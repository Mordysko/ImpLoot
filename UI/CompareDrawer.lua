-------------------------------------------------
-- Compare Drawer
--
-- The sliding tab on the left edge of the main
-- window -- mirrors PlanningDrawer, which lives on
-- the right. Holds two item slots and shows the
-- stat difference between them.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.CompareDrawer = ImpLoot.UI.CompareDrawer or {}
local CompareDrawer = ImpLoot.UI.CompareDrawer

CompareDrawer.IsOpen = false

-------------------------------------------------
-- Create Slot
-------------------------------------------------

function CompareDrawer:CreateSlot(parent, index)

    local Layout = ImpLoot.UI.Layout
    local Theme = ImpLoot.Theme

    local row = CreateFrame("Button", nil, parent)

    row:SetWidth(Layout.GridButtonWidth)
    row:SetHeight(46)

    Theme:ApplyPanelStyle(row)

    row.Index = index

    -------------------------------------------------
    -- Item Icon
    -------------------------------------------------

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(32, 32)
    icon:SetPoint("LEFT", row, "LEFT", 3, 0)
    icon:Hide()

    row.Icon = icon

    -------------------------------------------------
    -- Lock Badge
    --
    -- A small badge in the corner of the icon, plus
    -- the whole slot's border goes gold while locked
    -- -- two separate cues so it isn't easy to miss.
    -------------------------------------------------

    local lockIcon = row:CreateTexture(nil, "OVERLAY")
    lockIcon:SetSize(16, 16)
    lockIcon:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 4, -4)
    lockIcon:SetTexture("Interface\\Buttons\\LockButton-Locked-Up")
    lockIcon:Hide()

    row.LockIcon = lockIcon

    -------------------------------------------------
    -- Item Name
    -------------------------------------------------

    local text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")

    text:SetPoint("TOPLEFT", icon, "TOPRIGHT", 6, -2)
    text:SetPoint("RIGHT", row, "RIGHT", -4, 0)
    text:SetHeight(32)
    text:SetJustifyH("LEFT")
    text:SetJustifyV("MIDDLE")

    row.Text = text

    -------------------------------------------------
    -- Interaction
    --
    -- Left click = toggle lock. Right click = remove
    -- (blocked while locked).
    -------------------------------------------------

    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    row:SetScript("OnClick", function(_, mouseButton)

        -------------------------------------------------
        -- Ctrl+Click = Dressing Room
        -------------------------------------------------

        if IsControlKeyDown() then

            local slot = ImpLoot.Compare:GetSlot(index)

            if slot and slot.ItemID then

                local cached = ImpLoot.ItemCache:GetItem(slot.ItemID)

                if cached and cached.Link and DressUpItemLink then
                    DressUpItemLink(cached.Link)
                end

            end

            return

        end

        if mouseButton == "RightButton" then

            local removed = ImpLoot.Compare:RemoveItem(index)

            if not removed then

                ImpLoot:Print(
                    "Slot " .. index ..
                    " is locked -- unlock it before removing."
                )

            end

            return

        end

        ImpLoot.Compare:ToggleLock(index)

    end)

    -------------------------------------------------
    -- Hover Tooltip
    -------------------------------------------------

    row:SetScript("OnEnter", function()

        local slot = ImpLoot.Compare:GetSlot(index)

        if not slot or not slot.ItemID then
            return
        end

        local cached = ImpLoot.ItemCache:GetItem(slot.ItemID)

        if not cached or not cached.Link then
            return
        end

        GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink(cached.Link)
        GameTooltip:Show()

    end)

    row:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    return row

end

-------------------------------------------------
-- Refresh Slot
-------------------------------------------------

function CompareDrawer:RefreshSlot(index)

    local row = self.Slots[index]

    if not row then
        return
    end

    local slot = ImpLoot.Compare:GetSlot(index)

    if not slot or not slot.ItemID then

        row.Icon:Hide()
        row.LockIcon:Hide()

        local instructions = "Alt-Click to add item"

        if index == 2 then
            instructions = "Alt-Right Click to add item"
        end

        row.Text:ClearAllPoints()
        row.Text:SetWidth(row:GetWidth() - 12)
        row.Text:SetPoint("CENTER", row, "CENTER", 0, 0)
        row.Text:SetJustifyH("CENTER")

        row.Text:SetText(instructions)
        row.Text:SetTextColor(0.6, 0.6, 0.6)

        row:SetBackdropBorderColor(
            ImpLoot.Theme.Colors.Border[1],
            ImpLoot.Theme.Colors.Border[2],
            ImpLoot.Theme.Colors.Border[3],
            ImpLoot.Theme.Colors.Border[4]
        )

        return

    end

    local cached = ImpLoot.ItemCache:GetItem(slot.ItemID)

    if cached and cached.Texture then
        row.Icon:SetTexture(cached.Texture)
        row.Icon:Show()
    else
        row.Icon:Hide()
    end

    local displayName = cached and cached.Name or ("Item " .. slot.ItemID)
    local quality = cached and cached.Quality

    local r, g, b = ImpLoot.Theme:GetQualityColor(quality)

    row.Text:ClearAllPoints()
    row.Text:SetJustifyH("LEFT")
    row.Text:SetText(displayName)
    row.Text:SetTextColor(r, g, b)

    -------------------------------------------------
    -- Centre The Icon + Name As A Block
    --
    -- Sized against the actual rendered text width so
    -- the pair sits centred in the slot rather than
    -- pinned to the left edge.
    -------------------------------------------------

    local rowWidth = row:GetWidth()
    local iconSize = 32
    local gap = 6
    local sidePadding = 4

    local textWidth = row.Text:GetStringWidth() or 0
    local maxTextWidth = rowWidth - iconSize - gap - (sidePadding * 2)

    if textWidth > maxTextWidth then
        textWidth = maxTextWidth
    end

    local totalWidth = iconSize + gap + textWidth
    local startX = (rowWidth - totalWidth) / 2

    if startX < sidePadding then
        startX = sidePadding
    end

    row.Icon:ClearAllPoints()
    row.Icon:SetPoint("LEFT", row, "LEFT", startX, 0)

    row.Text:SetPoint("LEFT", row.Icon, "RIGHT", gap, 0)
    row.Text:SetPoint("RIGHT", row, "RIGHT", -sidePadding, 0)

    if slot.Locked then

        row.LockIcon:Show()

        local red = { 1.00, 0.20, 0.20, 1.00 }

        row:SetBackdropBorderColor(red[1], red[2], red[3], red[4])

    else

        row.LockIcon:Hide()

        row:SetBackdropBorderColor(
            ImpLoot.Theme.Colors.Border[1],
            ImpLoot.Theme.Colors.Border[2],
            ImpLoot.Theme.Colors.Border[3],
            ImpLoot.Theme.Colors.Border[4]
        )

    end

end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function CompareDrawer:Initialize(parent)

    local Theme = ImpLoot.Theme

    -------------------------------------------------
    -- Frame
    -------------------------------------------------

    local frame = CreateFrame("Frame", nil, parent)
    self.Frame = frame

    frame:SetWidth(Theme.Metrics.DrawerWidth)
    frame:SetPoint("TOPRIGHT", parent, "TOPLEFT", 6, -88)
    frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", 6, 88)

    -- Renders BEHIND the main window (both are children
    -- of it, which would otherwise draw the drawer ON
    -- TOP by default) -- makes it look like the drawer
    -- slides out from behind the main window rather than
    -- sitting beside it with two visible edges.
    frame:SetFrameStrata("LOW")

    Theme:ApplyPanelStyle(frame)

    -------------------------------------------------
    -- Handle
    -------------------------------------------------

    local handle = Theme:CreateTabHandle(parent)
    handle:SetPoint("RIGHT", parent, "LEFT", 6, 0)
    self.Handle = handle

    handle:SetScript("OnClick", function()
        self:Toggle()
    end)

    -------------------------------------------------
    -- Content Container
    -------------------------------------------------

    local content = CreateFrame("Frame", nil, frame)

    content:SetPoint("TOPLEFT", 10, -10)
    content:SetPoint("TOPRIGHT", -10, -10)
    content:SetPoint("BOTTOMLEFT", 10, 10)
    content:SetPoint("BOTTOMRIGHT", -10, 10)

    self.Content = content

    -------------------------------------------------
    -- Title
    -------------------------------------------------

    local title = content:CreateFontString(nil, "OVERLAY")
    title:SetFontObject(Theme.Fonts.Header)
    title:SetPoint("TOP", 0, 0)
    title:SetText("Compare")

    self.Title = title

    -------------------------------------------------
    -- Slots
    --
    -- Both are fixed in place: Slot 1 sits under the
    -- title, Slot 2 is pinned to the bottom of the
    -- drawer. The diff lines fill (and are centred
    -- within) the gap between them.
    -------------------------------------------------

    self.Slots = {}

    self.Slots[1] = self:CreateSlot(content, 1)
    self.Slots[1]:SetPoint("TOP", title, "BOTTOM", 0, -14)

    self.Slots[2] = self:CreateSlot(content, 2)
    self.Slots[2]:SetPoint("BOTTOM", content, "BOTTOM", 0, 0)

    -------------------------------------------------
    -- Diff Area
    -------------------------------------------------

    local diffArea = CreateFrame("Frame", nil, content)

    diffArea:SetPoint("TOP", self.Slots[1], "BOTTOM", 0, 0)
    diffArea:SetPoint("BOTTOM", self.Slots[2], "TOP", 0, 0)
    diffArea:SetPoint("LEFT", content, "LEFT", 0, 0)
    diffArea:SetPoint("RIGHT", content, "RIGHT", 0, 0)

    self.DiffArea = diffArea
    self.DiffWidgets = {}

    -------------------------------------------------
    -- Compare Events
    -------------------------------------------------

    ImpLoot.Events:Register("CompareChanged", function()
        self:Refresh()
    end)

    -------------------------------------------------

    self:SetOpen(false)

end

-------------------------------------------------
-- Refresh
-------------------------------------------------

function CompareDrawer:Refresh()

    if not self.Frame then
        return
    end

    -------------------------------------------------
    -- Slots
    -------------------------------------------------

    self:RefreshSlot(1)
    self:RefreshSlot(2)

    -------------------------------------------------
    -- Clear Previous Diff Lines
    -------------------------------------------------

    for _, widget in ipairs(self.DiffWidgets) do

        widget:Hide()

        if widget.SetParent then
            widget:SetParent(UIParent)
        end

    end

    self.DiffWidgets = {}

    -------------------------------------------------
    -- Build The Display Blocks
    --
    -- Numeric stat diffs, plus -- if both items are
    -- trinkets -- each one's Equip/Use effect text.
    -------------------------------------------------

    local diffs = ImpLoot.Compare:GetDiff()

    local blocks = {}

    for _, diff in ipairs(diffs) do

        local sign = ""

        if diff.Delta > 0 then
            sign = "+"
        end

        local color = { 1.00, 0.20, 0.20 }

        if diff.Delta > 0 then
            color = { 0.10, 1.00, 0.10 }
        end

        table.insert(blocks, {
            text = sign .. diff.Delta .. " " .. diff.Label,
            color = color,
            wrap = false,
        })

    end

    local slot1 = ImpLoot.Compare:GetSlot(1)
    local slot2 = ImpLoot.Compare:GetSlot(2)

    if slot1 and slot1.ItemID and slot2 and slot2.ItemID then

        local item1 = ImpLoot.Database:FindItemByID(slot1.ItemID)
        local item2 = ImpLoot.Database:FindItemByID(slot2.ItemID)

        if item1 and item1.Slot == "Trinket"
        and item2 and item2.Slot == "Trinket" then

            local effect1 = ImpLoot.Compare:GetItemEffectText(slot1.ItemID)
            local effect2 = ImpLoot.Compare:GetItemEffectText(slot2.ItemID)

            if effect1 then

                table.insert(blocks, {
                    text = "Slot 1: " .. effect1,
                    color = { 0.75, 0.75, 0.75 },
                    wrap = true,
                })

            end

            if effect2 then

                table.insert(blocks, {
                    text = "Slot 2: " .. effect2,
                    color = { 0.75, 0.75, 0.75 },
                    wrap = true,
                })

            end

        end

    end

    -------------------------------------------------
    -- Render Them, Centred As One Block
    --
    -- Heights are measured per-widget (GetHeight, not
    -- GetStringHeight -- that one ignores word-wrap)
    -- so wrapped trinket text is accounted for
    -- correctly alongside the fixed-height stat lines.
    -------------------------------------------------

    if #blocks == 0 then

        local placeholder =
            self.DiffArea:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")

        placeholder:SetText("(add two items to compare)")

        local h = placeholder:GetHeight() or 14

        placeholder:SetPoint("TOP", self.DiffArea, "CENTER", 0, h / 2)

        table.insert(self.DiffWidgets, placeholder)

    else

        local spacing = 4
        local widgets = {}
        local totalHeight = 0

        for i, block in ipairs(blocks) do

            local fs =
                self.DiffArea:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")

            if block.wrap then
                fs:SetWidth(self.DiffArea:GetWidth() - 8)
                fs:SetJustifyH("LEFT")
            else
                fs:SetJustifyH("CENTER")
            end

            fs:SetText(block.text)
            fs:SetTextColor(block.color[1], block.color[2], block.color[3])

            local h = fs:GetHeight() or 14

            table.insert(widgets, { fs = fs, height = h })

            totalHeight = totalHeight + h

            if i > 1 then
                totalHeight = totalHeight + spacing
            end

        end

        local cursorY = totalHeight / 2

        for _, widget in ipairs(widgets) do

            widget.fs:ClearAllPoints()
            widget.fs:SetPoint("TOP", self.DiffArea, "CENTER", 0, cursorY)

            cursorY = cursorY - widget.height - spacing

            table.insert(self.DiffWidgets, widget.fs)

        end

    end

end

-------------------------------------------------
-- Refresh Item
--
-- Called by ItemCache once an item's data (and so
-- its stats) finish loading, in case it's sitting
-- in one of our slots.
-------------------------------------------------

function CompareDrawer:RefreshItem(itemID)

    if not self.Frame then
        return
    end

    local slot1 = ImpLoot.Compare:GetSlot(1)
    local slot2 = ImpLoot.Compare:GetSlot(2)

    if (slot1 and slot1.ItemID == itemID)
    or (slot2 and slot2.ItemID == itemID) then

        self:Refresh()

    end

end

-------------------------------------------------
-- Toggle
-------------------------------------------------

function CompareDrawer:Toggle()
    self:SetOpen(not self.IsOpen)
end

-------------------------------------------------
-- Set Open State
-------------------------------------------------

function CompareDrawer:SetOpen(open)

    self.IsOpen = open

    if open then
        ImpLoot.Theme:SetArrowDirection(self.Handle.Arrow, "RIGHT")
    else
        ImpLoot.Theme:SetArrowDirection(self.Handle.Arrow, "LEFT")
    end

    if open then

        self.Frame:Show()

        self.Handle:ClearAllPoints()
        self.Handle:SetPoint("RIGHT", self.Frame, "LEFT", 6, 0)

    else

        self.Handle:ClearAllPoints()
        self.Handle:SetPoint("RIGHT", ImpLoot.UI.MainWindow.Frame, "LEFT", 2, 0)

        self.Frame:Hide()

    end

    if ImpLoot.UI.LootPanel
    and ImpLoot.UI.LootPanel.UpdateCompareDimming then

        ImpLoot.UI.LootPanel:UpdateCompareDimming()

    end

end
