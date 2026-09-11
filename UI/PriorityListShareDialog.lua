-------------------------------------------------
-- Priority List Share Dialog
--
-- A compact text-string import/export for Loot
-- Priority lists -- an alternative to Populate Item
-- List that can be built or shared entirely outside
-- the game (Discord, notes, another officer). Same
-- scrollable-box pattern as ImportDialog.lua, just
-- with two modes (Import: paste text in, Export: read
-- generated text out) instead of one.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.PriorityListShareDialog = ImpLoot.UI.PriorityListShareDialog or {}
local PriorityListShareDialog = ImpLoot.UI.PriorityListShareDialog

-------------------------------------------------
-- Initialize
-------------------------------------------------

function PriorityListShareDialog:Initialize(parentFrame)

    -------------------------------------------------
    -- Window
    -------------------------------------------------

    local window = CreateFrame("Frame", nil, parentFrame)
    self.Window = window

    window:SetSize(460, 380)
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

    local label = window:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("TOPLEFT", 20, -45)
    label:SetWidth(420)
    label:SetJustifyH("LEFT")
    self.Label = label

    -------------------------------------------------
    -- Edit Box (same scrollable pattern as ImportDialog)
    -------------------------------------------------

    local editBoxBackground = CreateFrame("Frame", nil, window)
    editBoxBackground:SetPoint("TOPLEFT", 20, -75)
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

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootPriorityShareScrollFrame",
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
    editBox:SetWidth(1)
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

    self.ScrollFrame = scrollFrame

    -------------------------------------------------
    -- Primary Button (Import or Copy, depending on mode)
    -------------------------------------------------

    local primaryButton = ImpLoot.Theme:CreateMenuButton(window)
    primaryButton:SetSize(90, 24)
    primaryButton:SetPoint("BOTTOMRIGHT", -110, 15)
    self.PrimaryButton = primaryButton

    -------------------------------------------------
    -- Close Button
    -------------------------------------------------

    local closeButton = ImpLoot.Theme:CreateMenuButton(window)
    closeButton:SetSize(90, 24)
    closeButton:SetPoint("BOTTOMRIGHT", -15, 15)
    closeButton:SetText("Close")

    closeButton:SetScript("OnClick", function()
        window:Hide()
    end)

end

-------------------------------------------------
-- Show Import Mode
-------------------------------------------------

function PriorityListShareDialog:ShowImport()

    local activeName = ImpLoot.LootCouncil:GetActiveListName()

    if not activeName then
        ImpLoot:Print("Create or select a list first.")
        return
    end

    self.Mode = "Import"
    self.Title:SetText("Import Priority List")
    self.Label:SetText(
        "Paste a priority list text string below, one item per \";\". " ..
        "Imports into the currently selected list (\"" .. activeName .. "\")."
    )

    self.EditBox:SetText("")

    self.PrimaryButton:SetText("Import")

    self.PrimaryButton:SetScript("OnClick", function()

        local text = self.EditBox:GetText()
        local listName = ImpLoot.LootCouncil:GetActiveListName()

        if not listName then
            ImpLoot:Print("Create or select a list first.")
            return
        end

        local imported, warnings = ImpLoot.LootCouncil:ImportTextToList(listName, text)

        ImpLoot:Print("Imported " .. imported .. " item(s) into \"" .. listName .. "\".")

        for _, warning in ipairs(warnings) do
            ImpLoot:Print(warning)
        end

        if ImpLoot.UI.LootPriorityWindow and ImpLoot.UI.LootPriorityWindow.RefreshItemsList then
            ImpLoot.UI.LootPriorityWindow:RefreshItemsList()
        end

        self.EditBox:SetText("")
        self.Window:Hide()

    end)

    self.Window:Show()
    self.EditBox:SetFocus()

end

-------------------------------------------------
-- Show Export Mode
-------------------------------------------------

function PriorityListShareDialog:ShowExport()

    local activeName = ImpLoot.LootCouncil:GetActiveListName()

    if not activeName then
        ImpLoot:Print("Create or select a list first.")
        return
    end

    self.Mode = "Export"
    self.Title:SetText("Export Priority List")
    self.Label:SetText(
        "Text for \"" .. activeName .. "\" -- select all and copy to share it."
    )

    local exported = ImpLoot.LootCouncil:ExportListToText(activeName)

    if exported == "" then
        exported = "-- This list has no items yet. --"
    end

    self.EditBox:SetText(exported)

    self.PrimaryButton:SetText("Select All")

    self.PrimaryButton:SetScript("OnClick", function()
        self.EditBox:SetFocus()
        self.EditBox:HighlightText()
    end)

    self.Window:Show()
    self.EditBox:SetFocus()
    self.EditBox:HighlightText()

end
