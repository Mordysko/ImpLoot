-------------------------------------------------
-- Planning Navigation
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.PlanningNavigation = ImpLoot.UI.PlanningNavigation or {}
local Navigation = ImpLoot.UI.PlanningNavigation

-------------------------------------------------
-- Pages
-------------------------------------------------

Navigation.Pages = {

    Root = {

        Id = "Planning",
        Title = "Planning",

        Entries = {
            { Text = "Wishlist",     Page = "Wishlist" },
            { Text = "Characters",   Page = "Characters" },
            { Text = "Raid Planner", Page = "RaidPlanner" },
            { Text = "Raid Notes",   Page = "RaidNotes" },
            { Text = "Settings",     Page = "Settings" },
        },

    },

    Wishlist = {

        Id = "Wishlist",
        Title = "Wishlist",

        Entries = {
            { Text = "< Back", Page = "Root" },
        },

    },

    RaidNotes = {

        Id = "RaidNotes",
        Title = "Raid Notes",

        Entries = {
            { Text = "< Back", Page = "Root" },
        },

    },

    Characters = {

        Id = "Characters",
        Title = "Characters",

        Entries = {
            { Text = "< Back", Page = "Root" },
        },

    },

    RaidPlanner = {

        Id = "RaidPlanner",
        Title = "Raid Planner",

        Entries = {
            { Text = "< Back", Page = "Root" },
        },

    },

}

-------------------------------------------------
-- Current Page
-------------------------------------------------

Navigation.CurrentPage = Navigation.Pages.Root

-------------------------------------------------
-- Set Current Page
-------------------------------------------------

function Navigation:SetPage(pageName)

    local page = self.Pages[pageName]

    if page then
        self.CurrentPage = page
    end

end

-------------------------------------------------
-- Get Current Page
-------------------------------------------------

function Navigation:GetCurrentPage()
    return self.CurrentPage
end
