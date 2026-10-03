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
local ITEM_ROW_HEIGHT = 16

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
    -- Soft Reserve View's Own Back Button
    --
    -- "Who won what" is the default view now, so it's
    -- the SR card view that needs a way back to it --
    -- not the other way around.
    -------------------------------------------------

    local reservesBackButton = ImpLoot.Theme:CreateMenuButton(frame)
    reservesBackButton:SetSize(70, 20)
    reservesBackButton:SetPoint("BOTTOMLEFT", 2, 8)
    reservesBackButton:SetText("Back")
    reservesBackButton:Hide()

    reservesBackButton:SetScript("OnClick", function()
        self:HideReserves()
    end)

    self.ReservesBackButton = reservesBackButton

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
    self.ReservesBackButton:Hide()

    self:RenderResultsTable()

end

-------------------------------------------------
-- Show / Hide / Toggle
-------------------------------------------------

function SummaryWindow:Show()

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
    self.ReservesBackButton:Hide()

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

    local groupsByPlayer = {}
    local order = {}

    local allReserves = ImpLoot.SoftReserve.State and ImpLoot.SoftReserve.State.Reserves or {}

    for itemID, reserveList in pairs(allReserves) do

        for _, reserve in ipairs(reserveList) do

            local group = groupsByPlayer[reserve.Player]

            if not group then

                group = {
                    Player = reserve.Player,
                    Class = reserve.Class,
                    Spec = reserve.Spec,
                    Items = {},
                }

                groupsByPlayer[reserve.Player] = group
                table.insert(order, group)

            end

            table.insert(group.Items, itemID)

        end

    end

    table.sort(order, function(a, b)
        return a.Player < b.Player
    end)

    return order

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
        card:Show()

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
-- Show / Hide Reserves
--
-- "Who won what" (the results table) is the default
-- view now -- Soft Reserve is the way out to the SR
-- card view, with its own Back button to return.
-------------------------------------------------

function SummaryWindow:ShowReserves()

    self.ResultsScroll:Hide()
    self.PostButton:Hide()
    self.ClearButton:Hide()
    self.ExportButton:Hide()

    self:Refresh()
    self.ScrollFrame:Show()
    self.ReservesBackButton:Show()

    self.Title:SetText("Soft reserves")

end

function SummaryWindow:HideReserves()

    self.ScrollFrame:Hide()
    self.ReservesBackButton:Hide()

    self.ResultsScroll:Show()
    self.PostButton:Show()
    self.ClearButton:Show()
    self.ExportButton:Show()

    self.Title:SetText("Who won what")

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

    if ImpLoot.UI.SummaryWindow and ImpLoot.UI.SummaryWindow.Frame
    and ImpLoot.UI.SummaryWindow.Frame:IsShown() then

        ImpLoot.UI.SummaryWindow:Refresh()

    end

end)
