-------------------------------------------------
-- Note Frames (on-screen notes)
--
-- Every note you show gets its own window on screen.
-- Several can be up at once.
--
--   Unlocked  title bar, drag to move, grip in the
--             corner to resize, right-click for options
--   Locked    just the note; clicks pass straight
--             through to the game, except a checklist's
--             items, which stay clickable
--
-- Right-click menu: Lock / Unlock, Edit, Background
-- opacity, Text size, Reset (checklists), Send, Hide.
-- Position, size, opacity, text size and lock state
-- are saved per note.
--
-- Raid notes linked to a boss (see Boss Watch below)
-- show by themselves and hide again when the boss dies
-- or you leave the raid.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.NoteFrames = ImpLoot.UI.NoteFrames or {}
local NoteFrames = ImpLoot.UI.NoteFrames

local Notes = ImpLoot.RaidNotes

local PADDING = 6
local TITLE_HEIGHT = 16
local FOOTER_HEIGHT = 20

local OPACITIES = { 0, 0.25, 0.5, 0.75, 1 }
local TEXT_SIZES = { { Label = "Small", Size = 10 }, { Label = "Normal", Size = 12 }, { Label = "Large", Size = 15 }, { Label = "Huge", Size = 18 } }

local function SetShown(region, shown)
    if shown then region:Show() else region:Hide() end
end

local function CurrentCharacter()
    return ImpLoot.Character and ImpLoot.Character:GetCurrent()
end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function NoteFrames:Initialize()

    self.Frames = {}
    self.HiddenByHand = {}
    self.Menu = CreateFrame("Frame", "ImpLootNoteMenu", UIParent, "UIDropDownMenuTemplate")

    local character = CurrentCharacter()

    if character then

        Notes:CheckResets(character)

        for _, note in ipairs(Notes:GetNotes(character)) do
            if note.Shown then
                self:Show(note)
            end
        end

    end

    self:InitBossWatch()

    -- Checklist resets while you're logged in (checked once a minute)
    local ticker = CreateFrame("Frame")
    local elapsed = 0

    ticker:SetScript("OnUpdate", function(_, delta)

        elapsed = elapsed + (delta or 0)

        if elapsed < 60 then
            return
        end

        elapsed = 0

        local current = CurrentCharacter()

        if current and Notes:CheckResets(current) then
            self:RefreshAll()
        end

    end)

end

-------------------------------------------------
-- Is Shown / Toggle
-------------------------------------------------

function NoteFrames:IsShown(note)
    local frame = self.Frames and self.Frames[note]
    return frame and frame:IsShown() or false
end

function NoteFrames:Toggle(note)

    if self:IsShown(note) then
        self:Hide(note)
    else
        self:Show(note)
    end

end

local function RefreshDrawer()

    if ImpLoot.UI.PlanningDrawer and ImpLoot.UI.PlanningDrawer.Refresh then
        ImpLoot.UI.PlanningDrawer:Refresh()
    end

end

-- Hidden by you (close button, menu, Hide in the drawer).
-- A boss-linked note hidden like that doesn't come back by
-- itself until the fight's over, the boss dies or you
-- leave the raid.
function NoteFrames:Hide(note)

    note.Shown = false

    local frame = self.Frames and self.Frames[note]

    if frame then

        if frame:IsShown() and Notes:IsLinked(note) then
            self.HiddenByHand[note] = true
        end

        frame.AutoShown = false
        frame:Hide()

    end

    RefreshDrawer()

end

-- auto: shown because its boss was targeted. That isn't
-- saved (after a /reload it shows again when you target
-- the boss), and it hides by itself when the boss dies or
-- you leave. Shown by hand, it stays until you hide it.
function NoteFrames:Show(note, auto)

    Notes:Upgrade(note)

    local frame = self.Frames[note] or self:CreateFrame(note)
    self.Frames[note] = frame

    if auto then
        if frame:IsShown() then
            return
        end
        frame.AutoShown = true
    else
        note.Shown = true
        frame.AutoShown = false
        self.HiddenByHand[note] = nil
    end

    self:ApplyLayout(frame)
    frame:Show()
    self:Refresh(note)

    if auto then
        RefreshDrawer()
    end

end

-- Taken away by the boss watch (only if it put it there)
function NoteFrames:AutoHide(note)

    local frame = self.Frames and self.Frames[note]

    if frame and frame:IsShown() and frame.AutoShown then
        frame.AutoShown = false
        frame:Hide()
        RefreshDrawer()
    end

end

-------------------------------------------------
-- Boss Watch
--
-- Shows a linked Raid note when, inside its raid, the
-- boss is alive and is your target, your focus, under
-- your mouse or in the boss frames. (Healers rarely
-- target the boss, so it isn't only your target.)
--
-- Hides it again (only if it showed itself) when:
--   - the boss dies. For an encounter with several
--     names (the Four Horsemen, a council), when the
--     fight ends after one of them died.
--   - you leave the raid.
-- You can always close it by hand; it then stays away
-- until the fight's over, the boss dies or you leave.
-------------------------------------------------

local BOSS_UNITS = { "boss1", "boss2", "boss3", "boss4" }

function NoteFrames:InitBossWatch()

    self.HiddenByHand = self.HiddenByHand or {}
    self.DiedThisFight = {}

    local watch = CreateFrame("Frame")

    for _, event in ipairs({
        "PLAYER_TARGET_CHANGED", "PLAYER_FOCUS_CHANGED", "UPDATE_MOUSEOVER_UNIT",
        "INSTANCE_ENCOUNTER_ENGAGE_UNIT", "ZONE_CHANGED_NEW_AREA", "PLAYER_ENTERING_WORLD",
        "COMBAT_LOG_EVENT_UNFILTERED", "PLAYER_REGEN_ENABLED",
    }) do
        watch:RegisterEvent(event)
    end

    watch:SetScript("OnEvent", function(_, event, ...)
        self:OnBossEvent(event, ...)
    end)

    self.BossWatch = watch

end

function NoteFrames:LinkedNotes()

    local linked = {}
    local character = CurrentCharacter()

    for _, note in ipairs(character and Notes:GetNotes(character) or {}) do
        if Notes:IsLinked(note) then
            table.insert(linked, note)
        end
    end

    return linked

end

function NoteFrames:CheckUnit(unit)

    if not UnitExists(unit) or UnitIsDead(unit) or UnitIsPlayer(unit) then
        return
    end

    local name = (UnitName(unit) or ""):lower()

    if name == "" then
        return
    end

    for _, note in ipairs(self:LinkedNotes()) do

        if not self.HiddenByHand[note] and Notes:GetTargets(note)[name] and Notes:InNoteZone(note) then
            self:Show(note, true)
        end

    end

end

function NoteFrames:OnBossEvent(event, ...)

    if event == "PLAYER_TARGET_CHANGED" then

        self:CheckUnit("target")

    elseif event == "PLAYER_FOCUS_CHANGED" then

        self:CheckUnit("focus")

    elseif event == "UPDATE_MOUSEOVER_UNIT" then

        self:CheckUnit("mouseover")

    elseif event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT" then

        for _, unit in ipairs(BOSS_UNITS) do
            self:CheckUnit(unit)
        end

    elseif event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then

        -- a new place: everything starts fresh
        self.HiddenByHand = {}
        self.DiedThisFight = {}

        for _, note in ipairs(self:LinkedNotes()) do
            if not Notes:InNoteZone(note) then
                self:AutoHide(note)
            end
        end

    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then

        local _, subEvent, _, _, _, _, destName = ...

        if subEvent ~= "UNIT_DIED" or not destName then
            return
        end

        destName = destName:lower()

        for _, note in ipairs(self:LinkedNotes()) do

            local targets, count = Notes:GetTargets(note)

            if targets[destName] then

                if count <= 1 then
                    self:BossDown(note)
                else
                    self.DiedThisFight[note] = true
                end

            end

        end

    elseif event == "PLAYER_REGEN_ENABLED" then

        -- the fight's over (won or wiped)
        for note in pairs(self.DiedThisFight) do
            self:BossDown(note)
        end

        self.DiedThisFight = {}
        self.HiddenByHand = {}

    end

end

function NoteFrames:BossDown(note)

    self.HiddenByHand[note] = nil
    self:AutoHide(note)

end

-------------------------------------------------
-- Lock / Unlock All
-------------------------------------------------

function NoteFrames:AnyUnlocked()

    for note, frame in pairs(self.Frames or {}) do
        if frame:IsShown() and not note.Locked then
            return true
        end
    end

    return false

end

function NoteFrames:SetAllLocked(locked)

    for note, frame in pairs(self.Frames or {}) do

        note.Locked = locked

        if frame:IsShown() then
            self:Refresh(note)
        end

    end

end

function NoteFrames:RefreshAll()

    for note, frame in pairs(self.Frames or {}) do
        if frame:IsShown() then
            self:Refresh(note)
        end
    end

end

-------------------------------------------------
-- Create Frame
-------------------------------------------------

function NoteFrames:CreateFrame(note)

    local frame = CreateFrame("Frame", nil, UIParent)
    frame.Note = note

    frame:SetFrameStrata("MEDIUM")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetMinResize(100, 40)
    frame:SetMaxResize(1000, 900)

    local background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetTexture(0, 0, 0)
    frame.Background = background

    -- Thin outline, only while unlocked, so you can see the edges
    local outline = CreateFrame("Frame", nil, frame)
    outline:SetAllPoints()
    outline:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
    outline:SetBackdropBorderColor(1, 0.82, 0, 0.6)
    frame.Outline = outline

    -------------------------------------------------
    -- Title Bar (unlocked only)
    -------------------------------------------------

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    title:SetPoint("TOPLEFT", PADDING, -3)
    title:SetPoint("RIGHT", frame, "RIGHT", -40, 0)
    title:SetJustifyH("LEFT")
    frame.Title = title

    local closeButton = CreateFrame("Button", nil, frame)
    closeButton:SetSize(14, 14)
    closeButton:SetPoint("TOPRIGHT", -3, -2)
    closeButton:SetNormalTexture("Interface\\Buttons\\UI-StopButton")
    closeButton:SetHighlightTexture("Interface\\Buttons\\UI-StopButton", "ADD")
    closeButton:SetScript("OnClick", function() self:Hide(frame.Note) end)
    closeButton:SetScript("OnEnter", function(button)
        GameTooltip:SetOwner(button, "ANCHOR_TOP")
        GameTooltip:SetText("Hide this note")
        GameTooltip:Show()
    end)
    closeButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.CloseButton = closeButton

    local lockButton = CreateFrame("Button", nil, frame)
    lockButton:SetSize(14, 14)
    lockButton:SetPoint("RIGHT", closeButton, "LEFT", -3, 0)
    lockButton:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
    lockButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    lockButton:SetScript("OnClick", function()
        frame.Note.Locked = true
        self:Refresh(frame.Note)
    end)
    lockButton:SetScript("OnEnter", function(button)
        GameTooltip:SetOwner(button, "ANCHOR_TOP")
        GameTooltip:SetText("Lock in place")
        GameTooltip:AddLine("Right-click the note for more options.", 1, 1, 1)
        GameTooltip:Show()
    end)
    lockButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.LockButton = lockButton

    -------------------------------------------------
    -- Content (clipped by a scroll frame)
    -------------------------------------------------

    local scroll = CreateFrame("ScrollFrame", nil, frame)
    frame.Scroll = scroll

    local child = CreateFrame("Frame", nil, scroll)
    child:SetSize(10, 10)
    scroll:SetScrollChild(child)
    frame.Child = child

    local text = child:CreateFontString(nil, "OVERLAY")
    text:SetPoint("TOPLEFT", 0, 0)
    text:SetJustifyH("LEFT")
    text:SetJustifyV("TOP")
    text:SetNonSpaceWrap(true)
    frame.Text = text

    frame.Rows = {}

    scroll:SetScript("OnMouseWheel", function(sf, delta)
        local maximum = math.max(0, child:GetHeight() - sf:GetHeight())
        local position = math.max(0, math.min(maximum, sf:GetVerticalScroll() - delta * 20))
        sf:SetVerticalScroll(position)
    end)

    -------------------------------------------------
    -- Checklist Footer
    -------------------------------------------------

    local resetButton = ImpLoot.Theme:CreateMenuButton(frame)
    resetButton:SetSize(50, 16)
    resetButton:SetPoint("BOTTOMLEFT", PADDING, 3)
    resetButton:SetText("Reset")
    resetButton:SetScript("OnClick", function()
        Notes:ResetChecklist(frame.Note)
        self:Refresh(frame.Note)
    end)
    frame.ResetButton = resetButton

    local doneButton = ImpLoot.Theme:CreateMenuButton(frame)
    doneButton:SetSize(90, 16)
    doneButton:SetPoint("BOTTOMRIGHT", -PADDING, 3)
    doneButton:SetText("|cff40ff40All done|r - Close")
    doneButton:SetScript("OnClick", function() self:Hide(frame.Note) end)
    frame.DoneButton = doneButton

    -------------------------------------------------
    -- Resize Grip (unlocked only)
    -------------------------------------------------

    local grip = CreateFrame("Button", nil, frame)
    grip:SetSize(14, 14)
    grip:SetPoint("BOTTOMRIGHT", -1, 1)
    grip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    grip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    grip:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    grip:SetFrameLevel(frame:GetFrameLevel() + 10)

    grip:SetScript("OnMouseDown", function() frame:StartSizing("BOTTOMRIGHT") end)
    grip:SetScript("OnMouseUp", function()
        frame:StopMovingOrSizing()
        frame.Note.Width = math.floor(frame:GetWidth() + 0.5)
        frame.Note.Height = math.floor(frame:GetHeight() + 0.5)
        self:SavePosition(frame)
        self:Refresh(frame.Note)
    end)
    frame.Grip = grip

    frame:SetScript("OnSizeChanged", function()
        if frame:IsShown() then
            self:LayoutContent(frame)
        end
    end)

    -------------------------------------------------
    -- Drag + Right-Click
    -------------------------------------------------

    frame:RegisterForDrag("LeftButton")

    frame:SetScript("OnDragStart", function()
        if not frame.Note.Locked then
            frame:StartMoving()
        end
    end)

    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        self:SavePosition(frame)
    end)

    frame:SetScript("OnMouseUp", function(_, button)
        if button == "RightButton" then
            self:ShowMenu(frame)
        end
    end)

    return frame

end

-------------------------------------------------
-- Position
-------------------------------------------------

function NoteFrames:SavePosition(frame)

    local note = frame.Note

    note.Left = math.floor(frame:GetLeft() + 0.5)
    note.Top = math.floor(frame:GetTop() + 0.5)

end

function NoteFrames:ApplyLayout(frame)

    local note = frame.Note

    frame:SetSize(note.Width or 240, note.Height or 200)
    frame:ClearAllPoints()

    if note.Left and note.Top then
        frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", note.Left, note.Top)
    else
        -- New notes start near the left, stepped so several don't overlap
        local count = 0
        for _, other in pairs(self.Frames) do
            if other ~= frame and other:IsShown() then count = count + 1 end
        end
        frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 80 + count * 30, -160 - count * 30)
    end

end

-------------------------------------------------
-- Refresh (content + locked state)
-------------------------------------------------

function NoteFrames:Refresh(note)

    local frame = self.Frames and self.Frames[note]

    if not frame or not frame:IsShown() then
        return
    end

    Notes:Upgrade(note)

    local unlocked = not note.Locked
    local isChecklist = (note.Type == "Checklist")

    frame.Background:SetAlpha(note.Alpha or 0.5)

    SetShown(frame.Outline, unlocked)
    SetShown(frame.Title, unlocked)
    SetShown(frame.CloseButton, unlocked)
    SetShown(frame.LockButton, unlocked)
    SetShown(frame.Grip, unlocked)

    frame.Title:SetText(note.Name .. (note.Type ~= "Personal" and ("  |cff999999" .. (note.Boss or note.Type) .. "|r") or ""))

    -- Locked notes let clicks through; checklist rows and
    -- buttons keep their own mouse handling
    frame:EnableMouse(unlocked)
    frame.Scroll:EnableMouse(unlocked)
    -- (the mouse wheel too, so a locked note never eats camera zoom)
    frame.Scroll:EnableMouseWheel(unlocked)

    local allDone = isChecklist and Notes:AllChecked(note)

    SetShown(frame.ResetButton, isChecklist)
    SetShown(frame.DoneButton, allDone)

    self:LayoutContent(frame)

end

function NoteFrames:LayoutContent(frame)

    local note = frame.Note
    local unlocked = not note.Locked
    local isChecklist = (note.Type == "Checklist")
    local size = note.FontSize or 12

    local top = unlocked and (TITLE_HEIGHT + 2) or PADDING
    local bottom = isChecklist and (FOOTER_HEIGHT + 2) or PADDING

    frame.Scroll:ClearAllPoints()
    frame.Scroll:SetPoint("TOPLEFT", PADDING, -top)
    frame.Scroll:SetPoint("BOTTOMRIGHT", -PADDING, bottom)

    local width = math.max(20, (frame:GetWidth() or 200) - PADDING * 2)
    frame.Child:SetWidth(width)

    for _, row in ipairs(frame.Rows) do
        row:Hide()
    end

    if isChecklist then

        frame.Text:Hide()

        local y = 0

        for index, item in ipairs(Notes:GetItems(note)) do

            local row = frame.Rows[index] or self:CreateRow(frame, index)
            frame.Rows[index] = row

            local checked = Notes:IsChecked(note, item)

            row.Item = item
            row:SetWidth(width)
            row:SetHeight(size + 6)
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", frame.Child, "TOPLEFT", 0, -y)

            row.Check:SetSize(size + 2, size + 2)
            SetShown(row.CheckMark, checked)

            row.Label:SetFont(STANDARD_TEXT_FONT, size, "")
            row.Label:SetWidth(width - size - 8)
            row.Label:SetText(Notes:Render(item, size))

            if checked then
                row.Label:SetTextColor(0.5, 0.5, 0.5)
                row.Label:SetAlpha(0.8)
            else
                row.Label:SetTextColor(1, 1, 1)
                row.Label:SetAlpha(1)
            end

            row:Show()

            y = y + size + 6

        end

        frame.Child:SetHeight(math.max(1, y))

    else

        frame.Text:Show()
        frame.Text:SetFont(STANDARD_TEXT_FONT, size, "")
        frame.Text:SetTextColor(1, 1, 1)
        frame.Text:SetWidth(width)
        frame.Text:SetText(Notes:Render(note.Text, size))

        frame.Child:SetHeight(math.max(1, frame.Text:GetHeight()))

    end

end

function NoteFrames:CreateRow(frame, index)

    local row = CreateFrame("Button", nil, frame.Child)
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    local check = row:CreateTexture(nil, "ARTWORK")
    check:SetPoint("LEFT", 0, 0)
    check:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
    row.Check = check

    local mark = row:CreateTexture(nil, "OVERLAY")
    mark:SetAllPoints(check)
    mark:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
    row.CheckMark = mark

    local label = row:CreateFontString(nil, "OVERLAY")
    label:SetPoint("LEFT", check, "RIGHT", 4, 0)
    label:SetJustifyH("LEFT")
    row.Label = label

    local highlight = row:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture(1, 1, 1, 0.08)

    row:SetScript("OnClick", function(_, button)

        if button == "RightButton" then
            self:ShowMenu(frame)
            return
        end

        Notes:ToggleItem(frame.Note, row.Item)
        self:Refresh(frame.Note)

    end)

    return row

end

-------------------------------------------------
-- Right-Click Menu
-------------------------------------------------

function NoteFrames:ShowMenu(frame)

    local note = frame.Note

    local opacity = {}

    for _, value in ipairs(OPACITIES) do
        table.insert(opacity, {
            text = math.floor(value * 100) .. "%",
            checked = math.abs((note.Alpha or 0.5) - value) < 0.01,
            func = function()
                note.Alpha = value
                self:Refresh(note)
                CloseDropDownMenus()
            end,
        })
    end

    local sizes = {}

    for _, choice in ipairs(TEXT_SIZES) do
        table.insert(sizes, {
            text = choice.Label,
            checked = (note.FontSize or 12) == choice.Size,
            func = function()
                note.FontSize = choice.Size
                self:Refresh(note)
                CloseDropDownMenus()
            end,
        })
    end

    local menu = {
        { text = note.Name, isTitle = true, notCheckable = true },
        {
            text = note.Locked and "Unlock (move / resize)" or "Lock in place",
            notCheckable = true,
            func = function()
                note.Locked = not note.Locked
                self:Refresh(note)
            end,
        },
        {
            text = "Edit text...",
            notCheckable = true,
            func = function() ImpLoot.UI.RaidNotesPopup:ShowNote(note) end,
        },
        { text = "Background opacity", hasArrow = true, notCheckable = true, menuList = opacity },
        { text = "Text size", hasArrow = true, notCheckable = true, menuList = sizes },
    }

    if note.Type == "Checklist" then
        table.insert(menu, {
            text = "Reset checklist",
            notCheckable = true,
            func = function()
                Notes:ResetChecklist(note)
                self:Refresh(note)
            end,
        })
    end

    table.insert(menu, {
        text = "Send to...",
        hasArrow = true,
        notCheckable = true,
        menuList = self:SendMenuItems(note),
    })

    table.insert(menu, { text = "Hide", notCheckable = true, func = function() self:Hide(note) end })
    table.insert(menu, { text = "Cancel", notCheckable = true, func = function() end })

    EasyMenu(menu, self.Menu, "cursor", 0, 0, "MENU")

end

-------------------------------------------------
-- Send Menu (here and in the editor)
--
-- The raid (or party), your target if it's a player,
-- or a player you type in.
-------------------------------------------------

function NoteFrames:SendMenuItems(note, beforeSend)

    local function Send(channel, target)
        if beforeSend then beforeSend() end
        Notes:SendNote(note, channel, target)
        CloseDropDownMenus()
    end

    local items = {}
    local group = Notes:GroupChannel()

    table.insert(items, {
        text = (group == "PARTY") and "Your party" or "The raid",
        notCheckable = true,
        disabled = not group,
        func = function() Send("GROUP") end,
    })

    local target = UnitName("target")

    if target and UnitIsPlayer("target") and not UnitIsUnit("target", "player") then
        table.insert(items, {
            text = "Your target: " .. target,
            notCheckable = true,
            func = function() Send("WHISPER", target) end,
        })
    end

    table.insert(items, {
        text = "A player...",
        notCheckable = true,
        func = function()
            if beforeSend then beforeSend() end
            CloseDropDownMenus()
            local dialog = StaticPopup_Show("IMPLOOT_SEND_NOTE_TO", note.Name, nil, note)
            if dialog then
                dialog:SetFrameStrata("TOOLTIP")
            end
        end,
    })

    return items

end

function NoteFrames:ShowSendMenu(note, beforeSend)

    local items = self:SendMenuItems(note, beforeSend)
    table.insert(items, 1, { text = "Send \"" .. note.Name .. "\" to", isTitle = true, notCheckable = true })
    table.insert(items, { text = "Cancel", notCheckable = true, func = function() end })

    EasyMenu(items, self.Menu, "cursor", 0, 0, "MENU")

end

StaticPopupDialogs["IMPLOOT_SEND_NOTE_TO"] = {
    text = "Send \"%s\" to which player?",
    button1 = "Send",
    button2 = "Cancel",
    hasEditBox = 1,
    maxLetters = 40,
    OnAccept = function(dialog, note)
        local name = _G[dialog:GetName() .. "EditBox"]:GetText()
        if note and name and name ~= "" then
            ImpLoot.RaidNotes:SendNote(note, "WHISPER", name)
        end
    end,
    EditBoxOnEnterPressed = function(editBox)
        local dialog = editBox:GetParent()
        StaticPopupDialogs["IMPLOOT_SEND_NOTE_TO"].OnAccept(dialog, dialog.data)
        dialog:Hide()
    end,
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    OnShow = function(dialog)
        _G[dialog:GetName() .. "EditBox"]:SetText("")
        _G[dialog:GetName() .. "EditBox"]:SetFocus()
    end,
    OnHide = function(dialog)
        dialog:SetFrameStrata("DIALOG")
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
}
