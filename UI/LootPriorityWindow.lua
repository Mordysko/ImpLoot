-------------------------------------------------
-- Loot Priority Window
--
-- Where the loot master actually builds Loot Council
-- lists: create/select a list, paste an item link,
-- pick Vote or Priority mode, and set up to 5 ordered
-- candidates (players or whole classes). The vote/
-- priority MECHANICS already existed (LootCouncil
-- module, wired into the Loot Master window) -- this
-- is the missing data-entry screen for them.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.LootPriorityWindow = ImpLoot.UI.LootPriorityWindow or {}
local LootPriorityWindow = ImpLoot.UI.LootPriorityWindow

local WINDOW_WIDTH = 420
local WINDOW_HEIGHT = 560
local CANDIDATE_ROW_HEIGHT = 26

-------------------------------------------------
-- Mode Explanations
--
-- Shown in the "?" tooltip next to the Mode button,
-- for whichever mode is currently selected.
-------------------------------------------------

local MODE_EXPLANATIONS = {

    Priority = "Candidates are tried in the listed order. " ..
        "Once someone wins the item, they're removed from " ..
        "the list -- the next drop goes to whoever's now first.",

    Vote = "The loot council votes on who should receive each " ..
        "drop. The loot master assigns it based on the live tally " ..
        "once voting closes.",

    Funnel = "Every drop of this item goes to whoever's in " ..
        "candidate slot 1. Unlike Priority, winning does NOT " ..
        "remove them -- the recipient only changes if you edit " ..
        "the candidates yourself.",

    Preselected = "Only the listed candidates are allowed to roll " ..
        "for this item, like a council-curated Soft Reserve. " ..
        "Once someone wins, they're removed -- the next drop only " ..
        "offers a roll to whoever's left.",

}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function LootPriorityWindow:Initialize()

    local frame = CreateFrame("Frame", "ImpLootLootPriorityFrame", UIParent)
    self.Frame = frame

    frame:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
    frame:SetPoint("CENTER", 0, 0)

    ImpLoot.Theme:ApplyPanelStyle(frame)

    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:Hide()

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
    title:SetPoint("TOP", 0, 0)
    title:SetTextColor(
        ImpLoot.Theme.Colors.Text[1],
        ImpLoot.Theme.Colors.Text[2],
        ImpLoot.Theme.Colors.Text[3]
    )
    title:SetText("Loot Priority")

    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", 2, 0)
    closeButton:SetScript("OnClick", function() frame:Hide() end)

    self:BuildListRow(frame, titleBar)

    local ok, err = pcall(function() self:BuildItemEditor(frame) end)

    if not ok then
        ImpLoot:Print("|cffff5555Loot Priority window failed to build (BuildItemEditor):|r " .. tostring(err))
    end

    local ok2, err2 = pcall(function() self:BuildExistingItemsList(frame) end)

    if not ok2 then
        ImpLoot:Print("|cffff5555Loot Priority window failed to build (BuildExistingItemsList):|r " .. tostring(err2))
    end

    self:Refresh()

end

-------------------------------------------------
-- List Row
--
-- Dropdown of existing lists, plus inline create/
-- delete (no separate dialog needed -- matches how
-- the options panel's member/disenchanter add flow
-- already works: editbox + button, right there).
-------------------------------------------------

function LootPriorityWindow:BuildListRow(frame, titleBar)

    local listLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    listLabel:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 26, -10)
    listLabel:SetText("List:")

    local listDropdown = CreateFrame(
        "Frame",
        "ImpLootLootPriorityListDropdown",
        frame,
        "UIDropDownMenuTemplate"
    )

    listDropdown:SetPoint("LEFT", listLabel, "RIGHT", -6, -2)
    UIDropDownMenu_SetWidth(listDropdown, 140)

    self.ListDropdown = listDropdown

    UIDropDownMenu_Initialize(listDropdown, function(self_, level)

        for _, listName in ipairs(ImpLoot.LootCouncil:GetListNames()) do

            local info = UIDropDownMenu_CreateInfo()

            info.text = listName
            info.checked = (ImpLoot.LootCouncil:GetActiveListName() == listName)

            info.func = function()

                ImpLoot.LootCouncil:SetActiveList(listName)
                UIDropDownMenu_SetText(listDropdown, listName)
                LootPriorityWindow:Refresh()

            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    local deleteListButton = ImpLoot.Theme:CreateMenuButton(frame)
    deleteListButton:SetSize(80, 20)
    deleteListButton:SetPoint("LEFT", listDropdown, "RIGHT", 6, 2)
    deleteListButton:SetText("Delete List")
    self.DeleteListButton = deleteListButton

    deleteListButton:SetScript("OnClick", function()

        local activeName = ImpLoot.LootCouncil:GetActiveListName()

        if activeName then

            ImpLoot.LootCouncil:DeleteList(activeName)
            self:Refresh()

        end

    end)

    -------------------------------------------------
    -- New List
    -------------------------------------------------

    local newListLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    newListLabel:SetPoint("TOPLEFT", listLabel, "BOTTOMLEFT", 0, -10)
    newListLabel:SetText("New list:")

    local newListBox = CreateFrame(
        "EditBox",
        "ImpLootLootPriorityNewListBox",
        frame,
        "InputBoxTemplate"
    )

    newListBox:SetSize(130, 20)
    newListBox:SetPoint("LEFT", newListLabel, "RIGHT", 10, 0)
    newListBox:SetAutoFocus(false)
    self.NewListBox = newListBox

    local createListButton = ImpLoot.Theme:CreateMenuButton(frame)
    createListButton:SetSize(70, 20)
    createListButton:SetPoint("LEFT", newListBox, "RIGHT", 6, 0)
    createListButton:SetText("Create")
    self.CreateListButton = createListButton

    createListButton:SetScript("OnClick", function()

        local name = newListBox:GetText()

        if name and name ~= "" then

            if ImpLoot.LootCouncil:CreateList(name) then

                ImpLoot.LootCouncil:SetActiveList(name)
                newListBox:SetText("")
                self:Refresh()

            end

        end

    end)

    self.ListRowBottom = newListLabel

end

-------------------------------------------------
-- Item Editor
-------------------------------------------------

function LootPriorityWindow:BuildItemEditor(frame)

    -------------------------------------------------
    -- Populate Item List
    --
    -- Sends the loot master to the main window to
    -- alt-click items onto this list, the same proven
    -- mechanism wishlists already use -- rather than
    -- typing or pasting an item link into a box here.
    -------------------------------------------------

    local populateButton = ImpLoot.Theme:CreateMenuButton(frame)
    populateButton:SetSize(150, 22)
    populateButton:SetPoint("TOPLEFT", self.ListRowBottom, "BOTTOMLEFT", 0, -16)
    populateButton:SetText("Populate Item List")
    self.PopulateButton = populateButton

    -------------------------------------------------
    -- Import / Export Text
    --
    -- A compact text-string alternative to Populate
    -- Item List -- can be built or shared entirely
    -- outside the game.
    -------------------------------------------------

    ImpLoot.UI.PriorityListShareDialog:Initialize(frame)

    local importTextButton = ImpLoot.Theme:CreateMenuButton(frame)
    importTextButton:SetSize(90, 22)
    importTextButton:SetPoint("LEFT", populateButton, "RIGHT", 8, 0)
    importTextButton:SetText("Import Text")
    self.ImportTextButton = importTextButton

    importTextButton:SetScript("OnClick", function()
        ImpLoot.UI.PriorityListShareDialog:ShowImport()
    end)

    local exportTextButton = ImpLoot.Theme:CreateMenuButton(frame)
    exportTextButton:SetSize(90, 22)
    exportTextButton:SetPoint("LEFT", importTextButton, "RIGHT", 8, 0)
    exportTextButton:SetText("Export Text")
    self.ExportTextButton = exportTextButton

    exportTextButton:SetScript("OnClick", function()
        ImpLoot.UI.PriorityListShareDialog:ShowExport()
    end)

    populateButton:SetScript("OnClick", function()

        local activeName = ImpLoot.LootCouncil:GetActiveListName()

        if not activeName then
            ImpLoot:Print("Create or select a list first.")
            return
        end

        ImpLoot.LootCouncil:StartPopulateMode(activeName)

        self.Frame:Hide()

        -- MainWindow only exposes Toggle() (flips open/
        -- closed), not a direct Show() -- only call it
        -- if the window isn't already open, so this
        -- never accidentally closes it instead
        if ImpLoot.UI.MainWindow
        and ImpLoot.UI.MainWindow.Frame
        and not ImpLoot.UI.MainWindow.Frame:IsShown() then

            ImpLoot.UI.MainWindow:Toggle()

        end

        if ImpLoot.UI.PopulateModeBar then
            ImpLoot.UI.PopulateModeBar:Show()
        end

    end)

    -------------------------------------------------
    -- Editing Header
    --
    -- Shows which item's candidates are currently
    -- being edited -- set by LoadItem(), cleared by
    -- ClearEditor(). Items themselves only ever get
    -- added via the populate workflow above, never
    -- typed in here.
    -------------------------------------------------

    local editingLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    editingLabel:SetPoint("TOPLEFT", populateButton, "BOTTOMLEFT", 0, -16)
    editingLabel:SetText("Select an item below to set its candidates.")
    self.EditingLabel = editingLabel

    -------------------------------------------------
    -- Mode Toggle
    --
    -- One button, same pattern as each candidate row's
    -- Player/Class toggle -- whichever label is showing
    -- is the selected mode for this item.
    -------------------------------------------------

    self.Mode = "Priority"

    local modeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    modeLabel:SetPoint("TOPLEFT", editingLabel, "BOTTOMLEFT", -4, -14)
    modeLabel:SetText("Mode:")

    local modeButton = ImpLoot.Theme:CreateMenuButton(frame)
    modeButton:SetSize(90, 20)
    modeButton:SetPoint("LEFT", modeLabel, "RIGHT", 10, 0)
    modeButton:SetText("Priority")
    self.ModeButton = modeButton

    modeButton:SetScript("OnClick", function()

        if LootPriorityWindow.Mode == "Priority" then
            LootPriorityWindow.Mode = "Vote"
        elseif LootPriorityWindow.Mode == "Vote" then
            LootPriorityWindow.Mode = "Funnel"
        elseif LootPriorityWindow.Mode == "Funnel" then
            LootPriorityWindow.Mode = "Preselected"
        else
            LootPriorityWindow.Mode = "Priority"
        end

        LootPriorityWindow:RefreshModeButtons()

    end)

    -------------------------------------------------
    -- Mode Help
    -------------------------------------------------

    local modeHelpButton = CreateFrame("Button", nil, frame)
    modeHelpButton:SetSize(16, 16)
    modeHelpButton:SetPoint("LEFT", modeButton, "RIGHT", 6, 0)
    self.ModeHelpButton = modeHelpButton

    local modeHelpBackground = modeHelpButton:CreateTexture(nil, "BACKGROUND")
    modeHelpBackground:SetAllPoints()
    modeHelpBackground:SetTexture("Interface\\Buttons\\WHITE8X8")
    modeHelpBackground:SetVertexColor(0.15, 0.15, 0.15, 0.9)

    local modeHelpText = modeHelpButton:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    modeHelpText:SetAllPoints()
    modeHelpText:SetJustifyH("CENTER")
    modeHelpText:SetText("?")

    modeHelpButton:SetScript("OnEnter", function()

        GameTooltip:SetOwner(modeHelpButton, "ANCHOR_RIGHT")
        GameTooltip:SetText(LootPriorityWindow.Mode .. " Mode", 1, 0.82, 0)

        local explanation = MODE_EXPLANATIONS[LootPriorityWindow.Mode]

        if explanation then
            GameTooltip:AddLine(explanation, 1, 1, 1, true)
        end

        GameTooltip:Show()

    end)

    modeHelpButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -------------------------------------------------
    -- Candidate Rows
    -------------------------------------------------

    self.CandidateRows = {}

    local previous = modeLabel

    for i = 1, 5 do

        local row = self:CreateCandidateRow(frame, i, previous)
        self.CandidateRows[i] = row
        previous = row.Container

    end

    -------------------------------------------------
    -- Save / Clear
    -------------------------------------------------

    local saveButton = ImpLoot.Theme:CreateMenuButton(frame)
    saveButton:SetSize(100, 22)
    saveButton:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -10)
    saveButton:SetText("Save Candidates")
    self.SaveButton = saveButton

    saveButton:SetScript("OnClick", function()
        LootPriorityWindow:SaveItem()
    end)

    local clearButton = ImpLoot.Theme:CreateMenuButton(frame)
    clearButton:SetSize(60, 22)
    clearButton:SetPoint("LEFT", saveButton, "RIGHT", 6, 0)
    clearButton:SetText("Clear")
    self.ClearButton = clearButton

    clearButton:SetScript("OnClick", function()
        LootPriorityWindow:ClearEditor()
    end)

    self.EditorBottom = saveButton

end

-------------------------------------------------
-- Create Candidate Row
--
-- A Type toggle (Player/Class) plus whichever input
-- actually applies -- a free-text name for Player, a
-- class dropdown for Class -- so there's never any
-- ambiguity about which one a typed value means.
-------------------------------------------------

function LootPriorityWindow:CreateCandidateRow(frame, index, previous)

    local container = CreateFrame("Frame", nil, frame)
    container:SetSize(360, CANDIDATE_ROW_HEIGHT)
    container:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -8)

    local row = { Container = container, Type = "Player" }

    local numberText = container:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    numberText:SetPoint("LEFT", 0, 0)
    numberText:SetText(index .. ".")

    local typeButton = ImpLoot.Theme:CreateMenuButton(container)
    typeButton:SetSize(60, 20)
    typeButton:SetPoint("LEFT", numberText, "RIGHT", 6, 0)
    typeButton:SetText("Player")
    row.TypeButton = typeButton

    local playerBox = CreateFrame(
        "EditBox",
        "ImpLootLootPriorityCandidateBox" .. index,
        container,
        "InputBoxTemplate"
    )

    playerBox:SetSize(150, 20)
    playerBox:SetPoint("LEFT", typeButton, "RIGHT", 10, 0)
    playerBox:SetAutoFocus(false)
    row.PlayerBox = playerBox

    local classDropdown = CreateFrame(
        "Frame",
        "ImpLootLootPriorityCandidateDropdown" .. index,
        container,
        "UIDropDownMenuTemplate"
    )

    classDropdown:SetPoint("LEFT", typeButton, "RIGHT", 4, -2)
    UIDropDownMenu_SetWidth(classDropdown, 120)
    row.ClassDropdown = classDropdown
    row.SelectedClass = nil

    UIDropDownMenu_Initialize(classDropdown, function(self_, level)

        for _, className in ipairs(ImpLoot.CLASS_ORDER) do

            local info = UIDropDownMenu_CreateInfo()

            info.text = className
            info.checked = (row.SelectedClass == className)

            info.func = function()
                row.SelectedClass = className
                UIDropDownMenu_SetText(classDropdown, className)
            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    playerBox:Show()
    classDropdown:Hide()

    typeButton:SetScript("OnClick", function()

        row.Type = (row.Type == "Player") and "Class" or "Player"
        typeButton:SetText(row.Type)

        if row.Type == "Player" then
            playerBox:Show()
            classDropdown:Hide()
        else
            playerBox:Hide()
            classDropdown:Show()
        end

    end)

    -------------------------------------------------
    -- Move Up / Down
    --
    -- Swaps this row's data with the adjacent one --
    -- reordering or fixing a mistake without retyping
    -- names. Anchored off typeButton (not playerBox/
    -- classDropdown) so their position stays fixed
    -- regardless of which of those two is currently
    -- shown.
    -------------------------------------------------

    local upButton = ImpLoot.Theme:CreateMenuButton(container)
    upButton:SetSize(20, 20)
    upButton:SetPoint("LEFT", typeButton, "RIGHT", 175, 0)
    upButton:SetText("^")
    row.UpButton = upButton

    local downButton = ImpLoot.Theme:CreateMenuButton(container)
    downButton:SetSize(20, 20)
    downButton:SetPoint("LEFT", upButton, "RIGHT", 2, 0)
    downButton:SetText("v")
    row.DownButton = downButton

    if index == 1 then
        upButton:Disable()
    end

    if index == 5 then
        downButton:Disable()
    end

    upButton:SetScript("OnClick", function()
        LootPriorityWindow:SwapCandidateRows(index, index - 1)
    end)

    downButton:SetScript("OnClick", function()
        LootPriorityWindow:SwapCandidateRows(index, index + 1)
    end)

    return row

end

-------------------------------------------------
-- Get / Set Row Data
-------------------------------------------------

function LootPriorityWindow:GetRowData(row)

    if row.Type == "Player" then
        return { Type = "Player", Value = row.PlayerBox:GetText() }
    end

    return { Type = "Class", Value = row.SelectedClass }

end

function LootPriorityWindow:SetRowData(row, data)

    row.Type = data.Type
    row.TypeButton:SetText(data.Type)

    if data.Type == "Player" then

        row.PlayerBox:SetText(data.Value or "")
        row.PlayerBox:Show()
        row.ClassDropdown:Hide()

    else

        row.SelectedClass = data.Value
        row.PlayerBox:Hide()
        row.ClassDropdown:Show()

        if UIDropDownMenu_SetText then
            UIDropDownMenu_SetText(row.ClassDropdown, data.Value or "")
        end

    end

end

-------------------------------------------------
-- Swap Candidate Rows
-------------------------------------------------

function LootPriorityWindow:SwapCandidateRows(indexA, indexB)

    local rowA = self.CandidateRows[indexA]
    local rowB = self.CandidateRows[indexB]

    if not rowA or not rowB then
        return
    end

    local dataA = self:GetRowData(rowA)
    local dataB = self:GetRowData(rowB)

    self:SetRowData(rowA, dataB)
    self:SetRowData(rowB, dataA)

end

-------------------------------------------------
-- Existing Items List
--
-- Shows every item already configured for the active
-- list. Clicking a row loads it back into the editor
-- for changes; the x removes it entirely.
-------------------------------------------------

function LootPriorityWindow:BuildExistingItemsList(frame)

    local header = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT", self.EditorBottom, "BOTTOMLEFT", 0, -16)
    header:SetText("Items in this list")
    self.ExistingItemsHeader = header

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootLootPriorityScrollFrame",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    self.ItemsScrollFrame = scrollFrame

    scrollFrame:SetPoint("TOPLEFT", header, "BOTTOMLEFT", -2, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -26, 10)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetWidth(WINDOW_WIDTH - 40 - 22) -- 22 = the increased left margin shift
    scrollChild:SetHeight(1)

    self.ItemsScrollChild = scrollChild

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

    self.ItemRows = {}

end


-------------------------------------------------
-- Refresh Mode Buttons
--
-- Disabling the currently-selected one is the "this
-- is active" indicator -- you can't click what's
-- already selected.
-------------------------------------------------

function LootPriorityWindow:RefreshModeButtons()

    if not self.ModeButton then
        return
    end

    self.ModeButton:SetText(self.Mode)

end

-------------------------------------------------
-- Clear Editor
-------------------------------------------------

function LootPriorityWindow:ClearEditor()

    self.PendingItemID = nil
    self.EditingLabel:SetText("Select an item below to set its candidates.")

    self.Mode = "Priority"
    self:RefreshModeButtons()

    for _, row in ipairs(self.CandidateRows) do

        row.Type = "Player"
        row.TypeButton:SetText("Player")

        row.PlayerBox:SetText("")
        row.PlayerBox:Show()

        row.SelectedClass = nil
        row.ClassDropdown:Hide()

        if UIDropDownMenu_SetText then
            UIDropDownMenu_SetText(row.ClassDropdown, "")
        end

    end

end

-------------------------------------------------
-- Save Item
-------------------------------------------------

function LootPriorityWindow:SaveItem()

    if not self.PendingItemID then
        ImpLoot:Print("Select an item from the list below first.")
        return
    end

    local activeName = ImpLoot.LootCouncil:GetActiveListName()

    if not activeName then
        ImpLoot:Print("Create or select a list first.")
        return
    end

    local candidates = {}

    for _, row in ipairs(self.CandidateRows) do

        if row.Type == "Player" then

            local name = row.PlayerBox:GetText()

            if name and name ~= "" then
                table.insert(candidates, { Type = "Player", Value = name })
            end

        else

            if row.SelectedClass then
                table.insert(candidates, { Type = "Class", Value = row.SelectedClass })
            end

        end

    end

    if #candidates == 0 then
        ImpLoot:Print("Add at least one candidate before saving.")
        return
    end

    local cached = ImpLoot.ItemCache:GetItem(self.PendingItemID)
    local itemName = (cached and cached.Name) or ("Item " .. self.PendingItemID)

    local ok = ImpLoot.LootCouncil:SetItem(
        activeName, self.PendingItemID, itemName, self.Mode, candidates
    )

    if ok then

        self:ClearEditor()
        self:RefreshItemsList()

    else

        ImpLoot:Print("Could not save -- check the mode and candidate count (max 5).")

    end

end

-------------------------------------------------
-- Load Item (Back Into The Editor)
-------------------------------------------------

function LootPriorityWindow:LoadItem(itemID)

    local activeName = ImpLoot.LootCouncil:GetActiveListName()

    if not activeName then
        return
    end

    local item = ImpLoot.LootCouncil:GetItem(activeName, itemID)

    if not item then
        return
    end

    self:ClearEditor()

    self.PendingItemID = itemID
    self.EditingLabel:SetText("Editing: " .. item.Name)

    self.Mode = item.Mode
    self:RefreshModeButtons()

    for i, candidate in ipairs(item.Candidates) do

        local row = self.CandidateRows[i]

        if row then

            row.Type = candidate.Type
            row.TypeButton:SetText(candidate.Type)

            if candidate.Type == "Player" then

                row.PlayerBox:SetText(candidate.Value)
                row.PlayerBox:Show()
                row.ClassDropdown:Hide()

            else

                row.SelectedClass = candidate.Value
                row.PlayerBox:Hide()
                row.ClassDropdown:Show()

                if UIDropDownMenu_SetText then
                    UIDropDownMenu_SetText(row.ClassDropdown, candidate.Value)
                end

            end

        end

    end

end

-------------------------------------------------
-- Acquire Item Row
-------------------------------------------------

function LootPriorityWindow:AcquireItemRow(index)

    local row = self.ItemRows[index]

    if row then
        return row
    end

    row = CreateFrame("Button", nil, self.ItemsScrollChild)
    row:SetSize(WINDOW_WIDTH - 50, 20)

    local background = row:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetTexture("Interface\\Buttons\\WHITE8X8")
    background:SetVertexColor(1, 1, 1, 0)
    row.Background = background

    row:SetScript("OnEnter", function()
        background:SetVertexColor(1, 1, 1, 0.08)
    end)

    row:SetScript("OnLeave", function()
        background:SetVertexColor(1, 1, 1, 0)
    end)

    row.Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.Text:SetPoint("TOPLEFT", 4, -2)
    row.Text:SetJustifyH("LEFT")
    row.Text:SetWidth(WINDOW_WIDTH - 84)

    row.RemoveButton = CreateFrame("Button", nil, row)
    row.RemoveButton:SetSize(14, 14)
    row.RemoveButton:SetPoint("RIGHT", -4, 0)

    local removeText = row.RemoveButton:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    removeText:SetAllPoints()
    removeText:SetText("x")

    self.ItemRows[index] = row

    return row

end

-------------------------------------------------
-- Refresh Items List
-------------------------------------------------

function LootPriorityWindow:RefreshItemsList()

    if not self.ItemRows or not self.ItemsScrollChild then
        return
    end

    for _, row in ipairs(self.ItemRows) do
        row:Hide()
    end

    local activeName = ImpLoot.LootCouncil:GetActiveListName()

    if not activeName or not ImpLoot.LootCouncil.DB.Lists[activeName] then

        self.ItemsScrollChild:SetHeight(1)

        if self.ItemsScrollFrame.UpdateScrollIndicators then
            self.ItemsScrollFrame:UpdateScrollIndicators()
        end

        return

    end

    local list = ImpLoot.LootCouncil.DB.Lists[activeName]

    local itemIDs = {}

    for itemID in pairs(list.Items) do
        table.insert(itemIDs, itemID)
    end

    table.sort(itemIDs, function(a, b)
        return list.Items[a].Name < list.Items[b].Name
    end)

    local y = 0

    for index, itemID in ipairs(itemIDs) do

        local item = list.Items[itemID]
        local row = self:AcquireItemRow(index)

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", self.ItemsScrollChild, "TOPLEFT", 0, -y)

        local candidateSummary = {}

        for _, c in ipairs(item.Candidates) do
            table.insert(candidateSummary, c.Value)
        end

        row.Text:SetText(
            item.Name .. " (" .. item.Mode .. "): " .. table.concat(candidateSummary, ", ")
        )

        -- rows are sized to their actual (possibly wrapped)
        -- text height, not a fixed single-line height, so a
        -- long candidate list wrapping to two lines doesn't
        -- overlap the row below it
        local rowHeight = math.max((row.Text:GetStringHeight() or 12) + 6, 20)
        row:SetHeight(rowHeight)

        row.RemoveButton:SetScript("OnClick", function()
            ImpLoot.LootCouncil:RemoveItem(activeName, itemID)
            LootPriorityWindow:RefreshItemsList()
        end)

        row:SetScript("OnClick", function()
            LootPriorityWindow:LoadItem(itemID)
        end)

        row:Show()

        y = y + rowHeight + 8

    end

    self.ItemsScrollChild:SetHeight(math.max(y, 1))

    if self.ItemsScrollFrame.UpdateScrollChildRect then
        self.ItemsScrollFrame:UpdateScrollChildRect()
    end

    if self.ItemsScrollFrame.UpdateScrollIndicators then
        self.ItemsScrollFrame:UpdateScrollIndicators()
    end

end

-------------------------------------------------
-- Refresh / Show / Hide / Toggle
-------------------------------------------------

function LootPriorityWindow:Refresh()

    local activeName = ImpLoot.LootCouncil:GetActiveListName()

    if UIDropDownMenu_SetText and self.ListDropdown then
        UIDropDownMenu_SetText(self.ListDropdown, activeName or "No lists yet")
    end

    if self.DeleteListButton then

        if activeName then
            self.DeleteListButton:Enable()
        else
            self.DeleteListButton:Disable()
        end

    end

    self:RefreshModeButtons()
    self:RefreshItemsList()

end

function LootPriorityWindow:Show()
    self:Refresh()
    self.Frame:Show()
end

function LootPriorityWindow:Hide()
    self.Frame:Hide()
end

function LootPriorityWindow:Toggle()

    if self.Frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end

end
