-------------------------------------------------
-- ImpLoot Announcements
--
-- Per-announcement-type settings: whether it's on,
-- a custom text template (with {placeholder} tokens),
-- and which channel it goes out on. "Auto" escalates
-- Say -> Party -> Raid/Raid Warning, matching
-- LootHog's own default behaviour -- everything else
-- is an explicit, always-honoured channel choice.
-------------------------------------------------

ImpLoot.Announcements = {}

-------------------------------------------------
-- Defaults
-------------------------------------------------

ImpLoot.Announcements.Defaults = {

    OpenRollAnnounced = {
        Enabled = true,
        Text = "{item} available now for an open roll. You have {seconds} seconds to roll.",
        Channel = "Auto",
    },

    SoftReserveAnnounced = {
        Enabled = true,
        Text = "{item}, reserved by {reservers}. Roll now!",
        Channel = "Auto",
    },

    WinnerAnnounced = {
        Enabled = true,
        Text = "Congratulations! {winner} wins with a roll of {roll}. ({range})",
        Channel = "Auto",
    },

    EligibleClasses = {
        Enabled = true,
        Text = "{item} can be used by: {classes}",
        Channel = "Auto",
    },

    NoRollsDisenchant = {
        Enabled = true,
        Text = "No rolls on {item} -- assigned to the disenchanter.",
        Channel = "Auto",
    },

    RollTimeRemaining = {
        Enabled = true,
        Text = "{seconds} seconds left to roll on {item}!",
        Channel = "AutoNoWarning",
    },

    RollCountdown = {
        Enabled = true,
        Text = "{count}",
        Channel = "AutoNoWarning",
    },

    LCVoteCalled = {
        Enabled = true,
        Text = "Loot Council vote called for {item}.",
        Channel = "Auto",
    },

    FunnelAssigned = {
        Enabled = true,
        Text = "{item} assigned to {player}",
        Channel = "Auto",
    },

}

-------------------------------------------------
-- Channel Names -> SendChatMessage Values
-------------------------------------------------

local CHANNEL_MAP = {
    Say = "SAY",
    Party = "PARTY",
    Raid = "RAID",
    RaidWarning = "RAID_WARNING",
    Guild = "GUILD",
    Officer = "OFFICER",
}

-------------------------------------------------
-- Initialize
-------------------------------------------------

-------------------------------------------------
-- Migration Version
--
-- Bump this whenever a default template text/channel
-- changes and existing users' saved (now-outdated)
-- values should be force-replaced with the new
-- default, rather than requiring a manual Reset click.
-- Runs once per bump, never again after that.
-------------------------------------------------

local CURRENT_MIGRATION_VERSION = 1

local MIGRATED_TYPES = {
    "OpenRollAnnounced", "WinnerAnnounced", "RollCountdown", "RollTimeRemaining",
}

function ImpLoot.Announcements:Initialize()

    ImpLootDB.Announcements = ImpLootDB.Announcements or {}

    for typeName, defaults in pairs(self.Defaults) do

        ImpLootDB.Announcements[typeName] = ImpLootDB.Announcements[typeName] or {}

        for key, value in pairs(defaults) do

            if ImpLootDB.Announcements[typeName][key] == nil then
                ImpLootDB.Announcements[typeName][key] = value
            end

        end

    end

    local migratedVersion = ImpLootDB.AnnouncementsMigratedVersion or 0

    if migratedVersion < CURRENT_MIGRATION_VERSION then

        for _, typeName in ipairs(MIGRATED_TYPES) do

            local defaults = self.Defaults[typeName]

            if defaults then

                ImpLootDB.Announcements[typeName].Text = defaults.Text
                ImpLootDB.Announcements[typeName].Channel = defaults.Channel

            end

        end

        ImpLootDB.AnnouncementsMigratedVersion = CURRENT_MIGRATION_VERSION

    end

    self.DB = ImpLootDB.Announcements

end

-------------------------------------------------
-- Settings Access
-------------------------------------------------

function ImpLoot.Announcements:GetSettings(typeName)
    return self.DB[typeName]
end

function ImpLoot.Announcements:SetEnabled(typeName, enabled)

    if self.DB[typeName] then
        self.DB[typeName].Enabled = enabled
    end

end

function ImpLoot.Announcements:SetText(typeName, text)

    if self.DB[typeName] then
        self.DB[typeName].Text = text
    end

end

function ImpLoot.Announcements:SetChannel(typeName, channel)

    if self.DB[typeName] then
        self.DB[typeName].Channel = channel
    end

end

-------------------------------------------------
-- Reset All To Defaults
--
-- Mutates each type's existing settings table in
-- place, not the version-gated migration path -- so
-- this always applies regardless of migration state,
-- and the options panel's widgets (whose closures
-- reference these same tables) reflect it immediately.
-------------------------------------------------

function ImpLoot.Announcements:ResetAllToDefaults()

    for typeName, defaults in pairs(self.Defaults) do

        local settings = self.DB[typeName]

        if settings then

            for key, value in pairs(defaults) do
                settings[key] = value
            end

        end

    end

end

-------------------------------------------------
-- Resolve Channel
-------------------------------------------------

function ImpLoot.Announcements:ResolveChannel(channel)

    if channel ~= "Auto" and channel ~= "AutoNoWarning" then
        return CHANNEL_MAP[channel] or "SAY"
    end

    local numRaid = 0
    local numParty = 0

    if GetNumRaidMembers then
        numRaid = GetNumRaidMembers()
    end

    if GetNumPartyMembers then
        numParty = GetNumPartyMembers()
    end

    if numRaid > 0 then

        -- AutoNoWarning caps at RAID even for a leader/officer --
        -- for rapid-fire announcements (the roll countdown) since
        -- WoW throttles how often consecutive Raid Warnings can be
        -- sent, and multiple countdown numbers a second apart would
        -- get silently dropped by the client on that channel.
        if channel == "Auto"
        and ((IsRaidLeader and IsRaidLeader())
        or (IsRaidOfficer and IsRaidOfficer())) then

            return "RAID_WARNING"

        end

        return "RAID"

    end

    if numParty > 0 then
        return "PARTY"
    end

    return "SAY"

end

-------------------------------------------------
-- Format Text
-------------------------------------------------

function ImpLoot.Announcements:FormatText(typeName, placeholders)

    local settings = self.DB[typeName]

    if not settings then
        return nil
    end

    local text = settings.Text

    for key, value in pairs(placeholders or {}) do

        text = text:gsub("{" .. key .. "}", (tostring(value):gsub("%%", "%%%%")))

    end

    return text

end

-------------------------------------------------
-- Announce
--
-- Composes and sends the message for a given type,
-- if it's enabled. Returns false without sending
-- anything if the type is disabled or has no text.
-------------------------------------------------

function ImpLoot.Announcements:Announce(typeName, placeholders)

    local settings = self.DB[typeName]

    if not settings or not settings.Enabled then
        return false
    end

    local text = self:FormatText(typeName, placeholders)

    if not text or text == "" then
        return false
    end

    local channel = self:ResolveChannel(settings.Channel)

    SendChatMessage(text, channel)

    return true

end
