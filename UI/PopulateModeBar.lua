-------------------------------------------------
-- Populate Mode Bar
--
-- A small, always-visible-while-active status bar for
-- the "Populate Item List" workflow: shows how many
-- items have been alt-clicked/staged so far, with
-- Add-to-Priority-List and Cancel buttons. Appears
-- independently of whatever the main window happens to
-- be showing, since alt-clicking loot can happen from
-- any boss's page.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.PopulateModeBar = ImpLoot.UI.PopulateModeBar or {}
local PopulateModeBar = ImpLoot.UI.PopulateModeBar

-------------------------------------------------
-- Initialize
-------------------------------------------------

function PopulateModeBar:Initialize()

    local frame = CreateFrame("Frame", "ImpLootPopulateModeBar", UIParent)
    self.Frame = frame

    frame:SetSize(340, 76)
    frame:SetPoint("TOP", 0, -120)
    frame:SetFrameStrata("HIGH")

    ImpLoot.Theme:ApplyPanelStyle(frame)

    frame:Hide()

    local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOP", 0, -8)
    self.StatusText = text

    local addButton = ImpLoot.Theme:CreateMenuButton(frame)
    addButton:SetSize(130, 22)
    addButton:SetPoint("BOTTOMLEFT", 10, 8)
    addButton:SetText("Add to Priority List")

    addButton:SetScript("OnClick", function()

        local added = ImpLoot.LootCouncil:CommitStagedItems()

        ImpLoot:Print("Added " .. added .. " item(s) to the priority list.")

        self:Hide()

        if ImpLoot.UI.LootPriorityWindow then
            ImpLoot.UI.LootPriorityWindow:Show()
        end

    end)

    local cancelButton = ImpLoot.Theme:CreateMenuButton(frame)
    cancelButton:SetSize(70, 22)
    cancelButton:SetPoint("LEFT", addButton, "RIGHT", 6, 0)
    cancelButton:SetText("Cancel")

    cancelButton:SetScript("OnClick", function()

        ImpLoot.LootCouncil:StopPopulateMode()
        self:Hide()

    end)

end

-------------------------------------------------
-- Refresh
-------------------------------------------------

function PopulateModeBar:Refresh()

    local count = #ImpLoot.LootCouncil:GetStagedItems()

    self.StatusText:SetText(
        "Populate Mode -- " .. count .. " item(s) staged\nAlt-click loot to add more"
    )

end

-------------------------------------------------
-- Show / Hide
-------------------------------------------------

function PopulateModeBar:Show()
    self:Refresh()
    self.Frame:Show()
end

function PopulateModeBar:Hide()
    self.Frame:Hide()
end
