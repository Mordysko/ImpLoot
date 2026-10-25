-------------------------------------------------
-- History Window
--
-- Every item ImpLoot has recorded, across every raid --
-- unlike the Summary window's Who won what, which only
-- shows the current session. Search, filter by raid and
-- period, sort by any column, edit or delete entries,
-- and export what's shown as text or CSV. It syncs with the
-- raid on its own (see HistorySync).
--
--   Hover a row        details (how it was won, raid...)
--   Shift-click a row  link the item in chat
--   Right-click a row  change winner / note / tag, delete
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.HistoryWindow = ImpLoot.UI.HistoryWindow or {}
local HistoryWindow = ImpLoot.UI.HistoryWindow

local WINDOW_WIDTH = 660
local WINDOW_HEIGHT = 460
local ROW_HEIGHT = 16

-- Column layout, left to right. `Key` is what a click on
-- the heading sorts by.
local COLUMNS = {
    { Key = "Timestamp", Label = "Date", Width = 82 },
    { Key = "Item", Label = "Item", Width = 170 },
    { Key = "Winner", Label = "Winner", Width = 90 },
    { Key = "ResultLabel", Label = "Result", Width = 44 },
    { Key = "BossName", Label = "Boss", Width = 112 },
    { Key = "Raid", Label = "Raid", Width = 110 },
}

local COLUMN_GAP = 4

local PERIODS = {
    { Label = "All time", Seconds = nil },
    { Label = "Today", Today = true },
    { Label = "Last 7 days", Seconds = 7 * 86400 },
    { Label = "Last 30 days", Seconds = 30 * 86400 },
}

local TAGS = { "MS", "OS", "SR", "LC", "DE" }

-- (SetShown doesn't exist on the 3.3.5 client)
local function SetShown(region, shown)

    if shown then
        region:Show()
    else
        region:Hide()
    end

end

-------------------------------------------------
-- Edit / Delete Prompts
-------------------------------------------------

local function PopupEditBox(dialog)
    return _G[dialog:GetName() .. "EditBox"]
end

local function AcceptEdit(dialog, data)

    local text = PopupEditBox(dialog):GetText()

    if data.Field == "Winner" then
        ImpLoot.LootHistory:SetWinner(data.Entry, text)
    else
        ImpLoot.LootHistory:SetNote(data.Entry, text)
    end

end

StaticPopupDialogs["IMPLOOT_HISTORY_EDIT"] = {

    text = "%s",
    button1 = "Save",
    button2 = "Cancel",
    hasEditBox = 1,
    maxLetters = 60,

    OnShow = function(dialog, data)

        local box = PopupEditBox(dialog)
        box:SetText((data and data.Current) or "")
        box:HighlightText()
        box:SetFocus()

    end,

    OnAccept = function(dialog, data)
        AcceptEdit(dialog, data)
    end,

    EditBoxOnEnterPressed = function(box)

        local dialog = box:GetParent()
        AcceptEdit(dialog, dialog.data)
        dialog:Hide()

    end,

    EditBoxOnEscapePressed = function(box)
        box:GetParent():Hide()
    end,

    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,

}

StaticPopupDialogs["IMPLOOT_HISTORY_DELETE"] = {

    text = "%s",
    button1 = "Delete",
    button2 = "Cancel",

    OnAccept = function(_, data)

        local count = ImpLoot.LootHistory:DeleteWhere(data.Test)
        ImpLoot:Print(count .. " history " .. (count == 1 and "entry" or "entries") .. " deleted.")

    end,

    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,

}

local function ConfirmDelete(description, test)

    local count = ImpLoot.LootHistory:CountWhere(test)

    if count == 0 then
        ImpLoot:Print("Nothing to delete.")
        return
    end

    StaticPopup_Show(
        "IMPLOOT_HISTORY_DELETE",
        "Delete " .. count .. " history " .. (count == 1 and "entry" or "entries")
            .. " (" .. description .. ")?\n\nThis can't be undone.",
        nil,
        { Test = test }
    )

end

-------------------------------------------------
-- Filtering And Sorting
-------------------------------------------------

local UNKNOWN_CHARACTER = "Unknown character"

function HistoryWindow:MatchesFilters(logEntry)

    if self.CharacterFilter
    and (logEntry.Owner or UNKNOWN_CHARACTER) ~= self.CharacterFilter then
        return false
    end

    if self.RaidFilter
    and ImpLoot.LootMaster:FormatRaidLabel(logEntry) ~= self.RaidFilter then
        return false
    end

    local period = PERIODS[self.PeriodIndex]

    if period.Today then

        if date("%Y-%m-%d", logEntry.Timestamp or 0) ~= date("%Y-%m-%d") then
            return false
        end

    elseif period.Seconds then

        if time() - (logEntry.Timestamp or 0) > period.Seconds then
            return false
        end

    end

    local search = self.SearchText

    if search ~= "" then

        local haystack = table.concat({
            ImpLoot.LootHistory.ItemName(logEntry),
            logEntry.Winner or "",
            logEntry.BossName or "",
            logEntry.Raid or "",
            logEntry.ResultLabel or "",
            logEntry.Note or "",
        }, "\001"):lower()

        if not haystack:find(search, 1, true) then
            return false
        end

    end

    return true

end

local function SortValue(logEntry, key)

    if key == "Timestamp" then
        return logEntry.Timestamp or 0
    elseif key == "Item" then
        return ImpLoot.LootHistory.ItemName(logEntry):lower()
    elseif key == "Raid" then
        return (ImpLoot.LootMaster:FormatRaidLabel(logEntry) or ""):lower()
    end

    return tostring(logEntry[key] or ""):lower()

end

function HistoryWindow:BuildView()

    local view = {}

    for _, logEntry in ipairs(ImpLoot.LootMaster:GetLog()) do

        if self:MatchesFilters(logEntry) then
            table.insert(view, logEntry)
        end

    end

    local key, ascending = self.SortKey, self.SortAscending

    table.sort(view, function(a, b)

        local va, vb = SortValue(a, key), SortValue(b, key)

        if va == vb then

            if ascending then
                return (a.Id or 0) < (b.Id or 0)
            end

            return (a.Id or 0) > (b.Id or 0)

        end

        if ascending then
            return va < vb
        end

        return va > vb

    end)

    self.View = view

    return view

end

-------------------------------------------------
-- Rows
-------------------------------------------------

function HistoryWindow:ShowRowMenu(row)

    local logEntry = row.LogEntry

    if not logEntry then
        return
    end

    local menu = {
        { text = ImpLoot.LootHistory.ItemName(logEntry), isTitle = true, notCheckable = true },

        { text = "Change winner...", notCheckable = true, func = function()
            StaticPopup_Show("IMPLOOT_HISTORY_EDIT", "Who got " .. ImpLoot.LootHistory.ItemName(logEntry) .. "?",
                nil, { Entry = logEntry, Field = "Winner", Current = logEntry.Winner })
        end },

        { text = "Edit note...", notCheckable = true, func = function()
            StaticPopup_Show("IMPLOOT_HISTORY_EDIT", "Note for " .. ImpLoot.LootHistory.ItemName(logEntry) .. ":",
                nil, { Entry = logEntry, Field = "Note", Current = logEntry.Note })
        end },
    }

    local tagMenu = {}

    for _, tag in ipairs(TAGS) do

        table.insert(tagMenu, {
            text = tag,
            checked = (logEntry.ResultLabel == tag),
            func = function() ImpLoot.LootHistory:SetTag(logEntry, tag) end,
        })

    end

    table.insert(tagMenu, {
        text = "None",
        checked = (logEntry.ResultLabel or "") == "",
        func = function() ImpLoot.LootHistory:SetTag(logEntry, "") end,
    })

    table.insert(menu, { text = "Result", notCheckable = true, hasArrow = true, menuList = tagMenu })

    table.insert(menu, {
        text = "Share in sync",
        checked = not logEntry.NoSync,
        keepShownOnClick = false,
        func = function() ImpLoot.LootHistory:SetShared(logEntry, logEntry.NoSync and true or false) end,
    })

    table.insert(menu, { text = "Delete", notCheckable = true, func = function()
        ConfirmDelete("this entry", function(e) return e == logEntry end)
    end })

    table.insert(menu, { text = "Cancel", notCheckable = true })

    EasyMenu(menu, self.MenuFrame, "cursor", 0, 0, "MENU")

end

function HistoryWindow:AcquireRow(index)

    local row = self.Rows[index]

    if row then
        return row
    end

    row = CreateFrame("Button", nil, self.ListChild)
    row:SetHeight(ROW_HEIGHT)
    row:SetPoint("LEFT", 0, 0)
    row:SetPoint("RIGHT", 0, 0)
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    local highlight = row:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture(1, 1, 1, 0.08)

    row.Cells = {}

    local x = 2

    for i, column in ipairs(COLUMNS) do

        local cell = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        cell:SetPoint("LEFT", row, "LEFT", x, 0)
        cell:SetWidth(column.Width)
        cell:SetHeight(ROW_HEIGHT)
        cell:SetJustifyH("LEFT")

        row.Cells[i] = cell

        x = x + column.Width + COLUMN_GAP

    end

    row:SetScript("OnEnter", function(selfRow)

        if not selfRow.LogEntry then
            return
        end

        GameTooltip:SetOwner(selfRow, "ANCHOR_RIGHT")
        ImpLoot.LootHistory:AddTooltipLines(selfRow.LogEntry)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Shift-click: link in chat   Right-click: edit", 0.5, 0.5, 0.5)
        GameTooltip:Show()

    end)

    row:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    row:SetScript("OnClick", function(selfRow, button)

        local logEntry = selfRow.LogEntry

        if not logEntry then
            return
        end

        if button == "RightButton" then
            self:ShowRowMenu(selfRow)
            return
        end

        if IsShiftKeyDown() then

            local link = select(2, GetItemInfo(logEntry.ItemID))

            if link then
                ChatEdit_InsertLink(link)
            end

        end

    end)

    self.Rows[index] = row

    return row

end

function HistoryWindow:FillRow(row, logEntry)

    row.LogEntry = logEntry

    local cells = row.Cells

    cells[1]:SetText(logEntry.Timestamp and date("%m-%d %H:%M", logEntry.Timestamp) or "")
    cells[1]:SetTextColor(0.75, 0.75, 0.75)

    local cached = ImpLoot.ItemCache and ImpLoot.ItemCache:GetItem(logEntry.ItemID)
    local quality = (cached and cached.Quality) or logEntry.Quality

    cells[2]:SetText(ImpLoot.LootHistory.ItemName(logEntry))
    cells[2]:SetTextColor(ImpLoot.Theme:GetQualityColor(quality))

    cells[3]:SetText(logEntry.Winner or "?")
    cells[3]:SetTextColor(ImpLoot.Theme:GetClassColor(logEntry.WinnerClass))

    cells[4]:SetText(logEntry.ResultLabel or "")
    cells[4]:SetTextColor(0.8, 0.8, 0.8)

    cells[5]:SetText(logEntry.BossName or "")
    cells[5]:SetTextColor(1, 1, 1)

    cells[6]:SetText(ImpLoot.LootMaster:FormatRaidLabel(logEntry) or "")
    cells[6]:SetTextColor(0.75, 0.75, 0.75)

end

-------------------------------------------------
-- Refresh
-------------------------------------------------

function HistoryWindow:Refresh()

    if not self.Frame or not self.Frame:IsShown() then
        return
    end

    local view = self:BuildView()

    for _, row in ipairs(self.Rows) do
        row:Hide()
    end

    for i, logEntry in ipairs(view) do

        local row = self:AcquireRow(i)
        row:SetPoint("TOP", self.ListChild, "TOP", 0, -((i - 1) * ROW_HEIGHT))
        self:FillRow(row, logEntry)
        row:Show()

    end

    SetShown(self.EmptyText, #view == 0)

    if #ImpLoot.LootMaster:GetLog() == 0 then
        self.EmptyText:SetText("Nothing recorded yet.")
    else
        self.EmptyText:SetText("Nothing matches these filters.")
    end

    self.ListChild:SetHeight(math.max(#view * ROW_HEIGHT, 1))

    if self.ListScroll.UpdateScrollIndicators then
        self.ListScroll:UpdateScrollIndicators()
    end

    local total = #ImpLoot.LootMaster:GetLog()
    local countText

    if #view == total then
        countText = total .. (total == 1 and " item" or " items")
    else
        countText = "Showing " .. #view .. " of " .. total
    end

    local syncStatus = ImpLoot.HistorySync and ImpLoot.HistorySync.StatusText

    if syncStatus then
        countText = countText .. "   |cff888888Sync: " .. syncStatus .. "|r"
    end

    self.CountText:SetText(countText)

    for i, heading in ipairs(self.Headings) do

        local column = COLUMNS[i]
        local text = column.Label

        if self.SortKey == column.Key then
            text = text .. (self.SortAscending and " ^" or " v")
        end

        heading:SetText(text)

    end

end

-------------------------------------------------
-- Export
-------------------------------------------------

-- The Export button opens this view; while it's open the
-- same button switches between Text and CSV (its label
-- shows the format on screen), and Back returns to the
-- list.

function HistoryWindow:GetExportFormat()
    return (ImpLootDB and ImpLootDB.HistoryExportFormat) or "Text"
end

function HistoryWindow:ShowExport()

    local format = self:GetExportFormat()
    local text, count

    if format == "CSV" then
        text, count = ImpLoot.LootHistory:BuildExportCSV(self.View or {})
    else
        text, count = ImpLoot.LootHistory:BuildExport(self.View or {})
    end

    self.ListScroll:Hide()
    self.HeaderRow:Hide()
    self.EmptyText:Hide()
    self.ExportPanel:Show()

    self.ExportBox:SetText(text)
    self.ExportBox:HighlightText()
    self.ExportBox:SetFocus()

    self.ExportInfo:SetText(count .. (count == 1 and " item" or " items")
        .. " (what's shown) as " .. format .. ". Ctrl+C to copy.")

    self.ExportButton:SetText(format)

    self:UpdateBackButton()

end

function HistoryWindow:ToggleExportFormat()

    ImpLootDB = ImpLootDB or {}
    ImpLootDB.HistoryExportFormat = (self:GetExportFormat() == "CSV") and "Text" or "CSV"

    self:ShowExport()

end

function HistoryWindow:HideExport()

    self.ExportBox:ClearFocus()
    self.ExportPanel:Hide()
    self.HeaderRow:Show()
    self.ListScroll:Show()

    if self.ExportButton then
        self.ExportButton:SetText("Export")
    end

    if self.Frame and self.Frame:IsShown() then
        self:Refresh()
    end

    self:UpdateBackButton()

end

-------------------------------------------------
-- Back Button
--
-- Bottom left. From the export view it returns to the
-- list; from the list it returns to Who won what when
-- that's where Loot history was opened from (the
-- window turns back into it). Hidden otherwise.
-------------------------------------------------

function HistoryWindow:UpdateBackButton()

    if not self.BackButton then
        return
    end

    local show = self.ExportPanel:IsShown() or self.ReturnToSummary

    self.CountText:ClearAllPoints()

    if show then
        self.BackButton:Show()
        self.CountText:SetPoint("LEFT", self.BackButton, "RIGHT", 8, 0)
    else
        self.BackButton:Hide()
        self.CountText:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 14, 16)
    end

end

function HistoryWindow:Back()

    if self.ExportPanel:IsShown() then
        self:HideExport()
    elseif self.ReturnToSummary then
        self:ReturnToWhoWonWhat()
    end

end

-------------------------------------------------
-- Open From / Return To Who Won What
--
-- Rather than a second window, Who won what turns into
-- Loot history in place (same top-left corner) and Back
-- turns it back again.
-------------------------------------------------

local function TopLeftOf(frame)
    return frame:GetLeft(), frame:GetTop()
end

function HistoryWindow:OpenFromSummary()

    local summary = ImpLoot.UI.SummaryWindow
    local left, top

    if summary and summary.Frame and summary.Frame:IsShown() then
        left, top = TopLeftOf(summary.Frame)
        summary.Frame:Hide()
    end

    if left and top then
        self.Frame:ClearAllPoints()
        self.Frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
    end

    self.ReturnToSummary = true

    self:HideExport()
    self.Frame:Show()
    self.Frame:Raise()

    self:UpdateBackButton()

end

function HistoryWindow:ReturnToWhoWonWhat()

    local left, top = TopLeftOf(self.Frame)

    self.ReturnToSummary = false
    self.Frame:Hide()

    local summary = ImpLoot.UI.SummaryWindow

    summary:Show()

    if left and top then
        summary.Frame:ClearAllPoints()
        summary.Frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
    end

end

-------------------------------------------------
-- Delete Menu
-------------------------------------------------

function HistoryWindow:ShowDeleteMenu()

    local menu = {
        { text = "Older than 30 days", notCheckable = true, func = function()
            local limit = time() - 30 * 86400
            ConfirmDelete("older than 30 days", function(e) return (e.Timestamp or 0) < limit end)
        end },
        { text = "Everything", notCheckable = true, func = function()
            ConfirmDelete("everything", function() return true end)
        end },
        { text = "Cancel", notCheckable = true },
    }

    EasyMenu(menu, self.MenuFrame, self.DeleteButton, 0, 0, "MENU")

end

-------------------------------------------------
-- Dropdowns
-------------------------------------------------

-------------------------------------------------
-- Character Dropdown
--
-- Which of your characters' history to show: the one
-- that logged or received each entry (its Owner). Opens
-- on the character you're playing; "All characters"
-- shows everything.
-------------------------------------------------

local function ClassColouredName(name)

    for _, character in ipairs(ImpLoot.Character and ImpLootDB.Players and ImpLoot.Character:GetAllCharacters() or {}) do

        if character.Name == name and character.Class then

            local token = character.Class.Token or (character.Class.Name and character.Class.Name:upper():gsub(" ", ""))
            local colour = token and RAID_CLASS_COLORS and RAID_CLASS_COLORS[token]

            if colour then
                return string.format("|cff%02x%02x%02x%s|r", colour.r * 255, colour.g * 255, colour.b * 255, name)
            end

        end

    end

    return name

end

function HistoryWindow:CharacterLabel()
    return self.CharacterFilter or "All characters"
end

function HistoryWindow:InitializeCharacterDropdown()

    local dropdown = self.CharacterDropdown

    UIDropDownMenu_Initialize(dropdown, function(_, level)

        local names, seen, unknown = {}, {}, false

        for _, logEntry in ipairs(ImpLoot.LootMaster:GetLog()) do

            if logEntry.Owner then

                if not seen[logEntry.Owner] then
                    seen[logEntry.Owner] = true
                    table.insert(names, logEntry.Owner)
                end

            else
                unknown = true
            end

        end

        local me = UnitName("player")

        if me and not seen[me] then
            table.insert(names, me)
        end

        table.sort(names)
        table.insert(names, 1, false)

        if unknown then
            table.insert(names, UNKNOWN_CHARACTER)
        end

        for _, name in ipairs(names) do

            local info = UIDropDownMenu_CreateInfo()
            info.text = name and (name == UNKNOWN_CHARACTER and name or ClassColouredName(name)) or "All characters"
            info.checked = (self.CharacterFilter == (name or nil))

            info.func = function()
                self.CharacterFilter = name or nil
                UIDropDownMenu_SetText(dropdown, self:CharacterLabel())
                self:Refresh()
            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    UIDropDownMenu_SetText(dropdown, self:CharacterLabel())

end

function HistoryWindow:InitializeRaidDropdown()

    local dropdown = self.RaidDropdown

    UIDropDownMenu_Initialize(dropdown, function(_, level)

        local labels, seen = {}, {}

        for _, logEntry in ipairs(ImpLoot.LootMaster:GetLog()) do

            local label = ImpLoot.LootMaster:FormatRaidLabel(logEntry)

            if label and not seen[label] then
                seen[label] = true
                table.insert(labels, label)
            end

        end

        table.sort(labels)
        table.insert(labels, 1, false)

        for _, label in ipairs(labels) do

            local info = UIDropDownMenu_CreateInfo()
            info.text = label or "All raids"
            info.checked = (self.RaidFilter == (label or nil))

            info.func = function()
                self.RaidFilter = label or nil
                UIDropDownMenu_SetText(dropdown, label or "All raids")
                self:Refresh()
            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    UIDropDownMenu_SetText(dropdown, self.RaidFilter or "All raids")

end

function HistoryWindow:InitializePeriodDropdown()

    local dropdown = self.PeriodDropdown

    UIDropDownMenu_Initialize(dropdown, function(_, level)

        for index, period in ipairs(PERIODS) do

            local info = UIDropDownMenu_CreateInfo()
            info.text = period.Label
            info.checked = (self.PeriodIndex == index)

            info.func = function()
                self.PeriodIndex = index
                UIDropDownMenu_SetText(dropdown, period.Label)
                self:Refresh()
            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    UIDropDownMenu_SetText(dropdown, PERIODS[self.PeriodIndex].Label)

end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function HistoryWindow:Initialize()

    self.SortKey = "Timestamp"
    self.SortAscending = false
    self.PeriodIndex = 1
    self.RaidFilter = nil
    self.SearchText = ""
    self.Rows = {}
    self.Headings = {}

    local frame = CreateFrame("Frame", "ImpLootHistoryFrame", UIParent)
    self.Frame = frame

    frame:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
    frame:SetPoint("CENTER", 0, 40)
    frame:SetFrameStrata("DIALOG")

    ImpLoot.Theme:ApplyPanelStyle(frame)

    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:SetToplevel(true)
    frame:Hide()

    -- Escape closes it, like the game's own windows
    table.insert(UISpecialFrames, "ImpLootHistoryFrame")

    frame:SetScript("OnShow", function() self:Refresh() end)

    -------------------------------------------------
    -- Title Bar
    -------------------------------------------------

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
    title:SetText("Loot history")

    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", 2, 0)
    closeButton:SetScript("OnClick", function() frame:Hide() end)

    -------------------------------------------------
    -- Filters: Search, Raid, Period
    -------------------------------------------------

    local searchBox = CreateFrame("EditBox", "ImpLootHistorySearchBox", frame, "InputBoxTemplate")
    searchBox:SetSize(150, 20)
    searchBox:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 10, -6)
    searchBox:SetAutoFocus(false)
    self.SearchBox = searchBox

    local searchHint = searchBox:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    searchHint:SetPoint("LEFT", 2, 0)
    searchHint:SetText("Search item, player...")

    searchBox:SetScript("OnTextChanged", function(box)

        local text = box:GetText() or ""
        SetShown(searchHint, text == "" and not box:HasFocus())
        self.SearchText = text:lower()
        self:Refresh()

    end)

    searchBox:SetScript("OnEditFocusGained", function() searchHint:Hide() end)
    searchBox:SetScript("OnEditFocusLost", function(box)
        SetShown(searchHint, (box:GetText() or "") == "")
    end)
    searchBox:SetScript("OnEscapePressed", function(box) box:ClearFocus() end)
    searchBox:SetScript("OnEnterPressed", function(box) box:ClearFocus() end)

    -- Character, Raid, Time -- left to right
    local characterDropdown = CreateFrame("Frame", "ImpLootHistoryCharacterDropdown", frame, "UIDropDownMenuTemplate")
    characterDropdown:SetPoint("LEFT", searchBox, "RIGHT", -6, -2)
    UIDropDownMenu_SetWidth(characterDropdown, 110)
    self.CharacterDropdown = characterDropdown

    local raidDropdown = CreateFrame("Frame", "ImpLootHistoryRaidDropdown", frame, "UIDropDownMenuTemplate")
    raidDropdown:SetPoint("LEFT", characterDropdown, "RIGHT", -24, 0)
    UIDropDownMenu_SetWidth(raidDropdown, 130)
    self.RaidDropdown = raidDropdown

    local periodDropdown = CreateFrame("Frame", "ImpLootHistoryPeriodDropdown", frame, "UIDropDownMenuTemplate")
    periodDropdown:SetPoint("LEFT", raidDropdown, "RIGHT", -24, 0)
    UIDropDownMenu_SetWidth(periodDropdown, 100)
    self.PeriodDropdown = periodDropdown

    self.CharacterFilter = UnitName("player")

    self:InitializeCharacterDropdown()
    self:InitializeRaidDropdown()
    self:InitializePeriodDropdown()

    -------------------------------------------------
    -- Column Headings (click to sort)
    -------------------------------------------------

    local headerRow = CreateFrame("Frame", nil, frame)
    headerRow:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -4, -8)
    headerRow:SetPoint("RIGHT", frame, "RIGHT", -14, 0)
    headerRow:SetHeight(ROW_HEIGHT)
    self.HeaderRow = headerRow

    local x = 2

    for i, column in ipairs(COLUMNS) do

        local heading = CreateFrame("Button", nil, headerRow)
        heading:SetPoint("LEFT", headerRow, "LEFT", x, 0)
        heading:SetSize(column.Width, ROW_HEIGHT)

        local label = heading:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetAllPoints()
        label:SetJustifyH("LEFT")
        heading:SetFontString(label)

        heading:SetScript("OnClick", function()

            if self.SortKey == column.Key then
                self.SortAscending = not self.SortAscending
            else
                self.SortKey = column.Key
                -- dates newest first, everything else A-Z
                self.SortAscending = (column.Key ~= "Timestamp")
            end

            self:Refresh()

        end)

        self.Headings[i] = heading

        x = x + column.Width + COLUMN_GAP

    end

    -------------------------------------------------
    -- List
    -------------------------------------------------

    local listScroll = CreateFrame("ScrollFrame", "ImpLootHistoryListScrollFrame", frame, "UIPanelScrollFrameTemplate")
    listScroll:SetPoint("TOPLEFT", headerRow, "BOTTOMLEFT", 0, -4)
    listScroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -14, 40)
    self.ListScroll = listScroll

    local listChild = CreateFrame("Frame", nil, listScroll)
    listChild:SetWidth(WINDOW_WIDTH - 30)
    listChild:SetHeight(1)
    listScroll:SetScrollChild(listChild)
    self.ListChild = listChild

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(listScroll)

    listScroll:EnableMouseWheel(true)

    listScroll:SetScript("OnMouseWheel", function(sf, delta)

        local maximum = sf:GetVerticalScrollRange()
        local position = sf:GetVerticalScroll() - delta * ROW_HEIGHT * 3

        position = math.max(0, math.min(maximum, position))
        sf:SetVerticalScroll(position)

        if sf.UpdateScrollIndicators then
            sf:UpdateScrollIndicators()
        end

    end)

    local emptyText = frame:CreateFontString(nil, "OVERLAY", "GameFontDisable")
    emptyText:SetPoint("TOP", listScroll, "TOP", 0, -30)
    self.EmptyText = emptyText

    -------------------------------------------------
    -- Export Panel (replaces the list while shown)
    -------------------------------------------------

    local exportPanel = CreateFrame("Frame", nil, frame)
    exportPanel:SetPoint("TOPLEFT", headerRow, "TOPLEFT", 0, 0)
    exportPanel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 40)
    exportPanel:Hide()
    self.ExportPanel = exportPanel

    local exportInfo = exportPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    exportInfo:SetPoint("TOPLEFT", exportPanel, "TOPLEFT", 2, -4)
    self.ExportInfo = exportInfo

    local exportScroll = CreateFrame("ScrollFrame", "ImpLootHistoryExportScrollFrame", exportPanel, "UIPanelScrollFrameTemplate")
    exportScroll:SetPoint("TOPLEFT", exportPanel, "TOPLEFT", 0, -26)
    exportScroll:SetPoint("BOTTOMRIGHT", exportPanel, "BOTTOMRIGHT", 0, 0)
    ImpLoot.Theme:ApplyPanelStyle(exportScroll)

    local exportBox = CreateFrame("EditBox", nil, exportScroll)
    exportBox:SetMultiLine(true)
    exportBox:SetFontObject(GameFontHighlightSmall)
    exportBox:SetWidth(WINDOW_WIDTH - 40)
    exportBox:SetHeight(300)
    exportBox:SetAutoFocus(false)
    exportBox:SetTextInsets(6, 6, 6, 6)
    exportBox:SetScript("OnEscapePressed", function() self:HideExport() end)
    exportScroll:SetScrollChild(exportBox)
    self.ExportBox = exportBox

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(exportScroll)

    exportScroll:EnableMouseWheel(true)

    exportScroll:SetScript("OnMouseWheel", function(sf, delta)

        local maximum = sf:GetVerticalScrollRange()
        local position = math.max(0, math.min(maximum, sf:GetVerticalScroll() - delta * 20))
        sf:SetVerticalScroll(position)

        if sf.UpdateScrollIndicators then
            sf:UpdateScrollIndicators()
        end

    end)

    -------------------------------------------------
    -- Bottom Bar
    -------------------------------------------------

    local backButton = ImpLoot.Theme:CreateMenuButton(frame)
    backButton:SetSize(70, 20)
    backButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 12, 12)
    backButton:SetText("Back")
    backButton:SetScript("OnClick", function() self:Back() end)
    backButton:Hide()
    self.BackButton = backButton

    local countText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    countText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 14, 16)
    self.CountText = countText

    local deleteButton = ImpLoot.Theme:CreateMenuButton(frame)
    deleteButton:SetSize(80, 20)
    deleteButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)
    deleteButton:SetText("Delete...")
    deleteButton:SetScript("OnClick", function() self:ShowDeleteMenu() end)
    self.DeleteButton = deleteButton

    local exportButton = ImpLoot.Theme:CreateMenuButton(frame)
    exportButton:SetSize(80, 20)
    exportButton:SetPoint("RIGHT", deleteButton, "LEFT", -4, 0)
    exportButton:SetText("Export")
    exportButton:SetScript("OnClick", function()

        if self.ExportPanel:IsShown() then
            self:ToggleExportFormat()
        else
            self:ShowExport()
        end

    end)
    self.ExportButton = exportButton

    -- Closing (X or Escape) forgets where it was opened from
    frame:HookScript("OnHide", function()
        self.ReturnToSummary = false
    end)

    self.MenuFrame = CreateFrame("Frame", "ImpLootHistoryMenu", frame, "UIDropDownMenuTemplate")

    -------------------------------------------------
    -- Stay Current
    -------------------------------------------------

    local function RefreshIfShown()

        if frame:IsShown() and not self.ExportPanel:IsShown() then
            self:Refresh()
        end

    end

    ImpLoot.Events:Register("LootHistoryChanged", RefreshIfShown)
    ImpLoot.Events:Register("LootQueueChanged", RefreshIfShown)

end

-------------------------------------------------
-- Show / Hide / Toggle
-------------------------------------------------

function HistoryWindow:Show()

    self.ReturnToSummary = false
    self:HideExport()
    self.Frame:Show()
    self.Frame:Raise()
    self:UpdateBackButton()

end

function HistoryWindow:Toggle()

    if self.Frame:IsShown() then
        self.Frame:Hide()
    else
        self:Show()
    end

end
