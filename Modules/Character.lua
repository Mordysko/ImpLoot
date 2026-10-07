-------------------------------------------------
-- ImpLoot Character Module
-------------------------------------------------

ImpLoot.Character = {}

-------------------------------------------------
-- Create Character
-------------------------------------------------

function ImpLoot.Character:Create(name, class)

    return {

        Name = name,

        Class = {
            Name = class,
            Token = nil,
        },

        Spec = nil,

        Guild = {
            Name = nil,
            Rank = nil,
        },

        Wishlist = {},
        ActiveWishlist = {},
        PriorityLists = {},
        LootHistory = {},
        SelectedRaid = nil,
        RaidNotes = {},
        ActiveRaidNote = nil,

    }

end

-------------------------------------------------
-- Get Character
-------------------------------------------------

function ImpLoot.Character:Get(player, name)

    for _, character in ipairs(player.Characters) do

        if character.Name == name then
            return character
        end

    end

    return nil

end

-------------------------------------------------
-- Get Current Character
-------------------------------------------------

function ImpLoot.Character:GetCurrent()

    local playerName = UnitName("player")

    local player = ImpLoot.Player:Get(playerName)

    if not player then
        return nil
    end

    return self:Get(player, playerName)

end

-------------------------------------------------
-- Get Or Create Character
-------------------------------------------------

function ImpLoot.Character:GetOrCreate(player, name, class)

    local character = self:Get(player, name)

    if character then
        return character
    end

    character = self:Create(name, class)

    ImpLoot.Player:AddCharacter(player, character)

    return character

end

-------------------------------------------------
-- Get All Characters
--
-- Flattened across every "Player" bucket in the saved
-- data (today, each character ends up in its own
-- bucket keyed by its own name -- there's no real
-- account-level grouping -- but this doesn't care
-- about that, it just collects every character found
-- anywhere).
-------------------------------------------------

function ImpLoot.Character:GetAllCharacters()

    local all = {}

    for _, player in pairs(ImpLootDB.Players) do

        for _, character in ipairs(player.Characters) do
            table.insert(all, character)
        end

    end

    return all

end

-------------------------------------------------
-- Viewed Character
--
-- A view/edit context for the Wishlist screen only --
-- selecting an alt via the Characters page lets you
-- browse and edit THEIR wishlist without touching
-- anything tied to whoever's actually logged in
-- (Soft Reserve matching, Loot Master, Raid Notes,
-- etc. all keep using GetCurrent() directly).
-------------------------------------------------

ImpLoot.Character.ViewedName = nil

function ImpLoot.Character:SetViewed(name)
    self.ViewedName = name
end

function ImpLoot.Character:ClearViewed()
    self.ViewedName = nil
end

function ImpLoot.Character:GetViewed()

    if not self.ViewedName then
        return self:GetCurrent()
    end

    for _, character in ipairs(self:GetAllCharacters()) do

        if character.Name == self.ViewedName then
            return character
        end

    end

    -- the viewed character no longer resolves for some
    -- reason -- fall back rather than show nothing
    return self:GetCurrent()

end
