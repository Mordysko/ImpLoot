-------------------------------------------------
-- ImpLoot Core
--
-- This file creates the addon namespace,
-- provides the print helper, initializes the
-- addon, and listens for WoW events.
-------------------------------------------------

ImpLoot = ImpLoot or {}

-------------------------------------------------
-- Key Binding Display Strings
--
-- Without these, the Key Bindings menu falls back to
-- showing the raw binding/header names from
-- bindings.xml verbatim ("IMPLOOT_TOGGLE_LOOTMASTER")
-- instead of readable text.
-------------------------------------------------

BINDING_HEADER_IMPLOOT = "ImpLoot"
BINDING_NAME_IMPLOOT_TOGGLE_LOOTMASTER = "Toggle Loot Master Window"

ImpLoot.Session = {}

ImpLoot.SelectedRaid = nil
ImpLoot.SelectedBoss = nil
ImpLoot.SelectedLoot = nil
ImpLoot.SelectedClass = nil

-------------------------------------------------
-- Class Order
--
-- Used by the Vault of Archavon class dropdown.
-------------------------------------------------

ImpLoot.CLASS_ORDER = {
    "Warrior",
    "Paladin",
    "Hunter",
    "Rogue",
    "Priest",
    "Death Knight",
    "Shaman",
    "Mage",
    "Warlock",
    "Druid",
}

-------------------------------------------------
-- Class Specs
--
-- For labeling a Priority list Class candidate with a
-- specific spec (e.g. "Mage - Fire") -- descriptive
-- only, not mechanically verified. WotLK has no
-- reliable way for an addon to passively know another
-- player's current spec, so this is purely a note for
-- whoever's assigning to use their own judgement with,
-- the same way a bare Class candidate already relies on
-- the loot master to manually confirm someone's actual
-- class.
-------------------------------------------------

ImpLoot.CLASS_SPECS = {
    ["Warrior"] = { "Arms", "Fury", "Protection" },
    ["Paladin"] = { "Holy", "Protection", "Retribution" },
    ["Hunter"] = { "Beast Mastery", "Marksmanship", "Survival" },
    ["Rogue"] = { "Assassination", "Combat", "Subtlety" },
    ["Priest"] = { "Discipline", "Holy", "Shadow" },
    ["Death Knight"] = { "Blood", "Frost", "Unholy" },
    ["Shaman"] = { "Elemental", "Enhancement", "Restoration" },
    ["Mage"] = { "Arcane", "Fire", "Frost" },
    ["Warlock"] = { "Affliction", "Demonology", "Destruction" },
    ["Druid"] = { "Balance", "Feral Combat", "Restoration" },
}

-------------------------------------------------
-- Print
-------------------------------------------------

function ImpLoot:Print(message)

    DEFAULT_CHAT_FRAME:AddMessage(
        "|cff33ff99ImpLoot:|r " .. tostring(message)
    )

end

-------------------------------------------------
-- Event Frame
-------------------------------------------------

ImpLoot.Frame = CreateFrame("Frame")

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot:Initialize()

    -------------------------------------------------
    -- Saved Database
    -------------------------------------------------

    ImpLootDB = ImpLootDB or {}
    ImpLootDB.Players = ImpLootDB.Players or {}

    -------------------------------------------------
    -- Modules
    -------------------------------------------------

    ImpLoot.Player:Initialize()
    ImpLoot.Wishlist:Initialize()
    ImpLoot.Compare:Initialize()
    ImpLoot.ItemCache:Initialize()
    ImpLoot.SoftReserve:Initialize()
    ImpLoot.LootCouncil:Initialize()
    ImpLoot.LootMaster:Initialize()
    ImpLoot.Announcements:Initialize()
    ImpLoot.Comms:Initialize()
    ImpLoot.RaidNotes:Initialize()
    ImpLoot.WindowLayering:Initialize()

    -------------------------------------------------
    -- UI
    -------------------------------------------------

    ImpLoot.UI.MainWindow:Initialize()
    ImpLoot.UI.LootMasterWindow:Initialize()
    ImpLoot.UI.SummaryWindow:Initialize()
    ImpLoot.UI.OptionsPanel:Initialize()
    ImpLoot.UI.MinimapButton:Initialize()
    ImpLoot.UI.ReservePopup:Initialize()
    ImpLoot.UI.VotePopup:Initialize()
    ImpLoot.UI.LootPriorityWindow:Initialize()
    ImpLoot.UI.PopulateModeBar:Initialize()

    ImpLoot.WindowLayering:ApplyAll()

    -------------------------------------------------

    ImpLoot:Print("ImpLoot loaded successfully.")

end

-------------------------------------------------
-- Event Handling
-------------------------------------------------

ImpLoot.Frame:RegisterEvent("ADDON_LOADED")
ImpLoot.Frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

ImpLoot.Frame:SetScript("OnEvent", function(self, event, addonName, itemID, success)

    -------------------------------------------------
    -- Addon Loaded
    -------------------------------------------------

    if event == "ADDON_LOADED" then

        if addonName ~= "ImpLoot" then
            return
        end

        ImpLoot:Initialize()

        return

    end

    -------------------------------------------------
    -- Item Information Received
    -------------------------------------------------

    if event == "GET_ITEM_INFO_RECEIVED" then

        ImpLoot.ItemCache:OnItemInfoReceived(
            itemID,
            success
        )

        return

    end

end)