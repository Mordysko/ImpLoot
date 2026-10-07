-------------------------------------------------
-- ImpLoot Window Layering Module
--
-- Lets the user choose which WoW frame strata each
-- of ImpLoot's top-level windows renders at, so they
-- can resolve overlap with other addons (damage
-- meters, raid frames, etc.) without ImpLoot always
-- winning or always losing that fight.
--
-- Only exposes a safe subset of WoW's full strata
-- list -- BACKGROUND sits behind almost everything
-- (a window set to it could become unreachable
-- behind the game world itself), and FULLSCREEN /
-- FULLSCREEN_DIALOG / TOOLTIP are unusual choices
-- for an ordinary window and can interfere with
-- other UI in surprising ways.
-------------------------------------------------

ImpLoot.WindowLayering = {}

local WindowLayering = ImpLoot.WindowLayering

WindowLayering.VALID_STRATA = { "LOW", "MEDIUM", "HIGH", "DIALOG" }

-------------------------------------------------
-- Windows Covered
--
-- The persistent/semi-persistent top-level windows a
-- player might actually want positioned above or below
-- other addons during a raid. Transient, quick dialogs
-- (import, wishlist rename, raid notes, etc.) aren't
-- included -- they're modal-style popups that typically
-- only appear briefly on top of the main window anyway.
--
-- Main Window is deliberately NOT included here (even
-- though it's one of the persistent windows) -- it's
-- locked to LOW instead. Several of those transient
-- sub-dialogs (WishlistDialog, RaidNoteDialog,
-- RaidNotesPopup) are opened from within it and have
-- their own fixed DIALOG strata; if Main Window were
-- adjustable up to DIALOG too, it could end up sharing
-- their exact strata with no guaranteed order between
-- them. Locking Main Window to LOW removes that
-- possibility entirely rather than needing each of
-- those sub-dialogs to track it dynamically too.
-------------------------------------------------

WindowLayering.WINDOWS = {
    { Key = "LootMasterWindow", Label = "Loot Master Window" },
    { Key = "LootPriorityWindow", Label = "Loot Priority Window" },
    { Key = "SummaryWindow", Label = "Summary Window" },
    { Key = "ReservePopup", Label = "Reserve Popup" },
    { Key = "VotePopup", Label = "Vote Popup" },
}

WindowLayering.Defaults = {
    LootMasterWindow = "MEDIUM",
    LootPriorityWindow = "MEDIUM",
    SummaryWindow = "DIALOG",
    ReservePopup = "DIALOG",
    VotePopup = "DIALOG",
}

-------------------------------------------------
-- Initialize
-------------------------------------------------

function WindowLayering:Initialize()

    ImpLootDB.WindowStrata = ImpLootDB.WindowStrata or {}
    self.DB = ImpLootDB.WindowStrata

    for key, default in pairs(self.Defaults) do

        if self.DB[key] == nil then
            self.DB[key] = default
        end

    end

end

-------------------------------------------------
-- Get / Set Strata
-------------------------------------------------

function WindowLayering:GetStrata(windowKey)

    return self.DB[windowKey] or self.Defaults[windowKey] or "MEDIUM"

end

function WindowLayering:SetStrata(windowKey, strata)

    self.DB[windowKey] = strata

    self:ApplyToWindow(windowKey)

end

-------------------------------------------------
-- Get Frame For Window
-------------------------------------------------

function WindowLayering:GetFrameForWindow(windowKey)

    local UI = ImpLoot.UI

    local module = UI[windowKey]

    if not module then
        return nil
    end

    return module.Frame

end

-------------------------------------------------
-- Apply To Window / Apply All
-------------------------------------------------

function WindowLayering:ApplyToWindow(windowKey)

    local frame = self:GetFrameForWindow(windowKey)

    if not frame then
        return
    end

    frame:SetFrameStrata(self:GetStrata(windowKey))

end

function WindowLayering:ApplyAll()

    for _, entry in ipairs(self.WINDOWS) do
        self:ApplyToWindow(entry.Key)
    end

end

-------------------------------------------------
-- Reset Settings To Defaults
-------------------------------------------------

function WindowLayering:ResetSettingsToDefaults()

    for key, default in pairs(self.Defaults) do
        self.DB[key] = default
    end

    self:ApplyAll()

end
