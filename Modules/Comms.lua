-------------------------------------------------
-- ImpLoot Comms
--
-- Raid-wide addon messages so other ImpLoot users
-- react locally, without the loot master needing to
-- know or target them individually.
--
-- Only the loot master typically has the imported SR
-- list, so a bystander's client can't independently
-- know "is this item reserved for me" -- the broadcast
-- carries the relevant reserver NAMES themselves (the
-- same names already shown in "Reserved by: ..."), and
-- each client just checks whether its own name is in
-- that list. Wishlist relevance, by contrast, IS local
-- data every client already has, so that check needs
-- nothing from the broadcast at all.
--
-- Message format is a simple "TYPE|arg|arg|..." string.
-- Item links are never put in the payload (they contain
-- "|" themselves, which would break the parse) -- only
-- the item ID goes over the wire, and each client
-- resolves the display link locally.
-------------------------------------------------

ImpLoot.Comms = {}

local ADDON_PREFIX = "ImpLoot"

-- Short names of everyone we've received an ImpLoot addon
-- message from this session (see the chat fallback below).
ImpLoot.Comms.AddonSenders = {}

-- Item IDs spotted in the loot master's chat, waiting out
-- a short settle period before being acted on.
ImpLoot.Comms.PendingChatItems = {}

-- itemID -> GetTime() of the last chat-triggered popup.
ImpLoot.Comms.ChatItemCooldown = {}

local CHAT_EVENTS = {
    "CHAT_MSG_RAID",
    "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_RAID_WARNING",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.Comms:Initialize()

    local frame = CreateFrame("Frame")

    frame:RegisterEvent("CHAT_MSG_ADDON")

    frame:SetScript("OnEvent", function(_, event, prefix, message, channel, sender)

        if prefix ~= ADDON_PREFIX then
            return
        end

        self:OnMessageReceived(message, sender)

    end)

    self.EventFrame = frame

    -------------------------------------------------
    -- Chat Fallback Watcher
    -------------------------------------------------

    local chatFrame = CreateFrame("Frame")

    for _, chatEvent in ipairs(CHAT_EVENTS) do
        chatFrame:RegisterEvent(chatEvent)
    end

    chatFrame:SetScript("OnEvent", function(_, event, message, sender)
        self:OnChatMessage(message, sender)
    end)

    local sinceLastTick = 0

    chatFrame:SetScript("OnUpdate", function(_, delta)

        sinceLastTick = sinceLastTick + (delta or 0)

        if sinceLastTick >= 0.25 then

            sinceLastTick = 0

            if #self.PendingChatItems > 0 then
                self:ProcessPendingChatItems(GetTime())
            end

        end

    end)

    self.ChatFrame = chatFrame

end

-------------------------------------------------
-- Send Helpers
-------------------------------------------------

local function joinParts(...)
    return table.concat({...}, "|")
end

function ImpLoot.Comms:Broadcast(message)

    local channel = "PARTY"

    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        channel = "RAID"
    end

    SendAddonMessage(ADDON_PREFIX, message, channel)

end

function ImpLoot.Comms:Whisper(message, targetName)
    SendAddonMessage(ADDON_PREFIX, message, "WHISPER", targetName)
end

-------------------------------------------------
-- Outgoing: Item Announced
--
-- reserverNames is a plain array of player names (SR
-- mode only -- pass an empty table for Open Roll).
-------------------------------------------------

function ImpLoot.Comms:SendItemAnnounced(itemID, mode, reserverNames)

    local modeCode = "OPEN"

    if mode == "SoftReserve" then
        modeCode = "SR"
    end

    local namesCSV = table.concat(reserverNames or {}, ",")

    self:Broadcast(joinParts("ITEM", itemID, modeCode, namesCSV))

end

-------------------------------------------------
-- Outgoing: Vote Call
--
-- candidates is the same {Type=,Value=} array used by
-- LootCouncil, serialized as "Type:Value;Type:Value".
-------------------------------------------------

local function serializeCandidates(candidates)

    local parts = {}

    for _, c in ipairs(candidates) do
        table.insert(parts, c.Type .. ":" .. c.Value)
    end

    return table.concat(parts, ";")

end

local function deserializeCandidates(text)

    local candidates = {}

    if not text or text == "" then
        return candidates
    end

    for chunk in text:gmatch("[^;]+") do

        local ctype, cvalue = chunk:match("^([^:]+):(.+)$")

        if ctype and cvalue then
            table.insert(candidates, { Type = ctype, Value = cvalue })
        end

    end

    return candidates

end

function ImpLoot.Comms:SendVoteCall(itemID, voteID, candidates)

    self:Broadcast(joinParts(
        "VOTE_CALL",
        itemID,
        voteID,
        UnitName("player"),
        serializeCandidates(candidates)
    ))

end

-------------------------------------------------
-- Outgoing: Vote Cast
-------------------------------------------------

function ImpLoot.Comms:SendVoteCast(voteID, targetPlayer, candidateType, candidateValue)

    self:Whisper(
        joinParts("VOTE_CAST", voteID, UnitName("player"), candidateType, candidateValue),
        targetPlayer
    )

end

-------------------------------------------------
-- Outgoing: Resolved
--
-- Lets every client (not just the loot master) build
-- its own summary log -- the raid leader, if different
-- from the loot master, still gets one this way.
-------------------------------------------------

function ImpLoot.Comms:SendResolved(itemID, winner, bossName, mode, resultLabel)

    self:Broadcast(joinParts(
        "RESOLVED", itemID, winner, bossName or "", mode or "", resultLabel or ""
    ))

end

-------------------------------------------------
-- Incoming Dispatch
-------------------------------------------------

function ImpLoot.Comms:OnMessageReceived(message, sender)

    -- Anyone sending us ImpLoot messages has the addon -- if
    -- that's the loot master, their own addon already covers
    -- popups, so the chat fallback stands down for them.
    local shortSender = sender and sender:match("^([^%-]+)")

    if shortSender then
        self.AddonSenders[shortSender] = true
    end

    local msgType = message:match("^([^|]+)")

    if msgType == "ITEM" then

        local _, itemID, modeCode, namesCSV = self:SplitParts(message)

        self:HandleItemAnnounced(tonumber(itemID), modeCode, namesCSV)

    elseif msgType == "VOTE_CALL" then

        local _, itemID, voteID, callerName, candidatesText = self:SplitParts(message)

        self:HandleVoteCall(tonumber(itemID), voteID, callerName, deserializeCandidates(candidatesText))

    elseif msgType == "VOTE_CAST" then

        local _, voteID, voterName, candidateType, candidateValue = self:SplitParts(message)

        if ImpLoot.LootMaster and ImpLoot.LootMaster.RecordVoteCast then

            ImpLoot.LootMaster:RecordVoteCast(voteID, voterName, candidateType, candidateValue)

        end

    elseif msgType == "RESOLVED" then

        -------------------------------------------------
        -- Skip Our Own Broadcast Coming Back
        --
        -- SendAddonMessage to a group channel (PARTY/
        -- RAID) echoes back to the sender's own client,
        -- same as any other group chat message would --
        -- the loot master's own Assign() already calls
        -- LogResolution directly the moment it happens,
        -- so logging it again here when that same
        -- message arrives back as an incoming one would
        -- double every entry in their own log. This only
        -- needs to run for entries arriving from someone
        -- ELSE's client.
        -------------------------------------------------

        if ImpLoot.LootMaster:NamesMatch(sender, UnitName("player")) then
            return
        end

        local _, itemID, winner, bossName, mode, resultLabel = self:SplitParts(message)

        if ImpLoot.LootMaster and ImpLoot.LootMaster.LogResolution then

            ImpLoot.LootMaster:LogResolution(
                tonumber(itemID), winner, (bossName ~= "" and bossName or nil),
                (mode ~= "" and mode or nil), (resultLabel ~= "" and resultLabel or nil)
            )

        end

    end

end

function ImpLoot.Comms:SplitParts(message)

    local parts = {}

    for part in (message .. "|"):gmatch("(.-)|") do
        table.insert(parts, part)
    end

    local unpackFn = table.unpack or unpack

    return unpackFn(parts)

end

-------------------------------------------------
-- Handle Item Announced (Relevance Check)
--
-- SR items: relevant if MY name is in the broadcast
-- reserver list. Open Roll items: relevant if the item
-- is on one of my OWN character's wishlists -- purely
-- local data, nothing from the broadcast needed.
-------------------------------------------------

function ImpLoot.Comms:HandleItemAnnounced(itemID, modeCode, namesCSV)

    local myName = UnitName("player")

    if modeCode == "SR" then

        for name in (namesCSV .. ","):gmatch("(.-),") do

            if name == myName then

                ImpLoot.Events:Fire("ShowReservePopup", itemID, "SoftReserve")
                return

            end

        end

        return

    end

    -- Open Roll: check the current character's wishlists
    local wishlistName = self:FindWishlistName(itemID)

    if wishlistName then
        ImpLoot.Events:Fire("ShowReservePopup", itemID, "Wishlist", wishlistName)
    end

end

-------------------------------------------------
-- Find Wishlist Name
--
-- The name of the first of the current character's
-- wishlists containing this item, or nil.
-------------------------------------------------

function ImpLoot.Comms:FindWishlistName(itemID)

    local character = ImpLoot.Character:GetCurrent()

    if not character then
        return nil
    end

    for _, wishlist in ipairs(character.Wishlists or {}) do

        for _, entry in ipairs(wishlist.Items or {}) do

            if entry.ItemID == itemID then
                return wishlist.Name
            end

        end

    end

    return nil

end

-------------------------------------------------
-- Handle Vote Call (Council Membership Check)
-------------------------------------------------

function ImpLoot.Comms:HandleVoteCall(itemID, voteID, callerName, candidates)

    if not ImpLoot.LootCouncil:IsMember(UnitName("player")) then
        return
    end

    ImpLoot.Events:Fire("ShowVotePopup", itemID, voteID, callerName, candidates)

end

-------------------------------------------------
-- Chat Fallback: The Loot Master's Raid Chat
--
-- The popup normally relies on the loot master's ImpLoot
-- sending a hidden addon message. If the loot master
-- doesn't have the addon, nothing arrives -- so this
-- also watches raid/party chat for an item link posted
-- by the LOOT MASTER and runs the same "is this one of
-- mine" check locally.
--
-- Deliberately narrow, so ordinary gear talk never
-- triggers it:
--
--   * Only the player who is currently the master
--     looter (GetLootMethod) -- nobody else's chat is
--     looked at. No master looter, nothing happens.
--   * Never our own messages (if we ARE the loot master
--     we have the addon, and it already covers us).
--   * Never once that loot master is known to have the
--     addon (we've received ImpLoot messages from them) --
--     their addon message already did the job, so this
--     would only be a duplicate popup.
--   * Wording that says the item ISN'T up for a roll
--     ("congrats", "assigned to", "seconds left"...) is
--     skipped -- result and reminder lines carry the item
--     link too, but popping a Roll button for an item
--     that's already been won would be wrong.
--   * At most one popup per item per roll window.
--
-- What it can check from chat alone: the item against the
-- player's own wishlists, and against their own Soft
-- Reserve import (if they've imported the list). Chat
-- doesn't carry the loot master's reserver list the way
-- the addon message does.
-------------------------------------------------

-- Wait this long before acting, so an addon message sent
-- alongside the chat line (same loot master, addon
-- installed) has time to arrive and take over.
local CHAT_SETTLE_SECONDS = 1.0

-- Added to the roll duration to get how long one popup per
-- item is enough for.
local CHAT_COOLDOWN_PADDING = 30

-- Lowercase fragments marking a message as a result,
-- reminder or note rather than "this item is up". The
-- text is padded with spaces first, so " won " only
-- matches the whole word.
local NOT_UP_FOR_ROLL_PHRASES = {
    "congrat", "gratz", "grats",
    "wins", " won ", "winner",
    "assigned", "awarded", "goes to",
    "disenchant",
    "left to roll", "seconds left", "can be used by",
    "vote called",
}

-------------------------------------------------
-- Extract Item IDs
--
-- Every distinct item link in the message, in order.
-------------------------------------------------

function ImpLoot.Comms:ExtractItemIDs(message)

    local ids = {}
    local seen = {}

    for idText in message:gmatch("|Hitem:(%d+)") do

        local itemID = tonumber(idText)

        if itemID and not seen[itemID] then
            seen[itemID] = true
            table.insert(ids, itemID)
        end

    end

    return ids

end

-------------------------------------------------
-- Message Wording Checks
--
-- Item links are cut out first so an item whose own
-- NAME happens to contain one of these words can't
-- trip them.
-------------------------------------------------

local function plainText(message)
    return " " .. message:gsub("|H.-|h%[.-%]|h", " "):lower() .. " "
end

function ImpLoot.Comms:LooksLikeNotUpForRoll(message)

    local text = plainText(message)

    for _, phrase in ipairs(NOT_UP_FOR_ROLL_PHRASES) do

        if text:find(phrase, 1, true) then
            return true
        end

    end

    return false

end

-- "Reserved by ..." / "SR" -- an item restricted to its
-- reservers, so being on a wishlist doesn't mean the
-- player can actually roll on it.
function ImpLoot.Comms:LooksSoftReserved(message)

    local text = plainText(message)

    return text:find("reserv", 1, true) ~= nil
        or text:find("%f[%a]sr%f[%A]") ~= nil

end

-------------------------------------------------
-- On Chat Message
-------------------------------------------------

function ImpLoot.Comms:OnChatMessage(message, sender)

    if not message or not sender then
        return
    end

    local masterName = ImpLoot.LootMaster:GetMasterLooterName()

    if not masterName or not ImpLoot.LootMaster:NamesMatch(sender, masterName) then
        return
    end

    if ImpLoot.LootMaster:NamesMatch(sender, UnitName("player")) then
        return
    end

    local itemIDs = self:ExtractItemIDs(message)

    if #itemIDs == 0 or self:LooksLikeNotUpForRoll(message) then
        return
    end

    local shortSender = sender:match("^([^%-]+)") or sender
    local softReserved = self:LooksSoftReserved(message)
    local fireAt = GetTime() + CHAT_SETTLE_SECONDS

    for _, itemID in ipairs(itemIDs) do

        table.insert(self.PendingChatItems, {
            ItemID = itemID,
            Sender = shortSender,
            SoftReserved = softReserved,
            FireAt = fireAt,
        })

    end

end

-------------------------------------------------
-- Process Pending Chat Items
-------------------------------------------------

function ImpLoot.Comms:ProcessPendingChatItems(now)

    local i = 1

    while i <= #self.PendingChatItems do

        local pending = self.PendingChatItems[i]

        if now >= pending.FireAt then
            table.remove(self.PendingChatItems, i)
            self:HandleChatItem(pending, now)
        else
            i = i + 1
        end

    end

end

-------------------------------------------------
-- Handle Chat Item (Relevance Check)
-------------------------------------------------

function ImpLoot.Comms:HandleChatItem(pending, now)

    -- Their addon message arrived while we waited --
    -- it already handled this, don't pop it twice.
    if self.AddonSenders[pending.Sender] then
        return
    end

    local itemID = pending.ItemID

    local rollDuration = (ImpLoot.LootMaster.Settings and ImpLoot.LootMaster.Settings.RollDuration) or 30
    local lastShown = self.ChatItemCooldown[itemID]

    if lastShown and (now - lastShown) < (rollDuration + CHAT_COOLDOWN_PADDING) then
        return
    end

    local myName = UnitName("player")

    -- Own Soft Reserve import (if there is one)
    if ImpLoot.SoftReserve then

        for _, name in ipairs(ImpLoot.SoftReserve:GetDistinctReservers(itemID)) do

            if name == myName then

                self.ChatItemCooldown[itemID] = now
                ImpLoot.Events:Fire("ShowReservePopup", itemID, "SoftReserve")
                return

            end

        end

    end

    -- A reserved item is only open to its reservers, so a
    -- wishlist match isn't something they can act on.
    if pending.SoftReserved then
        return
    end

    local wishlistName = self:FindWishlistName(itemID)

    if wishlistName then

        self.ChatItemCooldown[itemID] = now
        ImpLoot.Events:Fire("ShowReservePopup", itemID, "Wishlist", wishlistName)

    end

end
