-------------------------------------------------
-- ImpLoot Options Panel
--
-- The real Interface > AddOns options screen --
-- everything below has accumulated real settings
-- over many sessions with no UI control anywhere
-- until now. One parent category ("ImpLoot") with
-- child categories, same registration pattern
-- LootHog itself uses.
--
-- Loot Council's per-item priority lists themselves
-- (the actual candidate configs) are NOT here --
-- those belong with the Loot Master window where
-- they're actually used. This panel only covers the
-- council roster and the disenchanter fallback list.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.OptionsPanel = ImpLoot.UI.OptionsPanel or {}
local OptionsPanel = ImpLoot.UI.OptionsPanel

-------------------------------------------------
-- Shared Row Helpers
--
-- Each returns the widget and the Y offset for the
-- NEXT row. Each widget gets a .RefreshFn the panel
-- calls on OnShow, so values stay correct even if
-- changed elsewhere (e.g. the Loot Master window's
-- own auto-assign checkbox).
-------------------------------------------------

local ROW_HEIGHT = 26
local ANNOUNCEMENT_BUTTON_WIDTH = 50
local ANNOUNCEMENT_BUTTON_HEIGHT = 18

-------------------------------------------------
-- Generate Widget Name
--
-- InputBoxTemplate (and UIDropDownMenuTemplate)
-- both do real internal work with a frame's global
-- name -- an unnamed one renders with only its
-- border-cap textures visible and no actual input
-- area, which is exactly the "missing text box"
-- symptom this fixes.
-------------------------------------------------

local widgetNameCounter = 0

local function GenerateWidgetName(prefix)
    widgetNameCounter = widgetNameCounter + 1
    return "ImpLootOptions" .. prefix .. widgetNameCounter
end

local function CreateCheckboxRow(parent, label, y, getValue, setValue)

    local check = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    check:SetPoint("TOPLEFT", 16, y)
    check:SetSize(24, 24)

    local text = check:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("LEFT", check, "RIGHT", 4, 0)
    text:SetText(label)

    check:SetScript("OnClick", function(self)
        setValue(self:GetChecked() and true or false)
    end)

    check.RefreshFn = function()
        check:SetChecked(getValue())
    end

    return check, y - ROW_HEIGHT

end

local function CreateNumberRow(parent, label, y, getValue, setValue)

    local text = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", 16, y)
    text:SetText(label)

    local box = CreateFrame("EditBox", GenerateWidgetName("NumberBox"), parent, "InputBoxTemplate")
    box:SetSize(50, 20)
    box:SetPoint("LEFT", text, "RIGHT", 10, 0)
    box:SetAutoFocus(false)
    box:SetNumeric(true)

    box:SetScript("OnTextChanged", function(self)

        local value = tonumber(self:GetText())

        if value then
            setValue(value)
        end

    end)

    box:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)

    box.RefreshFn = function()
        box:SetText(tostring(getValue() or 0))
    end

    return box, y - ROW_HEIGHT

end

local function CreateEditableMessageRow(parent, label, y, width, editButton, getValue, setValue)

    local text = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", 16, y)
    text:SetText(label)

    -------------------------------------------------
    -- View Mode: plain text showing the current
    -- message, not an always-live edit box. Sidesteps
    -- a real WoW client quirk entirely: InputBoxTemplate
    -- can fire a spurious OnTextChanged on its own
    -- init, possibly on a later frame -- late enough
    -- that a synchronous suppress-flag guard around
    -- creation has already reset by the time it lands,
    -- silently blanking the saved setting. This design
    -- never wires OnTextChanged to setValue at all, so
    -- that spurious event (whenever it fires) simply
    -- doesn't matter.
    --
    -- editButton is created and positioned by the
    -- caller (on the Enabled/Edit/Reset row above),
    -- not here -- this function only wires up its
    -- behavior.
    -------------------------------------------------

    local messageText = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    messageText:SetPoint("TOPLEFT", 16, y - 18)
    messageText:SetWidth(width or 260)
    messageText:SetJustifyH("LEFT")

    -------------------------------------------------
    -- Edit Mode: a real edit box, populated fresh with
    -- the current value the moment Edit is clicked --
    -- not on some earlier "OnShow" that may not have
    -- fired reliably.
    -------------------------------------------------

    local box = CreateFrame("EditBox", GenerateWidgetName("TextBox"), parent, "InputBoxTemplate")
    box:SetSize(width or 260, 20)
    box:SetPoint("TOPLEFT", 16, y - 18)
    box:SetAutoFocus(false)
    box:Hide()

    local saveButton = ImpLoot.Theme:CreateMenuButton(parent)
    saveButton:SetSize(ANNOUNCEMENT_BUTTON_WIDTH, ANNOUNCEMENT_BUTTON_HEIGHT)
    saveButton:SetPoint("TOPLEFT", editButton, "TOPLEFT", 0, 0)
    saveButton:SetText("Save")
    saveButton:Hide()

    local function EnterEditMode()

        box:SetText(getValue() or "")

        messageText:Hide()
        editButton:Hide()

        box:Show()
        saveButton:Show()

        box:SetFocus()

    end

    local function ExitEditMode()

        box:ClearFocus()
        box:Hide()
        saveButton:Hide()

        messageText:Show()
        editButton:Show()

    end

    local function SaveAndExit()

        setValue(box:GetText() or "")
        messageText:SetText(getValue() or "")

        ExitEditMode()

    end

    editButton:SetScript("OnClick", EnterEditMode)
    saveButton:SetScript("OnClick", SaveAndExit)

    box:SetScript("OnEnterPressed", function()
        SaveAndExit()
    end)

    box:SetScript("OnEscapePressed", function()
        ExitEditMode() -- cancel without saving
    end)

    messageText.RefreshFn = function()
        messageText:SetText(getValue() or "")
    end

    messageText.RefreshFn()

    messageText.EditButton = editButton
    messageText.SaveButton = saveButton
    messageText.Box = box

    return messageText, y - ROW_HEIGHT - 34

end

local CHANNEL_CHOICES = { "Auto", "AutoNoWarning", "Say", "Party", "Raid", "RaidWarning", "Guild", "Officer" }

local function CreateChoiceDropdown(parent, label, y, frameName, choices, getValue, setValue)

    local text = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", 16, y)
    text:SetText(label)

    local dropdown = CreateFrame("Frame", frameName, parent, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", text, "RIGHT", 0, -2)

    UIDropDownMenu_SetWidth(dropdown, 100)

    UIDropDownMenu_Initialize(dropdown, function(self, level)

        for _, choice in ipairs(choices) do

            local info = UIDropDownMenu_CreateInfo()

            info.text = choice
            info.checked = (getValue() == choice)

            info.func = function()
                setValue(choice)
                UIDropDownMenu_SetText(dropdown, choice)
            end

            UIDropDownMenu_AddButton(info, level)

        end

    end)

    dropdown.LabelText = text

    dropdown.RefreshFn = function()

        if UIDropDownMenu_SetText then
            UIDropDownMenu_SetText(dropdown, getValue())
        end

    end

    return dropdown, y - ROW_HEIGHT - 6

end

local function CreateChannelDropdown(parent, label, y, frameName, getValue, setValue)
    return CreateChoiceDropdown(parent, label, y, frameName, CHANNEL_CHOICES, getValue, setValue)
end

-------------------------------------------------
-- Panel Base
--
-- Every panel is a plain Frame with an .okay/refresh
-- convention: collects .RefreshFn-bearing widgets as
-- they're created, and calls them all on OnShow.
-------------------------------------------------

local function CreatePanel(name, parentName, title)

    local panel = CreateFrame("Frame")
    panel.name = name

    if parentName then
        panel.parent = parentName
    end

    local titleText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOPLEFT", 16, -16)
    titleText:SetText(title)

    panel.Widgets = {}

    panel:SetScript("OnShow", function()

        for _, widget in ipairs(panel.Widgets) do

            if widget.RefreshFn then
                widget.RefreshFn()
            end

        end

    end)

    return panel

end

-------------------------------------------------
-- Top-Level Panel
-------------------------------------------------

function OptionsPanel:BuildMainPanel()

    local panel = CreatePanel("ImpLoot", nil, "ImpLoot")

    local body = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    body:SetPoint("TOPLEFT", 16, -50)
    body:SetWidth(360)
    body:SetJustifyH("LEFT")
    body:SetText(
        "Loot management with Soft Reserve support.\n\n" ..
        "Use the categories on the left to configure Loot Master " ..
        "timing, Soft Reserve rules, announcement text and channels, " ..
        "and the Loot Council roster.\n\n" ..
        "|cffffd200Slash Commands|r\n" ..
        "|cffffffff/il|r -- toggle the main window\n" ..
        "|cffffffff/il <item link>|r -- manually add an item to the Loot Master queue\n" ..
        "|cffffffff/il config|r or |cffffffff/il options|r -- open this settings window\n" ..
        "|cffffffff/il reset|r -- reset all settings to default (asks for confirmation)\n" ..
        "|cffffffff/il help|r -- open this page"
    )

    local minimapWidget = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    minimapWidget:SetPoint("TOPLEFT", 16, -220)
    minimapWidget:SetSize(24, 24)

    local minimapLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    minimapLabel:SetPoint("LEFT", minimapWidget, "RIGHT", 4, 0)
    minimapLabel:SetText("Show minimap button")

    minimapWidget:SetScript("OnClick", function(self_)

        if ImpLoot.UI.MinimapButton then
            ImpLoot.UI.MinimapButton:SetShown(self_:GetChecked() and true or false)
        end

    end)

    minimapWidget.RefreshFn = function()

        if ImpLoot.UI.MinimapButton then
            minimapWidget:SetChecked(ImpLoot.UI.MinimapButton:IsShown())
        end

    end

    table.insert(panel.Widgets, minimapWidget)

    self.MainPanel = panel

    return panel

end

-------------------------------------------------
-- Loot Master Panel
-------------------------------------------------

function OptionsPanel:BuildLootMasterPanel()

    local panel = CreatePanel("Loot Master", "ImpLoot", "Loot Master")
    local Settings = ImpLoot.LootMaster.Settings

    local y = -50
    local widget

    widget, y = CreateNumberRow(panel, "Roll duration (seconds, 0 = off):", y,
        function() return Settings.RollDuration end,
        function(v) Settings.RollDuration = v end)
    table.insert(panel.Widgets, widget)

    -------------------------------------------------
    -- Countdown Timer Reminder (with its own disable
    -- checkbox, rather than only "0 = off" via the
    -- number field itself)
    -------------------------------------------------

    local lastCountdownInterval = (Settings.PeriodicAnnounceInterval > 0)
        and Settings.PeriodicAnnounceInterval or 10

    widget, y = CreateCheckboxRow(panel, "Countdown timer reminder every:", y,
        function() return Settings.PeriodicAnnounceInterval > 0 end,
        function(v)
            if v then
                Settings.PeriodicAnnounceInterval = lastCountdownInterval
            else
                if Settings.PeriodicAnnounceInterval > 0 then
                    lastCountdownInterval = Settings.PeriodicAnnounceInterval
                end
                Settings.PeriodicAnnounceInterval = 0
            end
        end)
    table.insert(panel.Widgets, widget)

    widget, y = CreateNumberRow(panel, "Reminder interval (seconds):", y,
        function() return Settings.PeriodicAnnounceInterval end,
        function(v)
            Settings.PeriodicAnnounceInterval = v
            if v > 0 then lastCountdownInterval = v end
        end)
    table.insert(panel.Widgets, widget)

    widget, y = CreateNumberRow(panel, "Final countdown starts at (seconds):", y,
        function() return Settings.FinalCountdownThreshold end,
        function(v) Settings.FinalCountdownThreshold = v end)
    table.insert(panel.Widgets, widget)

    y = y - 10

    widget, y = CreateCheckboxRow(panel, "Auto-finalize when the timer runs out", y,
        function() return Settings.AutoFinalizeOnTimeout end,
        function(v) Settings.AutoFinalizeOnTimeout = v end)
    table.insert(panel.Widgets, widget)

    widget, y = CreateCheckboxRow(panel, "Auto-assign to the roll winner", y,
        function() return Settings.AutoAssignToRollWinner end,
        function(v) Settings.AutoAssignToRollWinner = v end)
    table.insert(panel.Widgets, widget)

    widget, y = CreateCheckboxRow(panel, "Auto-clear the queue when the next boss is looted", y,
        function() return Settings.AutoClearOnNewBoss end,
        function(v) Settings.AutoClearOnNewBoss = v end)
    table.insert(panel.Widgets, widget)

    self.LootMasterPanel = panel

    return panel

end

-------------------------------------------------
-- Soft Reserve Panel
-------------------------------------------------

function OptionsPanel:BuildSoftReservePanel()

    local panel = CreatePanel("Soft Reserve", "ImpLoot", "Soft Reserve")

    local y = -50
    local widget

    widget, y = CreateCheckboxRow(panel, "Allow multiple reserves per item", y,
        function() return ImpLoot.SoftReserve:GetSettings().AllowMultipleReserves end,
        function(v) ImpLoot.SoftReserve:SetSetting("AllowMultipleReserves", v) end)
    table.insert(panel.Widgets, widget)

    widget, y = CreateCheckboxRow(panel, "Exclude previous winners on repeat drops", y,
        function() return ImpLoot.SoftReserve:GetSettings().ExcludePreviousWinners end,
        function(v) ImpLoot.SoftReserve:SetSetting("ExcludePreviousWinners", v) end)
    table.insert(panel.Widgets, widget)

    self.SoftReservePanel = panel

    return panel

end

-------------------------------------------------
-- Announcements Panel
--
-- One block per announcement type: Enabled checkbox,
-- text template, channel.
-------------------------------------------------

local ANNOUNCEMENT_LABELS = {
    OpenRollAnnounced = "Open Roll Announced",
    SoftReserveAnnounced = "Soft Reserve Roll Announced",
    WinnerAnnounced = "Winner Announced",
    EligibleClasses = "Eligible Classes",
    NoRollsDisenchant = "No Rolls (Disenchanter)",
    RollTimeRemaining = "Roll Time Remaining",
    RollCountdown = "Roll Countdown",
    LCVoteCalled = "Loot Council Vote Called",
    FunnelAssigned = "Funnel Assigned",
    PreselectedAnnounced = "Preselected Roll Announced",
}

local ANNOUNCEMENT_ORDER = {
    "OpenRollAnnounced", "SoftReserveAnnounced", "WinnerAnnounced", "EligibleClasses",
    "NoRollsDisenchant", "RollTimeRemaining", "RollCountdown", "LCVoteCalled", "FunnelAssigned",
    "PreselectedAnnounced",
}

function OptionsPanel:BuildAnnouncementsPanel()

    local panel = CreatePanel("Announcements", "ImpLoot", "Announcements")

    -------------------------------------------------
    -- Scrollable Content
    --
    -- 7 announcement types x 3 controls each is far
    -- taller than the fixed options viewport -- without
    -- this, content silently overflows past the
    -- window's own border instead of scrolling.
    -------------------------------------------------

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootOptionsAnnouncementsScroll",
        panel,
        "UIPanelScrollFrameTemplate"
    )

    scrollFrame:SetPoint("TOPLEFT", 16, -50)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 16)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetWidth(1)
    scrollChild:SetHeight(1)

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

    local y = 0

    for _, typeName in ipairs(ANNOUNCEMENT_ORDER) do

        local settings = ImpLoot.Announcements:GetSettings(typeName)
        local defaults = ImpLoot.Announcements.Defaults[typeName]

        if settings then

            local header = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            header:SetPoint("TOPLEFT", 0, y)
            header:SetText(ANNOUNCEMENT_LABELS[typeName] or typeName)

            y = y - 20

            -------------------------------------------------
            -- Enabled / Edit / Reset -- all on one row
            -------------------------------------------------

            local checkboxWidget = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
            checkboxWidget:SetPoint("TOPLEFT", 16, y)
            checkboxWidget:SetSize(24, 24)

            local checkLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            checkLabel:SetPoint("LEFT", checkboxWidget, "RIGHT", 4, 0)
            checkLabel:SetText("Enabled")

            checkboxWidget:SetScript("OnClick", function(self)
                settings.Enabled = self:GetChecked() and true or false
            end)

            checkboxWidget.RefreshFn = function()
                checkboxWidget:SetChecked(settings.Enabled)
            end
            checkboxWidget.RefreshFn()

            table.insert(panel.Widgets, checkboxWidget)

            local editButton = ImpLoot.Theme:CreateMenuButton(scrollChild)
            editButton:SetSize(ANNOUNCEMENT_BUTTON_WIDTH, ANNOUNCEMENT_BUTTON_HEIGHT)
            editButton:SetPoint("LEFT", checkLabel, "RIGHT", 12, 0)
            editButton:SetText("Edit")

            local resetButton = nil

            if defaults then

                resetButton = ImpLoot.Theme:CreateMenuButton(scrollChild)
                resetButton:SetSize(ANNOUNCEMENT_BUTTON_WIDTH, ANNOUNCEMENT_BUTTON_HEIGHT)
                resetButton:SetPoint("LEFT", editButton, "RIGHT", 6, 0)
                resetButton:SetText("Reset")

            end

            y = y - ROW_HEIGHT

            -------------------------------------------------
            -- Text
            -------------------------------------------------

            local textWidget, channelWidget

            textWidget, y = CreateEditableMessageRow(scrollChild, "Text:", y, 300, editButton,
                function() return settings.Text end,
                function(v) settings.Text = v end)
            table.insert(panel.Widgets, textWidget)

            channelWidget, y = CreateChannelDropdown(scrollChild, "Channel:", y,
                "ImpLootOptionsChannelDropdown" .. typeName,
                function() return settings.Channel end,
                function(v) settings.Channel = v end)
            table.insert(panel.Widgets, channelWidget)

            if resetButton and defaults then

                resetButton:SetScript("OnClick", function()

                    ImpLoot.Announcements:SetEnabled(typeName, defaults.Enabled)
                    ImpLoot.Announcements:SetText(typeName, defaults.Text)
                    ImpLoot.Announcements:SetChannel(typeName, defaults.Channel)

                    checkboxWidget.RefreshFn()
                    textWidget.RefreshFn()
                    channelWidget.RefreshFn()

                end)

            end

            y = y - 14

        end

    end

    scrollChild:SetWidth(340)
    scrollChild:SetHeight(math.abs(y) + 10)

    if scrollFrame.UpdateScrollIndicators then
        scrollFrame:UpdateScrollIndicators()
    end

    self.AnnouncementsPanel = panel

    return panel

end

-------------------------------------------------
-- Loot Council Panel
--
-- Roster and disenchanter fallback list only -- the
-- per-item priority lists themselves live in the Loot
-- Master window, not here.
-------------------------------------------------

function OptionsPanel:BuildLootCouncilPanel()

    local panel = CreatePanel("Loot Council", "ImpLoot", "Loot Council")

    -------------------------------------------------
    -- Members
    -------------------------------------------------

    local membersHeader = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    membersHeader:SetPoint("TOPLEFT", 16, -50)
    membersHeader:SetText("Council Members")

    local memberBox = CreateFrame("EditBox", GenerateWidgetName("MemberBox"), panel, "InputBoxTemplate")
    memberBox:SetSize(112, 20)
    memberBox:SetPoint("TOPLEFT", 16, -72)
    memberBox:SetAutoFocus(false)
    self.MemberBox = memberBox

    local memberAddButton = ImpLoot.Theme:CreateMenuButton(panel)
    memberAddButton:SetSize(50, 20)
    memberAddButton:SetPoint("LEFT", memberBox, "RIGHT", 6, 0)
    memberAddButton:SetText("Add")

    memberAddButton:SetScript("OnClick", function()

        local name = memberBox:GetText()

        if name and name ~= "" then

            ImpLoot.LootCouncil:AddMember(name)
            memberBox:SetText("")
            self:RefreshCouncilLists()

        end

    end)

    self.MemberRows = {}
    self.MemberListTop = -100

    -------------------------------------------------
    -- Disenchanters
    -------------------------------------------------

    local disenchantHeader = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    disenchantHeader:SetPoint("TOPLEFT", 200, -50)
    disenchantHeader:SetText("Disenchanters (in priority order)")

    local disenchantBox = CreateFrame("EditBox", GenerateWidgetName("DisenchantBox"), panel, "InputBoxTemplate")
    disenchantBox:SetSize(112, 20)
    disenchantBox:SetPoint("TOPLEFT", 200, -72)
    disenchantBox:SetAutoFocus(false)
    self.DisenchantBox = disenchantBox

    local disenchantAddButton = ImpLoot.Theme:CreateMenuButton(panel)
    disenchantAddButton:SetSize(50, 20)
    disenchantAddButton:SetPoint("LEFT", disenchantBox, "RIGHT", 6, 0)
    disenchantAddButton:SetText("Add")

    disenchantAddButton:SetScript("OnClick", function()

        local name = disenchantBox:GetText()

        if name and name ~= "" then

            local current = {}

            for _, entry in ipairs(ImpLoot.LootCouncil:GetDisenchanters()) do
                table.insert(current, entry.Name)
            end

            table.insert(current, name)

            ImpLoot.LootCouncil:SetDisenchanters(current)
            disenchantBox:SetText("")
            self:RefreshCouncilLists()

        end

    end)

    self.DisenchantRows = {}
    self.DisenchantListTop = -100

    panel:HookScript("OnShow", function()
        self:RefreshCouncilLists()
    end)

    self.LootCouncilPanel = panel

    return panel

end

-------------------------------------------------
-- Refresh Council Lists (Dynamic Rows)
--
-- Rebuilds both name lists -- called on panel show,
-- and again after every add/remove so the list stays
-- current without needing to close and reopen the
-- panel.
-------------------------------------------------

function OptionsPanel:RefreshCouncilLists()

    local panel = self.LootCouncilPanel

    if not panel then
        return
    end

    for _, row in ipairs(self.MemberRows) do
        row:Hide()
    end

    for _, row in ipairs(self.DisenchantRows) do
        row:Hide()
    end

    local y = self.MemberListTop

    for i, name in ipairs(ImpLoot.LootCouncil:GetMembers()) do

        local row = self.MemberRows[i]

        if not row then

            row = CreateFrame("Frame", nil, panel)
            row:SetSize(160, 20)

            row.Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.Text:SetPoint("LEFT", 0, 0)

            row.RemoveButton = CreateFrame("Button", nil, row)
            row.RemoveButton:SetSize(14, 14)
            row.RemoveButton:SetPoint("LEFT", row.Text, "RIGHT", 6, 0)
            row.RemoveText = row.RemoveButton:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
            row.RemoveText:SetAllPoints()
            row.RemoveText:SetText("x")

            self.MemberRows[i] = row

        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 16, y)
        row.Text:SetText(name)

        row.RemoveButton:SetScript("OnClick", function()
            ImpLoot.LootCouncil:RemoveMember(name)
            self:RefreshCouncilLists()
        end)

        row:Show()

        y = y - 20

    end

    y = self.DisenchantListTop

    for i, entry in ipairs(ImpLoot.LootCouncil:GetDisenchanters()) do

        local row = self.DisenchantRows[i]

        if not row then

            row = CreateFrame("Frame", nil, panel)
            row:SetSize(160, 20)

            row.Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.Text:SetPoint("LEFT", 0, 0)

            row.RemoveButton = CreateFrame("Button", nil, row)
            row.RemoveButton:SetSize(14, 14)
            row.RemoveButton:SetPoint("LEFT", row.Text, "RIGHT", 6, 0)
            row.RemoveText = row.RemoveButton:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
            row.RemoveText:SetAllPoints()
            row.RemoveText:SetText("x")

            self.DisenchantRows[i] = row

        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 200, y)
        row.Text:SetText(i .. ". " .. entry.Name)

        row.RemoveButton:SetScript("OnClick", function()

            local remaining = {}

            for j, e in ipairs(ImpLoot.LootCouncil:GetDisenchanters()) do
                if j ~= i then table.insert(remaining, e.Name) end
            end

            ImpLoot.LootCouncil:SetDisenchanters(remaining)
            self:RefreshCouncilLists()

        end)

        row:Show()

        y = y - 20

    end

end

-------------------------------------------------
-- Window Layering Panel
-------------------------------------------------

function OptionsPanel:BuildWindowLayeringPanel()

    local panel = CreatePanel("Window Layering", "ImpLoot", "Window Layering")

    local intro = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    intro:SetPoint("TOPLEFT", 16, -40)
    intro:SetWidth(360)
    intro:SetJustifyH("LEFT")
    intro:SetText(
        "Choose which layer each ImpLoot window renders on, if " ..
        "it's overlapping another addon's window and you'd like " ..
        "one to sit above or below the other. Higher layers " ..
        "(further down this list) always render above lower ones."
    )

    -- the intro wraps across several lines at this width -- measure
    -- its actual rendered height rather than guessing a fixed gap,
    -- so the first dropdown never overlaps it even if the text
    -- above is edited later and wraps differently
    local introHeight = intro:GetStringHeight() or 56

    local y = -40 - introHeight - 20
    local widget

    for _, entry in ipairs(ImpLoot.WindowLayering.WINDOWS) do

        widget, y = CreateChoiceDropdown(
            panel,
            entry.Label .. ":",
            y,
            "ImpLootWindowStrata" .. entry.Key,
            ImpLoot.WindowLayering.VALID_STRATA,
            function() return ImpLoot.WindowLayering:GetStrata(entry.Key) end,
            function(v) ImpLoot.WindowLayering:SetStrata(entry.Key, v) end
        )

        table.insert(panel.Widgets, widget)

    end

    self.WindowLayeringPanel = panel
    panel.IntroText = intro

    return panel

end

-------------------------------------------------
-- About Panel
-------------------------------------------------

function OptionsPanel:BuildAboutPanel()

    local panel = CreatePanel("About", "ImpLoot", "About ImpLoot")

    local body = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    body:SetPoint("TOPLEFT", 16, -50)
    body:SetWidth(360)
    body:SetJustifyH("LEFT")
    body:SetText(
        "ImpLoot -- loot management with Soft Reserve and Loot Council support.\n\n" ..
        "A Loot Council vote for a Class-type candidate slot (e.g. \"Any Warrior\") " ..
        "resolves to whichever specific player the loot master assigns it to -- " ..
        "the addon doesn't pick one automatically.\n\n" ..
        "To set a hotkey for opening the Loot Master window, use the Key Bindings " ..
        "menu (Game Menu > Key Bindings) -- look for the \"ImpLoot\" category.\n\n" ..
        "Wishlists, priority lists, and everything else ImpLoot saves are only " ..
        "written to disk on a proper logout, /reload, or exiting normally through " ..
        "the game menu. Alt-F4 or a crash skips that step entirely, same as any " ..
        "other addon or Blizzard's own UI settings -- so anything created since " ..
        "your last logout/reload won't be there next time. A quick /reload after " ..
        "finishing something you don't want to risk losing is a cheap safety net."
    )

    self.AboutPanel = panel

    return panel

end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function OptionsPanel:Initialize()

    local mainPanel = self:BuildMainPanel()
    local lootMasterPanel = self:BuildLootMasterPanel()
    local softReservePanel = self:BuildSoftReservePanel()
    local announcementsPanel = self:BuildAnnouncementsPanel()
    local lootCouncilPanel = self:BuildLootCouncilPanel()
    local windowLayeringPanel = self:BuildWindowLayeringPanel()
    local aboutPanel = self:BuildAboutPanel()

    InterfaceOptions_AddCategory(mainPanel)
    InterfaceOptions_AddCategory(lootMasterPanel)
    InterfaceOptions_AddCategory(softReservePanel)
    InterfaceOptions_AddCategory(announcementsPanel)
    InterfaceOptions_AddCategory(lootCouncilPanel)
    InterfaceOptions_AddCategory(windowLayeringPanel)
    InterfaceOptions_AddCategory(aboutPanel)

end

-------------------------------------------------
-- Open
--
-- Jumps straight to the ImpLoot category, for the
-- in-window "Settings" menu shortcut.
-------------------------------------------------

function OptionsPanel:Open()

    if InterfaceOptionsFrame_OpenToCategory then

        -- called twice to work around a long-standing
        -- Blizzard bug where the first call sometimes
        -- opens to the wrong (top of list) category
        InterfaceOptionsFrame_OpenToCategory(self.MainPanel)
        InterfaceOptionsFrame_OpenToCategory(self.MainPanel)

    end

end
