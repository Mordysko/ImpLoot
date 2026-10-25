-------------------------------------------------
-- ImpLoot Notes Module
--
-- Named notes per character (stored, for backward
-- compatibility, in character.RaidNotes). Each note
-- has a type:
--
--   Personal   free text, shown on screen
--   Checklist  one item per line; click an item on
--              screen to tick it. Resets Daily (server
--              daily reset), Weekly (raid reset) or
--              only by hand (Manual).
--   Raid       free text for a fight (boss linking
--              comes in a later build; shown by hand
--              for now)
--
-- Note text can hold simple markup, rendered on the
-- on-screen note:
--   {rt1}..{rt8} / {star} {circle} {diamond}
--   {triangle} {moon} {square} {cross} {skull}
--   {warrior} {paladin} ... {deathknight} {druid}
--   {tank} {healer} {dps}
--   colour codes inserted from the editor's palette
--
-- The on-screen windows are UI/NoteFrames.lua; the
-- editor is UI/RaidNotesPopup.lua.
-------------------------------------------------

ImpLoot.RaidNotes = {}
ImpLoot.Notes = ImpLoot.RaidNotes

local Notes = ImpLoot.RaidNotes

Notes.TYPES = { "Personal", "Checklist", "Raid" }
Notes.RESETS = { "Daily", "Weekly", "Manual" }

-- The weekly raid reset happens at the daily reset on
-- this weekday (date("*t").wday: 1 = Sunday, 4 = Wednesday)
Notes.WEEKLY_RESET_WDAY = 4

-------------------------------------------------
-- Initialize
-------------------------------------------------

function Notes:Initialize()
end

-------------------------------------------------
-- Defaults For A Note (also fills in older notes)
-------------------------------------------------

function Notes:Upgrade(note)

    note.Type = note.Type or "Personal"
    note.Text = note.Text or ""
    note.Alpha = note.Alpha or 0.5
    note.FontSize = note.FontSize or 12
    note.Width = note.Width or 240
    note.Height = note.Height or 200

    if note.Locked == nil then
        note.Locked = false
    end

    if note.Type == "Checklist" then
        note.Reset = note.Reset or "Daily"
        note.Checked = note.Checked or {}
    end

    return note

end

function Notes:GetNotes(character)

    if not character then
        return {}
    end

    character.RaidNotes = character.RaidNotes or {}

    for _, note in ipairs(character.RaidNotes) do
        self:Upgrade(note)
    end

    return character.RaidNotes

end

-------------------------------------------------
-- Create Note
-------------------------------------------------

function Notes:CreateNote(character, name, noteType, reset)

    if not character then
        return false
    end

    if not name or name == "" then
        return false
    end

    local list = self:GetNotes(character)

    for _, note in ipairs(list) do

        if note.Name == name then
            return false
        end

    end

    local note = self:Upgrade({
        Name = name,
        Text = "",
        Type = noteType or "Personal",
        Reset = reset,
    })

    table.insert(list, note)

    if note.Type == "Checklist" then
        self:ScheduleReset(note)
    end

    return true, note

end

-------------------------------------------------
-- Get Note
-------------------------------------------------

function Notes:GetNote(character, name)

    for _, note in ipairs(self:GetNotes(character)) do

        if note.Name == name then
            return note
        end

    end

    return nil

end

-------------------------------------------------
-- Rename Note
-------------------------------------------------

function Notes:RenameNote(character, note, newName)

    if not character or not note then
        return false
    end

    if not newName or newName == "" then
        return false
    end

    for _, other in ipairs(self:GetNotes(character)) do

        if other ~= note and other.Name == newName then
            return false
        end

    end

    if character.ActiveRaidNote == note.Name then
        character.ActiveRaidNote = newName
    end

    note.Name = newName

    if ImpLoot.UI.NoteFrames then
        ImpLoot.UI.NoteFrames:Refresh(note)
    end

    return true

end

-------------------------------------------------
-- Delete Note
-------------------------------------------------

function Notes:DeleteNote(character, note)

    if not character or not note then
        return false
    end

    local list = self:GetNotes(character)

    for index, current in ipairs(list) do

        if current == note then

            if ImpLoot.UI.NoteFrames then
                ImpLoot.UI.NoteFrames:Hide(note)
            end

            table.remove(list, index)

            if character.ActiveRaidNote == note.Name then
                character.ActiveRaidNote = nil
            end

            return true

        end

    end

    return false

end

-------------------------------------------------
-- Active (Selected) Note
-------------------------------------------------

function Notes:SetActive(character, note)

    if not character then
        return
    end

    character.ActiveRaidNote = note and note.Name or nil

end

function Notes:GetActive(character)

    if not character or not character.ActiveRaidNote then
        return nil
    end

    return self:GetNote(character, character.ActiveRaidNote)

end

-------------------------------------------------
-- Set Text
-------------------------------------------------

function Notes:SetText(note, text)

    if not note then
        return
    end

    note.Text = text or ""

    if ImpLoot.UI.NoteFrames then
        ImpLoot.UI.NoteFrames:Refresh(note)
    end

end

-------------------------------------------------
-- Checklist Items
--
-- One item per non-empty line. Ticks are stored by
-- the item's text, so editing or reordering the list
-- keeps the ticks on items that are still there.
-------------------------------------------------

function Notes:GetItems(note)

    local items = {}

    for line in ((note.Text or "") .. "\n"):gmatch("(.-)\r?\n") do

        local trimmed = line:gsub("^%s+", ""):gsub("%s+$", "")

        if trimmed ~= "" then
            table.insert(items, trimmed)
        end

    end

    return items

end

function Notes:IsChecked(note, item)
    return note.Checked and note.Checked[item] and true or false
end

function Notes:ToggleItem(note, item)

    note.Checked = note.Checked or {}

    if note.Checked[item] then
        note.Checked[item] = nil
    else
        note.Checked[item] = true
    end

end

function Notes:AllChecked(note)

    local items = self:GetItems(note)

    if #items == 0 then
        return false
    end

    for _, item in ipairs(items) do
        if not self:IsChecked(note, item) then
            return false
        end
    end

    return true

end

function Notes:ResetChecklist(note)
    note.Checked = {}
    self:ScheduleReset(note)
end

-------------------------------------------------
-- Checklist Resets
--
-- Daily: the server's daily quest reset (the game
-- reports how long until it). Weekly: the first daily
-- reset that falls on WEEKLY_RESET_WDAY.
-------------------------------------------------

local function NextDailyReset()

    local now = time()

    if GetQuestResetTime then

        local seconds = GetQuestResetTime()

        if seconds and seconds > 0 then
            return now + seconds
        end

    end

    -- Fallback: next local midnight
    local t = date("*t", now)
    t.hour, t.min, t.sec = 0, 0, 0

    return time(t) + 86400

end

function Notes:ScheduleReset(note)

    if note.Type ~= "Checklist" or note.Reset == "Manual" then
        note.NextReset = nil
        return
    end

    local nextReset = NextDailyReset()

    if note.Reset == "Weekly" then

        for _ = 1, 7 do

            if date("*t", nextReset).wday == self.WEEKLY_RESET_WDAY then
                break
            end

            nextReset = nextReset + 86400

        end

    end

    note.NextReset = nextReset

end

-- Untick any checklist whose reset time has passed.
-- Returns true if anything was reset.
function Notes:CheckResets(character)

    local changed = false
    local now = time()

    for _, note in ipairs(self:GetNotes(character)) do

        if note.Type == "Checklist" and note.Reset ~= "Manual" then

            if not note.NextReset then
                self:ScheduleReset(note)
            elseif now >= note.NextReset then
                self:ResetChecklist(note)
                changed = true
            end

        end

    end

    return changed

end

-------------------------------------------------
-- Markup
-------------------------------------------------

local RAID_ICONS = {
    star = 1, circle = 2, diamond = 3, triangle = 4,
    moon = 5, square = 6, cross = 7, x = 7, skull = 8,
}

local CLASS_TOKENS = {
    warrior = "WARRIOR", paladin = "PALADIN", hunter = "HUNTER",
    rogue = "ROGUE", priest = "PRIEST", deathknight = "DEATHKNIGHT",
    dk = "DEATHKNIGHT", shaman = "SHAMAN", mage = "MAGE",
    warlock = "WARLOCK", druid = "DRUID",
}

-- Class icon positions on the character-create sheet
-- (same values as the game's CLASS_ICON_TCOORDS)
local CLASS_COORDS = {
    WARRIOR = { 0, 0.25, 0, 0.25 },
    MAGE = { 0.25, 0.49609375, 0, 0.25 },
    ROGUE = { 0.49609375, 0.7421875, 0, 0.25 },
    DRUID = { 0.7421875, 0.98828125, 0, 0.25 },
    HUNTER = { 0, 0.25, 0.25, 0.5 },
    SHAMAN = { 0.25, 0.49609375, 0.25, 0.5 },
    PRIEST = { 0.49609375, 0.7421875, 0.25, 0.5 },
    WARLOCK = { 0.7421875, 0.98828125, 0.25, 0.5 },
    PALADIN = { 0, 0.25, 0.5, 0.75 },
    DEATHKNIGHT = { 0.25, 0.49609375, 0.5, 0.75 },
}

local ROLE_COORDS = {
    tank = { 0, 19, 22, 41 },
    healer = { 20, 39, 1, 20 },
    dps = { 20, 39, 22, 41 },
}

Notes.CLASS_TOKENS = CLASS_TOKENS

local CLASS_TEXTURE = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"
local ROLE_TEXTURE = "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES"

-- Texture string for a token (or nil if not a token).
-- Size 0 means "the height of the text it sits in", so
-- icons always match the note's text size.
function Notes:IconFor(token, size)

    token = token:lower()
    size = size or 0

    local rt = tonumber(token:match("^rt(%d)$")) or RAID_ICONS[token]

    if rt and rt >= 1 and rt <= 8 then
        return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_" .. rt .. ":" .. size .. "|t"
    end

    local class = CLASS_TOKENS[token]

    if class then

        local c = CLASS_COORDS[class]

        return string.format("|T%s:%d:%d:0:0:256:256:%d:%d:%d:%d|t", CLASS_TEXTURE, size, size,
            c[1] * 256, c[2] * 256, c[3] * 256, c[4] * 256)

    end

    local role = ROLE_COORDS[token]

    if role then
        return string.format("|T%s:%d:%d:0:0:64:64:%d:%d:%d:%d|t", ROLE_TEXTURE, size, size,
            role[1], role[2], role[3], role[4])
    end

    return nil

end

-- Note text with its {tokens} turned into icons, sized to
-- match the text
function Notes:Render(text)

    return ((text or ""):gsub("{(%w+)}", function(token)
        return self:IconFor(token, 0)
    end))

end

-- For the editor's toolbar
function Notes:ToolbarIcon(token)

    token = token:lower()

    local rt = tonumber(token:match("^rt(%d)$")) or RAID_ICONS[token]

    if rt then
        return "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. rt, { 0, 1, 0, 1 }
    end

    local class = CLASS_TOKENS[token]

    if class then
        return CLASS_TEXTURE, CLASS_COORDS[class]
    end

    local role = ROLE_COORDS[token]

    if role then
        return ROLE_TEXTURE, { role[1] / 64, role[2] / 64, role[3] / 64, role[4] / 64 }
    end

end
