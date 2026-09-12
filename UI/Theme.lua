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
-- Create Vertical Arrow (Up/Down only)
--
-- A small triangle icon for up/down indicators --
-- the scroll "more above/below" indicators and the
-- Loot Priority candidate row reorder buttons. Two
-- separate, natively-oriented textures (Arrow-Up-Up /
-- Arrow-Down-Up) rather than one texture rotated via
-- TexCoord -- this is the exact style confirmed working
-- well for scrolling, and reusing it here keeps the
-- reorder buttons visually consistent with the scroll
-- indicators rather than mismatched.
--
-- Left/right (the drawer tab's open/close indicator)
-- stays as plain "<"/">" text -- this helper is
-- deliberately scoped to vertical only.
-------------------------------------------------

local VERTICAL_ARROW_TEXTURES = {
    UP   = "Interface\\Buttons\\Arrow-Up-Up",
    DOWN = "Interface\\Buttons\\Arrow-Down-Up",
}

function ImpLoot.Theme:CreateVerticalArrow(parent, direction)

    local arrow = parent:CreateTexture(nil, "OVERLAY")

    arrow:SetTexture(VERTICAL_ARROW_TEXTURES[direction] or VERTICAL_ARROW_TEXTURES.UP)
    arrow:SetVertexColor(1, 0.82, 0, 1) -- matches the addon's gold theme text color

    return arrow

end

-------------------------------------------------
-- Apply Drawer-Style Scroll Indicators
--
-- Replaces the standard WoW scrollbar (track, thumb,
-- up/down buttons) with small arrow indicators shown
-- only when there's actually more content in that
-- direction -- matching the drawer tab's own arrow
-- style, rather than a permanently-visible scrollbar.
-- Mouse wheel scrolling is untouched; only the always-
-- visible scrollbar chrome goes away.
--
-- The arrows are created on the scroll frame's PARENT
-- (not the scroll frame itself), since anything parented
-- directly to a ScrollFrame is clipped to its scrollable
-- viewport and would scroll away with the content.
--
-- Call :UpdateScrollIndicators() on the returned scroll
-- frame after populating/resizing its content, since a
-- content-height change doesn't always fire
-- OnScrollRangeChanged on its own.
-------------------------------------------------

function ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(scrollFrame)

    local scrollBarName = scrollFrame:GetName() and (scrollFrame:GetName() .. "ScrollBar")
    local scrollBar = scrollBarName and _G[scrollBarName]

    if scrollBar then

        scrollBar:Hide()
        scrollBar:EnableMouse(false)
        scrollBar:SetAlpha(0)

        -- belt-and-suspenders: UIPanelScrollFrameTemplate's
        -- up/down buttons are children of the scrollbar, so
        -- hiding it should already hide them too, but disable
        -- their mouse interaction directly as well in case
        -- anything else in the template re-shows the parent
        local upButton = _G[scrollBarName .. "ScrollUpButton"]
        local downButton = _G[scrollBarName .. "ScrollDownButton"]

        if upButton then
            upButton:Hide()
            upButton:EnableMouse(false)
        end

        if downButton then
            downButton:Hide()
            downButton:EnableMouse(false)
        end

    end

    local parent = scrollFrame:GetParent()

    -- Each arrow gets its own small frame (rather than being a
    -- texture directly on `parent`) so its frame level can be
    -- raised above the scroll frame's own -- otherwise the loot
    -- items scrolling underneath (a separate frame hierarchy
    -- inside the scroll frame) can end up drawn on top of the
    -- arrow instead of below it.
    local topArrowFrame = CreateFrame("Frame", nil, parent)
    topArrowFrame:SetSize(14, 14)
    topArrowFrame:SetPoint("TOP", scrollFrame, "TOP", 0, 10)
    topArrowFrame:SetFrameLevel(scrollFrame:GetFrameLevel() + 10)

    local topArrow = self:CreateVerticalArrow(topArrowFrame, "UP")
    topArrow:SetAllPoints()
    topArrowFrame:Hide()

    local bottomArrowFrame = CreateFrame("Frame", nil, parent)
    bottomArrowFrame:SetSize(14, 14)
    bottomArrowFrame:SetPoint("BOTTOM", scrollFrame, "BOTTOM", 0, -10)
    bottomArrowFrame:SetFrameLevel(scrollFrame:GetFrameLevel() + 10)

    local bottomArrow = self:CreateVerticalArrow(bottomArrowFrame, "DOWN")
    bottomArrow:SetAllPoints()
    bottomArrowFrame:Hide()

    scrollFrame.TopArrow = topArrowFrame
    scrollFrame.BottomArrow = bottomArrowFrame

    local function UpdateScrollIndicators()

        local current = scrollFrame:GetVerticalScroll() or 0
        local maximum = scrollFrame:GetVerticalScrollRange() or 0

        if current > 0.5 then
            topArrowFrame:Show()
        else
            topArrowFrame:Hide()
        end

        if maximum > 0.5 and current < maximum - 0.5 then
            bottomArrowFrame:Show()
        else
            bottomArrowFrame:Hide()
        end

    end

    scrollFrame.UpdateScrollIndicators = UpdateScrollIndicators

    scrollFrame:HookScript("OnScrollRangeChanged", UpdateScrollIndicators)
    scrollFrame:HookScript("OnVerticalScroll", UpdateScrollIndicators)

    UpdateScrollIndicators()

end

-------------------------------------------------
-- Get Strata Above
--
-- Returns the next strata up from the given one, in
-- WoW's fixed strata order. Used by windows that need
-- to render above another ImpLoot window regardless of
-- whatever strata that window's own Window Layering
-- setting currently has it on -- e.g. the CSV import
-- dialog needs to sit above the Main Window even if the
-- user has set the Main Window itself to "DIALOG" (one
-- of Window Layering's own valid choices), which would
-- otherwise put them at the same strata with no
-- guaranteed order between them.
-------------------------------------------------

local STRATA_ORDER = {
    "BACKGROUND", "LOW", "MEDIUM", "HIGH",
    "DIALOG", "FULLSCREEN", "FULLSCREEN_DIALOG", "TOOLTIP",
}

local STRATA_INDEX = {}

for i, strata in ipairs(STRATA_ORDER) do
    STRATA_INDEX[strata] = i
end

function ImpLoot.Theme:GetStrataAbove(strata)

    local index = STRATA_INDEX[strata] or STRATA_INDEX.MEDIUM

    return STRATA_ORDER[math.min(index + 1, #STRATA_ORDER)]

end

-------------------------------------------------
-- Item Quality Colour
-------------------------------------------------

function ImpLoot.Theme:GetQualityColor(quality)

    if quality == 5 then
        return 1.00, 0.50, 0.00
    elseif quality == 4 then
        return 0.64, 0.21, 0.93
    elseif quality == 3 then
        return 0.00, 0.44, 0.87
    elseif quality == 2 then
        return 0.12, 1.00, 0.00
    end

    return 1, 1, 1

end