-------------------------------------------------
-- Main Window
--
-- Owns the addon's outer frame, header and status bar.
-- Everything else (boss list, loot list, details,
-- import dialog, planning drawer) is a separate module
-- that MainWindow creates and hands its own frame to --
-- MainWindow never reaches into their internals.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.MainWindow = ImpLoot.UI.MainWindow or {}
local MainWindow = ImpLoot.UI.MainWindow

-------------------------------------------------
-- Shared Layout Constants
--
-- Other UI files read ImpLoot.UI.Layout -- this is the
-- one place those numbers are defined.
-------------------------------------------------

ImpLoot.UI.Layout = {

    WindowWidth      = 800,
    WindowHeight     = 550,

    HeaderHeight     = 36,
    StatusHeight     = 24,

    Padding          = 8,
    BossPanelWidth   = 150,

    ListButtonHeight = 18,

    -------------------------------------------------
    -- Loot / Wishlist Grid
    -------------------------------------------------

    GridColumns      = 3,
    GridButtonWidth  = 185,
    GridButtonHeight = 18,
    GridColumnGap    = 8,
    GridRowGap       = 4,

}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function MainWindow:Initialize()

    local Layout = ImpLoot.UI.Layout

    -------------------------------------------------
    -- Frame
    -------------------------------------------------

    local frame = CreateFrame("Frame", "ImpLootMainWindow", UIParent)
    self.Frame = frame

    -- Locked at LOW rather than user-adjustable via Window
    -- Layering -- several sub-dialogs opened from within this
    -- window (WishlistDialog, RaidNoteDialog, RaidNotesPopup)
    -- have their own fixed DIALOG strata, and if this window
    -- were adjustable up to DIALOG too, it could end up sharing
    -- their exact strata with no guaranteed order between them.
    frame:SetFrameStrata("LOW")

    frame:SetSize(Layout.WindowWidth, Layout.WindowHeight)
    frame:SetPoint("CENTER")

    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })

    frame:SetBackdropColor(0.08, 0.08, 0.08, 0.95)

    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:Hide()

    -------------------------------------------------
    -- Header
    -------------------------------------------------

    local header = CreateFrame("Frame", nil, frame)
    self.Header = header

    header:SetPoint("TOPLEFT", 4, -4)
    header:SetPoint("TOPRIGHT", -4, -4)
    header:SetHeight(Layout.HeaderHeight)

    header:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background" })
    header:SetBackdropColor(0.16, 0.16, 0.16, 0.95)

    header:EnableMouse(true)
    header:RegisterForDrag("LeftButton")

    header:SetScript("OnDragStart", function()
        frame:StartMoving()
    end)

    header:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
    end)

    local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("CENTER")
    title:SetText("ImpLoot")

    local closeButton = CreateFrame("Button", nil, header, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", 2, 0)

    closeButton:SetScript("OnClick", function()
        frame:Hide()
    end)

    -------------------------------------------------
    -- Status Bar
    -------------------------------------------------

    local statusBar = CreateFrame("Frame", nil, frame)
    self.StatusBar = statusBar

    statusBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 4, 4)
    statusBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4)
    statusBar:SetHeight(Layout.StatusHeight)

    statusBar:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background" })
    statusBar:SetBackdropColor(0.14, 0.14, 0.14, 0.95)

    local statusText = statusBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("LEFT", 8, 0)

    local version = GetAddOnMetadata and GetAddOnMetadata("ImpLoot", "Version")
    statusText:SetText(version and ("v" .. version) or "")

    self.StatusText = statusText

    -------------------------------------------------
    -- Child Panels
    --
    -- Each panel builds its own frame and stores it on
    -- itself (self.Frame). Order here matters only where
    -- one panel's Initialize positions itself relative to
    -- another (BossPanel needs the header; LootPanel needs
    -- BossPanel's frame; DetailsWorkspace needs LootPanel).
    -------------------------------------------------

    ImpLoot.UI.PlanningDrawer:Initialize(frame)
    ImpLoot.UI.CompareDrawer:Initialize(frame)
    ImpLoot.UI.BossPanel:Initialize(frame, header)
    ImpLoot.UI.LootPanel:Initialize(frame, ImpLoot.UI.BossPanel.Frame)
    ImpLoot.UI.DetailsWorkspace:Initialize(ImpLoot.UI.LootPanel)
    ImpLoot.UI.ImportDialog:Initialize(frame)
    ImpLoot.UI.WishlistDialog:Initialize()
    ImpLoot.UI.RaidNoteDialog:Initialize()
    ImpLoot.UI.RaidNotesPopup:Initialize()

    -------------------------------------------------
    -- Initial UI Refresh
    -------------------------------------------------

    ImpLoot.UI.PlanningDrawer:Refresh()
    ImpLoot.UI.DetailsWorkspace:Refresh()
    ImpLoot.UI.CompareDrawer:Refresh()

end

-------------------------------------------------
-- Toggle
-------------------------------------------------

function MainWindow:Toggle()

    if self.Frame:IsShown() then

        self.Frame:Hide()

    else

        ImpLoot.UI.BossPanel:Populate()
        self.Frame:Show()

    end

end
