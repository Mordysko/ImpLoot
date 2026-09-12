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

-------------------------------------------------
-- Create Directional Arrow
--
-- A single, uniform arrow style reused everywhere the
-- addon needs one (the drawer tab's open/close
-- indicator, the scroll "more above/below" indicators)
-- rather than different text characters that don't
-- visually match each other ("<"/">" are a different
-- weight and shape than "^"/"v" in most fonts).
--
-- Built from Interface\Buttons\UI-ScrollBar-ScrollUpButton-Up
-- specifically because it's a texture this addon has
-- already proven works in this client -- it's the exact
-- texture on the scrollbar's own up-button, which every
-- scroll frame in the addon has been successfully hiding
-- (and therefore rendering, before being hidden) since
-- the scroll indicator feature was built. The earlier
-- "Arrow-Up-Up"/etc. set turned out not to render at all
-- in this client -- rather than guess at another unverified
-- name, this one is built from something already confirmed
-- to exist. One base texture (pointing UP), rotated to the
-- other three directions via the 8-value form of
-- SetTexCoord (true corner remapping, not just a flip --
-- WotLK 3.3.5a has no SetRotation() API).
-------------------------------------------------

local ARROW_BASE_TEXTURE = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up"

local ARROW_TEXCOORDS = {
    UP    = { 0, 0, 0, 1, 1, 0, 1, 1 },   -- identity (base texture points up)
    DOWN  = { 1, 1, 1, 0, 0, 1, 0, 0 },   -- 180 degrees
    RIGHT = { 0, 1, 1, 1, 0, 0, 1, 0 },   -- 90 degrees clockwise
    LEFT  = { 1, 0, 0, 0, 1, 1, 0, 1 },   -- 90 degrees counter-clockwise
}

function ImpLoot.Theme:CreateDirectionalArrow(parent, direction)

    local arrow = parent:CreateTexture(nil, "OVERLAY")

    arrow:SetTexture(ARROW_BASE_TEXTURE)
    arrow:SetVertexColor(1, 0.82, 0, 1) -- matches the addon's gold theme text color

    self:SetArrowDirection(arrow, direction)

    return arrow

end

-------------------------------------------------
-- Set Arrow Direction
--
-- Re-points an existing CreateDirectionalArrow texture
-- at a new direction, for widgets that need to flip
-- which way their arrow points after creation (the
-- drawer tab, the mode toggle's cycling, etc).
-------------------------------------------------

function ImpLoot.Theme:SetArrowDirection(arrow, direction)

    local coords = ARROW_TEXCOORDS[direction] or ARROW_TEXCOORDS.UP

    arrow:SetTexCoord(unpack(coords))

end

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

    local arrow = self:CreateDirectionalArrow(handle, "RIGHT")
    arrow:SetSize(16, 16)
    arrow:SetPoint("CENTER")

    handle.Arrow = arrow

    return handle

end

-------------------------------------------------
-- Set Tab Direction
-------------------------------------------------

function ImpLoot.Theme:SetTabDirection(handle, open)

    if open then
        self:SetArrowDirection(handle.Arrow, "LEFT")
    else
        self:SetArrowDirection(handle.Arrow, "RIGHT")
    end

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

    local topArrow = self:CreateDirectionalArrow(parent, "UP")
    topArrow:SetSize(14, 14)
    topArrow:SetPoint("TOP", scrollFrame, "TOP", 0, 10)
    topArrow:Hide()

    local bottomArrow = self:CreateDirectionalArrow(parent, "DOWN")
    bottomArrow:SetSize(14, 14)
    bottomArrow:SetPoint("BOTTOM", scrollFrame, "BOTTOM", 0, -10)
    bottomArrow:Hide()

    scrollFrame.TopArrow = topArrow
    scrollFrame.BottomArrow = bottomArrow

    local function UpdateScrollIndicators()

        local current = scrollFrame:GetVerticalScroll() or 0
        local maximum = scrollFrame:GetVerticalScrollRange() or 0

        if current > 0.5 then
            topArrow:Show()
        else
            topArrow:Hide()
        end

        if maximum > 0.5 and current < maximum - 0.5 then
            bottomArrow:Show()
        else
            bottomArrow:Hide()
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