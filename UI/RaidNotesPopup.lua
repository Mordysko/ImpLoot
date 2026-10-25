-------------------------------------------------
-- Note Editor
--
-- Edits one note's text. A toolbar above the text
-- inserts icons at the cursor -- raid markers, class
-- icons, role icons -- and a colour palette inserts a
-- "pen" colour: everything you type is in it until you
-- pick another (white = normal text). Highlighted text is
-- recoloured. The pen colour is outlined in the palette.
-- What you type shows the icons as {skull}, {mage}
-- etc.; the on-screen note shows the real icons.
--
-- (Kept under its old name, RaidNotesPopup, since the
-- rest of the addon already refers to it.)
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.RaidNotesPopup = ImpLoot.UI.RaidNotesPopup or {}
local Editor = ImpLoot.UI.RaidNotesPopup

local Notes = ImpLoot.RaidNotes

local WIDTH, HEIGHT = 520, 470
local ICON = 20

local MARKERS = { "star", "circle", "diamond", "triangle", "moon", "square", "cross", "skull" }
local ROLES = { "tank", "healer", "dps" }
local CLASSES = { "warrior", "paladin", "hunter", "rogue", "priest", "deathknight", "shaman", "mage", "warlock", "druid" }

local PALETTE = {
    "ff2020", "ff8000", "ffd100", "ffff00", "80ff00", "00ff00", "00ffa0", "00ffff",
    "40a0ff", "0060ff", "8080ff", "a335ee", "ff40ff", "ff80c0", "ffffff", "a0a0a0",
    "c41f3b", "f58cba", "abd473", "fff569", "69ccf0", "0070de", "9482c9", "c79c6e",
}

local function SetShown(region, shown)
    if shown then region:Show() else region:Hide() end
end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function Editor:Initialize()

    local window = CreateFrame("Frame", "ImpLootNoteEditor", UIParent)
    self.Window = window

    window:SetSize(WIDTH, HEIGHT)
    window:SetPoint("CENTER")
    window:SetFrameStrata("DIALOG")
    window:SetToplevel(true)
    window:EnableMouse(true)
    window:SetMovable(true)
    window:SetClampedToScreen(true)

    ImpLoot.Theme:ApplySolidPanelStyle(window)

    window:Hide()

    table.insert(UISpecialFrames, "ImpLootNoteEditor")
    window:SetScript("OnHide", function() self:Save() end)

    local titleBar = CreateFrame("Frame", nil, window)
    titleBar:SetPoint("TOPLEFT", 4, -4)
    titleBar:SetPoint("TOPRIGHT", -4, -4)
    titleBar:SetHeight(24)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() window:StartMoving() end)
    titleBar:SetScript("OnDragStop", function() window:StopMovingOrSizing() end)

    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", 6, 0)
    self.Title = title

    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", 2, 0)
    closeButton:SetScript("OnClick", function() window:Hide() end)

    -------------------------------------------------
    -- Toolbar: markers + roles, then classes
    -------------------------------------------------

    local function IconButton(token, anchor, x, y)

        local button = CreateFrame("Button", nil, window)
        button:SetSize(ICON, ICON)
        button:SetPoint("TOPLEFT", anchor, "TOPLEFT", x, y)

        local texture, coords = Notes:ToolbarIcon(token)
        local icon = button:CreateTexture(nil, "ARTWORK")
        icon:SetAllPoints()
        icon:SetTexture(texture)
        icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])

        button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

        button:SetScript("OnClick", function() self:Insert("{" .. token .. "}") end)
        button:SetScript("OnEnter", function()
            GameTooltip:SetOwner(button, "ANCHOR_TOP")
            GameTooltip:SetText("{" .. token .. "}")
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function() GameTooltip:Hide() end)

        return button

    end

    local row1 = CreateFrame("Frame", nil, window)
    row1:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 8, -6)
    row1:SetSize(10, ICON)

    local x = 0

    for _, token in ipairs(MARKERS) do
        IconButton(token, row1, x, 0)
        x = x + ICON + 3
    end

    x = x + 10

    for _, token in ipairs(ROLES) do
        IconButton(token, row1, x, 0)
        x = x + ICON + 3
    end

    local row2 = CreateFrame("Frame", nil, window)
    row2:SetPoint("TOPLEFT", row1, "BOTTOMLEFT", 0, -4)
    row2:SetSize(10, ICON)

    x = 0

    for _, token in ipairs(CLASSES) do
        IconButton(token, row2, x, 0)
        x = x + ICON + 3
    end

    -------------------------------------------------
    -- Colour Palette
    -------------------------------------------------

    local paletteLabel = window:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    paletteLabel:SetPoint("TOPLEFT", row2, "BOTTOMLEFT", 0, -8)
    paletteLabel:SetText("Text colour:")

    local swatchSize = 14
    x = 0

    for index, hex in ipairs(PALETTE) do

        local swatch = CreateFrame("Button", nil, window)
        swatch:SetSize(swatchSize, swatchSize)

        local column = (index - 1) % 12
        local line = math.floor((index - 1) / 12)

        swatch:SetPoint("TOPLEFT", paletteLabel, "BOTTOMLEFT", column * (swatchSize + 3), -4 - line * (swatchSize + 3))

        local fill = swatch:CreateTexture(nil, "ARTWORK")
        fill:SetAllPoints()
        fill:SetTexture(tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255)

        swatch:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

        -- Outline for "the colour you're typing in"
        local selected = CreateFrame("Frame", nil, swatch)
        selected:SetPoint("TOPLEFT", -2, 2)
        selected:SetPoint("BOTTOMRIGHT", 2, -2)
        selected:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 2 })
        selected:SetBackdropBorderColor(1, 1, 1, 1)
        selected:Hide()
        swatch.Selected = selected
        swatch.Hex = hex

        swatch:SetScript("OnClick", function() self:PickColour(hex) end)

        self.Swatches = self.Swatches or {}
        table.insert(self.Swatches, swatch)

    end

    local paletteHint = window:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    paletteHint:SetPoint("TOPLEFT", paletteLabel, "BOTTOMLEFT", 12 * (swatchSize + 3) + 8, -4)
    paletteHint:SetPoint("RIGHT", window, "RIGHT", -10, 0)
    paletteHint:SetJustifyH("LEFT")
    paletteHint:SetText("Picks the colour you type in (white for normal). Highlight text first to recolour it.")

    -------------------------------------------------
    -- Text
    -------------------------------------------------

    local textArea = CreateFrame("Frame", nil, window)
    textArea:SetPoint("TOPLEFT", paletteLabel, "BOTTOMLEFT", -2, -4 - 2 * (swatchSize + 3) - 6)
    textArea:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -10, 46)
    ImpLoot.Theme:ApplySolidPanelStyle(textArea)

    local scroll = CreateFrame("ScrollFrame", "ImpLootNoteEditorScroll", textArea, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 6, -6)
    scroll:SetPoint("BOTTOMRIGHT", -6, 6)
    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(scroll)

    local editBox = CreateFrame("EditBox", nil, scroll)
    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetAutoFocus(false)
    editBox:SetWidth(WIDTH - 40)
    editBox:SetHeight(200)
    editBox:SetTextInsets(2, 2, 2, 2)
    editBox:SetScript("OnEscapePressed", function() window:Hide() end)
    editBox:SetScript("OnCursorChanged", function(_, _, y, _, height)
        -- keep the cursor in view while typing
        local top = scroll:GetVerticalScroll()
        local bottom = top + scroll:GetHeight()
        y = -y
        if y < top then
            scroll:SetVerticalScroll(y)
        elseif y + height > bottom then
            scroll:SetVerticalScroll(y + height - scroll:GetHeight())
        end
        self:UpdateSwatches()
    end)
    -- OnChar can arrive before or after the character is in
    -- the text, depending on the client: handle it whichever
    -- way, once.
    editBox:SetScript("OnChar", function(_, char)
        if self:ApplyPen(char) == false then
            self.PendingChar = char
        end
    end)

    editBox:SetScript("OnTextChanged", function()
        if self.PendingChar and not self.Applying then
            local char = self.PendingChar
            self.PendingChar = nil
            self:ApplyPen(char)
        end
        if scroll.UpdateScrollIndicators then
            scroll:UpdateScrollIndicators()
        end
    end)
    scroll:SetScrollChild(editBox)
    self.EditBox = editBox

    -- Clicking anywhere in the text area puts the cursor in the box
    textArea:EnableMouse(true)
    textArea:SetScript("OnMouseDown", function() editBox:SetFocus() end)

    scroll:EnableMouseWheel(true)
    scroll:SetScript("OnMouseWheel", function(sf, delta)
        local maximum = sf:GetVerticalScrollRange()
        sf:SetVerticalScroll(math.max(0, math.min(maximum, sf:GetVerticalScroll() - delta * 20)))
        if sf.UpdateScrollIndicators then sf:UpdateScrollIndicators() end
    end)

    -------------------------------------------------
    -- Bottom Row
    -------------------------------------------------

    local hint = titleBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    hint:SetPoint("LEFT", title, "RIGHT", 10, 0)
    hint:SetPoint("RIGHT", titleBar, "RIGHT", -30, 0)
    hint:SetJustifyH("LEFT")
    self.Hint = hint

    -------------------------------------------------
    -- Text Size + Background Sliders (this note)
    -------------------------------------------------

    local function Slider(name, label, minValue, maxValue, step, x, format, onChange)

        local slider = CreateFrame("Slider", name, window, "OptionsSliderTemplate")
        slider:SetWidth(120)
        slider:SetHeight(16)
        slider:SetPoint("BOTTOMLEFT", window, "BOTTOMLEFT", x, 14)
        slider:SetMinMaxValues(minValue, maxValue)
        slider:SetValueStep(step)

        _G[name .. "Low"]:SetText("")
        _G[name .. "High"]:SetText("")

        local text = _G[name .. "Text"]

        slider:SetScript("OnValueChanged", function(_, value)

            value = math.floor(value / step + 0.5) * step
            text:SetText(label .. ": " .. string.format(format, value))

            if not self.Loading then
                onChange(value)
            end

        end)

        return slider

    end

    self.SizeSlider = Slider("ImpLootNoteEditorSize", "Text size", 8, 24, 1, 16, "%d", function(value)
        if self.Note then
            self.Note.FontSize = value
            ImpLoot.UI.NoteFrames:Refresh(self.Note)
        end
    end)

    self.AlphaSlider = Slider("ImpLootNoteEditorAlpha", "Background", 0, 100, 5, 152, "%d%%", function(value)
        if self.Note then
            self.Note.Alpha = value / 100
            ImpLoot.UI.NoteFrames:Refresh(self.Note)
        end
    end)

    local saveButton = ImpLoot.Theme:CreateMenuButton(window)
    saveButton:SetSize(70, 22)
    saveButton:SetPoint("BOTTOMRIGHT", -10, 10)
    saveButton:SetText("Save")
    saveButton:SetScript("OnClick", function() window:Hide() end)

    local showButton = ImpLoot.Theme:CreateMenuButton(window)
    showButton:SetSize(120, 22)
    showButton:SetPoint("RIGHT", saveButton, "LEFT", -6, 0)
    showButton:SetScript("OnClick", function()
        if self.Note then
            self:Save()
            ImpLoot.UI.NoteFrames:Toggle(self.Note)
            self:UpdateShowButton()
        end
    end)
    self.ShowButton = showButton

end

-------------------------------------------------
-- Insert
-------------------------------------------------

function Editor:Insert(text)

    self.EditBox:SetFocus()
    self.EditBox:Insert(text)

end

-- The colour the text at `position` is in (6 hex digits),
-- or nil for normal text
local function ColourAt(text, position)

    local before = text:sub(1, position)
    local colour, colourEnd

    for start, hex in before:gmatch("()|c%x%x(%x%x%x%x%x%x)") do
        colour, colourEnd = hex:lower(), start
    end

    if not colour then
        return nil
    end

    -- closed again before the cursor?
    if before:find("|r", colourEnd, true) then
        return nil
    end

    return colour

end

function Editor:CurrentColour()

    local box = self.EditBox

    if not box.GetCursorPosition then
        return nil
    end

    return ColourAt(box:GetText() or "", box:GetCursorPosition())

end

-- Palette click:
--   text highlighted               -> that text changes colour
--   same colour as the cursor's   -> step out of it (normal text)
--   inside another colour          -> switch colour from here
--   normal text                    -> start a coloured section
-- Removes colour codes that do nothing: a colour that's
-- replaced or closed before any text, and a close with no
-- colour open. Recolouring leaves a few of those behind.
local function TidyColours(text)

    local out = {}
    local open = false
    local pendingColour
    local openColour, lastClosed
    local i = 1

    while i <= #text do

        local colour = text:match("^|c%x%x%x%x%x%x%x%x", i)

        if colour then

            pendingColour = colour
            i = i + #colour

        elseif text:sub(i, i + 1) == "|r" then

            if pendingColour then
                pendingColour = nil
            elseif open then
                table.insert(out, "|r")
                open = false
                lastClosed = openColour
            end

            i = i + 2

        else

            if pendingColour then

                if out[#out] == "|r" and lastClosed and lastClosed:lower() == pendingColour:lower() then
                    -- "...|r|cffSAME..." : just carry on in that colour
                    table.remove(out)
                else
                    table.insert(out, pendingColour)
                end

                open = true
                openColour = pendingColour
                pendingColour = nil

            end

            lastClosed = nil
            table.insert(out, text:sub(i, i))
            i = i + 1

        end

    end

    -- a colour picked at the very end, waiting for text
    if pendingColour then
        table.insert(out, pendingColour)
        open = true
    end

    return table.concat(out)

end

-- If text is highlighted, colour just that text and return
-- true. (The 3.3.5 edit box can't report its selection, so
-- this types a marker character -- which replaces the
-- selection, like any typing does -- and works out what was
-- replaced by comparing before and after.)
function Editor:ColourSelection(hex)

    local box = self.EditBox
    local before = box:GetText() or ""

    box:Insert("\001")

    local after = box:GetText() or ""
    local marker = after:find("\001", 1, true)

    if not marker then
        return false
    end

    local removed = #before - (#after - 1)

    if removed <= 0 then
        -- nothing was highlighted: take the marker back out
        box:SetText(before)
        box:SetCursorPosition(marker - 1)
        return false
    end

    local selection = before:sub(marker, marker + removed - 1)

    -- drop colour codes inside it, so it's all one colour
    local clean = selection:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")

    -- whatever colour the text after the selection was in carries on
    local following = ColourAt(before, marker - 1 + removed)

    -- (unless that colour ends right there anyway)
    if after:sub(marker + 1, marker + 2) == "|r" then
        following = nil
    end

    local replacement = "|cff" .. hex .. clean .. "|r" .. (following and ("|cff" .. following) or "")

    local upToEnd = after:sub(1, marker - 1) .. replacement

    box:SetText(TidyColours(upToEnd .. after:sub(marker + 1)))
    box:SetCursorPosition(#TidyColours(upToEnd))

    return true

end

function Editor:PickColour(hex)

    local box = self.EditBox
    box:SetFocus()

    -- White is "normal text"
    self.PenColour = (hex:lower() ~= "ffffff") and hex:lower() or nil

    self:ColourSelection(hex)
    self:UpdateSwatches()

end

-------------------------------------------------
-- Typing In The Pen Colour
--
-- After each typed character: if the text at that spot
-- isn't already in the pen colour, the character is
-- wrapped in it (or, with white picked, taken out of the
-- colour around it), and the cursor is left inside, so
-- the following characters just carry on in it.
-------------------------------------------------

function Editor:ApplyPen(char)

    if self.Applying or not char or char == "" then
        return
    end

    local box = self.EditBox
    local text = box:GetText() or ""
    local position = box:GetCursorPosition()
    local start = position - #char

    if start < 0 or text:sub(start + 1, position) ~= char then
        return false
    end

    local pen = self.PenColour
    local around = ColourAt(text, start)

    if pen == around then
        return true
    end

    local before, after = text:sub(1, start), text:sub(position + 1)
    local newText, cursor

    if pen then

        -- [pen]char|  then whatever colour followed carries on
        local resume = around and ("|cff" .. around) or ""
        newText = before .. "|cff" .. pen .. char .. "|r" .. resume .. after
        cursor = start + 10 + #char

    else

        -- leave the colour for this character
        newText = before .. "|r" .. char .. "|cff" .. around .. after
        cursor = start + 2 + #char

    end

    self.Applying = true
    box:SetText(TidyColours(newText))
    box:SetCursorPosition(#TidyColours(newText:sub(1, cursor)))
    self.Applying = false

    return true

end

-- The palette outline shows the pen colour (white when none)
function Editor:UpdateSwatches()

    local pen = self.PenColour or "ffffff"

    for _, swatch in ipairs(self.Swatches or {}) do
        SetShown(swatch.Selected, swatch.Hex:lower() == pen)
    end

end

-------------------------------------------------
-- Show / Save
-------------------------------------------------

function Editor:UpdateShowButton()

    if not self.Note then
        return
    end

    local character = ImpLoot.Character:GetCurrent()
    local own = false

    for _, note in ipairs(ImpLoot.RaidNotes:GetNotes(character)) do
        if note == self.Note then own = true end
    end

    if own then
        self.ShowButton:Enable()
        self.ShowButton:SetText(ImpLoot.UI.NoteFrames:IsShown(self.Note) and "Hide on screen" or "Show on screen")
    else
        -- another character's note (viewed from the Characters page)
        self.ShowButton:Disable()
        self.ShowButton:SetText("Show on screen")
    end

end

function Editor:ShowNote(note)

    if not note then
        return
    end

    Notes:Upgrade(note)

    self.Note = note
    self.Title:SetText(note.Name .. "  |cff999999(" .. note.Type .. ")|r")
    self.EditBox:SetText(note.Text or "")

    if note.Type == "Checklist" then
        self.Hint:SetText("One item per line. Resets: " .. (note.Reset or "Daily") .. ".")
    elseif note.Type == "Raid" then
        self.Hint:SetText("Linking to a boss comes next build.")
    else
        self.Hint:SetText("")
    end

    self.Loading = true
    self.SizeSlider:SetValue(note.FontSize or 12)
    self.AlphaSlider:SetValue(math.floor((note.Alpha or 0.5) * 100 + 0.5))
    self.Loading = false

    self:UpdateShowButton()

    self.PenColour = nil
    self.PendingChar = nil

    self.Window:Show()
    self.Window:Raise()
    self.EditBox:SetFocus()
    self:UpdateSwatches()

end

-- The selected note of the viewed character (Notes page)
function Editor:Show()

    local character = ImpLoot.Character:GetViewed()
    self:ShowNote(ImpLoot.RaidNotes:GetActive(character))

end

function Editor:Close()

    if self.Window and self.Window:IsShown() then
        self.Window:Hide()   -- saves (OnHide)
    end

end

function Editor:Save()

    if self.Note and self.EditBox then
        ImpLoot.RaidNotes:SetText(self.Note, self.EditBox:GetText())
    end

end
