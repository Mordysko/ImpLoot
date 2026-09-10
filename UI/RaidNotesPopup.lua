-------------------------------------------------
-- Raid Notes Popup
--
-- The actual text-editing surface for whichever note
-- is active -- same edit-box-fills-a-bordered-frame
-- approach as ImportDialog's CSV paste box (anchored
-- by both corners, not a fixed size, so it reliably
-- fills its container rather than risking the
-- zero-height mistake from the inline attempt).
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.RaidNotesPopup = ImpLoot.UI.RaidNotesPopup or {}
local RaidNotesPopup = ImpLoot.UI.RaidNotesPopup

-------------------------------------------------
-- Initialize
-------------------------------------------------

function RaidNotesPopup:Initialize()

    local window = CreateFrame("Frame", "ImpLootRaidNotesPopup", UIParent)
    self.Window = window

    window:SetSize(420, 320)
    window:SetPoint("CENTER")
    window:SetFrameStrata("DIALOG")

    window:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })

    window:SetBackdropColor(0.08, 0.08, 0.08, 0.98)
    window:Hide()

    local title = window:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    self.Title = title

    -------------------------------------------------
    -- Edit Box
    -------------------------------------------------

    local editBoxBackground = CreateFrame("Frame", nil, window)
    editBoxBackground:SetPoint("TOPLEFT", 20, -45)
    editBoxBackground:SetPoint("BOTTOMRIGHT", -20, 50)

    editBoxBackground:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })

    editBoxBackground:SetBackdropColor(0.02, 0.02, 0.02, 1)

    local editBox = CreateFrame("EditBox", nil, editBoxBackground)
    self.EditBox = editBox

    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetAutoFocus(false)
    editBox:SetPoint("TOPLEFT", 8, -8)
    editBox:SetPoint("BOTTOMRIGHT", -8, 8)
    editBox:SetText("")
    editBox:EnableMouse(true)

    editBox:SetScript("OnEscapePressed", function()
        RaidNotesPopup:Save()
        window:Hide()
    end)

    -------------------------------------------------
    -- Save Button
    -------------------------------------------------

    local saveButton = ImpLoot.Theme:CreateMenuButton(window)
    self.SaveButton = saveButton
    saveButton:SetSize(90, 24)
    saveButton:SetPoint("BOTTOMRIGHT", -15, 15)
    saveButton:SetText("Save")

    saveButton:SetScript("OnClick", function()
        self:Save()
        window:Hide()
    end)

    -------------------------------------------------
    -- Close Button (Top Right)
    -------------------------------------------------

    local closeButton = CreateFrame("Button", nil, window, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -4, -4)

    closeButton:SetScript("OnClick", function()
        self:Save()
        window:Hide()
    end)

end

-------------------------------------------------
-- Show
--
-- Opens the popup on the currently active note for
-- the viewed character. Does nothing (rather than
-- error) if there's no active note to edit.
-------------------------------------------------

function RaidNotesPopup:Show()

    local character = ImpLoot.Character:GetViewed()
    local note = ImpLoot.RaidNotes:GetActive(character)

    if not note then
        return
    end

    self.Title:SetText(note.Name)
    self.EditBox:SetText(note.Text or "")

    self.Window:Show()

    self.EditBox:SetFocus()

end

-------------------------------------------------
-- Save
--
-- Writes back to whichever note was active when the
-- popup opened -- not whatever's active NOW, in case
-- something changed it out from under the popup.
-------------------------------------------------

function RaidNotesPopup:Save()

    local character = ImpLoot.Character:GetViewed()
    local note = ImpLoot.RaidNotes:GetActive(character)

    if not note then
        return
    end

    ImpLoot.RaidNotes:SetText(note, self.EditBox:GetText())

end
