-------------------------------------------------
-- Onyxia's Lair
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
-------------------------------------------------

local ONYXIA_RAID = {

    Name = "Onyxia's Lair",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "25",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Onyxia
        -------------------------------------------------

        {
            Order = 1,
            Name = "Onyxia",
            NPCID = 10184,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Fluttering Sapphiron Drape",
                    IDs = {
                        Normal = 49307,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Runed Ring of Binding",
                    IDs = {
                        Normal = 49309,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Eskhandar's Choker",
                    IDs = {
                        Normal = 49306,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Netherwind Hood",
                    IDs = {
                        Normal = 49318,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Circlet of Transcendence",
                    IDs = {
                        Normal = 49316,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Coronet of Transcendence",
                    IDs = {
                        Normal = 49317,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Nemesis Skullcover",
                    IDs = {
                        Normal = 49315,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Stormrage Antlers",
                    IDs = {
                        Normal = 49327,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Stormrage Helm",
                    IDs = {
                        Normal = 49328,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Stormrage Hood",
                    IDs = {
                        Normal = 49326,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Bloodfang Mask",
                    IDs = {
                        Normal = 49322,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Dragonstalker's Helmet",
                    IDs = {
                        Normal = 49319,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Coif of Ten Storms",
                    IDs = {
                        Normal = 49331,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Cowl of Ten Storms",
                    IDs = {
                        Normal = 49330,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gaze of Ten Storms",
                    IDs = {
                        Normal = 49329,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Frostforged Helmet",
                    IDs = {
                        Normal = 49333,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Frostforged Ringhelm",
                    IDs = {
                        Normal = 49332,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Judgement Cover",
                    IDs = {
                        Normal = 49323,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Judgement Helm",
                    IDs = {
                        Normal = 49325,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Judgement Helmet",
                    IDs = {
                        Normal = 49324,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Faceguard of Wrath",
                    IDs = {
                        Normal = 49320,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Greathelm of Wrath",
                    IDs = {
                        Normal = 49321,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Purified Shard of the Flame",
                    IDs = {
                        Normal = 49463,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Purified Shard of the Scale",
                    IDs = {
                        Normal = 49310,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Empowered Deathbringer",
                    IDs = {
                        Normal = 49297,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Rusted Gutgore Ripper",
                    IDs = {
                        Normal = 49437,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Sharpened Fang of the Mystics",
                    IDs = {
                        Normal = 49304,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Antique Cornerstone Grimoire",
                    IDs = {
                        Normal = 49308,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gleaming Quel'Serrar",
                    IDs = {
                        Normal = 49303,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = { "Paladin", "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Glinting Azuresong Mageblade",
                    IDs = {
                        Normal = 49298,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Singed Vis'kag the Bloodletter",
                    IDs = {
                        Normal = 49296,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Snub-Nose Blastershot Launcher",
                    IDs = {
                        Normal = 49305,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Reclaimed Shadowstrike",
                    IDs = {
                        Normal = 49302,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Reclaimed Thunderstrike",
                    IDs = {
                        Normal = 49301,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Keen Obsidian Edged Blade",
                    IDs = {
                        Normal = 49299,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Reins of the Onyxian Drake",
                    IDs = {
                        Normal = 49636,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Enlarged Onyxia Hide Backpack",
                    IDs = {
                        Normal = 49295,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Bag",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Flowing Sapphiron Drape",
                    IDs = {
                        Normal = 49491,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Eskhandar's Links",
                    IDs = {
                        Normal = 49492,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Signified Ring of Binding",
                    IDs = {
                        Normal = 49489,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Netherwind Crown",
                    IDs = {
                        Normal = 49481,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Aurora of Transcendence",
                    IDs = {
                        Normal = 49482,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Halo of Transcendence",
                    IDs = {
                        Normal = 49483,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Nemesis Skullcap",
                    IDs = {
                        Normal = 49484,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Stormrage Cover",
                    IDs = {
                        Normal = 49473,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Stormrage Coverlet",
                    IDs = {
                        Normal = 49471,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Stormrage Crown",
                    IDs = {
                        Normal = 49472,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Bloodfang Hood",
                    IDs = {
                        Normal = 49477,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Dragonstalker's Helm",
                    IDs = {
                        Normal = 49480,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Crown of Ten Storms",
                    IDs = {
                        Normal = 49469,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Helm of Ten Storms",
                    IDs = {
                        Normal = 49468,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Helmet of Ten Storms",
                    IDs = {
                        Normal = 49470,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Frostforged Greathelm",
                    IDs = {
                        Normal = 49467,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Frostforged Helm",
                    IDs = {
                        Normal = 49466,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Judgement Crown",
                    IDs = {
                        Normal = 49476,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Judgement Heaume",
                    IDs = {
                        Normal = 49475,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Judgement Hood",
                    IDs = {
                        Normal = 49474,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Helm of Wrath",
                    IDs = {
                        Normal = 49479,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Helmet of Wrath",
                    IDs = {
                        Normal = 49478,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Shiny Shard of the Flame",
                    IDs = {
                        Normal = 49464,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Shiny Shard of the Scale",
                    IDs = {
                        Normal = 49488,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Raging Deathbringer",
                    IDs = {
                        Normal = 49500,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Honed Fang of the Mystics",
                    IDs = {
                        Normal = 49494,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Tarnished Gutgore Ripper",
                    IDs = {
                        Normal = 49465,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Antediluvian Cornerstone Grimoire",
                    IDs = {
                        Normal = 49490,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Burnished Quel'Serrar",
                    IDs = {
                        Normal = 49495,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = { "Paladin", "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Polished Azuresong Mageblade",
                    IDs = {
                        Normal = 49499,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Tempered Vis'kag the Bloodletter",
                    IDs = {
                        Normal = 49501,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Rifled Blastershot Launcher",
                    IDs = {
                        Normal = 49493,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Reinforced Shadowstrike",
                    IDs = {
                        Normal = 49496,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Reinforced Thunderstrike",
                    IDs = {
                        Normal = 49497,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Sharpened Obsidian Edged Blade",
                    IDs = {
                        Normal = 49498,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Reins of the Onyxian Drake",
                    IDs = {
                        Normal = 49636,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Enlarged Onyxia Hide Backpack",
                    IDs = {
                        Normal = 49295,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Bag",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

            },

        },

    },

}

ImpLoot.Database:RegisterRaid(ONYXIA_RAID)
