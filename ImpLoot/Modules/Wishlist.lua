-------------------------------------------------
-- ImpLoot Wishlist Module
-------------------------------------------------

ImpLoot.Wishlist = {}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.Wishlist:Initialize()
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

    table.insert(wishlist.Items, {

        ItemID = itemID,
        Count = 1,

        Raid = raid,
        Boss = boss,
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