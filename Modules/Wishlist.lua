-------------------------------------------------
-- ImpLoot Wishlist Module
-------------------------------------------------

ImpLoot.Wishlist = {}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.Wishlist:Initialize()

    -------------------------------------------------
    -- Migrate Old-Format Wishlist Entries
    --
    -- Previously stored the full Raid/Boss database
    -- objects directly on each wishlist item -- a raid
    -- object contains every boss and every item for that
    -- raid (each of which links back to the raid again),
    -- so every wishlist item was saving the entire raid's
    -- data all over again. With even a handful of items,
    -- that's enough to blow past a single SavedVariables
    -- allocation on /reload ("memory allocation error:
    -- block too big"). Only the names were ever actually
    -- needed, so convert any old-format entries still
    -- carrying full objects down to just RaidName/BossName
    -- before anything else touches them.
    -------------------------------------------------

    if not ImpLootDB or not ImpLootDB.Players then
        return
    end

    for _, player in pairs(ImpLootDB.Players) do

        if player.Characters then

            for _, character in ipairs(player.Characters) do

                if character.Wishlists then

                    for _, wishlist in ipairs(character.Wishlists) do

                        if wishlist.Items then

                            for _, entry in ipairs(wishlist.Items) do

                                if type(entry.Raid) == "table" then

                                    entry.RaidName = entry.Raid.Name
                                    entry.Raid = nil

                                end

                                if type(entry.Boss) == "table" then

                                    entry.BossName = entry.Boss.Name
                                    entry.Boss = nil

                                end

                            end

                        end

                    end

                end

            end

        end

    end

end

-------------------------------------------------
-- Create Wishlist
-------------------------------------------------

function ImpLoot.Wishlist:CreateWishlist(character, name)

    if not character then
        return false
    end

    if not name or name == "" then
        return false
    end

    character.Wishlists = character.Wishlists or {}

    -------------------------------------------------
    -- Maximum Wishlists
    -------------------------------------------------

    if #character.Wishlists >= 7 then
        return false
    end

    for _, wishlist in ipairs(character.Wishlists) do

        if wishlist.Name == name then
            return false
        end

    end

    table.insert(character.Wishlists, {

        Name = name,
        ArrangeBy = "ALL",
        Items = {}

    })

    self:NotifyChanged()

    return true

end

-------------------------------------------------
-- Get Wishlist
-------------------------------------------------

function ImpLoot.Wishlist:GetWishlist(character, name)

    if not character then
        return nil
    end

    character.Wishlists = character.Wishlists or {}

    for _, wishlist in ipairs(character.Wishlists) do

        if wishlist.Name == name then

            if not wishlist.ArrangeBy then
                wishlist.ArrangeBy = "ALL"
            end

            return wishlist
        end

    end

    return nil
end

-------------------------------------------------
-- Rename Wishlist
-------------------------------------------------

function ImpLoot.Wishlist:RenameWishlist(character, wishlist, newName)

    if not character then
        return false
    end

    if not wishlist then
        return false
    end

    if not newName or newName == "" then
        return false
    end

    for _, other in ipairs(character.Wishlists or {}) do

        if other ~= wishlist and other.Name == newName then
            return false
        end

    end

    wishlist.Name = newName

    self:NotifyChanged()

    return true

end

-------------------------------------------------
-- Delete Wishlist
-------------------------------------------------

function ImpLoot.Wishlist:DeleteWishlist(character, wishlist)

    if not character then
        return false
    end

    if not wishlist then
        return false
    end

    character.Wishlists = character.Wishlists or {}

    for index, current in ipairs(character.Wishlists) do

        if current == wishlist then

            table.remove(character.Wishlists, index)

            -- Clear active wishlist if we deleted it
            if character.ActiveWishlist == wishlist.Name then
                character.ActiveWishlist = nil
            end

            self:NotifyChanged()

            return true

        end

    end

    return false

end

function ImpLoot.Wishlist:AddItem(
    character,
    wishlistName,
    itemID,
    raid,
    boss,
    difficulty
)

    if not character then
        return false
    end

    if not itemID then
        return false
    end

    local wishlist = self:GetWishlist(character, wishlistName)

    if not wishlist then
        return false
    end

    wishlist.Items = wishlist.Items or {}

    for _, entry in ipairs(wishlist.Items) do

        if entry.ItemID == itemID then

            entry.Count = entry.Count + 1

            self:NotifyChanged()

            return true

        end

    end

    local item = ImpLoot.Database:FindItemByID(itemID)

    if not item then
        return false
    end

    -------------------------------------------------
    -- Store Names, Not Full Objects
    --
    -- raid/boss are full database objects (a raid
    -- contains every boss and every item for that raid,
    -- each of which links back to the raid again). Storing
    -- them directly here meant every wishlist item saved
    -- the entire raid's data all over again -- with even a
    -- handful of items, that's easily enough to blow past
    -- a single SavedVariables allocation on /reload
    -- ("memory allocation error: block too big"). Only the
    -- names are ever actually needed; RaidName/BossName get
    -- resolved back to real objects on demand wherever
    -- navigation needs them.
    -------------------------------------------------

    local raidName = raid and (type(raid) == "table" and raid.Name or raid)
    local bossName = boss and (type(boss) == "table" and boss.Name or boss)

    table.insert(wishlist.Items, {

        ItemID = itemID,
        Count = 1,

        RaidName = raidName,
        BossName = bossName,
        Difficulty = difficulty,

    })

    self:NotifyChanged()

    return true

end

-------------------------------------------------
-- Remove Item
-------------------------------------------------

function ImpLoot.Wishlist:RemoveItem(character, wishlistName, itemID)

    if not character then
        return false
    end

    if not itemID then
        return false
    end

    local wishlist = self:GetWishlist(character, wishlistName)

    if not wishlist then
        return false
    end

    for index, entry in ipairs(wishlist.Items) do

        if entry.ItemID == itemID then

            if entry.Count > 1 then
                entry.Count = entry.Count - 1
            else
                table.remove(wishlist.Items, index)
            end

            self:NotifyChanged()

            return true

        end

    end

    return false

end

-------------------------------------------------
-- Set Active Wishlist
-------------------------------------------------

function ImpLoot.Wishlist:SetActive(character, wishlist)

    if not character then
        return
    end

    if not wishlist then
        character.ActiveWishlist = nil
        self:NotifyChanged()
        return
    end

    character.ActiveWishlist = wishlist.Name

    self:NotifyChanged()

end

-------------------------------------------------
-- Get Active Wishlist
-------------------------------------------------

function ImpLoot.Wishlist:GetActive(character)

    if not character then
        return nil
    end

    if not character.ActiveWishlist then
        return nil
    end

    return self:GetWishlist(character, character.ActiveWishlist)

end

-------------------------------------------------
-- Notify Changed
-------------------------------------------------

function ImpLoot.Wishlist:NotifyChanged()

    ImpLoot.Events:Fire("WishlistChanged")

end