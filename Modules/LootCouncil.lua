-------------------------------------------------
-- ImpLoot Loot Council
--
-- Council roster + saved "lists" (bundles of per-
-- item candidate configs, e.g. "10 Man Main" vs
-- "25 Man Main"). Each list also carries its own
-- in-progress state -- which candidates are still
-- in contention this lockout, and a log of who's
-- already won what -- kept separate from the saved
-- template so editing a list doesn't lose progress,
-- and "Clear raid history" only resets the working
-- state, not the template itself.
-------------------------------------------------

ImpLoot.LootCouncil = {}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.LootCouncil:Initialize()

    ImpLootDB.LootCouncil = ImpLootDB.LootCouncil or {

        Members = {},
        Lists = {},
        ListState = {},
        ActiveList = nil,

        -- Ordered fallback list -- {Name=...} entries,
        -- checked top-down against raid attendance.
        Disenchanters = {},

    }

    self.DB = ImpLootDB.LootCouncil

    -------------------------------------------------
    -- Members / Disenchanters Became Per List
    --
    -- Before, one council and one disenchanter list
    -- applied to everything. Each existing priority list
    -- starts with a copy of them, so nothing is lost.
    -------------------------------------------------

    if not self.DB.PerListPeopleMigrated then

        for _, list in pairs(self.DB.Lists or {}) do

            if not list.Members then
                list.Members = {}
                for _, name in ipairs(self.DB.Members or {}) do
                    table.insert(list.Members, name)
                end
            end

            if not list.Disenchanters then
                list.Disenchanters = {}
                for _, entry in ipairs(self.DB.Disenchanters or {}) do
                    table.insert(list.Disenchanters, { Name = entry.Name })
                end
            end

        end

        self.DB.PerListPeopleMigrated = true

    end

    -- Populate Mode: transient, session-only staging for
    -- the "alt-click items in the main window, then commit
    -- them to a list" workflow -- deliberately not
    -- persisted, since resuming a half-finished staging
    -- session across a reload isn't worth the complexity.
    self.PopulateMode = false
    self.StagedItems = {}
    self.PopulateListName = nil

end

-------------------------------------------------
-- Council Members And Disenchanters (Per List)
--
-- Each priority list has its own Loot Council members
-- and disenchanters, so switching the active list (Loot
-- Master window) switches who votes and who
-- disenchants along with the priorities. `listName`
-- defaults to the ACTIVE list -- the one loot uses; the
-- Loot Council / Priority window passes the list it's
-- editing. With no active list there's no council and
-- no disenchanter.
-------------------------------------------------

local function ShortLower(name)
    return name and (name:match("^([^%-]+)") or name):lower() or ""
end

function ImpLoot.LootCouncil:GetListData(listName)

    listName = listName or self:GetActiveListName()

    local list = listName and self.DB.Lists[listName]

    if list then
        list.Members = list.Members or {}
        list.Disenchanters = list.Disenchanters or {}
    end

    return list

end

function ImpLoot.LootCouncil:AddMember(name, listName)

    local list = self:GetListData(listName)

    if not list or not name or name == "" then
        return false
    end

    if self:IsMember(name, listName) then
        return false
    end

    table.insert(list.Members, name)

    return true

end

function ImpLoot.LootCouncil:RemoveMember(name, listName)

    local list = self:GetListData(listName)

    if not list then
        return false
    end

    for i, existing in ipairs(list.Members) do

        if ShortLower(existing) == ShortLower(name) then
            table.remove(list.Members, i)
            return true
        end

    end

    return false

end

function ImpLoot.LootCouncil:GetMembers(listName)

    local list = self:GetListData(listName)

    return list and list.Members or {}

end

function ImpLoot.LootCouncil:IsMember(name, listName)

    for _, existing in ipairs(self:GetMembers(listName)) do

        if ShortLower(existing) == ShortLower(name) then
            return true
        end

    end

    return false

end

-------------------------------------------------
-- Lists (Save / Load / Delete)
--
-- A "list" bundles per-item candidate configs for
-- one raid setup (e.g. "10 Man Main"). Switching the
-- active list is how a guild recalls a saved raid
-- team without re-entering data.
-------------------------------------------------

function ImpLoot.LootCouncil:CreateList(listName)

    if not listName or listName == "" then
        return false
    end

    if self.DB.Lists[listName] then
        return false
    end

    self.DB.Lists[listName] = { Items = {}, Members = {}, Disenchanters = {} }

    self.DB.ListState[listName] = {
        Remaining = {},
        WonLog = {},
    }

    if not self.DB.ActiveList then
        self.DB.ActiveList = listName
    end

    return true

end

function ImpLoot.LootCouncil:DeleteList(listName)

    if not self.DB.Lists[listName] then
        return false
    end

    self.DB.Lists[listName] = nil
    self.DB.ListState[listName] = nil

    if self.DB.LootList == listName then
        self.DB.LootList = nil
        ImpLoot.Events:Fire("ActivePriorityListChanged")
    end

    if self.DB.ActiveList == listName then

        local fallback = nil

        for name in pairs(self.DB.Lists) do
            fallback = name
            break
        end

        self.DB.ActiveList = fallback

    end

    return true

end

function ImpLoot.LootCouncil:GetListNames()

    local names = {}

    for name in pairs(self.DB.Lists) do
        table.insert(names, name)
    end

    table.sort(names)

    return names

end

-------------------------------------------------
-- Editing List vs Active (Loot) List
--
-- Two different things:
--
--   Editing list: the one open in the Loot Council /
--   Priority window. Choosing it there changes nothing
--   about loot.
--
--   Active list: the one loot actually uses, chosen in
--   the Loot Master window's priority list dropdown --
--   or none at all, so a different raid group isn't
--   given your main team's priorities. Every loot
--   decision asks GetActiveListName().
-------------------------------------------------

function ImpLoot.LootCouncil:SetEditingList(listName)

    if not self.DB.Lists[listName] then
        return false
    end

    self.DB.ActiveList = listName

    return true

end

function ImpLoot.LootCouncil:GetEditingListName()
    return self.DB.ActiveList
end

-- nil = no priority list in use
function ImpLoot.LootCouncil:SetActiveList(listName)

    if listName and not self.DB.Lists[listName] then
        return false
    end

    self.DB.LootList = listName

    ImpLoot.Events:Fire("ActivePriorityListChanged")

    return true

end

function ImpLoot.LootCouncil:GetActiveListName()

    local name = self.DB.LootList

    if name and self.DB.Lists[name] then
        return name
    end

    return nil

end

-------------------------------------------------
-- Items Within A List
--
-- candidates is up to 5 entries, each either
-- { Type = "Player", Value = "Brad" } or
-- { Type = "Class", Value = "Warrior" }.
-------------------------------------------------

function ImpLoot.LootCouncil:SetItem(listName, itemID, itemName, mode, candidates)

    local list = self.DB.Lists[listName]

    if not list then
        return false
    end

    if mode ~= "Vote" and mode ~= "Priority" and mode ~= "Funnel" and mode ~= "Preselected" then
        return false
    end

    if not candidates or #candidates > 5 then
        return false
    end

    list.Items[itemID] = {
        Name = itemName,
        Mode = mode,
        Candidates = candidates,
    }

    -- Reset this item's working state to a fresh copy
    -- of the template -- editing an item starts its
    -- contention list over.

    local state = self.DB.ListState[listName]

    if state then

        local remainingCopy = {}

        for _, candidate in ipairs(candidates) do

            table.insert(remainingCopy, {
                Type = candidate.Type,
                Value = candidate.Value,
                Spec = candidate.Spec,
            })

        end

        state.Remaining[itemID] = remainingCopy
        state.WonLog[itemID] = nil

    end

    return true

end

function ImpLoot.LootCouncil:RemoveItem(listName, itemID)

    local list = self.DB.Lists[listName]

    if not list or not list.Items[itemID] then
        return false
    end

    list.Items[itemID] = nil

    local state = self.DB.ListState[listName]

    if state then

        state.Remaining[itemID] = nil
        state.WonLog[itemID] = nil

    end

    return true

end

function ImpLoot.LootCouncil:GetItem(listName, itemID)

    local list = self.DB.Lists[listName]

    if not list then
        return nil
    end

    return list.Items[itemID]

end

function ImpLoot.LootCouncil:IsCouncilItem(listName, itemID)
    return self:GetItem(listName, itemID) ~= nil
end

-------------------------------------------------
-- Remaining Candidates (Working State)
--
-- Falls back to a fresh copy of the template if
-- this item's working state hasn't been touched yet
-- this session (e.g. right after loading a list).
-------------------------------------------------

function ImpLoot.LootCouncil:GetRemainingCandidates(listName, itemID)

    local state = self.DB.ListState[listName]
    local item = self:GetItem(listName, itemID)

    if not state or not item then
        return {}
    end

    if not state.Remaining[itemID] then

        local remainingCopy = {}

        for _, candidate in ipairs(item.Candidates) do

            table.insert(remainingCopy, {
                Type = candidate.Type,
                Value = candidate.Value,
                Spec = candidate.Spec,
            })

        end

        state.Remaining[itemID] = remainingCopy

    end

    return state.Remaining[itemID]

end

-------------------------------------------------
-- Record Win
--
-- Removes the FIRST matching candidate slot and
-- shifts everything below it up by one (table.remove
-- already does exactly this) -- so a name/class
-- appearing more than once only loses its earliest
-- slot, and everyone else moves up. winnerType is
-- "Player" or "Class"; winnerValue is the matched
-- name or class.
-------------------------------------------------

function ImpLoot.LootCouncil:RecordWin(listName, itemID, winnerType, winnerValue, winnerPlayerName)

    -------------------------------------------------
    -- Funnel Mode Never Removes The Candidate
    --
    -- The whole point of Funnel is that every drop
    -- keeps going to the same slot-1 candidate until
    -- the loot master manually reconfigures the item's
    -- candidates -- unlike Priority, a win here never
    -- shrinks the remaining list.
    -------------------------------------------------

    local item = self:GetItem(listName, itemID)

    if not (item and item.Mode == "Funnel") then

        local remaining = self:GetRemainingCandidates(listName, itemID)

        for i, candidate in ipairs(remaining) do

            if candidate.Type == winnerType and candidate.Value == winnerValue then

                table.remove(remaining, i)

                break

            end

        end

    end

    local state = self.DB.ListState[listName]

    if state then

        state.WonLog[itemID] = state.WonLog[itemID] or {}

        table.insert(state.WonLog[itemID], {
            Winner = winnerPlayerName or winnerValue,
            MatchedType = winnerType,
            MatchedValue = winnerValue,
        })

    end

end

-------------------------------------------------
-- Record Class Slot Win
--
-- A Class slot ("Any Warrior") covers every player of
-- that class, so one win doesn't remove it -- it only
-- logs who got the item. The slot is removed once every
-- player of that class in the raid has one (see
-- LootMaster:RecordWinForExclusion) or the loot master
-- skips it (RemoveCandidate).
-------------------------------------------------

function ImpLoot.LootCouncil:RecordClassSlotWin(listName, itemID, className, playerName)

    local state = self.DB.ListState[listName]

    if not state then
        return
    end

    state.WonLog[itemID] = state.WonLog[itemID] or {}

    table.insert(state.WonLog[itemID], {
        Winner = playerName,
        MatchedType = "Class",
        MatchedValue = className,
    })

end

-------------------------------------------------
-- Remove Candidate
--
-- Drops the first remaining slot matching this type and
-- value; everyone below moves up. Only touches this
-- raid's working state, never the saved list (Clear Raid
-- History restores it).
-------------------------------------------------

function ImpLoot.LootCouncil:RemoveCandidate(listName, itemID, candidateType, value)

    local remaining = self:GetRemainingCandidates(listName, itemID)

    for i, candidate in ipairs(remaining) do

        if candidate.Type == candidateType and candidate.Value == value then
            table.remove(remaining, i)
            return true
        end

    end

    return false

end

-------------------------------------------------
-- Get Winners
--
-- Set of short names (no realm) who have already
-- received this item from this list this raid.
-------------------------------------------------

function ImpLoot.LootCouncil:GetWinners(listName, itemID)

    local winners = {}

    for _, won in ipairs(self:GetWonLog(listName, itemID)) do

        if won.Winner then
            winners[won.Winner:match("^([^%-]+)") or won.Winner] = true
        end

    end

    return winners

end

function ImpLoot.LootCouncil:GetWonLog(listName, itemID)

    local state = self.DB.ListState[listName]

    if not state or not state.WonLog[itemID] then
        return {}
    end

    return state.WonLog[itemID]

end

-------------------------------------------------
-- Clear Raid History
--
-- Resets the ACTIVE list's working state (remaining
-- candidates + won log) back to its saved template --
-- never touches the template itself, and never
-- touches other saved lists.
-------------------------------------------------

function ImpLoot.LootCouncil:ClearRaidHistory(listName)

    listName = listName or self:GetActiveListName()

    if not listName or not self.DB.Lists[listName] then
        return false
    end

    self.DB.ListState[listName] = {
        Remaining = {},
        WonLog = {},
    }

    return true

end

-------------------------------------------------
-- Disenchanter Fallback List
--
-- Ordered {Name=...} entries. GetActiveDisenchanter
-- returns the first one who's actually in the raid,
-- given a roster (list of player names present).
-------------------------------------------------

function ImpLoot.LootCouncil:SetDisenchanters(names, listName)

    local list = self:GetListData(listName)

    if not list then
        return false
    end

    local entries = {}

    for _, name in ipairs(names) do

        if name and name ~= "" then
            table.insert(entries, { Name = name })
        end

    end

    list.Disenchanters = entries

    return true

end

function ImpLoot.LootCouncil:GetDisenchanters(listName)

    local list = self:GetListData(listName)

    return list and list.Disenchanters or {}

end

function ImpLoot.LootCouncil:IsDisenchanter(name, listName)

    for _, entry in ipairs(self:GetDisenchanters(listName)) do

        if ShortLower(entry.Name) == ShortLower(name) then
            return true
        end

    end

    return false

end

function ImpLoot.LootCouncil:AddDisenchanter(name, listName)

    local list = self:GetListData(listName)

    if not list or not name or name == "" or self:IsDisenchanter(name, listName) then
        return false
    end

    table.insert(list.Disenchanters, { Name = name })

    return true

end

function ImpLoot.LootCouncil:RemoveDisenchanter(name, listName)

    local list = self:GetListData(listName)

    if not list then
        return false
    end

    for i, entry in ipairs(list.Disenchanters) do

        if ShortLower(entry.Name) == ShortLower(name) then
            table.remove(list.Disenchanters, i)
            return true
        end

    end

    return false

end

-- The first of the ACTIVE list's disenchanters who's in
-- the raid, or nil (no active list: no disenchanter)
function ImpLoot.LootCouncil:GetActiveDisenchanter(rosterNames)

    local present = {}

    for _, name in ipairs(rosterNames or {}) do
        present[ShortLower(name)] = name
    end

    for _, entry in ipairs(self:GetDisenchanters()) do

        local inRaid = present[ShortLower(entry.Name)]

        if inRaid then
            return inRaid
        end

    end

    return nil

end

-------------------------------------------------
-- Populate Mode
--
-- "Add multiple items" workflow (Add Item): alt-click items in
-- the main window while this is active stages them
-- here instead of adding to a wishlist; committing
-- writes each staged item into the target list with
-- an empty candidate list, ready for the loot master
-- to fill in names back in the Loot Priority window.
-------------------------------------------------

function ImpLoot.LootCouncil:StartPopulateMode(listName)

    if not self.DB.Lists[listName] then
        return false
    end

    self.PopulateMode = true
    self.PopulateListName = listName
    self.StagedItems = {}

    return true

end

function ImpLoot.LootCouncil:StopPopulateMode()

    self.PopulateMode = false
    self.PopulateListName = nil
    self.StagedItems = {}

end

function ImpLoot.LootCouncil:IsPopulateModeActive()
    return self.PopulateMode == true
end

-------------------------------------------------
-- Add Staged Item
--
-- Deduplicated -- alt-clicking the same item twice
-- doesn't stage it twice.
-------------------------------------------------

function ImpLoot.LootCouncil:AddStagedItem(itemID, itemName)

    if not self.PopulateMode then
        return false
    end

    for _, entry in ipairs(self.StagedItems) do

        if entry.ItemID == itemID then
            return false
        end

    end

    table.insert(self.StagedItems, { ItemID = itemID, Name = itemName })

    return true

end

function ImpLoot.LootCouncil:GetStagedItems()
    return self.StagedItems
end

-------------------------------------------------
-- Commit Staged Items
--
-- Writes each staged item into the target list with
-- an empty candidate list. Does not overwrite an item
-- that's already configured in the list (re-staging
-- something that already has candidates set would
-- otherwise wipe them).
-------------------------------------------------

function ImpLoot.LootCouncil:CommitStagedItems()

    if not self.PopulateMode or not self.PopulateListName then
        return 0
    end

    local list = self.DB.Lists[self.PopulateListName]

    if not list then
        return 0
    end

    local added = 0

    for _, entry in ipairs(self.StagedItems) do

        if not list.Items[entry.ItemID] then

            self:SetItem(self.PopulateListName, entry.ItemID, entry.Name, "Priority", {})
            added = added + 1

        end

    end

    self:StopPopulateMode()

    return added

end

-------------------------------------------------
-- Text Import / Export
--
-- A compact, hand-typeable/shareable alternative to
-- Add Item -- lets a priority list be built
-- (or shared with another guild/officer) entirely
-- outside the game. Format, one item per ";":
--
--   itemID, mode, candidate, candidate, ...;
--
-- e.g. "45533, prio, Moradladdy, hunter;" -- Dark Edge
-- of Depravity, Priority mode, candidate 1 is the
-- player Moradladdy, candidate 2 is any Hunter.
--
-- mode is one of: prio=Priority, vote=Vote, fun=Funnel,
-- pres=Preselected. Item IDs (not names) are used
-- deliberately, since the same item name can exist under
-- different IDs across Normal/Heroic.
--
-- A class candidate can optionally carry a spec label,
-- written as "class-spec" (e.g. "mage-fire", "hunter-
-- beast mastery"): "45533, prio, mage-fire;" means any
-- Mage specifically labeled Fire spec. Spec is
-- descriptive only (see CLASS_SPECS in Core.lua), same
-- as it is everywhere else in the addon.
-------------------------------------------------

local IMPORT_MODE_ABBREVIATIONS = {
    prio = "Priority",
    vote = "Vote",
    fun = "Funnel",
    pres = "Preselected",
}

local EXPORT_MODE_ABBREVIATIONS = {
    Priority = "prio",
    Vote = "vote",
    Funnel = "fun",
    Preselected = "pres",
}

local CLASS_LOOKUP = {}

for _, className in ipairs(ImpLoot.CLASS_ORDER) do
    CLASS_LOOKUP[string.lower(className)] = className
end

CLASS_LOOKUP["deathknight"] = "Death Knight"
CLASS_LOOKUP["dk"] = "Death Knight"

local function TrimText(value)

    value = string.gsub(value, "^%s+", "")
    value = string.gsub(value, "%s+$", "")

    return value

end

-------------------------------------------------
-- Resolve Candidate Token
--
-- A bare word with no type marker in the import
-- string -- resolved to a Class candidate if it
-- matches a known class name (case-insensitive,
-- including "dk"/"deathknight" for Death Knight),
-- otherwise treated as a player name. The one
-- unavoidable edge case: a player literally named
-- e.g. "Hunter" would resolve as the class instead --
-- rare enough not to be worth a structural fix, but
-- worth documenting.
--
-- A class can optionally carry a spec, written as
-- "class-spec" (e.g. "mage-fire", "hunter-beast
-- mastery" -- the spec half can still contain spaces
-- of its own, since only the FIRST hyphen is treated
-- as the class/spec separator). Only actually resolved
-- as class-spec if the part before the hyphen matches a
-- known class AND the part after matches one of that
-- class's specs -- otherwise falls through to being
-- read as a plain player name, so a player name that
-- happens to include a hyphen (e.g. a pasted
-- "Name-Realm") isn't misread as a spec label.
-------------------------------------------------

local function ResolveCandidateToken(token)

    local hyphenPos = token:find("-", 1, true)

    if hyphenPos then

        local classPart = TrimText(token:sub(1, hyphenPos - 1))
        local specPart = TrimText(token:sub(hyphenPos + 1))

        local className = CLASS_LOOKUP[string.lower(classPart)]

        if className then

            local specs = ImpLoot.CLASS_SPECS[className]

            if specs then

                for _, specName in ipairs(specs) do

                    if string.lower(specName) == string.lower(specPart) then
                        return { Type = "Class", Value = className, Spec = specName }
                    end

                end

            end

        end

    end

    local className = CLASS_LOOKUP[string.lower(token)]

    if className then
        return { Type = "Class", Value = className }
    end

    return { Type = "Player", Value = token }

end

-------------------------------------------------
-- Parse Import Text
--
-- Returns two values: a list of successfully parsed
-- entries ({ItemID, ItemName, Mode, Candidates}), and
-- a list of warning strings for any skipped entries
-- (unknown item ID, unrecognized mode, or too many
-- candidates) -- never aborts the whole import over
-- one bad line.
-------------------------------------------------

function ImpLoot.LootCouncil:ParseImportText(text)

    local entries = {}
    local warnings = {}

    if not text then
        return entries, warnings
    end

    for rawItemEntry in string.gmatch(text, "[^;]+") do

        local itemEntry = TrimText(rawItemEntry)

        if itemEntry ~= "" then

            local fields = {}

            for field in string.gmatch(itemEntry, "[^,]+") do
                table.insert(fields, TrimText(field))
            end

            local itemIDText = fields[1]
            local modeText = fields[2]

            local itemID = itemIDText and tonumber(itemIDText)

            if not itemID then

                table.insert(warnings, "Skipped \"" .. itemEntry .. "\": couldn't read an item ID.")

            else

                local item = ImpLoot.Database:FindItemByID(itemID)

                if not item then

                    table.insert(warnings, "Skipped item " .. itemID .. ": not a known item ID.")

                else

                    local mode = modeText and IMPORT_MODE_ABBREVIATIONS[string.lower(modeText)]

                    if not mode then

                        table.insert(warnings,
                            "Skipped item " .. itemID .. ": unrecognized mode \"" ..
                            tostring(modeText) .. "\" (use prio/vote/fun/pres).")

                    else

                        local candidateCount = #fields - 2

                        if candidateCount > 5 then

                            table.insert(warnings,
                                "Skipped item " .. itemID .. ": " .. candidateCount ..
                                " candidates listed, but only 5 are supported.")

                        else

                            local candidates = {}

                            for i = 3, #fields do
                                table.insert(candidates, ResolveCandidateToken(fields[i]))
                            end

                            table.insert(entries, {
                                ItemID = itemID,
                                ItemName = item.Name,
                                Mode = mode,
                                Candidates = candidates,
                            })

                        end

                    end

                end

            end

        end

    end

    return entries, warnings

end

-------------------------------------------------
-- Import Text To List
--
-- Parses and writes straight into the given list,
-- same end result as Add Item would have
-- produced. Returns the count actually imported plus
-- the same warnings list from ParseImportText.
-------------------------------------------------

function ImpLoot.LootCouncil:ImportTextToList(listName, text)

    if not self.DB.Lists[listName] then
        return 0, { "No such priority list: " .. tostring(listName) }
    end

    local entries, warnings = self:ParseImportText(text)

    local imported = 0

    for _, entry in ipairs(entries) do

        local ok = self:SetItem(listName, entry.ItemID, entry.ItemName, entry.Mode, entry.Candidates)

        if ok then
            imported = imported + 1
        end

    end

    return imported, warnings

end

-------------------------------------------------
-- Export List To Text
--
-- The inverse of ImportTextToList -- one line per
-- item, same format the import expects.
-------------------------------------------------

function ImpLoot.LootCouncil:ExportListToText(listName)

    local list = self.DB.Lists[listName]

    if not list then
        return ""
    end

    local lines = {}

    for itemID, item in pairs(list.Items) do

        local modeAbbrev = EXPORT_MODE_ABBREVIATIONS[item.Mode] or "prio"

        local parts = { tostring(itemID), modeAbbrev }

        for _, candidate in ipairs(item.Candidates or {}) do

            local token = candidate.Value

            if candidate.Type == "Class" and candidate.Spec then
                token = token .. "-" .. candidate.Spec
            end

            table.insert(parts, token)

        end

        table.insert(lines, table.concat(parts, ", ") .. ";")

    end

    table.sort(lines)

    return table.concat(lines, "\n")

end
