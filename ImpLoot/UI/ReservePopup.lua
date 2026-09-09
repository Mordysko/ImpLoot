-------------------------------------------------
-- Reserve / Wishlist Popup
--
-- Shows only for the person it's actually relevant to
-- (their own soft reserve, or an open-roll item on
-- their own wishlist) -- Comms.lua already did that
-- filtering before firing "ShowReservePopup". Clicking
-- Roll/Off-Spec Roll performs a REAL roll (RandomRoll),
-- exactly as if they'd typed /roll themselves.
--
-- Multiple relevant items can be announced in quick
-- succession, so this queues rather than stacking
-- frames or replacing what's currently shown.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.ReservePopup = ImpLoot.UI.ReservePopup or {}
local ReservePopup = ImpLoot.UI.ReservePopup

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ReservePopup:Initialize()

    self.Pending = {}

    ImpLootDB.ReservePopupPosition = ImpLootDB.ReservePopupPosition or nil

    local frame = CreateFrame("Frame", "ImpLootReservePopup", UIParent)
    self.Frame = frame

    frame:SetSize(240, 110)
    frame:SetFrameStrata("DIALOG")

    if ImpLootDB.ReservePopupPosition then

        local pos = ImpLootDB.ReservePopupPosition

        frame:SetPoint(pos.point, UIParent, pos.point, pos.x, pos.y)

    else

        frame:SetPoint("TOP", 0, -180)

    end

    ImpLoot.Theme:ApplyPanelStyle(frame)

    -------------------------------------------------
    -- Moveable
    --
    -- No dedicated title bar on a popup this small --
    -- dragging anywhere on the background (not the
    -- buttons, which consume their own clicks) moves
    -- it. Position is remembered across sessions.
    -------------------------------------------------

    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")

    frame:SetScript("OnDragStart", function()
        frame:StartMoving()
    end)

    frame:SetScript("OnDragStop", function()

        frame:StopMovingOrSizing()

        local point, _, _, x, y = frame:GetPoint()

        ImpLootDB.ReservePopupPosition = {
            point = point,
            x = x,
            y = y,
        }

    end)

    frame:Hide()

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", 0, -10)
    title:SetTextColor(
        ImpLoot.Theme.Colors.Text[1],
        ImpLoot.Theme.Colors.Text[2],
        ImpLoot.Theme.Colors.Text[3]
    )
    self.TitleText = title

    local reasonText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    reasonText:SetPoint("TOP", title, "BOTTOM", 0, -6)
    reasonText:SetWidth(220)
    reasonText:SetJustifyH("CENTER")
    self.ReasonText = reasonText

    local rollButton = ImpLoot.Theme:CreateMenuButton(frame)
    rollButton:SetSize(70, 22)
    rollButton:SetPoint("BOTTOMLEFT", 8, 10)
    rollButton:SetText("Roll")
    self.RollButton = rollButton

    local offSpecButton = ImpLoot.Theme:CreateMenuButton(frame)
    offSpecButton:SetSize(90, 22)
    offSpecButton:SetPoint("LEFT", rollButton, "RIGHT", 4, 0)
    offSpecButton:SetText("Off-Spec Roll")
    self.OffSpecButton = offSpecButton

    local passButton = ImpLoot.Theme:CreateMenuButton(frame)
    passButton:SetSize(60, 22)
    passButton:SetPoint("LEFT", offSpecButton, "RIGHT", 4, 0)
    passButton:SetText("Pass")
    self.PassButton = passButton

    rollButton:SetScript("OnClick", function()
        self:RollAndDismiss(false)
    end)

    offSpecButton:SetScript("OnClick", function()
        self:RollAndDismiss(true)
    end)

    passButton:SetScript("OnClick", function()
        self:Dismiss()
    end)

    ImpLoot.Events:Register("ShowReservePopup", function(itemID, mode, wishlistName)
        self:Enqueue(itemID, mode, wishlistName)
    end)

    -------------------------------------------------
    -- Timeout Ticking
    --
    -- Directly mirrors the roll timer's own approach --
    -- once the roll window this popup was announced
    -- for would have closed, acting on it is pointless
    -- (or actively misleading), so it auto-dismisses
    -- rather than sitting there stale. Reads GetTime()
    -- itself so it's directly callable without a real
    -- OnUpdate loop.
    -------------------------------------------------

    local tickFrame = CreateFrame("Frame")
    local sinceLastTick = 0

    tickFrame:SetScript("OnUpdate", function(_, delta)

        sinceLastTick = sinceLastTick + (delta or 0)

        if sinceLastTick >= 0.5 then
            sinceLastTick = 0
            self:OnTimerTick()
        end

    end)

    self.TickFrame = tickFrame

end

-------------------------------------------------
-- Enqueue / Show Next
-------------------------------------------------

function ReservePopup:Enqueue(itemID, mode, wishlistName)

    table.insert(self.Pending, {
        ItemID = itemID,
        Mode = mode,
        WishlistName = wishlistName,
    })

    if not self.Frame:IsShown() then
        self:ShowNext()
    end

end

function ReservePopup:ShowNext()

    local next = table.remove(self.Pending, 1)

    if not next then
        self.Frame:Hide()
        return
    end

    self.Current = next

    local cached = ImpLoot.ItemCache:GetItem(next.ItemID)
    local displayName = (cached and cached.Name) or ("Item " .. next.ItemID)

    local r, g, b = ImpLoot.Theme:GetQualityColor(cached and cached.Quality)
    self.TitleText:SetText(displayName)
    self.TitleText:SetTextColor(r, g, b)

    if next.Mode == "SoftReserve" then
        self.ReasonText:SetText("You reserved this item!")
    else
        self.ReasonText:SetText(
            "This item is in your \"" .. (next.WishlistName or "?") .. "\" wishlist."
        )
    end

    local rollDuration = ImpLoot.LootMaster.Settings.RollDuration

    if rollDuration and rollDuration > 0 then
        self.ExpireAt = GetTime() + rollDuration
    else
        self.ExpireAt = nil
    end

    self.Frame:Show()

end

-------------------------------------------------
-- On Timer Tick
-------------------------------------------------

function ReservePopup:OnTimerTick()

    if not self.Frame:IsShown() or not self.ExpireAt then
        return
    end

    if GetTime() >= self.ExpireAt then
        self:Dismiss()
    end

end

-------------------------------------------------
-- Roll And Dismiss
-------------------------------------------------

function ReservePopup:RollAndDismiss(offSpec)

    -- Standard WotLK convention: Main Spec is 1-100,
    -- Off Spec is 1-99 -- distinguished by the roll's
    -- own upper bound, not a separate range entirely.
    local low = 1
    local high = offSpec and 99 or 100

    RandomRoll(low, high)

    self:Dismiss()

end

function ReservePopup:Dismiss()
    self.Current = nil
    self:ShowNext()
end
