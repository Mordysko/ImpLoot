-------------------------------------------------
-- Import Dialog
--
-- The "Import CSV" button and its modal window for
-- pasting a SoftRes.it CSV export.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.ImportDialog = ImpLoot.UI.ImportDialog or {}
local ImportDialog = ImpLoot.UI.ImportDialog

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImportDialog:Initialize(mainWindowFrame)

    -------------------------------------------------
    -- Open Button
    -------------------------------------------------

    local openButton = ImpLoot.Theme:CreateMenuButton(mainWindowFrame)
    self.OpenButton = openButton

    openButton:SetSize(100, 24)
    openButton:SetPoint("BOTTOMRIGHT", -5, 5)
    openButton:SetText("Import CSV")

    openButton:SetScript("OnClick", function()
        self.Window:Show()
    end)

    -------------------------------------------------
    -- Window
    -------------------------------------------------

    local window = CreateFrame("Frame", nil, mainWindowFrame)
    self.Window = window

    window:SetSize(500, 350)
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
    title:SetText("Import SoftRes.it CSV")

    local label = window:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("TOPLEFT", 20, -45)
    label:SetText("Paste the SoftRes.it CSV export below.")

    -------------------------------------------------
    -- Edit Box
    -------------------------------------------------

    local editBoxBackground = CreateFrame("Frame", nil, window)
    editBoxBackground:SetPoint("TOPLEFT", 20, -65)
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

    -------------------------------------------------
    -- Scroll Frame
    --
    -- A plain EditBox doesn't clip or scroll its own
    -- content -- a long pasted CSV just kept growing
    -- downward past the visible box, overlapping
    -- whatever was behind it. Wrapping it in a real
    -- ScrollFrame gives it a scrollbar and clips
    -- everything to the visible area, same pattern
    -- used elsewhere in the addon for long content.
    -------------------------------------------------

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootImportDialogScrollFrame",
        editBoxBackground,
        "UIPanelScrollFrameTemplate"
    )

    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    self.EditBox = editBox

    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetAutoFocus(false)
    editBox:SetWidth(1) -- SetScrollChild governs actual layout; matches scrollFrame's width
    editBox:SetText("")
    editBox:EnableMouse(true)

    scrollFrame:SetScrollChild(editBox)

    -- Keeps the edit box's wrap width in sync with the
    -- scroll frame's own width, and its height able to
    -- grow with content (scrolling handles overflow).
    editBox:SetScript("OnTextChanged", function(self_)

        local scrollWidth = scrollFrame:GetWidth() or 1
        self_:SetWidth(scrollWidth)

        local textHeight = self_:GetHeight() or 0
        local frameHeight = scrollFrame:GetHeight() or 0

        if textHeight < frameHeight then
            self_:SetHeight(frameHeight)
        end

    end)

    scrollFrame:SetScript("OnSizeChanged", function(self_, w)
        editBox:SetWidth(w or 1)
    end)

    editBox:SetScript("OnEscapePressed", function()
        window:Hide()
    end)

    -------------------------------------------------
    -- Import Button
    -------------------------------------------------

    local importButton = ImpLoot.Theme:CreateMenuButton(window)
    importButton:SetSize(90, 24)
    importButton:SetPoint("BOTTOMRIGHT", -110, 15)
    importButton:SetText("Import")

    importButton:SetScript("OnClick", function()

        local csv = self.EditBox:GetText()
        local reserveCount = ImpLoot.SoftReserve:Import(csv)

        ImpLoot:Print("Imported " .. reserveCount .. " soft reserves.")

        self.EditBox:SetText("")
        self.Window:Hide()

    end)

    -------------------------------------------------
    -- Cancel Button
    -------------------------------------------------

    local cancelButton = ImpLoot.Theme:CreateMenuButton(window)
    cancelButton:SetSize(90, 24)
    cancelButton:SetPoint("BOTTOMRIGHT", -15, 15)
    cancelButton:SetText("Cancel")

    cancelButton:SetScript("OnClick", function()
        self.Window:Hide()
    end)

end
