-------------------------------------------------
-- Workspace Manager
--
-- Tracks which workspace the details panel should show
-- (e.g. "Details" or "Wishlist"). UI\DetailsWorkspace.lua
-- reads this to decide what to display.
-------------------------------------------------

ImpLoot.Workspace = {}

local Workspace = ImpLoot.Workspace

Workspace.Current = "Details"

-------------------------------------------------
-- Set Workspace
-------------------------------------------------

function Workspace:Set(workspace)

    self.Current = workspace

end

-------------------------------------------------
-- Get Workspace
-------------------------------------------------

function Workspace:Get()

    return self.Current

end
