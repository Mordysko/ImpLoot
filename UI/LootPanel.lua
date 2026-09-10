-------------------------------------------------
-- Loot Panel
--
-- Search box + scrollable loot list. Also owns the
-- divider line that DetailsWorkspace anchors below.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.LootPanel = ImpLoot.UI.LootPanel or {}
local LootPanel = ImpLoot.UI.LootPanel

local PLACEHOLDER_TEXT = "Search..."

-------------------------------------------------
-- Initialize
-------------------------------------------------

function LootPanel:Initialize(mainWindowFrame, bossPanelFrame)

    local Layout = ImpLoot.UI.Layout

    local frame = CreateFrame("Frame", nil, mainWindowFrame)
    self.Frame = frame

    frame:SetPoint("TOPLEFT", bossPanelFrame, "TOPRIGHT", Layout.Padding, 0)
    frame:SetPoint("BOTTOMRIGHT", mainWindowFrame, "BOTTOMRIGHT", -Layout.Padding, Layout.StatusHeight + Layout.Padding)

    frame:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background" })
    frame:SetBackdropColor(0.10, 0.10, 0.10, 0.95)

    -------------------------------------------------
    -- Title
    -------------------------------------------------

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 10, -10)
    title:SetText("Loot")

    -------------------------------------------------
    -- Class Dropdown (Vault of Archavon Only)
    --
    -- Replaces the Normal/Heroic toggle for that raid,
    -- whose loot is organized per-class rather than
    -- per-difficulty-tier. Lives here (top of the loot
    -- window, next to the title) rather than in
    -- BossPanel, so it doesn't overlap the loot grid.
    -------------------------------------------------

    local classDropdown = CreateFrame(
        "Frame",
        "ImpLootClassDropDown",
        frame,
        "UIDropDownMenuTemplate"
    )

    self.ClassDropdown = classDropdown

    classDropdown:SetPoint("LEFT", title, "RIGHT", 4, -2)

    UIDropDownMenu_SetWidth(classDropdown, 90)

    ImpLoot.SelectedClass = ImpLoot.SelectedClass
        or (ImpLoot.CLASS_ORDER and ImpLoot.CLASS_ORDER[1])
        or "Warrior"

    UIDropDownMenu_Initialize(classDropdown, function(dropdown, level)

        for _, className in ipairs(ImpLoot.CLASS_ORDER) do

            local info = UIDropDownMenu_CreateInfo()

            info.text = className
            info.checked = (ImpLoot.SelectedClass == className)

            info.func = function()

                ImpLoot.SelectedClass = className

                UIDropDownMenu_SetText(classDropdown, className)

                if ImpLoot.SelectedBoss then
                    self:PopulateForBoss(ImpLoot.SelectedBoss)
                end

            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    if UIDropDownMenu_SetText then
        UIDropDownMenu_SetText(classDropdown, ImpLoot.SelectedClass)
    end

    classDropdown:Hide()

    -------------------------------------------------
    -- Search Box
    -------------------------------------------------

    local searchBox = CreateFrame("EditBox", "ImpLootLootPanelSearchBox", frame, "InputBoxTemplate")
    self.SearchBox = searchBox

    searchBox:SetAutoFocus(false)
    searchBox:SetSize(170, 20)
    searchBox:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -8)

    searchBox:SetScript("OnEditFocusGained", function()
        self:ClearSearchPlaceholder()
    end)

    searchBox:SetScript("OnEditFocusLost", function()
        if searchBox:GetText() == "" then
            self:ResetSearchBox()
        end
    end)

    searchBox:SetScript("OnEnterPressed", function(box)
        box:ClearFocus()
    end)

    searchBox:SetScript("OnTextChanged", function(box)

        local text = box:GetText()

        if text == PLACEHOLDER_TEXT then
            return
        end

        if text == "" then

            if ImpLoot.SelectedBoss then
                self:PopulateForBoss(ImpLoot.SelectedBoss)
            else
                self:ResetLootHeaders()
                self:Clear()
            end

            return

        end

        local results = ImpLoot.Database:Search(text, ImpLoot.SelectedRaid)
        self:PopulateSearchResults(results)

    end)

    searchBox:SetText(PLACEHOLDER_TEXT)
    searchBox:SetTextColor(0.6, 0.6, 0.6)

    -------------------------------------------------
    -- Loot List Viewport
    -------------------------------------------------

    local content = CreateFrame(
        "ScrollFrame",
        "ImpLootLootScrollFrame",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    self.Content = content

    content:SetPoint(
        "TOPLEFT",
        title,
        "BOTTOMLEFT",
        0,
        -10
    )

    content:SetPoint(
        "TOPRIGHT",
        frame,
        "TOPRIGHT",
        -8,
        -10
    )

    content:SetHeight(220)

    -------------------------------------------------
    -- Loot Scroll Content
    -------------------------------------------------

    local scrollChild = CreateFrame(
        "Frame",
        nil,
        content
    )

    scrollChild:SetWidth(
        content:GetWidth()
    )

    scrollChild:SetHeight(1)

    self.ScrollChild =
        scrollChild

    content:SetScrollChild(
        scrollChild
    )

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(content)

    -------------------------------------------------
    -- Mouse Wheel
    -------------------------------------------------

    content:EnableMouseWheel(true)

    content:SetScript(
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

    -------------------------------------------------
    -- Divider
    -------------------------------------------------

    local divider =
        frame:CreateTexture(
            nil,
            "ARTWORK"
        )

    self.Divider = divider

    divider:SetTexture(
        1,
        1,
        1,
        0.20
    )

    divider:SetHeight(1)

    divider:SetPoint(
        "TOPLEFT",
        content,
        "BOTTOMLEFT",
        0,
        -8
    )

    divider:SetPoint(
        "TOPRIGHT",
        content,
        "BOTTOMRIGHT",
        0,
        -8
    )

    self.Buttons = {}

    -------------------------------------------------
    -- Compare Events
    --
    -- The compare drawer's contents decide which loot
    -- buttons should grey out (wrong slot, or not
    -- equippable at all).
    -------------------------------------------------

    ImpLoot.Events:Register("CompareChanged", function()
        self:UpdateCompareDimming()
    end)

end

-------------------------------------------------
-- Search Placeholder
-------------------------------------------------

function LootPanel:ResetSearchBox()
    self.SearchBox:SetText(PLACEHOLDER_TEXT)
    self.SearchBox:SetTextColor(0.6, 0.6, 0.6)
end

function LootPanel:ClearSearchPlaceholder()

    if self.SearchBox:GetText() == PLACEHOLDER_TEXT then
        self.SearchBox:SetText("")
        self.SearchBox:SetTextColor(1, 1, 1)
    end

end

function LootPanel:ClearSearchFocus()

    if self.SearchBox then
        self.SearchBox:ClearFocus()
    end

end

-------------------------------------------------
-- Clear List
-------------------------------------------------

function LootPanel:Clear()

    local children = {
        self.ScrollChild:GetChildren()
    }

    for _, child in ipairs(children) do
        child:Hide()
        child:SetParent(nil)
    end

end

-------------------------------------------------
-- Show Loot Item
-------------------------------------------------

function LootPanel:ShowLootItem(item)

    if not item then
        return
    end

    if not item.Boss then
        return
    end

    ImpLoot.SelectedRaid = item.Raid
    ImpLoot.SelectedBoss = item.Boss
    ImpLoot.SelectedLoot = item

    ImpLoot.UI.BossPanel:HighlightForBoss(item.Boss)
    self:PopulateForBoss(item.Boss)

    ImpLoot.Workspace:Set("Details")

    ImpLoot.UI.DetailsWorkspace:Refresh()
    ImpLoot.UI.DetailsWorkspace:ShowLoot(item)

end

-------------------------------------------------
-- Format Item Type
-------------------------------------------------

local function FormatItemType(item)

    if not item then
        return ""
    end

    local equipLoc = item.EquipLoc
    local subType = item.SubType

    local equipText = ""

    if equipLoc == "INVTYPE_HEAD" then
        equipText = "Head"

    elseif equipLoc == "INVTYPE_NECK" then
        return "Neck"

    elseif equipLoc == "INVTYPE_SHOULDER" then
        equipText = "Shoulder"

    elseif equipLoc == "INVTYPE_CHEST"
        or equipLoc == "INVTYPE_ROBE" then
        equipText = "Chest"

    elseif equipLoc == "INVTYPE_WAIST" then
        equipText = "Waist"

    elseif equipLoc == "INVTYPE_LEGS" then
        equipText = "Legs"

    elseif equipLoc == "INVTYPE_FEET" then
        equipText = "Feet"

    elseif equipLoc == "INVTYPE_WRIST" then
        equipText = "Wrist"

    elseif equipLoc == "INVTYPE_HAND" then
        equipText = "Hands"

    elseif equipLoc == "INVTYPE_CLOAK" then
        return "Back"

    elseif equipLoc == "INVTYPE_FINGER" then
        return "Ring"

    elseif equipLoc == "INVTYPE_TRINKET" then
        return "Trinket"

    elseif equipLoc == "INVTYPE_WEAPONMAINHAND" then
        equipText = "Main Hand"

    elseif equipLoc == "INVTYPE_WEAPONOFFHAND" then
        equipText = "Off Hand"

    elseif equipLoc == "INVTYPE_2HWEAPON" then
        equipText = "Two-Hand"

    elseif equipLoc == "INVTYPE_WEAPON" then
        equipText = "One-Hand"

    elseif equipLoc == "INVTYPE_RANGED"
        or equipLoc == "INVTYPE_RANGEDRIGHT" then
        equipText = "Ranged"

    elseif equipLoc == "INVTYPE_SHIELD" then
        equipText = "Off Hand"

    elseif equipLoc == "INVTYPE_HOLDABLE" then
        return "Off Hand Item"

    end

    if equipText ~= "" and subType and subType ~= "" then
        return equipText .. ", " .. subType
    elseif equipText ~= "" then
        return equipText
    elseif subType and subType ~= "" then
        return subType
    end

    return ""

end

-------------------------------------------------
-- Create Loot Button
--
-- `entry` is either a raw item (normal boss listing) or a
-- search result wrapper { Item, Boss, Raid } -- entry.Item
-- tells the two apart.
-------------------------------------------------

function LootPanel:CreateLootButton(entry, x, y, isSearchResult)

    local Layout = ImpLoot.UI.Layout
    local item = entry.Item or entry

    -------------------------------------------------
    -- Determine Item ID For Current Difficulty
    -------------------------------------------------

    local selectedDifficulty = ImpLoot.UI.BossPanel:GetSelectedDifficulty()

    local itemID

    if selectedDifficulty == "10 Heroic" or selectedDifficulty == "25 Heroic" then
        itemID = item.IDs.Heroic or item.IDs.Normal
    else
        itemID = item.IDs.Normal or item.IDs.Heroic
    end

    -------------------------------------------------
    -- Get Cached Item Information
    -------------------------------------------------

    local cached = ImpLoot.ItemCache:GetItem(itemID)

    local button = CreateFrame("Button", nil, self.ScrollChild)

    button.Item = item
    button.ItemID = itemID

    button:SetWidth(Layout.GridButtonWidth)
    button:SetHeight(46)
    button:SetPoint("TOPLEFT", x, -y)

    local bg = button:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0, 0, 0, 0)

    button.Background = bg
    button.Selected = false

    -------------------------------------------------
    -- Item Icon
    -------------------------------------------------

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(32, 32)
    icon:SetPoint("LEFT", button, "LEFT", 3, 0)

    local iconID = nil

    if cached and cached.Texture then
        iconID = cached.Texture
    end

    if iconID then
        icon:SetTexture(iconID)
    end

    button.Icon = icon

    -------------------------------------------------
    -- Item Name
    -------------------------------------------------

    local text = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")

    if isSearchResult then
        text:SetPoint("TOPLEFT", icon, "TOPRIGHT", 6, 3)
        text:SetHeight(12)
    else
        text:SetPoint("TOPLEFT", icon, "TOPRIGHT", 6, -2)
        text:SetHeight(16)
    end

    text:SetPoint("RIGHT", button, "RIGHT", -4, 0)
    text:SetJustifyH("LEFT")

    local displayName = item.Name
    local displayQuality = item.Quality

    if cached then
        displayName = cached.Name
        displayQuality = cached.Quality
    end

    local r, g, b = ImpLoot.Theme:GetQualityColor(displayQuality)
    text:SetTextColor(r, g, b)
    text:SetText(displayName)

    button.Text = text

    -------------------------------------------------
    -- Item Slot / Type
    -------------------------------------------------

    local typeText = button:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")

    typeText:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, isSearchResult and 0 or -1)
    typeText:SetPoint("RIGHT", button, "RIGHT", -4, 0)
    typeText:SetHeight(isSearchResult and 12 or 14)
    typeText:SetJustifyH("LEFT")

    local itemType = ""

    if item.Token then

        -- Tier tokens aren't real equippable gear, so the
        -- client's own SubType for them is usually "Junk" --
        -- accurate to WoW's internal classification, but
        -- reads as if something's wrong with the item. Our
        -- own data already knows these are tokens.
        itemType = "Token"

    elseif cached then
        itemType = FormatItemType(cached)
    else
        itemType = FormatItemType(item)
    end

    typeText:SetText(itemType)

    button.TypeText = typeText

    -------------------------------------------------
    -- Item Link
    -------------------------------------------------

    if cached then
        button.ItemLink = cached.Link
    end

    -------------------------------------------------
    -- Hover Highlight + Tooltip
    -------------------------------------------------

    button:SetScript("OnEnter", function()

        if not button.Selected then
            button.Background:SetVertexColor(0.35, 0.35, 0.35, 0.20)
        end

        if button.ItemLink then
            GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(button.ItemLink)
            GameTooltip:Show()
        end

    end)

    button:SetScript("OnLeave", function()

        if not button.Selected then
            button.Background:SetVertexColor(0, 0, 0, 0)
        end

        GameTooltip:Hide()

    end)

    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    button:SetScript("OnClick", function(clickedButton, mouseButton)
        self:HandleLootButtonClick(button, entry, item, itemID, selectedDifficulty, isSearchResult, mouseButton)
    end)

    return button

end

-------------------------------------------------
-- Handle Loot Button Click
--
-- Extracted from CreateLootButton -- six distinct
-- click behaviors depending on modifier keys and
-- context, checked in priority order (shift/ctrl
-- first, since those apply regardless of what else
-- is going on; compare-drawer alt-click next, since
-- it temporarily takes over alt-click while open;
-- then the remaining plain-click behaviors).
-------------------------------------------------

function LootPanel:HandleLootButtonClick(button, entry, item, itemID, selectedDifficulty, isSearchResult, mouseButton)

    -------------------------------------------------
    -- Shift+Click = Link In Chat
    --
    -- ChatEdit_InsertLink handles both cases on its
    -- own: inserting into an already-open chat line,
    -- or opening one if none is active -- the same
    -- standard helper every other item/spell link in
    -- the game uses, rather than reimplementing it.
    -------------------------------------------------

    if IsShiftKeyDown()
    and not IsAltKeyDown()
    and not IsControlKeyDown() then

        local freshCached = ImpLoot.ItemCache:GetItem(itemID)

        if freshCached and freshCached.Link then
            ChatEdit_InsertLink(freshCached.Link)
        end

        return

    end

    -------------------------------------------------
    -- Ctrl+Click = Dressing Room
    -------------------------------------------------

    if IsControlKeyDown() then

        local freshCached = ImpLoot.ItemCache:GetItem(itemID)

        if freshCached and freshCached.Link and DressUpItemLink then
            DressUpItemLink(freshCached.Link)
        end

        return

    end

    -------------------------------------------------
    -- Compare Drawer Open = Alt-Click Fills Slots
    --
    -- While the compare drawer is open, the active
    -- wishlist is deactivated -- alt-click goes to
    -- the compare slots instead. Left = Slot 1,
    -- Right = Slot 2.
    -------------------------------------------------

    local compareDrawer = ImpLoot.UI.CompareDrawer

    if compareDrawer
    and compareDrawer.IsOpen
    and IsAltKeyDown() then

        local slotIndex = 1

        if mouseButton == "RightButton" then
            slotIndex = 2
        end

        local success, reason = ImpLoot.Compare:SetItem(slotIndex, button.ItemID)

        if not success then
            ImpLoot:Print("Couldn't add to Slot " .. slotIndex .. ": " .. tostring(reason))
        end

        return

    end

    -------------------------------------------------
    -- Right Click = Ignored Otherwise
    -------------------------------------------------

    if mouseButton == "RightButton" then
        return
    end

    -------------------------------------------------
    -- Alt + Left Click = Add to Active Wishlist,
    -- or to the Priority List staging area if
    -- Populate Mode is currently active
    -------------------------------------------------

    if IsAltKeyDown()
    and not IsShiftKeyDown() then

        if ImpLoot.LootCouncil:IsPopulateModeActive() then

            local cached = ImpLoot.ItemCache:GetItem(button.ItemID)
            local itemName = (cached and cached.Name) or item.Name

            local added = ImpLoot.LootCouncil:AddStagedItem(button.ItemID, itemName)

            if added then

                DEFAULT_CHAT_FRAME:AddMessage(
                    "|cff33ff99ImpLoot|r: Staged |cffffffff"
                    .. itemName
                    .. "|r for the priority list."
                )

                if ImpLoot.UI.PopulateModeBar then
                    ImpLoot.UI.PopulateModeBar:Refresh()
                end

            end

            return

        end

        local character = ImpLoot.Character:GetCurrent()
        local wishlist = ImpLoot.Wishlist:GetActive(character)

        if wishlist then

            local success = ImpLoot.Wishlist:AddItem(
                character,
                wishlist.Name,
                button.ItemID,
                ImpLoot.SelectedRaid,
                ImpLoot.SelectedBoss,
                selectedDifficulty
            )

            if success then

                DEFAULT_CHAT_FRAME:AddMessage(
                    "|cff33ff99ImpLoot|r: Added |cffffffff"
                    .. item.Name
                    .. "|r to wishlist |cff00ff00"
                    .. wishlist.Name
                    .. "|r."
                )

            end

        else

            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99ImpLoot|r: No active wishlist selected.")

        end

        return

    end

    self:ClearSearchFocus()

    -------------------------------------------------
    -- Normal Click
    -------------------------------------------------

    if isSearchResult then

        -------------------------------------------------
        -- Search Result = Navigate To Boss
        -------------------------------------------------

        if entry.Boss and entry.Difficulty then
            ImpLoot.UI.BossPanel:SelectBoss(entry.Boss, entry.Difficulty)
        else

            -------------------------------------------------
            -- Fallback
            -------------------------------------------------

            self:ShowLootItem(entry)

        end

    else

        -------------------------------------------------
        -- Normal Boss Loot = Show Loot Item
        -------------------------------------------------

        self:ShowLootItem(item)

    end

end

-------------------------------------------------
-- Refresh Cached Item
-------------------------------------------------

function LootPanel:RefreshItem(itemID)

    if not itemID then
        return
    end

    itemID = tonumber(itemID)

    if not itemID then
        return
    end

    for _, button in ipairs(self.Buttons) do

        if button.ItemID == itemID then

            local item = button.Item

            if not item then
                return
            end

            local cached = ImpLoot.ItemCache:GetItem(itemID)

            if not cached then
                return
            end

            -------------------------------------------------
            -- Update item icon
            -------------------------------------------------

            if cached.Texture then
                button.Icon:SetTexture(cached.Texture)
            end

            -------------------------------------------------
            -- Update item name
            -------------------------------------------------

            button.Text:SetText(cached.Name)

            -------------------------------------------------
            -- Update quality color
            -------------------------------------------------

            local r, g, b =
                ImpLoot.Theme:GetQualityColor(cached.Quality)

            button.Text:SetTextColor(r, g, b)

            -------------------------------------------------
            -- Update tooltip information
            -------------------------------------------------

            button.ItemLink = cached.Link

            return

        end

    end

end

-------------------------------------------------
-- Populate For Boss
-------------------------------------------------

function LootPanel:PopulateForBoss(boss)

    if not boss then
        return
    end

    self.Buttons = {}
    self:Clear()
    self:ResetLootHeaders()

    local Layout = ImpLoot.UI.Layout

    local selectedDifficulty =
        ImpLoot.UI.BossPanel:GetSelectedDifficulty()

    local selectedFaction =
        ImpLoot.UI.BossPanel:GetSelectedFaction()

    local selectedClass =
        ImpLoot.UI.BossPanel:GetSelectedClass()

    local function ItemMatchesSelectedClass(item)

        if not selectedClass then
            return true
        end

        if not item.Classes then
            return true
        end

        for _, className in ipairs(item.Classes) do

            if className == selectedClass then
                return true
            end

        end

        return false

    end

    -------------------------------------------------
    -- Vault of Archavon: Three Main Headings
    --
    -- Tier Tokens, PvP Season Gear, Non-Set Epics (the
    -- class-agnostic wrist/waist/feet accessories) --
    -- each of the first two sub-divided by spec where
    -- the class actually has more than one (e.g. Death
    -- Knight: Tanking / DPS). Everywhere else keeps the
    -- existing single-level BonusLootGroup behaviour
    -- (Ulduar's "Hard Mode Loot", Obsidian Sanctum's
    -- drake tiers, etc.) untouched.
    -------------------------------------------------

    local raid = ImpLoot.SelectedRaid
    local raidName = type(raid) == "table" and raid.Name or raid
    local isVoA = (raidName == "Vault of Archavon")

    local MAIN_ORDER = { "Tier Tokens", "PvP Season Gear", "Non-Set Epics" }

    local function ClassifyVoAItem(item)

        if item.Classes and #item.Classes > 1 then
            return "Non-Set Epics", nil
        end

        local main = "Tier Tokens"

        if item.Name:find("^Hateful")
        or item.Name:find("^Deadly")
        or item.Name:find("^Furious")
        or item.Name:find("^Relentless")
        or item.Name:find("^Wrathful") then

            main = "PvP Season Gear"

        end

        local sub = item.BonusLootGroup

        if sub == "Tier Tokens" or sub == "PvP Season Gear" then
            sub = nil
        end

        return main, sub

    end

    -------------------------------------------------
    -- Split Into The Base Loot Bucket + Any Named
    -- Bonus Loot Groups (e.g. Ulduar's "Hard Mode
    -- Loot", Obsidian Sanctum's three "Bonus Loot"
    -- drake tiers) -- in the order they first appear.
    -------------------------------------------------

    local baseBucket = { Label = nil, Items = {} }
    local buckets = { baseBucket }
    local bucketByLabel = {}

    -- VoA: nested main -> sub -> items
    local mainBuckets = {}
    local mainByLabel = {}

    local totalShown = 0

    for _, item in ipairs(boss.Loot) do

        local availableIn = item.AvailableIn

        if availableIn
        and availableIn[selectedDifficulty]
        and (not item.Faction or item.Faction == selectedFaction)
        and ItemMatchesSelectedClass(item) then

            totalShown = totalShown + 1

            if isVoA then

                local mainLabel, subLabel = ClassifyVoAItem(item)

                local main = mainByLabel[mainLabel]

                if not main then

                    main = { Label = mainLabel, Subs = {}, SubByLabel = {} }
                    mainByLabel[mainLabel] = main
                    table.insert(mainBuckets, main)

                end

                local subKey = subLabel or ""
                local sub = main.SubByLabel[subKey]

                if not sub then

                    sub = { Label = subLabel, Items = {} }
                    main.SubByLabel[subKey] = sub
                    table.insert(main.Subs, sub)

                end

                table.insert(sub.Items, item)

            else

                local label = item.BonusLootGroup
                local bucket = baseBucket

                if label then

                    bucket = bucketByLabel[label]

                    if not bucket then

                        bucket = { Label = label, Items = {} }
                        bucketByLabel[label] = bucket
                        table.insert(buckets, bucket)

                    end

                end

                table.insert(bucket.Items, item)

            end

        end

    end

    -------------------------------------------------
    -- Render A Grid Of Items, Starting At Row Y
    --
    -- Returns the Y position immediately after the
    -- last row rendered (i.e. where the next thing
    -- should start).
    -------------------------------------------------

    local function renderGrid(items, startY)

        for i, item in ipairs(items) do

            local column =
                (i - 1) %
                Layout.GridColumns

            local row =
                math.floor(
                    (i - 1) /
                    Layout.GridColumns
                )

            local x = column * (
                Layout.GridButtonWidth +
                Layout.GridColumnGap
            )

            local y = startY + row * (
                46 +
                Layout.GridRowGap
            )

            local button =
                self:CreateLootButton(
                    item,
                    x,
                    y
                )

            table.insert(self.Buttons, button)

            if ImpLoot.SelectedLoot == item then
                self:HighlightButton(button)
            end

        end

        local rowsUsed = math.ceil(#items / Layout.GridColumns)

        return startY + rowsUsed * (46 + Layout.GridRowGap)

    end

    -------------------------------------------------
    -- Render Every Bucket In Order
    -------------------------------------------------

    local y = 0
    local renderedAnything = false

    if isVoA then

        table.sort(mainBuckets, function(a, b)

            local rankA, rankB = 99, 99

            for i, label in ipairs(MAIN_ORDER) do
                if label == a.Label then rankA = i end
                if label == b.Label then rankB = i end
            end

            return rankA < rankB

        end)

        for _, main in ipairs(mainBuckets) do

            if renderedAnything then
                y = y + 6
            end

            local mainHeader = self:AcquireLootHeader()

            mainHeader:ClearAllPoints()
            mainHeader:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 4, -y)
            mainHeader:SetFontObject(GameFontNormal)
            mainHeader:SetText(main.Label)
            mainHeader:Show()

            y = y + 20
            renderedAnything = true

            local showSubHeadings = (#main.Subs > 1)
                or (main.Subs[1] and main.Subs[1].Label)

            for _, sub in ipairs(main.Subs) do

                if showSubHeadings and sub.Label then

                    local subHeader = self:AcquireLootHeader()

                    subHeader:ClearAllPoints()
                    subHeader:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 14, -y)
                    subHeader:SetFontObject(GameFontHighlightSmall)
                    subHeader:SetText(sub.Label)
                    subHeader:Show()

                    y = y + 16

                end

                if #sub.Items > 0 then
                    y = renderGrid(sub.Items, y)
                end

            end

        end

    else

        for _, bucket in ipairs(buckets) do

            if bucket.Label then

                if renderedAnything then
                    y = y + 6
                end

                local header = self:AcquireLootHeader()

                header:ClearAllPoints()
                header:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 4, -y)
                header:SetFontObject(GameFontNormal)
                header:SetText(bucket.Label)
                header:Show()

                y = y + 20

            end

            if #bucket.Items > 0 then
                y = renderGrid(bucket.Items, y)
                renderedAnything = true
            end

        end

    end

    -------------------------------------------------
    -- Set Scroll Content Height
    -------------------------------------------------

    if totalShown > 0 then
        self:UpdateScrollChildHeight(y)
    else
        self:UpdateScrollChildHeight(1)
    end

    self:UpdateCompareDimming()

end

-------------------------------------------------
-- Update Class Dropdown
--
-- Shows/hides the Vault of Archavon class dropdown
-- based on the currently selected raid.
-------------------------------------------------

function LootPanel:UpdateClassDropdown()

    if not self.ClassDropdown then
        return
    end

    local raid = ImpLoot.SelectedRaid
    local raidName = type(raid) == "table" and raid.Name or raid

    if raidName == "Vault of Archavon" then

        self.ClassDropdown:Show()

        if UIDropDownMenu_SetText then
            UIDropDownMenu_SetText(self.ClassDropdown, ImpLoot.SelectedClass)
        end

    else

        self.ClassDropdown:Hide()

    end

end

-------------------------------------------------
-- Loot Section Headers
--
-- A grow-as-needed pool of FontStrings for section
-- headings ("Hard Mode Loot"), reset (all hidden) at
-- the start of every PopulateForBoss.
-------------------------------------------------

function LootPanel:ResetLootHeaders()

    self.HeaderWidgets = self.HeaderWidgets or {}
    self.HeaderWidgetCursor = 0

    for _, header in ipairs(self.HeaderWidgets) do
        header:Hide()
    end

end

function LootPanel:AcquireLootHeader()

    self.HeaderWidgetCursor = self.HeaderWidgetCursor + 1

    local header = self.HeaderWidgets[self.HeaderWidgetCursor]

    if not header then

        header = self.ScrollChild:CreateFontString(
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
-- Update Compare Dimming
--
-- While the compare drawer is open with exactly one
-- slot filled, grey out any loot button that can't
-- go in the other slot -- wrong equip slot, or not
-- equippable gear at all (mounts, tier tokens).
-------------------------------------------------

function LootPanel:UpdateCompareDimming()

    if not self.Buttons then
        return
    end

    local compareDrawer = ImpLoot.UI.CompareDrawer

    local anchorItemID = nil

    if compareDrawer and compareDrawer.IsOpen then

        local slot1 = ImpLoot.Compare:GetSlot(1)
        local slot2 = ImpLoot.Compare:GetSlot(2)

        local filled1 = slot1 and slot1.ItemID
        local filled2 = slot2 and slot2.ItemID

        if filled1 and not filled2 then
            anchorItemID = slot1.ItemID
        elseif filled2 and not filled1 then
            anchorItemID = slot2.ItemID
        end

    end

    for _, button in ipairs(self.Buttons) do

        local dimmed = false

        if compareDrawer and compareDrawer.IsOpen then

            if not ImpLoot.Compare:IsEquippable(button.Item) then

                dimmed = true

            elseif anchorItemID
            and button.ItemID
            and not ImpLoot.Compare:SlotsAreCompatible(anchorItemID, button.ItemID) then

                dimmed = true

            end

        end

        local alpha = 1

        if dimmed then
            alpha = 0.35
        end

        button.Icon:SetAlpha(alpha)
        button.Text:SetAlpha(alpha)
        button.TypeText:SetAlpha(alpha)

    end

end

-------------------------------------------------
-- Populate Trash
-------------------------------------------------

function LootPanel:PopulateTrash()

    self.Buttons = {}
    self:Clear()
    self:ResetLootHeaders()

    local raid = ImpLoot.SelectedRaid

    if not raid or not raid.Trash then
        return
    end

    local selectedDifficulty =
        ImpLoot.UI.BossPanel:GetSelectedDifficulty()

    local Layout = ImpLoot.UI.Layout

    local displayIndex = 0

    for _, item in ipairs(raid.Trash) do

        local availableIn = item.AvailableIn

        if availableIn
        and availableIn[selectedDifficulty] then

            displayIndex = displayIndex + 1

            local column =
                (displayIndex - 1) % Layout.GridColumns

            local row =
                math.floor(
                    (displayIndex - 1) /
                    Layout.GridColumns
                )

            local x = column * (
                Layout.GridButtonWidth +
                Layout.GridColumnGap
            )

            local y = row * (
                46 +
                Layout.GridRowGap
            )

            local button =
                self:CreateLootButton(item, x, y)

            table.insert(
                self.Buttons,
                button
            )

            if ImpLoot.SelectedLoot == item then
                self:HighlightButton(button)
            end

        end

    end

end

-------------------------------------------------
-- Populate Extra Drops
-------------------------------------------------

function LootPanel:PopulateExtraDrops()

    self.Buttons = {}
    self:Clear()
    self:ResetLootHeaders()

    local raid = ImpLoot.SelectedRaid

    if not raid or not raid.ExtraDrops then
        return
    end

    local selectedDifficulty =
        ImpLoot.UI.BossPanel:GetSelectedDifficulty()

    local Layout = ImpLoot.UI.Layout

    local displayIndex = 0

    for _, item in ipairs(raid.ExtraDrops) do

        local availableIn = item.AvailableIn

        if availableIn
        and availableIn[selectedDifficulty] then

            displayIndex = displayIndex + 1

            local column =
                (displayIndex - 1) % Layout.GridColumns

            local row =
                math.floor(
                    (displayIndex - 1) /
                    Layout.GridColumns
                )

            local x = column * (
                Layout.GridButtonWidth +
                Layout.GridColumnGap
            )

            local y = row * (
                46 +
                Layout.GridRowGap
            )

            local button =
                self:CreateLootButton(item, x, y)

            table.insert(
                self.Buttons,
                button
            )

            if ImpLoot.SelectedLoot == item then
                self:HighlightButton(button)
            end

        end

    end

end

-------------------------------------------------
-- Populate Search Results
-------------------------------------------------

function LootPanel:PopulateSearchResults(results)

    self:Clear()
    self:ResetLootHeaders()

    if not results or #results == 0 then
        self:UpdateScrollChildHeight(1)
        return
    end

    local Layout = ImpLoot.UI.Layout

    local columns = Layout.GridColumns or 3
    local buttonWidth = Layout.GridButtonWidth
    local columnGap = Layout.GridColumnGap

    local rowHeight = 46
    local rowGap = Layout.GridRowGap or 6

    for index, result in ipairs(results) do

        local column =
            (index - 1) % columns

        local row =
            math.floor(
                (index - 1) /
                columns
            )

        local x =
            column * (
                buttonWidth +
                columnGap
            )

        local y =
            row * (
                rowHeight +
                rowGap
            )

        self:CreateLootButton(
            result,
            x,
            y,
            true
        )

    end

    -------------------------------------------------
    -- Set Scroll Content Height
    -------------------------------------------------

    local rows =
        math.floor(
            (#results - 1) /
            columns
        ) + 1

    local contentHeight =
        rows * rowHeight +
        (rows - 1) * rowGap

    self:UpdateScrollChildHeight(
        contentHeight
    )

end

-------------------------------------------------
-- Highlight Button
-------------------------------------------------

function LootPanel:HighlightButton(selectedButton)

    for _, button in ipairs(self.Buttons) do

        button.Selected = false

        button.Background:SetVertexColor(0, 0, 0, 0)

    end

    selectedButton.Selected = true

    selectedButton.Background:SetVertexColor(0.20, 0.45, 0.80, 0.35)

end

-------------------------------------------------
-- Clear Selection
-------------------------------------------------

function LootPanel:ClearSelection()

    ImpLoot.SelectedLoot = nil

    for _, button in ipairs(self.Buttons) do

        button.Selected = false

        if button.Background then
            button.Background:SetVertexColor(0, 0, 0, 0)
        end

    end

    ImpLoot.UI.DetailsWorkspace:Clear()

end

-------------------------------------------------
-- Set Content Height
-------------------------------------------------

function LootPanel:SetContentHeight(height)

    if not height then
        return
    end

    self.Content:SetHeight(height)

end

-------------------------------------------------
-- Update Loot Scroll Content Height
-------------------------------------------------

function LootPanel:UpdateScrollChildHeight(height)

    if not height then
        height = 1
    end

    self.ScrollChild:SetHeight(height)

    self.Content:SetVerticalScroll(0)

    -------------------------------------------------
    -- Refresh ScrollFrame
    -------------------------------------------------

    if self.Content.UpdateScrollChildRect then
        self.Content:UpdateScrollChildRect()
    end

    if self.Content.UpdateScrollIndicators then
        self.Content:UpdateScrollIndicators()
    end

end