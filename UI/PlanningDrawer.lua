-------------------------------------------------
-- Planning Drawer
--
-- The sliding tab on the left edge of the main window,
-- driven by PlanningNavigation's page tree.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.PlanningDrawer = ImpLoot.UI.PlanningDrawer or {}
local PlanningDrawer = ImpLoot.UI.PlanningDrawer

PlanningDrawer.IsOpen = false

-------------------------------------------------
-- Initialize
-------------------------------------------------

function PlanningDrawer:Initialize(parent)

    local Theme = ImpLoot.Theme

    -------------------------------------------------
    -- Frame
    -------------------------------------------------

    local frame = CreateFrame("Frame", nil, parent)
    self.Frame = frame

    frame:SetWidth(Theme.Metrics.DrawerWidth)
    frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", -6, -88)
    frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", -6, 88)

    -- Renders BEHIND the main window (both are children
    -- of it, which would otherwise draw the drawer ON
    -- TOP by default) -- makes it look like the drawer
    -- slides out from behind the main window rather than
    -- sitting beside it with two visible edges.
    frame:SetFrameStrata("LOW")

    Theme:ApplyPanelStyle(frame)

    -------------------------------------------------
    -- Handle
    -------------------------------------------------

    local handle = Theme:CreateTabHandle(parent)
    handle:SetPoint("LEFT", parent, "RIGHT", -6, 0)
    self.Handle = handle

    handle:SetScript("OnClick", function()
        self:Toggle()
    end)

    -------------------------------------------------
    -- Navigation Container
    -------------------------------------------------

    local content = CreateFrame("Frame", nil, frame)

    content:SetPoint("TOPLEFT", 10, -10)
    content:SetPoint("TOPRIGHT", -10, -10)
    content:SetPoint("BOTTOMLEFT", 10, 10)
    content:SetPoint("BOTTOMRIGHT", -10, 10)

    self.Content = content
    self.GeneratedWidgets = {}

    -------------------------------------------------

    self:SetOpen(false)

    -------------------------------------------------
    -- Wishlist Events
    -------------------------------------------------

    ImpLoot.Events:Register("WishlistChanged", function()

        self:Refresh()

    end)
end

-------------------------------------------------
-- Refresh
-------------------------------------------------

function PlanningDrawer:Refresh()

    local Navigation = ImpLoot.UI.PlanningNavigation
    local page = Navigation:GetCurrentPage()

    if not page then
        return
    end

    -------------------------------------------------
    -- Clear Previous Content
    -------------------------------------------------

    if self.GeneratedWidgets then

        for _, widget in ipairs(self.GeneratedWidgets) do

            widget:Hide()

            if widget.SetParent then
                widget:SetParent(UIParent)
            end

        end

    end

    self.GeneratedWidgets = {}

    -------------------------------------------------
    -- Title
    -------------------------------------------------

    local title = self.Content:CreateFontString(nil, "OVERLAY")
    title:SetFontObject(ImpLoot.Theme.Fonts.Header)
    title:SetPoint("TOP", 0, 0)
    title:SetText(page.Title)

    table.insert(self.GeneratedWidgets, title)

    -------------------------------------------------
    -- Entries
    -------------------------------------------------

    local previous = title

    for _, entry in ipairs(page.Entries) do

        local button = ImpLoot.Theme:CreateMenuButton(self.Content)
        
        if page.Id == "Wishlist" then

            button:SetSize(120, 22)

            button:SetPoint(
                "TOP",
                self.Content,
                "TOP",
                0,
                -24
            )

        else

            button:SetPoint(
                "TOP",
                previous,
                "BOTTOM",
                0,
                -6
            )

        end

        button:SetText(entry.Text)

        -------------------------------------------------
        -- Arrange By Selection
        -------------------------------------------------

        if page.Id == "Wishlist"
        and (
            entry.Page == "WishlistRaid"
            or entry.Page == "WishlistSlot"
            or entry.Page == "WishlistAll"
        ) then

            local character = ImpLoot.Character:GetViewed()

            if character then

                local wishlist = ImpLoot.Wishlist:GetActive(character)

                if wishlist then

                    local selectedPage

                    if wishlist.ArrangeBy == "RAID" then
                        selectedPage = "WishlistRaid"

                    elseif wishlist.ArrangeBy == "SLOT" then
                        selectedPage = "WishlistSlot"

                    else
                        selectedPage = "WishlistAll"
                    end

                    if entry.Page == selectedPage then
                        button:SetText("> " .. entry.Text)
                    end

                end

            end

        end

        button:SetScript("OnClick", function()

            -------------------------------------------------
            -- Wishlist Arrange By
            -------------------------------------------------

            if page.Id == "Wishlist"
            and (
                entry.Page == "WishlistRaid"
                or entry.Page == "WishlistSlot"
                or entry.Page == "WishlistAll"
            ) then

                local character = ImpLoot.Character:GetViewed()

                if not character then
                    return
                end

                local wishlist = ImpLoot.Wishlist:GetActive(character)

                if not wishlist then
                    return
                end

                -------------------------------------------------
                -- Save Arrange By
                -------------------------------------------------

                if entry.Page == "WishlistRaid" then

                    wishlist.ArrangeBy = "RAID"

                elseif entry.Page == "WishlistSlot" then

                    wishlist.ArrangeBy = "SLOT"

                elseif entry.Page == "WishlistAll" then

                    wishlist.ArrangeBy = "ALL"

                end

                -------------------------------------------------
                -- Notify the addon
                -------------------------------------------------

                ImpLoot.Wishlist:NotifyChanged()

                -------------------------------------------------
                -- Stay on Wishlist
                -------------------------------------------------

                ImpLoot.Workspace:Set("Wishlist")

                ImpLoot.UI.DetailsWorkspace:Refresh()

                self:Refresh()

                return
            end

            -------------------------------------------------
            -- Settings -- jumps to the real Interface
            -- options panel rather than navigating within
            -- our own window.
            -------------------------------------------------

            if entry.Page == "Settings" then

                ImpLoot.UI.OptionsPanel:Open()

                return

            end

            -------------------------------------------------
            -- Normal Navigation
            -------------------------------------------------

            Navigation:SetPage(entry.Page)

            if entry.Page == "Wishlist" then

                ImpLoot.Character:ClearViewed()
                ImpLoot.Workspace:Set("Wishlist")

            elseif entry.Page == "RaidPlanner" then

                ImpLoot.Workspace:Set("RaidPlanner")

            elseif entry.Page == "Root" then

                ImpLoot.Workspace:Set("Details")

            end

            ImpLoot.UI.DetailsWorkspace:Refresh()
            self:Refresh()

        end)

        table.insert(self.GeneratedWidgets, button)
        previous = button

    end

    -------------------------------------------------
    -- Wishlist Manager Buttons
    -------------------------------------------------

    -------------------------------------------------
    -- Wishlist Manager
    -------------------------------------------------

    if page.Id == "Wishlist" then

        -------------------------------------------------
        -- Current Character
        -------------------------------------------------

        local character = ImpLoot.Character:GetViewed()

        local wishlistCount = 0

        if character and character.Wishlists then
            wishlistCount = #character.Wishlists
        end
        
        -------------------------------------------------
        -- Create Wishlist
        -------------------------------------------------

        local createButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        createButton:SetSize(120, 22)

        createButton:SetPoint(
            "TOP",
            previous,
            "BOTTOM",
            0,
            -16
        )

        createButton:SetText("Create Wishlist")

        if wishlistCount >= 7 then
            createButton:Disable()
        else
            createButton:Enable()
        end

        -------------------------------------------------
        -- Hide Create button at maximum
        -------------------------------------------------

        local wishlistCount = 0

        if character and character.Wishlists then
            wishlistCount = #character.Wishlists
        end

        createButton:SetScript("OnClick", function()

            ImpLoot.UI.WishlistDialog:Configure("Create")
            ImpLoot.UI.WishlistDialog:Show()

        end)

        table.insert(
            self.GeneratedWidgets,
            createButton
        )


        -------------------------------------------------
        -- Rename
        -------------------------------------------------

        local renameButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        renameButton:SetSize(55, 22)

        renameButton:SetPoint(
            "TOPLEFT",
            createButton,
            "BOTTOMLEFT",
            0,
            -6
        )

        renameButton:SetText("Rename")

        renameButton:SetScript("OnClick", function()

            local character =
                ImpLoot.Character:GetViewed()

            local active =
                ImpLoot.Wishlist:GetActive(character)

            if not active then
                return
            end

            ImpLoot.UI.WishlistDialog:Configure(
                "Rename",
                active
            )

            ImpLoot.UI.WishlistDialog:Show()

        end)

        table.insert(
            self.GeneratedWidgets,
            renameButton
        )


        -------------------------------------------------
        -- Delete
        -------------------------------------------------

        local deleteButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        deleteButton:SetSize(55, 22)

        deleteButton:SetPoint(
            "LEFT",
            renameButton,
            "RIGHT",
            10,
            0
        )

        deleteButton:SetText("Delete")

        deleteButton:SetScript("OnClick", function()

            local character =
                ImpLoot.Character:GetViewed()

            local active =
                ImpLoot.Wishlist:GetActive(character)

            if not active then
                return
            end

            ImpLoot.UI.WishlistDialog:Configure(
                "Delete",
                active
            )

            ImpLoot.UI.WishlistDialog:Show()

        end)

        table.insert(
            self.GeneratedWidgets,
            deleteButton
        )


        -------------------------------------------------
        -- Show / Hide Rename + Delete
        -------------------------------------------------

        local active = nil

        if character then
            active =
                ImpLoot.Wishlist:GetActive(character)
        end

        if active then

            renameButton:Show()
            deleteButton:Show()

        else

            renameButton:Hide()
            deleteButton:Hide()

        end


        -------------------------------------------------
        -- Wishlist List
        -------------------------------------------------

        local wishlistPrevious = createButton

        if character and character.Wishlists then

            for index, wishlist in ipairs(character.Wishlists) do

                local wishlistButton =
                    ImpLoot.Theme:CreateMenuButton(self.Content)

                wishlistButton:SetSize(120, 22)

                -------------------------------------------------
                -- First wishlist
                -------------------------------------------------

                if index == 1 then

                    wishlistButton:SetPoint(
                        "TOP",
                        wishlistPrevious,
                        "BOTTOM",
                        0,
                        -38
                    )

                else

                    wishlistButton:SetPoint(
                        "TOP",
                        wishlistPrevious,
                        "BOTTOM",
                        0,
                        -2
                    )

                end

                wishlistButton:SetText(
                    wishlist.Name
                )

                local currentActive =
                    ImpLoot.Wishlist:GetActive(character)

                if currentActive == wishlist then

                    wishlistButton:SetText(
                        "> " .. wishlist.Name
                    )

                end

                wishlistButton:SetScript(
                    "OnClick",
                    function()

                        local character =
                            ImpLoot.Character:GetViewed()

                        ImpLoot.Wishlist:SetActive(
                            character,
                            wishlist
                        )

                        ImpLoot.Workspace:Set(
                            "Wishlist"
                        )

                        ImpLoot.UI.DetailsWorkspace:Refresh()

                        self:Refresh()

                    end
                )

                table.insert(
                    self.GeneratedWidgets,
                    wishlistButton
                )

                wishlistPrevious = wishlistButton

            end

        end


        -------------------------------------------------
        -- Arrange By
        -------------------------------------------------

        -------------------------------------------------
        -- All Items
        -------------------------------------------------

        local allButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        allButton:SetSize(120, 22)

        allButton:SetPoint(
            "BOTTOM",
            self.Content,
            "BOTTOM",
            0,
            34
        )

        allButton:SetText("All Items")

        allButton:SetScript("OnClick", function()

            local character =
                ImpLoot.Character:GetViewed()

            if not character then
                return
            end

            local wishlist =
                ImpLoot.Wishlist:GetActive(character)

            if not wishlist then
                return
            end

            wishlist.ArrangeBy = "ALL"

            ImpLoot.Wishlist:NotifyChanged()

            ImpLoot.Workspace:Set("Wishlist")

            ImpLoot.UI.DetailsWorkspace:Refresh()

            self:Refresh()

        end)

        table.insert(
            self.GeneratedWidgets,
            allButton
        )


        -------------------------------------------------
        -- By Raid
        -------------------------------------------------

        local raidButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        raidButton:SetSize(55, 22)

        raidButton:SetPoint(
            "TOPLEFT",
            allButton,
            "BOTTOMLEFT",
            0,
            -6
        )

        raidButton:SetText("By Raid")

        raidButton:SetScript("OnClick", function()

            local character =
                ImpLoot.Character:GetViewed()

            if not character then
                return
            end

            local wishlist =
                ImpLoot.Wishlist:GetActive(character)

            if not wishlist then
                return
            end

            wishlist.ArrangeBy = "RAID"

            ImpLoot.Wishlist:NotifyChanged()

            ImpLoot.Workspace:Set("Wishlist")

            ImpLoot.UI.DetailsWorkspace:Refresh()

            self:Refresh()

        end)

        table.insert(
            self.GeneratedWidgets,
            raidButton
        )


        -------------------------------------------------
        -- By Slot
        -------------------------------------------------

        local slotButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        slotButton:SetSize(55, 22)

        slotButton:SetPoint(
            "LEFT",
            raidButton,
            "RIGHT",
            10,
            0
        )

        slotButton:SetText("By Slot")

        slotButton:SetScript("OnClick", function()

            local character =
                ImpLoot.Character:GetViewed()

            if not character then
                return
            end

            local wishlist =
                ImpLoot.Wishlist:GetActive(character)

            if not wishlist then
                return
            end

            wishlist.ArrangeBy = "SLOT"

            ImpLoot.Wishlist:NotifyChanged()

            ImpLoot.Workspace:Set("Wishlist")

            ImpLoot.UI.DetailsWorkspace:Refresh()

            self:Refresh()

        end)

        table.insert(
            self.GeneratedWidgets,
            slotButton
        )

    end

    -------------------------------------------------
    -- Raid Notes Manager
    --
    -- Exact mirror of the Wishlist Manager above --
    -- Create/Rename/Delete buttons plus a list of
    -- saved note names. Selecting a note makes it
    -- active and opens the text-editing popup
    -- directly (no in-window text area).
    -------------------------------------------------

    if page.Id == "RaidNotes" then

        local character = ImpLoot.Character:GetViewed()

        local noteCount = 0

        if character and character.RaidNotes then
            noteCount = #character.RaidNotes
        end

        -------------------------------------------------
        -- Create Note
        -------------------------------------------------

        local createNoteButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        createNoteButton:SetSize(120, 22)

        createNoteButton:SetPoint(
            "TOP",
            previous,
            "BOTTOM",
            0,
            -16
        )

        createNoteButton:SetText("Create Note")

        if noteCount >= 7 then
            createNoteButton:Disable()
        else
            createNoteButton:Enable()
        end

        createNoteButton:SetScript("OnClick", function()

            ImpLoot.UI.RaidNoteDialog:Configure("Create")
            ImpLoot.UI.RaidNoteDialog:Show()

        end)

        table.insert(self.GeneratedWidgets, createNoteButton)

        -------------------------------------------------
        -- Rename
        -------------------------------------------------

        local renameNoteButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        renameNoteButton:SetSize(55, 22)

        renameNoteButton:SetPoint(
            "TOPLEFT",
            createNoteButton,
            "BOTTOMLEFT",
            0,
            -6
        )

        renameNoteButton:SetText("Rename")

        renameNoteButton:SetScript("OnClick", function()

            local character = ImpLoot.Character:GetViewed()
            local active = ImpLoot.RaidNotes:GetActive(character)

            if not active then
                return
            end

            ImpLoot.UI.RaidNoteDialog:Configure("Rename", active)
            ImpLoot.UI.RaidNoteDialog:Show()

        end)

        table.insert(self.GeneratedWidgets, renameNoteButton)

        -------------------------------------------------
        -- Delete
        -------------------------------------------------

        local deleteNoteButton =
            ImpLoot.Theme:CreateMenuButton(self.Content)

        deleteNoteButton:SetSize(55, 22)

        deleteNoteButton:SetPoint(
            "LEFT",
            renameNoteButton,
            "RIGHT",
            10,
            0
        )

        deleteNoteButton:SetText("Delete")

        deleteNoteButton:SetScript("OnClick", function()

            local character = ImpLoot.Character:GetViewed()
            local active = ImpLoot.RaidNotes:GetActive(character)

            if not active then
                return
            end

            ImpLoot.UI.RaidNoteDialog:Configure("Delete", active)
            ImpLoot.UI.RaidNoteDialog:Show()

        end)

        table.insert(self.GeneratedWidgets, deleteNoteButton)

        -------------------------------------------------
        -- Show / Hide Rename + Delete
        -------------------------------------------------

        local activeNote = nil

        if character then
            activeNote = ImpLoot.RaidNotes:GetActive(character)
        end

        if activeNote then
            renameNoteButton:Show()
            deleteNoteButton:Show()
        else
            renameNoteButton:Hide()
            deleteNoteButton:Hide()
        end

        -------------------------------------------------
        -- Note List
        -------------------------------------------------

        local notePrevious = createNoteButton

        if character and character.RaidNotes then

            for index, note in ipairs(character.RaidNotes) do

                local noteButton =
                    ImpLoot.Theme:CreateMenuButton(self.Content)

                noteButton:SetSize(120, 22)

                if index == 1 then

                    noteButton:SetPoint(
                        "TOP",
                        notePrevious,
                        "BOTTOM",
                        0,
                        -38
                    )

                else

                    noteButton:SetPoint(
                        "TOP",
                        notePrevious,
                        "BOTTOM",
                        0,
                        -2
                    )

                end

                local label = note.Name

                if ImpLoot.RaidNotes:GetActive(character) == note then
                    label = "> " .. label
                end

                noteButton:SetText(label)

                noteButton:SetScript("OnClick", function()

                    local character = ImpLoot.Character:GetViewed()

                    ImpLoot.RaidNotes:SetActive(character, note)

                    ImpLoot.UI.RaidNotesPopup:Show()

                    self:Refresh()

                end)

                table.insert(self.GeneratedWidgets, noteButton)

                notePrevious = noteButton

            end

        end

    end

    -------------------------------------------------
    -- Characters
    --
    -- View/edit-only -- selecting one only changes
    -- which character's wishlist is shown, nothing
    -- about the actually logged-in character.
    -------------------------------------------------

    if page.Id == "Characters" then

        local actualCurrent = ImpLoot.Character:GetCurrent()

        for _, character in ipairs(ImpLoot.Character:GetAllCharacters()) do

            if character.Wishlists and #character.Wishlists > 0 then

            local characterButton = ImpLoot.Theme:CreateMenuButton(self.Content)

            characterButton:SetSize(120, 22)

            characterButton:SetPoint(
                "TOP",
                previous,
                "BOTTOM",
                0,
                -6
            )

            local label = character.Name

            if actualCurrent and character.Name == actualCurrent.Name then
                label = label .. " (you)"
            end

            characterButton:SetText(label)

            characterButton:SetScript("OnClick", function()

                ImpLoot.Character:SetViewed(character.Name)

                Navigation:SetPage("Wishlist")
                ImpLoot.Workspace:Set("Wishlist")

                ImpLoot.UI.DetailsWorkspace:Refresh()
                self:Refresh()

            end)

            table.insert(self.GeneratedWidgets, characterButton)
            previous = characterButton

            end

        end

    end

end

-------------------------------------------------
-- Toggle
-------------------------------------------------

function PlanningDrawer:Toggle()
    self:SetOpen(not self.IsOpen)
end

-------------------------------------------------
-- Set Open State
-------------------------------------------------

function PlanningDrawer:SetOpen(open)

    self.IsOpen = open

    ImpLoot.Theme:SetTabDirection(self.Handle, open)

    if open then

        self.Frame:Show()

        self.Handle:ClearAllPoints()
        self.Handle:SetPoint("LEFT", self.Frame, "RIGHT", -6, 0)

    else

        self.Handle:ClearAllPoints()
        self.Handle:SetPoint("LEFT", ImpLoot.UI.MainWindow.Frame, "RIGHT", -2, 0)

        self.Frame:Hide()

    end

end
