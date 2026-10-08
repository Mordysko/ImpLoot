-------------------------------------------------
-- Soft Reserve: Manual Editing
--
-- Lets the loot master add, change and remove reserves
-- by hand, without a new CSV import -- a late joiner, a
-- typo'd item, a change of mind.
--
-- All editing happens on a DRAFT: a plain copy of the
-- reserves grouped by player (BuildDraft). Nothing in the
-- real reserve list changes until CommitDraft, so the UI
-- can add/edit/remove freely and the loot master is only
-- asked to reload once, when they Save -- not after every
-- individual player. Closing without saving just drops
-- the draft.
--
-- A draft is a list of players:
--   { Player, Class, Spec, Note,
--     Items = { { ItemID, ItemName, Boss, Plus, Date }, ... } }
-------------------------------------------------

local SoftReserve = ImpLoot.SoftReserve

-------------------------------------------------
-- Classes And Specs
--
-- Same class / class-spec choices softres.it offers.
-- Spec is cosmetic (the card shows it in the class's
-- colour); the class is what actually matters.
-------------------------------------------------

SoftReserve.ClassOrder = {
    "Death Knight", "Druid", "Hunter", "Mage", "Paladin",
    "Priest", "Rogue", "Shaman", "Warlock", "Warrior",
}

SoftReserve.ClassSpecs = {
    ["Death Knight"] = { "Blood", "Frost", "Unholy" },
    ["Druid"]        = { "Balance", "Feral Combat", "Restoration" },
    ["Hunter"]       = { "Beast Mastery", "Marksmanship", "Survival" },
    ["Mage"]         = { "Arcane", "Fire", "Frost" },
    ["Paladin"]      = { "Holy", "Protection", "Retribution" },
    ["Priest"]       = { "Discipline", "Holy", "Shadow" },
    ["Rogue"]        = { "Assassination", "Combat", "Subtlety" },
    ["Shaman"]       = { "Elemental", "Enhancement", "Restoration" },
    ["Warlock"]      = { "Affliction", "Demonology", "Destruction" },
    ["Warrior"]      = { "Arms", "Fury", "Protection" },
}

-- Difficulty labels shown in the form -> the keys the
-- loot data uses in each item's AvailableIn.
SoftReserve.DifficultyChoices = {
    { Label = "10 Normal", Key = "10" },
    { Label = "25 Normal", Key = "25" },
    { Label = "10 Heroic", Key = "10 Heroic" },
    { Label = "25 Heroic", Key = "25 Heroic" },
}

-------------------------------------------------
-- Max Reserves Per Player
--
-- Set per guild on softres.it each week, so it's a
-- setting here too. 0 means no limit.
-------------------------------------------------

SoftReserve.DefaultMaxReserves = 3

function SoftReserve:GetMaxReserves()

    local settings = self.State and self.State.Settings
    local value = settings and settings.MaxReservesPerPlayer

    if value == nil then
        return self.DefaultMaxReserves
    end

    return value

end

-------------------------------------------------
-- Normalize Name
--
-- Trims whitespace, and capitalises plain-letter names the
-- way WoW does ("mordysko" -> "Mordysko"). Names with
-- accents/other characters are only trimmed, rather than
-- risk mangling them.
-------------------------------------------------

function SoftReserve:NormalizeName(name)

    name = tostring(name or "")
    name = name:gsub("^%s+", "")
    name = name:gsub("%s+$", "")

    if name:match("^%a+$") then
        name = name:sub(1, 1):upper() .. name:sub(2):lower()
    end

    return name

end

-------------------------------------------------
-- Build Draft
--
-- One entry per player, sorted by name, each player's
-- items sorted by name so the order is stable (the
-- reserves table itself has no order).
-------------------------------------------------

function SoftReserve:BuildDraft()

    local byName = {}
    local draft = {}

    local reserves = self.State and self.State.Reserves or {}

    for itemID, rows in pairs(reserves) do

        for _, row in ipairs(rows) do

            local player = byName[row.Player]

            if not player then

                player = {
                    Player = row.Player,
                    Class = row.Class,
                    Spec = row.Spec,
                    Note = row.Note,
                    Items = {},
                }

                byName[row.Player] = player
                table.insert(draft, player)

            end

            table.insert(player.Items, {
                ItemID = itemID,
                ItemName = row.ItemName,
                Boss = row.Boss,
                Plus = row.Plus,
                Date = row.Date,
            })

        end

    end

    table.sort(draft, function(a, b)
        return a.Player < b.Player
    end)

    for _, player in ipairs(draft) do

        table.sort(player.Items, function(a, b)

            local nameA = a.ItemName or ""
            local nameB = b.ItemName or ""

            if nameA ~= nameB then
                return nameA < nameB
            end

            return a.ItemID < b.ItemID

        end)

    end

    return draft

end

-------------------------------------------------
-- Validate Player Entry
--
-- `entry` is the player as filled in on the form;
-- `existing` is the draft player being edited (nil when
-- adding), so a player isn't flagged as clashing with
-- themselves. Returns true, or false and a message to
-- show the loot master.
-------------------------------------------------

function SoftReserve:ValidatePlayerEntry(draft, entry, existing)

    if not entry.Player or entry.Player == "" then
        return false, "Enter a player name."
    end

    if not entry.Class or entry.Class == "" then
        return false, "Choose a class."
    end

    if #entry.Items == 0 then
        return false, "Add at least one item."
    end

    local max = self:GetMaxReserves()

    if max > 0 and #entry.Items > max then
        return false, "Too many items -- the limit is " .. max .. " per player."
    end

    local settings = self.State and self.State.Settings

    if settings and settings.AllowMultipleReserves == false then

        local seen = {}

        for _, item in ipairs(entry.Items) do

            if seen[item.ItemID] then
                return false, (item.ItemName or "An item")
                    .. " is reserved twice, and reserving the same item more than once is turned off."
            end

            seen[item.ItemID] = true

        end

    end

    local wanted = entry.Player:lower()

    for _, other in ipairs(draft) do

        if other ~= existing and other.Player:lower() == wanted then
            return false, other.Player .. " already has reserves -- use their Edit button instead."
        end

    end

    return true

end

-------------------------------------------------
-- Draft Set / Remove Player
-------------------------------------------------

-- Replace `existing` with `entry`, or add `entry` when
-- `existing` is nil. Keeps the draft sorted by name.
function SoftReserve:DraftSetPlayer(draft, existing, entry)

    if existing then

        for i, player in ipairs(draft) do

            if player == existing then
                draft[i] = entry
                break
            end

        end

    else
        table.insert(draft, entry)
    end

    table.sort(draft, function(a, b)
        return a.Player < b.Player
    end)

end

function SoftReserve:DraftRemovePlayer(draft, existing)

    for i, player in ipairs(draft) do

        if player == existing then
            table.remove(draft, i)
            return true
        end

    end

    return false

end

-------------------------------------------------
-- Commit Draft
--
-- Replaces the real reserve list with the draft.
-- Remaining slots are cleared so every item rebuilds from
-- the new list (same reason Import does -- the cache would
-- otherwise keep showing the old reservers); WonLog is left
-- alone, it's this raid night's win history.
-------------------------------------------------

function SoftReserve:CommitDraft(draft)

    local reserves = {}
    local count = 0
    local today = date and date("%Y-%m-%d") or ""

    for _, player in ipairs(draft) do

        for _, item in ipairs(player.Items) do

            if not reserves[item.ItemID] then
                reserves[item.ItemID] = {}
            end

            table.insert(reserves[item.ItemID], {
                Player = player.Player,
                Class = player.Class,
                Spec = player.Spec or "",
                ItemName = item.ItemName,
                Boss = item.Boss or "",
                Note = player.Note or "",
                Plus = item.Plus or 0,
                Date = item.Date or today,
            })

            count = count + 1

        end

    end

    self.State.Reserves = reserves
    self.State.Remaining = {}
    self.State.EditedDate = date and date("%Y-%m-%d") or nil

    return count

end

-------------------------------------------------
-- Item Search (For The Form's Autocomplete)
--
-- The same search the loot panel uses, narrowed to one raid
-- and one difficulty. Each loot entry is a single
-- difficulty with its own item ID, so the ID that gets
-- stored is exactly the one softres.it would export for
-- that raid + difficulty.
-------------------------------------------------

function SoftReserve:GetItemIDForEntry(item, difficultyKey)

    if not item.IDs then
        return nil
    end

    if difficultyKey and difficultyKey:find("Heroic", 1, true) then
        return item.IDs.Heroic or item.IDs.Normal
    end

    return item.IDs.Normal or item.IDs.Heroic

end

-------------------------------------------------
-- Item Classes
--
-- Which classes can use an item, or nil when it isn't class-
-- restricted. Class-locked gear (tier pieces) carries a
-- Classes list. Tier tokens don't -- any class of a group
-- can turn one in -- so their group (Conqueror / Protector /
-- Vanquisher) comes from the name, whether it's worded
-- "Vanquisher's Mark of..." or "Mantle of the Wayward
-- Vanquisher". Only items flagged as tokens are read that
-- way, so an ordinary item that happens to share a word
-- is never mistaken for one.
-------------------------------------------------

function SoftReserve:GetItemClasses(item)

    if item.Classes and #item.Classes > 0 then
        return item.Classes
    end

    if (item.Token or item.Type == "TIER_TOKEN") and item.Name then

        local groups = ImpLoot.LootMaster and ImpLoot.LootMaster.TokenClassGroups

        for _, group in ipairs(groups or {}) do

            local word = group.Prefix:match("^(%a+)")

            if word and item.Name:find("%f[%a]" .. word .. "%f[%A]") then
                return group.Classes
            end

        end

    end

    return nil

end

function SoftReserve:CanClassUseItem(item, class)

    if not class or class == "" then
        return true
    end

    local classes = self:GetItemClasses(item)

    if not classes then
        return true
    end

    for _, allowed in ipairs(classes) do

        if allowed == class then
            return true
        end

    end

    return false

end

-- `class` (optional) hides anything that class can't use --
-- the other classes' tokens and class-locked gear.
function SoftReserve:SearchItems(text, raid, difficultyKey, limit, class)

    local out = {}
    local seen = {}

    if not text or #text < 2 then
        return out
    end

    for _, result in ipairs(ImpLoot.Database:Search(text, raid)) do

        local item = result.Item

        local inDifficulty = not difficultyKey
            or (item.AvailableIn and item.AvailableIn[difficultyKey])

        if inDifficulty and self:CanClassUseItem(item, class) then

            local itemID = self:GetItemIDForEntry(item, difficultyKey)

            if itemID and not seen[itemID] then

                seen[itemID] = true

                local bossName = (result.Boss and result.Boss.Name)
                    or (item.IsTrash and "Trash")
                    or (item.IsExtraDrops and "Extra drops")
                    or ""

                table.insert(out, {
                    ItemID = itemID,
                    ItemName = item.Name,
                    Boss = bossName,
                    Quality = item.Quality,
                })

                if limit and #out >= limit then
                    break
                end

            end

        end

    end

    return out

end

-------------------------------------------------
-- Guess Raid And Difficulty
--
-- Which raid and difficulty most of the current reserves
-- belong to -- the form's dropdowns start there, since the
-- loot master is nearly always adding to the same raid.
-- Returns the raid (or nil) and a difficulty key (or nil).
-------------------------------------------------

function SoftReserve:GuessRaidAndDifficulty(draft)

    local raidCounts, diffCounts = {}, {}
    local bestRaid, bestRaidCount = nil, 0
    local bestDiff, bestDiffCount = nil, 0

    for _, player in ipairs(draft) do

        for _, entry in ipairs(player.Items) do

            local item = ImpLoot.Database:FindItemByID(entry.ItemID)

            if item then

                if item.Raid then

                    raidCounts[item.Raid] = (raidCounts[item.Raid] or 0) + 1

                    if raidCounts[item.Raid] > bestRaidCount then
                        bestRaid, bestRaidCount = item.Raid, raidCounts[item.Raid]
                    end

                end

                if item.Difficulty then

                    diffCounts[item.Difficulty] = (diffCounts[item.Difficulty] or 0) + 1

                    if diffCounts[item.Difficulty] > bestDiffCount then
                        bestDiff, bestDiffCount = item.Difficulty, diffCounts[item.Difficulty]
                    end

                end

            end

        end

    end

    return bestRaid, bestDiff

end
