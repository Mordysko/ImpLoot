-------------------------------------------------
-- ImpLoot Soft Reserve
-------------------------------------------------

ImpLoot.SoftReserve = {}
ImpLoot.SoftReserve.Reserves = {}

ImpLoot.SoftReserve.Defaults = {
    AllowMultipleReserves = true,
    ExcludePreviousWinners = true,
}

-------------------------------------------------
-- Initialize
--
-- Settings and the working "who's still eligible to
-- roll this item" state persist across reloads (the
-- import list itself doesn't -- it's re-pasted each
-- time) so a manual Clear Raid History is required to
-- reset progress mid-lockout.
-------------------------------------------------

function ImpLoot.SoftReserve:Initialize()

    ImpLootDB.SoftReserveState = ImpLootDB.SoftReserveState or {

        Settings = {
            AllowMultipleReserves = true,
            ExcludePreviousWinners = true,
        },

        Remaining = {},
        WonLog = {},

    }

    self.State = ImpLootDB.SoftReserveState

end

function ImpLoot.SoftReserve:GetSettings()
    return self.State.Settings
end

function ImpLoot.SoftReserve:SetSetting(key, value)
    self.State.Settings[key] = value
end

-------------------------------------------------
-- Reset Settings To Defaults
--
-- Only the Settings sub-table -- never touches
-- Remaining/WonLog (in-progress raid state).
-------------------------------------------------

function ImpLoot.SoftReserve:ResetSettingsToDefaults()

    for key, value in pairs(self.Defaults) do
        self.State.Settings[key] = value
    end

end

-------------------------------------------------
-- Parse CSV Line
--
-- SoftRes.it has exported at least two CSV variants:
-- one that quotes fields containing commas (item/boss
-- names) and one that quotes nothing at all. Column
-- order is identical between them (just different
-- header labels, which Import() skips regardless), so
-- a proper quote-aware field splitter handles both --
-- and any future variant with the same column order --
-- without needing to special-case either one.
-------------------------------------------------

local function ParseCSVLine(line)

    local fields = {}
    local i = 1
    local n = #line

    while i <= n + 1 do

        local field

        if line:sub(i, i) == '"' then

            -- Quoted field: read to the closing quote; a
            -- doubled "" inside represents a literal quote
            -- character rather than ending the field.
            local out = {}
            i = i + 1

            while true do

                local c = line:sub(i, i)

                if c == "" then
                    break -- malformed / unterminated -- stop at end of line
                elseif c == '"' then

                    if line:sub(i + 1, i + 1) == '"' then
                        table.insert(out, '"')
                        i = i + 2
                    else
                        i = i + 1
                        break
                    end

                else
                    table.insert(out, c)
                    i = i + 1
                end

            end

            field = table.concat(out)

        else

            -- Unquoted field: up to the next comma or end of line
            local commaPos = line:find(",", i, true)

            if commaPos then
                field = line:sub(i, commaPos - 1)
                i = commaPos
            else
                field = line:sub(i)
                i = n + 1
            end

        end

        table.insert(fields, field)

        if line:sub(i, i) == "," then
            i = i + 1
        else
            break
        end

    end

    return fields

end

-------------------------------------------------
-- Import CSV
-------------------------------------------------

function ImpLoot.SoftReserve:Import(csv)

    self.Reserves = {}

    local firstLine = true
    local reserveCount = 0

    for line in csv:gmatch("[^\r\n]+") do

        if firstLine then

            firstLine = false

        else

            local fields = ParseCSVLine(line)

            local itemName = fields[1]
            local itemID = fields[2]
            local boss = fields[3]
            local player = fields[4]
            local class = fields[5]
            local spec = fields[6]
            local note = fields[7]
            local plus = fields[8]
            local date = fields[9]

            if itemID and tonumber(itemID) then

                itemID = tonumber(itemID)

                if not self.Reserves[itemID] then
                    self.Reserves[itemID] = {}
                end

                table.insert(self.Reserves[itemID], {

                    Player = player,
                    Class = class,
                    Spec = spec,

                    ItemName = itemName,
                    Boss = boss,

                    Note = note,
                    Plus = tonumber(plus) or 0,
                    Date = date,

                })

                reserveCount = reserveCount + 1

            end

        end

    end

    return reserveCount

end

-------------------------------------------------
-- Get Reserves for Item
-------------------------------------------------

function ImpLoot.SoftReserve:GetReserves(itemID)

    if not self.Reserves then
        return {}
    end

    return self.Reserves[itemID] or {}

end

-------------------------------------------------
-- Remaining Rollers (Working State)
--
-- Expands each reserve record into one flat "slot"
-- per effective roll (1 base + Plus, unless multiple
-- reserves are disallowed) so the same table.remove
-- shift-and-compact mechanic used for Loot Council
-- applies here too. Falls back to a fresh expansion
-- from the current import if this item hasn't been
-- touched yet this session.
-------------------------------------------------

function ImpLoot.SoftReserve:GetRemainingSlots(itemID)

    if not self.State.Remaining[itemID] then

        local slots = {}

        for _, reserve in ipairs(self:GetReserves(itemID)) do

            local count = 1

            if self.State.Settings.AllowMultipleReserves then
                count = 1 + (reserve.Plus or 0)
            end

            for i = 1, count do

                table.insert(slots, {
                    Player = reserve.Player,
                    Class = reserve.Class,
                    Spec = reserve.Spec,
                })

            end

        end

        self.State.Remaining[itemID] = slots

    end

    return self.State.Remaining[itemID]

end

-------------------------------------------------
-- Record Win
--
-- Removes the winner's FIRST remaining slot for this
-- item and shifts the rest up, unless Exclude Previous
-- Winners is turned off (in which case winning doesn't
-- remove eligibility for a repeat drop).
-------------------------------------------------

function ImpLoot.SoftReserve:RecordWin(itemID, winnerName)

    if not self.State.Settings.ExcludePreviousWinners then
        return
    end

    local slots = self:GetRemainingSlots(itemID)

    for i, slot in ipairs(slots) do

        if slot.Player == winnerName then

            table.remove(slots, i)

            break

        end

    end

    self.State.WonLog[itemID] = self.State.WonLog[itemID] or {}

    table.insert(self.State.WonLog[itemID], { Winner = winnerName })

end

function ImpLoot.SoftReserve:GetWonLog(itemID)
    return self.State.WonLog[itemID] or {}
end

-------------------------------------------------
-- Clear Raid History
--
-- Resets working state (remaining slots + won log)
-- for every item -- never touches the imported
-- reserve list itself, and never touches settings.
-------------------------------------------------

function ImpLoot.SoftReserve:ClearRaidHistory()

    self.State.Remaining = {}
    self.State.WonLog = {}

end
