-------------------------------------------------
-- ImpLoot Database
--
-- Owns ImpLoot.Data (the list of registered raids) and
-- every read of it. Nothing outside this file should
-- touch ImpLoot.Data directly -- go through these
-- functions so there's exactly one place that knows
-- the raid/boss/loot table shape.
--
-- This file must load before anything in Data\Raids\,
-- since raid files call RegisterRaid() the moment they
-- load.
-------------------------------------------------

ImpLoot.Database = {}
ImpLoot.Data = ImpLoot.Data or {}

-------------------------------------------------
-- Register Raid
-------------------------------------------------

function ImpLoot.Database:RegisterRaid(raid)

    -------------------------------------------------
    -- Link Raid, Boss and Loot
    -------------------------------------------------

    for _, boss in ipairs(raid.Bosses) do

        boss.Raid = raid

        for _, item in ipairs(boss.Loot) do

            item.Boss = boss
            item.Raid = raid

            item.AvailableIn = item.AvailableIn or {}

            if item.Difficulty then
                item.AvailableIn[item.Difficulty] = true
            end

            if not next(item.AvailableIn) then
                item.AvailableIn["10"] = true
            end

        end

    end

    -------------------------------------------------
    -- Link Trash Loot
    -------------------------------------------------

    if raid.Trash then

        for _, item in ipairs(raid.Trash) do

            item.Raid = raid
            item.Boss = nil
            item.IsTrash = true

            item.AvailableIn = item.AvailableIn or {}

            if item.Difficulty then
                item.AvailableIn[item.Difficulty] = true
            end

            if not next(item.AvailableIn) then
                item.AvailableIn["10"] = true
            end

        end

    end

    -------------------------------------------------
    -- Store Raid
    -------------------------------------------------

    table.insert(ImpLoot.Data, raid)

end

-------------------------------------------------
-- Get All Raids
-------------------------------------------------

function ImpLoot.Database:GetRaids()
    return ImpLoot.Data
end

-------------------------------------------------
-- Release Order
--
-- For the raid dropdown -- unlisted raids (a future
-- addition not in this table yet) sort after
-- everything listed here, in registration order.
-------------------------------------------------

local RAID_RELEASE_ORDER = {
    ["Naxxramas"] = 1,
    ["Obsidian Sanctum"] = 2,
    ["The Eye of Eternity"] = 3,
    ["Vault of Archavon"] = 4,
    ["Ulduar"] = 5,
    ["Trial of the Crusader"] = 6,
    ["Onyxia's Lair"] = 7,
    ["Icecrown Citadel"] = 8,
    ["Ruby Sanctum"] = 9,
}

-------------------------------------------------
-- Get Raids In Release Order
-------------------------------------------------

function ImpLoot.Database:GetRaidsInReleaseOrder()

    local raids = {}

    for _, raid in ipairs(ImpLoot.Data) do
        table.insert(raids, raid)
    end

    table.sort(raids, function(a, b)

        local rankA = RAID_RELEASE_ORDER[a.Name] or 999
        local rankB = RAID_RELEASE_ORDER[b.Name] or 999

        if rankA ~= rankB then
            return rankA < rankB
        end

        return a.Name < b.Name

    end)

    return raids

end

-------------------------------------------------
-- Get Raid
-------------------------------------------------

function ImpLoot.Database:GetRaid(name)

    for _, raid in ipairs(ImpLoot.Data) do

        if raid.Name == name then
            return raid
        end

    end

    return nil

end

-------------------------------------------------
-- Get Boss
-------------------------------------------------

function ImpLoot.Database:GetBoss(raid, bossName)

    if not raid then
        return nil
    end

    for _, boss in ipairs(raid.Bosses) do

        if boss.Name == bossName then
            return boss
        end

    end

    return nil

end

-------------------------------------------------
-- Find Item By ID
-------------------------------------------------

function ImpLoot.Database:FindItemByID(itemID)

    for _, raid in ipairs(ImpLoot.Data) do

        for _, boss in ipairs(raid.Bosses) do

            for _, item in ipairs(boss.Loot) do

                if item.IDs then

                    if item.IDs.Normal == itemID
                    or item.IDs.Heroic == itemID then

                        return item

                    end

                end

            end

        end

        if raid.Trash then

            for _, item in ipairs(raid.Trash) do

                if item.IDs then

                    if item.IDs.Normal == itemID
                    or item.IDs.Heroic == itemID then

                        return item

                    end

                end

            end

        end

    end

    return nil

end

-------------------------------------------------
-- Search
-------------------------------------------------

function ImpLoot.Database:Search(text, raidFilter)

    local results = {}

    if not text or text == "" then
        return results
    end

    text = string.lower(text)

    -------------------------------------------------
    -- Trim Whitespace
    -------------------------------------------------

    local function Trim(value)

        value = string.gsub(
            value,
            "^%s+",
            ""
        )

        value = string.gsub(
            value,
            "%s+$",
            ""
        )

        return value

    end

    -------------------------------------------------
    -- Get Cached Item Information
    -------------------------------------------------

    local function GetCachedItem(item)

        if not item or not item.IDs then
            return nil
        end

        local itemID =
            item.IDs.Normal
            or item.IDs.Heroic

        if not itemID then
            return nil
        end

        if ImpLoot.ItemCache then

            return ImpLoot.ItemCache:GetItem(
                itemID
            )

        end

        return nil

    end

    -------------------------------------------------
    -- Does One Search Term Match This Item?
    -------------------------------------------------

    local function ItemMatches(item, term)

        term = Trim(term)

        if term == "" then
            return true
        end

        -------------------------------------------------
        -- Item Name
        -------------------------------------------------

        if item.Name then

            if string.find(
                string.lower(item.Name),
                term,
                1,
                true
            ) then

                return true

            end

        end

        -------------------------------------------------
        -- Database Slot
        -------------------------------------------------

        if item.Slot then

            if string.find(
                string.lower(item.Slot),
                term,
                1,
                true
            ) then

                return true

            end

        end

        -------------------------------------------------
        -- Cached Item Information
        -------------------------------------------------

        local cached =
            GetCachedItem(item)

        if cached then

            if cached.Type then

                if string.find(
                    string.lower(cached.Type),
                    term,
                    1,
                    true
                ) then

                    return true

                end

            end

            if cached.SubType then

                if string.find(
                    string.lower(cached.SubType),
                    term,
                    1,
                    true
                ) then

                    return true

                end

            end

            if cached.EquipLoc then

                if string.find(
                    string.lower(cached.EquipLoc),
                    term,
                    1,
                    true
                ) then

                    return true

                end

            end

        end

        return false

    end

    -------------------------------------------------
    -- OR Group Matching
    -------------------------------------------------

    local function MatchesOrGroup(item, group)

        local startPosition = 1

        while true do

            local orPosition =
                string.find(
                    group,
                    " or ",
                    startPosition,
                    true
                )

            if not orPosition then

                local term =
                    string.sub(
                        group,
                        startPosition
                    )

                if ItemMatches(item, term) then
                    return true
                end

                break

            end

            local term =
                string.sub(
                    group,
                    startPosition,
                    orPosition - 1
                )

            if ItemMatches(item, term) then
                return true
            end

            startPosition =
                orPosition + 4

        end

        return false

    end

    -------------------------------------------------
    -- Check One Item, Add It If It Matches
    -------------------------------------------------

    local function TryAddResult(item, raid, boss)

        local matches = true

        for group in string.gmatch(
            text,
            "[^,]+"
        ) do

            group = Trim(group)

            if group ~= ""
            and not MatchesOrGroup(
                item,
                group
            ) then

                matches = false
                break

            end

        end

        if matches then

            table.insert(
                results,
                {
                    Raid = raid,
                    Boss = boss,
                    Item = item,

                    -------------------------------------------------
                    -- Difficulty Information
                    -------------------------------------------------

                    Difficulty =
                        item.Difficulty,

                    AvailableIn =
                        item.AvailableIn,
                }
            )

        end

    end

    -------------------------------------------------
    -- Search Database
    -------------------------------------------------

    for _, raid in ipairs(ImpLoot.Data) do

        if not raidFilter or raid == raidFilter then

            for _, boss in ipairs(raid.Bosses) do

                for _, item in ipairs(boss.Loot) do
                    TryAddResult(item, raid, boss)
                end

            end

            if raid.Trash then

                for _, item in ipairs(raid.Trash) do
                    TryAddResult(item, raid, nil)
                end

            end

        end

    end

    return results

end