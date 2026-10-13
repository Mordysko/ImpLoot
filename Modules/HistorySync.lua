-------------------------------------------------
-- Loot History Sync
--
-- Fills in loot you missed (disconnected, too far away
-- to see the chat line, joined late) from other raiders
-- running ImpLoot. Covers the last 7 days.
--
-- Runs on its own -- there's no button: once after you
-- log in, /reload or join a raid, then every few minutes
-- while you're in one (Options -> Loot Master, 0 = off).
-- Never during combat; it waits until the fight is over.
--
-- How a sync goes (addon messages, ImpLoot prefix):
--
--   HS_REQ|since|myTime     to the raid: who has history since <since>?
--   HS_HAVE|count|theirTime whispered back by anyone with entries
--   HS_SEND|since           whispered to the (up to) two raiders
--                           with the most entries
--   HS_E|...                one per entry, whispered back
--   HS_END|count            done
--
-- Each raider's clock is compared with ours (from
-- HS_HAVE), so their times line up with ours.
--
-- Matching a received entry against our own history:
--
--   1. One we deleted (see LootHistory:DeleteWhere) is
--      never brought back.
--   2. Same recorder and the recorder's own Id: the
--      same entry.
--   3. Otherwise the same item, within 15 minutes, with
--      the same winner (or the winner it was first
--      recorded for, so an edited entry still matches).
--      Each of our entries can only be matched once per
--      sender, so two real copies won by the same player
--      are never folded into one.
--
-- When both sides have the entry, whichever was edited
-- most recently wins; otherwise we only fill in what
-- we're missing.
-------------------------------------------------

ImpLoot.HistorySync = ImpLoot.HistorySync or {}
local HistorySync = ImpLoot.HistorySync

local SYNC_DAYS = 7
local MATCH_WINDOW = 15 * 60
local SEND_INTERVAL = 0.15
local OFFER_WAIT = 3
local SYNC_TIMEOUT = 90
local MAX_SOURCES = 2
local MAX_MESSAGE = 240

-------------------------------------------------
-- Small Helpers
-------------------------------------------------

local function Me()
    return UnitName("player")
end

local function Clean(value)
    return (tostring(value or ""):gsub("|", "/"))
end

local function Optional(value)
    return (value and value ~= "") and value or nil
end

local function ShortName(name)
    return name and (name:match("^([^%-]+)") or name):lower() or nil
end

-- Sync only ever runs in a raid group, never a party
local function GroupChannel()

    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        return "RAID"
    end

    return nil

end

-------------------------------------------------
-- Timers And The Throttled Outbox
--
-- Sending a week of history in one burst could get the
-- player disconnected, so entries go out a few per
-- second.
-------------------------------------------------

local timerFrame = CreateFrame("Frame")
local timers = {}
local outbox = {}
local sendWait = 0

timerFrame:SetScript("OnUpdate", function(_, elapsed)

    for i = #timers, 1, -1 do

        local timer = timers[i]
        timer.Left = timer.Left - elapsed

        if timer.Left <= 0 then
            table.remove(timers, i)
            timer.Callback()
        end

    end

    if #outbox > 0 then

        sendWait = sendWait - elapsed

        if sendWait <= 0 then

            sendWait = SEND_INTERVAL
            local message = table.remove(outbox, 1)
            SendAddonMessage("ImpLoot", message.Text, message.Channel, message.Target)

        end

    end

end)

local function After(seconds, callback)
    table.insert(timers, { Left = seconds, Callback = callback })
end

local function Queue(text, channel, target)
    table.insert(outbox, { Text = text:sub(1, MAX_MESSAGE), Channel = channel, Target = target })
end

-------------------------------------------------
-- What We Share
-------------------------------------------------

function HistorySync:EntriesSince(since)

    local list = {}

    for _, logEntry in ipairs(ImpLoot.LootMaster:GetLog()) do

        if logEntry.Winner
        and logEntry.ItemID
        and not logEntry.NoSync
        and (logEntry.Timestamp or 0) >= since then
            table.insert(list, logEntry)
        end

    end

    return list

end

local function EncodeEntry(e)

    local fields = {
        "HS_E",
        Clean(e.Recorder), e.RecorderId or "", e.ItemID, e.Quality or "",
        Clean(e.ItemName), Clean(e.Winner), Clean(e.FirstWinner), e.WinnerClass or "",
        Clean(e.BossName), Clean(e.Raid), e.Size or "", e.Heroic and "1" or "",
        Clean(e.ResultLabel), e.Mode or "", e.Timestamp or 0, e.Received or "", e.Edited or "",
        "",
    }

    -- The note gets whatever room is left, so nothing
    -- before it is ever cut off.
    local room = MAX_MESSAGE - #table.concat(fields, "|")
    fields[#fields] = Clean(e.Note):sub(1, math.max(0, math.min(60, room)))

    return table.concat(fields, "|")

end

local function DecodeEntry(parts, offset)

    local function num(index)
        return tonumber(parts[index])
    end

    local entry = {
        Recorder = Optional(parts[2]),
        RecorderId = num(3),
        ItemID = num(4),
        Quality = num(5),
        ItemName = Optional(parts[6]),
        Winner = Optional(parts[7]),
        FirstWinner = Optional(parts[8]),
        WinnerClass = Optional(parts[9]),
        BossName = Optional(parts[10]),
        Raid = Optional(parts[11]),
        Size = num(12),
        Heroic = parts[13] == "1",
        ResultLabel = parts[14] or "",
        Mode = Optional(parts[15]),
        Timestamp = (num(16) or 0) + offset,
        Received = num(17) and (num(17) + offset) or nil,
        Edited = num(18) and (num(18) + offset) or nil,
        Note = Optional(parts[19]),
    }

    if not entry.Raid then
        entry.Heroic = nil
    end

    return entry

end

-------------------------------------------------
-- Matching And Merging
-------------------------------------------------

local function NamesOf(e)

    local names = {}

    if e.Winner then
        names[ShortName(e.Winner)] = true
    end

    if e.FirstWinner then
        names[ShortName(e.FirstWinner)] = true
    end

    return names

end

local function ShareAName(a, b)

    local namesA = NamesOf(a)

    for name in pairs(NamesOf(b)) do
        if namesA[name] then
            return true
        end
    end

    return false

end

function HistorySync:IsDeleted(remote)

    for _, mark in ipairs(ImpLootDB.LootHistoryDeleted or {}) do

        if remote.Recorder and remote.RecorderId
        and mark.Recorder == remote.Recorder
        and mark.RecorderId == remote.RecorderId then
            return true
        end

        if mark.ItemID == remote.ItemID
        and math.abs((mark.Timestamp or 0) - remote.Timestamp) <= MATCH_WINDOW
        and NamesOf(remote)[ShortName(mark.Winner)] then
            return true
        end

    end

    return false

end

function HistorySync:FindMatch(remote, alreadyMatched)

    local log = ImpLoot.LootMaster:GetLog()

    -- 2. The very same entry
    if remote.Recorder and remote.RecorderId then

        for _, local_ in ipairs(log) do

            if not alreadyMatched[local_]
            and local_.Recorder == remote.Recorder
            and local_.RecorderId == remote.RecorderId then
                return local_
            end

        end

    end

    -- 3. Same item, same time, a winner in common --
    -- an exact winner match beats an edited one
    local fallback

    for _, local_ in ipairs(log) do

        if not alreadyMatched[local_]
        and local_.ItemID == remote.ItemID
        and math.abs((local_.Timestamp or 0) - remote.Timestamp) <= MATCH_WINDOW
        and ShareAName(local_, remote) then

            if ShortName(local_.Winner) == ShortName(remote.Winner) then
                return local_
            end

            fallback = fallback or local_

        end

    end

    return fallback

end

local function FillMissing(target, source, field)

    if (target[field] == nil or target[field] == "") and source[field] ~= nil and source[field] ~= "" then
        target[field] = source[field]
        return true
    end

    return false

end

-- Returns "added", "updated", "same" or "deleted".
function HistorySync:Merge(remote, sender, alreadyMatched)

    if self:IsDeleted(remote) then
        return "deleted"
    end

    local local_ = self:FindMatch(remote, alreadyMatched)

    if local_ then

        alreadyMatched[local_] = true

        local changed = false

        if (remote.Edited or 0) > (local_.Edited or 0) then

            -- Their version was edited more recently: it wins
            for _, field in ipairs({ "Winner", "WinnerClass", "Note", "ResultLabel", "BossName" }) do

                if remote[field] ~= nil and local_[field] ~= remote[field] then
                    local_[field] = remote[field]
                    changed = true
                end

            end

            local_.FirstWinner = local_.FirstWinner or remote.FirstWinner
            local_.Edited = remote.Edited

        else

            -- Ours is as new or newer: only take what we lack
            for _, field in ipairs({ "Note", "ResultLabel", "WinnerClass", "ItemName", "Quality", "Raid", "Size" }) do
                changed = FillMissing(local_, remote, field) or changed
            end

            if local_.Raid and local_.Heroic == nil then
                local_.Heroic = remote.Heroic
            end

        end

        -- We only saw the chat line; they know how it was won
        if local_.Source == "Chat" and remote.Mode and not local_.Edited then

            local_.Source = nil
            local_.Mode = remote.Mode
            local_.ResultLabel = remote.ResultLabel
            local_.Note = remote.Note or local_.Note
            changed = true

        end

        if remote.Received and not local_.Received then
            local_.Received = remote.Received
            changed = true
        end

        return changed and "updated" or "same"

    end

    -- New to us: add it, in time order, so Who won what
    -- and the chat matching still see the log oldest first
    local log = ImpLoot.LootMaster:GetLog()

    local id = ImpLootDB.LootMasterLogNextId or 1
    ImpLootDB.LootMasterLogNextId = id + 1

    remote.Id = id
    remote.Synced = sender

    local position = #log + 1

    while position > 1 and (log[position - 1].Timestamp or 0) > remote.Timestamp do
        position = position - 1
    end

    table.insert(log, position, remote)
    alreadyMatched[remote] = true

    return "added"

end

-------------------------------------------------
-- Starting A Sync
-------------------------------------------------

function HistorySync:SetStatus(text)
    self.StatusText = text
    ImpLoot.Events:Fire("LootHistoryChanged")
end

function HistorySync:Start(quiet)

    local channel = GroupChannel()

    if not channel then

        if not quiet then
            ImpLoot:Print("History sync: you need to be in a raid group.")
        end

        return

    end

    if self.Current and not self.Current.Done then

        if not quiet then
            ImpLoot:Print("History sync: already running.")
        end

        return

    end

    self.Current = {
        Since = time() - SYNC_DAYS * 86400,
        Offers = {},
        Asked = {},
        Matched = {},
        Added = 0,
        Updated = 0,
        Quiet = quiet,
    }

    Queue("HS_REQ|" .. self.Current.Since .. "|" .. time(), channel)

    self:SetStatus("Asking the raid...")

    local current = self.Current

    After(OFFER_WAIT, function()
        if self.Current == current then
            self:PickSources()
        end
    end)

end

function HistorySync:PickSources()

    local current = self.Current
    local names = {}

    for name, offer in pairs(current.Offers) do

        if offer.Count > 0 then
            table.insert(names, name)
        end

    end

    table.sort(names, function(a, b)
        return current.Offers[a].Count > current.Offers[b].Count
    end)

    if #names == 0 then

        current.Done = true

        if not current.Quiet then
            ImpLoot:Print("History sync: nobody else in the group has ImpLoot history to share.")
        end

        self:SetStatus(nil)

        return

    end

    local asked = {}

    for i = 1, math.min(MAX_SOURCES, #names) do

        current.Asked[names[i]] = true
        current.Matched[names[i]] = {}
        table.insert(asked, names[i])

        Queue("HS_SEND|" .. current.Since, "WHISPER", names[i])

    end

    self:SetStatus("Receiving from " .. table.concat(asked, ", ") .. "...")

    After(SYNC_TIMEOUT, function()
        if self.Current == current then
            self:Finish()
        end
    end)

end

function HistorySync:Finish()

    local current = self.Current

    if not current or current.Done then
        return
    end

    current.Done = true

    local message = "History sync done: " .. current.Added .. " new"

    if current.Updated > 0 then
        message = message .. ", " .. current.Updated .. " updated"
    end

    if not current.Quiet or current.Added + current.Updated > 0 then
        ImpLoot:Print(message .. ".")
    end

    self:SetStatus(nil)
    ImpLoot.Events:Fire("LootQueueChanged")

end

-------------------------------------------------
-- Incoming
-------------------------------------------------

function HistorySync:OnMessage(message, sender)

    if not sender or ShortName(sender) == ShortName(Me()) then
        return
    end

    local parts = { ImpLoot.Comms:SplitParts(message) }
    local kind = parts[1]

    if kind == "HS_REQ" then

        if not GroupChannel() then
            return
        end

        local list = self:EntriesSince(tonumber(parts[2]) or 0)

        if #list > 0 then
            Queue("HS_HAVE|" .. #list .. "|" .. time(), "WHISPER", sender)
        end

    elseif kind == "HS_HAVE" then

        local current = self.Current

        if current and not current.Done then
            current.Offers[sender] = {
                Count = tonumber(parts[2]) or 0,
                Offset = time() - (tonumber(parts[3]) or time()),
            }
        end

    elseif kind == "HS_SEND" then

        local list = self:EntriesSince(tonumber(parts[2]) or 0)

        for _, logEntry in ipairs(list) do
            Queue(EncodeEntry(logEntry), "WHISPER", sender)
        end

        Queue("HS_END|" .. #list, "WHISPER", sender)

    elseif kind == "HS_E" then

        local current = self.Current

        if not current or current.Done or not current.Asked[sender] then
            return
        end

        local offset = (current.Offers[sender] and current.Offers[sender].Offset) or 0
        local remote = DecodeEntry(parts, offset)

        if not remote.ItemID or not remote.Winner then
            return
        end

        local result = self:Merge(remote, sender, current.Matched[sender])

        if result == "added" then
            current.Added = current.Added + 1
        elseif result == "updated" then
            current.Updated = current.Updated + 1
        end

    elseif kind == "HS_END" then

        local current = self.Current

        if not current or current.Done or not current.Asked[sender] then
            return
        end

        current.Asked[sender] = "done"

        for _, state in pairs(current.Asked) do
            if state ~= "done" then
                return
            end
        end

        self:Finish()

    end

end

-------------------------------------------------
-- Automatic Sync
--
-- Once soon after logging in, a /reload or joining a
-- raid, then again every SyncInterval minutes while in
-- one. Checked every 30 seconds; skipped while in combat
-- (and simply caught on the next check after it).
-------------------------------------------------

local CHECK_EVERY = 30
local MINIMUM_INTERVAL = 2

function HistorySync:GetIntervalSeconds()

    local minutes = tonumber(ImpLoot.LootHistory.Settings.SyncInterval) or 0

    if minutes <= 0 then
        return nil
    end

    return math.max(MINIMUM_INTERVAL, minutes) * 60

end

function HistorySync:CheckAutoSync()

    local interval = self:GetIntervalSeconds()

    if not interval then
        return
    end

    if not (GetNumRaidMembers and GetNumRaidMembers() > 0) then
        return
    end

    if InCombatLockdown and InCombatLockdown() then
        return
    end

    if self.Current and not self.Current.Done then
        return
    end

    local now = time()

    -- NextSyncAt is set to "soon" by logging in / joining
    if self.NextSyncAt and now < self.NextSyncAt then
        return
    end

    self.NextSyncAt = now + interval
    self:Start(true)

end

-- Logging in, a /reload or joining a raid: sync shortly
function HistorySync:OnGroupChanged()

    local inRaid = GetNumRaidMembers and GetNumRaidMembers() > 0

    if inRaid and not self.WasInRaid then
        self.NextSyncAt = time() + 10
    end

    self.WasInRaid = inRaid

end

function HistorySync:Initialize()

    local frame = CreateFrame("Frame")

    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("RAID_ROSTER_UPDATE")

    frame:SetScript("OnEvent", function()
        self:OnGroupChanged()
    end)

    self.EventFrame = frame

    local function Check()
        self:CheckAutoSync()
        After(CHECK_EVERY, Check)
    end

    After(CHECK_EVERY, Check)

end
