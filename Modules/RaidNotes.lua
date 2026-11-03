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
--   Raid       free text for a fight. Can be linked to
--              a boss: it then shows by itself when you
--              target the boss in its raid, and hides
--              when the boss dies or you leave (see
--              UI/NoteFrames.lua).
--
-- Note text can hold simple markup, rendered on the
-- on-screen note:
--   {rt1}..{rt8} / {star} {circle} {diamond}
--   {triangle} {moon} {square} {cross} {skull}
--   {warrior} {paladin} ... {deathknight} {druid}
--   {tank} {healer} {dps}
--   {spell:12345}  that spell's icon
--   colour codes inserted from the editor's palette
--
-- Notes can be sent to the raid, the party or one
-- player (see Sharing below).
--
-- The on-screen windows are UI/NoteFrames.lua; the
-- editor is UI/RaidNotesPopup.lua.
-------------------------------------------------

ImpLoot.RaidNotes = {}
ImpLoot.Notes = ImpLoot.RaidNotes

local Notes = ImpLoot.RaidNotes

Notes.TYPES = { "Personal", "Checklist", "Raid" }
Notes.RESETS = { "Daily", "Weekly", "Manual" }

-- Until the server's weekly reset has been seen (from a
-- raid lockout, see LearnWeeklyReset), the weekly reset
-- is taken as the daily reset on this weekday
-- (date("*t").wday: 1 = Sunday, 4 = Wednesday)
Notes.WEEKLY_RESET_WDAY = 4

local WEEK = 7 * 86400

-------------------------------------------------
-- Initialize
-------------------------------------------------

function Notes:Initialize()

    ImpLootDB.WeeklyReset = ImpLootDB.WeeklyReset or {}
    ImpLootDB.NoteSharing = ImpLootDB.NoteSharing or {}

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("UPDATE_INSTANCE_INFO")

    frame:SetScript("OnEvent", function(_, event)

        if event == "PLAYER_ENTERING_WORLD" then

            -- asks the server for our lockouts; the answer is
            -- UPDATE_INSTANCE_INFO
            if RequestRaidInfo and not self.AskedRaidInfo then
                self.AskedRaidInfo = true
                RequestRaidInfo()
            end

        else
            self:LearnWeeklyReset()
        end

    end)

    self.EventFrame = frame

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

    -- Raid notes: note.Raid / note.Boss (the boss it's linked
    -- to, nil for none) and note.Targets (comma-separated
    -- names that show it when targeted)

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
-- reports how long until it). Weekly: the server's
-- weekly raid reset, learned from your raid lockouts
-- (every raid lockout ends on it), saved per realm.
-- Until a lockout has been seen on a realm: the first
-- daily reset that falls on WEEKLY_RESET_WDAY.
-------------------------------------------------

local function RealmKey()
    return GetRealmName and GetRealmName() or "?"
end

-- Called when the server sends our lockouts. Remembers when
-- the weekly reset is, and moves weekly checklists to it if
-- that differs from what they were set to.
function Notes:LearnWeeklyReset()

    if not GetNumSavedInstances or not GetSavedInstanceInfo then
        return
    end

    local soonest

    for i = 1, GetNumSavedInstances() or 0 do

        local _, _, reset, _, _, _, _, isRaid = GetSavedInstanceInfo(i)

        if isRaid and reset and reset > 0 and (not soonest or reset < soonest) then
            soonest = reset
        end

    end

    if not soonest then
        return
    end

    -- to the nearest minute, so it doesn't drift by a second
    -- each time
    local resetTime = math.floor((time() + soonest) / 60 + 0.5) * 60
    local store = ImpLootDB.WeeklyReset or {}
    ImpLootDB.WeeklyReset = store

    local known = store[RealmKey()]

    if known then

        -- same time of the week as before (an extended lockout
        -- ends a week later, still on the same reset)
        local offset = (resetTime - known) % WEEK

        if offset < 120 or offset > WEEK - 120 then
            return
        end

    end

    store[RealmKey()] = resetTime

    -- move weekly checklists that haven't reset yet onto it
    local character = ImpLoot.Character and ImpLoot.Character:GetCurrent()
    local now = time()

    for _, note in ipairs(self:GetNotes(character)) do

        if note.Type == "Checklist" and note.Reset == "Weekly" and note.NextReset and note.NextReset > now then
            note.NextReset = self:NextWeeklyReset()
        end

    end

end

-- Next weekly reset from the one learned for this realm,
-- or nil if none has been seen yet
function Notes:NextWeeklyReset()

    local store = ImpLootDB and ImpLootDB.WeeklyReset
    local known = store and store[RealmKey()]

    if not known then
        return nil
    end

    local now = time()
    local nextReset = known + math.ceil((now - known) / WEEK) * WEEK

    if nextReset <= now then
        nextReset = nextReset + WEEK
    end

    return nextReset

end

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
    local weekly = (note.Reset == "Weekly") and self:NextWeeklyReset()

    if weekly then

        nextReset = weekly

    elseif note.Reset == "Weekly" then

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

    text = (text or ""):gsub("{[Ss][Pp][Ee][Ll][Ll]:(%d+)}", function(id)
        return "|T" .. self:SpellIcon(tonumber(id)) .. ":0|t"
    end)

    return (text:gsub("{(%w+)}", function(token)
        return self:IconFor(token, 0)
    end))

end

-------------------------------------------------
-- Spells
--
-- {spell:ID} shows that spell's icon. Any spell in the
-- game works by its ID (boss abilities included); by
-- name only spells you know (the game can't look up
-- others by name).
-------------------------------------------------

local UNKNOWN_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

function Notes:SpellIcon(id)

    local _, _, icon = GetSpellInfo(id or 0)
    return icon or UNKNOWN_ICON

end

-- A spell ID from what was typed or pasted: an ID, a
-- spell link, a Wowhead address (...spell=12345), or the
-- name of a spell you know. Returns id, name or nil.
function Notes:FindSpell(input)

    input = (input or ""):gsub("^%s+", ""):gsub("%s+$", "")

    if input == "" then
        return nil
    end

    local id = input:match("|H%a+:(%d+)") or input:match("spell=(%d+)") or input:match("^(%d+)$")

    if not id and GetSpellLink then
        local link = GetSpellLink(input)
        id = link and link:match("|H%a+:(%d+)")
    end

    id = tonumber(id)

    local name = id and GetSpellInfo(id)

    if not name then
        return nil
    end

    return id, name

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

-------------------------------------------------
-- Boss Links (Raid notes)
--
-- A Raid note linked to a boss shows by itself when you
-- target that boss (or it's your focus, under your
-- mouse, or up in the boss frames) while alive, inside
-- its raid. The names that count are note.Targets,
-- filled in from the table below when you pick the boss
-- and editable in the editor. Most bosses are just
-- their own name; encounters with several (or
-- differently named) enemies list them here.
-------------------------------------------------

local BOSS_TARGETS = {
    ["The Four Horsemen"] = "Thane Korth'azz, Lady Blaumeux, Sir Zeliek, Baron Rivendare",
    ["Thaddius"] = "Thaddius, Stalagg, Feugen",
    ["Assembly of Iron"] = "Steelbreaker, Runemaster Molgeim, Stormcaller Brundir",
    ["Mimiron"] = "Mimiron, Leviathan Mk II, VX-001, Aerial Command Unit",
    ["Yogg-Saron"] = "Sara, Yogg-Saron",
    ["Northrend Beasts"] = "Gormok the Impaler, Acidmaw, Dreadscale, Icehowl",
    ["Twin Val'kyr"] = "Fjola Lightbane, Eydis Darkbane",
    -- the champions' names change with your faction and
    -- the raid's make-up: type the ones you'll target
    ["Faction Champions"] = "",
    ["Gunship Battle"] = "High Overlord Saurfang, Muradin Bronzebeard",
    ["Blood Prince Council"] = "Prince Valanar, Prince Keleseth, Prince Taldaram",
}

-- The raid's zone name in game, where it differs from ours
local RAID_ZONES = {
    ["Obsidian Sanctum"] = "The Obsidian Sanctum",
    ["Ruby Sanctum"] = "The Ruby Sanctum",
}

-- Bosses that aren't an enemy you target
local NOT_A_TARGET = {
    ["Argent Crusade Tribute"] = true,
}

Notes.NOT_A_TARGET = NOT_A_TARGET

function Notes:DefaultTargets(bossName)

    if not bossName then
        return ""
    end

    return BOSS_TARGETS[bossName] or bossName

end

function Notes:SetBossLink(note, raidName, bossName)

    if not note then
        return
    end

    note.Raid = raidName
    note.Boss = bossName
    note.Targets = bossName and self:DefaultTargets(bossName) or nil

end

function Notes:IsLinked(note)
    return note and note.Type == "Raid" and note.Boss ~= nil
end

-- note.Targets as a set of lower-case names
function Notes:GetTargets(note)

    local targets, count = {}, 0

    for name in (note.Targets or ""):gmatch("[^,]+") do

        name = name:gsub("^%s+", ""):gsub("%s+$", ""):lower()

        if name ~= "" then
            targets[name] = true
            count = count + 1
        end

    end

    return targets, count

end

-- Are we in the note's raid?
function Notes:InNoteZone(note)

    if not note.Raid then
        return true
    end

    local zone = (GetRealZoneText and GetRealZoneText() or ""):lower()
    local wanted = (RAID_ZONES[note.Raid] or note.Raid):lower()

    return zone == wanted or zone == note.Raid:lower()

end

function Notes:DescribeLink(note)

    if not self:IsLinked(note) then
        return nil
    end

    return (note.Raid and (note.Raid .. ": ") or "") .. note.Boss

end

-------------------------------------------------
-- Sharing
--
-- Send a note to the raid (or party) or to one player.
-- Whoever receives it is asked whether to save it
-- (Options: notes from the raid leader or an assistant
-- can be saved without asking). A note they already got
-- from the same sender, under the same name, is updated
-- in place -- where they put it on screen and its size
-- stay as they had them.
--
-- Addon messages (ImpLoot prefix), a few per second:
--
--   NS_B|id|parts      a note is coming, in <parts> pieces
--   NS_C|id|n|piece    piece n
--
-- The note is its fields joined by "~" (name, type,
-- reset, raid, boss, targets, text), with "%", "~", "|"
-- and control characters (new lines) written as %XX.
-------------------------------------------------

local SHARE_PIECE = 200
local SHARE_MAX_PIECES = 80
local SHARE_INTERVAL = 0.2
local SHARE_TIMEOUT = 60

local function Encode(value)
    return (tostring(value or ""):gsub("[%c%%~|]", function(c)
        return string.format("%%%02X", c:byte())
    end))
end

local function Decode(value)
    return (value:gsub("%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end))
end

function Notes:Serialize(note)

    local fields = {
        note.Name, note.Type, note.Reset or "",
        note.Raid or "", note.Boss or "", note.Targets or "",
        note.Text or "",
    }

    for i, value in ipairs(fields) do
        fields[i] = Encode(value)
    end

    return table.concat(fields, "~")

end

function Notes:Deserialize(data)

    local fields = {}

    for value in (data .. "~"):gmatch("(.-)~") do
        table.insert(fields, Decode(value))
    end

    if #fields < 7 or fields[1] == "" then
        return nil
    end

    local function Optional(value)
        return value ~= "" and value or nil
    end

    local noteType = fields[2]
    local known = false

    for _, t in ipairs(self.TYPES) do
        if t == noteType then known = true end
    end

    return {
        Name = fields[1]:sub(1, 40),
        Type = known and noteType or "Personal",
        Reset = Optional(fields[3]),
        Raid = Optional(fields[4]),
        Boss = Optional(fields[5]),
        Targets = Optional(fields[6]),
        Text = fields[7],
    }

end

-- Cut into pieces, never through the middle of a %XX
local function Pieces(data)

    local pieces = {}
    local i = 1

    while i <= #data do

        local last = math.min(#data, i + SHARE_PIECE - 1)

        if last < #data then
            local percent = data:sub(last - 1, last):find("%", 1, true)
            if percent then
                last = last - 2 + percent - 1
            end
        end

        table.insert(pieces, data:sub(i, last))
        i = last + 1

    end

    return pieces

end

Notes.Pieces = Pieces

-------------------------------------------------
-- Outbox (a few messages a second)
-------------------------------------------------

local outbox = {}
local outboxFrame = CreateFrame("Frame")
local outboxWait = 0

outboxFrame:SetScript("OnUpdate", function(_, elapsed)

    -- the next "save this note?" question, a frame after the
    -- last one closed
    if Notes.AskSoon then
        Notes.AskSoon = nil
        Notes:AskNext()
    end

    if #outbox == 0 then
        return
    end

    outboxWait = outboxWait - (elapsed or 0)

    if outboxWait > 0 then
        return
    end

    outboxWait = SHARE_INTERVAL

    local message = table.remove(outbox, 1)
    SendAddonMessage("ImpLoot", message.Text, message.Channel, message.Target)

end)

local function Print(text)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd200ImpLoot:|r " .. text)
end

-- "RAID", "PARTY" or nil when not in a group
function Notes:GroupChannel()

    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        return "RAID"
    end

    if GetNumPartyMembers and GetNumPartyMembers() > 0 then
        return "PARTY"
    end

    return nil

end

-- channel: "GROUP" (raid or party) or "WHISPER" (+ target)
function Notes:SendNote(note, channel, target)

    if not note then
        return false
    end

    local where

    if channel == "WHISPER" then

        if not target or target == "" then
            return false
        end

        where = target

    else

        channel = self:GroupChannel()

        if not channel then
            Print("You're not in a group.")
            return false
        end

        where = (channel == "RAID") and "the raid" or "your party"

    end

    local pieces = Pieces(self:Serialize(note))

    if #pieces > SHARE_MAX_PIECES then
        Print("\"" .. note.Name .. "\" is too long to send.")
        return false
    end

    local id = tostring(math.random(100000, 999999))

    table.insert(outbox, { Text = "NS_B|" .. id .. "|" .. #pieces, Channel = channel, Target = target })

    for index, piece in ipairs(pieces) do
        table.insert(outbox, { Text = "NS_C|" .. id .. "|" .. index .. "|" .. piece, Channel = channel, Target = target })
    end

    Print("Sending note \"" .. note.Name .. "\" to " .. where .. ".")

    return true

end

-------------------------------------------------
-- Receiving
-------------------------------------------------

Notes.Incoming = {}
Notes.Waiting = {}

local function SameName(a, b)

    if not a or not b then
        return false
    end

    a = (a:match("^([^%-]+)") or a):lower()
    b = (b:match("^([^%-]+)") or b):lower()

    return a == b

end

function Notes:IsLeaderOrAssistant(name)

    if GetNumRaidMembers and GetNumRaidMembers() > 0 then

        for i = 1, GetNumRaidMembers() do
            local member, rank = GetRaidRosterInfo(i)
            if SameName(member, name) then
                return (rank or 0) > 0
            end
        end

        return false

    end

    for i = 1, 4 do

        local unit = "party" .. i

        if UnitExists(unit) and SameName(UnitName(unit), name) then
            return UnitIsPartyLeader and UnitIsPartyLeader(unit) and true or false
        end

    end

    return false

end

function Notes:OnShareMessage(message, sender)

    if SameName(sender, UnitName("player")) then
        return  -- our own, echoed back by the raid channel
    end

    local now = time()

    -- forget half-received notes that stopped arriving
    for key, incoming in pairs(self.Incoming) do
        if now - incoming.Started > SHARE_TIMEOUT then
            self.Incoming[key] = nil
        end
    end

    local kind, id, a, b = message:match("^(NS_%a)|([^|]+)|([^|]*)|?(.*)$")

    if not kind then
        return
    end

    local key = sender .. ":" .. id
    local incoming = self.Incoming[key]

    if not incoming then
        incoming = { Started = now, Pieces = {}, Got = 0 }
        self.Incoming[key] = incoming
    end

    if kind == "NS_B" then

        incoming.Total = math.min(tonumber(a) or 0, SHARE_MAX_PIECES)

    elseif kind == "NS_C" then

        local index = tonumber(a)

        if index and not incoming.Pieces[index] then
            incoming.Pieces[index] = b or ""
            incoming.Got = incoming.Got + 1
        end

    end

    if incoming.Total and incoming.Got >= incoming.Total then

        self.Incoming[key] = nil

        local note = self:Deserialize(table.concat(incoming.Pieces, "", 1, incoming.Total))

        if note then
            self:Received(note, (sender:match("^([^%-]+)") or sender))
        end

    end

end

function Notes:AutoAccepts(sender)

    local settings = ImpLootDB and ImpLootDB.NoteSharing or {}

    return settings.AcceptFromLeader and self:IsLeaderOrAssistant(sender)

end

function Notes:Received(note, sender)

    if self:AutoAccepts(sender) then
        self:SaveShared(note, sender)
        return
    end

    table.insert(self.Waiting, { Note = note, Sender = sender })
    self:AskNext()

end

-- One "save this note?" question at a time
function Notes:AskNext()

    if self.Asking or #self.Waiting == 0 then
        return
    end

    local nextOne = table.remove(self.Waiting, 1)
    self.Asking = nextOne

    local dialog = StaticPopup_Show("IMPLOOT_SHARED_NOTE", nextOne.Sender,
        nextOne.Note.Name .. " |cff999999(" .. nextOne.Note.Type .. ")|r", nextOne)

    if dialog then
        -- above the note editor and the rest of ImpLoot
        dialog:SetFrameStrata("TOOLTIP")
    else
        self.Asking = nil
    end

end

StaticPopupDialogs["IMPLOOT_SHARED_NOTE"] = {
    text = "%s sent you a note:\n\n|cffffffff%s|r\n\nSave it?",
    button1 = "Save",
    button2 = "Ignore",
    OnAccept = function(_, data)
        if data then
            ImpLoot.RaidNotes:SaveShared(data.Note, data.Sender)
        end
    end,
    OnHide = function(dialog)
        dialog:SetFrameStrata("DIALOG")
        ImpLoot.RaidNotes.Asking = nil
        ImpLoot.RaidNotes.AskSoon = true
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
}

function Notes:SaveShared(shared, sender)

    local character = ImpLoot.Character and ImpLoot.Character:GetCurrent()

    if not character or not shared then
        return
    end

    -- the same note from the same person: update it
    local note

    for _, existing in ipairs(self:GetNotes(character)) do
        if existing.Name == shared.Name and SameName(existing.SharedBy, sender) then
            note = existing
        end
    end

    local updated = note ~= nil

    if not note then

        -- a free name: "Name", else "Name (Sender)", "Name (Sender) 2" ...
        local name = shared.Name
        local base = (shared.Name .. " (" .. sender .. ")"):sub(1, 40)
        local count = 1

        while self:GetNote(character, name) do
            name = (count == 1) and base or (base:sub(1, 37) .. " " .. count)
            count = count + 1
        end

        local _, created = self:CreateNote(character, name, shared.Type, shared.Reset)
        note = created

    end

    if not note then
        return
    end

    note.SharedBy = sender
    note.Type = shared.Type
    note.Reset = (shared.Type == "Checklist") and (shared.Reset or note.Reset or "Daily") or nil
    note.Raid, note.Boss, note.Targets = shared.Raid, shared.Boss, shared.Targets
    self:Upgrade(note)

    if note.Type == "Checklist" and not note.NextReset then
        self:ScheduleReset(note)
    end

    self:SetText(note, shared.Text)

    -- the editor open on it would save its old text over this
    local editor = ImpLoot.UI and ImpLoot.UI.RaidNotesPopup

    if editor and editor.Note == note and editor.Window and editor.Window:IsShown() then
        editor:ShowNote(note)
    end

    if ImpLoot.UI and ImpLoot.UI.PlanningDrawer and ImpLoot.UI.PlanningDrawer.Refresh then
        ImpLoot.UI.PlanningDrawer:Refresh()
    end

    Print((updated and "Updated" or "Saved") .. " note \"" .. note.Name .. "\" from " .. sender
        .. (self:IsLinked(note) and (" (shows when you target " .. note.Boss .. ")") or "") .. ".")

end
