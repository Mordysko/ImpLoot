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

local WINDOW_WIDTH = 400
local WINDOW_HEIGHT = 420
local CARD_PADDING = 6
local CARD_GAP = 6

-- Gap between the window edge and the reserve cards, both sides
local SR_SIDE_MARGIN = 10
local ITEM_ROW_HEIGHT = 16

-------------------------------------------------
-- Editing Prompts
--
-- Reserve edits live in a draft until Save. WoW only writes
-- SavedVariables on logout or /reload, so Save is followed
-- by ONE reload prompt for the whole batch (not one per
-- player edited). Closing with unsaved edits asks first,
-- since they'd otherwise be lost.
-------------------------------------------------

StaticPopupDialogs["IMPLOOT_RELOAD_AFTER_SR_EDIT"] = {

    text = "Saved %d soft reserve(s).\n\nWoW only writes this to disk on your next logout or " ..
        "reload -- a crash before then would lose these edits. Reload now to save them immediately?",
    button1 = "Reload Now",
    button2 = "Later",

    OnAccept = function()
        ReloadUI()
    end,

    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,

}

StaticPopupDialogs["IMPLOOT_DISCARD_SR_EDITS"] = {

    text = "You have unsaved soft reserve changes.\n\nIf you close this window they will be LOST. Close anyway?",
    button1 = "Discard Changes",
    button2 = "Keep Editing",

    OnAccept = function()
        ImpLoot.UI.SummaryWindow:DiscardEdits()
        ImpLoot.UI.SummaryWindow.Frame:Hide()
    end,

    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,

}

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
    title:SetText("Soft reserves")
    self.Title = title

    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", 2, 0)
    closeButton:SetScript("OnClick", function() self:RequestClose() end)

    -------------------------------------------------
    -- Soft Reserve Editing Buttons
    --
    -- "Edit Soft Reserves" sits by the close button; once
    -- clicked, "Add Soft Reserve" and "Save" appear on the
    -- row below (the one Post to raid / Clear use on the
    -- other view) and each player's card gets an Edit button.
    -- All shown/hidden by UpdateEditChrome.
    -------------------------------------------------

    local editModeButton = ImpLoot.Theme:CreateMenuButton(titleBar)
    editModeButton:SetSize(120, 18)
    editModeButton:SetPoint("RIGHT", closeButton, "LEFT", -2, 0)
    editModeButton:SetText("Edit Soft Reserves")
    editModeButton:Hide()
    editModeButton:SetScript("OnClick", function() self:EnterEditMode() end)
    self.EditModeButton = editModeButton

    local addButton = ImpLoot.Theme:CreateMenuButton(frame)
    addButton:SetSize(120, 20)
    addButton:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 2, -6)
    addButton:SetText("Add Soft Reserve")
    addButton:Hide()
    addButton:SetScript("OnClick", function() self:OpenEditor(nil) end)
    self.AddButton = addButton

    -- Import CSV + SR counter share this row when not editing.
    ImpLoot.UI.ImportDialog:Attach(frame, titleBar)

    local saveButton = ImpLoot.Theme:CreateMenuButton(frame)
    saveButton:SetSize(70, 20)
    saveButton:SetPoint("TOPRIGHT", titleBar, "BOTTOMRIGHT", -2, -6)
    saveButton:SetText("Save")
    saveButton:Hide()
    saveButton:SetScript("OnClick", function() self:SaveEdits() end)
    self.SaveButton = saveButton

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
        self:RenderResultsTable()
    end)

    local exportButton = ImpLoot.Theme:CreateMenuButton(frame)
    exportButton:SetSize(80, 20)
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

    -- Equal margins left and right so the reserve cards sit centred
    -- in the window. (This view shows scroll arrows, not a scrollbar,
    -- so nothing needs reserving down the right-hand side.)
    scrollFrame:SetPoint("TOPLEFT", postButton, "BOTTOMLEFT", SR_SIDE_MARGIN - 6, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -SR_SIDE_MARGIN, 10)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetWidth(WINDOW_WIDTH - (SR_SIDE_MARGIN * 2))
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

    self.CardWidgets = {}

    -------------------------------------------------
    -- Results Table ("Who Won What")
    --
    -- A visual, read-only table (pooled row widgets,
    -- same pattern as the SR cards above) -- not an
    -- EditBox. It populates itself automatically the
    -- moment it's shown, same as the SR view does.
    -------------------------------------------------

    local resultsScroll = CreateFrame(
        "ScrollFrame",
        "ImpLootSummaryResultsScrollFrame",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    self.ResultsScroll = resultsScroll

    resultsScroll:SetPoint("TOPLEFT", postButton, "BOTTOMLEFT", -2, -8)
    resultsScroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -26, 34)
    resultsScroll:Hide()

    local resultsChild = CreateFrame("Frame", nil, resultsScroll)
    resultsChild:SetWidth(WINDOW_WIDTH - 36)
    resultsChild:SetHeight(1)

    self.ResultsChild = resultsChild

    resultsScroll:SetScrollChild(resultsChild)

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(resultsScroll)

    resultsScroll:EnableMouseWheel(true)

    resultsScroll:SetScript("OnMouseWheel", function(sf, delta)

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

    self.ResultRowWidgets = {}
    self.ResultHeadingWidgets = {}

    -------------------------------------------------
    -- Export Box (Overlay)
    --
    -- A multi-line, auto-selected EditBox -- WoW has no
    -- clipboard API, so this is the standard way to let
    -- the user copy text out themselves (Ctrl+C). Only
    -- holds the exported text, shown on demand via Export
    -- above rather than being the main results view
    -- itself.
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

    -------------------------------------------------
    -- "Who Won What" Is The Default View
    --
    -- The SR card view (self.ScrollFrame) starts
    -- hidden -- Soft Reserve is what navigates to it.
    -------------------------------------------------

    self.ScrollFrame:Hide()

    self.Editing = false
    self.Draft = nil
    self.Dirty = false
    self.FormOpen = false
    self.InReserves = false

    ImpLoot.UI.SoftReserveEditor:Initialize(self, frame)

    -- Whatever hides the window, edits don't linger into the
    -- next time it opens (closing normally asks first -- see
    -- RequestClose -- this is the backstop).
    frame:HookScript("OnHide", function()

        if self.Editing or self.FormOpen then
            self:DiscardEdits()
        end

    end)

    self:RenderResultsTable()

end

-------------------------------------------------
-- Show / Hide / Toggle
-------------------------------------------------

function SummaryWindow:Show()

    self.InReserves = false
    self:DiscardEdits()

    -------------------------------------------------
    -- Always Reset To The Default Pane
    --
    -- Widget visibility persists across Hide()/Show()
    -- of the frame itself -- Hide()ing the window
    -- doesn't reset which of the three panes (results /
    -- SR cards / export text) was last visible within
    -- it. Without forcing it back here, reopening via
    -- the Loot Master window's "Summary" button after
    -- having last left it on the SR card view (or the
    -- export text) would keep showing that instead of
    -- "Who won what" -- exactly the "stuck until
    -- /reload" symptom this fixes.
    -------------------------------------------------

    self.ScrollFrame:Hide()

    self.ExportScroll:Hide()
    self.ExportBackButton:Hide()

    self.ResultsScroll:Show()
    self.PostButton:Show()
    self.ClearButton:Show()
    self.ExportButton:Show()

    self.Title:SetText("Who won what")

    self:RenderResultsTable()

    self.Frame:Show()

end

function SummaryWindow:Hide()
    self:RequestClose()
end

function SummaryWindow:Toggle()

    if self.Frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end

end

-------------------------------------------------
-- Toggle Reserves
--
-- The Loot Master window's own "Soft Reserve" button --
-- opens straight to the SR card view rather than the
-- default "Who won what", closing the whole window if
-- it's already open (matching Toggle's own show/hide
-- behaviour, not just switching panes on an already-
-- open window).
-------------------------------------------------

function SummaryWindow:ToggleReserves()

    if self.Frame:IsShown() then
        self:Hide()
        return
    end

    self:DiscardEdits()
    self.Frame:Show()
    self:ShowReserves()

end

-------------------------------------------------
-- Format Line
--
-- Still used by PostToRaid and the Export pane's text
-- box -- both are about the resolution log (who won
-- what), not the reserve display below.
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
-- Build Player Groups
--
-- Inverts the SR data (stored keyed by item) into
-- groups keyed by player, each with the class/spec
-- from their own reserve rows and the full list of
-- items they've reserved -- across every item in
-- ImpLoot.SoftReserve.State.Reserves, not just one.
-- Sorted alphabetically by player name.
-------------------------------------------------

function SummaryWindow:BuildPlayerGroups()

    -- While editing, the cards show the draft (so changes are
    -- visible straight away); otherwise the real reserves.
    local draft = self.Draft or ImpLoot.SoftReserve:BuildDraft()

    local groups = {}

    for _, player in ipairs(draft) do

        local itemIDs = {}

        for _, item in ipairs(player.Items) do
            table.insert(itemIDs, item.ItemID)
        end

        table.insert(groups, {
            Player = player.Player,
            Class = player.Class,
            Spec = player.Spec,
            Items = itemIDs,
            Draft = player,
        })

    end

    return groups

end

-------------------------------------------------
-- Acquire Card
--
-- A pooled background panel per player, with its own
-- name/spec text -- item rows are pooled separately per
-- card (see AcquireCardItemRow) since each player has a
-- different number of them.
-------------------------------------------------

function SummaryWindow:AcquireCard(index)

    local card = self.CardWidgets[index]

    if card then
        return card
    end

    card = CreateFrame("Frame", nil, self.ScrollChild)
    card:SetWidth(self.ScrollChild:GetWidth())

    ImpLoot.Theme:ApplyPanelStyle(card)

    local nameText = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("TOPLEFT", card, "TOPLEFT", CARD_PADDING, -CARD_PADDING)
    nameText:SetJustifyH("LEFT")
    nameText:SetTextColor(
        ImpLoot.Theme.Colors.Text[1],
        ImpLoot.Theme.Colors.Text[2],
        ImpLoot.Theme.Colors.Text[3]
    )

    card.NameText = nameText

    local specText = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    specText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -2)
    specText:SetJustifyH("LEFT")

    card.SpecText = specText

    -- Only shown while editing (see Refresh)
    local editButton = ImpLoot.Theme:CreateMenuButton(card)
    editButton:SetSize(40, 16)
    editButton:SetPoint("TOPRIGHT", card, "TOPRIGHT", -6, -5)
    editButton:SetText("Edit")
    editButton:Hide()

    editButton:SetScript("OnClick", function()

        if card.DraftPlayer then
            self:OpenEditor(card.DraftPlayer)
        end

    end)

    card.EditButton = editButton

    card.ItemRows = {}

    self.CardWidgets[index] = card

    return card

end

-------------------------------------------------
-- Acquire Card Item Row
-------------------------------------------------

function SummaryWindow:AcquireCardItemRow(card, index)

    local row = card.ItemRows[index]

    if row then
        return row
    end

    row = CreateFrame("Frame", nil, card)
    row:SetWidth(card:GetWidth() - (CARD_PADDING * 2))
    row:SetHeight(ITEM_ROW_HEIGHT)

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(14, 14)
    icon:SetPoint("LEFT", row, "LEFT", 0, 0)

    row.Icon = icon

    local text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    text:SetPoint("LEFT", icon, "RIGHT", 4, 0)
    text:SetJustifyH("LEFT")

    row.Text = text

    card.ItemRows[index] = row

    return row

end

-------------------------------------------------
-- Refresh
--
-- Renders the current soft reserve import as one card
-- per player -- name, class-colored spec, and their
-- reserved items with icons -- a visual read of the
-- import itself, not a text log. "Who won what" lives
-- behind the Export button instead (see ShowExport).
-------------------------------------------------

function SummaryWindow:Refresh()

    if not self.ScrollChild then
        return
    end

    self.CardWidgets = self.CardWidgets or {}

    for _, card in ipairs(self.CardWidgets) do

        card:Hide()

        for _, row in ipairs(card.ItemRows) do
            row:Hide()
        end

    end

    local groups = self:BuildPlayerGroups()

    if #groups == 0 then

        local card = self:AcquireCard(1)
        card.NameText:SetText("No SRs loaded.")
        card.NameText:SetTextColor(0.6, 0.6, 0.6)
        card.SpecText:SetText("")
        card:ClearAllPoints()
        card:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 0, 0)
        card:SetHeight(CARD_PADDING * 2 + 16)
        card.DraftPlayer = nil
        card.EditButton:Hide()
        card:Show()

        self.ScrollChild:SetHeight(card:GetHeight())

        if self.ScrollFrame.UpdateScrollIndicators then
            self.ScrollFrame:UpdateScrollIndicators()
        end

        return

    end

    local y = 0

    for i, group in ipairs(groups) do

        local card = self:AcquireCard(i)

        card.NameText:SetText(group.Player)
        card.NameText:SetTextColor(
            ImpLoot.Theme.Colors.Text[1],
            ImpLoot.Theme.Colors.Text[2],
            ImpLoot.Theme.Colors.Text[3]
        )

        local cr, cg, cb = ImpLoot.Theme:GetClassColor(group.Class)
        card.SpecText:SetText(group.Spec or "")
        card.SpecText:SetTextColor(cr, cg, cb)

        local itemY = -(CARD_PADDING + 16 + 14 + 2)

        for itemIndex, itemID in ipairs(group.Items) do

            local row = self:AcquireCardItemRow(card, itemIndex)
            local cached = ImpLoot.ItemCache:GetItem(itemID)

            local itemName = (cached and cached.Name) or ("Item " .. itemID)
            local quality = cached and cached.Quality

            if cached and cached.Texture then
                row.Icon:SetTexture(cached.Texture)
                row.Icon:Show()
            else
                row.Icon:Hide()
            end

            local qr, qg, qb = ImpLoot.Theme:GetQualityColor(quality)
            row.Text:SetText(itemName)
            row.Text:SetTextColor(qr, qg, qb)

            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", card, "TOPLEFT", CARD_PADDING, itemY)
            row:Show()

            itemY = itemY - ITEM_ROW_HEIGHT

        end

        local cardHeight = CARD_PADDING + 16 + 14 + 2
            + (#group.Items * ITEM_ROW_HEIGHT) + CARD_PADDING

        card:ClearAllPoints()
        card:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 0, -y)
        card:SetHeight(cardHeight)
        card.DraftPlayer = group.Draft
        card:Show()

        if self.Editing then
            card.EditButton:Show()
        else
            card.EditButton:Hide()
        end

        y = y + cardHeight + CARD_GAP

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
-- Build Boss Groups
--
-- Shared by the results table and GetExportText below
-- -- the resolution log grouped by boss, in that raid's
-- own real encounter order.
-------------------------------------------------

function SummaryWindow:BuildBossGroups()

    local log = ImpLoot.LootMaster:GetLog()

    local bucketsByBoss = {}
    local order = {}

    -------------------------------------------------
    -- Group By Boss, In Boss Order
    --
    -- Same source of truth as the Raid Planner: each
    -- item's own Boss.Index (set once, centrally, from
    -- that boss's position in its raid's own Bosses
    -- list) rather than the order items happened to
    -- resolve in. Trash, Extra Drops, or anything the
    -- database can't tie to a specific boss groups under
    -- whatever name was recorded at the time, pinned
    -- after every real boss.
    -------------------------------------------------

    for _, entry in ipairs(log) do

        local item = ImpLoot.Database:FindItemByID(entry.ItemID)

        local bossName = (item and item.Boss and item.Boss.Name)
            or entry.BossName
            or "Unknown"

        local bossIndex = (item and item.Boss and item.Boss.Index) or 999999

        local bucket = bucketsByBoss[bossName]

        if not bucket then

            bucket = { BossName = bossName, BossIndex = bossIndex, Entries = {} }
            bucketsByBoss[bossName] = bucket
            table.insert(order, bucket)

        end

        table.insert(bucket.Entries, entry)

    end

    table.sort(order, function(a, b)
        return a.BossIndex < b.BossIndex
    end)

    return order

end

-------------------------------------------------
-- Get Export Text
--
-- One line per item: Item,Winner,Roll -- no boss
-- headings, no quoting, just the three raw values a
-- spreadsheet column paste expects. Roll is whatever
-- GetResultLabel recorded at the moment the item was
-- assigned (SR/LC/MS/OS), blank if none applies.
-------------------------------------------------

function SummaryWindow:GetExportText()

    local groups = self:BuildBossGroups()
    local lines = {}

    for _, bucket in ipairs(groups) do

        for _, entry in ipairs(bucket.Entries) do

            local cached = ImpLoot.ItemCache:GetItem(entry.ItemID)
            local itemName = (cached and cached.Name) or ("Item " .. entry.ItemID)

            table.insert(lines, itemName .. "," .. entry.Winner .. "," .. (entry.ResultLabel or ""))

        end

    end

    return table.concat(lines, "\n")

end

-------------------------------------------------
-- Acquire Result Row / Heading
-------------------------------------------------

local ITEM_COLUMN_WIDTH = 210
local WINNER_COLUMN_WIDTH = 90
local ROLL_COLUMN_WIDTH = 50

function SummaryWindow:AcquireResultHeading(index)

    local heading = self.ResultHeadingWidgets[index]

    if heading then
        return heading
    end

    heading = self.ResultsChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    heading:SetJustifyH("LEFT")
    heading:SetTextColor(
        ImpLoot.Theme.Colors.Text[1],
        ImpLoot.Theme.Colors.Text[2],
        ImpLoot.Theme.Colors.Text[3]
    )

    self.ResultHeadingWidgets[index] = heading

    return heading

end

function SummaryWindow:AcquireResultRow(index)

    local row = self.ResultRowWidgets[index]

    if row then
        return row
    end

    row = CreateFrame("Frame", nil, self.ResultsChild)
    row:SetWidth(self.ResultsChild:GetWidth())
    row:SetHeight(ITEM_ROW_HEIGHT)

    local itemText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    itemText:SetPoint("LEFT", row, "LEFT", 0, 0)
    itemText:SetWidth(ITEM_COLUMN_WIDTH)
    itemText:SetJustifyH("LEFT")

    row.ItemText = itemText

    local winnerText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    winnerText:SetPoint("LEFT", itemText, "RIGHT", 2, 0)
    winnerText:SetWidth(WINNER_COLUMN_WIDTH)
    winnerText:SetJustifyH("LEFT")

    row.WinnerText = winnerText

    local rollText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    rollText:SetPoint("LEFT", winnerText, "RIGHT", 2, 0)
    rollText:SetWidth(ROLL_COLUMN_WIDTH)
    rollText:SetJustifyH("LEFT")

    row.RollText = rollText

    self.ResultRowWidgets[index] = row

    return row

end

-------------------------------------------------
-- Render Results Table
--
-- "Who won what" as a plain, read-only, three-column
-- table (Item / Winner / Roll) -- auto-populated the
-- moment it's shown, same as the SR view, rather than
-- an EditBox the user had to think of as text to edit.
-- Grouped by boss, same order as GetExportText.
-------------------------------------------------

function SummaryWindow:RenderResultsTable()

    if not self.ResultsChild then
        return
    end

    for _, heading in ipairs(self.ResultHeadingWidgets) do
        heading:Hide()
    end

    for _, row in ipairs(self.ResultRowWidgets) do
        row:Hide()
    end

    local groups = self:BuildBossGroups()

    local y = 0

    local headerRow = self:AcquireResultRow(1)
    headerRow.ItemText:SetText("Item")
    headerRow.ItemText:SetTextColor(1, 0.82, 0)
    headerRow.WinnerText:SetText("Winner")
    headerRow.WinnerText:SetTextColor(1, 0.82, 0)
    headerRow.RollText:SetText("Roll")
    headerRow.RollText:SetTextColor(1, 0.82, 0)
    headerRow:ClearAllPoints()
    headerRow:SetPoint("TOPLEFT", self.ResultsChild, "TOPLEFT", 0, -y)
    headerRow:Show()

    y = y + ITEM_ROW_HEIGHT + 4

    if #groups == 0 then

        local heading = self:AcquireResultHeading(1)
        heading:SetText("Nothing resolved yet.")
        heading:SetTextColor(0.6, 0.6, 0.6)
        heading:ClearAllPoints()
        heading:SetPoint("TOPLEFT", self.ResultsChild, "TOPLEFT", 0, -y)
        heading:Show()

        y = y + ITEM_ROW_HEIGHT

        self.ResultsChild:SetHeight(y)

        if self.ResultsScroll.UpdateScrollIndicators then
            self.ResultsScroll:UpdateScrollIndicators()
        end

        return

    end

    local rowIndex = 1
    local headingIndex = 0

    for _, bucket in ipairs(groups) do

        headingIndex = headingIndex + 1

        local heading = self:AcquireResultHeading(headingIndex)
        heading:SetText(bucket.BossName)
        heading:SetTextColor(
            ImpLoot.Theme.Colors.Text[1],
            ImpLoot.Theme.Colors.Text[2],
            ImpLoot.Theme.Colors.Text[3]
        )
        heading:ClearAllPoints()
        heading:SetPoint("TOPLEFT", self.ResultsChild, "TOPLEFT", 0, -y)
        heading:Show()

        y = y + ITEM_ROW_HEIGHT + 2

        for _, entry in ipairs(bucket.Entries) do

            rowIndex = rowIndex + 1

            local row = self:AcquireResultRow(rowIndex)

            local cached = ImpLoot.ItemCache:GetItem(entry.ItemID)
            local itemName = (cached and cached.Name) or ("Item " .. entry.ItemID)
            local quality = cached and cached.Quality

            local qr, qg, qb = ImpLoot.Theme:GetQualityColor(quality)
            row.ItemText:SetText(itemName)
            row.ItemText:SetTextColor(qr, qg, qb)

            row.WinnerText:SetText(entry.Winner)
            row.WinnerText:SetTextColor(1, 1, 1)

            row.RollText:SetText(entry.ResultLabel or "")
            row.RollText:SetTextColor(0.8, 0.8, 0.8)

            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", self.ResultsChild, "TOPLEFT", 4, -y)
            row:Show()

            -------------------------------------------------
            -- Measure The Row's Actual Height
            --
            -- A long item name can wrap to two lines
            -- within its column -- GetStringHeight
            -- reflects that wrapping, where a fixed
            -- ITEM_ROW_HEIGHT wouldn't. Taking the larger
            -- of the two is what stops a wrapped name
            -- from overlapping the row placed right under
            -- it.
            -------------------------------------------------

            local measuredHeight = row.ItemText:GetStringHeight() or ITEM_ROW_HEIGHT

            y = y + math.max(ITEM_ROW_HEIGHT, measuredHeight)

        end

        y = y + CARD_GAP

    end

    self.ResultsChild:SetHeight(math.max(y, 1))

    if self.ResultsScroll.UpdateScrollChildRect then
        self.ResultsScroll:UpdateScrollChildRect()
    end

    if self.ResultsScroll.UpdateScrollIndicators then
        self.ResultsScroll:UpdateScrollIndicators()
    end

end

-------------------------------------------------
-- Show Reserves
--
-- "Who won what" (the results table) is the default
-- view -- the SR card view is only ever reached via
-- the Loot Master window's own "Soft Reserve" button
-- (ToggleReserves below), and dismissed the same way
-- (closing the whole window), so it has no Back button
-- or other in-window way out of its own.
-------------------------------------------------

function SummaryWindow:ShowReserves()

    self.ResultsScroll:Hide()
    self.PostButton:Hide()
    self.ClearButton:Hide()
    self.ExportButton:Hide()

    self.InReserves = true

    self:Refresh()
    self.ScrollFrame:Show()
    self:UpdateEditChrome()

    self.Title:SetText("Soft reserves")

end

-------------------------------------------------
-- Show / Hide Export
--
-- A second pane reached from the default "Who won
-- what" view (Export) -- the one place the actual
-- copyable text lives, since the results table itself
-- is a plain visual, non-editable table.
-------------------------------------------------

function SummaryWindow:ShowExport()

    self.ExportBox:SetText(self:GetExportText())
    self.ExportBox:SetFocus()
    self.ExportBox:HighlightText()

    self.ResultsScroll:Hide()
    self.PostButton:Hide()
    self.ClearButton:Hide()
    self.ExportButton:Hide()

    self.ExportScroll:Show()
    self.ExportBackButton:Show()

    self.Title:SetText("Exported Text")

    if self.ExportScroll.UpdateScrollIndicators then
        self.ExportScroll:UpdateScrollIndicators()
    end

end

function SummaryWindow:HideExport()

    self.ExportBox:ClearFocus()

    self.ExportScroll:Hide()
    self.ExportBackButton:Hide()

    self.ResultsScroll:Show()
    self.PostButton:Show()
    self.ClearButton:Show()
    self.ExportButton:Show()

    self.Title:SetText("Who won what")

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

    local window = ImpLoot.UI.SummaryWindow

    if window and window.Frame and window.Frame:IsShown() then

        -- "Who won what" is the default view and the one a new
        -- resolution shows up in...
        window:RenderResultsTable()

        -- ...and the reserve cards only need redrawing if they're
        -- what's on screen.
        if window.InReserves then
            window:Refresh()
        end

    end

end)

-------------------------------------------------
-- Soft Reserve Editing
--
-- Edit Soft Reserves starts a DRAFT (a copy of the reserves
-- grouped by player). Add / per-player Edit open the form
-- (UI/SoftReserveEditor.lua), which changes only the draft.
-- Nothing touches the real reserve list until Save, so the
-- loot master gets a single reload prompt at the end rather
-- than one per player. Closing with unsaved edits asks first.
-------------------------------------------------

-- Which of the editing buttons show: only on the reserve page,
-- and not while the form is open. "Edit Soft Reserves" stays
-- visible but greyed out once editing has started.
function SummaryWindow:UpdateEditChrome()

    if not self.EditModeButton then
        return
    end

    if self.InReserves and not self.FormOpen then

        self.EditModeButton:Show()

        if self.Editing then

            self.EditModeButton:Disable()
            self.EditModeButton:SetAlpha(0.5)

            self.AddButton:Show()
            self.SaveButton:Show()
            ImpLoot.UI.ImportDialog:SetChromeShown(false)

        else

            self.EditModeButton:Enable()
            self.EditModeButton:SetAlpha(1)

            self.AddButton:Hide()
            self.SaveButton:Hide()
            ImpLoot.UI.ImportDialog:SetChromeShown(true)

        end

    else

        self.EditModeButton:Hide()
        self.AddButton:Hide()
        self.SaveButton:Hide()
        ImpLoot.UI.ImportDialog:SetChromeShown(false)

    end

end

function SummaryWindow:EnterEditMode()

    if self.Editing then
        return
    end

    self.Editing = true
    self.Dirty = false
    self.Draft = ImpLoot.SoftReserve:BuildDraft()

    self:UpdateEditChrome()
    self:Refresh()

end

function SummaryWindow:MarkDirty()
    self.Dirty = true
end

-- Opens the form for one draft player, or for a new one (nil)
function SummaryWindow:OpenEditor(draftPlayer)

    if not self.Editing then
        return
    end

    self.FormOpen = true
    self.ScrollFrame:Hide()
    self:UpdateEditChrome()

    ImpLoot.UI.SoftReserveEditor:Open(draftPlayer)

end

-- Called by the form when Done / Cancel returns here
function SummaryWindow:OnEditorClosed()

    self.FormOpen = false

    self.Title:SetText("Soft reserves")
    self.ScrollFrame:Show()

    self:UpdateEditChrome()
    self:Refresh()

end

-- Throw the draft away and leave edit mode, no questions asked
-- (callers that need to ask do so first -- see RequestClose).
function SummaryWindow:DiscardEdits()

    if ImpLoot.UI.SoftReserveEditor and ImpLoot.UI.SoftReserveEditor.Abort then
        ImpLoot.UI.SoftReserveEditor:Abort()
    end

    local wasEditing = self.Editing or self.FormOpen

    self.Editing = false
    self.Draft = nil
    self.Dirty = false
    self.FormOpen = false

    if wasEditing and self.InReserves and self.Frame and self.Frame:IsShown() then
        self.Title:SetText("Soft reserves")
        self.ScrollFrame:Show()
        self:Refresh()
    end

    self:UpdateEditChrome()

end

-- Apply the draft to the real reserves, once, then offer the
-- single reload that makes WoW write it to disk.
function SummaryWindow:SaveEdits()

    if not self.Editing then
        return
    end

    local changed = self.Dirty
    local count = 0

    if changed then
        count = ImpLoot.SoftReserve:CommitDraft(self.Draft)
    end

    self.Editing = false
    self.Draft = nil
    self.Dirty = false

    self:UpdateEditChrome()
    self:Refresh()

    if changed then

        local importDialog = ImpLoot.UI.ImportDialog

        if importDialog and importDialog.UpdateCounter then
            importDialog:UpdateCounter()
        end

        StaticPopup_Show("IMPLOOT_RELOAD_AFTER_SR_EDIT", count)

    end

end

-- Every route that closes the window comes through here: with
-- unsaved edits (including a half-filled form) it asks first.
function SummaryWindow:RequestClose()

    local unsaved = self.Dirty
        or (self.FormOpen and ImpLoot.UI.SoftReserveEditor:HasChanges())

    if self.Editing and unsaved then
        StaticPopup_Show("IMPLOOT_DISCARD_SR_EDITS")
        return
    end

    self:DiscardEdits()
    self.Frame:Hide()

end
