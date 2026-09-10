-------------------------------------------------
-- Boss Panel
--
-- The left-hand column: raid selector + scrollable boss
-- list. Every frame this panel creates is stored on
-- itself (self.Frame, self.Content, self.Buttons) --
-- nothing here is a bare file-scope local, so nothing is
-- at risk of going out of reach if this file gets split
-- further later.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.BossPanel = ImpLoot.UI.BossPanel or {}
local BossPanel = ImpLoot.UI.BossPanel

-------------------------------------------------
-- Initialize
-------------------------------------------------

function BossPanel:Initialize(mainWindowFrame, header)

    local Layout = ImpLoot.UI.Layout

    local frame = CreateFrame("Frame", nil, mainWindowFrame)
    self.Frame = frame

    frame:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -Layout.Padding)
    frame:SetPoint("BOTTOMLEFT", mainWindowFrame, "BOTTOMLEFT", Layout.Padding, Layout.StatusHeight + Layout.Padding)
    frame:SetWidth(Layout.BossPanelWidth)

    -------------------------------------------------
    -- Raid Selector
    -------------------------------------------------

    local raidSelector = CreateFrame(
        "Frame",
        "ImpLootRaidDropDown",
        frame,
        "UIDropDownMenuTemplate"
    )

    self.RaidSelector = raidSelector

    raidSelector:SetPoint("TOPLEFT", frame, "TOPLEFT", -8, 0)

    UIDropDownMenu_SetWidth(raidSelector, Layout.BossPanelWidth - 34)

    UIDropDownMenu_Initialize(raidSelector, function(dropdown, level)

        for _, raid in ipairs(ImpLoot.Database:GetRaidsInReleaseOrder()) do

            local info = UIDropDownMenu_CreateInfo()

            info.text = raid.Name
            info.checked = (ImpLoot.SelectedRaid == raid)

            info.func = function()

                ImpLoot.SelectedRaid = raid
                ImpLoot.SelectedBoss = nil

                UIDropDownMenu_SetText(raidSelector, raid.Name)

                self:Populate()

                ImpLoot.UI.LootPanel:Clear()

            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    -------------------------------------------------
    -- Raid Size Toggle
    -------------------------------------------------

    local raidSizeToggle = ImpLoot.Theme:CreateMenuButton(frame)
    self.RaidSizeToggle = raidSizeToggle

    raidSizeToggle:SetSize(65, 22)
    raidSizeToggle:SetPoint("TOPLEFT", raidSelector, "BOTTOMLEFT", 16, -8)

    self.RaidSize = 10

    raidSizeToggle:SetText("10 Man")

    raidSizeToggle:SetScript("OnClick", function()
        if self.RaidSize == 10 then
            self.RaidSize = 25
            raidSizeToggle:SetText("25 Man")
        else
            self.RaidSize = 10
            raidSizeToggle:SetText("10 Man")
        end

        if ImpLoot.SelectedBoss then

            ImpLoot.UI.LootPanel:PopulateForBoss(
                ImpLoot.SelectedBoss
            )

        elseif self.TrashButton and self.TrashButton.Selected then

            ImpLoot.UI.LootPanel:PopulateTrash()

        end
    end)

    -------------------------------------------------
    -- Difficulty Toggle
    --
    -- Doubles as the Horde/Alliance toggle for Trial of
    -- the Crusader, which has no true Heroic mode --
    -- that raid tracks a separate Faction state instead,
    -- purely to pick which faction's loot list to show.
    -------------------------------------------------

    local difficultyToggle = ImpLoot.Theme:CreateMenuButton(frame)
    self.DifficultyToggle = difficultyToggle

    difficultyToggle:SetSize(65, 22)
    difficultyToggle:SetPoint("LEFT", raidSizeToggle, "RIGHT", 4, 0)

    self.Difficulty = "Normal"
    self.Faction = "Horde"

    difficultyToggle:SetText("Normal")

    difficultyToggle:SetScript("OnClick", function()

        local raid = ImpLoot.SelectedRaid
        local raidName = type(raid) == "table" and raid.Name or raid

        if raidName == "Trial of the Crusader"
            or raidName == "Vault of Archavon" then

            if self.Faction == "Horde" then
                self.Faction = "Alliance"
            else
                self.Faction = "Horde"
            end

            difficultyToggle:SetText(self.Faction)

        else

            if self.Difficulty == "Normal" then
                self.Difficulty = "Heroic"
                difficultyToggle:SetText("Heroic")
            else
                self.Difficulty = "Normal"
                difficultyToggle:SetText("Normal")
            end

        end

        if ImpLoot.SelectedBoss then

            ImpLoot.UI.LootPanel:PopulateForBoss(
                ImpLoot.SelectedBoss
            )

        elseif self.TrashButton and self.TrashButton.Selected then

            ImpLoot.UI.LootPanel:PopulateTrash()

        end
    end)

    difficultyToggle:Hide()

    -------------------------------------------------
    -- The Vault of Archavon class dropdown lives in
    -- LootPanel now (top of the loot window, next to
    -- the "Loot" title) -- see LootPanel:Initialize.
    -- self.SelectedClass is set there via
    -- ImpLoot.SelectedClass.
    -------------------------------------------------

    self:UpdateDifficultyToggle()

    -------------------------------------------------
    -- Get Selected Raid Difficulty
    -------------------------------------------------

    function BossPanel:GetSelectedDifficulty()

        if self.RaidSize == 10 then

            if self.Difficulty == "Heroic" then
                return "10 Heroic"
            end

            return "10"

        elseif self.RaidSize == 25 then

            if self.Difficulty == "Heroic" then
                return "25 Heroic"
            end

            return "25"

        end

        return "10"

    end

    -------------------------------------------------
    -- Get Selected Faction
    --
    -- Only meaningful for Trial of the Crusader --
    -- everything else ignores this.
    -------------------------------------------------

    function BossPanel:GetSelectedFaction()

        -- Manual Horde/Alliance toggle for both raids that need
        -- it (Trial of the Crusader's champions, Koralon's
        -- faction-locked tier tokens in Vault of Archavon).
        -- Not auto-detected from the player's own faction --
        -- cross-faction servers may not gate this loot the same
        -- way, so showing both on request is the safer default.
        return self.Faction or "Horde"

    end

    -------------------------------------------------
    -- Get Selected Class
    --
    -- Only meaningful for Vault of Archavon -- nil
    -- everywhere else, so the class filter in
    -- LootPanel is a no-op for other raids.
    -------------------------------------------------

    function BossPanel:GetSelectedClass()

        local raid = ImpLoot.SelectedRaid
        local raidName = type(raid) == "table" and raid.Name or raid

        if raidName ~= "Vault of Archavon" then
            return nil
        end

        return ImpLoot.SelectedClass

    end

    -------------------------------------------------
    -- Select Boss Programmatically
    -------------------------------------------------

    function BossPanel:SelectBoss(boss, difficulty)

        if not boss then
            return
        end

        -------------------------------------------------
        -- Set Raid Size / Difficulty
        -------------------------------------------------

        if difficulty == "10"
        or difficulty == "10 Heroic" then

            self.RaidSize = 10

        elseif difficulty == "25"
        or difficulty == "25 Heroic" then

            self.RaidSize = 25

        else

            return

        end

        if difficulty == "10 Heroic"
        or difficulty == "25 Heroic" then

            self.Difficulty = "Heroic"

        else

            self.Difficulty = "Normal"

        end

        -------------------------------------------------
        -- Update Toggle Text
        -------------------------------------------------

        if self.RaidSizeToggle then

            if self.RaidSize == 10 then
                self.RaidSizeToggle:SetText("10 Man")
            else
                self.RaidSizeToggle:SetText("25 Man")
            end

        end

        if self.DifficultyToggle then

            if self.Difficulty == "Heroic" then
                self.DifficultyToggle:SetText("Heroic")
            else
                self.DifficultyToggle:SetText("Normal")
            end

        end

        -------------------------------------------------
        -- Select Boss
        -------------------------------------------------

        ImpLoot.SelectedRaid = boss.Raid

        ImpLoot.SelectedBoss = boss

        -- Rebuild the boss list for this raid -- we may
        -- have just switched raids entirely (e.g. via a
        -- wishlist click), and without this the button
        -- list on screen is still the PREVIOUS raid's,
        -- so HighlightForBoss below finds nothing to
        -- highlight and the raid dropdown never updates.
        self:Populate()

        local pendingLootSelection = ImpLoot.PendingLootSelection
        ImpLoot.PendingLootSelection = nil

        self:UpdateDifficultyToggle()

        -------------------------------------------------
        -- Highlight Boss
        -------------------------------------------------

        self:HighlightForBoss(boss)

        -------------------------------------------------
        -- Populate Boss Loot
        -------------------------------------------------

        ImpLoot.UI.LootPanel:ClearSelection()
        ImpLoot.UI.LootPanel:ClearSearchFocus()

        -- ClearSelection() above wipes SelectedLoot, so restore
        -- the pending item after it, right before we populate.
        ImpLoot.SelectedLoot = pendingLootSelection

        ImpLoot.UI.LootPanel:PopulateForBoss(
            boss
        )

    end

    -------------------------------------------------
    -- Title
    -------------------------------------------------

    local bossTitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    self.BossTitle = bossTitle
    bossTitle:SetPoint("TOPLEFT", raidSizeToggle, "BOTTOMLEFT", 0, -8)
    bossTitle:SetText("Bosses")

    -------------------------------------------------
    -- Boss Content
    -------------------------------------------------

    local content = CreateFrame("Frame", nil, frame)
    self.Content = content

    content:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -58)
    content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 6)

    self.Buttons = {}

end

-------------------------------------------------
-- Select Trash
--
-- Mirrors SelectBoss, but for navigating straight to
-- a raid's Trash view (e.g. clicking a trash-dropped
-- item from the wishlist) -- may need to switch raids
-- entirely first, so the boss list gets rebuilt before
-- looking for that raid's own Trash button to highlight.
-------------------------------------------------

function BossPanel:SelectTrash(raid, difficulty)

    if not raid then
        return
    end

    if difficulty == "10"
    or difficulty == "10 Heroic" then

        self.RaidSize = 10

    elseif difficulty == "25"
    or difficulty == "25 Heroic" then

        self.RaidSize = 25

    else

        return

    end

    if difficulty == "10 Heroic"
    or difficulty == "25 Heroic" then

        self.Difficulty = "Heroic"

    else

        self.Difficulty = "Normal"

    end

    if self.RaidSizeToggle then

        if self.RaidSize == 10 then
            self.RaidSizeToggle:SetText("10 Man")
        else
            self.RaidSizeToggle:SetText("25 Man")
        end

    end

    ImpLoot.SelectedRaid = raid
    ImpLoot.SelectedBoss = nil

    local pendingLootSelection = ImpLoot.PendingLootSelection
    ImpLoot.PendingLootSelection = nil

    -- rebuild the boss list for this raid (we may have
    -- just switched raids entirely), so self.TrashButton
    -- below actually refers to THIS raid's trash button
    self:Populate()

    if self.DifficultyToggle then

        if self.Difficulty == "Heroic" then
            self.DifficultyToggle:SetText("Heroic")
        else
            self.DifficultyToggle:SetText("Normal")
        end

    end

    self:UpdateDifficultyToggle()

    if self.TrashButton then
        self:Highlight(self.TrashButton)
    end

    ImpLoot.UI.LootPanel:ClearSelection()
    ImpLoot.UI.LootPanel:ClearSearchFocus()

    ImpLoot.SelectedLoot = pendingLootSelection

    ImpLoot.UI.LootPanel:PopulateTrash()

end

-------------------------------------------------
-- Clear Content
-------------------------------------------------

local function ClearContent(content)

    local children = { content:GetChildren() }

    for _, child in ipairs(children) do
        child:Hide()
        child:SetParent(nil)
    end

end

-------------------------------------------------
-- Update Difficulty Toggle Visibility
-------------------------------------------------

function BossPanel:UpdateDifficultyToggle()

    if not self.DifficultyToggle then
        return
    end

    local raid = ImpLoot.SelectedRaid
    local raidName = nil

    if type(raid) == "table" then
        raidName = raid.Name
    else
        raidName = raid
    end

    if ImpLoot.UI.LootPanel
    and ImpLoot.UI.LootPanel.UpdateClassDropdown then

        ImpLoot.UI.LootPanel:UpdateClassDropdown()

    end

    if raidName == "Trial of the Crusader" then

        self.DifficultyToggle:Show()
        self.DifficultyToggle:SetText(self.Faction or "Horde")

    elseif raidName == "Vault of Archavon" then

        -- Only Koralon has faction-specific loot -- the toggle
        -- would just be dead weight on the other three bosses.
        local boss = ImpLoot.SelectedBoss

        if boss and boss.Name == "Koralon the Flame Watcher" then

            self.DifficultyToggle:Show()
            self.DifficultyToggle:SetText(self.Faction or "Horde")

        else

            self.DifficultyToggle:Hide()

        end

    elseif raidName == "Icecrown Citadel"
        or raidName == "Ruby Sanctum" then

        self.DifficultyToggle:Show()
        self.DifficultyToggle:SetText(self.Difficulty or "Normal")

    else

        self.DifficultyToggle:Hide()

    end

end

-------------------------------------------------
-- Populate
-------------------------------------------------

function BossPanel:Populate()

    self.Buttons = {}
    ClearContent(self.Content)

    local raid = ImpLoot.SelectedRaid

    if not raid then

        -------------------------------------------------
        -- Fall Back To Last Selected Raid, Then First
        -------------------------------------------------

        local character = ImpLoot.Character:GetCurrent()

        if character and character.SelectedRaid then
            raid = ImpLoot.Database:GetRaid(character.SelectedRaid)
        end

        if not raid then

            local raids = ImpLoot.Database:GetRaids()

            raid = raids[1]

        end

    end

    if not raid then
        return
    end

    ImpLoot.SelectedRaid = raid

    -------------------------------------------------
    -- Remember This Choice For Next Time
    -------------------------------------------------

    local character = ImpLoot.Character:GetCurrent()

    if character then
        character.SelectedRaid = raid.Name
    end

    if UIDropDownMenu_SetText and self.RaidSelector then
        UIDropDownMenu_SetText(self.RaidSelector, raid.Name)
    end

    self:UpdateDifficultyToggle()

    local Layout = ImpLoot.UI.Layout
    local y = -30

    for _, boss in ipairs(raid.Bosses) do

        local button = CreateFrame("Button", nil, self.Content)

        button:SetWidth(Layout.BossPanelWidth - 12)
        button:SetHeight(Layout.ListButtonHeight)
        button:SetPoint("TOPLEFT", 6, y)

        local bg = button:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\Buttons\\WHITE8X8")
        bg:SetVertexColor(0, 0, 0, 0)
        button.Background = bg

        button.Selected = false
        button.Boss = boss

        local text = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        text:SetAllPoints()
        text:SetJustifyH("CENTER")
        text:SetText(boss.Name)

        button:SetScript("OnClick", function()

            ImpLoot.UI.LootPanel:ClearSelection()
            ImpLoot.UI.LootPanel:ClearSearchFocus()

            ImpLoot.SelectedRaid = raid
            ImpLoot.SelectedBoss = boss
            ImpLoot.SelectedLoot = nil

            self:UpdateDifficultyToggle()

            self:Highlight(button)

            ImpLoot.UI.LootPanel:PopulateForBoss(boss)

        end)

        button:SetScript("OnEnter", function()
            if not button.Selected then
                button.Background:SetVertexColor(0.35, 0.35, 0.35, 0.20)
            end
        end)

        button:SetScript("OnLeave", function()
            if not button.Selected then
                button.Background:SetVertexColor(0, 0, 0, 0)
            end
        end)

                table.insert(self.Buttons, button)

        y = y - 20

    end

    -------------------------------------------------
    -- Trash
    --
    -- Only shown for raids that actually have trash
    -- loot tracked (Obsidian Sanctum, Eye of Eternity,
    -- Trial of the Crusader, and Ruby Sanctum don't).
    -------------------------------------------------

    self.TrashButton = nil

    if raid.Trash and #raid.Trash > 0 then

        y = y - 40

        local trashButton = CreateFrame("Button", nil, self.Content)

        trashButton:SetWidth(Layout.BossPanelWidth - 12)
        trashButton:SetHeight(Layout.ListButtonHeight)
        trashButton:SetPoint("TOPLEFT", 6, y)

        local trashBackground = trashButton:CreateTexture(nil, "BACKGROUND")
        trashBackground:SetAllPoints()
        trashBackground:SetTexture("Interface\\Buttons\\WHITE8X8")
        trashBackground:SetVertexColor(0, 0, 0, 0)
        trashButton.Background = trashBackground

        trashButton.Selected = false
        trashButton.IsTrash = true

        local trashText = trashButton:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        trashText:SetAllPoints()
        trashText:SetJustifyH("CENTER")
        trashText:SetText("Trash")

        trashButton:SetScript("OnEnter", function()
            if not trashButton.Selected then
                trashButton.Background:SetVertexColor(0.35, 0.35, 0.35, 0.20)
            end
        end)

        trashButton:SetScript("OnLeave", function()
            if not trashButton.Selected then
                trashButton.Background:SetVertexColor(0, 0, 0, 0)
            end
        end)

        trashButton:SetScript("OnClick", function()

            self:Highlight(trashButton)

            ImpLoot.SelectedBoss = nil
            ImpLoot.SelectedLoot = nil

            ImpLoot.UI.LootPanel:PopulateTrash()

        end)

        self.TrashButton = trashButton

        table.insert(self.Buttons, trashButton)

    end

end

-------------------------------------------------
-- Highlight
-------------------------------------------------

function BossPanel:Highlight(selectedButton)

    for _, button in ipairs(self.Buttons) do
        button.Selected = false
        button.Background:SetVertexColor(0, 0, 0, 0)
    end

    selectedButton.Selected = true
    selectedButton.Background:SetVertexColor(0.20, 0.45, 0.80, 0.35)

end

-------------------------------------------------
-- Highlight For Boss
--
-- Used when a boss is selected indirectly (e.g. clicking
-- a search result), rather than via its own button.
-------------------------------------------------

function BossPanel:HighlightForBoss(boss)

    for _, button in ipairs(self.Buttons) do

        if button.Boss == boss then
            self:Highlight(button)
            return
        end

    end

end
