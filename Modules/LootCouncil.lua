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
