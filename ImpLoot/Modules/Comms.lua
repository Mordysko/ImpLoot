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

function ImpLoot.Comms:SendResolved(itemID, winner, bossName)

    self:Broadcast(joinParts("RESOLVED", itemID, winner, bossName or ""))

end

-------------------------------------------------
-- Incoming Dispatch
-------------------------------------------------

function ImpLoot.Comms:OnMessageReceived(message, sender)

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

        local _, itemID, winner, bossName = self:SplitParts(message)

        if ImpLoot.LootMaster and ImpLoot.LootMaster.LogResolution then

            ImpLoot.LootMaster:LogResolution(
                tonumber(itemID), winner, (bossName ~= "" and bossName or nil)
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
    local character = ImpLoot.Character:GetCurrent()

    if not character then
        return
    end

    for _, wishlist in ipairs(character.Wishlists or {}) do

        for _, entry in ipairs(wishlist.Items or {}) do

            if entry.ItemID == itemID then

                ImpLoot.Events:Fire("ShowReservePopup", itemID, "Wishlist", wishlist.Name)
                return

            end

        end

    end

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
