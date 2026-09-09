-------------------------------------------------
-- Summary Window
--
-- "Who received what", built from every client's own
-- local log (populated either by resolving items
-- directly, or by receiving the "RESOLVED" broadcast
-- from whoever did) -- so the loot master, the raid
-- leader if that's someone else, or any other ImpLoot
-- user can open this and see the same picture.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.SummaryWindow = ImpLoot.UI.SummaryWindow or {}
local SummaryWindow = ImpLoot.UI.SummaryWindow

local WINDOW_WIDTH = 300
local WINDOW_HEIGHT = 360
local ROW_HEIGHT = 18

-------------------------------------------------
-- Initialize
-------------------------------------------------

function SummaryWindow:Initialize()

    local frame = CreateFrame("Frame", "ImpLootSummaryFrame", UIParent)
    self.Frame = frame

    frame:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
    frame:SetPoint("CENTER", -250, 0)
    frame:SetFrameStrata("DIALOG")

    ImpLoot.Theme:ApplyPanelStyle(frame)

    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:Hide()

    local titleBar = CreateFrame("Frame", nil, frame)
    titleBar:SetPoint("TOPLEFT", 4, -4)
    titleBar:SetPoint("TOPRIGHT", -4, -4)
    titleBar:SetHeight(24)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() frame:StartMoving() end)
    titleBar:SetScript("OnDragStop", function() frame:StopMovingOrSizing() end)

    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", 4, 0)
    title:SetTextColor(
        ImpLoot.Theme.Colors.Text[1],
        ImpLoot.Theme.Colors.Text[2],
        ImpLoot.Theme.Colors.Text[3]
    )
    title:SetText("Loot summary")

    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", 2, 0)
    closeButton:SetScript("OnClick", function() frame:Hide() end)

    -------------------------------------------------
    -- Post To Raid / Clear
    -------------------------------------------------

    local postButton = ImpLoot.Theme:CreateMenuButton(frame)
    postButton:SetSize(90, 20)
    postButton:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 2, -6)
    postButton:SetText("Post to raid")
    self.PostButton = postButton

    postButton:SetScript("OnClick", function()
        self:PostToRaid()
    end)

    local clearButton = ImpLoot.Theme:CreateMenuButton(frame)
    clearButton:SetSize(70, 20)
    clearButton:SetPoint("LEFT", postButton, "RIGHT", 4, 0)
    clearButton:SetText("Clear")
    self.ClearButton = clearButton

    clearButton:SetScript("OnClick", function()
        ImpLoot.LootMaster:ClearLog()
        self:Refresh()
    end)

    local exportButton = ImpLoot.Theme:CreateMenuButton(frame)
    exportButton:SetSize(60, 20)
    exportButton:SetPoint("LEFT", clearButton, "RIGHT", 4, 0)
    exportButton:SetText("Export")
    self.ExportButton = exportButton

    exportButton:SetScript("OnClick", function()
        self:ShowExport()
    end)

    -------------------------------------------------
    -- Scroll Content
    -------------------------------------------------

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootSummaryScrollFrame",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    self.ScrollFrame = scrollFrame

    scrollFrame:SetPoint("TOPLEFT", postButton, "BOTTOMLEFT", -2, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -26, 10)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetWidth(WINDOW_WIDTH - 36)
    scrollChild:SetHeight(1)

    self.ScrollChild = scrollChild

    scrollFrame:SetScrollChild(scrollChild)

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(scrollFrame)

    scrollFrame:EnableMouseWheel(true)

    scrollFrame:SetScript("OnMouseWheel", function(sf, delta)

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

    end)

    self.RowWidgets = {}

    -------------------------------------------------
    -- Export Box (Overlay)
    --
    -- A multi-line, auto-selected EditBox -- WoW has no
    -- clipboard API, so this is the standard way to let
    -- the user copy text out themselves (Ctrl+C).
    -------------------------------------------------

    local exportScroll = CreateFrame(
        "ScrollFrame",
        "ImpLootSummaryExportScrollFrame",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    self.ExportScroll = exportScroll

    exportScroll:SetPoint("TOPLEFT", postButton, "BOTTOMLEFT", -2, -8)
    exportScroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -26, 34)
    exportScroll:Hide()

    ImpLoot.Theme:ApplyPanelStyle(exportScroll)

    local exportBox = CreateFrame("EditBox", nil, exportScroll)
    exportBox:SetMultiLine(true)
    exportBox:SetFontObject(GameFontHighlightSmall)
    exportBox:SetWidth(WINDOW_WIDTH - 36)
    exportBox:SetHeight(400)
    exportBox:SetAutoFocus(false)

    exportBox:SetScript("OnEscapePressed", function()
        self:HideExport()
    end)

    self.ExportBox = exportBox

    exportScroll:SetScrollChild(exportBox)

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(exportScroll)

    local function HandleExportMouseWheel(sf, delta)

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

    exportScroll:EnableMouseWheel(true)
    exportScroll:SetScript("OnMouseWheel", HandleExportMouseWheel)

    exportBox:EnableMouseWheel(true)
    exportBox:SetScript("OnMouseWheel", function(_, delta)
        HandleExportMouseWheel(exportScroll, delta)
    end)

    local exportBackButton = ImpLoot.Theme:CreateMenuButton(frame)
    exportBackButton:SetSize(70, 20)
    exportBackButton:SetPoint("BOTTOMLEFT", 2, 8)
    exportBackButton:SetText("Back")
    exportBackButton:Hide()

    exportBackButton:SetScript("OnClick", function()
        self:HideExport()
    end)

    self.ExportBackButton = exportBackButton

    self:Refresh()

end

-------------------------------------------------
-- Show / Hide / Toggle
-------------------------------------------------

function SummaryWindow:Show()
    self:Refresh()
    self.Frame:Show()
end

function SummaryWindow:Hide()
    self.Frame:Hide()
end

function SummaryWindow:Toggle()

    if self.Frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end

end

-------------------------------------------------
-- Acquire Row
-------------------------------------------------

function SummaryWindow:AcquireRow(index)

    local row = self.RowWidgets[index]

    if row then
        return row
    end

    row = self.ScrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row:SetJustifyH("LEFT")
    row:SetWidth(self.ScrollChild:GetWidth())

    self.RowWidgets[index] = row

    return row

end

-------------------------------------------------
-- Format Line
-------------------------------------------------

function SummaryWindow:FormatLine(entry)

    local cached = ImpLoot.ItemCache:GetItem(entry.ItemID)
    local itemName = (cached and cached.Name) or ("Item " .. entry.ItemID)

    local line = entry.Winner .. " -- " .. itemName

    if entry.BossName then
        line = line .. " (" .. entry.BossName .. ")"
    end

    return line

end

-------------------------------------------------
-- Refresh
-------------------------------------------------

function SummaryWindow:Refresh()

    if not self.ScrollChild then
        return
    end

    for _, row in ipairs(self.RowWidgets) do
        row:Hide()
    end

    local log = ImpLoot.LootMaster:GetLog()

    if #log == 0 then

        local row = self:AcquireRow(1)
        row:SetText("Nothing resolved yet.")
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 2, 0)
        row:Show()

        self.ScrollChild:SetHeight(ROW_HEIGHT)

        if self.ScrollFrame.UpdateScrollIndicators then
            self.ScrollFrame:UpdateScrollIndicators()
        end

        return

    end

    local y = 0

    for i, entry in ipairs(log) do

        local row = self:AcquireRow(i)
        row:SetText(self:FormatLine(entry))
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 2, -y)
        row:Show()

        y = y + ROW_HEIGHT

    end

    self.ScrollChild:SetHeight(math.max(y, 1))

    if self.ScrollFrame.UpdateScrollChildRect then
        self.ScrollFrame:UpdateScrollChildRect()
    end

    if self.ScrollFrame.UpdateScrollIndicators then
        self.ScrollFrame:UpdateScrollIndicators()
    end

end

-------------------------------------------------
-- Get Export Text
--
-- Tab-separated with a header row -- pasting
-- tab-separated text into Excel splits it into
-- columns automatically.
-------------------------------------------------

function SummaryWindow:GetExportText()

    local log = ImpLoot.LootMaster:GetLog()

    local lines = { "Winner\tItem\tBoss" }

    for _, entry in ipairs(log) do

        local cached = ImpLoot.ItemCache:GetItem(entry.ItemID)
        local itemName = (cached and cached.Name) or ("Item " .. entry.ItemID)

        table.insert(lines, string.format(
            "%s\t%s\t%s",
            entry.Winner, itemName, entry.BossName or ""
        ))

    end

    return table.concat(lines, "\n")

end

-------------------------------------------------
-- Show / Hide Export
-------------------------------------------------

function SummaryWindow:ShowExport()

    self.ExportBox:SetText(self:GetExportText())
    self.ExportBox:SetFocus()
    self.ExportBox:HighlightText()

    self.ScrollFrame:Hide()
    self.ExportScroll:Show()
    self.ExportBackButton:Show()

    self.PostButton:Hide()
    self.ClearButton:Hide()
    self.ExportButton:Hide()

    if self.ExportScroll.UpdateScrollIndicators then
        self.ExportScroll:UpdateScrollIndicators()
    end

end

function SummaryWindow:HideExport()

    self.ExportBox:ClearFocus()

    self.ExportScroll:Hide()
    self.ExportBackButton:Hide()
    self.ScrollFrame:Show()

    self.PostButton:Show()
    self.ClearButton:Show()
    self.ExportButton:Show()

end

-------------------------------------------------
-- Post To Raid
--
-- One chat line per resolved item, sent via the same
-- channel logic Announcements already uses.
-------------------------------------------------

function SummaryWindow:PostToRaid()

    local log = ImpLoot.LootMaster:GetLog()

    if #log == 0 then
        ImpLoot:Print("Nothing to post -- the summary is empty.")
        return
    end

    local channel = ImpLoot.Announcements:ResolveChannel("Auto")

    for _, entry in ipairs(log) do
        SendChatMessage(self:FormatLine(entry), channel)
    end

end

-------------------------------------------------
-- React To Queue Changes (a new resolution happened)
-------------------------------------------------

ImpLoot.Events:Register("LootQueueChanged", function()

    if ImpLoot.UI.SummaryWindow and ImpLoot.UI.SummaryWindow.Frame
    and ImpLoot.UI.SummaryWindow.Frame:IsShown() then

        ImpLoot.UI.SummaryWindow:Refresh()

    end

end)
