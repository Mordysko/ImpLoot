-------------------------------------------------
-- ImpLoot Slash Commands
-------------------------------------------------

SLASH_IMPLOOT1 = "/imploot"
SLASH_IMPLOOT2 = "/il"

-------------------------------------------------
-- Open Options To Panel
--
-- InterfaceOptionsFrame_OpenToCategory has a known
-- Blizzard quirk where the first call after login
-- sometimes doesn't actually select the category --
-- calling it twice is the standard workaround.
-------------------------------------------------

local function OpenOptionsToPanel(panel)

    if not panel or not InterfaceOptionsFrame_OpenToCategory then
        return false
    end

    InterfaceOptionsFrame_OpenToCategory(panel)
    InterfaceOptionsFrame_OpenToCategory(panel)

    return true

end

SlashCmdList["IMPLOOT"] = function(msg)

    msg = msg and msg:gsub("^%s+", ""):gsub("%s+$", "") or ""

    local command, rest = msg:match("^(%S*)%s*(.-)$")
    command = (command or ""):lower()
    rest = (rest or ""):lower()

    if command == "config" or command == "options" or command == "help" then

        local opened = OpenOptionsToPanel(
            ImpLoot.UI
            and ImpLoot.UI.OptionsPanel
            and ImpLoot.UI.OptionsPanel.MainPanel
        )

        if not opened then
            print("|cffff0000ImpLoot: Options panel not available.|r")
        end

        return

    end

    if command == "reset" then

        if rest == "confirm" then

            if ImpLoot.LootMaster and ImpLoot.LootMaster.ResetSettingsToDefaults then
                ImpLoot.LootMaster:ResetSettingsToDefaults()
            end

            if ImpLoot.SoftReserve and ImpLoot.SoftReserve.ResetSettingsToDefaults then
                ImpLoot.SoftReserve:ResetSettingsToDefaults()
            end

            if ImpLoot.Announcements and ImpLoot.Announcements.ResetAllToDefaults then
                ImpLoot.Announcements:ResetAllToDefaults()
            end

            if ImpLoot.WindowLayering and ImpLoot.WindowLayering.ResetSettingsToDefaults then
                ImpLoot.WindowLayering:ResetSettingsToDefaults()
            end

            ImpLoot:Print("All settings have been reset to default.")

        else

            ImpLoot:Print(
                "This will reset all ImpLoot settings to their defaults " ..
                "(wishlists, raid notes, and the loot council roster are " ..
                "not affected). Type |cffffff00/il reset confirm|r to proceed."
            )

        end

        return

    end

    if msg ~= "" then

        if ImpLoot.LootMaster
        and ImpLoot.LootMaster.AddManualItem then

            local ok, message = ImpLoot.LootMaster:AddManualItem(msg)

            ImpLoot:Print(message)

        else

            print("|cffff0000ImpLoot: Loot Master not available.|r")

        end

        return

    end

    if ImpLoot
    and ImpLoot.UI
    and ImpLoot.UI.MainWindow
    and ImpLoot.UI.MainWindow.Toggle then

        ImpLoot.UI.MainWindow:Toggle()

    else

        print("|cffff0000ImpLoot: UI not available.|r")

    end

end
