-------------------------------------------------
-- Minimap Button
--
-- No bundled minimap-icon library in this client,
-- so this is a small standalone implementation:
-- orbits the minimap edge by angle (same convention
-- LibDBIcon-style buttons use), drag to reposition,
-- left-click toggles the main window, right-click
-- opens the options panel. Position and shown/hidden
-- state persist across sessions.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.MinimapButton = ImpLoot.UI.MinimapButton or {}
local MinimapButton = ImpLoot.UI.MinimapButton

local RADIUS = 80

-- Lua 5.1 (this client) names it atan2; later Lua
-- versions folded it into a two-argument atan.
local atan2 = math.atan2 or math.atan

-------------------------------------------------
-- Initialize
-------------------------------------------------

function MinimapButton:Initialize()

    ImpLootDB.MinimapButton = ImpLootDB.MinimapButton or {
        Angle = 215,
        Hidden = false,
    }

    self.State = ImpLootDB.MinimapButton

    local button = CreateFrame("Button", "ImpLootMinimapButton", Minimap)
    self.Button = button

    button:SetSize(31, 31)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:RegisterForDrag("LeftButton")
    button:SetMovable(true)

    local icon = button:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 0)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Bag_08")
    self.Icon = icon

    local border = button:CreateTexture(nil, "OVERLAY")
    border:SetSize(52, 52)
    border:SetPoint("TOPLEFT", 0, 0)
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    local highlight = button:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetSize(30, 30)
    highlight:SetPoint("CENTER", 0, 0)
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    highlight:SetBlendMode("ADD")

    -------------------------------------------------
    -- Click Handling
    -------------------------------------------------

    button:SetScript("OnClick", function(_, mouseButton)

        if mouseButton == "LeftButton" then

            if ImpLoot.UI.MainWindow and ImpLoot.UI.MainWindow.Toggle then
                ImpLoot.UI.MainWindow:Toggle()
            end

        elseif mouseButton == "RightButton" then

            if ImpLoot.UI.OptionsPanel
            and ImpLoot.UI.OptionsPanel.MainPanel
            and InterfaceOptionsFrame_OpenToCategory then

                InterfaceOptionsFrame_OpenToCategory(ImpLoot.UI.OptionsPanel.MainPanel)
                InterfaceOptionsFrame_OpenToCategory(ImpLoot.UI.OptionsPanel.MainPanel)

            end

        end

    end)

    -------------------------------------------------
    -- Tooltip
    -------------------------------------------------

    button:SetScript("OnEnter", function(self_)

        GameTooltip:SetOwner(self_, "ANCHOR_LEFT")
        GameTooltip:SetText("ImpLoot")
        GameTooltip:AddLine("Left-click: toggle window", 1, 1, 1)
        GameTooltip:AddLine("Right-click: open settings", 1, 1, 1)
        GameTooltip:AddLine("Drag: reposition", 1, 1, 1)
        GameTooltip:Show()

    end)

    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -------------------------------------------------
    -- Drag To Reposition
    -------------------------------------------------

    button:SetScript("OnDragStart", function(self_)
        self_.Dragging = true
    end)

    button:SetScript("OnDragStop", function(self_)
        self_.Dragging = false
    end)

    button:SetScript("OnUpdate", function(self_)

        if not self_.Dragging then
            return
        end

        local mx, my = Minimap:GetCenter()
        local px, py = GetCursorPosition()
        local scale = Minimap:GetEffectiveScale()

        if not mx or not px then
            return
        end

        px, py = px / scale, py / scale

        local angle = math.deg(atan2(py - my, px - mx))

        MinimapButton.State.Angle = angle
        MinimapButton:UpdatePosition()

    end)

    self:UpdatePosition()

    if self.State.Hidden then
        button:Hide()
    else
        button:Show()
    end

end

-------------------------------------------------
-- Update Position
-------------------------------------------------

function MinimapButton:UpdatePosition()

    local angle = self.State.Angle or 215

    local x = math.cos(math.rad(angle)) * RADIUS
    local y = math.sin(math.rad(angle)) * RADIUS

    self.Button:ClearAllPoints()
    self.Button:SetPoint("CENTER", Minimap, "CENTER", x, y)

end

-------------------------------------------------
-- Set Shown
-------------------------------------------------

function MinimapButton:SetShown(shown)

    self.State.Hidden = not shown

    if shown then
        self.Button:Show()
    else
        self.Button:Hide()
    end

end

function MinimapButton:IsShown()
    return not self.State.Hidden
end
