-------------------------------------------------
-- ImpLoot Loot Master
--
-- The corpse-side (and post-corpse "tracking") loot
-- queue. Populates itself from the real loot window,
-- decides each item's mode (Open Roll / Soft Reserve /
-- Loot Council) from the existing data modules, and
-- handles assignment -- via the real Master Loot API
-- while the corpse it came from is still open, falling
-- back to "just record the winner, trade manually"
-- once it isn't.
-------------------------------------------------

ImpLoot.LootMaster = {}

-------------------------------------------------
-- Roll Settings
--
-- Main Spec is a standard /roll (1-100); Off Spec is
-- the Off-Spec Roll button's 1-99 -- classified by the
-- roll's own upper bound, not a configurable threshold.
-------------------------------------------------

-------------------------------------------------
-- Settings Defaults
--
-- Persisted like everything else -- see Initialize.
-------------------------------------------------

ImpLoot.LootMaster.Defaults = {

    RollDuration = 30,
    PeriodicAnnounceInterval = 10,
    FinalCountdownThreshold = 5,

    AutoFinalizeOnTimeout = true,
    AutoAssignToRollWinner = true,
    AutoClearOnNewBoss = false,

    -- 0 (Poor) means no filtering at all -- every item
    -- that drops is queued, exactly like before this
    -- setting existed. Only items that would otherwise
    -- fall through to unassigned Open Roll are affected;
    -- see ShouldQueueItem below.
    MinimumQuality = 0,

    -- When true, /il <item> skips landing in the queue
    -- for a manual Announce click and immediately starts
    -- its roll/announcement instead -- whatever mode the
    -- item actually resolves to (SoftReserve, LootCouncil,
    -- or Open Roll), same as clicking Announce yourself
    -- would. Default false preserves the original /il
    -- behaviour of just adding it to the queue.
    ManualItemAutoRoll = false,

}

-------------------------------------------------
-- Legendary Assignment Confirmation
--
-- Legendary-quality items (Fragment of Val'anyr, etc.)
-- get an extra manual confirmation step before the
-- actual assignment happens -- a single misclick handing
-- one to the wrong person is a mistake that can't be
-- undone once it's looted/traded. Auto-Assign To Roll
-- Winner still picks the winner automatically for these;
-- it just pauses on this step instead of assigning
-- outright, same as a manual assignment would.
--
-- Deliberately NOT applied to every item -- that would
-- make Auto-Assign To Roll Winner largely pointless,
-- since every award would need a manual click-through
-- regardless. Scoped to quality 5 (Legendary) specifically.
-------------------------------------------------

StaticPopupDialogs["IMPLOOT_CONFIRM_LEGENDARY_ASSIGN"] = {

    text = "Award %s to %s?\n\nThis is a Legendary item and cannot be undone once assigned.",
    button1 = "Award",
    button2 = "Cancel",

    OnAccept = function(_, data)
        ImpLoot.LootMaster:Assign(data.QueueID, data.WinnerName, data.ClassSlot)
    end,

    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,

}

-------------------------------------------------
-- Get Item Quality
--
-- Checks the addon's own raid database first (it's
-- pre-populated for every boss and doesn't depend on
-- the item having been seen/cached this session), then
-- falls back to the general item cache for anything not
-- in that database (e.g. a Trash/Extra Drops item, or
-- something from outside the addon's known raids).
-------------------------------------------------

function ImpLoot.LootMaster:GetItemQuality(itemID)

    local item = ImpLoot.Database:FindItemByID(itemID)

    if item and item.Quality then
        return item.Quality
    end

    local cached = ImpLoot.ItemCache:GetItem(itemID)

    if cached and cached.Quality then
        return cached.Quality
    end

    return nil

end

-------------------------------------------------
-- Get Player Item Count
--
-- How many times a player has already won a specific
-- item this session, per the resolution log. Built for
-- multi-piece Legendary components (Fragment of Val'anyr
-- and similar) -- shown next to a candidate's name so
-- whoever's assigning has that context in view at the
-- moment of the decision, rather than needing to
-- remember it or check the Summary window separately.
-------------------------------------------------

function ImpLoot.LootMaster:GetPlayerItemCount(playerName, itemID)

    local count = 0

    for _, logEntry in ipairs(self:GetSessionLog()) do

        if logEntry.Winner == playerName and logEntry.ItemID == itemID then
            count = count + 1
        end

    end

    return count

end

-------------------------------------------------
-- Request Assign
--
-- The entry point every caller (manual Assign button,
-- Auto-Assign To Roll Winner, the no-rolls disenchant
-- path) should use instead of calling Assign directly.
-- Legendary items pause here for manual confirmation;
-- everything else assigns immediately exactly as before.
-------------------------------------------------

-- `classSlot` (optional) is the class name when the winner
-- was picked from a Loot Priority class slot ("Any Warrior"),
-- so the win is logged against that slot (see
-- RecordWinForExclusion).
function ImpLoot.LootMaster:RequestAssign(queueID, winnerName, classSlot)

    local entry = self:GetEntry(queueID)

    if not entry then
        return
    end

    local quality = self:GetItemQuality(entry.ItemID)

    if quality == 5 then

        StaticPopup_Show(
            "IMPLOOT_CONFIRM_LEGENDARY_ASSIGN",
            entry.ItemLink or entry.ItemID,
            winnerName,
            { QueueID = queueID, WinnerName = winnerName, ClassSlot = classSlot }
        )

        return

    end

    self:Assign(queueID, winnerName, classSlot)

end

-------------------------------------------------
-- Assign Sole Reserver
--
-- The one-click path for a SoftReserve item nobody else
-- could possibly win (see SoftReserve:GetSoleReserver) --
-- announces the direct assignment to chat first, since
-- skipping the roll shouldn't also mean skipping letting
-- the raid know who got it and why, then goes through
-- the same RequestAssign path (legendary confirmation
-- included) as every other assignment.
-------------------------------------------------

function ImpLoot.LootMaster:AssignSoleReserver(queueID, winnerName)

    local entry = self:GetEntry(queueID)

    if not entry then
        return
    end

    ImpLoot.Announcements:Announce("SoleReserverAssigned", {
        item = entry.ItemLink,
        winner = winnerName,
    })

    entry.AssignNote = "Only reserver"

    self:RequestAssign(queueID, winnerName)

end

-------------------------------------------------
-- Roll Message Pattern
--
-- Matches WoW's own system message: "<Player> rolls
-- <roll> (<min>-<max>)".
-------------------------------------------------

local ROLL_PATTERN = "(.+) rolls (%d+) %((%d+)%-(%d+)%)"

-------------------------------------------------
-- Initialize
-------------------------------------------------

function ImpLoot.LootMaster:Initialize()

    ImpLootDB.LootMasterSettings = ImpLootDB.LootMasterSettings or {}

    for key, value in pairs(self.Defaults) do

        if ImpLootDB.LootMasterSettings[key] == nil then
            ImpLootDB.LootMasterSettings[key] = value
        end

    end

    self.Settings = ImpLootDB.LootMasterSettings

    ImpLootDB.LootMasterLog = ImpLootDB.LootMasterLog or {}
    self.Log = ImpLootDB.LootMasterLog

    -- Every history entry gets a permanent Id (for editing and
    -- syncing later). Entries saved before Ids existed get one now.
    ImpLootDB.LootMasterLogNextId = ImpLootDB.LootMasterLogNextId or 1

    for _, logEntry in ipairs(self.Log) do

        if not logEntry.Id then
            logEntry.Id = ImpLootDB.LootMasterLogNextId
            ImpLootDB.LootMasterLogNextId = ImpLootDB.LootMasterLogNextId + 1
        elseif logEntry.Id >= ImpLootDB.LootMasterLogNextId then
            ImpLootDB.LootMasterLogNextId = logEntry.Id + 1
        end

    end

    self.Queue = {}
    self.NextQueueID = 1
    self.CurrentCorpseGUID = nil
    self.ActiveRollQueueID = nil

    local frame = CreateFrame("Frame")

    frame:RegisterEvent("LOOT_OPENED")
    frame:RegisterEvent("LOOT_CLOSED")
    frame:RegisterEvent("CHAT_MSG_SYSTEM")

    frame:SetScript("OnEvent", function(_, event, msg)

        if event == "LOOT_OPENED" then
            self:OnLootOpened()
        elseif event == "LOOT_CLOSED" then
            self:OnLootClosed()
        elseif event == "CHAT_MSG_SYSTEM" then
            self:OnChatMsgSystem(msg)
        end

    end)

    self.EventFrame = frame

    -------------------------------------------------
    -- Timer Ticking
    --
    -- Runs every 0.5s rather than every frame -- a
    -- roll countdown doesn't need frame-rate precision.
    -- OnTimerTick reads GetTime() itself rather than
    -- accumulating elapsed time, so it's also directly
    -- callable (e.g. from tests) without a real OnUpdate
    -- loop.
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
-- Reset Settings To Defaults
--
-- Mutates the existing Settings table in place
-- (rather than replacing it) so the options panel's
-- already-built widgets -- whose getValue/setValue
-- closures reference this exact table -- immediately
-- reflect the reset values without needing a UI reload.
-------------------------------------------------

function ImpLoot.LootMaster:ResetSettingsToDefaults()

    for key, value in pairs(self.Defaults) do
        self.Settings[key] = value
    end

end

-------------------------------------------------
-- Extract Item ID
-------------------------------------------------

function ImpLoot.LootMaster:ExtractItemID(itemLink)

    if not itemLink then
        return nil
    end

    local itemID = itemLink:match("item:(%d+)")

    return itemID and tonumber(itemID) or nil

end

-------------------------------------------------
-- Is Master Looter
-------------------------------------------------

function ImpLoot.LootMaster:IsMasterLooter()

    if not GetLootMethod then
        return false
    end

    local method, partyIndex, raidIndex = GetLootMethod()

    if method ~= "master" then
        return false
    end

    local playerName = UnitName("player")

    if raidIndex and raidIndex > 0 then

        local raidName = GetRaidRosterInfo and GetRaidRosterInfo(raidIndex)

        return raidName == playerName

    end

    if partyIndex and partyIndex > 0 then

        return UnitName("party" .. partyIndex) == playerName

    end

    -- partyIndex/raidIndex of 0 means the player themselves
    return true

end

-------------------------------------------------
-- Determine Mode
--
-- Loot Council takes priority over Soft Reserve if
-- an item somehow ends up tagged as both.
-------------------------------------------------

function ImpLoot.LootMaster:DetermineMode(itemID)

    local listName = ImpLoot.LootCouncil:GetActiveListName()

    if listName and ImpLoot.LootCouncil:IsCouncilItem(listName, itemID) then
        return "LootCouncil"
    end

    if #ImpLoot.SoftReserve:GetReserves(itemID) > 0 then
        return "SoftReserve"
    end

    return "OpenRoll"

end

-------------------------------------------------
-- Reevaluate Pending Modes
--
-- After the active priority list changes, items still
-- waiting in the queue are sorted again: onto the new
-- list's Loot Council handling, or off it to Soft
-- Reserve / open roll. Anything already rolling, voting
-- or assigned is left alone.
-------------------------------------------------

function ImpLoot.LootMaster:ReevaluatePendingModes()

    for _, entry in ipairs(self.Queue or {}) do

        if entry.State == "Pending" then
            entry.Mode = self:DetermineMode(entry.ItemID)
        end

    end

    ImpLoot.Events:Fire("LootQueueChanged")

end

-------------------------------------------------
-- Should Queue Item
--
-- The Minimum Quality setting only ever applies to an
-- item that isn't spoken for anywhere else in the addon.
-- Anything already on the priority list (Loot Council,
-- any mode) or Soft Reserved takes precedence over the
-- quality filter completely and always gets queued --
-- the filter only has a say for whatever's left, which
-- would otherwise just fall through to an unassigned
-- Open Roll. Below the configured minimum, those get
-- quietly skipped instead of ever reaching the queue;
-- at or above it, they're queued and handled exactly as
-- they always have been.
-------------------------------------------------

function ImpLoot.LootMaster:ShouldQueueItem(itemID, slotQuality)

    if self:DetermineMode(itemID) ~= "OpenRoll" then
        return true
    end

    local minimum = self.Settings.MinimumQuality or 0

    if minimum <= 0 then
        return true
    end

    local quality = slotQuality or self:GetItemQuality(itemID)

    if not quality then
        -- Unknown quality -- never silently hide an item
        -- we can't actually confirm falls below the bar.
        return true
    end

    return quality >= minimum

end

-------------------------------------------------
-- On Loot Opened
--
-- Scans every item slot in the loot window that just
-- opened. New items become new queue entries; items
-- already queued from a PREVIOUS opening of this same
-- corpse (e.g. it was closed and reopened) just get
-- their slot index refreshed rather than duplicated.
-------------------------------------------------

function ImpLoot.LootMaster:OnLootOpened()

    -------------------------------------------------
    -- Corpse Or Chest
    --
    -- A dead NPC targeted while looting is the corpse.
    -- Anything else (a chest: Gunship, Dreamwalker, the
    -- Ulduar keepers...) is named after the boss that
    -- drops these items -- the one just killed if it
    -- drops them (see LootHistory:GuessBoss) -- so
    -- reopening the same chest still matches its own
    -- queue entries.
    -------------------------------------------------

    -------------------------------------------------
    -- Which Corpse / Chest Is This?
    --
    -- Needs to come out the same every time the SAME
    -- loot is opened, whatever you happen to have
    -- targeted -- otherwise walking away and reopening a
    -- boss looked like a new boss (and Auto-clear wiped
    -- the queue, rolls in progress included).
    --
    --   A raid boss (by name, whether you targeted the
    --   corpse or not): "boss:<name>"
    --   Any other targeted corpse (trash): its own GUID
    --   Anything else, e.g. an untargeted chest: the boss
    --   whose loot table has these items, or "unknown"
    -------------------------------------------------

    local corpseGUID, bossName

    local targetIsCorpse = UnitExists and UnitExists("target")
        and UnitIsDead and UnitIsDead("target")
        and not (UnitIsPlayer and UnitIsPlayer("target"))

    if targetIsCorpse then
        bossName = UnitName("target")
    end

    local numItems = GetNumLootItems and GetNumLootItems() or 0

    local function KnownBoss(name)
        return name and ImpLoot.LootHistory and ImpLoot.LootHistory:IsKnownBoss(name)
    end

    if not KnownBoss(bossName) then

        local firstItemID = nil

        for slot = 1, numItems do

            if LootSlotIsItem(slot) then
                firstItemID = self:ExtractItemID(GetLootSlotLink(slot))
                if firstItemID then break end
            end

        end

        local guessed = firstItemID and ImpLoot.LootHistory and ImpLoot.LootHistory:GuessBoss(firstItemID)

        if guessed and guessed ~= "Trash" then
            bossName = guessed
        elseif not targetIsCorpse then
            bossName = nil
        end

    end

    if KnownBoss(bossName) then
        corpseGUID = "boss:" .. bossName
    elseif targetIsCorpse then
        corpseGUID = UnitGUID("target")
    else
        corpseGUID = "chest:" .. (bossName or "unknown")
    end

    -------------------------------------------------
    -- Auto-Clear On New Boss
    --
    -- Only for a genuinely different boss/corpse (see
    -- above), and never while something is still being
    -- rolled or voted on -- that would throw the roll
    -- away. Then it waits, and says so.
    -------------------------------------------------

    if self.Settings.AutoClearOnNewBoss
    and self.CurrentCorpseGUID
    and self.CurrentCorpseGUID ~= corpseGUID
    and #self.Queue > 0 then

        local busy = false

        for _, entry in ipairs(self.Queue) do
            if entry.State == "Rolling" or entry.State == "Voting" then
                busy = true
                break
            end
        end

        if busy then
            ImpLoot:Print("New boss looted -- the queue wasn't cleared because a roll or vote is still in progress.")
        else
            self:ClearQueue()
            ImpLoot:Print("New boss detected -- loot queue cleared.")
        end

    end

    self.CurrentCorpseGUID = corpseGUID

    -------------------------------------------------
    -- Track which existing queue entries get matched
    -- THIS pass, so two genuinely separate copies of the
    -- same item dropping together (same corpse, same
    -- itemID, different loot slots) each get their own
    -- queue entry instead of the second slot silently
    -- overwriting the first's LootSlot. Reopening the
    -- SAME corpse later (a separate OnLootOpened call)
    -- still correctly upserts against those now-settled
    -- entries, since this tracking only exists for the
    -- duration of a single pass.
    -------------------------------------------------

    local matchedThisPass = {}
    local newLinks = {}

    for slot = 1, numItems do

        if LootSlotIsItem(slot) then

            local link = GetLootSlotLink(slot)
            local itemID = self:ExtractItemID(link)

            if itemID then

                local _, _, _, _, slotQuality = GetLootSlotInfo(slot)

                if self:ShouldQueueItem(itemID, slotQuality) then

                    local nextIdBefore = self.NextQueueID
                    local entry = self:AddToQueue(itemID, link, bossName, corpseGUID, slot, matchedThisPass)
                    matchedThisPass[entry.QueueID] = true

                    -- New this time (not a reopened corpse's item)
                    if entry.QueueID >= nextIdBefore then
                        table.insert(newLinks, link)
                    end

                end

            end

        end

    end

    if #newLinks > 0 and self:IsMasterLooter() then
        self:AnnounceDrops(bossName, newLinks)
    end

    -- Items won while the loot was closed: hand them over
    -- now (with Auto-assign on), or the row offers Assign
    if self.Settings.AutoAssignToRollWinner then

        for _, entry in ipairs(self.Queue) do

            if entry.State == "Awarded" and entry.CorpseGUID == corpseGUID and entry.Assignable then
                self:GiveAwarded(entry.QueueID, true)
            end

        end

    end

end

-------------------------------------------------
-- Announce Drops
--
-- "Loot from Lord Marrowgar: [item] [item] ..." in raid
-- chat, once per corpse or chest (reopening it only
-- posts items that weren't there before -- normally
-- none). Split over several lines if the links don't
-- fit in one chat message. On/off, wording and channel
-- are in Options -> Announcements ("Boss Loot Posted").
-------------------------------------------------

local CHAT_LIMIT = 250

function ImpLoot.LootMaster:AnnounceDrops(bossName, links)

    local Announcements = ImpLoot.Announcements
    local settings = Announcements:GetSettings("LootDropsAnnounced")

    if not settings or not settings.Enabled then
        return
    end

    local boss = bossName or "the chest"
    local line = ""

    local function Fits(items)
        local text = Announcements:FormatText("LootDropsAnnounced", { boss = boss, items = items })
        return text and #text <= CHAT_LIMIT
    end

    for _, link in ipairs(links) do

        local candidate = (line == "") and link or (line .. " " .. link)

        if line ~= "" and not Fits(candidate) then
            Announcements:Announce("LootDropsAnnounced", { boss = boss, items = line })
            line = link
        else
            line = candidate
        end

    end

    if line ~= "" then
        Announcements:Announce("LootDropsAnnounced", { boss = boss, items = line })
    end

end

-------------------------------------------------
-- On Loot Closed
--
-- Every entry tied to the corpse that just closed
-- loses its slot index -- it can no longer be
-- assigned via the real API, only recorded for a
-- manual trade, unless this same corpse gets reopened
-- (handled by the upsert in AddToQueue/OnLootOpened).
-------------------------------------------------

function ImpLoot.LootMaster:OnLootClosed()

    for _, entry in ipairs(self.Queue) do

        if entry.CorpseGUID == self.CurrentCorpseGUID then

            entry.Assignable = false
            entry.LootSlot = nil

        end

    end

    ImpLoot.Events:Fire("LootQueueChanged")

end

-------------------------------------------------
-- Add To Queue (Upsert)
-------------------------------------------------

function ImpLoot.LootMaster:AddToQueue(itemID, itemLink, bossName, corpseGUID, lootSlot, matchedThisPass)

    for _, entry in ipairs(self.Queue) do

        if entry.ItemID == itemID
        and entry.CorpseGUID == corpseGUID
        and entry.State ~= "Resolved"
        and not (matchedThisPass and matchedThisPass[entry.QueueID]) then

            entry.LootSlot = lootSlot
            entry.Assignable = (lootSlot ~= nil)

            ImpLoot.Events:Fire("LootQueueChanged")

            return entry

        end

    end

    local entry = {

        QueueID = self.NextQueueID,
        ItemID = itemID,
        ItemLink = itemLink,
        BossName = bossName,
        CorpseGUID = corpseGUID,
        LootSlot = lootSlot,
        Assignable = (lootSlot ~= nil),

        Mode = self:DetermineMode(itemID),
        State = "Pending",

        Rolls = {},
        Winner = nil,
        TradeOnly = false,

    }

    self.NextQueueID = self.NextQueueID + 1

    table.insert(self.Queue, entry)

    ImpLoot.Events:Fire("LootQueueChanged")

    return entry

end

-------------------------------------------------
-- Add Manual Item
--
-- For anything that doesn't come through the loot
-- window on its own (currency, recipes, an item that
-- somehow didn't get picked up automatically): /il
-- <item link or name>. Accepts a pasted item link
-- (shift-click, always works) or a plain name (only
-- resolves if the client already knows about it --
-- e.g. it was just sitting in the loot window).
--
-- Goes into the exact same queue as corpse loot, with
-- no loot slot of its own -- so it behaves like any
-- other item whose corpse has already closed: trade-
-- only, never eligible for the real Master Loot API.
-------------------------------------------------

function ImpLoot.LootMaster:AddManualItem(text)

    if not text or text == "" then
        return false, "Usage: /il <item link or name>"
    end

    local itemID = self:ExtractItemID(text)
    local itemLink = itemID and text or nil

    if not itemID then

        local name, link = GetItemInfo(text)

        if link then
            itemLink = link
            itemID = self:ExtractItemID(link)
        end

    end

    if not itemID then

        return false,
            "Couldn't find \"" .. text .. "\" -- try pasting the item link " ..
            "(shift-click it) instead of typing the name."

    end

    local bossName = nil

    if UnitExists and UnitExists("target") then
        bossName = UnitName("target")
    end

    local entry = self:AddToQueue(itemID, itemLink, bossName, nil, nil)

    if self.Settings.ManualItemAutoRoll then

        local ok, message = self:AnnounceItem(entry.QueueID)

        if ok then
            return true, "Started the roll for " .. itemLink .. "."
        end

        -- Announcing failed for some reason (e.g. already
        -- rolling/resolved) -- the item's still safely in
        -- the queue either way, so fall through to the
        -- normal "added to the queue" message below rather
        -- than leaving the person with no feedback at all.

    end

    return true, "Added " .. itemLink .. " to the loot queue."

end

-------------------------------------------------
-- Get Queue / Get Entry / Remove
-------------------------------------------------

function ImpLoot.LootMaster:GetQueue()
    return self.Queue
end

function ImpLoot.LootMaster:GetEntry(queueID)

    for _, entry in ipairs(self.Queue) do

        if entry.QueueID == queueID then
            return entry
        end

    end

    return nil

end

function ImpLoot.LootMaster:RemoveFromQueue(queueID)

    for i, entry in ipairs(self.Queue) do

        if entry.QueueID == queueID then

            table.remove(self.Queue, i)

            ImpLoot.Events:Fire("LootQueueChanged")

            return true

        end

    end

    return false

end

function ImpLoot.LootMaster:ClearQueue()
    self.Queue = {}
    self.ActiveRollQueueID = nil
    ImpLoot.Events:Fire("LootQueueChanged")
end

-------------------------------------------------
-- Format Reserver List
--
-- "Jayallday (x3), Testing" -- based on who's still
-- actually eligible to roll (remaining slots), not
-- the raw import list, so an already-excluded winner
-- never shows as if they can still roll.
-------------------------------------------------

function ImpLoot.LootMaster:FormatReserverList(itemID)

    local slots = ImpLoot.SoftReserve:GetRemainingSlots(itemID)

    -------------------------------------------------
    -- Absent Reservers Aren't Shown Here
    --
    -- Someone who reserved an item but isn't actually
    -- in the raid wasn't there for the kill and isn't
    -- eligible for the loot, so there's no reason to
    -- list them in what the loot master sees -- unlike
    -- the chat announcement, which marks them instead
    -- (see FormatReserverListForAnnouncement), this is
    -- purely about who can actually win it.
    -------------------------------------------------

    local presentSlots = {}

    for _, slot in ipairs(slots) do

        if self:IsPlayerPresent(slot.Player) then
            table.insert(presentSlots, slot)
        end

    end

    if #presentSlots == 0 then
        return "No SoftRes"
    end

    local counts = {}
    local order = {}

    for _, slot in ipairs(presentSlots) do

        if not counts[slot.Player] then
            counts[slot.Player] = 0
            table.insert(order, slot.Player)
        end

        counts[slot.Player] = counts[slot.Player] + 1

    end

    local parts = {}

    for _, player in ipairs(order) do

        if counts[player] > 1 then
            table.insert(parts, player .. " (x" .. counts[player] .. ")")
        else
            table.insert(parts, player)
        end

    end

    return self:JoinWithAmpersand(parts)

end

-------------------------------------------------
-- Format Reserver List For Announcement
--
-- The chat-facing counterpart to FormatReserverList:
-- everyone still gets named here (so people who were
-- about to sit out an item they reserved know why), but
-- anyone not actually in the raid is marked "- Absent"
-- rather than silently left off a message the whole
-- raid sees.
-------------------------------------------------

function ImpLoot.LootMaster:FormatReserverListForAnnouncement(itemID)

    local slots = ImpLoot.SoftReserve:GetRemainingSlots(itemID)

    if #slots == 0 then
        return "No SoftRes"
    end

    local counts = {}
    local order = {}

    for _, slot in ipairs(slots) do

        if not counts[slot.Player] then
            counts[slot.Player] = 0
            table.insert(order, slot.Player)
        end

        counts[slot.Player] = counts[slot.Player] + 1

    end

    local parts = {}

    for _, player in ipairs(order) do

        local label = player

        if counts[player] > 1 then
            label = label .. " (x" .. counts[player] .. ")"
        end

        if not self:IsPlayerPresent(player) then
            label = "(" .. label .. " - Absent)"
        end

        table.insert(parts, label)

    end

    return self:JoinWithAmpersand(parts)

end

-------------------------------------------------
-- Join With Ampersand
--
-- "Brad" / "Brad & Knightdeath" / "Brad, Knightdeath, & Moradladdy" --
-- comma-separated with an Oxford-comma "&" before
-- the last name.
-------------------------------------------------

function ImpLoot.LootMaster:JoinWithAmpersand(parts)

    if #parts == 0 then
        return ""
    elseif #parts == 1 then
        return parts[1]
    elseif #parts == 2 then
        return parts[1] .. " & " .. parts[2]
    end

    local allButLast = {}

    for i = 1, #parts - 1 do
        table.insert(allButLast, parts[i])
    end

    return table.concat(allButLast, ", ") .. " & " .. parts[#parts]

end

-------------------------------------------------
-- Get Reserver Name List
--
-- Unique remaining-eligible names, plain array (for
-- the addon broadcast) -- as opposed to
-- FormatReserverList's "Name (xN)" display text.
-------------------------------------------------

function ImpLoot.LootMaster:GetReserverNameList(itemID)

    local slots = ImpLoot.SoftReserve:GetRemainingSlots(itemID)
    local seen = {}
    local names = {}

    for _, slot in ipairs(slots) do

        if not seen[slot.Player] then
            seen[slot.Player] = true
            table.insert(names, slot.Player)
        end

    end

    return names

end

-------------------------------------------------
-- Announce Item
--
-- Sends the "here's who's reserved this" message,
-- then opens it for rolling and sends the "roll now"
-- message -- each independently toggleable/customizable
-- via Modules/Announcements.lua. Loot Council items
-- aren't announced this way; they use LC Vote instead
-- (not built yet).
-------------------------------------------------

-------------------------------------------------
-- Token Class Groupings
--
-- Standard WotLK tier token groups. Tokens
-- (Type == "TIER_TOKEN") have no Classes field of their
-- own, since any class in the group can turn them in --
-- which group a token belongs to comes from the group word
-- (Conqueror / Protector / Vanquisher) in its name, whether
-- worded "Vanquisher's Mark of..." or "Mantle of the Lost
-- Vanquisher". That matching lives in
-- SoftReserve:GetItemClasses, which reads this table; only
-- items flagged as tokens are read that way, so an ordinary
-- drop that happens to share one of those words is never
-- mistaken for a token.
-------------------------------------------------

local TOKEN_CLASS_GROUPS = {
    { Prefix = "Conqueror's ", Classes = { "Paladin", "Priest", "Warlock" } },
    { Prefix = "Protector's ", Classes = { "Warrior", "Hunter", "Shaman" } },
    { Prefix = "Vanquisher's ", Classes = { "Rogue", "Death Knight", "Mage", "Druid" } },
}

ImpLoot.LootMaster.TokenClassGroups = TOKEN_CLASS_GROUPS

-- `copies` (optional) is how many copies are being rolled
-- for together as one group (see StartGroupRoll) -- the
-- chat announcement then reads "[Item] x2" so the raid
-- knows one roll covers every copy.
-------------------------------------------------
-- One Roll At A Time
--
-- While an item is being rolled for (or several copies
-- of one item, rolled together), no other roll can be
-- started: its Open Roll / Announce button is greyed
-- out and starting one any other way is refused, until
-- the current roll has finished (its timer, or its own
-- Stop). A tie reroll is the same roll carrying on.
-------------------------------------------------

-- The entry currently being rolled for, or nil
function ImpLoot.LootMaster:GetRollInProgress()

    for _, entry in ipairs(self.Queue or {}) do

        if entry.State == "Rolling" then
            return entry
        end

    end

    return nil

end

function ImpLoot.LootMaster:AnnounceItem(queueID, copies)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    local busy = self:GetRollInProgress()

    if busy and busy.QueueID ~= queueID then
        return false, "Finish the roll on " .. (busy.ItemLink or "the current item") .. " first -- one roll at a time."
    end

    local announcedLink = entry.ItemLink

    if copies and copies > 1 then
        announcedLink = (entry.ItemLink or "") .. " x" .. copies
    end

    -------------------------------------------------
    -- Who Can Use It (Open Roll Only)
    --
    -- Tier tokens and class-locked gear name their classes
    -- right after the item, in the same message: "[Item]
    -- (Paladin, Priest, Warlock) available now for an open
    -- roll...". Only for an Open Roll -- a Soft Reserve or
    -- Preselected roll is limited to its own players
    -- anyway. Tokens' classes come from their name (see
    -- SoftReserve:GetItemClasses).
    -------------------------------------------------

    if entry.Mode == "OpenRoll" then

        local item = ImpLoot.Database:FindItemByID(entry.ItemID)
        local classes = item and ImpLoot.SoftReserve:GetItemClasses(item)

        if classes and #classes > 0 then
            announcedLink = (announcedLink or "") .. " (" .. table.concat(classes, ", ") .. ")"
        end

    end

    local listName, councilItem

    if entry.Mode == "LootCouncil" then

        listName = ImpLoot.LootCouncil:GetActiveListName()
        councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if not (councilItem and councilItem.Mode == "Preselected") then
            return false, "Loot Council items use LC Vote, not Announce."
        end

    end

    local reserverNames = {}

    if entry.Mode == "SoftReserve" then
        reserverNames = self:GetReserverNameList(entry.ItemID)
    end

    if ImpLoot.Comms then

        ImpLoot.Comms:SendItemAnnounced(entry.ItemID, entry.Mode, reserverNames)

    end

    if entry.Mode == "SoftReserve" then

        ImpLoot.Announcements:Announce("SoftReserveAnnounced", {
            item = announcedLink,
            reservers = self:FormatReserverListForAnnouncement(entry.ItemID),
        })

    elseif councilItem and councilItem.Mode == "Preselected" then

        local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)
        local names = {}

        for _, candidate in ipairs(remaining) do

            if candidate.Type == "Class" then
                table.insert(names, "Any " .. candidate.Value)
            else
                table.insert(names, candidate.Value)
            end

        end

        ImpLoot.Announcements:Announce("PreselectedAnnounced", {
            item = entry.ItemLink,
            players = self:JoinWithAmpersand(names),
            seconds = self.Settings.RollDuration,
        })

    else

        ImpLoot.Announcements:Announce("OpenRollAnnounced", {
            item = announcedLink,
            seconds = self.Settings.RollDuration,
        })

    end

    self:StartRoll(queueID)

    return true

end

-------------------------------------------------
-- Call Vote
--
-- Broadcasts a ballot to every council member (they
-- each decide locally whether to show it, based on
-- their own membership). The item stays "Voting"
-- until the loot master assigns it manually from the
-- live tally -- there's no auto-finalize for votes.
-------------------------------------------------

function ImpLoot.LootMaster:CallVote(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    if entry.Mode ~= "LootCouncil" then
        return false, "Only Loot Council items can be voted on."
    end

    local listName = ImpLoot.LootCouncil:GetActiveListName()

    if not listName then
        return false, "No active Loot Council list."
    end

    local candidates = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)

    self.NextVoteID = (self.NextVoteID or 0) + 1
    local voteID = "V" .. self.NextVoteID

    entry.State = "Voting"
    entry.ActiveVoteID = voteID
    entry.Votes = {}
    entry.Runoff = nil
    entry.RunoffCandidates = nil

    ImpLoot.Announcements:Announce("LCVoteCalled", {
        item = entry.ItemLink,
    })

    if ImpLoot.Comms then

        local sent = ImpLoot.Comms:SendVoteCall(entry.ItemID, voteID, candidates)

        if sent == 0 then
            ImpLoot:Print("No Loot Council members are in the raid to vote -- add them in the Loot Council / Priority window.")
        end

    end

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

-------------------------------------------------
-- Record Vote Cast
--
-- One vote per voter per vote ID -- a repeat cast from
-- the same person just overwrites their earlier one
-- rather than counting twice.
-------------------------------------------------

function ImpLoot.LootMaster:RecordVoteCast(voteID, voterName, candidateType, candidateValue)

    -- Only council members' votes count
    local isMember = false
    local voter = voterName and (voterName:match("^([^%-]+)") or voterName):lower()

    for _, member in ipairs(ImpLoot.LootCouncil:GetMembers()) do
        if (member:match("^([^%-]+)") or member):lower() == voter then
            isMember = true
            break
        end
    end

    if not isMember then
        return false
    end

    for _, entry in ipairs(self.Queue) do

        if entry.ActiveVoteID == voteID then

            -- A second vote only counts its own candidates
            if entry.Runoff then

                local allowed = false

                for _, candidate in ipairs(entry.RunoffCandidates or {}) do
                    if candidate.Type == candidateType and candidate.Value == candidateValue then
                        allowed = true
                        break
                    end
                end

                if not allowed then
                    return false
                end

            end

            entry.Votes[voterName] = {
                Type = candidateType,
                Value = candidateValue,
            }

            ImpLoot.Events:Fire("LootQueueChanged")

            return true

        end

    end

    return false

end

-------------------------------------------------
-- Get Vote Tally
--
-- Returns an ordered list of {Value=, Count=}, most
-- votes first.
-------------------------------------------------

function ImpLoot.LootMaster:GetVoteTally(queueID)

    local entry = self:GetEntry(queueID)

    if not entry or not entry.Votes then
        return {}
    end

    local counts = {}
    local types = {}
    local order = {}

    for _, vote in pairs(entry.Votes) do

        if not counts[vote.Value] then
            counts[vote.Value] = 0
            types[vote.Value] = vote.Type
            table.insert(order, vote.Value)
        end

        counts[vote.Value] = counts[vote.Value] + 1

    end

    local tally = {}

    for _, value in ipairs(order) do
        table.insert(tally, { Value = value, Type = types[value], Count = counts[value] })
    end

    table.sort(tally, function(a, b) return a.Count > b.Count end)

    return tally

end

-------------------------------------------------
-- Vote Leaders / Second Vote (Runoff)
--
-- A stalemate is two or more candidates sharing the
-- most votes. Then, instead of assigning, the loot
-- master runs a second vote between only those tied
-- candidates (normally the top two) -- same council,
-- fresh votes. If that ties as well, the loot master
-- decides between them (see the Loot Master window).
-------------------------------------------------

-- Returns the tally, the candidates sharing the most
-- votes, and whether that's a tie.
function ImpLoot.LootMaster:GetVoteLeaders(queueID)

    local tally = self:GetVoteTally(queueID)
    local leaders = {}

    if #tally == 0 then
        return tally, leaders, false
    end

    for _, t in ipairs(tally) do
        if t.Count == tally[1].Count then
            table.insert(leaders, t)
        end
    end

    return tally, leaders, #leaders > 1

end

function ImpLoot.LootMaster:StartRunoff(queueID)

    local entry = self:GetEntry(queueID)

    if not entry or entry.State ~= "Voting" then
        return false
    end

    local _, leaders, isTie = self:GetVoteLeaders(queueID)

    if not isTie then
        return false
    end

    -- Keep each tied candidate's spec label, if it had one
    local listName = ImpLoot.LootCouncil:GetActiveListName()
    local remaining = listName and ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID) or {}

    local candidates, names = {}, {}

    for _, leader in ipairs(leaders) do

        local spec = nil

        for _, c in ipairs(remaining) do
            if c.Type == leader.Type and c.Value == leader.Value then
                spec = c.Spec
                break
            end
        end

        table.insert(candidates, { Type = leader.Type, Value = leader.Value, Spec = spec })
        table.insert(names, leader.Type == "Class" and ("Any " .. leader.Value) or leader.Value)

    end

    -- "R" on the end tells the vote popup it's a second vote
    self.NextVoteID = (self.NextVoteID or 0) + 1
    local voteID = "V" .. self.NextVoteID .. "R"

    entry.ActiveVoteID = voteID
    entry.Votes = {}
    entry.Runoff = true
    entry.RunoffCandidates = candidates

    ImpLoot.Announcements:Announce("LCRunoffCalled", {
        item = entry.ItemLink,
        candidates = self:JoinWithAmpersand(names),
    })

    if ImpLoot.Comms then
        ImpLoot.Comms:SendVoteCall(entry.ItemID, voteID, candidates)
    end

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

-------------------------------------------------
-- Start / Stop Roll
--
-- Only one item can be actively rolling at a time --
-- WoW's roll messages don't reference an item, so
-- every incoming roll is attributed to whichever
-- item this points at. Starting a roll wipes any
-- previous standings for it (a fresh roll window).
-------------------------------------------------

function ImpLoot.LootMaster:StartRoll(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    if entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()
        local councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if not (councilItem and councilItem.Mode == "Preselected") then
            return false, "Loot Council items are voted, not rolled."
        end

    end

    entry.State = "Rolling"
    entry.Rolls = {}
    entry.RollGroup = nil
    entry.RerollPlayers = nil

    if self.Settings.RollDuration and self.Settings.RollDuration > 0 then

        entry.RollEndTime = GetTime() + self.Settings.RollDuration

        entry.NextPeriodicAnnounceAt = self.Settings.RollDuration
            - self.Settings.PeriodicAnnounceInterval

        entry.CountdownAnnounced = {}

    else

        entry.RollEndTime = nil

    end

    self.ActiveRollQueueID = queueID

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

function ImpLoot.LootMaster:StopRoll(queueID)

    if self.ActiveRollQueueID == queueID then
        self.ActiveRollQueueID = nil
    end

end

-------------------------------------------------
-- Get Raid Roster Names
-------------------------------------------------

function ImpLoot.LootMaster:GetRaidRosterNames()

    local names = {}

    local numRaid = 0

    if GetNumRaidMembers then
        numRaid = GetNumRaidMembers()
    end

    if numRaid > 0 then

        for i = 1, numRaid do

            local name = GetRaidRosterInfo(i)

            if name then
                table.insert(names, name)
            end

        end

    else

        table.insert(names, (UnitName("player")))

    end

    return names

end

-------------------------------------------------
-- Get Group Members Of Class
--
-- Everyone in the raid (or party, or just yourself when
-- solo) whose class matches, e.g. "Warrior" or "Death
-- Knight". Compared on the game's own class token, so
-- spelling/spacing of the list's class name doesn't
-- matter. Returns { Name =, Online = } sorted by name.
-------------------------------------------------

local function NormalizeClass(class)
    return class and class:upper():gsub("%s+", "") or ""
end

function ImpLoot.LootMaster:GetGroupMembersOfClass(className)

    local wanted = NormalizeClass(className)
    local members = {}

    local function Consider(name, classToken, online)

        if name and NormalizeClass(classToken) == wanted then
            table.insert(members, { Name = name, Online = online and true or false })
        end

    end

    local numRaid = GetNumRaidMembers and GetNumRaidMembers() or 0

    if numRaid > 0 then

        for i = 1, numRaid do
            local name, _, _, _, _, classToken, _, online = GetRaidRosterInfo(i)
            Consider(name, classToken, online)
        end

    else

        local _, myToken = UnitClass("player")
        Consider(UnitName("player"), myToken, true)

        local numParty = GetNumPartyMembers and GetNumPartyMembers() or 0

        for i = 1, numParty do
            local unit = "party" .. i
            local _, token = UnitClass(unit)
            Consider(UnitName(unit), token, UnitIsConnected and UnitIsConnected(unit))
        end

    end

    table.sort(members, function(a, b) return a.Name < b.Name end)

    return members

end

-------------------------------------------------
-- Is Player Present
--
-- Whether a name belongs to someone currently in the
-- raid roster -- offline members still count (they're
-- still in the group, just disconnected; they might
-- reconnect before anything needs resolving), only
-- someone genuinely not in the raid at all doesn't.
-------------------------------------------------

function ImpLoot.LootMaster:IsPlayerPresent(playerName)

    for _, rosterName in ipairs(self:GetRaidRosterNames()) do

        if self:NamesMatch(rosterName, playerName) then
            return true
        end

    end

    return false

end

-------------------------------------------------
-- On Timer Tick
--
-- Handles the periodic "N seconds left" announcements,
-- the final countdown (5, 4, 3, 2, 1), and finalizing
-- the roll once time is up. Reads GetTime() itself
-- rather than an elapsed-time parameter, so it's
-- directly callable without a real game loop.
-------------------------------------------------

function ImpLoot.LootMaster:OnTimerTick()

    -- Fired unconditionally (even with no active roll) so
    -- the Loot Master window's per-row countdown numbers
    -- stay in sync -- including hiding a stale number once
    -- a roll ends, not just updating it while one's active.
    ImpLoot.Events:Fire("LootTimerTick")

    local queueID = self.ActiveRollQueueID

    if not queueID then
        return
    end

    local entry = self:GetEntry(queueID)

    if not entry or not entry.RollEndTime then
        return
    end

    local remaining = entry.RollEndTime - GetTime()

    if remaining <= 0 then
        self:FinalizeRoll(queueID)
        return
    end

    -- Lightweight signal, separate from LootQueueChanged --
    -- lets the window update just the visible countdown
    -- number in place, without rebuilding the whole row
    -- list every half second.
    ImpLoot.Events:Fire("LootTimerTick", queueID, remaining)

    local remainingRounded = math.ceil(remaining)

    -------------------------------------------------
    -- Final Countdown
    -------------------------------------------------

    if remainingRounded <= self.Settings.FinalCountdownThreshold
    and remainingRounded >= 1 then

        if not entry.CountdownAnnounced[remainingRounded] then

            entry.CountdownAnnounced[remainingRounded] = true

            ImpLoot.Announcements:Announce("RollCountdown", {
                item = entry.ItemLink,
                count = remainingRounded,
            })

        end

        return

    end

    -------------------------------------------------
    -- Periodic "N Seconds Left"
    -------------------------------------------------

    if self.Settings.PeriodicAnnounceInterval > 0
    and entry.NextPeriodicAnnounceAt
    and remainingRounded <= entry.NextPeriodicAnnounceAt then

        ImpLoot.Announcements:Announce("RollTimeRemaining", {
            item = entry.ItemLink,
            seconds = remainingRounded,
        })

        entry.NextPeriodicAnnounceAt =
            entry.NextPeriodicAnnounceAt - self.Settings.PeriodicAnnounceInterval

        if entry.NextPeriodicAnnounceAt <= self.Settings.FinalCountdownThreshold then
            entry.NextPeriodicAnnounceAt = nil
        end

    end

end

-------------------------------------------------
-- Finalize Roll
--
-- Always stops accepting new rolls once time is up.
-- Whether it goes on to auto-assign is a separate
-- setting -- if it's off, the item just sits ready
-- for the loot master to Assign manually.
-------------------------------------------------

function ImpLoot.LootMaster:FinalizeRoll(queueID, isManualStop)

    local entry = self:GetEntry(queueID)

    if not entry then
        return
    end

    -- Several copies rolled for together (see StartGroupRoll)
    -- finish together, with one winner per copy.
    local group = self:GetRollGroupEntries(entry)

    if #group > 1 then
        self:FinalizeGroupRoll(group, isManualStop)
        return
    end

    self:StopRoll(queueID)

    entry.RollEndTime = nil
    entry.State = "RollComplete"

    ImpLoot.Events:Fire("LootQueueChanged")

    -- Two or more players share the top roll: they reroll
    local tied = self:GetTiedAtTop(entry.Rolls)

    if tied then
        self:StartTieReroll({ entry }, tied, entry.Rolls[1].Roll)
        return
    end

    -------------------------------------------------
    -- Winner Announcement
    --
    -- Announced here, the moment the countdown actually
    -- ends -- not in Assign(), which may not get called
    -- until much later (manual assignment, or Auto
    -- Finalize/Auto Assign turned off). Loot Council
    -- items never reach this function at all (they
    -- resolve via LC Vote, not a roll timer), so their
    -- own announcement still happens in Assign().
    -------------------------------------------------

    local topRoll = self:GetTopRoll(queueID)

    if topRoll then

        ImpLoot.Announcements:Announce("WinnerAnnounced", {
            item = entry.ItemLink,
            winner = topRoll.Player,
            roll = tostring(topRoll.Roll),
            range = tostring(topRoll.Min) .. "-" .. tostring(topRoll.Max),
        })

    end

    -------------------------------------------------
    -- Manually Clicking Stop Always Resolves The Roll
    --
    -- A deliberate, active decision to end the roll
    -- right now -- unlike the timer running out on its
    -- own, assigning to whoever's currently winning
    -- doesn't wait on the Auto Finalize/Auto Assign
    -- settings (those two only describe unattended
    -- behaviour for a natural timeout). If nobody
    -- rolled at all, it still falls through to the
    -- disenchanter check below, same as an unattended
    -- timeout would.
    -------------------------------------------------

    if isManualStop then

        if topRoll then
            self:RequestAssign(queueID, topRoll.Player)
            return
        end

    end

    if not isManualStop and not self.Settings.AutoFinalizeOnTimeout then
        return
    end

    if not topRoll then

        local disenchanter = ImpLoot.LootCouncil:GetActiveDisenchanter(
            self:GetRaidRosterNames()
        )

        if disenchanter then

            ImpLoot.Announcements:Announce("NoRollsDisenchant", {
                item = entry.ItemLink,
            })

            entry.AssignNote = "Disenchant (no rolls)"
            entry.AssignResult = "DE"
            self:RequestAssign(queueID, disenchanter)

        end

        return

    end

    if self.Settings.AutoAssignToRollWinner then
        self:RequestAssign(queueID, topRoll.Player)
    end

end

function ImpLoot.LootMaster:GetActiveRollQueueID()
    return self.ActiveRollQueueID
end

-------------------------------------------------
-- Get Roll Type
-------------------------------------------------

function ImpLoot.LootMaster:GetRollType(minRoll, maxRoll)

    -- Standard WotLK convention: /roll 1-100 is Main Spec,
    -- anything with a top end below 100 (the Off-Spec Roll
    -- button rolls 1-99) is Off Spec.
    if maxRoll and maxRoll < 100 then
        return "OS"
    end

    return "MS"

end

-------------------------------------------------
-- Get Max Rolls For Player
--
-- Open Roll: everyone gets exactly one roll. Soft
-- Reserve: as many rolls as they have remaining
-- reserved slots on this item (so a triple reserve
-- gets three). Loot Council items aren't rolled at
-- all.
-------------------------------------------------

function ImpLoot.LootMaster:GetMaxRollsForPlayer(entry, playerName)

    -- A tie reroll: only the tied players, once each
    if entry.RerollPlayers then
        return entry.RerollPlayers[playerName] and 1 or 0
    end

    if entry.Mode == "OpenRoll" then
        return 1
    end

    if entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()
        local councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if not (councilItem and councilItem.Mode == "Preselected") then
            return 0
        end

        local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)

        for _, candidate in ipairs(remaining) do

            if candidate.Type == "Player" and self:NamesMatch(candidate.Value, playerName) then
                return 1
            end

        end

        return 0

    end

    if entry.Mode ~= "SoftReserve" then
        return 0
    end

    local slots = ImpLoot.SoftReserve:GetRemainingSlots(entry.ItemID)
    local count = 0

    for _, slot in ipairs(slots) do

        if slot.Player == playerName then
            count = count + 1
        end

    end

    return count

end

-------------------------------------------------
-- On Chat Msg System
--
-- Parses WoW's own roll system message and routes it
-- to whichever item is currently open for rolling.
-------------------------------------------------

function ImpLoot.LootMaster:OnChatMsgSystem(msg)

    if not self.ActiveRollQueueID then
        return
    end

    local player, roll, minRoll, maxRoll = msg:match(ROLL_PATTERN)

    if not player then
        return
    end

    self:ProcessRoll(
        self.ActiveRollQueueID,
        player,
        tonumber(roll),
        tonumber(minRoll),
        tonumber(maxRoll)
    )

end

-------------------------------------------------
-- Process Roll
--
-- Rejects the roll (rather than counting it) if the
-- item isn't actively rolling, the roll is a 0 (i.e.
-- someone typed "pass"), or the player has no
-- eligible rolls left for this item.
-------------------------------------------------

function ImpLoot.LootMaster:ProcessRoll(queueID, playerName, rollValue, minRoll, maxRoll)

    local entry = self:GetEntry(queueID)

    if not entry or entry.State ~= "Rolling" then
        return false, "No active roll for this item."
    end

    if rollValue == 0 then
        return false, "Rolls of 0 don't count."
    end

    -------------------------------------------------
    -- Only The Two Standard Ranges Count
    --
    -- /roll 1-100 (Main Spec) or /roll 1-99 (the
    -- addon's own Off Spec Roll button, and the
    -- standard convention for it) -- anything else
    -- (a typo'd range, a custom /roll someone made up)
    -- is silently ignored rather than being treated as
    -- a legitimate participant in the standings.
    -------------------------------------------------

    if maxRoll ~= 100 and maxRoll ~= 99 then
        return false, "Only /roll 1-100 or 1-99 count -- that roll was ignored."
    end

    local maxAllowed = self:GetMaxRollsForPlayer(entry, playerName)

    local existingCount = 0

    for _, roll in ipairs(entry.Rolls) do

        if roll.Player == playerName then
            existingCount = existingCount + 1
        end

    end

    if existingCount >= maxAllowed then

        return false,
            playerName .. " has no eligible rolls remaining for this item."

    end

    -------------------------------------------------
    -- Two Copies, One Roll
    --
    -- When the same item drops twice from the same
    -- corpse (two separate queue entries -- see
    -- AddToQueue), players naturally roll ONCE for a
    -- shot at either copy, not once per copy. Mirror
    -- the same roll into any sibling entry that's also
    -- still actively rolling, so both entries' standings
    -- stay identical throughout the roll period.
    -------------------------------------------------

    local siblings = self:GetSiblingEntries(entry)

    local function RecordRollOn(targetEntry)

        table.insert(targetEntry.Rolls, {
            Player = playerName,
            Roll = rollValue,
            Type = self:GetRollType(minRoll, maxRoll),
            Min = minRoll,
            Max = maxRoll,
        })

        table.sort(targetEntry.Rolls, function(a, b)

            -- Main Spec rolls always outrank Off Spec rolls,
            -- regardless of the actual number rolled -- an
            -- 87 on an Off Spec roll (1-99) must never beat
            -- a 45 on a Main Spec roll (1-100). Only compare
            -- the raw roll value once both sides are the
            -- same type.
            if a.Type ~= b.Type then
                return a.Type == "MS"
            end

            return a.Roll > b.Roll

        end)

    end

    RecordRollOn(entry)

    for _, sibling in ipairs(siblings) do

        if sibling.State == "Rolling" then
            RecordRollOn(sibling)
        end

    end

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

-------------------------------------------------
-- Get Sibling Entries
--
-- Other queue entries for the exact same item dropped
-- from the exact same corpse -- i.e. two or more copies
-- that appeared together in one loot window. Used to
-- keep roll standings in sync across copies and to
-- exclude an already-assigned winner from the others'
-- standings.
-------------------------------------------------

function ImpLoot.LootMaster:GetSiblingEntries(entry)

    local siblings = {}

    for _, other in ipairs(self.Queue) do

        if other.QueueID ~= entry.QueueID
        and other.ItemID == entry.ItemID
        and other.CorpseGUID == entry.CorpseGUID then

            table.insert(siblings, other)

        end

    end

    return siblings

end

-------------------------------------------------
-- Get Copy Group
--
-- Every still-Pending entry for the exact same item
-- from the exact same corpse, itself included -- the
-- full set of copies a Soft Reserve multi-copy
-- decision (see GetMultiCopyDecision) needs to reason
-- about together. Once a copy leaves Pending (it's
-- rolling, or already resolved), it's no longer part
-- of a decision still being made about the others.
-------------------------------------------------

function ImpLoot.LootMaster:GetCopyGroup(entry)

    local group = {}

    for _, other in ipairs(self.Queue) do

        if other.ItemID == entry.ItemID
        and other.CorpseGUID == entry.CorpseGUID
        and other.State == "Pending" then

            table.insert(group, other)

        end

    end

    return group

end

-------------------------------------------------
-- Get Multi-Copy Decision
--
-- For a Soft Reserve item with more than one Pending
-- copy from the same corpse, works out which of two
-- outcomes applies by comparing distinct reservers to
-- the number of copies -- reusing the exact same
-- comparison the Sole Reserver shortcut already makes,
-- just no longer limited to 1-vs-1:
--
--   reservers <= copies -> "DirectAssign": no roll
--   needed at all, one copy per reserver. Any leftover
--   copies (more copies than reservers) fall back to
--   plain Open Roll, same as an unreserved item.
--
--   reservers > copies -> "GroupRoll": every copy in
--   the group needs to be rolled for together, as one
--   combined event rather than separate per-copy
--   announcements.
--
-- Returns nil when there's nothing special to decide:
-- not Soft Reserve mode, only one copy, no reservers
-- at all, or AllowMultipleReserves is on (that setting
-- means each copy is deliberately handled on its own --
-- see SoftReserve.lua).
-------------------------------------------------

function ImpLoot.LootMaster:GetMultiCopyDecision(entry)

    if entry.Mode ~= "SoftReserve" then
        return nil
    end

    if ImpLoot.SoftReserve:GetSettings().AllowMultipleReserves then
        return nil
    end

    local group = self:GetCopyGroup(entry)

    if #group <= 1 then
        return nil
    end

    local reservers = ImpLoot.SoftReserve:GetPresentReservers(entry.ItemID)

    if #reservers == 0 then
        return nil
    end

    if #reservers <= #group then

        return {
            Type = "DirectAssign",
            Group = group,
            Reservers = reservers,
        }

    end

    return {
        Type = "GroupRoll",
        Group = group,
    }

end

-------------------------------------------------
-- Execute Direct Assign
--
-- The "reservers <= copies" outcome of a multi-copy
-- decision: one copy per reserver, no roll, one
-- combined announcement naming everyone who's getting
-- one. Any copies left over once every reserver has
-- one (more copies than reservers) are released to
-- plain Open Roll -- handled from there exactly like
-- any other unreserved item, not auto-announced here.
-------------------------------------------------

function ImpLoot.LootMaster:ExecuteDirectAssign(decision)

    local group = decision.Group
    local reservers = decision.Reservers

    for i = #reservers + 1, #group do
        group[i].Mode = "OpenRoll"
    end

    ImpLoot.Announcements:Announce("MultiCopyDirectAssigned", {
        item = group[1].ItemLink,
        count = tostring(#reservers),
        winners = self:JoinWithAmpersand(reservers),
    })

    for i, reserver in ipairs(reservers) do
        group[i].AssignNote = "Soft reserve (one copy each)"
        self:RequestAssign(group[i].QueueID, reserver)
    end

end

-------------------------------------------------
-- Execute Group Roll
--
-- The "reservers > copies" outcome: every copy is
-- rolled for together as one event (see StartGroupRoll).
-------------------------------------------------

function ImpLoot.LootMaster:ExecuteGroupRoll(decision)
    return self:StartGroupRoll(decision.Group)
end

-------------------------------------------------
-- Get Open Roll Copy Group
--
-- Every still-Pending Open Roll copy of the same item
-- from the same corpse, itself included. Returns nil
-- when there's only the one copy. A Soft Reserve copy
-- whose reservers are all absent counts as Open Roll
-- here too (the Loot Master window makes the same
-- switch when it draws the row).
-------------------------------------------------

function ImpLoot.LootMaster:GetOpenRollCopyGroup(entry)

    local function IsOpenRoll(e)

        if e.Mode == "OpenRoll" then
            return true
        end

        return e.Mode == "SoftReserve"
            and #ImpLoot.SoftReserve:GetPresentReservers(e.ItemID) == 0

    end

    if not IsOpenRoll(entry) then
        return nil
    end

    local group = {}

    for _, copy in ipairs(self:GetCopyGroup(entry)) do

        if IsOpenRoll(copy) then
            copy.Mode = "OpenRoll"
            table.insert(group, copy)
        end

    end

    if #group <= 1 then
        return nil
    end

    return group

end

-------------------------------------------------
-- Start Group Roll
--
-- Two or more copies of the same item from the same
-- corpse are rolled for ONCE: one announcement ("[Item]
-- x2"), one shared timer, and the rolls mirrored onto
-- every copy (see ProcessRoll). When it ends,
-- FinalizeGroupRoll gives the first copy to the highest
-- roller, the second to the next-highest DIFFERENT
-- player, and so on.
--
-- The first copy is the "leader": its timer drives the
-- countdown and it's the one rolls are routed to. Every
-- copy is tagged with the full group (RollGroup) so a
-- Stop on any of them ends the whole roll.
-------------------------------------------------

function ImpLoot.LootMaster:StartGroupRoll(group)

    local leader = group[1]

    local ok, message = self:AnnounceItem(leader.QueueID, #group)

    if not ok then
        return false, message
    end

    local ids = {}

    for _, copy in ipairs(group) do
        table.insert(ids, copy.QueueID)
    end

    for i = 2, #group do
        self:StartRoll(group[i].QueueID)
        group[i].RollEndTime = leader.RollEndTime
    end

    for _, copy in ipairs(group) do
        copy.RollGroup = ids
    end

    self.ActiveRollQueueID = leader.QueueID

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

-------------------------------------------------
-- Get Roll Group Entries
--
-- The copies rolled for together with this entry
-- (itself included, leader first), or just the entry
-- on its own if it wasn't part of a group roll.
-------------------------------------------------

function ImpLoot.LootMaster:GetRollGroupEntries(entry)

    if not entry.RollGroup then
        return { entry }
    end

    local group = {}

    for _, id in ipairs(entry.RollGroup) do

        local copy = self:GetEntry(id)

        if copy then
            table.insert(group, copy)
        end

    end

    return group

end

-------------------------------------------------
-- Ties
--
-- When the best roll is shared, nobody has won yet:
-- the tied players (only them) roll again, with a
-- fresh timer, and the result is decided as usual.
-- A second tie just rerolls again.
-------------------------------------------------

-- The players sharing the best roll (same roll type and
-- number), or nil when there's a single best roll.
function ImpLoot.LootMaster:GetTiedAtTop(rolls)

    local top = rolls and rolls[1]

    if not top then
        return nil
    end

    local tied, seen = {}, {}

    for _, roll in ipairs(rolls) do

        if roll.Type ~= top.Type or roll.Roll ~= top.Roll then
            break
        end

        if not seen[roll.Player] then
            seen[roll.Player] = true
            table.insert(tied, roll.Player)
        end

    end

    return (#tied > 1) and tied or nil

end

function ImpLoot.LootMaster:StartTieReroll(entries, players, rollValue)

    local allowed = {}

    for _, player in ipairs(players) do
        allowed[player] = true
    end

    local ids = {}

    for _, e in ipairs(entries) do
        self:StartRoll(e.QueueID)
        e.RerollPlayers = allowed
        table.insert(ids, e.QueueID)
    end

    local leader = entries[1]

    -- Several copies left: they reroll as one group
    if #entries > 1 then

        for _, e in ipairs(entries) do
            e.RollGroup = ids
            e.RollEndTime = leader.RollEndTime
        end

    end

    self.ActiveRollQueueID = leader.QueueID

    ImpLoot.Announcements:Announce("RollTie", {
        item = leader.ItemLink,
        roll = tostring(rollValue),
        players = self:JoinWithAmpersand(players),
        seconds = self.Settings.RollDuration,
    })

    ImpLoot.Events:Fire("LootQueueChanged")

end

-------------------------------------------------
-- Finalize Group Roll
--
-- Ends every copy's roll at once and works out one
-- winner per copy from the shared standings: the top
-- roller gets the first copy, the next-highest
-- different player the second, and so on. Copies with
-- no one left to win them go to the disenchanter (if
-- one is set), same as a single item nobody rolled on.
--
-- Follows the same settings as a single roll: Stop
-- always assigns; a timeout only assigns with Auto
-- Finalize (and Auto Assign for actual winners) on.
-- With those off, each copy just sits ready to Assign,
-- and assigning one removes that winner from the
-- other copies' standings (see Assign).
-------------------------------------------------

function ImpLoot.LootMaster:FinalizeGroupRoll(group, isManualStop)

    local copies = {}

    for _, copy in ipairs(group) do

        self:StopRoll(copy.QueueID)

        if copy.State == "Rolling" then

            copy.RollEndTime = nil
            copy.State = "RollComplete"

            table.insert(copies, copy)

        end

    end

    if #copies == 0 then
        return
    end

    ImpLoot.Events:Fire("LootQueueChanged")

    -- Every copy holds the same mirrored, already-sorted rolls.
    -- Each player's best roll, best first:
    local ranked = {}
    local seen = {}

    for _, roll in ipairs(copies[1].Rolls) do

        if not seen[roll.Player] then
            seen[roll.Player] = true
            table.insert(ranked, roll)
        end

    end

    local function SameRoll(a, b)
        return a and b and a.Type == b.Type and a.Roll == b.Roll
    end

    -------------------------------------------------
    -- A Tie For The Last Copy
    --
    -- e.g. 2 copies, rolls 90 / 36 / 36: the 90 wins a
    -- copy, and the two 36s reroll for the other one.
    -- (Ties among players who all get a copy don't
    -- matter.)
    -------------------------------------------------

    local count = #copies

    if #ranked > count and SameRoll(ranked[count], ranked[count + 1]) then

        local tieRoll = ranked[count]
        local clear, tiedPlayers = {}, {}

        for _, roll in ipairs(ranked) do

            if SameRoll(roll, tieRoll) then
                table.insert(tiedPlayers, roll.Player)
            elseif #tiedPlayers == 0 then
                table.insert(clear, roll)
            end

        end

        -- The clear winners keep their copies...
        local rerollCopies = {}

        for i = #clear + 1, count do
            table.insert(rerollCopies, copies[i])
        end

        for i, roll in ipairs(clear) do

            ImpLoot.Announcements:Announce("WinnerAnnounced", {
                item = copies[i].ItemLink,
                winner = roll.Player,
                roll = tostring(roll.Roll),
                range = tostring(roll.Min) .. "-" .. tostring(roll.Max),
            })

            if isManualStop or (self.Settings.AutoFinalizeOnTimeout and self.Settings.AutoAssignToRollWinner) then
                self:RequestAssign(copies[i].QueueID, roll.Player)
            end

        end

        -- ...and the tied players reroll for the rest
        self:StartTieReroll(rerollCopies, tiedPlayers, tieRoll.Roll)

        return

    end

    local winners = {}

    for i = 1, math.min(count, #ranked) do
        winners[i] = ranked[i]
    end

    for i, roll in ipairs(winners) do

        ImpLoot.Announcements:Announce("WinnerAnnounced", {
            item = copies[i].ItemLink,
            winner = roll.Player,
            roll = tostring(roll.Roll),
            range = tostring(roll.Min) .. "-" .. tostring(roll.Max),
        })

    end

    if not isManualStop and not self.Settings.AutoFinalizeOnTimeout then
        return
    end

    local disenchanter = nil

    if #winners < #copies then
        disenchanter = ImpLoot.LootCouncil:GetActiveDisenchanter(
            self:GetRaidRosterNames()
        )
    end

    for i, copy in ipairs(copies) do

        local roll = winners[i]

        if roll then

            if isManualStop or self.Settings.AutoAssignToRollWinner then
                self:RequestAssign(copy.QueueID, roll.Player)
            end

        elseif disenchanter then

            ImpLoot.Announcements:Announce("NoRollsDisenchant", {
                item = copy.ItemLink,
            })

            copy.AssignNote = "Disenchant (no rolls)"
            copy.AssignResult = "DE"
            self:RequestAssign(copy.QueueID, disenchanter)

        end

    end

end

-------------------------------------------------
-- Standings

-------------------------------------------------

function ImpLoot.LootMaster:GetStandings(queueID)

    local entry = self:GetEntry(queueID)

    if not entry then
        return {}
    end

    return entry.Rolls

end

function ImpLoot.LootMaster:GetTopRoll(queueID)
    return self:GetStandings(queueID)[1]
end

-------------------------------------------------
-- Names Match
--
-- Strips a realm suffix ("Name-Realm") before
-- comparing, since candidate names and roll names
-- don't always carry one consistently.
-------------------------------------------------

function ImpLoot.LootMaster:NamesMatch(a, b)

    if not a or not b then
        return false
    end

    local shortA = a:match("^([^%-]+)") or a
    local shortB = b:match("^([^%-]+)") or b

    return shortA == shortB

end

-------------------------------------------------
-- Find Candidate Index
--
-- Master Loot's candidate list is shared across every
-- item in the current loot window (eligibility is
-- about loot range, not the specific item) -- so this
-- doesn't take a slot parameter, matching the real API.
-------------------------------------------------

function ImpLoot.LootMaster:FindCandidateIndex(winnerName)

    if not GetMasterLootCandidate then
        return nil
    end

    local numMembers = 0

    if GetNumRaidMembers then
        numMembers = GetNumRaidMembers()
    end

    for i = 1, numMembers do

        local candidateName = GetMasterLootCandidate(i)

        if candidateName and self:NamesMatch(candidateName, winnerName) then
            return i
        end

    end

    return nil

end

-------------------------------------------------
-- Assign
--
-- Calls the real Master Loot API when the item's
-- corpse is still open and the winner is a valid
-- candidate; otherwise just records the winner so the
-- item can be traded manually later. Either path is
-- "Assign" from the loot master's point of view.
-------------------------------------------------

function ImpLoot.LootMaster:RecordWinForExclusion(entry, winnerName, classSlot)

    if entry.Mode == "SoftReserve" then

        ImpLoot.SoftReserve:RecordWin(entry.ItemID, winnerName)

    elseif entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()

        if not listName then
            return
        end

        -------------------------------------------------
        -- Picked From A Class Slot ("Any Warrior")
        --
        -- Log the win but keep the slot, so the next copy
        -- goes to another Warrior. Once every Warrior in the
        -- raid has one, the slot is removed and whoever's
        -- next (e.g. "Any Hunter") moves up.
        -------------------------------------------------

        if classSlot then

            ImpLoot.LootCouncil:RecordClassSlotWin(listName, entry.ItemID, classSlot, winnerName)

            local winners = ImpLoot.LootCouncil:GetWinners(listName, entry.ItemID)
            local stillWaiting = 0

            for _, member in ipairs(self:GetGroupMembersOfClass(classSlot)) do

                if not winners[member.Name] then
                    stillWaiting = stillWaiting + 1
                end

            end

            if stillWaiting == 0
            and ImpLoot.LootCouncil:RemoveCandidate(listName, entry.ItemID, "Class", classSlot) then

                ImpLoot:Print(
                    "Every " .. classSlot .. " in the raid now has " .. (entry.ItemLink or "this item")
                    .. " -- " .. classSlot .. " removed from its priority list."
                )

            end

            return

        end

        local remaining = ImpLoot.LootCouncil:GetRemainingCandidates(listName, entry.ItemID)

        for _, candidate in ipairs(remaining) do

            if candidate.Type == "Player" and candidate.Value == winnerName then

                ImpLoot.LootCouncil:RecordWin(listName, entry.ItemID, "Player", winnerName, winnerName)

                return

            end

        end

        -- Class-slot wins arrive with `classSlot` set (handled
        -- above, from the class picker in the Loot Master window).

    end

end

-------------------------------------------------
-- Log Resolution / Get Log / Clear Log
--
-- Every client (loot master or not) builds its own
-- copy of this log -- the loot master logs locally at
-- the moment of resolution and also broadcasts it, so
-- the raid leader (if a different person) gets one
-- too, and anyone else running the addon who's curious.
-------------------------------------------------

-- `details` (optional) carries the richer history fields:
-- ItemName, Quality, WinnerClass, Raid, Size, Heroic, Note,
-- Recorder. Anything missing (e.g. a message from an older
-- ImpLoot) is filled in from this client where it can be.
function ImpLoot.LootMaster:LogResolution(itemID, winnerName, bossName, mode, resultLabel, details)

    local now = time and time() or 0

    details = details or {}

    -------------------------------------------------
    -- Upgrade A Chat-Captured Entry
    --
    -- On a raider's client the "receives loot" chat line
    -- can arrive just before the loot master's own
    -- "assigned" message for the same item. That chat
    -- entry (see LootHistory) is the same drop -- fill in
    -- how it was won instead of adding it twice. Only
    -- within a few minutes, so a later, separate win of
    -- the same item is never merged into it.
    -------------------------------------------------

    if mode then

        local function short(name)
            return name and (name:match("^([^%-]+)") or name):lower() or ""
        end

        for i = #self.Log, 1, -1 do

            local logEntry = self.Log[i]

            if (now - (logEntry.Timestamp or 0)) > 300 then
                break
            end

            if logEntry.Source == "Chat"
            and logEntry.ItemID == itemID
            and short(logEntry.Winner) == short(winnerName) then

                logEntry.Source = nil
                logEntry.Mode = mode
                logEntry.ResultLabel = resultLabel
                logEntry.Note = details.Note or logEntry.Note
                logEntry.BossName = bossName or logEntry.BossName
                logEntry.WinnerClass = details.WinnerClass or logEntry.WinnerClass
                logEntry.Recorder = details.Recorder or logEntry.Recorder
                logEntry.RecorderId = details.RecorderId

                return

            end

        end

    end

    -------------------------------------------------
    -- Guard Against The Same Message Twice
    --
    -- Every entry carries the Id it has in its recorder's
    -- own history (RecorderId). The same recorder + Id
    -- arriving again is the same resolution, not a second
    -- one. Two genuine copies won by the same player each
    -- have their own Id, so both are kept.
    --
    -- An older ImpLoot sends no Id: for those, fall back to
    -- the old rule (same item, winner and boss within a
    -- few seconds of the last entry is a repeat).
    -------------------------------------------------

    if details.Recorder and details.RecorderId then

        for i = #self.Log, 1, -1 do

            local logEntry = self.Log[i]

            if logEntry.Recorder == details.Recorder
            and logEntry.RecorderId == details.RecorderId then
                return
            end

        end

    elseif details.Remote then

        local lastEntry = self.Log[#self.Log]

        if lastEntry
        and lastEntry.ItemID == itemID
        and lastEntry.Winner == winnerName
        and lastEntry.BossName == bossName
        and (now - (lastEntry.Timestamp or 0)) < 5 then
            return
        end

    end

    local raidName, size, heroic = self:GetRaidContext()

    if not details.Raid then
        details.Raid, details.Size, details.Heroic = raidName, size, heroic
    end

    local cached = ImpLoot.ItemCache and ImpLoot.ItemCache:GetItem(itemID)

    local id = ImpLootDB.LootMasterLogNextId or 1
    ImpLootDB.LootMasterLogNextId = id + 1

    -- Logged by this client: its own Id is the recorder's Id
    local recorder = details.Recorder or (UnitName and UnitName("player"))
    local recorderId = details.RecorderId

    if not details.Remote then
        recorderId = id
    end

    table.insert(self.Log, {
        Id = id,
        ItemID = itemID,
        ItemName = details.ItemName or (cached and cached.Name),
        Quality = details.Quality or (cached and cached.Quality),
        Winner = winnerName,
        WinnerClass = details.WinnerClass or self:GetClassForPlayer(winnerName),
        BossName = bossName,
        Raid = details.Raid,
        Size = details.Size,
        Heroic = details.Heroic,
        Mode = mode,
        ResultLabel = resultLabel,
        Note = details.Note,
        Recorder = recorder,
        RecorderId = recorderId,
        Source = details.Source,
        Received = details.Received,
        Timestamp = now,
    })

end

-------------------------------------------------
-- Get Result Label
--
-- The short tag for the Summary window's Roll column:
-- "SR" for a Soft Reserve win, "LC" for Loot Council,
-- or the winner's own roll type (MS/OS) looked up from
-- the entry's own roll standings for an Open Roll win.
-- Blank if none of those apply (e.g. assigned with no
-- roll at all, or the winner's roll can't be found).
-------------------------------------------------

function ImpLoot.LootMaster:GetResultLabel(entry, winnerName)

    -- Set by the path that made the assignment, e.g. "DE"
    -- for an item nobody rolled on going to the disenchanter
    if entry.AssignResult then
        return entry.AssignResult
    end

    if entry.Mode == "SoftReserve" then
        return "SR"
    end

    if entry.Mode == "LootCouncil" then
        return "LC"
    end

    if entry.Rolls then

        for _, roll in ipairs(entry.Rolls) do

            if roll.Player == winnerName then
                return roll.Type
            end

        end

    end

    return ""

end

-------------------------------------------------
-- Raid Context
--
-- Instance name, size (10/25) and whether it's heroic,
-- for the history. nil outside a raid instance. Heroic
-- covers both the old difficulty picker (3/4) and ICC's
-- dynamic heroic toggle.
-------------------------------------------------

function ImpLoot.LootMaster:GetRaidContext()

    if not (IsInInstance and GetInstanceInfo) then
        return nil
    end

    local _, instanceType = IsInInstance()

    if instanceType ~= "raid" then
        return nil
    end

    local name, _, difficultyIndex, _, maxPlayers, dynamicDifficulty, isDynamic = GetInstanceInfo()

    difficultyIndex = difficultyIndex or 1

    local size = (maxPlayers and maxPlayers > 0) and maxPlayers
        or ((difficultyIndex == 1 or difficultyIndex == 3) and 10 or 25)

    local heroic = (difficultyIndex == 3 or difficultyIndex == 4)
        or (isDynamic and dynamicDifficulty == 1) or false

    return name, size, heroic

end

-- "Icecrown Citadel 25H", "Naxxramas 10", or nil
function ImpLoot.LootMaster:FormatRaidLabel(logEntry)

    if not logEntry.Raid then
        return nil
    end

    local label = logEntry.Raid

    if logEntry.Size then
        label = label .. " " .. logEntry.Size .. (logEntry.Heroic and "H" or "")
    end

    return label

end

-------------------------------------------------
-- Get Class For Player
--
-- The game's class token ("WARRIOR", "DEATHKNIGHT")
-- for a group member, or nil if they aren't in it.
-------------------------------------------------

function ImpLoot.LootMaster:GetClassForPlayer(playerName)

    if not playerName then
        return nil
    end

    local short = playerName:match("^([^%-]+)") or playerName

    if UnitName and UnitName("player") == short then
        local _, token = UnitClass("player")
        return token
    end

    local numRaid = GetNumRaidMembers and GetNumRaidMembers() or 0

    if numRaid > 0 then

        for i = 1, numRaid do

            local name, _, _, _, _, token = GetRaidRosterInfo(i)

            if name == short then
                return token
            end

        end

    else

        local numParty = GetNumPartyMembers and GetNumPartyMembers() or 0

        for i = 1, numParty do

            local unit = "party" .. i

            if UnitName(unit) == short then
                local _, token = UnitClass(unit)
                return token
            end

        end

    end

    return nil

end

-------------------------------------------------
-- Describe Win
--
-- A short note on how the item was won, kept with the
-- history entry: "Rolled 95 (MS)", "Soft reserve,
-- rolled 87", "Loot priority (Any Warrior)", "Council
-- vote", "Disenchant (no rolls)" and so on.
-------------------------------------------------

function ImpLoot.LootMaster:DescribeWin(entry, winnerName, classSlot)

    if entry.AssignNote then
        return entry.AssignNote
    end

    local winnerRoll = nil

    for _, roll in ipairs(entry.Rolls or {}) do

        if roll.Player == winnerName then
            winnerRoll = roll
            break
        end

    end

    if entry.Mode == "SoftReserve" then

        if winnerRoll then
            return "Soft reserve, rolled " .. winnerRoll.Roll
        end

        return "Soft reserve"

    end

    if entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()
        local councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)
        local lcMode = councilItem and councilItem.Mode

        if lcMode == "Priority" then
            return classSlot and ("Loot priority (Any " .. classSlot .. ")") or "Loot priority"
        elseif lcMode == "Vote" then
            return "Council vote"
        elseif lcMode == "Funnel" then
            return "Funnel"
        elseif lcMode == "Preselected" then
            return winnerRoll and ("Preselected, rolled " .. winnerRoll.Roll) or "Preselected"
        end

        return "Loot council"

    end

    if winnerRoll then
        return "Rolled " .. winnerRoll.Roll .. " (" .. (winnerRoll.Type or "MS") .. ")"
    end

    return "Assigned"

end

-------------------------------------------------
-- Log, Session Log, Clear
--
-- The log is the permanent loot history (see the
-- History window). The Summary window's Who won what
-- shows only the current session: everything since its
-- Clear button was last pressed. Clear just moves that
-- starting point -- the history keeps every entry.
-------------------------------------------------

function ImpLoot.LootMaster:GetLog()
    return self.Log
end

function ImpLoot.LootMaster:GetSessionLog()

    local startId = ImpLootDB.LootMasterSessionStartId or 0
    local startTime = ImpLootDB.LootMasterSessionStartTime or 0
    local session = {}

    -- By Id AND time: an older entry that arrives later by
    -- history sync gets a new Id, but doesn't belong here.
    for _, logEntry in ipairs(self.Log) do

        if (logEntry.Id or 0) > startId
        and (logEntry.Timestamp or 0) >= startTime then
            table.insert(session, logEntry)
        end

    end

    return session

end

function ImpLoot.LootMaster:ClearLog()
    ImpLootDB.LootMasterSessionStartId = (ImpLootDB.LootMasterLogNextId or 1) - 1
    ImpLootDB.LootMasterSessionStartTime = time()
end

-------------------------------------------------
-- Give Awarded / Mark Traded
--
-- For an item already won but not yet handed over
-- (State "Awarded", see Assign). GiveAwarded hands it
-- over with Master Loot -- needs the loot open.
-- MarkTraded is for when it was traded instead.
-------------------------------------------------

function ImpLoot.LootMaster:GiveAwarded(queueID, quiet)

    local entry = self:GetEntry(queueID)

    if not entry or entry.State ~= "Awarded" then
        return false
    end

    if not (entry.Assignable and entry.LootSlot and self:IsMasterLooter()) then

        if not quiet then
            ImpLoot:Print("Open the loot to hand " .. (entry.ItemLink or "it") .. " to " .. entry.Winner .. ".")
        end

        return false

    end

    local candidateIndex = self:FindCandidateIndex(entry.Winner)

    if not candidateIndex then

        if not quiet then
            ImpLoot:Print(entry.Winner .. " can't receive " .. (entry.ItemLink or "it") .. " right now (too far away?). Try again, or trade it.")
        end

        return false

    end

    GiveMasterLoot(entry.LootSlot, candidateIndex)

    entry.State = "Resolved"
    entry.TradeOnly = nil

    ImpLoot.Events:Fire("LootQueueChanged")

    return true

end

function ImpLoot.LootMaster:MarkTraded(queueID)

    local entry = self:GetEntry(queueID)

    if not entry or entry.State ~= "Awarded" then
        return
    end

    entry.State = "Resolved"
    entry.TradeOnly = true

    ImpLoot.Events:Fire("LootQueueChanged")

end

function ImpLoot.LootMaster:Assign(queueID, winnerName, classSlot)

    local entry = self:GetEntry(queueID)

    if not entry then
        return false, "Item not found in queue."
    end

    self:RecordWinForExclusion(entry, winnerName, classSlot)

    -------------------------------------------------
    -- Two Copies, One Roll: Exclude The Winner From
    -- The Other Copy's Standings
    --
    -- Once this copy is assigned, any sibling entry
    -- (the same item dropped from the same corpse,
    -- still unresolved) needs the winner's roll(s)
    -- removed from ITS standings too -- otherwise its
    -- own top roll would just be the same person again,
    -- instead of correctly becoming whoever was next in
    -- line.
    -------------------------------------------------

    for _, sibling in ipairs(self:GetSiblingEntries(entry)) do

        if sibling.State ~= "Resolved" then

            for i = #sibling.Rolls, 1, -1 do

                if sibling.Rolls[i].Player == winnerName then
                    table.remove(sibling.Rolls, i)
                end

            end

        end

    end

    local resultMessage

    if entry.Assignable
    and entry.LootSlot
    and self:IsMasterLooter() then

        local candidateIndex = self:FindCandidateIndex(winnerName)

        if candidateIndex then

            GiveMasterLoot(entry.LootSlot, candidateIndex)

            entry.Winner = winnerName
            entry.State = "Resolved"

            resultMessage = "Assigned via Master Loot."

        end

    end

    if not resultMessage then

        entry.Winner = winnerName

        if entry.CorpseGUID then

            -------------------------------------------------
            -- Won, Not Yet Handed Over ("Awarded")
            --
            -- The item is still on the corpse / in the chest
            -- (e.g. the roll ended while you'd walked away
            -- and the loot window was closed). Reopening the
            -- loot attaches to this entry instead of listing
            -- the item again; then it's handed over (see
            -- GiveAwarded) -- automatically with Auto-assign
            -- on, or with the row's Assign button.
            -------------------------------------------------

            entry.State = "Awarded"
            entry.TradeOnly = nil

            resultMessage = winnerName .. " won it -- open the loot again to hand it over."

        else

            -- Added by hand (/il): never on a corpse, so trade it
            entry.State = "Resolved"
            entry.TradeOnly = true

            resultMessage = "Recorded -- trade this item to " .. winnerName .. "."

        end

    end

    -------------------------------------------------
    -- Winner Announcement
    --
    -- Only for Loot Council items -- Open Roll and Soft
    -- Reserve items already got their WinnerAnnounced
    -- the moment the roll ended, in FinalizeRoll, not
    -- here (Assign for those can happen much later --
    -- manual assignment, or Auto Assign turned off).
    -------------------------------------------------

    if entry.Mode == "LootCouncil" then

        local listName = ImpLoot.LootCouncil:GetActiveListName()
        local councilItem = listName and ImpLoot.LootCouncil:GetItem(listName, entry.ItemID)

        if councilItem and councilItem.Mode == "Funnel" then

            -------------------------------------------------
            -- Funnel Assignment Announcement
            --
            -- No roll or vote happened here -- a plain
            -- "assigned to" message fits better than the
            -- roll-flavoured WinnerAnnounced text.
            -------------------------------------------------

            ImpLoot.Announcements:Announce("FunnelAssigned", {
                item = entry.ItemLink,
                player = winnerName,
            })

        else

            local winnerRoll = nil

            for _, roll in ipairs(entry.Rolls) do

                if roll.Player == winnerName then
                    winnerRoll = roll
                    break
                end

            end

            if winnerRoll then

                -- A Preselected roll: say what they rolled
                ImpLoot.Announcements:Announce("WinnerAnnounced", {
                    item = entry.ItemLink,
                    winner = winnerName,
                    roll = tostring(winnerRoll.Roll),
                    range = tostring(winnerRoll.Min) .. "-" .. tostring(winnerRoll.Max),
                })

            else

                -- No roll happened (Priority list order or a
                -- council vote), so a "wins with a roll of"
                -- message would only read "N/A".
                local announcementType = (councilItem and councilItem.Mode == "Vote")
                    and "VoteAssigned" or "PriorityAssigned"

                ImpLoot.Announcements:Announce(announcementType, {
                    item = entry.ItemLink,
                    player = winnerName,
                })

            end

        end

    end

    local resultLabel = self:GetResultLabel(entry, winnerName)

    local cached = ImpLoot.ItemCache and ImpLoot.ItemCache:GetItem(entry.ItemID)
    local raidName, size, heroic = self:GetRaidContext()

    local details = {
        ItemName = (cached and cached.Name) or (entry.ItemLink and entry.ItemLink:match("%[(.-)%]")),
        Quality = (cached and cached.Quality) or self:GetItemQuality(entry.ItemID),
        WinnerClass = self:GetClassForPlayer(winnerName),
        Raid = raidName,
        Size = size,
        Heroic = heroic,
        Note = self:DescribeWin(entry, winnerName, classSlot),
        Recorder = UnitName("player"),
    }

    entry.AssignNote = nil
    entry.AssignResult = nil

    self:LogResolution(entry.ItemID, winnerName, entry.BossName, entry.Mode, resultLabel, details)

    local logged = self.Log[#self.Log]
    details.RecorderId = logged and logged.Recorder == details.Recorder and logged.RecorderId or nil

    if ImpLoot.Comms then

        ImpLoot.Comms:SendResolved(
            entry.ItemID, winnerName, entry.BossName, entry.Mode, resultLabel, details
        )

    end

    ImpLoot.Events:Fire("LootQueueChanged")

    return true, resultMessage

end
