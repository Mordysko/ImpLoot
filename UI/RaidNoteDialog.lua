-------------------------------------------------
-- Raid Note Dialog
--
-- Create / Rename / Delete name prompt -- exact
-- mirror of WishlistDialog.lua, targeting
-- RaidNotes instead of Wishlist.
-------------------------------------------------

local ImpLoot = ImpLoot

ImpLoot.UI = ImpLoot.UI or {}

local RaidNoteDialog = {}
ImpLoot.UI.RaidNoteDialog = RaidNoteDialog

RaidNoteDialog.Mode = "Create"
RaidNoteDialog.TargetNote = nil

function RaidNoteDialog:Initialize()

    if self.Frame then
        return
    end

    local frame = CreateFrame("Frame", "ImpLootRaidNoteDialog", UIParent)
    self.Frame = frame

    frame:SetSize(320, 150)
    frame:SetPoint("CENTER")
    -- Always on top of everything (the note editor included)
    frame:SetFrameStrata("TOOLTIP")
    frame:SetToplevel(true)
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = {
            left = 4,
            right = 4,
            top = 4,
            bottom = 4,
        },
    })

    frame:SetBackdropColor(0.08, 0.08, 0.08, 0.95)

    frame:Hide()

    -------------------------------------------------
    -- Header
    -------------------------------------------------

    local header = CreateFrame("Frame", nil, frame)
    self.Header = header

    header:SetPoint("TOPLEFT", 4, -4)
    header:SetPoint("TOPRIGHT", -4, -4)
    header:SetHeight(28)

    header:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    })

    header:SetBackdropColor(0.16, 0.16, 0.16, 0.95)

    local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("CENTER")
    title:SetText("Create Note")
    self.Title = title

    -------------------------------------------------
    -- Close Button
    -------------------------------------------------

    local closeButton = CreateFrame(
        "Button",
        nil,
        header,
        "UIPanelCloseButton"
    )

    closeButton:SetPoint("RIGHT", 2, 0)

    closeButton:SetScript("OnClick", function()

        RaidNoteDialog:Hide()

    end)

    self.CloseButton = closeButton

    -------------------------------------------------
    -- Name Label
    -------------------------------------------------

    local nameLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")

    self.NameLabel = nameLabel

    nameLabel:SetPoint("TOPLEFT", 20, -54)
    nameLabel:SetText("Note Name")

    -------------------------------------------------
    -- Name Box
    -------------------------------------------------

    local editBox = CreateFrame("EditBox", "ImpLootRaidNoteDialogEditBox", frame, "InputBoxTemplate")
    self.EditBox = editBox

    editBox:SetSize(260, 24)
    editBox:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -8)

    editBox:SetAutoFocus(false)
    editBox:SetMaxLetters(40)

    -------------------------------------------------
    -- Message
    -------------------------------------------------

    local message = frame:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormal"
    )

    self.Message = message

    message:SetPoint("TOP", editBox, "BOTTOM", 0, -12)
    message:SetWidth(260)
    message:SetJustifyH("CENTER")
    message:Hide()

    -------------------------------------------------
    -- Note Type (Create only) + Checklist Reset
    -------------------------------------------------

    local function ChoiceRow(label, choices, anchor, yOffset, onPick)

        local caption = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        caption:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, yOffset)
        caption:SetText(label)

        local buttons = {}
        local previous

        for _, choice in ipairs(choices) do

            local button = ImpLoot.Theme:CreateMenuButton(frame)
            button:SetSize(82, 20)

            if previous then
                button:SetPoint("LEFT", previous, "RIGHT", 4, 0)
            else
                button:SetPoint("TOPLEFT", caption, "BOTTOMLEFT", 0, -6)
            end

            button:SetText(choice)
            button.Choice = choice
            button:SetScript("OnClick", function() onPick(choice) end)

            table.insert(buttons, button)
            previous = button

        end

        return caption, buttons

    end

    self.TypeCaption, self.TypeButtons = ChoiceRow("Type", ImpLoot.RaidNotes.TYPES, editBox, -10, function(choice)
        RaidNoteDialog.NoteType = choice
        RaidNoteDialog:UpdateChoices()
    end)

    self.ResetCaption, self.ResetButtons = ChoiceRow("Checklist resets", ImpLoot.RaidNotes.RESETS, self.TypeButtons[1], -10, function(choice)
        RaidNoteDialog.Reset = choice
        RaidNoteDialog:UpdateChoices()
    end)

    local typeHelp = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    typeHelp:SetPoint("TOPLEFT", self.ResetButtons[1], "BOTTOMLEFT", 0, -8)
    typeHelp:SetWidth(270)
    typeHelp:SetJustifyH("LEFT")
    self.TypeHelp = typeHelp

    -------------------------------------------------
    -- Create Button
    -------------------------------------------------

    local create = CreateFrame(
        "Button",
        nil,
        frame,
        "UIPanelButtonTemplate"
    )

    self.CreateButton = create

    create:SetSize(100, 22)
    create:SetPoint("BOTTOM", 0, 16)
    create:SetText("Create")

    create:SetScript("OnClick", function()

        local name = RaidNoteDialog.EditBox:GetText()

        if RaidNoteDialog.Mode ~= "Delete" then

            if name == "" then
                return
            end

        end

        local character = ImpLoot.Character:GetViewed()

        if not character then
            return
        end

        local success

        if RaidNoteDialog.Mode == "Rename" then

            success = ImpLoot.RaidNotes:RenameNote(
                character,
                RaidNoteDialog.TargetNote,
                name
            )

        elseif RaidNoteDialog.Mode == "Delete" then

            success = ImpLoot.RaidNotes:DeleteNote(
                character,
                RaidNoteDialog.TargetNote
            )

        else

            success = ImpLoot.RaidNotes:CreateNote(character, name, RaidNoteDialog.NoteType, RaidNoteDialog.Reset)

            if success then
                -- show its type in the drawer's list, select it and
                -- open it for writing straight away
                ImpLoot.UI.PlanningDrawer.NotesFilter = RaidNoteDialog.NoteType
                local note = ImpLoot.RaidNotes:GetNote(character, name)
                ImpLoot.RaidNotes:SetActive(character, note)
                RaidNoteDialog.OpenAfter = note
            end

        end

        if success then

            RaidNoteDialog:Configure("Create")

            ImpLoot.UI.PlanningDrawer:Refresh()
            RaidNoteDialog:Hide()

            if RaidNoteDialog.OpenAfter then
                ImpLoot.UI.RaidNotesPopup:ShowNote(RaidNoteDialog.OpenAfter)
                RaidNoteDialog.OpenAfter = nil
            end

        end

    end)

end

-------------------------------------------------
-- Configure
-------------------------------------------------

function RaidNoteDialog:Configure(mode, note)

    self.Mode = mode or "Create"
    self.TargetNote = note

end

local TYPE_HELP = {
    Personal = "Free text, shown on screen.",
    Checklist = "One item per line. Click an item on screen to tick it.",
    Raid = "Notes for a fight. Linking it to a boss comes next build.",
}

function RaidNoteDialog:SetCreateWidgetsShown(shown)

    local widgets = { self.TypeCaption, self.TypeHelp }

    for _, button in ipairs(self.TypeButtons) do table.insert(widgets, button) end

    for _, widget in ipairs(widgets) do
        if shown then widget:Show() else widget:Hide() end
    end

    local resetShown = shown and self.NoteType == "Checklist"

    for _, widget in ipairs(self.ResetButtons) do
        if resetShown then widget:Show() else widget:Hide() end
    end

    if resetShown then self.ResetCaption:Show() else self.ResetCaption:Hide() end

    self.TypeHelp:ClearAllPoints()

    if resetShown then
        self.TypeHelp:SetPoint("TOPLEFT", self.ResetButtons[1], "BOTTOMLEFT", 0, -8)
    else
        self.TypeHelp:SetPoint("TOPLEFT", self.TypeButtons[1], "BOTTOMLEFT", 0, -8)
    end

    self.Frame:SetHeight(shown and (resetShown and 290 or 240) or 150)

end

function RaidNoteDialog:UpdateChoices()

    for _, button in ipairs(self.TypeButtons) do
        if button.Choice == self.NoteType then
            button:SetText("|cffffffff" .. button.Choice .. "|r")
            button:LockHighlight()
        else
            button:SetText(button.Choice)
            button:UnlockHighlight()
        end
    end

    for _, button in ipairs(self.ResetButtons) do
        if button.Choice == self.Reset then
            button:SetText("|cffffffff" .. button.Choice .. "|r")
            button:LockHighlight()
        else
            button:SetText(button.Choice)
            button:UnlockHighlight()
        end
    end

    self.TypeHelp:SetText(TYPE_HELP[self.NoteType] or "")

    self:SetCreateWidgetsShown(self.Mode ~= "Rename" and self.Mode ~= "Delete")

end

function RaidNoteDialog:Show()

    if self.Mode == "Rename" and self.TargetNote then

        self.Title:SetText("Rename Note")
        self.CreateButton:SetText("Rename")

        self.NameLabel:Show()

        self.EditBox:Show()
        self.Message:ClearAllPoints()
        self.Message:SetPoint("TOP", self.EditBox, "BOTTOM", 0, -12)
        self.Message:Hide()

        self.EditBox:SetText(self.TargetNote.Name)

        self.EditBox:SetFocus()
        self.EditBox:HighlightText()

    elseif self.Mode == "Delete" and self.TargetNote then

        self.Title:SetText("Delete Note")
        self.CreateButton:SetText("Delete")

        self.NameLabel:Hide()

        self.EditBox:Hide()

        self.Message:ClearAllPoints()
        self.Message:SetPoint("TOP", self.Title, "BOTTOM", 0, -40)

        self.Message:SetText(
            "Delete note:\n\n|cffffffff"
            .. self.TargetNote.Name ..
            "|r"
        )

        self.Message:Show()

    else

        self.Title:SetText("Create Note")
        self.CreateButton:SetText("Create")

        self.NameLabel:Show()

        self.EditBox:Show()

        self.Message:ClearAllPoints()
        self.Message:SetPoint("TOP", self.EditBox, "BOTTOM", 0, -12)
        self.Message:Hide()

        self.EditBox:SetText("")

        self.EditBox:SetFocus()
        self.EditBox:HighlightText()

        self.NoteType = "Personal"
        self.Reset = "Daily"

    end

    self:UpdateChoices()

    self.Frame:Show()

end

function RaidNoteDialog:Hide()

    self.EditBox:ClearFocus()
    self.Frame:Hide()

end
