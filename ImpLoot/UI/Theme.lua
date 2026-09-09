-------------------------------------------------
-- ImpLoot Theme
-------------------------------------------------

ImpLoot.Theme = {}

-------------------------------------------------
-- Colours
-------------------------------------------------

ImpLoot.Theme.Colors = {
    Background = {0.08, 0.08, 0.08, 0.95},
    Border     = {0.35, 0.35, 0.35, 1.00},
    Highlight  = {0.16, 0.16, 0.16, 1.00},
    Text       = {1.00, 0.82, 0.00, 1.00},
}

-------------------------------------------------
-- Metrics
-------------------------------------------------

ImpLoot.Theme.Metrics = {

    ButtonWidth = 100,
    ButtonHeight = 22,

    DrawerWidth = 220,

    Padding = 8,
    BorderInset = 3,
    BorderSize = 12,

}

-------------------------------------------------
-- Fonts
-------------------------------------------------

ImpLoot.Theme.Fonts = {

    Normal = GameFontNormal,
    Highlight = GameFontHighlight,
    Disabled = GameFontDisable,

    Header = GameFontNormalLarge,
    Title = GameFontHighlightLarge,

}

-------------------------------------------------
-- Apply Panel Style
-------------------------------------------------

function ImpLoot.Theme:ApplyPanelStyle(frame)

    local colors = self.Colors

    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = {
            left = 3,
            right = 3,
            top = 3,
            bottom = 3,
        },
    })

    frame:SetBackdropColor(
        colors.Background[1],
        colors.Background[2],
        colors.Background[3],
        colors.Background[4]
    )

    frame:SetBackdropBorderColor(
        colors.Border[1],
        colors.Border[2],
        colors.Border[3],
        colors.Border[4]
    )

end

-------------------------------------------------
-- Create Menu Button
-------------------------------------------------

function ImpLoot.Theme:CreateMenuButton(parent)

    local button = CreateFrame("Button", nil, parent)

    local metrics = self.Metrics
    local fonts = self.Fonts

    button:SetWidth(metrics.ButtonWidth)
    button:SetHeight(metrics.ButtonHeight)

    button:SetNormalFontObject(fonts.Normal)
    button:SetHighlightFontObject(fonts.Highlight)
    button:SetDisabledFontObject(fonts.Disabled)

    self:ApplyPanelStyle(button)

    return button

end

-------------------------------------------------
-- Create Tab Handle
-------------------------------------------------

function ImpLoot.Theme:CreateTabHandle(parent)

    local handle = CreateFrame("Button", nil, parent)

    handle:SetWidth(20)
    handle:SetHeight(64)

    self:ApplyPanelStyle(handle)

    -- Renders behind BOTH the drawer (LOW) and the main
    -- window (default MEDIUM) regardless of which one
    -- it's currently overlapping, so only the protruding
    -- tab (with the arrow) is visible -- the rest tucks
    -- behind whichever edge it's touching.
    handle:SetFrameStrata("BACKGROUND")

    local arrow = handle:CreateFontString(nil, "OVERLAY")
    arrow:SetFontObject(self.Fonts.Header)
    arrow:SetPoint("CENTER")
    arrow:SetText(">")

    handle.Arrow = arrow

    return handle

end

-------------------------------------------------
-- Set Tab Direction
-------------------------------------------------

function ImpLoot.Theme:SetTabDirection(handle, open)

    if open then
        handle.Arrow:SetText("<")
    else
        handle.Arrow:SetText(">")
    end

end

-------------------------------------------------
-- Item Quality Colour
-------------------------------------------------

function ImpLoot.Theme:GetQualityColor(quality)

    if quality == 4 then
        return 0.64, 0.21, 0.93
    elseif quality == 3 then
        return 0.00, 0.44, 0.87
    elseif quality == 2 then
        return 0.12, 1.00, 0.00
    end

    return 1, 1, 1

end