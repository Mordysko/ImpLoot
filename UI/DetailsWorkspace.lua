-------------------------------------------------
-- Details Workspace
--
-- The panel below the loot list divider. Shows either
-- item details or the character's wishlist, depending on
-- ImpLoot.Workspace:Get() -- switched via the planning
-- drawer.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.DetailsWorkspace = ImpLoot.UI.DetailsWorkspace or {}
local DetailsWorkspace = ImpLoot.UI.DetailsWorkspace

-------------------------------------------------
-- Wishlist Grouping Constants
-------------------------------------------------

local WISHLIST_HEADER_HEIGHT = 16
local WISHLIST_HEADER_ITEM_GAP = 6
local WISHLIST_GROUP_GAP = 14
local WISHLIST_HEADER_LEFT_OFFSET = -8

-------------------------------------------------
-- Raid Difficulty Order
--
-- entry.Difficulty is a string like "10", "25",
-- "10 Heroic", "25 Heroic" (from
-- BossPanel:GetSelectedDifficulty()).
-------------------------------------------------

local RAID_DIFFICULTY_RANK = {
    ["10"] = 1,
    ["10 Heroic"] = 2,
    ["25"] = 3,
    ["25 Heroic"] = 4,
}

-------------------------------------------------
-- Slot Order
--
-- Matches the order slots appear on a character
-- sheet, rather than alphabetically.
-------------------------------------------------

local WISHLIST_SLOT_ORDER = {
    "Head", "Neck", "Shoulder", "Back", "Chest", "Wrist",
    "Hands", "Waist", "Legs", "Feet", "Finger", "Trinket",
    "Main Hand", "One-Hand", "Two-Hand", "Off Hand",
    "Ranged", "Relic", "Fist Weapon", "Staff", "Thrown",
    "Mount", "Tier Token", "Quest",
}

local WISHLIST_SLOT_RANK = {}

for i, slotName in ipairs(WISHLIST_SLOT_ORDER) do
    WISHLIST_SLOT_RANK[slotName] = i
end

-------------------------------------------------
-- Get Raid Group Info
--
-- Key/label/rank for arranging by raid+difficulty,
-- e.g. "Icecrown Citadel 10 - Heroic".
-------------------------------------------------

local function GetRaidGroupInfo(entry)

    local raidName = "Other"

    if entry.Raid and entry.Raid.Name then
        raidName = entry.Raid.Name
    end

    local difficulty = entry.Difficulty

    local label = raidName

    if difficulty then

        local size, mode = difficulty:match("^(%d+)%s*(%a*)$")

        if size and mode and mode ~= "" then
            label = raidName .. " " .. size .. " - " .. mode
        elseif size then
            label = raidName .. " " .. size .. " - Normal"
        else
            label = raidName .. " " .. difficulty
        end

    end

    local rank = RAID_DIFFICULTY_RANK[difficulty] or 99
    local key = raidName .. "|" .. tostring(difficulty)

    return key, label, raidName, rank

end

-------------------------------------------------
-- Get Slot Group Info
-------------------------------------------------

local function GetSlotGroupInfo(entry)

    local item = ImpLoot.Database:FindItemByID(entry.ItemID)
    local slotName = (item and item.Slot) or "Other"

    local rank = WISHLIST_SLOT_RANK[slotName] or 999

    return slotName, slotName, rank

end

-------------------------------------------------
-- Create Wishlist Row
-------------------------------------------------

function DetailsWorkspace:CreateWishlistRow(parent, index)

    local row = CreateFrame("Button", nil, parent)

    local Layout = ImpLoot.UI.Layout

    local wishlistRowWidth =
        Layout.GridButtonWidth + 50

    row:SetWidth(wishlistRowWidth)
    row:SetHeight(Layout.GridButtonHeight)

    -------------------------------------------------
    -- Hover Highlight
    -------------------------------------------------

    local highlight = row:CreateTexture(nil, "BACKGROUND")
    highlight:SetAllPoints(row)
    highlight:SetTexture(
        "Interface\\Tooltips\\UI-Tooltip-Background"
    )
    highlight:SetVertexColor(0.35, 0.35, 0.35, 0.30)
    highlight:Hide()

    row.Highlight = highlight

    -------------------------------------------------
    -- Item Icon
    -------------------------------------------------

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(32, 32)
    icon:SetPoint("LEFT", row, "LEFT", 3, 0)

    row.Icon = icon


    -------------------------------------------------
    -- Item Icon
    -------------------------------------------------

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("LEFT", row, "LEFT", 3, 0)

    row.Icon = icon


    -------------------------------------------------
    -- Item Name
    -------------------------------------------------

    local text = row:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )

    text:SetPoint("LEFT", icon, "RIGHT", 5, 0)
    text:SetJustifyH("LEFT")

    row.Text = text

    -------------------------------------------------
    -- Count
    -------------------------------------------------

    local count = row:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )

    count:SetPoint("LEFT", text, "RIGHT", 10, 0)
    count:SetJustifyH("LEFT")

    row.Count = count

    -------------------------------------------------
    -- Item Interaction
    -------------------------------------------------

    row.ItemID = nil

    row:SetScript("OnClick", function()

        -------------------------------------------------
        -- Alt+Click = Remove One Copy
        -------------------------------------------------

        if IsAltKeyDown() and not IsShiftKeyDown() then

            if not row.ItemID then
                return
            end

            local character = ImpLoot.Character:GetViewed()

            if not character then
                return
            end

            local wishlist = ImpLoot.Wishlist:GetActive(character)

            if not wishlist then
                return
            end

            ImpLoot.Wishlist:RemoveItem(
                character,
                wishlist.Name,
                row.ItemID
            )

            return

        end

        -------------------------------------------------
        -- Shift+Alt+Click = Reserved for Compare
        -------------------------------------------------

        if IsShiftKeyDown() and IsAltKeyDown() then
            return
        end

        -------------------------------------------------
        -- Normal Click = Navigate To Boss Loot
        -------------------------------------------------

        if not row.ItemID then
            return
        end

        local item =
            ImpLoot.Database:FindItemByID(
                row.ItemID
            )

        if not item then
            return
        end

        -------------------------------------------------
        -- Use Stored Location If Available
        -------------------------------------------------

        if row.Entry
        and row.Entry.Boss
        and row.Entry.Difficulty then

            ImpLoot.PendingLootSelection = item

            ImpLoot.UI.BossPanel:SelectBoss(
                row.Entry.Boss,
                row.Entry.Difficulty
            )

        elseif row.Entry
        and row.Entry.Raid
        and row.Entry.Difficulty
        and not row.Entry.Boss then

            -------------------------------------------------
            -- Trash Item -- No Specific Boss, Just A Raid
            -------------------------------------------------

            ImpLoot.PendingLootSelection = item

            ImpLoot.UI.BossPanel:SelectTrash(
                row.Entry.Raid,
                row.Entry.Difficulty
            )

        else

            -------------------------------------------------
            -- Legacy Wishlist Entry
            -------------------------------------------------

            ImpLoot.UI.LootPanel:ShowLootItem(
                item
            )

        end

    end)

    -------------------------------------------------
    -- Hover Highlight
    -------------------------------------------------

    row:SetScript("OnEnter", function(self)

        self.Highlight:Show()

    end)

    row:SetScript("OnLeave", function(self)

        self.Highlight:Hide()

    end)

    row:Hide()

    return row

end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function DetailsWorkspace:Initialize(lootPanel)


    local frame = CreateFrame("Frame", nil, lootPanel.Frame)
    self.Frame = frame

    frame:SetPoint("TOPLEFT", lootPanel.Divider, "BOTTOMLEFT", 0, -8)
    frame:SetPoint("TOPRIGHT", lootPanel.Divider, "BOTTOMRIGHT", 0, -8)
    frame:SetPoint("BOTTOMRIGHT", -8, 8)
    frame:SetPoint("BOTTOMLEFT", 8, 8)


    local container = CreateFrame("Frame", nil, frame)
    container:SetAllPoints()
    self.Container = container

    self:BuildDetailsView(container)
    self:BuildWishlistViewHeader(container)
    self:BuildCompareView(container)
    self:BuildRaidPlannerView(container)
    self:BuildWishlistScrollArea()

    -------------------------------------------------
    -- Wishlist Events
    -------------------------------------------------

    ImpLoot.Events:Register(
        "WishlistChanged",
        function()

            if ImpLoot.Workspace:Get() == "Wishlist" then

                self:RefreshWishlist()

            end

        end
    )


end

-------------------------------------------------
-- Build Details View
-------------------------------------------------

function DetailsWorkspace:BuildDetailsView(container)

    -------------------------------------------------
    -- Details View
    -------------------------------------------------

    local detailsView = CreateFrame("Frame", nil, container)

    detailsView:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
    detailsView:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)
    detailsView:SetHeight(32)

    self.DetailsView = detailsView


    -------------------------------------------------
    -- Character
    -------------------------------------------------

    local characterText = detailsView:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )

    characterText:SetPoint(
        "LEFT",
        detailsView,
        "LEFT",
        4,
        10
    )

    characterText:SetJustifyH("LEFT")
    characterText:SetText("Character: -")

    self.CharacterText = characterText


    -------------------------------------------------
    -- Item Name
    -------------------------------------------------

    local itemText = detailsView:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )

    itemText:SetPoint(
        "CENTER",
        detailsView,
        "CENTER",
        0,
        10
    )

    itemText:SetJustifyH("CENTER")
    itemText:SetText("")

    self.ItemText = itemText


    -------------------------------------------------
    -- Wishlist Count
    -------------------------------------------------

    local wishlistText = detailsView:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )

    wishlistText:SetPoint(
        "RIGHT",
        detailsView,
        "RIGHT",
        -4,
        10
    )

    wishlistText:SetJustifyH("RIGHT")
    wishlistText:SetText("Wishlists: 0")

    self.WishlistText = wishlistText

end

-------------------------------------------------
-- Build Wishlist View Header
-------------------------------------------------

function DetailsWorkspace:BuildWishlistViewHeader(container)

    -------------------------------------------------
    -- Wishlist View
    -------------------------------------------------

    local wishlistView = CreateFrame("Frame", nil, container)

    wishlistView:SetAllPoints()
    wishlistView:Hide()

    self.WishlistView = wishlistView


    -------------------------------------------------
    -- Wishlist Title
    -------------------------------------------------

    local wishlistTitle = wishlistView:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormal"
    )

    wishlistTitle:SetPoint(
        "TOPLEFT",
        wishlistView,
        "TOPLEFT",
        4,
        0
    )

    wishlistTitle:SetJustifyH("LEFT")
    wishlistTitle:SetText("Wishlist")

    self.WishlistTitle = wishlistTitle

    -------------------------------------------------
    -- Wishlist Item Counter
    -------------------------------------------------

    local wishlistItemCount =
        wishlistView:CreateFontString(
            nil,
            "OVERLAY",
            "GameFontNormal"
        )

    wishlistItemCount:SetPoint(
        "TOPRIGHT",
        wishlistView,
        "TOPRIGHT",
        -4,
        0
    )

    wishlistItemCount:SetJustifyH("RIGHT")
    wishlistItemCount:SetText("0 Items")

    self.WishlistItemCount =
        wishlistItemCount


    local emptyText = wishlistView:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )

    emptyText:SetWidth(300)

    emptyText:SetPoint(
        "CENTER",
        wishlistView,
        "CENTER",
        0,
        0
    )

    emptyText:SetJustifyH("CENTER")
    emptyText:SetText("(empty)")

    self.EmptyText = emptyText

end

-------------------------------------------------
-- Build Compare View
-------------------------------------------------

function DetailsWorkspace:BuildCompareView(container)

    -------------------------------------------------
    -- Compare View
    -------------------------------------------------

    local compareView = CreateFrame(
        "Frame",
        nil,
        container
    )

    compareView:SetAllPoints()
    compareView:Hide()

    self.CompareView = compareView

end

-------------------------------------------------
-- Build Raid Planner View
-------------------------------------------------

function DetailsWorkspace:BuildRaidPlannerView(container)

    -------------------------------------------------
    -- Raid Planner View
    --
    -- Read-only: groups the viewed character's
    -- wishlist items (across ALL their wishlists, not
    -- just the active one) by raid and difficulty, so
    -- you can see everything you're after in one place
    -- without needing live lockout data.
    -------------------------------------------------

    local raidPlannerView = CreateFrame("Frame", nil, container)

    raidPlannerView:SetAllPoints()
    raidPlannerView:Hide()

    self.RaidPlannerView = raidPlannerView

    local raidPlannerScroll = CreateFrame(
        "ScrollFrame",
        "ImpLootRaidPlannerScrollFrame",
        raidPlannerView,
        "UIPanelScrollFrameTemplate"
    )

    self.RaidPlannerScroll = raidPlannerScroll

    raidPlannerScroll:SetPoint("TOPLEFT", 4, -4)
    raidPlannerScroll:SetPoint("BOTTOMRIGHT", -26, 4)

    local raidPlannerScrollChild = CreateFrame("Frame", nil, raidPlannerScroll)
    raidPlannerScrollChild:SetWidth(1)
    raidPlannerScrollChild:SetHeight(1)

    self.RaidPlannerScrollChild = raidPlannerScrollChild

    raidPlannerScroll:SetScrollChild(raidPlannerScrollChild)

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(raidPlannerScroll)

    raidPlannerScroll:EnableMouseWheel(true)

    raidPlannerScroll:SetScript("OnMouseWheel", function(sf, delta)

        local current = sf:GetVerticalScroll()
        local step = 20
        local maximum = sf:GetVerticalScrollRange()

        local newPosition = current - (delta * step)

        if newPosition < 0 then
            newPosition = 0
        end

        if newPosition > maximum then
            newPosition = maximum
        end

        sf:SetVerticalScroll(newPosition)

        if sf.UpdateScrollIndicators then
            sf:UpdateScrollIndicators()
        end

    end)

    local raidPlannerText = raidPlannerScrollChild:CreateFontString(
        nil, "OVERLAY", "GameFontHighlightSmall"
    )

    raidPlannerText:SetPoint("TOPLEFT", 4, 0)
    raidPlannerText:SetJustifyH("LEFT")
    raidPlannerText:SetSpacing(3)

    self.RaidPlannerText = raidPlannerText

end

-------------------------------------------------
-- Build Wishlist Scroll Area
-------------------------------------------------

function DetailsWorkspace:BuildWishlistScrollArea()

    local wishlistView = self.WishlistView

    -------------------------------------------------
    -- Wishlist Scroll Frame
    -------------------------------------------------

    local Layout = ImpLoot.UI.Layout

    local rowHeight =
        Layout.GridButtonHeight

    local rowGap =
        Layout.GridRowGap

    local visibleRows = 9

    local viewportHeight =
        (visibleRows * rowHeight) +
        ((visibleRows - 1) * rowGap)

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootWishlistScrollFrame",
        wishlistView,
        "UIPanelScrollFrameTemplate"
    )

    scrollFrame:SetPoint(
        "TOPLEFT",
        wishlistView,
        "TOPLEFT",
        4,
        -32
    )

    scrollFrame:SetPoint(
        "TOPRIGHT",
        wishlistView,
        "TOPRIGHT",
        -4,
        -32
    )

    scrollFrame:SetHeight(
        viewportHeight
    )

    self.WishlistScrollFrame =
        scrollFrame

    -------------------------------------------------
    -- Scroll Content
    -------------------------------------------------

    local itemsFrame =
        CreateFrame(
            "Frame",
            nil,
            scrollFrame
        )

    local wishlistColumns = 2

    itemsFrame:SetPoint(
        "TOPLEFT",
        scrollFrame,
        "TOPLEFT",
        0,
        0
    )

    itemsFrame:SetWidth(
        scrollFrame:GetWidth()
    )

    self.WishlistColumns = wishlistColumns

    itemsFrame:SetHeight(1)

    self.ItemsFrame =
        itemsFrame

    self.ItemRows = {}

    for i = 1, 30 do

        self.ItemRows[i] =
            self:CreateWishlistRow(
                itemsFrame,
                i
            )

    end

    scrollFrame:SetScrollChild(
        itemsFrame
    )

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(scrollFrame)

    -------------------------------------------------
    -- Mouse Wheel Scrolling
    -------------------------------------------------

    scrollFrame:EnableMouseWheel(true)

    scrollFrame:SetScript(
        "OnMouseWheel",
        function(self, delta)

            local current =
                self:GetVerticalScroll()

            local step = 20

            local maximum =
                self:GetVerticalScrollRange()

            local newPosition =
                current - (delta * step)

            if newPosition < 0 then
                newPosition = 0
            end

            if newPosition > maximum then
                newPosition = maximum
            end

            self:SetVerticalScroll(
                newPosition
            )

            if self.UpdateScrollIndicators then
                self:UpdateScrollIndicators()
            end

        end
    )


end

-------------------------------------------------
-- Refresh
--
-- Switches which view is shown. Called by the planning
-- drawer whenever the workspace selection changes.
-------------------------------------------------

function DetailsWorkspace:Refresh()

    local workspace = ImpLoot.Workspace:Get()

    -------------------------------------------------
    -- Hide All Views
    -------------------------------------------------

    self.DetailsView:Hide()
    self.WishlistView:Hide()
    self.CompareView:Hide()
    self.RaidPlannerView:Hide()

    -------------------------------------------------
    -- Details
    -------------------------------------------------

    if workspace == "Details" then

        self:SetLayout("Details")

        self.DetailsView:Show()

        return

    end

    -------------------------------------------------
    -- Wishlist
    -------------------------------------------------

    if workspace == "Wishlist" then

        self:SetLayout("Wishlist")

        self.WishlistView:Show()
        self:RefreshWishlist()

        return

    end

    -------------------------------------------------
    -- Compare
    -------------------------------------------------

    if workspace == "Compare" then

        self.CompareView:Show()

        return

    end

    -------------------------------------------------
    -- Raid Planner
    -------------------------------------------------

    if workspace == "RaidPlanner" then

        self:SetLayout("RaidPlanner")

        self.RaidPlannerView:Show()
        self:RefreshRaidPlanner()

        return

    end

end

-------------------------------------------------
-- Details Text Helpers
-------------------------------------------------

local function AddSection(lines, title)
    table.insert(lines, "")
    table.insert(lines, title)
    table.insert(lines, "----------------")
end

local function AddLine(lines, label, value)
    table.insert(lines, label .. ": " .. tostring(value))
end

-------------------------------------------------
-- Show Loot
-------------------------------------------------

function DetailsWorkspace:ShowLoot(item)

    if not item then
        return
    end

    -------------------------------------------------
    -- Character
    -------------------------------------------------

    local character = ImpLoot.Character:GetCurrent()

    if character and character.Name then
        self.CharacterText:SetText(
            "Character: " .. character.Name
        )
    else
        self.CharacterText:SetText(
            "Character: -"
        )
    end

    -------------------------------------------------
    -- Item Name
    -------------------------------------------------

    local displayName = item.Name
    local quality = item.Quality

    -------------------------------------------------
    -- Determine Item ID For Current Difficulty
    -------------------------------------------------

    local itemID = item.ID

    if not itemID and item.IDs then

        local selectedDifficulty =
            ImpLoot.UI.BossPanel:GetSelectedDifficulty()

        if selectedDifficulty == "10 Heroic"
        or selectedDifficulty == "25 Heroic" then

            itemID = 
                item.IDs.Heroic
                or item.IDs.Normal

        else

            itemID = 
                item.IDs.Normal
                or item.IDs.Heroic

        end

    end

    -------------------------------------------------
    -- Use cached item information when available
    -------------------------------------------------

    if itemID and ImpLoot.ItemCache then

        local cached = ImpLoot.ItemCache:GetItem(itemID)

        if cached then

            if cached.Name then
                displayName = cached.Name
            end

            if cached.Quality then
                quality = cached.Quality
            end

        end

    end

    self.ItemText:SetText(
        displayName or ""
    )

    -------------------------------------------------
    -- Item Quality Color
    -------------------------------------------------

    if quality then

        local r, g, b =
            ImpLoot.Theme:GetQualityColor(quality)

        self.ItemText:SetTextColor(r, g, b)

    else

        self.ItemText:SetTextColor(1, 1, 1)

    end

    -------------------------------------------------
    -- Wishlist Count
    -------------------------------------------------

    local wishlistCount = 0

    if character and character.Wishlists then

        for _, wishlist in pairs(character.Wishlists) do

            if wishlist.Items then

                for _, entry in ipairs(wishlist.Items) do

                    if entry.ItemID == itemID then

                        wishlistCount = wishlistCount + 1
                        break

                    end

                end

            end

        end

    end

    self.WishlistText:SetText(
        "Wishlists: " .. wishlistCount
    )

end

-------------------------------------------------
-- Get Wishlist Column X
--
-- Same per-column X math the grid previously had
-- inline, factored out so both the flat layout and
-- the grouped layouts can share it.
-------------------------------------------------

function DetailsWorkspace:GetWishlistColumnX(column)

    local Layout = ImpLoot.UI.Layout

    local contentWidth = self.ItemsFrame:GetWidth()
    local wishlistRowWidth = Layout.GridButtonWidth + 50
    local halfButtonWidth = wishlistRowWidth / 2
    local columnSeparation = 20

    local columnCenter

    if column == 0 then

        local originalCenter = contentWidth / 3
        local emptySpace = originalCenter - halfButtonWidth

        columnCenter = originalCenter - (emptySpace * 0.25)
        columnCenter = columnCenter - columnSeparation

    else

        local originalCenter = (contentWidth * 2) / 3
        local emptySpace = contentWidth - (originalCenter + halfButtonWidth)

        columnCenter = originalCenter + (emptySpace * 0.25)
        columnCenter = columnCenter + columnSeparation

    end

    return columnCenter - halfButtonWidth, wishlistRowWidth

end

-------------------------------------------------
-- Wishlist Group Headers
--
-- A grow-as-needed pool of FontStrings, reset (all
-- hidden) at the start of every refresh and handed
-- out one at a time as groups are rendered.
-------------------------------------------------

function DetailsWorkspace:ResetWishlistHeaders()

    self.HeaderWidgets = self.HeaderWidgets or {}
    self.HeaderWidgetCursor = 0

    for _, header in ipairs(self.HeaderWidgets) do
        header:Hide()
    end

end

function DetailsWorkspace:AcquireWishlistHeader()

    self.HeaderWidgetCursor = self.HeaderWidgetCursor + 1

    local header = self.HeaderWidgets[self.HeaderWidgetCursor]

    if not header then

        header = self.ItemsFrame:CreateFontString(
            nil,
            "OVERLAY",
            "GameFontNormal"
        )

        header:SetJustifyH("LEFT")

        self.HeaderWidgets[self.HeaderWidgetCursor] = header

    end

    return header

end

-------------------------------------------------
-- Populate Wishlist Row
--
-- Fills in one wishlist row's icon/name/count and
-- positions it at the given (x, y).
-------------------------------------------------

function DetailsWorkspace:PopulateWishlistRow(row, entry, x, y)

    row.ItemID = entry.ItemID
    row.Entry = entry

    local item = ImpLoot.Database:FindItemByID(entry.ItemID)

    if not item then
        row:Hide()
        return
    end

    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", x, -y)

    -------------------------------------------------
    -- Item Icon
    -------------------------------------------------

    local cached = nil

    if ImpLoot.ItemCache then
        cached = ImpLoot.ItemCache:GetItem(entry.ItemID)
    end

    if cached and cached.Texture then
        row.Icon:SetTexture(cached.Texture)
        row.Icon:Show()
    else
        row.Icon:Hide()
    end

    -------------------------------------------------
    -- Item Name
    -------------------------------------------------

    local displayName = item.Name
    local quality = item.Quality

    if cached then

        if cached.Name then
            displayName = cached.Name
        end

        if cached.Quality then
            quality = cached.Quality
        end

    end

    local r, g, b = ImpLoot.Theme:GetQualityColor(quality)

    row.Text:SetText(displayName)
    row.Text:SetTextColor(r, g, b)

    -------------------------------------------------
    -- Count
    -------------------------------------------------

    if entry.Count and entry.Count > 1 then
        row.Count:SetText("x" .. entry.Count)
    else
        row.Count:SetText("")
    end

    row:Show()

end

-------------------------------------------------
-- Build Wishlist Groups
--
-- Buckets displayItems into ordered groups per the
-- ArrangeBy mode. "ALL" is a single, unlabelled group
-- (no header rendered) so it shares the same renderer
-- as "RAID".
-------------------------------------------------

function DetailsWorkspace:BuildWishlistGroups(displayItems, arrangeBy)

    if arrangeBy == "ALL" then

        return { { Label = nil, Entries = displayItems } }

    end

    local groups = {}
    local groupsByKey = {}

    for _, entry in ipairs(displayItems) do

        local key, label, sortName, rank

        if arrangeBy == "SLOT" then
            key, label, rank = GetSlotGroupInfo(entry)
            sortName = label
        else
            key, label, sortName, rank = GetRaidGroupInfo(entry)
        end

        local group = groupsByKey[key]

        if not group then

            group = {
                Key = key,
                Label = label,
                SortName = sortName,
                Rank = rank,
                Entries = {},
            }

            groupsByKey[key] = group
            table.insert(groups, group)

        end

        table.insert(group.Entries, entry)

    end

    table.sort(groups, function(a, b)

        -------------------------------------------------
        -- By Slot: Character-Sheet Order (Rank) First
        -------------------------------------------------

        if arrangeBy == "SLOT" then

            if a.Rank ~= b.Rank then
                return a.Rank < b.Rank
            end

            return a.Label < b.Label

        end

        -------------------------------------------------
        -- By Raid: Raid Name, Then Difficulty Rank
        -------------------------------------------------

        if a.SortName ~= b.SortName then
            return a.SortName < b.SortName
        end

        if a.Rank ~= b.Rank then
            return a.Rank < b.Rank
        end

        return a.Label < b.Label

    end)

    return groups

end

-------------------------------------------------
-- Render Sequential Wishlist Groups
--
-- Used by "ALL" and "RAID" -- each group takes the
-- full width: a header (if labelled), then its items
-- fill the normal 2-column grid, then the next group
-- starts fresh at column 0.
-------------------------------------------------

function DetailsWorkspace:RenderSequentialWishlistGroups(groups, wishlistColumns)

    local Layout = ImpLoot.UI.Layout

    local y = 0
    local rowIndex = 0

    for _, group in ipairs(groups) do

        if group.Label then

            local x0 = self:GetWishlistColumnX(0)

            local header = self:AcquireWishlistHeader()

            header:ClearAllPoints()

            header:SetPoint(
                "TOPLEFT",
                self.ItemsFrame,
                "TOPLEFT",
                x0 + WISHLIST_HEADER_LEFT_OFFSET,
                -y
            )

            header:SetText(group.Label)
            header:Show()

            y = y + WISHLIST_HEADER_HEIGHT + WISHLIST_HEADER_ITEM_GAP

        end

        for i, entry in ipairs(group.Entries) do

            rowIndex = rowIndex + 1

            local row = self.ItemRows[rowIndex]

            if row then

                local column = (i - 1) % wishlistColumns

                local gridRow = math.floor(
                    (i - 1) / wishlistColumns
                )

                local x = self:GetWishlistColumnX(column)

                local rowY = y + gridRow * (
                    Layout.GridButtonHeight +
                    Layout.GridRowGap
                )

                self:PopulateWishlistRow(row, entry, x, rowY)

            end

        end

        local rowsUsed = math.ceil(
            #group.Entries / wishlistColumns
        )

        y = y + rowsUsed * (
            Layout.GridButtonHeight +
            Layout.GridRowGap
        )

        if group.Label then
            y = y + WISHLIST_GROUP_GAP
        end

    end

    return y, rowIndex

end

-------------------------------------------------
-- Render Masonry Wishlist Groups
--
-- Used by "SLOT" -- each group is confined to a
-- single column (its header included), and every
-- group is placed into whichever of the two columns
-- is currently shorter. Keeps small single-item
-- groups from wasting the second column.
-------------------------------------------------

function DetailsWorkspace:RenderMasonryWishlistGroups(groups)

    local Layout = ImpLoot.UI.Layout

    local columnY = { [0] = 0, [1] = 0 }
    local rowIndex = 0

    for _, group in ipairs(groups) do

        local column = 0

        if columnY[1] < columnY[0] then
            column = 1
        end

        local x = self:GetWishlistColumnX(column)

        local header = self:AcquireWishlistHeader()

        header:ClearAllPoints()

        header:SetPoint(
            "TOPLEFT",
            self.ItemsFrame,
            "TOPLEFT",
            x + WISHLIST_HEADER_LEFT_OFFSET,
            -columnY[column]
        )

        header:SetText(group.Label)
        header:Show()

        columnY[column] = columnY[column] +
            WISHLIST_HEADER_HEIGHT +
            WISHLIST_HEADER_ITEM_GAP

        for _, entry in ipairs(group.Entries) do

            rowIndex = rowIndex + 1

            local row = self.ItemRows[rowIndex]

            if row then

                self:PopulateWishlistRow(row, entry, x, columnY[column])

                columnY[column] = columnY[column] +
                    Layout.GridButtonHeight +
                    Layout.GridRowGap

            end

        end

        columnY[column] = columnY[column] + WISHLIST_GROUP_GAP

    end

    local totalHeight = columnY[0]

    if columnY[1] > totalHeight then
        totalHeight = columnY[1]
    end

    return totalHeight, rowIndex

end

-------------------------------------------------
-- Refresh Wishlist View
-------------------------------------------------

-------------------------------------------------
-- Raid Planner
--
-- Read-only lookup: groups the viewed character's
-- wishlist items (across ALL their wishlists, not
-- just the active one -- this is meant to answer
-- "what am I after across everything", not just one
-- list) by raid and difficulty, with each item shown
-- next to the boss it drops from. No lockout data --
-- deliberately simplified per the agreed scope.
-------------------------------------------------

local RAID_PLANNER_DIFFICULTY_LABELS = {
    ["10"] = "10 Man",
    ["25"] = "25 Man",
    ["10 Heroic"] = "10 Man Heroic",
    ["25 Heroic"] = "25 Man Heroic",
}

function DetailsWorkspace:RefreshRaidPlanner()

    local character = ImpLoot.Character:GetViewed()

    if not character then

        self.RaidPlannerText:SetText("No character selected.")
        self.RaidPlannerScrollChild:SetHeight(20)

        if self.RaidPlannerScroll.UpdateScrollIndicators then
            self.RaidPlannerScroll:UpdateScrollIndicators()
        end

        return

    end

    -------------------------------------------------
    -- Collect Unique Item IDs Across All Wishlists
    -------------------------------------------------

    local seenItemIDs = {}
    local itemIDs = {}

    for _, wishlist in ipairs(character.Wishlists or {}) do

        for _, entry in ipairs(wishlist.Items or {}) do

            if not seenItemIDs[entry.ItemID] then

                seenItemIDs[entry.ItemID] = true
                table.insert(itemIDs, entry.ItemID)

            end

        end

    end

    if #itemIDs == 0 then

        self.RaidPlannerText:SetText("No wishlist items yet -- add some from any boss's loot.")
        self.RaidPlannerScrollChild:SetHeight(20)

        if self.RaidPlannerScroll.UpdateScrollIndicators then
            self.RaidPlannerScroll:UpdateScrollIndicators()
        end

        return

    end

    -------------------------------------------------
    -- Group By Raid -> Difficulty
    -------------------------------------------------

    local raidGroups = {}

    for _, itemID in ipairs(itemIDs) do

        local item = ImpLoot.Database:FindItemByID(itemID)

        if item and item.Raid then

            local raidName = item.Raid.Name
            local bossName = (item.Boss and item.Boss.Name) or "Trash"

            raidGroups[raidName] = raidGroups[raidName] or {}

            for difficulty in pairs(item.AvailableIn or {}) do

                raidGroups[raidName][difficulty] = raidGroups[raidName][difficulty] or {}

                table.insert(raidGroups[raidName][difficulty], {
                    BossName = bossName,
                    ItemName = item.Name,
                })

            end

        end

    end

    -------------------------------------------------
    -- Build Text, Raids In Release Order
    -------------------------------------------------

    local lines = {}

    for _, raid in ipairs(ImpLoot.Database:GetRaidsInReleaseOrder()) do

        local difficulties = raidGroups[raid.Name]

        if difficulties then

            table.insert(lines, "|cffffd100" .. raid.Name .. "|r")

            local difficultyOrder = {}

            for difficulty in pairs(difficulties) do
                table.insert(difficultyOrder, difficulty)
            end

            table.sort(difficultyOrder)

            for _, difficulty in ipairs(difficultyOrder) do

                local label = RAID_PLANNER_DIFFICULTY_LABELS[difficulty] or difficulty

                table.insert(lines, "  |cffcccccc" .. label .. "|r")

                for _, entry in ipairs(difficulties[difficulty]) do

                    table.insert(lines, "    " .. entry.BossName .. " -- " .. entry.ItemName)

                end

            end

        end

    end

    local textWidth = math.max(200, (self.RaidPlannerScroll:GetWidth() or 0) - 10)

    self.RaidPlannerText:SetWidth(textWidth)
    self.RaidPlannerText:SetText(table.concat(lines, "\n"))

    self.RaidPlannerScrollChild:SetWidth(textWidth + 10)
    self.RaidPlannerScrollChild:SetHeight(#lines * 16 + 20)

    if self.RaidPlannerScroll.UpdateScrollIndicators then
        self.RaidPlannerScroll:UpdateScrollIndicators()
    end

end



function DetailsWorkspace:RefreshWishlist()

    -------------------------------------------------
    -- Viewed Character
    -------------------------------------------------

    local character = ImpLoot.Character:GetViewed()

    if not character then

        self.WishlistTitle:SetText("Wishlist")
        self.EmptyText:SetText("(no character)")
        self.EmptyText:Show()

        for _, row in ipairs(self.ItemRows) do
            row.ItemID = nil
            row.Entry = nil
            row:Hide()
        end

        if self.WishlistItemCount then
            self.WishlistItemCount:SetText("0 Items")
        end

        if self.WishlistScrollFrame.UpdateScrollIndicators then
            self.WishlistScrollFrame:UpdateScrollIndicators()
        end

        return

    end

    -------------------------------------------------
    -- Active Wishlist
    -------------------------------------------------

    local activeWishlist = ImpLoot.Wishlist:GetActive(character)

    if not activeWishlist then

        self.WishlistTitle:SetText("Wishlist")

        self.EmptyText:SetText("(no active wishlist)")
        self.EmptyText:Show()

        for _, row in ipairs(self.ItemRows) do
            row.ItemID = nil
            row:Hide()
        end

        if self.WishlistItemCount then
            self.WishlistItemCount:SetText("0 Items")
        end

        if self.WishlistScrollFrame.UpdateScrollIndicators then
            self.WishlistScrollFrame:UpdateScrollIndicators()
        end

        return

    end

    local titleText = activeWishlist.Name
    local actualCurrent = ImpLoot.Character:GetCurrent()

    if actualCurrent and character.Name ~= actualCurrent.Name then
        titleText = titleText .. "  (" .. character.Name .. ")"
    end

    self.WishlistTitle:SetText(titleText)

    -------------------------------------------------
    -- Calculate Total Wishlist Quantity
    -------------------------------------------------

    local totalWishlistItems = 0

    for _, entry in ipairs(activeWishlist.Items or {}) do

        totalWishlistItems =
            totalWishlistItems +
            (entry.Count or 1)

    end

    self.WishlistItemCount:SetText(
        tostring(totalWishlistItems) .. " Items"
    )

    -------------------------------------------------
    -- Hide all rows first
    -------------------------------------------------

    for _, row in ipairs(self.ItemRows) do
        row.ItemID = nil
        row:Hide()
    end

    -------------------------------------------------
    -- Reset Group Headers
    --
    -- Always, even for an empty wishlist -- otherwise a
    -- stale "Icecrown Citadel" heading from before the
    -- last item was removed (or before ANY item was ever
    -- added to a brand-new wishlist) stays on screen with
    -- nothing under it.
    -------------------------------------------------

    self:ResetWishlistHeaders()

    -------------------------------------------------
    -- Empty Wishlist
    -------------------------------------------------

    if #activeWishlist.Items == 0 then

        self.EmptyText:SetText("(empty)")
        self.EmptyText:Show()

        if self.WishlistItemCount then
            self.WishlistItemCount:SetText("0 Items")
        end

        if self.WishlistScrollFrame.UpdateScrollIndicators then
            self.WishlistScrollFrame:UpdateScrollIndicators()
        end

        return

    end

    self.EmptyText:Hide()

    -------------------------------------------------
    -- Create Display Order
    -------------------------------------------------

    local displayItems = {}

    for _, entry in ipairs(activeWishlist.Items) do
        table.insert(displayItems, entry)
    end

    -------------------------------------------------
    -- Sort Display Items
    -------------------------------------------------

    local arrangeBy = activeWishlist.ArrangeBy or "ALL"

    table.sort(displayItems, function(a, b)

        local itemA = ImpLoot.Database:FindItemByID(a.ItemID)
        local itemB = ImpLoot.Database:FindItemByID(b.ItemID)

        local nameA = itemA and itemA.Name or ""
        local nameB = itemB and itemB.Name or ""

        -------------------------------------------------
        -- All Items
        -------------------------------------------------

        if arrangeBy == "ALL" then

            return string.lower(nameA) < string.lower(nameB)

        end

        -------------------------------------------------
        -- By Raid
        -------------------------------------------------

        if arrangeBy == "RAID" then

            -- Currently all raid data is ICC 10.
            -- Keep alphabetical order within the raid.

            return string.lower(nameA) < string.lower(nameB)

        end

        -------------------------------------------------
        -- By Slot
        -------------------------------------------------

        if arrangeBy == "SLOT" then

            -- Not wired yet.
            -- Keep alphabetical order until slot sorting is added.

            return string.lower(nameA) < string.lower(nameB)

        end

        -------------------------------------------------
        -- Fallback
        -------------------------------------------------

        return string.lower(nameA) < string.lower(nameB)

    end)

    -------------------------------------------------
    -- Build & Render Groups
    -------------------------------------------------

    local groups = self:BuildWishlistGroups(displayItems, arrangeBy)

    local wishlistColumns = self.WishlistColumns or 2

    local totalHeight, rowsUsed

    if arrangeBy == "SLOT" then

        totalHeight, rowsUsed =
            self:RenderMasonryWishlistGroups(groups)

    else

        totalHeight, rowsUsed =
            self:RenderSequentialWishlistGroups(
                groups,
                wishlistColumns
            )

    end

    -------------------------------------------------
    -- Hide Any Rows Left Over From A Previous Refresh
    -------------------------------------------------

    for i = rowsUsed + 1, #self.ItemRows do

        local row = self.ItemRows[i]

        row.ItemID = nil
        row.Entry = nil
        row:Hide()

    end

    -------------------------------------------------
    -- Resize The Scroll Child To Fit
    -------------------------------------------------

    self.ItemsFrame:SetHeight(math.max(totalHeight, 1))

    if self.WishlistScrollFrame.UpdateScrollIndicators then
        self.WishlistScrollFrame:UpdateScrollIndicators()
    end

end

-------------------------------------------------
-- Clear Details
-------------------------------------------------

function DetailsWorkspace:Clear()

    if self.CharacterText then
        self.CharacterText:SetText("Character: -")
    end

    if self.ItemText then
        self.ItemText:SetText("")
    end

    if self.WishlistText then
        self.WishlistText:SetText("Wishlists: 0")
    end

end

-------------------------------------------------
-- Workspace Layout
-------------------------------------------------

function DetailsWorkspace:SetLayout(mode)

    if not self.Frame then
        return
    end

    local lootPanel = ImpLoot.UI.LootPanel

    if not lootPanel then
        return
    end

    local totalHeight = lootPanel.Frame:GetHeight()

    if totalHeight <= 0 then
        return
    end

    -------------------------------------------------
    -- Details
    -------------------------------------------------

    if mode == "Details" then

        local detailsHeight = 55

        self.Frame:SetHeight(detailsHeight)

        lootPanel:SetContentHeight(
            totalHeight - detailsHeight - 16
        )

    -------------------------------------------------
    -- Wishlist
    -------------------------------------------------

    elseif mode == "Wishlist" then

        local wishlistHeight = 270

        self.Frame:SetHeight(wishlistHeight)

        lootPanel:SetContentHeight(
            totalHeight - wishlistHeight - 16
        )

    -------------------------------------------------
    -- Raid Planner
    -------------------------------------------------

    elseif mode == "RaidPlanner" then

        local raidPlannerHeight = 270

        self.Frame:SetHeight(raidPlannerHeight)

        lootPanel:SetContentHeight(
            totalHeight - raidPlannerHeight - 16
        )

    end

end