-------------------------------------------------
-- Compare Module
--
-- Backing data for the compare drawer -- two item
-- slots (1 and 2), each of which can be locked to
-- prevent it being replaced or removed. Also works
-- out the stat difference between the two.
-------------------------------------------------

ImpLoot.Compare = {}

-------------------------------------------------
-- Compatible Weapon Slot Groups
--
-- Slots in the same group can be compared with each
-- other even though the Slot string differs (e.g. a
-- One-Hand weapon against a Two-Hand weapon). Any
-- slot not listed in a group only compares against
-- its own exact slot.
-------------------------------------------------

local COMPATIBLE_SLOT_GROUPS = {

    { "Main Hand", "Two-Hand", "One-Hand" },
    { "Off Hand", "One-Hand" },

}

-------------------------------------------------
-- Compatible Ranged Weapon Types
--
-- The database only tags these as Slot = "Ranged",
-- so telling a Bow from a Wand needs the live
-- itemSubType from the item cache.
-------------------------------------------------

local COMPATIBLE_RANGED_SUBTYPES = {
    "Bows",
    "Guns",
    "Thrown",
    "Crossbows",
}

-------------------------------------------------
-- Primary Stats
--
-- Shown plain on a tooltip ("+81 Intellect"), with
-- no "Equip:" prefix -- unlike the secondary/tertiary
-- combat ratings (Crit, Haste, Attack Power, Spell
-- Power, Armor Penetration, etc.), which always are.
-- Used to order the diff list to match that.
-------------------------------------------------

local PRIMARY_STAT_KEYS = {
    ITEM_MOD_STRENGTH_SHORT = true,
    ITEM_MOD_AGILITY_SHORT = true,
    ITEM_MOD_STAMINA_SHORT = true,
    ITEM_MOD_INTELLECT_SHORT = true,
    ITEM_MOD_SPIRIT_SHORT = true,
}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.Compare:Initialize()

    self.Slots = {

        [1] = {
            ItemID = nil,
            Locked = false,
        },

        [2] = {
            ItemID = nil,
            Locked = false,
        },

    }

end

-------------------------------------------------
-- Get Slot
-------------------------------------------------

function ImpLoot.Compare:GetSlot(index)

    if not self.Slots then
        return nil
    end

    return self.Slots[index]

end

-------------------------------------------------
-- Is Equippable
--
-- Mounts and tier tokens aren't gear -- there's
-- nothing to stat-compare, so they're not eligible
-- for the compare slots (they can still go on a
-- wishlist, just not in here).
-------------------------------------------------

function ImpLoot.Compare:IsEquippable(item)

    if not item then
        return false
    end

    if item.Slot == "Mount" then
        return false
    end

    if item.Slot == "Tier Token" then
        return false
    end

    if item.Slot == "Bag" then
        return false
    end

    return true

end

-------------------------------------------------
-- Slots Are Compatible
--
-- Whether two items (by itemID) can sit in the
-- compare drawer together -- exact slot match, or
-- one of the compatible weapon groupings above.
-------------------------------------------------

function ImpLoot.Compare:SlotsAreCompatible(itemIDA, itemIDB)

    local itemA = ImpLoot.Database:FindItemByID(itemIDA)
    local itemB = ImpLoot.Database:FindItemByID(itemIDB)

    if not itemA or not itemB then
        return false
    end

    local slotA = itemA.Slot
    local slotB = itemB.Slot

    -------------------------------------------------
    -- Ranged: Go By Actual Weapon Type
    --
    -- The database only knows "Ranged" -- Bows, Guns,
    -- Thrown, Wands, and Crossbows are indistinguishable
    -- there, so this checks the live itemSubType instead.
    -------------------------------------------------

    if slotA == "Ranged" and slotB == "Ranged" then

        local cachedA = ImpLoot.ItemCache:GetItem(itemIDA)
        local cachedB = ImpLoot.ItemCache:GetItem(itemIDB)

        local subA = cachedA and cachedA.SubType
        local subB = cachedB and cachedB.SubType

        -------------------------------------------------
        -- Not Cached Yet -- Don't Block On It
        -------------------------------------------------

        if not subA or not subB then
            return true
        end

        if subA == subB then
            return true
        end

        local inGroupA, inGroupB = false, false

        for _, subType in ipairs(COMPATIBLE_RANGED_SUBTYPES) do

            if subType == subA then
                inGroupA = true
            end

            if subType == subB then
                inGroupB = true
            end

        end

        return inGroupA and inGroupB

    end

    -------------------------------------------------
    -- Exact Match
    -------------------------------------------------

    if slotA == slotB then
        return true
    end

    -------------------------------------------------
    -- Compatible Melee Slot Groups
    -------------------------------------------------

    for _, group in ipairs(COMPATIBLE_SLOT_GROUPS) do

        local inA, inB = false, false

        for _, groupSlot in ipairs(group) do

            if groupSlot == slotA then
                inA = true
            end

            if groupSlot == slotB then
                inB = true
            end

        end

        if inA and inB then
            return true
        end

    end

    return false

end

-------------------------------------------------
-- Set Item
--
-- Fails (returns false, reason) if the slot is
-- locked, the item isn't equippable gear, or the
-- item doesn't share a compatible slot with
-- whatever's already sitting in the other slot.
-------------------------------------------------

function ImpLoot.Compare:SetItem(index, itemID)

    local slot = self:GetSlot(index)

    if not slot then
        return false, "No such slot."
    end

    if slot.Locked then
        return false, "That slot is locked."
    end

    local item = ImpLoot.Database:FindItemByID(itemID)

    if not self:IsEquippable(item) then
        return false, "Only equippable loot can be compared."
    end

    -------------------------------------------------
    -- Must Be Slot-Compatible With The Other Slot
    -------------------------------------------------

    local otherIndex = 2

    if index == 2 then
        otherIndex = 1
    end

    local other = self:GetSlot(otherIndex)

    if other and other.ItemID then

        if not self:SlotsAreCompatible(itemID, other.ItemID) then
            return false, "Only items of the same slot can be compared."
        end

    end

    slot.ItemID = itemID

    self:NotifyChanged()

    return true

end

-------------------------------------------------
-- Toggle Lock
-------------------------------------------------

function ImpLoot.Compare:ToggleLock(index)

    local slot = self:GetSlot(index)

    if not slot then
        return
    end

    if not slot.ItemID then
        return
    end

    slot.Locked = not slot.Locked

    self:NotifyChanged()

end

-------------------------------------------------
-- Remove Item
--
-- Fails (returns false) if the slot is locked.
-------------------------------------------------

function ImpLoot.Compare:RemoveItem(index)

    local slot = self:GetSlot(index)

    if not slot then
        return false
    end

    if slot.Locked then
        return false
    end

    slot.ItemID = nil

    self:NotifyChanged()

    return true

end

-------------------------------------------------
-- Get Diff
--
-- Stat differences you'd see replacing Slot 1's
-- item with Slot 2's item. Returns a list of
-- { Label = ..., Delta = ... }, positive deltas
-- being an increase, sorted alphabetically by
-- label. Empty until both slots have an item WoW
-- has fully cached the data for.
-------------------------------------------------

function ImpLoot.Compare:GetDiff()

    local diffs = {}

    local slot1 = self:GetSlot(1)
    local slot2 = self:GetSlot(2)

    if not slot1 or not slot1.ItemID
    or not slot2 or not slot2.ItemID then

        return diffs

    end

    local cached1 = ImpLoot.ItemCache:GetItem(slot1.ItemID)
    local cached2 = ImpLoot.ItemCache:GetItem(slot2.ItemID)

    if not cached1 or not cached1.Link
    or not cached2 or not cached2.Link then

        return diffs

    end

    local stats1 = GetItemStats(cached1.Link) or {}
    local stats2 = GetItemStats(cached2.Link) or {}

    -------------------------------------------------
    -- Stats We Don't Show
    --
    -- DPS is derived from a weapon's own damage/speed,
    -- not a stat you'd stack -- not useful to diff.
    -------------------------------------------------

    local excluded = {
        ITEM_MOD_DAMAGE_PER_SECOND_SHORT = true,
    }

    -------------------------------------------------
    -- Union Of Every Stat Key Seen
    -------------------------------------------------

    local seen = {}

    for key in pairs(stats1) do

        if not excluded[key] then
            seen[key] = true
        end

    end

    for key in pairs(stats2) do

        if not excluded[key] then
            seen[key] = true
        end

    end

    -------------------------------------------------
    -- Work Out The Non-Zero Differences
    -------------------------------------------------

    for key in pairs(seen) do

        local before = stats1[key] or 0
        local after = stats2[key] or 0

        local delta = after - before

        if delta ~= 0 then

            -------------------------------------------------
            -- Category, For Ordering
            --
            -- Matches tooltip order: Armor, then the
            -- plain primary stats, then sockets, then
            -- the secondary/tertiary "Equip:" ratings.
            -- Trinket Equip/Use effect text is added
            -- separately by the caller, after this list.
            -------------------------------------------------

            local category = 4

            if key == "RESISTANCE0_NAME" then
                category = 1
            elseif PRIMARY_STAT_KEYS[key] then
                category = 2
            elseif key:find("^EMPTY_SOCKET") then
                category = 3
            end

            table.insert(diffs, {
                Label = _G[key] or key,
                Delta = delta,
                Category = category,
            })

        end

    end

    -------------------------------------------------
    -- Armor, Primary Stats, Sockets, Then Ratings
    -------------------------------------------------

    table.sort(diffs, function(a, b)

        if a.Category ~= b.Category then
            return a.Category < b.Category
        end

        return a.Label < b.Label

    end)

    return diffs

end

-------------------------------------------------
-- Effect Text Scanning Tooltip
--
-- Trinkets' on-equip/on-use effects aren't part of
-- GetItemStats -- only the tooltip has them, so a
-- hidden tooltip is scanned for those specific lines.
-------------------------------------------------

local effectScanTooltip = CreateFrame(
    "GameTooltip",
    "ImpLootCompareScanTooltip",
    UIParent,
    "GameTooltipTemplate"
)

effectScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")

-------------------------------------------------
-- Get Item Effect Text
--
-- Returns the item's "Equip:" / "Use:" / "Chance
-- on ..." tooltip lines joined with newlines, or
-- nil if there aren't any (or the item isn't
-- cached yet).
-------------------------------------------------

function ImpLoot.Compare:GetItemEffectText(itemID)

    local cached = ImpLoot.ItemCache:GetItem(itemID)

    if not cached or not cached.Link then
        return nil
    end

    effectScanTooltip:ClearLines()
    effectScanTooltip:SetHyperlink(cached.Link)

    local lines = {}

    for i = 2, effectScanTooltip:NumLines() do

        local fontString = _G["ImpLootCompareScanTooltipTextLeft" .. i]

        if fontString then

            local text = fontString:GetText()

            if text
            and (
                text:find("^Equip:")
                or text:find("^Use:")
                or text:find("^Chance on hit:")
                or text:find("^Chance on parry:")
                or text:find("^Chance on dodge:")
                or text:find("^Chance on block:")
            ) then

                table.insert(lines, text)

            end

        end

    end

    if #lines == 0 then
        return nil
    end

    return table.concat(lines, "\n")

end

-------------------------------------------------
-- Notify Changed
-------------------------------------------------

function ImpLoot.Compare:NotifyChanged()

    ImpLoot.Events:Fire("CompareChanged")

end
