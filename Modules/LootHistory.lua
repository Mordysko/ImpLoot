-------------------------------------------------
-- Loot History: Chat Capture
--
-- Everyone in the raid sees "<player> receives loot:
-- [item]." when an item lands in someone's bags. Reading
-- those lines lets ImpLoot's history (the Summary
-- window's Who won what) also catch loot that never went
-- through the Loot Master window -- a Need/Greed win, an
-- item handed out by hand -- and lets raiders who aren't
-- the loot master build a history of their own.
--
-- What it does with each line (epic and better, inside a
-- raid instance only):
--
--   1. It's an item ImpLoot already assigned (same item,
--      same winner, recently): mark that entry as
--      received, nothing new is added.
--   2. Otherwise: add a new entry, noted "Looted
--      directly", tied to the boss it most likely came
--      from (see GuessBoss).
--
-- If the loot master's own "assigned" message arrives
-- AFTER the chat line (it can, on a raider's client),
-- LootMaster:LogResolution upgrades the chat entry in
-- place rather than adding a second one.
-------------------------------------------------

ImpLoot.LootHistory = ImpLoot.LootHistory or {}
local LootHistory = ImpLoot.LootHistory

-- How long after an assignment its "receives loot" line
-- is still matched to it, and how long a boss kill is
-- remembered for working out where loot came from.
local MATCH_WINDOW = 2 * 60 * 60
local BOSS_KILL_WINDOW = 15 * 60

local MINIMUM_QUALITY = 4 -- Epic

-- Never worth a history line: currencies and crafting
-- drops that every boss hands out.
local IGNORED_ITEMS = {
    [40752] = true, -- Emblem of Heroism
    [40753] = true, -- Emblem of Valor
    [45624] = true, -- Emblem of Conquest
    [47241] = true, -- Emblem of Triumph
    [49426] = true, -- Emblem of Frost
    [34057] = true, -- Abyss Crystal
    [43102] = true, -- Frozen Orb
    [50274] = true, -- Shadowfrost Shard (one per person, per kill)
}

LootHistory.Defaults = {
    RecordFromChat = true,

    -- Minutes between automatic history syncs while in a
    -- raid (0 = never). See HistorySync.
    SyncInterval = 60,
}

-------------------------------------------------
-- Loot Line Patterns
--
-- Built from the game's own (localized) strings, so it
-- works whatever language the client is in. Turns a
-- printf-style string like "%s receives loot: %s." into
-- a Lua pattern, keeping track of which capture is which
-- for languages that reorder them ("%2$s ... %1$s").
-------------------------------------------------

local MAGIC_CHARACTERS = "[%(%)%.%+%-%*%?%[%]%^%$]"

local function BuildPattern(formatString)

    local parts = {}
    local order = {}
    local captureCount = 0
    local i = 1
    local length = #formatString

    while i <= length do

        local char = formatString:sub(i, i)

        if char == "%" then

            local position, kind, nextIndex = formatString:match("^%%(%d)%$([sd])()", i)

            if position then

                captureCount = captureCount + 1
                order[captureCount] = tonumber(position)
                table.insert(parts, kind == "d" and "(%d+)" or "(.+)")
                i = nextIndex

            else

                local kind2 = formatString:sub(i + 1, i + 1)

                if kind2 == "s" or kind2 == "d" then
                    captureCount = captureCount + 1
                    order[captureCount] = captureCount
                    table.insert(parts, kind2 == "d" and "(%d+)" or "(.+)")
                    i = i + 2
                else
                    table.insert(parts, "%%")
                    i = i + (kind2 == "%" and 2 or 1)
                end

            end

        else

            table.insert(parts, char:find(MAGIC_CHARACTERS) and ("%" .. char) or char)
            i = i + 1

        end

    end

    return "^" .. table.concat(parts) .. "$", order

end

function LootHistory:BuildPatterns()

    self.Patterns = {}

    local function Add(formatString, isSelf)

        if type(formatString) == "string" then
            local pattern, order = BuildPattern(formatString)
            table.insert(self.Patterns, { Pattern = pattern, Order = order, IsSelf = isSelf })
        end

    end

    -- The "x2" versions first, so the count isn't swallowed
    -- into the item part by the plain version.
    Add(LOOT_ITEM_SELF_MULTIPLE, true)
    Add(LOOT_ITEM_MULTIPLE, false)
    Add(LOOT_ITEM_SELF, true)
    Add(LOOT_ITEM, false)

end

-- Returns playerName, itemLink -- or nil if it isn't a loot line.
function LootHistory:ParseLootLine(message)

    for _, entry in ipairs(self.Patterns or {}) do

        local captures = { message:match(entry.Pattern) }

        if captures[1] then

            local args = {}

            for index, value in ipairs(captures) do
                args[entry.Order[index]] = value
            end

            local playerName, itemText

            if entry.IsSelf then
                playerName, itemText = UnitName("player"), args[1]
            else
                playerName, itemText = args[1], args[2]
            end

            local link = itemText and itemText:match("|c%x+|Hitem:.-|h.-|h|r")

            if link then
                return playerName, link
            end

        end

    end

    return nil

end

-------------------------------------------------
-- Boss Kills
--
-- Remembers the last raid boss seen dying (any name the
-- raid database knows as a boss), so loot can be tied to
-- the right one when an item drops from more than one.
-------------------------------------------------

function LootHistory:IsKnownBoss(name)

    if not name then
        return false
    end

    if not self.BossNames then

        self.BossNames = {}

        for _, raid in ipairs(ImpLoot.Database:GetRaids() or {}) do
            for _, boss in ipairs(raid.Bosses or {}) do
                self.BossNames[boss.Name] = true
            end
        end

    end

    return self.BossNames[name] == true

end

function LootHistory:OnCombatLog(subEvent, destName)

    if subEvent == "UNIT_DIED" and self:IsKnownBoss(destName) then
        self.LastBossKill = { Name = destName, Time = time() }
    end

end

-------------------------------------------------
-- Guess Boss
--
-- Which boss an item most likely came from: every boss
-- the raid database lists it under, preferring the one
-- just killed. An item the database doesn't list for any
-- boss is filed as Trash.
-------------------------------------------------

function LootHistory:GuessBoss(itemID)

    local candidates = {}

    for _, raid in ipairs(ImpLoot.Database:GetRaids() or {}) do

        for _, boss in ipairs(raid.Bosses or {}) do

            for _, item in ipairs(boss.Loot or {}) do

                if item.IDs and (item.IDs.Normal == itemID or item.IDs.Heroic == itemID) then
                    table.insert(candidates, boss.Name)
                    break
                end

            end

        end

    end

    local recent = self.LastBossKill

    if recent and (time() - recent.Time) <= BOSS_KILL_WINDOW then

        for _, name in ipairs(candidates) do
            if name == recent.Name then
                return name
            end
        end

    end

    return candidates[1] or "Trash"

end

-------------------------------------------------
-- On Loot Line
-------------------------------------------------

local function ShortName(name)
    return name and (name:match("^([^%-]+)") or name):lower() or ""
end

function LootHistory:OnLootLine(message)

    if not self.Settings.RecordFromChat then
        return
    end

    local raidName = ImpLoot.LootMaster:GetRaidContext()

    if not raidName then
        return
    end

    local playerName, link = self:ParseLootLine(message)

    if not playerName then
        return
    end

    local itemID = tonumber(link:match("item:(%d+)"))

    if not itemID or IGNORED_ITEMS[itemID] then
        return
    end

    local itemName, _, quality = GetItemInfo(link)

    if not quality then
        quality = ImpLoot.LootMaster:GetItemQuality(itemID)
    end

    if (quality or 0) < MINIMUM_QUALITY then
        return
    end

    local now = time()
    local log = ImpLoot.LootMaster:GetLog()
    local who = ShortName(playerName)

    -- An item won while the loot was closed has now reached
    -- its winner (handed over or traded): it's done
    for _, entry in ipairs(ImpLoot.LootMaster:GetQueue() or {}) do

        if entry.State == "Awarded" and entry.ItemID == itemID and ShortName(entry.Winner) == who then
            entry.State = "Resolved"
            ImpLoot.Events:Fire("LootQueueChanged")
            break
        end

    end

    -------------------------------------------------
    -- 1. Already Assigned Through ImpLoot
    --
    -- Newest first, so with two copies won by the same
    -- player each line marks a different entry.
    -------------------------------------------------

    for i = #log, 1, -1 do

        local logEntry = log[i]

        if (now - (logEntry.Timestamp or 0)) > MATCH_WINDOW then
            break
        end

        if logEntry.ItemID == itemID
        and not logEntry.Received
        and ShortName(logEntry.Winner) == who then

            -- Oldest unreceived match wins, so keep looking
            -- back for an earlier one.
            local oldest = logEntry

            for j = i - 1, 1, -1 do

                local earlier = log[j]

                if (now - (earlier.Timestamp or 0)) > MATCH_WINDOW then
                    break
                end

                if earlier.ItemID == itemID
                and not earlier.Received
                and ShortName(earlier.Winner) == who then
                    oldest = earlier
                end

            end

            oldest.Received = now
            ImpLoot.Events:Fire("LootQueueChanged")

            return

        end

    end

    -------------------------------------------------
    -- 2. Not Assigned Through ImpLoot: Add It
    -------------------------------------------------

    ImpLoot.LootMaster:LogResolution(itemID, playerName, self:GuessBoss(itemID), nil, "", {
        ItemName = itemName or link:match("%[(.-)%]"),
        Quality = quality,
        Note = "Looted directly",
        Recorder = UnitName("player"),
        Source = "Chat",
        Received = now,
    })

    ImpLoot.Events:Fire("LootQueueChanged")

end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function LootHistory:Initialize()

    ImpLootDB.LootHistorySettings = ImpLootDB.LootHistorySettings or {}

    -- exp.4 had an on/off AutoSync; off carries over as 0
    local saved = ImpLootDB.LootHistorySettings

    if saved.AutoSync == false and saved.SyncInterval == nil then
        saved.SyncInterval = 0
    end

    saved.AutoSync = nil

    -- exp.5/exp.6 defaulted to 10 minutes; the default is now
    -- 60. Only an untouched 10 is moved -- any other value
    -- was chosen and stays.
    if not saved.SyncIntervalDefault60 then

        if saved.SyncInterval == 10 then
            saved.SyncInterval = 60
        end

        saved.SyncIntervalDefault60 = true

    end

    for key, value in pairs(self.Defaults) do

        if ImpLootDB.LootHistorySettings[key] == nil then
            ImpLootDB.LootHistorySettings[key] = value
        end

    end

    self.Settings = ImpLootDB.LootHistorySettings

    ImpLootDB.LootHistoryDeleted = ImpLootDB.LootHistoryDeleted or {}
    self:PruneDeleted()

    self:BuildPatterns()

    local frame = CreateFrame("Frame")

    frame:RegisterEvent("CHAT_MSG_LOOT")
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

    frame:SetScript("OnEvent", function(_, event, ...)

        if event == "CHAT_MSG_LOOT" then

            self:OnLootLine((...))

        elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then

            -- 3.3.5: timestamp, event, srcGUID, srcName, srcFlags,
            -- dstGUID, dstName, dstFlags
            local _, subEvent, _, _, _, _, destName = ...
            self:OnCombatLog(subEvent, destName)

        end

    end)

    self.EventFrame = frame

end

-------------------------------------------------
-- Editing
--
-- Any hand edit records when it happened (Edited) and
-- the winner it was first recorded with (FirstWinner),
-- so a later sync can still recognise the drop and
-- know which version is newest.
-------------------------------------------------

function LootHistory:MarkEdited(logEntry)

    if logEntry.Winner and not logEntry.FirstWinner then
        logEntry.FirstWinner = logEntry.Winner
    end

    logEntry.Edited = time()

end

function LootHistory:SetWinner(logEntry, playerName)

    playerName = playerName and playerName:gsub("^%s+", ""):gsub("%s+$", "") or ""

    if playerName == "" or playerName == logEntry.Winner then
        return
    end

    -- "brad" -> "Brad"
    playerName = playerName:sub(1, 1):upper() .. playerName:sub(2)

    self:MarkEdited(logEntry)
    logEntry.Winner = playerName
    logEntry.WinnerClass = ImpLoot.LootMaster:GetClassForPlayer(playerName)

    ImpLoot.Events:Fire("LootHistoryChanged")

end

function LootHistory:SetNote(logEntry, note)

    note = note and note:gsub("^%s+", ""):gsub("%s+$", "") or ""

    if note == "" then
        note = nil
    end

    if note == logEntry.Note then
        return
    end

    self:MarkEdited(logEntry)
    logEntry.Note = note

    ImpLoot.Events:Fire("LootHistoryChanged")

end

-- The short tag in the Result column: MS, OS, SR, LC, DE
-- (or "" to clear it).
function LootHistory:SetTag(logEntry, tag)

    if (logEntry.ResultLabel or "") == (tag or "") then
        return
    end

    self:MarkEdited(logEntry)
    logEntry.ResultLabel = tag or ""

    ImpLoot.Events:Fire("LootHistoryChanged")

end

-- Whether this entry is shared when other raiders sync
function LootHistory:SetShared(logEntry, shared)

    logEntry.NoSync = (not shared) or nil

    ImpLoot.Events:Fire("LootHistoryChanged")

end

-------------------------------------------------
-- Deleting
--
-- A deleted entry leaves a small marker behind for 30
-- days so a later sync doesn't bring it back.
-------------------------------------------------

local TOMBSTONE_DAYS = 30

function LootHistory:PruneDeleted()

    local deleted = ImpLootDB.LootHistoryDeleted
    local limit = time() - TOMBSTONE_DAYS * 86400

    for i = #deleted, 1, -1 do

        if (deleted[i].Timestamp or 0) < limit then
            table.remove(deleted, i)
        end

    end

end

-- `shouldDelete(entry)` -> true removes it. Returns the count.
function LootHistory:DeleteWhere(shouldDelete)

    local log = ImpLoot.LootMaster:GetLog()
    local deleted = ImpLootDB.LootHistoryDeleted
    local count = 0

    for i = #log, 1, -1 do

        local logEntry = log[i]

        if shouldDelete(logEntry) then

            table.insert(deleted, {
                Recorder = logEntry.Recorder,
                RecorderId = logEntry.RecorderId,
                ItemID = logEntry.ItemID,
                Winner = logEntry.FirstWinner or logEntry.Winner,
                Timestamp = logEntry.Timestamp,
            })

            table.remove(log, i)
            count = count + 1

        end

    end

    if count > 0 then
        ImpLoot.Events:Fire("LootHistoryChanged")
        ImpLoot.Events:Fire("LootQueueChanged")
    end

    return count

end

function LootHistory:CountWhere(test)

    local count = 0

    for _, logEntry in ipairs(ImpLoot.LootMaster:GetLog()) do

        if test(logEntry) then
            count = count + 1
        end

    end

    return count

end

-------------------------------------------------
-- Tooltip
--
-- One entry's details, shared by the Summary window
-- and the History window.
-------------------------------------------------

function LootHistory:AddTooltipLines(logEntry)

    local label = 0.8

    local link = logEntry.ItemID and select(2, GetItemInfo(logEntry.ItemID))

    if link then
        GameTooltip:AddLine(link)
    else
        GameTooltip:AddLine(logEntry.ItemName or ("Item " .. tostring(logEntry.ItemID)), 1, 1, 1)
    end

    local cr, cg, cb = ImpLoot.Theme:GetClassColor(logEntry.WinnerClass)
    GameTooltip:AddDoubleLine("Winner", logEntry.Winner or "?", label, label, label, cr, cg, cb)

    if logEntry.FirstWinner and logEntry.FirstWinner ~= logEntry.Winner then
        GameTooltip:AddDoubleLine("First recorded as", logEntry.FirstWinner, label, label, label, 0.7, 0.7, 0.7)
    end

    if logEntry.Note then
        GameTooltip:AddDoubleLine("How", logEntry.Note, label, label, label, 1, 1, 1)
    end

    if logEntry.BossName then
        GameTooltip:AddDoubleLine("Boss", logEntry.BossName, label, label, label, 1, 1, 1)
    end

    local raidLabel = ImpLoot.LootMaster:FormatRaidLabel(logEntry)

    if raidLabel then
        GameTooltip:AddDoubleLine("Raid", raidLabel, label, label, label, 1, 1, 1)
    end

    if logEntry.Timestamp and logEntry.Timestamp > 0 then
        GameTooltip:AddDoubleLine("When", date("%Y-%m-%d %H:%M", logEntry.Timestamp), label, label, label, 1, 1, 1)
    end

    if logEntry.Received then
        GameTooltip:AddDoubleLine("Received", date("%H:%M", logEntry.Received), label, label, label, 0.6, 1, 0.6)
    end

    if logEntry.Recorder and logEntry.Recorder ~= UnitName("player") then
        GameTooltip:AddDoubleLine("Recorded by", logEntry.Recorder, label, label, label, 0.7, 0.7, 0.7)
    end

    if logEntry.Edited then
        GameTooltip:AddDoubleLine("Edited", date("%Y-%m-%d %H:%M", logEntry.Edited), label, label, label, 0.7, 0.7, 0.7)
    end

end

-------------------------------------------------
-- Export
--
-- One line per entry, oldest first:
-- [2026-10-09 21:14] Icecrown Citadel 25H | Lord Marrowgar | Item -> Brad (MS)
-------------------------------------------------

local function ItemName(logEntry)

    local cached = ImpLoot.ItemCache and ImpLoot.ItemCache:GetItem(logEntry.ItemID)

    return (cached and cached.Name) or logEntry.ItemName or ("Item " .. tostring(logEntry.ItemID))

end

LootHistory.ItemName = ItemName

-------------------------------------------------
-- CSV Helpers
--
-- A field is quoted when it holds a comma, a quote or
-- a line break (quotes inside are doubled), so names
-- like "Pride of the Demon Lord, Heroic" survive a
-- spreadsheet import intact.
-------------------------------------------------

local function CSVField(value)

    value = tostring(value == nil and "" or value)

    if value:find('[,"\r\n]') then
        value = '"' .. value:gsub('"', '""') .. '"'
    end

    return value

end

function LootHistory.CSVLine(fields)

    local out = {}

    for i, value in ipairs(fields) do
        out[i] = CSVField(value)
    end

    return table.concat(out, ",")

end

function LootHistory:BuildExport(entries)

    local list = {}

    for _, logEntry in ipairs(entries) do
        table.insert(list, logEntry)
    end

    table.sort(list, function(a, b)

        if (a.Timestamp or 0) == (b.Timestamp or 0) then
            return (a.Id or 0) < (b.Id or 0)
        end

        return (a.Timestamp or 0) < (b.Timestamp or 0)

    end)

    local lines = {}

    for _, e in ipairs(list) do

        local tag = (e.ResultLabel and e.ResultLabel ~= "") and (" (" .. e.ResultLabel .. ")") or ""

        table.insert(lines, string.format("[%s] %s | %s | %s -> %s%s",
            e.Timestamp and date("%Y-%m-%d %H:%M", e.Timestamp) or "?",
            ImpLoot.LootMaster:FormatRaidLabel(e) or "-",
            e.BossName or "?", ItemName(e), e.Winner or "?", tag))

    end

    return table.concat(lines, "\n"), #list

end

-------------------------------------------------
-- Build Export (CSV)
--
-- Same entries, same order as BuildExport, one row
-- each under a heading row, ready for a spreadsheet:
-- Date,Time,Raid,Size,Difficulty,Boss,Item,ItemID,Winner,Result,Note
-------------------------------------------------

function LootHistory:BuildExportCSV(entries)

    local list = {}

    for _, logEntry in ipairs(entries) do
        table.insert(list, logEntry)
    end

    table.sort(list, function(a, b)

        if (a.Timestamp or 0) == (b.Timestamp or 0) then
            return (a.Id or 0) < (b.Id or 0)
        end

        return (a.Timestamp or 0) < (b.Timestamp or 0)

    end)

    local lines = {
        LootHistory.CSVLine({ "Date", "Time", "Raid", "Size", "Difficulty", "Boss", "Item", "ItemID", "Winner", "Result", "Note" }),
    }

    for _, e in ipairs(list) do

        table.insert(lines, LootHistory.CSVLine({
            e.Timestamp and date("%Y-%m-%d", e.Timestamp) or "",
            e.Timestamp and date("%H:%M", e.Timestamp) or "",
            e.Raid or "",
            e.Size or "",
            e.Raid and (e.Heroic and "Heroic" or "Normal") or "",
            e.BossName or "",
            ItemName(e),
            e.ItemID or "",
            e.Winner or "",
            e.ResultLabel or "",
            e.Note or "",
        }))

    end

    return table.concat(lines, "\n"), #list

end
