-------------------------------------------------
-- Loot Master Window
--
-- The visible queue built on top of Modules/LootMaster.
-- Refreshes reactively off the "LootQueueChanged" event
-- rather than polling, and can be attached to the real
-- Blizzard loot frame or left floating -- either way it
-- survives the corpse's loot window closing (tracking
-- mode), since that's the whole point of the queue.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.LootMasterWindow = ImpLoot.UI.LootMasterWindow or {}
local LootMasterWindow = ImpLoot.UI.LootMasterWindow

-------------------------------------------------
-- Global Toggle (for the hotkey -- see bindings.xml)
-------------------------------------------------

function ImpLoot_ToggleLootMasterWindow()

    if ImpLoot.UI.LootMasterWindow then
        ImpLoot.UI.LootMasterWindow:Toggle()
    end

end

-------------------------------------------------
-- Layout Constants
-------------------------------------------------

local WINDOW_WIDTH = 340
local WINDOW_HEIGHT = 420
local ROW_HEIGHT = 46
local ROW_GAP = 6
local HEADER_HEIGHT = 18
local GROUP_GAP = 8

-------------------------------------------------
-- Initialize
-------------------------------------------------

function LootMasterWindow:Initialize()

    ImpLootDB.LootMasterWindow = ImpLootDB.LootMasterWindow or {
        Attached = true,
    }

    self.WindowState = ImpLootDB.LootMasterWindow

    -------------------------------------------------
    -- Frame
    -------------------------------------------------

    local frame = CreateFrame("Frame", "ImpLootLootMasterFrame", UIParent)
    self.Frame = frame

    frame:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
    frame:SetPoint("CENTER", 250, 0)

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

    titleBar:SetScript("OnDragStart", function()

        if not self.WindowState.Attached then
            frame:StartMoving()
        end

    end)

    titleBar:SetScript("OnDragStop", function()

        frame:StopMovingOrSizing()

        local point, _, _, x, y = frame:GetPoint()

        self.WindowState.Point = point
        self.WindowState.X = x
        self.WindowState.Y = y

    end)

    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", 4, 0)
    title:SetTextColor(
        ImpLoot.Theme.Colors.Text[1],
        ImpLoot.Theme.Colors.Text[2],
        ImpLoot.Theme.Colors.Text[3]
    )
    title:SetText("Loot master")

    -------------------------------------------------
    -- Attach / Float Toggle
    -------------------------------------------------

    local attachButton = CreateFrame("Button", nil, titleBar)
    attachButton:SetSize(16, 16)
    attachButton:SetPoint("RIGHT", -22, 0)

    local attachIcon = attachButton:CreateTexture(nil, "ARTWORK")
    attachIcon:SetAllPoints()
    attachIcon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")

    attachButton:SetScript("OnClick", function()
        self:SetAttached(not self.WindowState.Attached)
    end)

    attachButton:SetScript("OnEnter", function()
        GameTooltip:SetOwner(attachButton, "ANCHOR_TOP")
        GameTooltip:SetText("Attach to loot window / float freely")
        GameTooltip:Show()
    end)

    attachButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    self.AttachButton = attachButton

    -------------------------------------------------
    -- Close Button + Hotkey Hint
    -------------------------------------------------

    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", 2, 0)

    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    -------------------------------------------------
    -- Auto-Assign Checkbox
    -------------------------------------------------

    local autoAssignCheck = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    autoAssignCheck:SetSize(18, 18)
    autoAssignCheck:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 2, -6)

    local autoAssignLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    autoAssignLabel:SetPoint("LEFT", autoAssignCheck, "RIGHT", 2, 0)
    autoAssignLabel:SetText("Auto-assign to roll winner")

    autoAssignCheck:SetScript("OnClick", function(button)
        ImpLoot.LootMaster.Settings.AutoAssignToRollWinner = button:GetChecked() and true or false
    end)

    self.AutoAssignCheck = autoAssignCheck

    local summaryButton = ImpLoot.Theme:CreateMenuButton(frame)
    summaryButton:SetSize(70, 20)
    summaryButton:SetPoint("TOPLEFT", autoAssignCheck, "BOTTOMLEFT", -2, -6)
    summaryButton:SetText("Summary")

    summaryButton:SetScript("OnClick", function()
        ImpLoot.UI.SummaryWindow:Toggle()
    end)

    self.SummaryButton = summaryButton

    local priorityButton = ImpLoot.Theme:CreateMenuButton(frame)
    priorityButton:SetSize(90, 20)
    priorityButton:SetPoint("LEFT", summaryButton, "RIGHT", 4, 0)
    priorityButton:SetText("Priority Lists")

    priorityButton:SetScript("OnClick", function()
        ImpLoot.UI.LootPriorityWindow:Toggle()
    end)

    self.PriorityButton = priorityButton

    local clearAllButton = ImpLoot.Theme:CreateMenuButton(frame)
    clearAllButton:SetSize(65, 20)
    clearAllButton:SetPoint("LEFT", priorityButton, "RIGHT", 4, 0)
    clearAllButton:SetText("Clear All")

    clearAllButton:SetScript("OnClick", function()
        ImpLoot.LootMaster:ClearQueue()
    end)

    self.ClearAllButton = clearAllButton

    -------------------------------------------------
    -- Scroll Content
    -------------------------------------------------

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        "ImpLootLootMasterScrollFrame",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    self.ScrollFrame = scrollFrame

    scrollFrame:SetPoint("TOPLEFT", summaryButton, "BOTTOMLEFT", 2, -8)
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

    -------------------------------------------------
    -- Widget Pools
    -------------------------------------------------

    self.HeaderWidgets = {}
    self.RowWidgets = {}

    -------------------------------------------------
    -- React To Queue Changes
    -------------------------------------------------

    ImpLoot.Events:Register("LootQueueChanged", function()
        self:Refresh()
    end)

    -------------------------------------------------
    -- React To Timer Ticks (countdown display only,
    -- not a full Refresh)
    -------------------------------------------------

    ImpLoot.Events:Register("LootTimerTick", function()
        self:UpdateAllTimerTexts()
    end)

    -------------------------------------------------
    -- Auto-Show On Loot Opened
    --
    -- Only for the actual master looter -- anyone else
    -- who loots the corpse (trash, or under a looser
    -- loot method) shouldn't have this pop open on
    -- their screen.
    -------------------------------------------------

    local autoShowFrame = CreateFrame("Frame")
    autoShowFrame:RegisterEvent("LOOT_OPENED")

    autoShowFrame:SetScript("OnEvent", function()

        if ImpLoot.LootMaster:IsMasterLooter() then
            self:Show()
        end

    end)

    self.AutoShowFrame = autoShowFrame

    self:UpdateAutoAssignCheckbox()
    self:Refresh()

end

-------------------------------------------------
-- Set Attached
--
-- Attached mode pins the window to the real Blizzard
-- loot frame (LootFrame) so it sits right alongside
-- it while looting a corpse. Floating mode restores
-- wherever it was last dragged to.
-------------------------------------------------

function LootMasterWindow:SetAttached(attached)

    self.WindowState.Attached = attached

    self:RepositionFrame()

end

function LootMasterWindow:RepositionFrame()

    self.Frame:ClearAllPoints()

    if self.WindowState.Attached and LootFrame then

        self.Frame:SetPoint("TOPLEFT", LootFrame, "TOPRIGHT", 8, 0)

    elseif self.WindowState.Point then

        self.Frame:SetPoint(
            self.WindowState.Point,
            UIParent,
            self.WindowState.Point,
            self.WindowState.X or 0,
            self.WindowState.Y or 0
        )

    else

        self.Frame:SetPoint("CENTER", 250, 0)

    end

end

-------------------------------------------------
-- Show / Hide / Toggle
-------------------------------------------------

function LootMasterWindow:Show()

    self:RepositionFrame()
    self:Refresh()
    self.Frame:Show()

end

function LootMasterWindow:Hide()
    self.Frame:Hide()
end

function LootMasterWindow:Toggle()

    if self.Frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end

end

-------------------------------------------------
-- Update Auto-Assign Checkbox (reflect saved setting)
-------------------------------------------------

function LootMasterWindow:UpdateAutoAssignCheckbox()

    if self.AutoAssignCheck then
        self.AutoAssignCheck:SetChecked(
            ImpLoot.LootMaster.Settings.AutoAssignToRollWinner
        )
    end

end

-------------------------------------------------
-- Format Standings
--
-- "#1 Testing -- 88 MS" style, one line per roll,
-- already in descending order from the module.
-------------------------------------------------

function LootMasterWindow:FormatStandings(entry)

    if #entry.Rolls == 0 then
        return "No rolls yet."
    end

    local lines = {}

    for i, roll in ipairs(entry.Rolls) do

        table.insert(lines, string.format(
            "#%d %s -- %d %s",
            i, roll.Player, roll.Roll, roll.Type
        ))

    end

    return table.concat(lines, "\n")

end

-------------------------------------------------
-- Acquire Header / Row (Widget Pools)
-------------------------------------------------

function LootMasterWindow:AcquireHeader(index)

    local header = self.HeaderWidgets[index]

    if not header then

        header = self.ScrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        header:SetTextColor(
            ImpLoot.Theme.Colors.Text[1],
            ImpLoot.Theme.Colors.Text[2],
            ImpLoot.Theme.Colors.Text[3]
        )
        header:SetJustifyH("LEFT")

        self.HeaderWidgets[index] = header

    end

    return header

end

function LootMasterWindow:AcquireRow(index)

    local row = self.RowWidgets[index]

    if row then
        return row
    end

    row = CreateFrame("Frame", nil, self.ScrollChild)
    row:SetHeight(ROW_HEIGHT)

    ImpLoot.Theme:ApplyPanelStyle(row)

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(28, 28)
    icon:SetPoint("TOPLEFT", 4, -4)
    row.Icon = icon

    -------------------------------------------------
    -- Icon Hover Tooltip
    --
    -- Textures can't have OnEnter/OnLeave scripts in
    -- this client -- an invisible button overlaid on
    -- the icon catches the hover instead. Reads
    -- row.Entry at hover time (not creation time), so
    -- a reused row always shows the tooltip for
    -- whatever item currently occupies it.
    -------------------------------------------------

    local iconButton = CreateFrame("Button", nil, row)
    iconButton:SetAllPoints(icon)
    row.IconButton = iconButton

    iconButton:SetScript("OnEnter", function(self_)

        if row.Entry and row.Entry.ItemLink then

            GameTooltip:SetOwner(self_, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(row.Entry.ItemLink)
            GameTooltip:Show()

        end

    end)

    iconButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    nameText:SetPoint("TOPLEFT", icon, "TOPRIGHT", 6, -1)
    nameText:SetJustifyH("LEFT")
    row.NameText = nameText

    local infoText = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    infoText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -3)
    infoText:SetJustifyH("LEFT")
    infoText:SetWidth(150)
    row.InfoText = infoText

    local actionButton = ImpLoot.Theme:CreateMenuButton(row)
    actionButton:SetSize(70, 20)
    actionButton:SetPoint("TOPRIGHT", -4, -4)
    row.ActionButton = actionButton

    -------------------------------------------------
    -- Assign-Among-Tied Dropdown
    --
    -- Shown instead of the plain Assign button when a
    -- Priority mode item's current tier has more than
    -- one candidate still in it (linked slots, e.g.
    -- "Prio 1 = Prio 2 = Prio 3") -- lets the loot master
    -- pick specifically who wins among the tied names,
    -- rather than the addon silently grabbing the first
    -- one in the list.
    -------------------------------------------------

    local tieDropdown = CreateFrame(
        "Frame",
        "ImpLootLootMasterTieDropdown" .. index,
        row,
        "UIDropDownMenuTemplate"
    )

    tieDropdown:SetPoint("TOPRIGHT", -14, -2)
    UIDropDownMenu_SetWidth(tieDropdown, 90)
    UIDropDownMenu_SetText(tieDropdown, "Assign to...")
    tieDropdown:Hide()
    row.TieDropdown = tieDropdown

    -------------------------------------------------
    -- Timer Text
    --
    -- Live remaining-seconds display while a roll is
    -- active, so the loot master can see how much time
    -- is left without waiting on a reminder announcement.
    -- Updated in place by the "LootTimerTick" event, not
    -- rebuilt on every full Refresh().
    -------------------------------------------------

    local timerText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    timerText:SetPoint("RIGHT", actionButton, "LEFT", -6, 0)
    timerText:Hide()
    row.TimerText = timerText

    local removeButton = CreateFrame("Button", nil, row)
    removeButton:SetSize(14, 14)
    removeButton:SetPoint("BOTTOMRIGHT", -4, 4)

    local removeText = removeButton:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    removeText:SetAllPoints()
    removeText:SetText("x")
    row.RemoveButton = removeButton

    self.RowWidgets[index] = row

    return row

end

-------------------------------------------------
-- Reset Widgets
-------------------------------------------------

function LootMasterWindow:ResetWidgets()

    for _, header in ipairs(self.HeaderWidgets) do
        header:Hide()
    end

    for _, row in ipairs(self.RowWidgets) do
        row:Hide()
    end

end

-------------------------------------------------
-- Populate Row
--
-- Wires the row's single action button based on the
-- entry's Mode/State. Loot Council items get an LC
-- Vote button that isn't wired up yet (no vote engine
-- built) -- clicking it just says so plainly rather
-- than pretending to work.
-------------------------------------------------

function LootMasterWindow:PopulateRow(row, entry)

    row.Entry = entry

    local cached = ImpLoot.ItemCache:GetItem(entry.ItemID)

    local displayName = (cached and cached.Name)
        or entry.ItemLink
        or ("Item " .. entry.ItemID)

    if cached and cached.Texture then
        row.Icon:SetTexture(cached.Texture)
    else
        row.Icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end

    local r, g, b = ImpLoot.Theme:GetQualityColor(cached and cached.Quality)
    row.NameText:SetText(displayName)
    row.NameText:SetTextColor(r, g, b)

    -------------------------------------------------
    -- Legendary Item Border
    --
    -- A visible warning before the loot master even
    -- clicks anything -- a Legendary drop's row gets an
    -- orange border instead of the normal panel style,
    -- so it stands out in the queue as needing extra
    -- care (it's also the one tier that pauses for
    -- manual confirmation before assigning -- see
    -- RequestAssign in LootMaster.lua).
    -------------------------------------------------

    local itemQuality = ImpLoot.LootMaster:GetItemQuality(entry.ItemID)

    if itemQuality == 5 then
        local lr, lg, lb = ImpLoot.Theme:GetQualityColor(5)
        row:SetBackdropBorderColor(lr, lg, lb, 1)
    else
        row:SetBackdropBorderColor(
            ImpLoot.Theme.Colors.Border[1],
            ImpLoot.Theme.Colors.Border[2],
            ImpLoot.Theme.Colors.Border[3],
            ImpLoot.Theme.Colors.Border[4]
        )
    end

    row.ActionButton:Hide()
    row.ActionButton:SetScript("OnClick", nil)
    row.TieDropdown:Hide()
    row.TimerText:Hide()

    -------------------------------------------------
    -- Loot Council
    --
    -- Preselected is the one LC mode that's excluded
    -- here -- it's a real roll under the hood (just
    -- restricted to specific candidates), so it falls
    -- through to the same Pending/Rolling/RollComplete/
    -- Resolved state machine every other roll-based item
    -- uses, rather than the Funnel/Priority/Vote display
    -- below.
    -------------------------------------------------

    local lcListName = entry.Mode == "LootCouncil" and ImpLoot.LootCouncil:GetActiveListName()
    local lcCouncilItem = lcListName and ImpLoot.LootCouncil:GetItem(lcListName, entry.ItemID)

    if entry.Mode == "LootCouncil" and lcCouncilItem and lcCouncilItem.Mode ~= "Preselected" then

        local listName = lcListName
        local councilItem = lcCouncilItem

        if councilItem and councilItem.Mode == "Funnel" then

            -------------------------------------------------
            -- Funnel Mode
            --
            -- Every drop goes to whoever's in candidate slot
            -- 1 -- no voting, and unlike Priority, a win never
            -- removes them. The only way the recipient changes
            -- is the loot master manually editing this item's
            -- candidates in the Loot Priority window.
            -------------------------------------------------

            local candidates = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)
            local first = candidates[1]

            if not first then

                row.InfoText:SetText("No one assigned to funnel this to -- set slot 1 in Loot Priority.")
                row.ActionButton:Hide()

            elseif first.Type == "Class" then

                row.InfoText:SetText("Funneling to: Any " .. first.Value)
                row.ActionButton:Hide()

            else

                row.InfoText:SetText("Funneling to: " .. first.Value)

                row.ActionButton:SetText("Assign")
                row.ActionButton:Show()

                row.ActionButton:SetScript("OnClick", function()

                    local currentCandidates = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)
                    local currentFirst = currentCandidates[1]

                    if not currentFirst or currentFirst.Type ~= "Player" then
                        ImpLoot:Print("No player assigned to funnel " .. displayName .. " to.")
                        return
                    end

                    ImpLoot.LootMaster:RequestAssign(entry.QueueID, currentFirst.Value)

                end)

            end

        elseif councilItem and councilItem.Mode == "Priority" then

            -------------------------------------------------
            -- Priority Mode
            --
            -- No voting involved -- the list's own order
            -- (grouped into tiers by any linked slots) already
            -- decides who's next. Show that order, grouping
            -- tied names with "=" and tiers with ">", and let
            -- the loot master assign straight to the current
            -- tier's candidate -- or, if more than one name is
            -- still tied in that tier, pick specifically who
            -- via a small dropdown instead of the addon
            -- silently grabbing the first one.
            -------------------------------------------------

            local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)

            if #remaining == 0 then

                row.InfoText:SetText("Priority list exhausted -- assign manually via /il or trade.")
                row.ActionButton:Hide()
                row.TieDropdown:Hide()

            else

                -------------------------------------------------
                -- Build Display Text, Grouped By Tier
                -------------------------------------------------

                local function CandidateLabel(candidate)

                    local label

                    if candidate.Type == "Class" then
                        label = "Any " .. candidate.Value
                        if candidate.Spec then
                            label = label .. " (" .. candidate.Spec .. ")"
                        end
                    else
                        label = candidate.Value
                    end

                    -- Multi-piece Legendary components (Fragment of
                    -- Val'anyr, etc.) get a running tally next to
                    -- each candidate's name -- how many of this
                    -- exact item they've already won this session,
                    -- so whoever's assigning has that context in
                    -- view without needing to check the Summary
                    -- window separately.
                    if itemQuality == 5 and candidate.Type == "Player" then

                        local priorCount = ImpLoot.LootMaster:GetPlayerItemCount(candidate.Value, entry.ItemID)

                        if priorCount > 0 then
                            label = label .. " (" .. priorCount .. " so far)"
                        end

                    end

                    return label

                end

                local tierGroups = {}
                local tierOrder = {}
                local seenTiers = {}

                for i, candidate in ipairs(remaining) do

                    local tier = candidate.Tier or i

                    if not seenTiers[tier] then
                        seenTiers[tier] = true
                        table.insert(tierOrder, tier)
                        tierGroups[tier] = {}
                    end

                    table.insert(tierGroups[tier], CandidateLabel(candidate))

                end

                local tierTexts = {}

                for _, tier in ipairs(tierOrder) do
                    table.insert(tierTexts, table.concat(tierGroups[tier], " = "))
                end

                row.InfoText:SetText("Priority: " .. table.concat(tierTexts, " > "))

                -------------------------------------------------
                -- Assign Action -- Single Candidate Vs A Tie
                -------------------------------------------------

                local currentTier = ImpLoot.LootCouncil:GetCurrentTierCandidates(listName, entry.ItemID)

                local function AssignTo(candidate)

                    if candidate.Type == "Class" then
                        ImpLoot:Print(
                            "Any " .. candidate.Value .. " is next in priority for " .. displayName ..
                            " -- assign it to a specific player via /il or trade."
                        )
                        return
                    end

                    ImpLoot.LootMaster:RequestAssign(entry.QueueID, candidate.Value)

                end

                if #currentTier <= 1 then

                    row.TieDropdown:Hide()

                    row.ActionButton:SetText("Assign")
                    row.ActionButton:Show()

                    row.ActionButton:SetScript("OnClick", function()

                        local liveTier = ImpLoot.LootCouncil:GetCurrentTierCandidates(listName, entry.ItemID)

                        if #liveTier == 0 then
                            ImpLoot:Print("Priority list exhausted for " .. displayName .. ".")
                            return
                        end

                        AssignTo(liveTier[1])

                    end)

                else

                    row.ActionButton:Hide()
                    row.TieDropdown:Show()

                    UIDropDownMenu_Initialize(row.TieDropdown, function(self_, level)

                        local liveTier = ImpLoot.LootCouncil:GetCurrentTierCandidates(listName, entry.ItemID)

                        for _, candidate in ipairs(liveTier) do

                            local info = UIDropDownMenu_CreateInfo()
                            info.text = CandidateLabel(candidate)

                            info.func = function()
                                UIDropDownMenu_SetText(row.TieDropdown, "Assign to...")
                                AssignTo(candidate)
                            end

                            UIDropDownMenu_AddButton(info, level)

                        end

                    end)

                end

            end

        elseif entry.State == "Voting" then

            local tally = ImpLoot.LootMaster:GetVoteTally(entry.QueueID)
            local lines = {}

            for _, t in ipairs(tally) do
                table.insert(lines, t.Value .. " -- " .. t.Count .. (t.Count == 1 and " vote" or " votes"))
            end

            row.InfoText:SetText(#lines > 0 and table.concat(lines, "\n") or "Voting -- no votes yet.")

            row.ActionButton:SetText("Assign")
            row.ActionButton:Show()

            row.ActionButton:SetScript("OnClick", function()

                local currentTally = ImpLoot.LootMaster:GetVoteTally(entry.QueueID)

                if #currentTally == 0 then
                    ImpLoot:Print("No votes yet for " .. displayName .. ".")
                    return
                end

                local top = currentTally[1]

                if top.Type == "Class" then
                    ImpLoot:Print(
                        "Any " .. top.Value .. " won the vote for " .. displayName ..
                        " -- assign it to a specific player via /il or trade."
                    )
                    return
                end

                ImpLoot.LootMaster:RequestAssign(entry.QueueID, top.Value)

            end)

        else

            row.InfoText:SetText("Loot Council item")

            row.ActionButton:SetText("LC Vote")
            row.ActionButton:Show()

            row.ActionButton:SetScript("OnClick", function()

                local ok, msg = ImpLoot.LootMaster:CallVote(entry.QueueID)

                if not ok then
                    ImpLoot:Print(msg)
                end

            end)

        end

    -------------------------------------------------
    -- Not Yet Announced
    -------------------------------------------------

    elseif entry.State == "Pending" then

        if entry.Mode == "SoftReserve" then

            row.InfoText:SetText(
                "Reserved by:\n" .. ImpLoot.LootMaster:FormatReserverList(entry.ItemID)
            )

        elseif entry.Mode == "LootCouncil" and lcCouncilItem then

            local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(lcListName, entry.ItemID)
            local names = {}

            for _, candidate in ipairs(remaining) do

                if candidate.Type == "Class" then
                    local label = "Any " .. candidate.Value
                    if candidate.Spec then
                        label = label .. " (" .. candidate.Spec .. ")"
                    end
                    table.insert(names, label)
                else
                    table.insert(names, candidate.Value)
                end

            end

            if #names == 0 then
                row.InfoText:SetText("Preselected: no one left -- edit candidates in Loot Priority.")
            else
                row.InfoText:SetText("Preselected: " .. table.concat(names, ", "))
            end

        else

            row.InfoText:SetText("No SoftRes")

        end

        row.ActionButton:SetText(entry.Mode == "SoftReserve" and "Announce" or "Open Roll")
        row.ActionButton:Show()

        row.ActionButton:SetScript("OnClick", function()

            local ok, msg = ImpLoot.LootMaster:AnnounceItem(entry.QueueID)

            if not ok then
                ImpLoot:Print(msg)
            end

        end)

    -------------------------------------------------
    -- Currently Rolling
    -------------------------------------------------

    elseif entry.State == "Rolling" then

        row.InfoText:SetText(self:FormatStandings(entry))

        row.ActionButton:SetText("Stop")
        row.ActionButton:Show()

        row.ActionButton:SetScript("OnClick", function()
            ImpLoot.LootMaster:FinalizeRoll(entry.QueueID)
        end)

        if entry.RollEndTime then

            row.TimerText:Show()
            self:UpdateRowTimerText(row)

        end

    -------------------------------------------------
    -- Roll Complete, Awaiting Manual Assign
    -------------------------------------------------

    elseif entry.State == "RollComplete" then

        row.InfoText:SetText(self:FormatStandings(entry))

        row.ActionButton:SetText("Assign")
        row.ActionButton:Show()

        row.ActionButton:SetScript("OnClick", function()

            local top = ImpLoot.LootMaster:GetTopRoll(entry.QueueID)

            if top then
                ImpLoot.LootMaster:RequestAssign(entry.QueueID, top.Player)
            else
                ImpLoot:Print("No rolls came in for " .. displayName .. " -- assign it manually via /il or trade it directly.")
            end

        end)

    -------------------------------------------------
    -- Resolved
    -------------------------------------------------

    elseif entry.State == "Resolved" then

        local winnerLine = "Winner: " .. (entry.Winner or "?")

        if entry.TradeOnly then
            winnerLine = winnerLine .. " (trade it)"
        end

        row.InfoText:SetText(winnerLine)

    end

    -------------------------------------------------
    -- Remove Button (always available)
    -------------------------------------------------

    row.RemoveButton:SetScript("OnClick", function()
        ImpLoot.LootMaster:RemoveFromQueue(entry.QueueID)
    end)

    row:Show()

end

-------------------------------------------------
-- Update Row Timer Text
--
-- Sets a single row's countdown number from its
-- entry's RollEndTime. Split out from the tick-driven
-- bulk update below so PopulateRow can also call it
-- once immediately (no need to wait for the next tick
-- to show a number).
-------------------------------------------------

function LootMasterWindow:UpdateRowTimerText(row)

    if not row.Entry
    or row.Entry.State ~= "Rolling"
    or not row.Entry.RollEndTime then

        row.TimerText:Hide()
        return

    end

    local remaining = row.Entry.RollEndTime - GetTime()

    if remaining <= 0 then
        row.TimerText:SetText("0")
    else
        row.TimerText:SetText(tostring(math.ceil(remaining)))
    end

    row.TimerText:Show()

end

-------------------------------------------------
-- Update All Timer Texts
--
-- Driven by the "LootTimerTick" event (fired from
-- LootMaster's own 0.5s ticker) rather than a full
-- Refresh() -- just the countdown numbers update every
-- tick, not the whole row layout.
-------------------------------------------------

function LootMasterWindow:UpdateAllTimerTexts()

    for _, row in ipairs(self.RowWidgets) do

        if row:IsShown() then
            self:UpdateRowTimerText(row)
        end

    end

end

-------------------------------------------------
-- Refresh
--
-- Groups the queue by boss (manually-added items with
-- no boss fall into "Other"), redraws headers/rows top
-- to bottom, and resizes the scroll child to fit.
-------------------------------------------------

function LootMasterWindow:Refresh()

    if not self.ScrollChild then
        return
    end

    self:UpdateAutoAssignCheckbox()
    self:ResetWidgets()

    local queue = ImpLoot.LootMaster:GetQueue()

    local groups = {}
    local groupOrder = {}

    for _, entry in ipairs(queue) do

        local key = entry.BossName or "Other"

        if not groups[key] then
            groups[key] = {}
            table.insert(groupOrder, key)
        end

        table.insert(groups[key], entry)

    end

    local y = 0
    local headerIndex = 0
    local rowIndex = 0

    for _, bossName in ipairs(groupOrder) do

        headerIndex = headerIndex + 1

        local header = self:AcquireHeader(headerIndex)
        header:ClearAllPoints()
        header:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 2, -y)
        header:SetText(bossName)
        header:Show()

        y = y + HEADER_HEIGHT

        for _, entry in ipairs(groups[bossName]) do

            rowIndex = rowIndex + 1

            local row = self:AcquireRow(rowIndex)
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", self.ScrollChild, "TOPLEFT", 0, -y)
            row:SetWidth(self.ScrollChild:GetWidth())

            self:PopulateRow(row, entry)

            y = y + ROW_HEIGHT + ROW_GAP

        end

        y = y + GROUP_GAP

    end

    self.ScrollChild:SetHeight(math.max(y, 1))

    if self.ScrollFrame.UpdateScrollChildRect then
        self.ScrollFrame:UpdateScrollChildRect()
    end

    if self.ScrollFrame.UpdateScrollIndicators then
        self.ScrollFrame:UpdateScrollIndicators()
    end

end
