-------------------------------------------------
-- ImpLoot Raid Notes Module
--
-- Named, saveable/loadable notes per character --
-- same shape as Wishlist.lua (Create/Rename/Delete/
-- SetActive/GetActive), just holding free text
-- instead of items.
-------------------------------------------------

ImpLoot.RaidNotes = {}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.RaidNotes:Initialize()
end

-------------------------------------------------
-- Create Note
-------------------------------------------------

function ImpLoot.RaidNotes:CreateNote(character, name)

    if not character then
        return false
    end

    if not name or name == "" then
        return false
    end

    character.RaidNotes = character.RaidNotes or {}

    if #character.RaidNotes >= 7 then
        return false
    end

    for _, note in ipairs(character.RaidNotes) do

        if note.Name == name then
            return false
        end

    end

    table.insert(character.RaidNotes, {

        Name = name,
        Text = "",

    })

    return true

end

-------------------------------------------------
-- Get Note
-------------------------------------------------

function ImpLoot.RaidNotes:GetNote(character, name)

    if not character then
        return nil
    end

    character.RaidNotes = character.RaidNotes or {}

    for _, note in ipairs(character.RaidNotes) do

        if note.Name == name then
            return note
        end

    end

    return nil

end

-------------------------------------------------
-- Rename Note
-------------------------------------------------

function ImpLoot.RaidNotes:RenameNote(character, note, newName)

    if not character or not note then
        return false
    end

    if not newName or newName == "" then
        return false
    end

    for _, other in ipairs(character.RaidNotes or {}) do

        if other ~= note and other.Name == newName then
            return false
        end

    end

    if character.ActiveRaidNote == note.Name then
        character.ActiveRaidNote = newName
    end

    note.Name = newName

    return true

end

-------------------------------------------------
-- Delete Note
-------------------------------------------------

function ImpLoot.RaidNotes:DeleteNote(character, note)

    if not character or not note then
        return false
    end

    character.RaidNotes = character.RaidNotes or {}

    for index, current in ipairs(character.RaidNotes) do

        if current == note then

            table.remove(character.RaidNotes, index)

            if character.ActiveRaidNote == note.Name then
                character.ActiveRaidNote = nil
            end

            return true

        end

    end

    return false

end

-------------------------------------------------
-- Set Active Note
-------------------------------------------------

function ImpLoot.RaidNotes:SetActive(character, note)

    if not character then
        return
    end

    if not note then
        character.ActiveRaidNote = nil
        return
    end

    character.ActiveRaidNote = note.Name

end

-------------------------------------------------
-- Get Active Note
-------------------------------------------------

function ImpLoot.RaidNotes:GetActive(character)

    if not character then
        return nil
    end

    if not character.ActiveRaidNote then
        return nil
    end

    return self:GetNote(character, character.ActiveRaidNote)

end

-------------------------------------------------
-- Set Text
-------------------------------------------------

function ImpLoot.RaidNotes:SetText(note, text)

    if not note then
        return
    end

    note.Text = text or ""

end
