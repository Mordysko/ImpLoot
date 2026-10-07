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
    frame:SetFrameStrata("DIALOG")
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

            success = ImpLoot.RaidNotes:CreateNote(character, name)

        end

        if success then

            RaidNoteDialog:Configure("Create")

            ImpLoot.UI.PlanningDrawer:Refresh()
            RaidNoteDialog:Hide()

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

    end

    self.Frame:Show()

end

function RaidNoteDialog:Hide()

    self.EditBox:ClearFocus()
    self.Frame:Hide()

end
