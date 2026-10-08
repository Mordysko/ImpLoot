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

-- Called by SummaryWindow once its frame exists: puts the
-- "Import CSV" button and the SR counter on the Soft Reserve
-- view's top row (where Add Soft Reserve sits while editing).
-- SummaryWindow shows/hides them via SetChromeShown.
function ImportDialog:Attach(summaryFrame, anchorFrame)

    self.SummaryFrame = summaryFrame

    local openButton = ImpLoot.Theme:CreateMenuButton(summaryFrame)
    self.OpenButton = openButton

    openButton:SetSize(100, 20)
    openButton:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 2, -6)
    openButton:SetText("Import CSV")
    openButton:Hide()

    -------------------------------------------------
    -- SR Counter
    --
    -- Shows how many soft reserves are currently loaded
    -- (persisted across reloads -- see SoftReserve.lua)
    -- so it's obvious at a glance whether an import is
    -- actually in effect. Shows the import date and, if
    -- the list was manually edited afterwards, the edit
    -- date too.
    -------------------------------------------------

    local counterText = summaryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    counterText:SetPoint("LEFT", openButton, "RIGHT", 8, 0)
    counterText:Hide()
    self.CounterText = counterText

    openButton:SetScript("OnClick", function()

        -- Recomputed every time -- window strata can change via
        -- the Window Layering options; this must always sit one
        -- level above the Soft Reserve window.
        self.Window:SetFrameStrata(ImpLoot.Theme:GetStrataAbove(summaryFrame:GetFrameStrata()))

        self.Window:Show()
    end)

    self:UpdateCounter()

end

function ImportDialog:SetChromeShown(shown)

    if not self.OpenButton then
        return
    end

    if shown then
        self.OpenButton:Show()
        self.CounterText:Show()
    else
        self.OpenButton:Hide()
        self.CounterText:Hide()
    end

end

function ImportDialog:UpdateCounter()

    if not self.CounterText then
        return
    end

    local count = ImpLoot.SoftReserve:GetTotalReserveCount()

    if count > 0 then

        local text = count .. " SR" .. (count == 1 and "" or "s") .. " loaded"
        local importDate = ImpLoot.SoftReserve:GetImportDate()
        local editedDate = ImpLoot.SoftReserve:GetEditedDate()

        if importDate and editedDate then
            text = text .. " (" .. importDate .. ", edited " .. editedDate .. ")"
        elseif editedDate then
            text = text .. " (edited " .. editedDate .. ")"
        elseif importDate then
            text = text .. " (" .. importDate .. ")"
        end

        self.CounterText:SetText(text)

    else
        self.CounterText:SetText("No SRs loaded")
    end

end

function ImportDialog:Initialize(mainWindowFrame)

    -------------------------------------------------
    -- Window
    -------------------------------------------------

    local window = CreateFrame("Frame", nil, UIParent)
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
    scrollFrame:SetPoint("BOTTOMRIGHT", -8, 8)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    self.EditBox = editBox

    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetAutoFocus(false)
    editBox:SetWidth(1) -- SetScrollChild governs actual layout; matches scrollFrame's width
    editBox:SetText("")
    editBox:EnableMouse(true)

    scrollFrame:SetScrollChild(editBox)

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(scrollFrame)

    local function HandleMouseWheel(sf, delta)

        local current = sf:GetVerticalScroll()
        local step = 20
        local maximum = sf:GetVerticalScrollRange()
        local newPosition = current - (delta * step)

        if newPosition < 0 then newPosition = 0 end
        if newPosition > maximum then newPosition = maximum end

        sf:SetVerticalScroll(newPosition)

        if sf.UpdateScrollIndicators then
            sf:UpdateScrollIndicators()
        end

    end

    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", HandleMouseWheel)

    editBox:EnableMouseWheel(true)
    editBox:SetScript("OnMouseWheel", function(_, delta)
        HandleMouseWheel(scrollFrame, delta)
    end)

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

        if scrollFrame.UpdateScrollIndicators then
            scrollFrame:UpdateScrollIndicators()
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
    self.ImportButton = importButton

    importButton:SetScript("OnClick", function()

        local csv = self.EditBox:GetText()
        local reserveCount = ImpLoot.SoftReserve:Import(csv)

        ImpLoot:Print("Imported " .. reserveCount .. " soft reserves.")

        self.EditBox:SetText("")
        self.Window:Hide()

        self:UpdateCounter()

        -- A fresh import replaces every reserve, so any half-made
        -- manual edits would now be based on the old list --
        -- drop them rather than let a later Save overwrite this.
        if ImpLoot.UI.SummaryWindow and ImpLoot.UI.SummaryWindow.DiscardEdits then
            ImpLoot.UI.SummaryWindow:DiscardEdits()
        end

        if ImpLoot.UI.SummaryWindow and ImpLoot.UI.SummaryWindow.Frame
        and ImpLoot.UI.SummaryWindow.Frame:IsShown() then

            ImpLoot.UI.SummaryWindow:Refresh()

        end

        if reserveCount > 0 then
            StaticPopup_Show("IMPLOOT_RELOAD_AFTER_SR_IMPORT", reserveCount)
        end

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
