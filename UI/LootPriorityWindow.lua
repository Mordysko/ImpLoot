-------------------------------------------------
-- Loot Council / Priority Window
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

-- Two columns: the list's items on the left, the editor
-- for the selected item on the right. The list controls
-- (List / New list / Add Item / Import / Export) sit
-- centred across the top.
local WINDOW_WIDTH = 810
local WINDOW_HEIGHT = 570
local CANDIDATE_ROW_HEIGHT = 26

local TOP_CONTROLS_X = 210      -- left edge of the centred top controls
local COLUMNS_TOP = -128        -- where both columns start
local LEFT_COLUMN_X = 14
local LEFT_COLUMN_WIDTH = 380
local RIGHT_COLUMN_X = 420

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
    title:SetText("Loot Council / Priority")

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

    local ok3, err3 = pcall(function() self:BuildCouncilMembers(frame) end)

    if not ok3 then
        ImpLoot:Print("|cffff5555Loot Priority window failed to build (BuildCouncilMembers):|r " .. tostring(err3))
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
    listLabel:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", TOP_CONTROLS_X, -10)
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

            -- The one loot is using right now (Loot Master window)
            if ImpLoot.LootCouncil:GetActiveListName() == listName then
                info.text = listName .. " |cff88ff88(active)|r"
            end

            info.checked = (ImpLoot.LootCouncil:GetEditingListName() == listName)

            info.func = function()

                ImpLoot.LootCouncil:SetEditingList(listName)
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

        local activeName = ImpLoot.LootCouncil:GetEditingListName()

        if activeName then

            ImpLoot.LootCouncil:DeleteList(activeName)
            self:Refresh()

        end

    end)

    -------------------------------------------------
    -- New List
    -------------------------------------------------

    local newListLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    newListLabel:SetPoint("TOPLEFT", listLabel, "BOTTOMLEFT", 0, -16)
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

                ImpLoot.LootCouncil:SetEditingList(name)
                newListBox:SetText("")
                self:Refresh()

            end

        end

    end)

    self.ListRowBottom = newListLabel

end

-------------------------------------------------
-- Add Item Panel
--
-- Pops out under the Add Item button: type an item's
-- name or ID (or shift-click one into the box) and Add,
-- or "Add multiple items..." for the alt-click workflow.
-- A newly added item opens straight in the editor.
-------------------------------------------------

-- Adds one item (by ID) to the active list and opens it
-- in the editor. Already on the list: just opens it.
function LootPriorityWindow:AddItemByID(itemID, itemName)

    local activeName = ImpLoot.LootCouncil:GetEditingListName()

    if not activeName then
        ImpLoot:Print("Create or select a list first.")
        return
    end

    local list = ImpLoot.LootCouncil.DB.Lists[activeName]

    if list.Items[itemID] then
        ImpLoot:Print((itemName or "That item") .. " is already on this list.")
    else
        ImpLoot.LootCouncil:SetItem(activeName, itemID, itemName or ("Item " .. itemID), "Priority", {})
    end

    self.AddItemBox:SetText("")
    self.AddItemPanel:Hide()

    self:RefreshItemsList()
    self:LoadItem(itemID)

end

-- Enter in the box: an ID or shift-clicked link is added
-- directly; otherwise the top search result is.
function LootPriorityWindow:AddTypedItem()

    local text = (self.AddItemBox:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")
    local linkedID = tonumber(text:match("item:(%d+)")) or tonumber(text)

    if linkedID then

        local entry = ImpLoot.Database:FindItemByID(linkedID)
        local name = (entry and entry.Name) or GetItemInfo(linkedID) or text:match("%[(.-)%]")

        self:AddItemByID(linkedID, name)
        return

    end

    local first = self.AddItemResults and self.AddItemResults[1]

    if first then
        self:AddItemByID(first.ItemID, first.ItemName)
    elseif #text >= 2 then
        ImpLoot:Print("No items match \"" .. text .. "\".")
    end

end

-------------------------------------------------
-- Add Item Search
--
-- Same as adding an item to a soft reserve: type at
-- least 2 letters and matching items appear underneath.
-- Every version of an item is its own result, labelled
-- with its boss and size ("Mimiron  25", "... 25H"), and
-- items from the raid this list is for come first.
-------------------------------------------------

local ADD_RESULT_ROWS = 8
local ADD_RESULT_HEIGHT = 18

function LootPriorityWindow:SearchItemsForList(text)

    local results, seen = {}, {}

    if not text or #text < 2 then
        return results
    end

    -- Raids this list already has items from
    local listRaids = {}
    local activeName = ImpLoot.LootCouncil:GetEditingListName()
    local list = activeName and ImpLoot.LootCouncil.DB.Lists[activeName]

    for itemID in pairs(list and list.Items or {}) do

        local entry = ImpLoot.Database:FindItemByID(itemID)

        if entry and entry.Raid then
            listRaids[entry.Raid.Name] = true
        end

    end

    for _, found in ipairs(ImpLoot.Database:Search(text)) do

        local item = found.Item
        local bossName = (found.Boss and found.Boss.Name)
            or (item.IsTrash and "Trash")
            or (item.IsExtraDrops and "Extra drops")
            or ""
        local size = item.Difficulty or ""

        for _, version in ipairs({
            { ID = item.IDs and item.IDs.Normal, Tag = size },
            { ID = item.IDs and item.IDs.Heroic, Tag = size .. "H" },
        }) do

            if version.ID and not seen[version.ID] then

                seen[version.ID] = true

                table.insert(results, {
                    ItemID = version.ID,
                    ItemName = item.Name,
                    Quality = item.Quality,
                    Where = bossName .. ((version.Tag ~= "") and ("  " .. version.Tag) or ""),
                    InListRaid = item.Raid and listRaids[item.Raid.Name] or false,
                    OnList = list and list.Items[version.ID] ~= nil,
                    Order = #results,
                })

            end

        end

    end

    table.sort(results, function(a, b)

        if a.InListRaid ~= b.InListRaid then
            return a.InListRaid
        end

        return a.Order < b.Order

    end)

    return results

end

function LootPriorityWindow:UpdateAddItemSearch()

    local text = (self.AddItemBox:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")
    local panel = self.AddItemPanel

    -- An ID or link isn't searched -- Enter adds it
    local isID = text:match("item:%d+") or tonumber(text)

    local results = (not isID) and self:SearchItemsForList(text) or {}
    self.AddItemResults = results

    local y = 0

    for i, row in ipairs(self.AddItemRows) do

        local result = results[i]

        if result then

            row.Result = result

            local r, g, b = ImpLoot.Theme:GetQualityColor(result.Quality)
            row.NameText:SetText(result.ItemName)
            row.NameText:SetTextColor(r, g, b)
            row.WhereText:SetText(result.OnList and "on this list" or result.Where)
            row:Show()

            y = y + ADD_RESULT_HEIGHT

        else

            row.Result = nil
            row:Hide()

        end

    end

    if #text >= 2 and not isID and #results == 0 then
        self.AddItemEmpty:Show()
        y = ADD_RESULT_HEIGHT
    else
        self.AddItemEmpty:Hide()
    end

    if #text < 2 or isID then
        self.AddItemHint:Show()
    else
        self.AddItemHint:Hide()
    end

    if #results > ADD_RESULT_ROWS then
        self.AddItemMore:SetText("+" .. (#results - ADD_RESULT_ROWS) .. " more -- keep typing to narrow it down")
        self.AddItemMore:Show()
        y = y + 14
    else
        self.AddItemMore:Hide()
    end

    self.AddItemResultsFrame:SetHeight(math.max(y, 1))

    -- label + box, then the results (or the one-line hint),
    -- then "Add multiple items..." with room to breathe
    panel:SetHeight(50 + (y > 0 and (y + 6) or 18) + 34)

end

function LootPriorityWindow:BuildAddItemPanel(frame, anchorButton)

    local panel = CreateFrame("Frame", nil, frame)
    panel:SetSize(300, 102)
    panel:SetPoint("TOPLEFT", anchorButton, "BOTTOMLEFT", 0, -4)
    panel:SetFrameLevel(frame:GetFrameLevel() + 30)
    panel:EnableMouse(true)
    panel:Hide()

    -- Solid, so the windows behind don't show through
    ImpLoot.Theme:ApplySolidPanelStyle(panel)

    self.AddItemPanel = panel

    local label = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("TOPLEFT", 10, -10)
    label:SetText("Add an item to this list:")

    local box = CreateFrame("EditBox", "ImpLootLootPriorityAddItemBox", panel, "InputBoxTemplate")
    box:SetSize(240, 20)
    box:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 6, -4)
    box:SetAutoFocus(false)
    self.AddItemBox = box

    box:SetScript("OnTextChanged", function() self:UpdateAddItemSearch() end)
    box:SetScript("OnEnterPressed", function() self:AddTypedItem() end)
    box:SetScript("OnEscapePressed", function() panel:Hide() end)

    local hint = panel:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    hint:SetPoint("TOPLEFT", box, "BOTTOMLEFT", -2, -4)
    hint:SetText("Type at least 2 letters of its name, or its ID")
    self.AddItemHint = hint

    -- Results, under the box
    local resultsFrame = CreateFrame("Frame", nil, panel)
    resultsFrame:SetPoint("TOPLEFT", box, "BOTTOMLEFT", -6, -4)
    resultsFrame:SetPoint("RIGHT", panel, "RIGHT", -8, 0)
    resultsFrame:SetHeight(1)
    self.AddItemResultsFrame = resultsFrame

    self.AddItemRows = {}

    for i = 1, ADD_RESULT_ROWS do

        local row = CreateFrame("Button", nil, resultsFrame)
        row:SetHeight(ADD_RESULT_HEIGHT)
        row:SetPoint("TOPLEFT", resultsFrame, "TOPLEFT", 0, -((i - 1) * ADD_RESULT_HEIGHT))
        row:SetPoint("RIGHT", resultsFrame, "RIGHT", 0, 0)
        row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

        local whereText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        whereText:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        whereText:SetJustifyH("RIGHT")
        whereText:SetTextColor(0.6, 0.6, 0.6)
        row.WhereText = whereText

        local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        nameText:SetPoint("LEFT", row, "LEFT", 4, 0)
        nameText:SetPoint("RIGHT", whereText, "LEFT", -6, 0)
        nameText:SetJustifyH("LEFT")
        row.NameText = nameText

        row:SetScript("OnClick", function()
            if row.Result then
                self:AddItemByID(row.Result.ItemID, row.Result.ItemName)
            end
        end)

        row:SetScript("OnEnter", function()
            if row.Result then
                GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink("item:" .. row.Result.ItemID)
                GameTooltip:Show()
            end
        end)

        row:SetScript("OnLeave", function() GameTooltip:Hide() end)

        row:Hide()

        self.AddItemRows[i] = row

    end

    local empty = resultsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    empty:SetPoint("TOPLEFT", resultsFrame, "TOPLEFT", 4, -3)
    empty:SetText("No matching items.")
    empty:SetTextColor(0.6, 0.6, 0.6)
    empty:Hide()
    self.AddItemEmpty = empty

    local more = resultsFrame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    more:SetPoint("TOPLEFT", resultsFrame, "TOPLEFT", 4, -(ADD_RESULT_ROWS * ADD_RESULT_HEIGHT) - 1)
    more:Hide()
    self.AddItemMore = more

    local multipleButton = ImpLoot.Theme:CreateMenuButton(panel)
    multipleButton:SetSize(160, 20)
    multipleButton:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 10, 8)
    multipleButton:SetText("Add multiple items...")
    multipleButton:SetScript("OnClick", function() self.StartPopulate() end)

    multipleButton:SetScript("OnEnter", function(button)
        GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
        GameTooltip:AddLine("Add multiple items")
        GameTooltip:AddLine("Opens the raid browser: alt-click items to add them to this list, then confirm.", 1, 1, 1, true)
        GameTooltip:Show()
    end)

    multipleButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

    panel:SetScript("OnHide", function() box:ClearFocus() end)
    panel:SetScript("OnShow", function() self:UpdateAddItemSearch() end)

    -- Shift-clicking an item while the box has focus puts
    -- its link in the box (as it would in chat)
    if not LootPriorityWindow.LinkHooked and ChatEdit_InsertLink then

        LootPriorityWindow.LinkHooked = true

        local original = ChatEdit_InsertLink

        ChatEdit_InsertLink = function(link, ...)

            if box:IsVisible() and box:HasFocus() and link then
                box:SetText(link)
                return true
            end

            return original(link, ...)

        end

    end

end

-------------------------------------------------
-- Item Editor
-------------------------------------------------

function LootPriorityWindow:BuildItemEditor(frame)

    -------------------------------------------------
    -- Add Item
    --
    -- Opens a small panel with the two ways to add items:
    -- type a name or ID (or shift-click an item into the
    -- box), or "Add multiple items..." -- the main-window
    -- alt-click workflow (formerly Populate Item List).
    -------------------------------------------------

    local populateButton = ImpLoot.Theme:CreateMenuButton(frame)
    populateButton:SetSize(150, 22)
    populateButton:SetPoint("TOPLEFT", self.ListRowBottom, "BOTTOMLEFT", 0, -16)
    populateButton:SetText("Add Item")
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

    self:BuildAddItemPanel(frame, populateButton)

    populateButton:SetScript("OnClick", function()

        if not ImpLoot.LootCouncil:GetEditingListName() then
            ImpLoot:Print("Create or select a list first.")
            return
        end

        if self.AddItemPanel:IsShown() then
            self.AddItemPanel:Hide()
        else
            self.AddItemPanel:Show()
            self.AddItemBox:SetText("")
            self.AddItemBox:SetFocus()
        end

    end)

    -- "Add multiple items...": the alt-click workflow
    self.StartPopulate = function()

        local activeName = ImpLoot.LootCouncil:GetEditingListName()

        if not activeName then
            ImpLoot:Print("Create or select a list first.")
            return
        end

        self.AddItemPanel:Hide()

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

    end

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
    editingLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", RIGHT_COLUMN_X + 4, COLUMNS_TOP)
    editingLabel:SetWidth(WINDOW_WIDTH - RIGHT_COLUMN_X - 24)
    editingLabel:SetJustifyH("LEFT")
    editingLabel:SetText("Select an item on the left to set its candidates.")
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
    saveButton:SetSize(124, 22)
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
    row.SelectedSpec = nil

    -------------------------------------------------
    -- Class Dropdown Label
    --
    -- "Mage" alone, or "Mage - Fire" once a spec has
    -- been picked from the pullout submenu.
    -------------------------------------------------

    local function UpdateClassDropdownLabel()

        local label = row.SelectedClass or ""

        if row.SelectedSpec then
            label = label .. " - " .. row.SelectedSpec
        end

        UIDropDownMenu_SetText(classDropdown, label)

    end

    -------------------------------------------------
    -- Level 1 (classes, each with a pullout arrow to
    -- its specs) / Level 2 (that class's specs)
    --
    -- Spec is a descriptive label only -- WotLK has no
    -- reliable way for an addon to passively know
    -- another player's current spec, so this doesn't
    -- change how a Class candidate resolves, only how
    -- it's labeled for whoever's assigning to read.
    -------------------------------------------------

    UIDropDownMenu_Initialize(classDropdown, function(self_, level)

        level = level or 1

        if level == 1 then

            for _, className in ipairs(ImpLoot.CLASS_ORDER) do

                local info = UIDropDownMenu_CreateInfo()

                info.text = className
                info.checked = (row.SelectedClass == className and not row.SelectedSpec)
                info.hasArrow = (ImpLoot.CLASS_SPECS[className] ~= nil)
                info.menuList = className

                info.func = function()
                    row.SelectedClass = className
                    row.SelectedSpec = nil
                    UpdateClassDropdownLabel()
                    CloseDropDownMenus()
                end

                UIDropDownMenu_AddButton(info, level)

            end

        elseif level == 2 then

            local className = UIDROPDOWNMENU_MENU_VALUE
            local specs = ImpLoot.CLASS_SPECS[className]

            if not specs then
                return
            end

            for _, specName in ipairs(specs) do

                local info = UIDropDownMenu_CreateInfo()

                info.text = specName
                info.checked = (row.SelectedClass == className and row.SelectedSpec == specName)

                info.func = function()
                    row.SelectedClass = className
                    row.SelectedSpec = specName
                    UpdateClassDropdownLabel()
                    CloseDropDownMenus()
                end

                UIDropDownMenu_AddButton(info, level)

            end

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
    row.UpButton = upButton

    local upArrow = ImpLoot.Theme:CreateVerticalArrow(upButton, "UP")
    upArrow:SetSize(10, 10)
    upArrow:SetPoint("CENTER", 1, 1)
    row.UpArrow = upArrow

    local downButton = ImpLoot.Theme:CreateMenuButton(container)
    downButton:SetSize(20, 20)
    downButton:SetPoint("LEFT", upButton, "RIGHT", 2, 0)
    row.DownButton = downButton

    local downArrow = ImpLoot.Theme:CreateVerticalArrow(downButton, "DOWN")
    downArrow:SetSize(10, 10)
    downArrow:SetPoint("CENTER", 1, -3)
    row.DownArrow = downArrow

    -- Slot 1 can't move up and slot 5 can't move down --
    -- removed entirely rather than just disabled, since a
    -- button that can never do anything is just clutter.
    if index == 1 then
        upButton:Hide()
    end

    if index == 5 then
        downButton:Hide()
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

    return { Type = "Class", Value = row.SelectedClass, Spec = row.SelectedSpec }

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
        row.SelectedSpec = data.Spec
        row.PlayerBox:Hide()
        row.ClassDropdown:Show()

        if UIDropDownMenu_SetText then
            local label = data.Value or ""
            if data.Spec then
                label = label .. " - " .. data.Spec
            end
            UIDropDownMenu_SetText(row.ClassDropdown, label)
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
    header:SetPoint("TOPLEFT", frame, "TOPLEFT", LEFT_COLUMN_X + 8, COLUMNS_TOP)
    header:SetText("Items in this list")
    self.ExistingItemsHeader = header

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootLootPriorityScrollFrame",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    self.ItemsScrollFrame = scrollFrame

    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", LEFT_COLUMN_X, COLUMNS_TOP - 20)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", LEFT_COLUMN_X + LEFT_COLUMN_WIDTH, 14)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetWidth(LEFT_COLUMN_WIDTH)
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
    self.EditingLabel:SetText("Select an item on the left to set its candidates.")

    self.Mode = "Priority"
    self:RefreshModeButtons()

    for _, row in ipairs(self.CandidateRows) do

        row.Type = "Player"
        row.TypeButton:SetText("Player")

        row.PlayerBox:SetText("")
        row.PlayerBox:Show()

        row.SelectedClass = nil
        row.SelectedSpec = nil
        row.ClassDropdown:Hide()

        if UIDropDownMenu_SetText then
            UIDropDownMenu_SetText(row.ClassDropdown, "")
        end

    end

    for _, itemRow in ipairs(self.ItemRows or {}) do
        itemRow.IsSelected = false
        self:ApplyRowHighlight(itemRow)
    end

end

-------------------------------------------------
-- Save Item
-------------------------------------------------

function LootPriorityWindow:SaveItem()

    if not self.PendingItemID then
        ImpLoot:Print("Select an item from the list on the left first.")
        return
    end

    local activeName = ImpLoot.LootCouncil:GetEditingListName()

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
                table.insert(candidates, {
                    Type = "Class",
                    Value = row.SelectedClass,
                    Spec = row.SelectedSpec,
                })
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

    local activeName = ImpLoot.LootCouncil:GetEditingListName()

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
    self:RefreshItemsList()

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
                row.SelectedSpec = candidate.Spec
                row.PlayerBox:Hide()
                row.ClassDropdown:Show()

                if UIDropDownMenu_SetText then
                    local label = candidate.Value or ""
                    if candidate.Spec then
                        label = label .. " - " .. candidate.Spec
                    end
                    UIDropDownMenu_SetText(row.ClassDropdown, label)
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
    row:SetSize(LEFT_COLUMN_WIDTH - 4, 20)

    local background = row:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetTexture("Interface\\Buttons\\WHITE8X8")
    background:SetVertexColor(1, 1, 1, 0)
    row.Background = background

    -- Gold bar down the left edge of the item being edited
    local accent = row:CreateTexture(nil, "ARTWORK")
    accent:SetPoint("TOPLEFT", 0, 0)
    accent:SetPoint("BOTTOMLEFT", 0, 0)
    accent:SetWidth(3)
    accent:SetTexture("Interface\\Buttons\\WHITE8X8")
    accent:SetVertexColor(1, 0.82, 0, 1)
    accent:Hide()
    row.Accent = accent

    row:SetScript("OnEnter", function()
        if not row.IsSelected then
            background:SetVertexColor(1, 1, 1, 0.08)
        end
    end)

    row:SetScript("OnLeave", function()
        LootPriorityWindow:ApplyRowHighlight(row)
    end)

    row.Icon = row:CreateTexture(nil, "ARTWORK")
    row.Icon:SetSize(16, 16)
    row.Icon:SetPoint("TOPLEFT", 6, -3)

    row.Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.Text:SetPoint("TOPLEFT", row.Icon, "TOPRIGHT", 5, -2)
    row.Text:SetJustifyH("LEFT")
    row.Text:SetWidth(LEFT_COLUMN_WIDTH - 50)

    row.RemoveButton = CreateFrame("Button", nil, row)
    row.RemoveButton:SetSize(14, 14)
    row.RemoveButton:SetPoint("RIGHT", -4, 0)

    local removeText = row.RemoveButton:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    removeText:SetAllPoints()
    removeText:SetText("x")

    self.ItemRows[index] = row

    return row

end

-- Selected (being edited): gold tint and bar; otherwise clear
function LootPriorityWindow:ApplyRowHighlight(row)

    if row.IsSelected then
        row.Background:SetVertexColor(1, 0.82, 0, 0.16)
        row.Accent:Show()
    else
        row.Background:SetVertexColor(1, 1, 1, 0)
        row.Accent:Hide()
    end

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

    local activeName = ImpLoot.LootCouncil:GetEditingListName()

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

    -- Same name twice (a 10- and a 25-player version): tag
    -- each with its size so they can be told apart
    local nameCount = {}

    for _, itemID in ipairs(itemIDs) do
        local name = list.Items[itemID].Name
        nameCount[name] = (nameCount[name] or 0) + 1
    end

    local function SizeTag(itemID)

        local entry = ImpLoot.Database:FindItemByID(itemID)

        if not entry then
            return nil
        end

        local tag = entry.Difficulty or "10"

        if entry.IDs and entry.IDs.Heroic == itemID then
            tag = tag .. "H"
        end

        return tag

    end

    local y = 0

    for index, itemID in ipairs(itemIDs) do

        local item = list.Items[itemID]
        local row = self:AcquireItemRow(index)

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", self.ItemsScrollChild, "TOPLEFT", 0, -y)

        local candidateSummary = {}

        for _, c in ipairs(item.Candidates) do
            local label = c.Value
            if c.Type == "Class" and c.Spec then
                label = label .. " (" .. c.Spec .. ")"
            end
            table.insert(candidateSummary, label)
        end

        -- Item name in its quality colour, then the mode and
        -- candidates -- so the item stands apart from the names
        local cached = ImpLoot.ItemCache:GetItem(itemID)
        local qr, qg, qb = ImpLoot.Theme:GetQualityColor((cached and cached.Quality) or 4)

        row.Icon:SetTexture((cached and cached.Texture) or "Interface\\Icons\\INV_Misc_QuestionMark")

        local candidatesText = (#candidateSummary > 0) and table.concat(candidateSummary, ", ")
            or "|cff888888no candidates yet|r"

        row.IsSelected = (self.PendingItemID == itemID)

        -- While it's being edited, the names are gold too
        local namesColor = row.IsSelected and "|cffffd100" or "|cffffffff"

        local displayName = (cached and cached.Name) or item.Name

        if nameCount[item.Name] > 1 then
            local tag = SizeTag(itemID)
            if tag then
                displayName = displayName .. " [" .. tag .. "]"
            end
        end

        row.Text:SetText(string.format("|cff%02x%02x%02x%s|r |cff999999(%s):|r %s%s|r",
            math.floor(qr * 255 + 0.5), math.floor(qg * 255 + 0.5), math.floor(qb * 255 + 0.5),
            displayName, item.Mode, namesColor, candidatesText))

        self:ApplyRowHighlight(row)

        -- rows are sized to their actual (possibly wrapped)
        -- text height, not a fixed single-line height, so a
        -- long candidate list wrapping to two lines doesn't
        -- overlap the row below it
        local rowHeight = math.max((row.Text:GetStringHeight() or 12) + 8, 22)
        row:SetHeight(rowHeight)

        row.RemoveButton:SetScript("OnClick", function()

            ImpLoot.LootCouncil:RemoveItem(activeName, itemID)

            if LootPriorityWindow.PendingItemID == itemID then
                LootPriorityWindow:ClearEditor()
            end

            LootPriorityWindow:RefreshItemsList()

        end)

        row:SetScript("OnClick", function()
            LootPriorityWindow:LoadItem(itemID)
        end)

        row:Show()

        y = y + rowHeight + 4

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
-- Loot Council And Disenchanter Lists
--
-- Under the editor, side by side: the Loot Council
-- (who gets the vote popup) and the Disenchanters (who
-- gets an item nobody rolled on -- the first one in the
-- raid, so they're numbered). Both belong to the list
-- being edited: whichever list is active in the Loot
-- Master window brings its own council and
-- disenchanters with it.
--
-- Each Add opens the same solid picker: everyone in the
-- group not already on that list, class coloured,
-- narrowed by typing -- or type any name and press
-- Enter.
-------------------------------------------------

local PERSON_ROW_HEIGHT = 17
local PERSON_ROWS = 7
local PERSON_COLUMN_WIDTH = 170
local PICK_ROWS = 10

local function ClassToken(name)
    return ImpLoot.LootMaster and ImpLoot.LootMaster.GetClassForPlayer
        and ImpLoot.LootMaster:GetClassForPlayer(name)
end

-- The two lists, by key
local PEOPLE = {

    Members = {
        Title = "Loot Council",
        Empty = "No members yet",
        PickLabel = "Add to the Loot Council:",
        Get = function(listName)
            return ImpLoot.LootCouncil:GetMembers(listName)
        end,
        Has = function(name, listName)
            return ImpLoot.LootCouncil:IsMember(name, listName)
        end,
        Add = function(name, listName)
            return ImpLoot.LootCouncil:AddMember(name, listName)
        end,
        Remove = function(name, listName)
            ImpLoot.LootCouncil:RemoveMember(name, listName)
        end,
        Numbered = false,
        Already = " is already on the Loot Council.",
    },

    Disenchanters = {
        Title = "Disenchanter",
        Empty = "No disenchanter yet",
        PickLabel = "Add a disenchanter:",
        Get = function(listName)
            local names = {}
            for _, entry in ipairs(ImpLoot.LootCouncil:GetDisenchanters(listName)) do
                table.insert(names, entry.Name)
            end
            return names
        end,
        Has = function(name, listName)
            return ImpLoot.LootCouncil:IsDisenchanter(name, listName)
        end,
        Add = function(name, listName)
            return ImpLoot.LootCouncil:AddDisenchanter(name, listName)
        end,
        Remove = function(name, listName)
            ImpLoot.LootCouncil:RemoveDisenchanter(name, listName)
        end,
        Numbered = true,
        Already = " is already a disenchanter.",
    },

}

function LootPriorityWindow:BuildPeopleColumn(frame, key, anchor, x)

    local spec = PEOPLE[key]
    local column = {}

    local header = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", x, -12)
    header:SetText(spec.Title)

    local addButton = ImpLoot.Theme:CreateMenuButton(frame)
    addButton:SetSize(56, 20)
    addButton:SetPoint("LEFT", header, "RIGHT", 10, 0)
    addButton:SetText("Add")
    column.AddButton = addButton

    local holder = CreateFrame("Frame", nil, frame)
    holder:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -8)
    holder:SetSize(PERSON_COLUMN_WIDTH, PERSON_ROW_HEIGHT)
    column.Holder = holder

    local empty = holder:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    empty:SetPoint("TOPLEFT", 2, -3)
    empty:SetText(spec.Empty)
    column.Empty = empty

    local more = holder:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    more:SetPoint("TOPLEFT", holder, "TOPLEFT", 2, -(PERSON_ROWS * PERSON_ROW_HEIGHT) - 2)
    more:Hide()
    column.More = more

    column.Rows = {}

    addButton:SetScript("OnClick", function()

        if not ImpLoot.LootCouncil:GetEditingListName() then
            ImpLoot:Print("Create or select a list first.")
            return
        end

        local picker = self.PersonPicker

        if picker:IsShown() and self.PickKey == key then
            picker:Hide()
            return
        end

        self.PickKey = key
        self.PickLabel:SetText(spec.PickLabel)

        picker:ClearAllPoints()
        -- Opens upwards: these buttons sit low in the window
        picker:SetPoint("BOTTOMLEFT", addButton, "TOPLEFT", 0, 4)
        picker:Show()

        self.PersonPickBox:SetText("")
        self.PersonPickBox:SetFocus()
        self:UpdatePersonPicker()

    end)

    self.PeopleColumns[key] = column

end

function LootPriorityWindow:BuildCouncilMembers(frame)

    self.PeopleColumns = {}

    -- Horizontal rule under Save Candidates / Clear
    local divider = frame:CreateTexture(nil, "ARTWORK")
    divider:SetTexture("Interface\\Buttons\\WHITE8X8")
    divider:SetVertexColor(1, 1, 1, 0.15)
    divider:SetHeight(1)
    divider:SetPoint("TOPLEFT", self.EditorBottom, "BOTTOMLEFT", 0, -14)
    divider:SetPoint("RIGHT", frame, "RIGHT", -16, 0)

    -- Vertical rule between the two lists
    local split = frame:CreateTexture(nil, "ARTWORK")
    split:SetTexture("Interface\\Buttons\\WHITE8X8")
    split:SetVertexColor(1, 1, 1, 0.15)
    split:SetWidth(1)
    split:SetPoint("TOPLEFT", divider, "BOTTOMLEFT", PERSON_COLUMN_WIDTH + 10, 0)
    split:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)

    self:BuildPeopleColumn(frame, "Members", divider, 0)
    self:BuildPeopleColumn(frame, "Disenchanters", divider, PERSON_COLUMN_WIDTH + 22)

    self:BuildPersonPicker(frame)

end

function LootPriorityWindow:RefreshPeopleColumn(key)

    local spec = PEOPLE[key]
    local column = self.PeopleColumns and self.PeopleColumns[key]

    if not column then
        return
    end

    for _, row in ipairs(column.Rows) do
        row:Hide()
    end

    local listName = ImpLoot.LootCouncil:GetEditingListName()
    local names = listName and spec.Get(listName) or {}

    if #names == 0 then
        column.Empty:Show()
        column.More:Hide()
        return
    end

    column.Empty:Hide()

    for i, name in ipairs(names) do

        if i > PERSON_ROWS then
            break
        end

        local row = column.Rows[i]

        if not row then

            row = CreateFrame("Frame", nil, column.Holder)
            row:SetSize(PERSON_COLUMN_WIDTH - 4, PERSON_ROW_HEIGHT)
            row:SetPoint("TOPLEFT", column.Holder, "TOPLEFT", 0, -((i - 1) * PERSON_ROW_HEIGHT))

            row.Background = row:CreateTexture(nil, "BACKGROUND")
            row.Background:SetAllPoints()
            row.Background:SetTexture("Interface\\Buttons\\WHITE8X8")

            -- Alternate darker / lighter, see-through
            if i % 2 == 1 then
                row.Background:SetVertexColor(0, 0, 0, 0.35)
            else
                row.Background:SetVertexColor(1, 1, 1, 0.06)
            end

            row.Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.Text:SetPoint("LEFT", 6, 0)

            row.RemoveButton = CreateFrame("Button", nil, row)
            row.RemoveButton:SetSize(14, 14)
            row.RemoveButton:SetPoint("LEFT", row.Text, "RIGHT", 6, 0)

            local removeText = row.RemoveButton:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
            removeText:SetAllPoints()
            removeText:SetText("x")

            column.Rows[i] = row

        end

        local r, g, b = ImpLoot.Theme:GetClassColor(ClassToken(name))
        local label = string.format("|cff%02x%02x%02x%s|r",
            math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5), name)

        if spec.Numbered then
            label = "|cffaaaaaa" .. i .. ".|r " .. label
        end

        row.Text:SetText(label)

        row.RemoveButton:SetScript("OnClick", function()
            spec.Remove(name, listName)
            self:RefreshPeopleColumn(key)
        end)

        row:Show()

    end

    if #names > PERSON_ROWS then
        column.More:SetText("+" .. (#names - PERSON_ROWS) .. " more")
        column.More:Show()
    else
        column.More:Hide()
    end

end

function LootPriorityWindow:RefreshCouncilMembers()
    self:RefreshPeopleColumn("Members")
    self:RefreshPeopleColumn("Disenchanters")
end

-- Group members not already on the list being added to,
-- whose names contain `filter`
function LootPriorityWindow:GetPickableRaiders(filter)

    filter = (filter or ""):lower()

    local spec = PEOPLE[self.PickKey or "Members"]
    local listName = ImpLoot.LootCouncil:GetEditingListName()

    local names = {}
    local numRaid = GetNumRaidMembers and GetNumRaidMembers() or 0

    if numRaid > 0 then

        for i = 1, numRaid do
            local name = GetRaidRosterInfo(i)
            if name then table.insert(names, name) end
        end

    else

        -- (parentheses: UnitName also returns a realm, which
        -- table.insert would take as a position)
        table.insert(names, (UnitName("player")))

        for i = 1, (GetNumPartyMembers and GetNumPartyMembers() or 0) do
            local name = UnitName("party" .. i)
            if name then table.insert(names, name) end
        end

    end

    local picks = {}

    for _, name in ipairs(names) do

        if not spec.Has(name, listName)
        and (filter == "" or name:lower():find(filter, 1, true)) then
            table.insert(picks, name)
        end

    end

    table.sort(picks)

    return picks

end

function LootPriorityWindow:AddPerson(name)

    name = (name or ""):gsub("^%s+", ""):gsub("%s+$", "")

    if name == "" then
        return
    end

    -- "brad" -> "Brad"
    name = name:sub(1, 1):upper() .. name:sub(2)

    local key = self.PickKey or "Members"
    local spec = PEOPLE[key]

    if not spec.Add(name, ImpLoot.LootCouncil:GetEditingListName()) then
        ImpLoot:Print(name .. spec.Already)
    end

    self.PersonPicker:Hide()
    self:RefreshPeopleColumn(key)

end

-- Enter: an exact group name, else the top match, else
-- exactly what was typed (someone not in the group)
function LootPriorityWindow:AddTypedPerson()

    local text = (self.PersonPickBox:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")

    if text == "" then
        return
    end

    local picks = self:GetPickableRaiders(text)

    for _, name in ipairs(picks) do
        if name:lower() == text:lower() then
            self:AddPerson(name)
            return
        end
    end

    if #picks > 0 then
        self:AddPerson(picks[1])
        return
    end

    self:AddPerson(text)

end

function LootPriorityWindow:UpdatePersonPicker()

    local text = (self.PersonPickBox:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")
    local picks = self:GetPickableRaiders(text)

    for i, row in ipairs(self.PersonPickRows) do

        local name = picks[i]

        if name then
            row.Name = name
            row.Text:SetText(name)
            row.Text:SetTextColor(ImpLoot.Theme:GetClassColor(ClassToken(name)))
            row:Show()
        else
            row.Name = nil
            row:Hide()
        end

    end

    local shown = math.min(#picks, PICK_ROWS)
    local extra = 0

    if #picks > PICK_ROWS then
        self.PersonPickMore:SetText("+" .. (#picks - PICK_ROWS) .. " more -- type to narrow it down")
        self.PersonPickMore:Show()
        extra = 14
    else
        self.PersonPickMore:Hide()
    end

    if #picks == 0 then

        if text ~= "" then
            self.PersonPickNote:SetText("Not in the group -- press Enter to add \"" .. text .. "\" anyway.")
        else
            self.PersonPickNote:SetText("Nobody in the group to pick -- type a name and press Enter.")
        end

        self.PersonPickNote:Show()
        extra = 28

    else

        self.PersonPickNote:Hide()

    end

    self.PersonPicker:SetHeight(56 + shown * PERSON_ROW_HEIGHT + extra + 8)

end

function LootPriorityWindow:BuildPersonPicker(frame)

    local picker = CreateFrame("Frame", nil, frame)
    picker:SetWidth(270)
    picker:SetFrameLevel(frame:GetFrameLevel() + 30)
    picker:EnableMouse(true)
    picker:SetClampedToScreen(true)
    picker:Hide()

    ImpLoot.Theme:ApplySolidPanelStyle(picker)

    self.PersonPicker = picker

    local label = picker:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("TOPLEFT", 10, -10)
    label:SetPoint("RIGHT", picker, "RIGHT", -10, 0)
    label:SetJustifyH("LEFT")
    self.PickLabel = label

    local box = CreateFrame("EditBox", "ImpLootLootCouncilPersonBox", picker, "InputBoxTemplate")
    box:SetSize(230, 20)
    box:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 6, -4)
    box:SetAutoFocus(false)
    self.PersonPickBox = box

    box:SetScript("OnTextChanged", function() self:UpdatePersonPicker() end)
    box:SetScript("OnEnterPressed", function() self:AddTypedPerson() end)
    box:SetScript("OnEscapePressed", function() picker:Hide() end)

    self.PersonPickRows = {}

    for i = 1, PICK_ROWS do

        local row = CreateFrame("Button", nil, picker)
        row:SetHeight(PERSON_ROW_HEIGHT)
        row:SetPoint("TOPLEFT", box, "BOTTOMLEFT", -6, -4 - (i - 1) * PERSON_ROW_HEIGHT)
        row:SetPoint("RIGHT", picker, "RIGHT", -8, 0)
        row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

        row.Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.Text:SetPoint("LEFT", 4, 0)

        row:SetScript("OnClick", function()
            if row.Name then
                self:AddPerson(row.Name)
            end
        end)

        row:Hide()

        self.PersonPickRows[i] = row

    end

    local more = picker:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    more:SetPoint("TOPLEFT", box, "BOTTOMLEFT", -2, -6 - PICK_ROWS * PERSON_ROW_HEIGHT)
    more:Hide()
    self.PersonPickMore = more

    local note = picker:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    note:SetPoint("TOPLEFT", box, "BOTTOMLEFT", -2, -6)
    note:SetWidth(246)
    note:SetJustifyH("LEFT")
    note:Hide()
    self.PersonPickNote = note

    picker:SetScript("OnHide", function() box:ClearFocus() end)

end

-------------------------------------------------
-- Refresh / Show / Hide / Toggle
-------------------------------------------------

function LootPriorityWindow:Refresh()

    local activeName = ImpLoot.LootCouncil:GetEditingListName()

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
    self:RefreshCouncilMembers()

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
