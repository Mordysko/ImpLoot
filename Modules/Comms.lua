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

        self:OnMessageReceived(message, sender, channel)

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

-------------------------------------------------
-- Vote Call: Sent To Each Council Member
--
-- Only the loot master has the Loot Council Members
-- list, so a raid-wide broadcast left every other
-- member's ImpLoot checking its own (empty) list and
-- ignoring the vote. Instead the call is whispered to
-- each member who's in the raid -- receiving it IS the
-- invitation (see HandleVoteCall). The loot master, if
-- on the council, gets theirs directly.
-------------------------------------------------

local function ShortLower(name)
    return name and (name:match("^([^%-]+)") or name):lower() or ""
end

function ImpLoot.Comms:SendVoteCall(itemID, voteID, candidates)

    local message = joinParts(
        "VOTE_CALL",
        itemID,
        voteID,
        UnitName("player"),
        serializeCandidates(candidates)
    )

    -- Who's in the group right now (name as the game has it)
    local present = {}
    local numRaid = GetNumRaidMembers and GetNumRaidMembers() or 0

    if numRaid > 0 then

        for i = 1, numRaid do
            local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
            if name and online then
                present[ShortLower(name)] = name
            end
        end

    else

        for i = 1, (GetNumPartyMembers and GetNumPartyMembers() or 0) do
            local name = UnitName("party" .. i)
            if name then
                present[ShortLower(name)] = name
            end
        end

    end

    local me = ShortLower(UnitName("player"))
    local sent = 0

    for _, member in ipairs(ImpLoot.LootCouncil:GetMembers()) do

        local key = ShortLower(member)

        if key == me then

            self:OnMessageReceived(message, UnitName("player"), "WHISPER")
            sent = sent + 1

        elseif present[key] then

            self:Whisper(message, present[key])
            sent = sent + 1

        end

    end

    return sent

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

-- The richer history fields ride on the end of the message,
-- so an older ImpLoot (which reads only the first six parts)
-- still understands it. "|" can't appear inside a part, so
-- names and notes have it stripped.
local function clean(value)
    return (tostring(value or ""):gsub("|", "/"))
end

function ImpLoot.Comms:SendResolved(itemID, winner, bossName, mode, resultLabel, details)

    details = details or {}

    local function build(note)
        return joinParts(
            "RESOLVED", itemID, winner, clean(bossName), mode or "", resultLabel or "",
            clean(details.ItemName), details.Quality or "", details.WinnerClass or "",
            clean(details.Raid), details.Size or "", details.Heroic and "1" or "",
            note, details.RecorderId or ""
        )
    end

    local note = clean(details.Note):sub(1, 60)
    local message = build(note)

    -- Addon messages cap out around 250 characters: trim the
    -- note (the least important part) if it would overflow.
    local overflow = #message - 240

    if overflow > 0 then
        message = build(note:sub(1, math.max(0, #note - overflow)))
    end

    self:Broadcast(message)

end

-------------------------------------------------
-- Incoming Dispatch
-------------------------------------------------

function ImpLoot.Comms:OnMessageReceived(message, sender, channel)

    local msgType = message:match("^([^|]+)")

    -- Loot history sync has its own handler
    if msgType and msgType:sub(1, 3) == "HS_" then

        if ImpLoot.HistorySync then
            ImpLoot.HistorySync:OnMessage(message, sender)
        end

        return

    end

    if msgType == "ITEM" then

        local _, itemID, modeCode, namesCSV = self:SplitParts(message)

        self:HandleItemAnnounced(tonumber(itemID), modeCode, namesCSV)

    elseif msgType == "VOTE_CALL" then

        local _, itemID, voteID, callerName, candidatesText = self:SplitParts(message)

        self:HandleVoteCall(tonumber(itemID), voteID, callerName, deserializeCandidates(candidatesText), channel)

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

        local _, itemID, winner, bossName, mode, resultLabel,
            itemName, quality, winnerClass, raid, size, heroic, note, recorderId = self:SplitParts(message)

        local function opt(value)
            return (value and value ~= "") and value or nil
        end

        if ImpLoot.LootMaster and ImpLoot.LootMaster.LogResolution then

            local details = {
                ItemName = opt(itemName),
                Quality = tonumber(quality),
                WinnerClass = opt(winnerClass),
                Raid = opt(raid),
                Size = tonumber(size),
                Heroic = heroic == "1",
                Note = opt(note),
                Recorder = sender,
                RecorderId = tonumber(recorderId),
                Remote = true,
            }

            -- An older sender gives no raid: use our own
            if not details.Raid then
                details.Heroic = nil
            end

            ImpLoot.LootMaster:LogResolution(
                tonumber(itemID), winner, opt(bossName),
                opt(mode), opt(resultLabel), details
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

function ImpLoot.Comms:HandleVoteCall(itemID, voteID, callerName, candidates, channel)

    -- Sent to us directly by the loot master: we're on their
    -- council. An older loot master's ImpLoot broadcasts to
    -- the whole raid instead -- then all we can go on is our
    -- own members list.
    if channel ~= "WHISPER" and not ImpLoot.LootCouncil:IsMember(UnitName("player")) then
        return
    end

    ImpLoot.Events:Fire("ShowVotePopup", itemID, voteID, callerName, candidates)

end
