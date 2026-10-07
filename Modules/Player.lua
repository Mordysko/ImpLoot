-------------------------------------------------
-- ImpLoot Player Module
-------------------------------------------------

ImpLoot.Player = {}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.Player:Initialize()

    local playerName = UnitName("player")
    local className = UnitClass("player")

    local player = self:GetOrCreate(playerName)

    -- Character:GetOrCreate already adds the character to
    -- player.Characters and registers the player when it
    -- creates one -- it does not need to be repeated here.
    -- (The old version called AddCharacter/Register again
    -- after this, which duplicated the character entry in
    -- ImpLootDB on every login.)
    ImpLoot.Character:GetOrCreate(player, playerName, className)

end

-------------------------------------------------
-- Register Player
-------------------------------------------------

function ImpLoot.Player:Register(player)
    ImpLootDB.Players[player.Name] = player
end

-------------------------------------------------
-- Get Player
-------------------------------------------------

function ImpLoot.Player:Get(name)
    return ImpLootDB.Players[name]
end

-------------------------------------------------
-- Get Or Create Player
-------------------------------------------------

function ImpLoot.Player:GetOrCreate(name)

    local player = self:Get(name)

    if player then
        return player
    end

    player = self:Create(name)
    self:Register(player)

    return player

end

-------------------------------------------------
-- Create Player
-------------------------------------------------

function ImpLoot.Player:Create(name)

    return {
        Name = name,
        Characters = {},
        Preferences = {},
    }

end

-------------------------------------------------
-- Add Character
-------------------------------------------------

function ImpLoot.Player:AddCharacter(player, character)
    table.insert(player.Characters, character)
end
