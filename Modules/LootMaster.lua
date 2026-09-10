-------------------------------------------------
-- ImpLoot Loot Master
--
-- The corpse-side (and post-corpse "tracking") loot
-- queue. Populates itself from the real loot window,
-- decides each item's mode (Open Roll / Soft Reserve /
-- Loot Council) from the existing data modules, and
-- handles assignment -- via the real Master Loot API
-- while the corpse it came from is still open, falling
-- back to "just record the winner, trade manually"
-- once it isn't.
-------------------------------------------------

ImpLoot.LootMaster = {}

-------------------------------------------------
-- Roll Settings
--
-- Main Spec is a standard /roll (1-100); Off Spec is
-- the Off-Spec Roll button's 1-99 -- classified by the
-- roll's own upper bound, not a configurable threshold.
-------------------------------------------------

-------------------------------------------------
-- Settings Defaults
--
-- Persisted like everything else -- see Initialize.
-------------------------------------------------

ImpLoot.LootMaster.Defaults = {

    RollDuration = 30,
    PeriodicAnnounceInterval = 10,
    FinalCountdownThreshold = 5,

    AutoFinalizeOnTimeout = true,
    AutoAssignToRollWinner = true,
    AutoClearOnNewBoss = false,

}

-------------------------------------------------
-- Roll Message Pattern
--
-- Matches WoW's own system message: "<Player> rolls
-- <roll> (<min>-<max>)".
-------------------------------------------------

local ROLL_PATTERN = "(.+) rolls (%d+) %((%d+)%-(%d+)%)"

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.LootMaster:Initialize()

    ImpLootDB.LootMasterSettings = ImpLootDB.LootMasterSettings or {}

    for key, value in pairs(self.Defaults) do

        if ImpLootDB.LootMasterSettings[key] == nil then
            ImpLootDB.LootMasterSettings[key] = value
        end

    end

    self.Settings = ImpLootDB.LootMasterSettings

    ImpLootDB.LootMasterLog = ImpLootDB.LootMasterLog or {}
    self.Log = ImpLootDB.LootMasterLog

    self.Queue = {}
    self.NextQueueID = 1
    self.CurrentCorpseGUID = nil
    self.ActiveRollQueueID = nil

    local frame = CreateFrame("Frame")

    frame:RegisterEvent("LOOT_OPENED")
    frame:RegisterEvent("LOOT_CLOSED")
    frame:RegisterEvent("CHAT_MSG_SYSTEM")

    frame:SetScript("OnEvent", function(_, event, msg)

        if event == "LOOT_OPENED" then
            self:OnLootOpened()
        elseif event == "LOOT_CLOSED" then
            self:OnLootClosed()
        elseif event == "CHAT_MSG_SYSTEM" then
            self:OnChatMsgSystem(msg)
        end

    end)

    self.EventFrame = frame

    -------------------------------------------------
    -- Timer Ticking
    --
    -- Runs every 0.5s rather than every frame -- a
    -- roll countdown doesn't need frame-rate precision.
    -- OnTimerTick reads GetTime() itself rather than
    -- accumulating elapsed time, so it's also directly
    -- callable (e.g. from tests) without a real OnUpdate
    -- loop.
    -------------------------------------------------

    local tickFrame = CreateFrame("Frame")
    local sinceLastTick = 0

    tickFrame:SetScript("OnUpdate", function(_, delta)

        sinceLastTick = sinceLastTick + (delta or 0)

        if sinceLastTick >= 0.5 then
            sinceLastTick = 0
            self:OnTimerTick()
        end

    end)

    self.TickFrame = tickFrame

end

-------------------------------------------------
-- Reset Settings To Defaults
--
-- Mutates the existing Settings table in place
-- (rather than replacing it) so the options panel's
-- already-built widgets -- whose getValue/setValue
-- closures reference this exact table -- immediately
-- reflect the reset values without needing a UI reload.
-------------------------------------------------

function ImpLoot.LootMaster:ResetSettingsToDefaults()

    for key, value in pairs(self.Defaults) do
        self.Settings[key] = value
    end

end

-------------------------------------------------
-- Extract Item ID
-------------------------------------------------

function ImpLoot.LootMaster:ExtractItemID(itemLink)

    if not itemLink then
        return nil
    end

    local itemID = itemLink:match("item:(%d+)")

    return itemID and tonumber(itemID) or nil

end

-------------------------------------------------
-- Is Master Looter
-------------------------------------------------

function ImpLoot.LootMaster:IsMasterLooter()

    if not GetLootMethod then
        return false
    end

    local method, partyIndex, raidIndex = GetLootMethod()

    if method ~= "master" then
        return false
    end

    local playerName = UnitName("player")

    if raidIndex and raidIndex > 0 then

        local raidName = GetRaidRosterInfo and GetRaidRosterInfo(raidIndex)

        return raidName == playerName

    end

    if partyIndex and partyIndex > 0 then

        return UnitName("party" .. partyIndex) == playerName

    end

    -- partyIndex/raidIndex of 0 means the player themselves
    return true

end

-------------------------------------------------
-- Determine Mode
--
-- Loot Council takes priority over Soft Reserve if
-- an item somehow ends up tagged as both.
-------------------------------------------------

function ImpLoot.LootMaster:DetermineMode(itemID)

    local listName = ImpLoot.LootCouncil:GetActiveListName()

    if listName and ImpLoot.LootCouncil:IsCouncilItem(listName, itemID) then
        return "LootCouncil"
    end

    if #ImpLoot.SoftReserve:GetReserves(itemID) > 0 then
        return "SoftReserve"
    end

    return "OpenRoll"

end

-------------------------------------------------
-- On Loot Opened
--
-- Scans every item slot in the loot window that just
-- opened. New items become new queue entries; items
-- already queued from a PREVIOUS opening of this same
-- corpse (e.g. it was closed and reopened) just get
-- their slot index refreshed rather than duplicated.
-------------------------------------------------

function ImpLoot.LootMaster:OnLootOpened()

    local corpseGUID = nil

    if UnitExists and UnitExists("target") then
        corpseGUID = UnitGUID("target")
    end

    if not corpseGUID then
        corpseGUID = "session-" .. tostring(self.NextQueueID)
    end

    -------------------------------------------------
    -- Auto-Clear On New Boss
    --
    -- Compares against the PREVIOUS corpse's GUID
    -- before it gets overwritten below. Re-opening the
    -- same corpse (closed and reopened to check for
    -- missed items) keeps the same GUID, so that never
    -- triggers a clear -- only a genuinely different
    -- corpse does.
    -------------------------------------------------

    if self.Settings.AutoClearOnNewBoss
    and self.CurrentCorpseGUID
    and self.CurrentCorpseGUID ~= corpseGUID
    and #self.Queue > 0 then

        self:ClearQueue()
        ImpLoot:Print("New boss detected -- loot queue cleared.")

    end

    self.CurrentCorpseGUID = corpseGUID

    local bossName = nil

    if UnitExists and UnitExists("target") then
        bossName = UnitName("target")
    end

    local numItems = GetNumLootItems and GetNumLootItems() or 0

    for slot = 1, numItems do

        if LootSlotIsItem(slot) then

            local link = GetLootSlotLink(slot)
            local itemID = self:ExtractItemID(link)

            if itemID then
                self:AddToQueue(itemID, link, bossName, corpseGUID, slot)
            end

        end

    end

end

-------------------------------------------------
-- On Loot Closed
--
-- Every entry tied to the corpse that just closed
-- loses its slot index -- it can no longer be
-- assigned via the real API, only recorded for a
-- manual trade, unless this same corpse gets reopened
-- (handled by the upsert in AddToQueue/OnLootOpened).
-------------------------------------------------

function ImpLoot.LootMaster:OnLootClosed()

    for _, entry in ipairs(self.Queue) do

        if entry.CorpseGUID == self.CurrentCorpseGUID then

            entry.Assignable = false
            entry.LootSlot = nil

        end

    end

    ImpLoot.Events:Fire("LootQueueChanged")

end

-------------------------------------------------
-- Add To Queue (Upsert)
-------------------------------------------------

function ImpLoot.LootMaster:AddToQueue(itemID, itemLink, bossName, corpseGUID, lootSlot)

    for _, entry in ipairs(self.Queue) do

        if entry.ItemID == itemID
        and entry.CorpseGUID == corpseGUID
        and entry.State ~= "Resolved" then

            entry.LootSlot = lootSlot
            entry.Assignable = (lootSlot ~= nil)

            ImpLoot.Events:Fire("LootQueueChanged")

            return entry

        end

    end

    local entry = {

        QueueID = self.NextQueueID,
        ItemID = itemID,
        ItemLink = itemLink,
        BossName = bossName,
        CorpseGUID = corpseGUID,
        LootSlot = lootSlot,
        Assignable = (lootSlot ~= nil),

        Mode = self:DetermineMode(itemID),
        State = "Pending",

        Rolls = {},
        Winner = nil,
        TradeOnly = false,

    }

    self.NextQueueID = self.NextQueueID + 1

    table.insert(self.Queue, entry)

    ImpLoot.Events:Fire("LootQueueChanged")

    return entry

end

-------------------------------------------------
-- Add Manual Item
--
-- For anything that doesn't come through the loot
-- window on its own (currency, recipes, an item that
-- somehow didn't get picked up automatically): /il
-- <item link or name>. Accepts a pasted item link
-- (shift-click, always works) or a plain name (only
-- resolves if the client already knows about it --
-- e.g. it was just sitting in the loot window).
--
-- Goes into the exact same queue as corpse loot, with
-- no loot slot of its own -- so it behaves like any
-- other item whose corpse has already closed: trade-
-- only, never eligible for the real Master Loot API.
-------------------------------------------------

function ImpLoot.LootMaster:AddManualItem(text)

    if not text or text == "" then
        return false, "Usage: /il <item link or name>"
    end

    local itemID = self:ExtractItemID(text)
    local itemLink = itemID and text or nil

    if not itemID then

        local name, link = GetItemInfo(text)

        if link then
            itemLink = link
            itemID = self:ExtractItemID(link)
        end

    end

    if not itemID then

        return false,
            "Couldn't find \"" .. text .. "\" -- try pasting the item link " ..
            "(shift-click it) instead of typing the name."

    end

    local bossName = nil

    if UnitExists and UnitExists("target") then
        bossName = UnitName("target")
    end

    self:AddToQueue(itemID, itemLink, bossName, nil, nil)

    return true, "Added " .. itemLink .. " to the loot queue."

end

-------------------------------------------------
-- Get Queue / Get Entry / Remove
-------------------------------------------------

function ImpLoot.LootMaster:GetQueue()
    return self.Queue
end

function ImpLoot.LootMaster:GetEntry(queueID)

    for _, entry in ipairs(self.Queue) do

        if entry.QueueID == queueID then
            return entry
        end

    end

    return nil

end

function ImpLoot.LootMaster:RemoveFromQueue(queueID)

    for i, entry in ipairs(self.Queue) do

        if entry.QueueID == queueID then

            table.remove(self.Queue, i)

            ImpLoot.Events:Fire("LootQueueChanged")

            return true

        end

    end

    return false

end

function ImpLoot.LootMaster:ClearQueue()
    self.Queue = {}
    self.ActiveRollQueueID = nil
    ImpLoot.Events:Fire("LootQueueChanged")
end

-------------------------------------------------
-- Format Reserver List
--
-- "Jayallday (x3), Testing" -- based on who's still
-- actually eligible to roll (remaining slots), not
-- the raw import list, so an already-excluded winner
-- never shows as if they can still roll.
-------------------------------------------------

function ImpLoot.LootMaster:FormatReserverList(itemID)

    local slots = ImpLoot.SoftReserve:GetRemainingSlots(itemID)

    if #slots == 0 then
        return "No SoftRes"
    end

    local counts = {}
    local order = {}

    for _, slot in ipairs(slots) do

        if not counts[slot.Player] then
            counts[slot.Player] = 0
            table.insert(order, slot.Player)
        end

        counts[slot.Player] = counts[slot.Player] + 1

    end

    local parts = {}

    for _, player in ipairs(order) do

        if counts[player] > 1 then
            table.insert(parts, player .. " (x" .. counts[player] .. ")")
        else
            table.insert(parts, player)
        end

    end

    return self:JoinWithAmpersand(parts)

end

-------------------------------------------------
-- Join With Ampersand
--
-- "Rad" / "Rad & Smeb" / "Rad, Smeb, & Mordy" --
-- comma-separated with an Oxford-comma "&" before
-- the last name.
-------------------------------------------------

function ImpLoot.LootMaster:JoinWithAmpersand(parts)

    if #parts == 0 then
        return ""
    elseif #parts == 1 then
        return parts[1]
    elseif #parts == 2 then
        return parts[1] .. " & " .. parts[2]
    end

    local allButLast = {}

    for i = 1, #parts - 1 do
        table.insert(allButLast, parts[i])
    end

    return table.concat(allButLast, ", ") .. " & " .. parts[#parts]

end

-------------------------------------------------
-- Get Reserver Name List
--
-- Unique remaining-eligible names, plain array (for
-- the addon broadcast) -- as opposed to
-- FormatReserverList's "Name (xN)" display text.
-------------------------------------------------

function ImpLoot.LootMaster:GetReserverNameList(itemID)

    local slots = ImpLoot.SoftReserve:GetRemainingSlots(itemID)
    local seen = {}
    local names = {}

    for _, slot in ipairs(slots) do

        if not seen[slot.Player] then
            seen[slot.Player] = true
            table.insert(names, slot.Player)
        end

    end

    return names

end

-------------------------------------------------
-- Announce Item
--
-- Sends the "here's who's reserved this" message,
-- then opens it for rolling and sends the "roll now"
-- message -- each independently toggleable/customizable
-- via Modules/Announcements.lua. Loot Council items
-- aren't announced this way; they use LC Vote instead
-- (not built yet).
-------------------------------------------------

-------------------------------------------------
-- Token Class Groupings
--
-- Standard WotLK tier token naming -- these items
-- (Type == "TIER_TOKEN") have no Classes field of
-- their own since any of the grouping's classes can
-- turn them in, so eligibility comes from the name
-- prefix instead. Matched as "starts with X's " (with
-- the apostrophe-s) specifically, not a loose substring
-- search -- some unrelated drops (e.g. Obsidian
-- Sanctum's "Gloves of the Lost Conqueror") contain the
-- same word without being a class-grouped token at all.
-------------------------------------------------

local TOKEN_CLASS_GROUPS = {
    { Prefix = "Conqueror's ", Classes = { "Paladin", "Priest", "Warlock" } },
    { Prefix = "Protector's ", Classes = { "Warrior", "Hunter", "Shaman" } },
    { Prefix = "Vanquisher's ", Classes = { "Rogue", "Death Knight", "Mage", "Druid" } },
}

local function GetTokenClasses(itemName)

    if not itemName then
        return nil
    end

    for _, group in ipairs(TOKEN_CLASS_GROUPS) do

        if itemName:sub(1, #group.Prefix) == group.Prefix then
            return group.Classes
        end

    end

    return nil

end

function ImpLoot.LootMaster:AnnounceItem(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    local listName, councilItem

    if entry.Mode == "LootCouncil" then

        listName = ImpLoot.LootCouncil:GetActiveListName()
        councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if not (councilItem and councilItem.Mode == "Preselected") then
            return false, "Loot Council items use LC Vote, not Announce."
        end

    end

    local reserverNames = {}

    if entry.Mode == "SoftReserve" then
        reserverNames = self:GetReserverNameList(entry.ItemID)
    end

    if ImpLoot.Comms then

        ImpLoot.Comms:SendItemAnnounced(entry.ItemID, entry.Mode, reserverNames)

    end

    if entry.Mode == "SoftReserve" then

        ImpLoot.Announcements:Announce("SoftReserveAnnounced", {
            item = entry.ItemLink,
            reservers = self:FormatReserverList(entry.ItemID),
        })

    elseif councilItem and councilItem.Mode == "Preselected" then

        local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)
        local names = {}

        for _, candidate in ipairs(remaining) do

            if candidate.Type == "Class" then
                table.insert(names, "Any " .. candidate.Value)
            else
                table.insert(names, candidate.Value)
            end

        end

        ImpLoot.Announcements:Announce("PreselectedAnnounced", {
            item = entry.ItemLink,
            players = self:JoinWithAmpersand(names),
            seconds = self.Settings.RollDuration,
        })

    else

        ImpLoot.Announcements:Announce("OpenRollAnnounced", {
            item = entry.ItemLink,
            seconds = self.Settings.RollDuration,
        })

    end

    local item = ImpLoot.Database:FindItemByID(entry.ItemID)

    local classes = item and item.Classes

    if not classes and item then
        classes = GetTokenClasses(item.Name)
    end

    if classes and #classes > 0 then

        ImpLoot.Announcements:Announce("EligibleClasses", {
            item = entry.ItemLink,
            classes = table.concat(classes, ", "),
        })

    end

    self:StartRoll(queueID)

    return true

end

-------------------------------------------------
-- Call Vote
--
-- Broadcasts a ballot to every council member (they
-- each decide locally whether to show it, based on
-- their own membership). The item stays "Voting"
-- until the loot master assigns it manually from the
-- live tally -- there's no auto-finalize for votes.
-------------------------------------------------

function ImpLoot.LootMaster:CallVote(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    if entry.Mode ~= "LootCouncil" then
        return false, "Only Loot Council items can be voted on."
    end

    local listName = ImpLoot.LootCouncil:GetActiveListName()

    if not listName then
        return false, "No active Loot Council list."
    end

    local candidates = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)

    self.NextVoteID = (self.NextVoteID or 0) + 1
    local voteID = "V" .. self.NextVoteID

    entry.State = "Voting"
    entry.ActiveVoteID = voteID
    entry.Votes = {}

    ImpLoot.Announcements:Announce("LCVoteCalled", {
        item = entry.ItemLink,
    })

    if ImpLoot.Comms then
        ImpLoot.Comms:SendVoteCall(entry.ItemID, voteID, candidates)
    end

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

-------------------------------------------------
-- Record Vote Cast
--
-- One vote per voter per vote ID -- a repeat cast from
-- the same person just overwrites their earlier one
-- rather than counting twice.
-------------------------------------------------

function ImpLoot.LootMaster:RecordVoteCast(voteID, voterName, candidateType, candidateValue)

    for _, entry in ipairs(self.Queue) do

        if entry.ActiveVoteID == voteID then

            entry.Votes[voterName] = {
                Type = candidateType,
                Value = candidateValue,
            }

            ImpLoot.Events:Fire("LootQueueChanged")

            return true

        end

    end

    return false

end

-------------------------------------------------
-- Get Vote Tally
--
-- Returns an ordered list of {Value=, Count=}, most
-- votes first.
-------------------------------------------------

function ImpLoot.LootMaster:GetVoteTally(queueID)

    local entry = self:GetEntry(queueID)

    if not entry or not entry.Votes then
        return {}
    end

    local counts = {}
    local types = {}
    local order = {}

    for _, vote in pairs(entry.Votes) do

        if not counts[vote.Value] then
            counts[vote.Value] = 0
            types[vote.Value] = vote.Type
            table.insert(order, vote.Value)
        end

        counts[vote.Value] = counts[vote.Value] + 1

    end

    local tally = {}

    for _, value in ipairs(order) do
        table.insert(tally, { Value = value, Type = types[value], Count = counts[value] })
    end

    table.sort(tally, function(a, b) return a.Count > b.Count end)

    return tally

end

-------------------------------------------------
-- Start / Stop Roll
--
-- Only one item can be actively rolling at a time --
-- WoW's roll messages don't reference an item, so
-- every incoming roll is attributed to whichever
-- item this points at. Starting a roll wipes any
-- previous standings for it (a fresh roll window).
-------------------------------------------------

function ImpLoot.LootMaster:StartRoll(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    if entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()
        local councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if not (councilItem and councilItem.Mode == "Preselected") then
            return false, "Loot Council items are voted, not rolled."
        end

    end

    entry.State = "Rolling"
    entry.Rolls = {}

    if self.Settings.RollDuration and self.Settings.RollDuration > 0 then

        entry.RollEndTime = GetTime() + self.Settings.RollDuration

        entry.NextPeriodicAnnounceAt = self.Settings.RollDuration
            - self.Settings.PeriodicAnnounceInterval

        entry.CountdownAnnounced = {}

    else

        entry.RollEndTime = nil

    end

    self.ActiveRollQueueID = queueID

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

function ImpLoot.LootMaster:StopRoll(queueID)

    if self.ActiveRollQueueID == queueID then
        self.ActiveRollQueueID = nil
    end

end

-------------------------------------------------
-- Get Raid Roster Names
-------------------------------------------------

function ImpLoot.LootMaster:GetRaidRosterNames()

    local names = {}

    local numRaid = 0

    if GetNumRaidMembers then
        numRaid = GetNumRaidMembers()
    end

    if numRaid > 0 then

        for i = 1, numRaid do

            local name = GetRaidRosterInfo(i)

            if name then
                table.insert(names, name)
            end

        end

    else

        table.insert(names, (UnitName("player")))

    end

    return names

end

-------------------------------------------------
-- On Timer Tick
--
-- Handles the periodic "N seconds left" announcements,
-- the final countdown (5, 4, 3, 2, 1), and finalizing
-- the roll once time is up. Reads GetTime() itself
-- rather than an elapsed-time parameter, so it's
-- directly callable without a real game loop.
-------------------------------------------------

function ImpLoot.LootMaster:OnTimerTick()

    -- Fired unconditionally (even with no active roll) so
    -- the Loot Master window's per-row countdown numbers
    -- stay in sync -- including hiding a stale number once
    -- a roll ends, not just updating it while one's active.
    ImpLoot.Events:Fire("LootTimerTick")

    local queueID = self.ActiveRollQueueID

    if not queueID then
        return
    end

    local entry = self:GetEntry(queueID)

    if not entry or not entry.RollEndTime then
        return
    end

    local remaining = entry.RollEndTime - GetTime()

    if remaining <= 0 then
        self:FinalizeRoll(queueID)
        return
    end

    -- Lightweight signal, separate from LootQueueChanged --
    -- lets the window update just the visible countdown
    -- number in place, without rebuilding the whole row
    -- list every half second.
    ImpLoot.Events:Fire("LootTimerTick", queueID, remaining)

    local remainingRounded = math.ceil(remaining)

    -------------------------------------------------
    -- Final Countdown
    -------------------------------------------------

    if remainingRounded <= self.Settings.FinalCountdownThreshold
    and remainingRounded >= 1 then

        if not entry.CountdownAnnounced[remainingRounded] then

            entry.CountdownAnnounced[remainingRounded] = true

            ImpLoot.Announcements:Announce("RollCountdown", {
                item = entry.ItemLink,
                count = remainingRounded,
            })

        end

        return

    end

    -------------------------------------------------
    -- Periodic "N Seconds Left"
    -------------------------------------------------

    if self.Settings.PeriodicAnnounceInterval > 0
    and entry.NextPeriodicAnnounceAt
    and remainingRounded <= entry.NextPeriodicAnnounceAt then

        ImpLoot.Announcements:Announce("RollTimeRemaining", {
            item = entry.ItemLink,
            seconds = remainingRounded,
        })

        entry.NextPeriodicAnnounceAt =
            entry.NextPeriodicAnnounceAt - self.Settings.PeriodicAnnounceInterval

        if entry.NextPeriodicAnnounceAt <= self.Settings.FinalCountdownThreshold then
            entry.NextPeriodicAnnounceAt = nil
        end

    end

end

-------------------------------------------------
-- Finalize Roll
--
-- Always stops accepting new rolls once time is up.
-- Whether it goes on to auto-assign is a separate
-- setting -- if it's off, the item just sits ready
-- for the loot master to Assign manually.
-------------------------------------------------

function ImpLoot.LootMaster:FinalizeRoll(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return
    end

    self:StopRoll(queueID)

    entry.RollEndTime = nil
    entry.State = "RollComplete"

    ImpLoot.Events:Fire("LootQueueChanged")

    -------------------------------------------------
    -- Winner Announcement
    --
    -- Announced here, the moment the countdown actually
    -- ends -- not in Assign(), which may not get called
    -- until much later (manual assignment, or Auto
    -- Finalize/Auto Assign turned off). Loot Council
    -- items never reach this function at all (they
    -- resolve via LC Vote, not a roll timer), so their
    -- own announcement still happens in Assign().
    -------------------------------------------------

    local topRoll = self:GetTopRoll(queueID)

    if topRoll then

        ImpLoot.Announcements:Announce("WinnerAnnounced", {
            item = entry.ItemLink,
            winner = topRoll.Player,
            roll = tostring(topRoll.Roll),
            range = tostring(topRoll.Min) .. "-" .. tostring(topRoll.Max),
        })

    end

    if not self.Settings.AutoFinalizeOnTimeout then
        return
    end

    if not topRoll then

        local disenchanter = ImpLoot.LootCouncil:GetActiveDisenchanter(
            self:GetRaidRosterNames()
        )

        if disenchanter then

            ImpLoot.Announcements:Announce("NoRollsDisenchant", {
                item = entry.ItemLink,
            })

            self:Assign(queueID, disenchanter)

        end

        return

    end

    if self.Settings.AutoAssignToRollWinner then
        self:Assign(queueID, topRoll.Player)
    end

end

function ImpLoot.LootMaster:GetActiveRollQueueID()
    return self.ActiveRollQueueID
end

-------------------------------------------------
-- Get Roll Type
-------------------------------------------------

function ImpLoot.LootMaster:GetRollType(minRoll, maxRoll)

    -- Standard WotLK convention: /roll 1-100 is Main Spec,
    -- anything with a top end below 100 (the Off-Spec Roll
    -- button rolls 1-99) is Off Spec.
    if maxRoll and maxRoll < 100 then
        return "OS"
    end

    return "MS"

end

-------------------------------------------------
-- Get Max Rolls For Player
--
-- Open Roll: everyone gets exactly one roll. Soft
-- Reserve: as many rolls as they have remaining
-- reserved slots on this item (so a triple reserve
-- gets three). Loot Council items aren't rolled at
-- all.
-------------------------------------------------

function ImpLoot.LootMaster:GetMaxRollsForPlayer(entry, playerName)

    if entry.Mode == "OpenRoll" then
        return 1
    end

    if entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()
        local councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if not (councilItem and councilItem.Mode == "Preselected") then
            return 0
        end

        local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)

        for _, candidate in ipairs(remaining) do

            if candidate.Type == "Player" and self:NamesMatch(candidate.Value, playerName) then
                return 1
            end

        end

        return 0

    end

    if entry.Mode ~= "SoftReserve" then
        return 0
    end

    local slots = ImpLoot.SoftReserve:GetRemainingSlots(entry.ItemID)
    local count = 0

    for _, slot in ipairs(slots) do

        if slot.Player == playerName then
            count = count + 1
        end

    end

    return count

end

-------------------------------------------------
-- On Chat Msg System
--
-- Parses WoW's own roll system message and routes it
-- to whichever item is currently open for rolling.
-------------------------------------------------

function ImpLoot.LootMaster:OnChatMsgSystem(msg)

    if not self.ActiveRollQueueID then
        return
    end

    local player, roll, minRoll, maxRoll = msg:match(ROLL_PATTERN)

    if not player then
        return
    end

    self:ProcessRoll(
        self.ActiveRollQueueID,
        player,
        tonumber(roll),
        tonumber(minRoll),
        tonumber(maxRoll)
    )

end

-------------------------------------------------
-- Process Roll
--
-- Rejects the roll (rather than counting it) if the
-- item isn't actively rolling, the roll is a 0 (i.e.
-- someone typed "pass"), or the player has no
-- eligible rolls left for this item.
-------------------------------------------------

function ImpLoot.LootMaster:ProcessRoll(queueID, playerName, rollValue, minRoll, maxRoll)

    local entry = self:GetEntry(queueID)

    if not entry or entry.State ~= "Rolling" then
        return false, "No active roll for this item."
    end

    if rollValue == 0 then
        return false, "Rolls of 0 don't count."
    end

    local maxAllowed = self:GetMaxRollsForPlayer(entry, playerName)

    local existingCount = 0

    for _, roll in ipairs(entry.Rolls) do

        if roll.Player == playerName then
            existingCount = existingCount + 1
        end

    end

    if existingCount >= maxAllowed then

        return false,
            playerName .. " has no eligible rolls remaining for this item."

    end

    table.insert(entry.Rolls, {
        Player = playerName,
        Roll = rollValue,
        Type = self:GetRollType(minRoll, maxRoll),
        Min = minRoll,
        Max = maxRoll,
    })

    table.sort(entry.Rolls, function(a, b)
        return a.Roll > b.Roll
    end)

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

-------------------------------------------------
-- Standings
-------------------------------------------------

function ImpLoot.LootMaster:GetStandings(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return {}
    end

    return entry.Rolls

end

function ImpLoot.LootMaster:GetTopRoll(queueID)
    return self:GetStandings(queueID)[1]
end

-------------------------------------------------
-- Names Match
--
-- Strips a realm suffix ("Name-Realm") before
-- comparing, since candidate names and roll names
-- don't always carry one consistently.
-------------------------------------------------

function ImpLoot.LootMaster:NamesMatch(a, b)

    if not a or not b then
        return false
    end

    local shortA = a:match("^([^%-]+)") or a
    local shortB = b:match("^([^%-]+)") or b

    return shortA == shortB

end

-------------------------------------------------
-- Find Candidate Index
--
-- Master Loot's candidate list is shared across every
-- item in the current loot window (eligibility is
-- about loot range, not the specific item) -- so this
-- doesn't take a slot parameter, matching the real API.
-------------------------------------------------

function ImpLoot.LootMaster:FindCandidateIndex(winnerName)

    if not GetMasterLootCandidate then
        return nil
    end

    local numMembers = 0

    if GetNumRaidMembers then
        numMembers = GetNumRaidMembers()
    end

    for i = 1, numMembers do

        local candidateName = GetMasterLootCandidate(i)

        if candidateName and self:NamesMatch(candidateName, winnerName) then
            return i
        end

    end

    return nil

end

-------------------------------------------------
-- Assign
--
-- Calls the real Master Loot API when the item's
-- corpse is still open and the winner is a valid
-- candidate; otherwise just records the winner so the
-- item can be traded manually later. Either path is
-- "Assign" from the loot master's point of view.
-------------------------------------------------

function ImpLoot.LootMaster:RecordWinForExclusion(entry, winnerName)

    if entry.Mode == "SoftReserve" then

        ImpLoot.SoftReserve:RecordWin(entry.ItemID, winnerName)

    elseif entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()

        if not listName then
            return
        end

        local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)

        for _, candidate in ipairs(remaining) do

            if candidate.Type == "Player" and candidate.Value == winnerName then

                ImpLoot.LootCouncil:RecordWin(listName, entry.ItemID, "Player", winnerName, winnerName)

                return

            end

        end

        -- A Class-type slot needs the winner's class, which isn't
        -- derivable from just a name here -- the vote UI (not built
        -- yet) will need to supply that explicitly when it resolves
        -- a Class candidate.

    end

end

-------------------------------------------------
-- Log Resolution / Get Log / Clear Log
--
-- Every client (loot master or not) builds its own
-- copy of this log -- the loot master logs locally at
-- the moment of resolution and also broadcasts it, so
-- the raid leader (if a different person) gets one
-- too, and anyone else running the addon who's curious.
-------------------------------------------------

function ImpLoot.LootMaster:LogResolution(itemID, winnerName, bossName)

    table.insert(self.Log, {
        ItemID = itemID,
        Winner = winnerName,
        BossName = bossName,
        Timestamp = time and time() or 0,
    })

end

function ImpLoot.LootMaster:GetLog()
    return self.Log
end

function ImpLoot.LootMaster:ClearLog()
    self.Log = {}
    ImpLootDB.LootMasterLog = self.Log
end

function ImpLoot.LootMaster:Assign(queueID, winnerName)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    self:RecordWinForExclusion(entry, winnerName)

    local resultMessage

    if entry.Assignable
    and entry.LootSlot
    and self:IsMasterLooter() then

        local candidateIndex = self:FindCandidateIndex(winnerName)

        if candidateIndex then

            GiveMasterLoot(entry.LootSlot, candidateIndex)

            entry.Winner = winnerName
            entry.State = "Resolved"

            resultMessage = "Assigned via Master Loot."

        end

    end

    if not resultMessage then

        entry.Winner = winnerName
        entry.State = "Resolved"
        entry.TradeOnly = true

        resultMessage = "Recorded -- trade this item to " .. winnerName .. "."

    end

    -------------------------------------------------
    -- Winner Announcement
    --
    -- Only for Loot Council items -- Open Roll and Soft
    -- Reserve items already got their WinnerAnnounced
    -- the moment the roll ended, in FinalizeRoll, not
    -- here (Assign for those can happen much later --
    -- manual assignment, or Auto Assign turned off).
    -------------------------------------------------

    if entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()
        local councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if councilItem and councilItem.Mode == "Funnel" then

            -------------------------------------------------
            -- Funnel Assignment Announcement
            --
            -- No roll or vote happened here -- a plain
            -- "assigned to" message fits better than the
            -- roll-flavoured WinnerAnnounced text.
            -------------------------------------------------

            ImpLoot.Announcements:Announce("FunnelAssigned", {
                item = entry.ItemLink,
                player = winnerName,
            })

        else

            local winnerRoll = nil

            for _, roll in ipairs(entry.Rolls) do

                if roll.Player == winnerName then
                    winnerRoll = roll
                    break
                end

            end

            local rollText = "N/A"
            local rangeText = "N/A"

            if winnerRoll then
                rollText = tostring(winnerRoll.Roll)
                rangeText = tostring(winnerRoll.Min) .. "-" .. tostring(winnerRoll.Max)
            end

            ImpLoot.Announcements:Announce("WinnerAnnounced", {
                item = entry.ItemLink,
                winner = winnerName,
                roll = rollText,
                range = rangeText,
            })

        end

    end

    self:LogResolution(entry.ItemID, winnerName, entry.BossName)

    if ImpLoot.Comms then
        ImpLoot.Comms:SendResolved(entry.ItemID, winnerName, entry.BossName)
    end

    ImpLoot.Events:Fire("LootQueueChanged")

    return true, resultMessage

end
