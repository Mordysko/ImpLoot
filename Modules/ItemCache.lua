ImpLoot = ImpLoot or {}
ImpLoot.ItemCache = ImpLoot.ItemCache or {}

-------------------------------------------------
-- Query Tooltip
-------------------------------------------------

local queryTooltip = CreateFrame(
    "GameTooltip",
    "ImpLootQueryTooltip",
    UIParent,
    "GameTooltipTemplate"
)

queryTooltip:SetOwner(UIParent, "ANCHOR_NONE")

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.ItemCache:Initialize()

    ImpLootDB.ItemCache = ImpLootDB.ItemCache or {}

    self.Pending = self.Pending or {}

    -------------------------------------------------
    -- Hidden polling frame
    -------------------------------------------------

    if not self.PollFrame then

        self.PollFrame = CreateFrame("Frame")

        self.PollFrame:SetScript("OnUpdate", function(frame, elapsed)

            ImpLoot.ItemCache:Poll(elapsed)

        end)

    end

    self.PollElapsed = 0

end

-------------------------------------------------
-- Get Saved Cache
-------------------------------------------------

function ImpLoot.ItemCache:Get(itemID)

    if not itemID then
        return nil
    end

    ImpLootDB.ItemCache = ImpLootDB.ItemCache or {}

    return ImpLootDB.ItemCache[tonumber(itemID)]

end

-------------------------------------------------
-- Store Item
-------------------------------------------------

function ImpLoot.ItemCache:Store(itemID)

    if not itemID then
        return nil
    end

    itemID = tonumber(itemID)

    if not itemID then
        return nil
    end

    local name, link, quality, itemLevel, requiredLevel,
          itemType, itemSubType, itemStackCount,
          equipLoc, texture = GetItemInfo(itemID)

    if not name then
        return nil
    end

    local data = {

        ItemID = itemID,
        Name = name,
        Link = link,
        Quality = quality,
        ItemLevel = itemLevel,
        RequiredLevel = requiredLevel,
        Type = itemType,
        SubType = itemSubType,
        StackCount = itemStackCount,
        EquipLoc = equipLoc,
        Texture = texture,

    }

    ImpLootDB.ItemCache[itemID] = data

    return data

end

-------------------------------------------------
-- Request Item
-------------------------------------------------

function ImpLoot.ItemCache:Request(itemID)

    if not itemID then
        return false
    end

    itemID = tonumber(itemID)

    if not itemID then
        return false
    end

    -------------------------------------------------
    -- Already stored by ImpLoot?
    -------------------------------------------------

    if self:Get(itemID) then
        return true
    end

    -------------------------------------------------
    -- Already available in WoW's cache?
    -------------------------------------------------

    local data = self:Store(itemID)

    if data then
        return true
    end

    -------------------------------------------------
    -- Already waiting for this item?
    -------------------------------------------------

    if self.Pending[itemID] then
        return false
    end

    -------------------------------------------------
    -- Mark as pending
    -------------------------------------------------

    self.Pending[itemID] = true

    -------------------------------------------------
    -- Request item information
    -------------------------------------------------

    queryTooltip:SetHyperlink(
        "item:" .. tostring(itemID) .. ":0:0:0:0:0:0:0"
    )

queryTooltip:Hide()

    return false

end

-------------------------------------------------
-- Poll Pending Items
-------------------------------------------------

function ImpLoot.ItemCache:Poll(elapsed)

    if not self.Pending then
        return
    end

    self.PollElapsed = self.PollElapsed + elapsed

    -------------------------------------------------
    -- Check every 0.25 seconds
    -------------------------------------------------

    if self.PollElapsed < 0.25 then
        return
    end

    self.PollElapsed = 0

    for itemID in pairs(self.Pending) do

    local data = self:Store(itemID)

    if data then

        self.Pending[itemID] = nil

            if ImpLoot.UI
                and ImpLoot.UI.LootPanel
                and ImpLoot.UI.LootPanel.RefreshItem then

                ImpLoot.UI.LootPanel:RefreshItem(itemID)

            end

            if ImpLoot.UI
                and ImpLoot.UI.CompareDrawer
                and ImpLoot.UI.CompareDrawer.RefreshItem then

                ImpLoot.UI.CompareDrawer:RefreshItem(itemID)

            end

        end

    end

end

-------------------------------------------------
-- Get Item
-------------------------------------------------

function ImpLoot.ItemCache:GetItem(itemID)

    if not itemID then
        return nil
    end

    itemID = tonumber(itemID)

    if not itemID then
        return nil
    end

    -------------------------------------------------
    -- Check ImpLoot's persistent cache
    -------------------------------------------------

    local cached = self:Get(itemID)

    if cached then
        return cached
    end

    -------------------------------------------------
    -- Check WoW's cache
    -------------------------------------------------

    local data = self:Store(itemID)

    if data then
        return data
    end

    -------------------------------------------------
    -- Request from server
    -------------------------------------------------

    self:Request(itemID)

    return nil

end

-------------------------------------------------
-- GET_ITEM_INFO_RECEIVED
--
-- Keep this as a fast path if the client fires
-- the event. Polling remains the fallback.
-------------------------------------------------

function ImpLoot.ItemCache:OnItemInfoReceived(itemID, success)

    if not itemID then
        return
    end

    itemID = tonumber(itemID)

    if not itemID then
        return
    end

    if not success then
        return
    end

    local data = self:Store(itemID)

    if data then

        self.Pending[itemID] = nil

        if ImpLoot.UI
            and ImpLoot.UI.LootPanel
            and ImpLoot.UI.LootPanel.RefreshItem then

            ImpLoot.UI.LootPanel:RefreshItem(itemID)

        end

        if ImpLoot.UI
            and ImpLoot.UI.CompareDrawer
            and ImpLoot.UI.CompareDrawer.RefreshItem then

            ImpLoot.UI.CompareDrawer:RefreshItem(itemID)

        end

    end

end