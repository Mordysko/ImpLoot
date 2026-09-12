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
-- Council Members
-------------------------------------------------

function ImpLoot.LootCouncil:AddMember(name)

    if not name or name == "" then
        return false
    end

    for _, existing in ipairs(self.DB.Members) do

        if existing == name then
            return false
        end

    end

    table.insert(self.DB.Members, name)

    return true

end

function ImpLoot.LootCouncil:RemoveMember(name)

    for i, existing in ipairs(self.DB.Members) do

        if existing == name then

            table.remove(self.DB.Members, i)

            return true

        end

    end

    return false

end

function ImpLoot.LootCouncil:GetMembers()
    return self.DB.Members
end

function ImpLoot.LootCouncil:IsMember(name)

    for _, existing in ipairs(self.DB.Members) do

        if existing == name then
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

    self.DB.Lists[listName] = { Items = {} }

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

function ImpLoot.LootCouncil:SetActiveList(listName)

    if not self.DB.Lists[listName] then
        return false
    end

    self.DB.ActiveList = listName

    return true

end

function ImpLoot.LootCouncil:GetActiveListName()
    return self.DB.ActiveList
end

-------------------------------------------------
-- Items Within A List
--
-- candidates is up to 5 entries, each either
-- { Type = "Player", Value = "Rad" } or
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
                Tier = candidate.Tier,
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
                Tier = candidate.Tier,
            })

        end

        state.Remaining[itemID] = remainingCopy

    end

    return state.Remaining[itemID]

end

-------------------------------------------------
-- Get Current Tier Candidates
--
-- Filters GetRemainingCandidates down to just the
-- lowest tier that still has anyone left in it -- the
-- set of candidates actually eligible right now. Linked
-- slots ("Prio 1 = Prio 2 = Prio 3") share a tier and
-- are all eligible together; the addon only moves on to
-- the next (unlinked) tier once every candidate in the
-- current one has won.
--
-- Legacy data (saved before this feature existed) has no
-- Tier field at all -- each such candidate is treated as
-- its own tier, matching the old strict "one at a time,
-- in order" behavior exactly.
-------------------------------------------------

function ImpLoot.LootCouncil:GetCurrentTierCandidates(listName, itemID)

    local remaining = self:GetRemainingCandidates(listName, itemID)

    if #remaining == 0 then
        return {}
    end

    local lowestTier = nil

    for i, candidate in ipairs(remaining) do

        local tier = candidate.Tier or i

        if not lowestTier or tier < lowestTier then
            lowestTier = tier
        end

    end

    local currentTier = {}

    for i, candidate in ipairs(remaining) do

        local tier = candidate.Tier or i

        if tier == lowestTier then
            table.insert(currentTier, candidate)
        end

    end

    return currentTier

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

    listName = listName or self.DB.ActiveList

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

function ImpLoot.LootCouncil:SetDisenchanters(names)

    local list = {}

    for _, name in ipairs(names) do

        if name and name ~= "" then
            table.insert(list, { Name = name })
        end

    end

    self.DB.Disenchanters = list

end

function ImpLoot.LootCouncil:GetDisenchanters()
    return self.DB.Disenchanters
end

function ImpLoot.LootCouncil:GetActiveDisenchanter(rosterNames)

    local present = {}

    for _, name in ipairs(rosterNames or {}) do
        present[name] = true
    end

    for _, entry in ipairs(self.DB.Disenchanters) do

        if present[entry.Name] then
            return entry.Name
        end

    end

    return nil

end

-------------------------------------------------
-- Populate Mode
--
-- "Populate Item List" workflow: alt-click items in
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
-- Populate Item List -- lets a priority list be built
-- (or shared with another guild/officer) entirely
-- outside the game. Format, one item per ";":
--
--   itemID, mode, candidate, candidate, ...;
--
-- e.g. "45533, prio, Mordality, hunter;" -- Dark Edge
-- of Depravity, Priority mode, candidate 1 is the
-- player Mordality, candidate 2 is any Hunter.
--
-- mode is one of: prio=Priority, vote=Vote, fun=Funnel,
-- pres=Preselected. Item IDs (not names) are used
-- deliberately, since the same item name can exist under
-- different IDs across Normal/Heroic.
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
-------------------------------------------------

local function ResolveCandidateToken(token)

    local className = CLASS_LOOKUP[string.lower(token)]

    if className then
        return { Type = "Class", Value = className }
    end

    return { Type = "Player", Value = token }

end

local function TrimText(value)

    value = string.gsub(value, "^%s+", "")
    value = string.gsub(value, "%s+$", "")

    return value

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
-- same end result as Populate Item List would have
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
            table.insert(parts, candidate.Value)
        end

        table.insert(lines, table.concat(parts, ", ") .. ";")

    end

    table.sort(lines)

    return table.concat(lines, "\n")

end
