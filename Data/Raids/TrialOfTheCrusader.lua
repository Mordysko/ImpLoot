-------------------------------------------------
-- Trial of the Crusader
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
--
-- Every boss here drops different loot per faction
-- (Horde vs Alliance) -- same slot, different item
-- name/ID. That's tracked with a Faction field on
-- each entry rather than a separate difficulty tier,
-- since ToC only has true 10/25 -- no Heroic mode.
-------------------------------------------------

local TOTC = {

    Name = "Trial of the Crusader",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "25",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Northrend Beasts
        -------------------------------------------------

        {
            Order = 1,
            Name = "Northrend Beasts",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Horde
                -------------------------------------------------

                {
                    Name = "Collar of Unending Torment",
                    IDs = {
                        Normal = 47849,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Gormok's Band",
                    IDs = {
                        Normal = 47854,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Icehowl Binding",
                    IDs = {
                        Normal = 47855,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Acidmaw Treads",
                    IDs = {
                        Normal = 47853,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Pauldrons of the Glacial Wilds",
                    IDs = {
                        Normal = 47857,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Pauldrons of the Spirit Walker",
                    IDs = {
                        Normal = 47860,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Bracers of the Northern Stalker",
                    IDs = {
                        Normal = 47850,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Gauntlets of Mounting Anger",
                    IDs = {
                        Normal = 47851,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of the Impaler",
                    IDs = {
                        Normal = 47859,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Girdle of the Frozen Reach",
                    IDs = {
                        Normal = 47858,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Dreadscale Bracers",
                    IDs = {
                        Normal = 47852,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Scepter of Imprisoned Souls",
                    IDs = {
                        Normal = 47856,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 10 Alliance
                -------------------------------------------------

                {
                    Name = "Collar of Ceaseless Torment",
                    IDs = {
                        Normal = 47607,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Carnivorous Band",
                    IDs = {
                        Normal = 47578,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Icehowl Cinch",
                    IDs = {
                        Normal = 47617,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Acidmaw Boots",
                    IDs = {
                        Normal = 47608,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Shoulderpads of the Glacial Wilds",
                    IDs = {
                        Normal = 47613,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Shoulderguards of the Spirit Walker",
                    IDs = {
                        Normal = 47616,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Armbands of the Northern Stalker",
                    IDs = {
                        Normal = 47610,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Gauntlets of Rising Anger",
                    IDs = {
                        Normal = 47609,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Belt of the Frozen Reach",
                    IDs = {
                        Normal = 47615,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Girdle of the Impaler",
                    IDs = {
                        Normal = 47614,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Dreadscale Armguards",
                    IDs = {
                        Normal = 47611,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Rod of Imprisoned Souls",
                    IDs = {
                        Normal = 47612,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                -------------------------------------------------
                -- 25 Horde
                -------------------------------------------------

                {
                    Name = "Drape of the Refreshing Winds",
                    IDs = {
                        Normal = 47256,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Cloak of the Untamed Predator",
                    IDs = {
                        Normal = 47418,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Ring of the Violent Temperament",
                    IDs = {
                        Normal = 47252,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Flowing Robes of Ascent",
                    IDs = {
                        Normal = 47425,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of the Tenebrous Mist",
                    IDs = {
                        Normal = 47258,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Boots of the Harsh Winter",
                    IDs = {
                        Normal = 47262,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Cuirass of Cruel Intent",
                    IDs = {
                        Normal = 47251,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Binding of the Ice Burrower",
                    IDs = {
                        Normal = 47265,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Hauberk of the Towering Monstrosity",
                    IDs = {
                        Normal = 47254,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Sabatons of the Courageous",
                    IDs = {
                        Normal = 47263,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Boneshatter Vambraces",
                    IDs = {
                        Normal = 47253,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Forlorn Barrier",
                    IDs = {
                        Normal = 47260,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Barb of Tarasque",
                    IDs = {
                        Normal = 47261,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Stygian Bladebreaker",
                    IDs = {
                        Normal = 47255,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 25 Alliance
                -------------------------------------------------

                {
                    Name = "Shawl of the Refreshing Winds",
                    IDs = {
                        Normal = 46976,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Drape of the Untamed Predator",
                    IDs = {
                        Normal = 46970,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Band of the Violent Temperment",
                    IDs = {
                        Normal = 46959,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Flowing Vestments of Ascent",
                    IDs = {
                        Normal = 46992,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Cord of the Tenebrous Mist",
                    IDs = {
                        Normal = 46972,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Boots of the Unrelenting Storm",
                    IDs = {
                        Normal = 46988,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Breastplate of Cruel Intent",
                    IDs = {
                        Normal = 46960,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Belt of the Ice Burrower",
                    IDs = {
                        Normal = 46990,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Chestplate of the Towering Monstrosity",
                    IDs = {
                        Normal = 46962,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Boots of the Courageous",
                    IDs = {
                        Normal = 46985,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Boneshatter Armplates",
                    IDs = {
                        Normal = 46961,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Crystal Plated Vanguard",
                    IDs = {
                        Normal = 46963,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Blade of Tarasque",
                    IDs = {
                        Normal = 46979,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Steel Bladebreaker",
                    IDs = {
                        Normal = 46958,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

            },

        },

        -------------------------------------------------
        -- 2. Lord Jaraxxus
        -------------------------------------------------

        {
            Order = 2,
            Name = "Lord Jaraxxus",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Horde
                -------------------------------------------------

                {
                    Name = "Fortitude of the Infernal",
                    IDs = {
                        Normal = 47872,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Pendant of Binding Elements",
                    IDs = {
                        Normal = 47864,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Firestorm Band",
                    IDs = {
                        Normal = 47862,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Planestalker Band",
                    IDs = {
                        Normal = 47868,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Legwraps of the Demonic Messenger",
                    IDs = {
                        Normal = 47865,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Felspark Bracers",
                    IDs = {
                        Normal = 47861,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of the Bloodhoof Emissary",
                    IDs = {
                        Normal = 47863,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sabatons of Tortured Space",
                    IDs = {
                        Normal = 49236,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Warsong Poacher's Greaves",
                    IDs = {
                        Normal = 47867,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Darkspear Ritual Binding",
                    IDs = {
                        Normal = 47866,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of the Nether Champion",
                    IDs = {
                        Normal = 47870,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Armplates of the Nether Lord",
                    IDs = {
                        Normal = 47869,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Orcish Deathblade",
                    IDs = {
                        Normal = 47871,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 10 Alliance
                -------------------------------------------------

                {
                    Name = "Amulet of Binding Elements",
                    IDs = {
                        Normal = 47619,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Endurance of the Infernal",
                    IDs = {
                        Normal = 47679,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Firestorm Ring",
                    IDs = {
                        Normal = 47618,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Planestalker Signet",
                    IDs = {
                        Normal = 47703,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Leggings of the Demonic Messenger",
                    IDs = {
                        Normal = 47620,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Felspark Bindings",
                    IDs = {
                        Normal = 47663,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Belt of the Winter Solstice",
                    IDs = {
                        Normal = 47669,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Boots of Tortured Space",
                    IDs = {
                        Normal = 49235,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Sentinel Scouting Greaves",
                    IDs = {
                        Normal = 47683,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Girdle of the Farseer",
                    IDs = {
                        Normal = 47621,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Girdle of the Nether Champion",
                    IDs = {
                        Normal = 47711,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Armguards of the Nether Lord",
                    IDs = {
                        Normal = 47680,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Dirk of the Night Watch",
                    IDs = {
                        Normal = 47676,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                -------------------------------------------------
                -- 25 Horde
                -------------------------------------------------

                {
                    Name = "Pride of the Demon Lord",
                    IDs = {
                        Normal = 47436,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Charge of the Eredar",
                    IDs = {
                        Normal = 47272,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Circle of the Darkmender",
                    IDs = {
                        Normal = 47278,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Pants of the Soothing Touch",
                    IDs = {
                        Normal = 47274,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Vest of Calamitous Fate",
                    IDs = {
                        Normal = 47270,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Bindings of the Autumn Willow",
                    IDs = {
                        Normal = 47277,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Wristwraps of Cloudy Omen",
                    IDs = {
                        Normal = 47280,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Dawnbreaker Sabatons",
                    IDs = {
                        Normal = 47269,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Leggings of Failing Light",
                    IDs = {
                        Normal = 47279,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Legplates of Feverish Dedication",
                    IDs = {
                        Normal = 47273,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Bloodbath Girdle",
                    IDs = {
                        Normal = 47268,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Solace of the Fallen",
                    IDs = {
                        Normal = 47271,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Talisman of Heedless Sins",
                    IDs = {
                        Normal = 47276,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Blood Fury",
                    IDs = {
                        Normal = 47266,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Death's Head Crossbow",
                    IDs = {
                        Normal = 47267,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 25 Alliance
                -------------------------------------------------

                {
                    Name = "Pride of the Eredar",
                    IDs = {
                        Normal = 47042,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Charge of the Demon Lord",
                    IDs = {
                        Normal = 47043,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Ring of the Darkmender",
                    IDs = {
                        Normal = 47223,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Leggings of the Soothing Touch",
                    IDs = {
                        Normal = 47051,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Cuirass of Calamitous Fate",
                    IDs = {
                        Normal = 47000,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bracers of the Autumn Willow",
                    IDs = {
                        Normal = 47055,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bracers of Cloudy Omen",
                    IDs = {
                        Normal = 47056,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Dawnbreaker Greaves",
                    IDs = {
                        Normal = 46997,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Legplates of Failing Light",
                    IDs = {
                        Normal = 47057,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Legguards of Feverish Dedication",
                    IDs = {
                        Normal = 47052,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bloodbath Belt",
                    IDs = {
                        Normal = 46999,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Solace of the Defeated",
                    IDs = {
                        Normal = 47041,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Symbol of Transgression",
                    IDs = {
                        Normal = 47053,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Lionhead Slasher",
                    IDs = {
                        Normal = 46996,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Talonstrike",
                    IDs = {
                        Normal = 46994,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

            },

        },

        -------------------------------------------------
        -- 3. Faction Champions
        -------------------------------------------------

        {
            Order = 3,
            Name = "Faction Champions",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Horde
                -------------------------------------------------

                {
                    Name = "Sunreaver Magus' Sandals",
                    IDs = {
                        Normal = 47873,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sunreaver Assassin's Gloves",
                    IDs = {
                        Normal = 47878,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sunreaver Ranger's Helm",
                    IDs = {
                        Normal = 47875,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sunreaver Champion's Faceplate",
                    IDs = {
                        Normal = 47876,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sunreaver Defender's Pauldrons",
                    IDs = {
                        Normal = 47877,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Binding Stone",
                    IDs = {
                        Normal = 47880,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Eitrigg's Oath",
                    IDs = {
                        Normal = 47882,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Fetish of Volatile Power",
                    IDs = {
                        Normal = 47879,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Vengeance of the Forsaken",
                    IDs = {
                        Normal = 47881,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sunreaver Disciple's Blade",
                    IDs = {
                        Normal = 47874,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 10 Alliance
                -------------------------------------------------

                {
                    Name = "Sandals of the Silver Magus",
                    IDs = {
                        Normal = 47721,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Gloves of the Silver Assassin",
                    IDs = {
                        Normal = 47719,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Helm of the Silver Ranger",
                    IDs = {
                        Normal = 47718,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Faceplate of the Silver Champion",
                    IDs = {
                        Normal = 47717,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Pauldrons of the Silver Defender",
                    IDs = {
                        Normal = 47720,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Binding Light",
                    IDs = {
                        Normal = 47728,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Fervor of the Frostborn",
                    IDs = {
                        Normal = 47727,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Talisman of Volatile Power",
                    IDs = {
                        Normal = 47726,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Victor's Call",
                    IDs = {
                        Normal = 47725,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Blade of the Silver Disciple",
                    IDs = {
                        Normal = 47724,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                -------------------------------------------------
                -- 25 Horde
                -------------------------------------------------

                {
                    Name = "Shroud of Displacement",
                    IDs = {
                        Normal = 47291,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Band of Callous Aggression",
                    IDs = {
                        Normal = 47282,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Sandals of the Mourning Widow",
                    IDs = {
                        Normal = 47293,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of Biting Cold",
                    IDs = {
                        Normal = 47286,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Robes of the Shattered Fellowship",
                    IDs = {
                        Normal = 47292,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Icewalker Treads",
                    IDs = {
                        Normal = 47284,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Sabatons of Tremoring Earth",
                    IDs = {
                        Normal = 47295,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Leggings of Concealed Hatred",
                    IDs = {
                        Normal = 47289,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Bracers of the Silent Massacre",
                    IDs = {
                        Normal = 47281,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Chestplate of the Frostwolf Hero",
                    IDs = {
                        Normal = 47288,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of Bloodied Scars",
                    IDs = {
                        Normal = 47283,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Bracers of the Broken Bond",
                    IDs = {
                        Normal = 47294,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Bastion of Resolve",
                    IDs = {
                        Normal = 47287,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Juggernaut's Vitality",
                    IDs = {
                        Normal = 47290,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Dual-blade Butcher",
                    IDs = {
                        Normal = 47285,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 25 Alliance
                -------------------------------------------------

                {
                    Name = "Cloak of Displacement",
                    IDs = {
                        Normal = 47089,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Ring of Callous Aggression",
                    IDs = {
                        Normal = 47070,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Boots of the Mourning Widow",
                    IDs = {
                        Normal = 47092,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Cord of Biting Cold",
                    IDs = {
                        Normal = 47081,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Vestments of the Shattered Fellowship",
                    IDs = {
                        Normal = 47094,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Treads of the Icewalker",
                    IDs = {
                        Normal = 47071,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Boots of Tremoring Earth",
                    IDs = {
                        Normal = 47090,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Legguards of Concealed Hatred",
                    IDs = {
                        Normal = 47083,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bracers of the Untold Massacre",
                    IDs = {
                        Normal = 47073,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Chestplate of the Frostborn Hero",
                    IDs = {
                        Normal = 47082,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Girdle of Bloodied Scars",
                    IDs = {
                        Normal = 47072,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Vambraces of the Broken Bond",
                    IDs = {
                        Normal = 47093,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bastion of Purity",
                    IDs = {
                        Normal = 47079,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Satrina's Impeding Scarab",
                    IDs = {
                        Normal = 47080,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Justicebringer",
                    IDs = {
                        Normal = 47069,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

            },

        },

        -------------------------------------------------
        -- 4. Twin Val'kyr
        -------------------------------------------------

        {
            Order = 4,
            Name = "Twin Val'kyr",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Horde
                -------------------------------------------------

                {
                    Name = "Darkbane Amulet",
                    IDs = {
                        Normal = 47890,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Band of the Twin Val'kyr",
                    IDs = {
                        Normal = 47888,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sandals of the Grieving Soul",
                    IDs = {
                        Normal = 49232,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Looming Shadow Wraps",
                    IDs = {
                        Normal = 47889,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Vest of Shifting Shadows",
                    IDs = {
                        Normal = 47887,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Helm of the High Mesa",
                    IDs = {
                        Normal = 47891,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sen'jin Ritualist Gloves",
                    IDs = {
                        Normal = 47893,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Greaves of the Lingering Vortex",
                    IDs = {
                        Normal = 47885,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Lightbane Focus",
                    IDs = {
                        Normal = 47913,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Nemesis Blade",
                    IDs = {
                        Normal = 47886,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Widebarrel Flintlock",
                    IDs = {
                        Normal = 47883,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Illumination",
                    IDs = {
                        Normal = 47892,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Edge of Agony",
                    IDs = {
                        Normal = 47884,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 10 Alliance
                -------------------------------------------------

                {
                    Name = "Darkbane Pendant",
                    IDs = {
                        Normal = 47747,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Loop of the Twin Val'kyr",
                    IDs = {
                        Normal = 47700,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Boots of the Grieving Soul",
                    IDs = {
                        Normal = 49231,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Gloves of Looming Shadow",
                    IDs = {
                        Normal = 47745,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Armor of Shifting Shadows",
                    IDs = {
                        Normal = 47739,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Helm of the Snowy Grotto",
                    IDs = {
                        Normal = 47746,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Gloves of the Azure Prophet",
                    IDs = {
                        Normal = 47744,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Sabatons of the Lingering Vortex",
                    IDs = {
                        Normal = 47738,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Chalice of Benedictus",
                    IDs = {
                        Normal = 47742,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Icefall Blade",
                    IDs = {
                        Normal = 47736,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "The Diplomat",
                    IDs = {
                        Normal = 47740,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Enlightenment",
                    IDs = {
                        Normal = 47743,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Reckoning",
                    IDs = {
                        Normal = 47737,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                -------------------------------------------------
                -- 25 Horde
                -------------------------------------------------

                {
                    Name = "Cry of the Val'kyr",
                    IDs = {
                        Normal = 47307,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Legionnaire's Gorget",
                    IDs = {
                        Normal = 47305,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "The Executioner's Vice",
                    IDs = {
                        Normal = 47297,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Skyweaver Vestments",
                    IDs = {
                        Normal = 47301,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Dark Essence Bindings",
                    IDs = {
                        Normal = 47306,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of Pale Thorns",
                    IDs = {
                        Normal = 47308,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of the Pitiless Killer",
                    IDs = {
                        Normal = 47299,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Greaves of Ruthless Judgment",
                    IDs = {
                        Normal = 47296,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Chestplate of the Frozen Lake",
                    IDs = {
                        Normal = 47310,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Legplates of Ascension",
                    IDs = {
                        Normal = 47304,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Armguards of the Shieldmaiden",
                    IDs = {
                        Normal = 47298,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Death's Choice",
                    IDs = {
                        Normal = 47303,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Mystifying Charm",
                    IDs = {
                        Normal = 47309,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Gouge of the Frigid Heart",
                    IDs = {
                        Normal = 47300,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Twin's Pact",
                    IDs = {
                        Normal = 47302,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 25 Alliance
                -------------------------------------------------

                {
                    Name = "Wail of the Val'kyr",
                    IDs = {
                        Normal = 47139,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "The Arbiter's Muse",
                    IDs = {
                        Normal = 47116,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "The Executioner's Malice",
                    IDs = {
                        Normal = 47105,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Skyweaver Robes",
                    IDs = {
                        Normal = 47126,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bindings of Dark Essence",
                    IDs = {
                        Normal = 47141,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Cord of Pale Thorns",
                    IDs = {
                        Normal = 47140,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Belt of the Merciless Killer",
                    IDs = {
                        Normal = 47107,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Sabatons of Ruthless Judgment",
                    IDs = {
                        Normal = 47106,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Breastplate of the Frozen Lake",
                    IDs = {
                        Normal = 47142,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Legguards of Ascension",
                    IDs = {
                        Normal = 47121,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bracers of the Shieldmaiden",
                    IDs = {
                        Normal = 47108,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Death's Verdict",
                    IDs = {
                        Normal = 47115,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Chalice of Searing Light",
                    IDs = {
                        Normal = 47138,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Twin Spike",
                    IDs = {
                        Normal = 47104,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Lupine Longstaff",
                    IDs = {
                        Normal = 47114,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

            },

        },

        -------------------------------------------------
        -- 5. Anub'arak
        -------------------------------------------------

        {
            Order = 5,
            Name = "Anub'arak",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Horde
                -------------------------------------------------

                {
                    Name = "Robes of the Sleepless",
                    IDs = {
                        Normal = 47906,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Belt of the Eternal",
                    IDs = {
                        Normal = 47909,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Shoulderpads of the Snow Bandit",
                    IDs = {
                        Normal = 47904,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Helm of the Crypt Lord",
                    IDs = {
                        Normal = 47897,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Pauldrons of the Shadow Hunter",
                    IDs = {
                        Normal = 47901,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Stoneskin Chestplate",
                    IDs = {
                        Normal = 47896,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Legplates of Redeemed Blood",
                    IDs = {
                        Normal = 47902,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Sunwalker Legguards",
                    IDs = {
                        Normal = 47908,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Aegis of the Coliseum",
                    IDs = {
                        Normal = 47910,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Pride of the Kor'kron",
                    IDs = {
                        Normal = 47895,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Mace of the Earthborn Chieftain",
                    IDs = {
                        Normal = 47894,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Frostblade Hatchet",
                    IDs = {
                        Normal = 47898,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Blackhorn Bludgeon",
                    IDs = {
                        Normal = 47905,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Ardent Guard",
                    IDs = {
                        Normal = 47899,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Forsaken Bonecarver",
                    IDs = {
                        Normal = 47903,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Darkmaw Crossbow",
                    IDs = {
                        Normal = 47907,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Anguish",
                    IDs = {
                        Normal = 47911,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                {
                    Name = "Perdition",
                    IDs = {
                        Normal = 47900,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 10 Alliance
                -------------------------------------------------

                {
                    Name = "Vestments of the Sleepless",
                    IDs = {
                        Normal = 47838,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Cinch of the Undying",
                    IDs = {
                        Normal = 47837,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Spaulders of the Snow Bandit",
                    IDs = {
                        Normal = 47832,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Helmet of the Crypt Lord",
                    IDs = {
                        Normal = 47813,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Pauldrons of the Timeless Hunter",
                    IDs = {
                        Normal = 47829,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Chestguard of the Warden",
                    IDs = {
                        Normal = 47811,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Legplates of the Immortal Spider",
                    IDs = {
                        Normal = 47836,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Legplates of the Silver Hand",
                    IDs = {
                        Normal = 47830,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Bulwark of the Royal Guard",
                    IDs = {
                        Normal = 47835,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Vigilant Ward",
                    IDs = {
                        Normal = 47812,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Argent Resolve",
                    IDs = {
                        Normal = 47809,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "The Lion's Maw",
                    IDs = {
                        Normal = 47808,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "The Grinder",
                    IDs = {
                        Normal = 47816,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Crusader's Glory",
                    IDs = {
                        Normal = 47810,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Westfall Saber",
                    IDs = {
                        Normal = 47814,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Baelgun's Heavy Crossbow",
                    IDs = {
                        Normal = 47741,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Fordragon Blades",
                    IDs = {
                        Normal = 47834,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                {
                    Name = "Cold Convergence",
                    IDs = {
                        Normal = 47815,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    Faction = "Alliance",
                },

                -------------------------------------------------
                -- 25 Horde
                -------------------------------------------------

                {
                    Name = "Maiden's Adoration",
                    IDs = {
                        Normal = 47328,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Might of the Nerub",
                    IDs = {
                        Normal = 47320,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Band of the Traitor King",
                    IDs = {
                        Normal = 47315,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Lurid Manifestation",
                    IDs = {
                        Normal = 47327,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Boots of the Icy Floe",
                    IDs = {
                        Normal = 47321,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Handwraps of the Lifeless Touch",
                    IDs = {
                        Normal = 47326,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Breeches of the Deepening Void",
                    IDs = {
                        Normal = 47317,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Bindings of the Ashen Saint",
                    IDs = {
                        Normal = 47324,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Leggings of the Awakening",
                    IDs = {
                        Normal = 47318,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Armbands of Dark Determination",
                    IDs = {
                        Normal = 47313,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Cuirass of Flowing Elements",
                    IDs = {
                        Normal = 47325,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Leggings of the Lurking Threat",
                    IDs = {
                        Normal = 47319,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Waistguard of Deathly Dominion",
                    IDs = {
                        Normal = 47311,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Greaves of the Saronite Citadel",
                    IDs = {
                        Normal = 47312,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Gauntlets of Bitter Reprisal",
                    IDs = {
                        Normal = 47330,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Girdle of the Forgotten Martyr",
                    IDs = {
                        Normal = 47323,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Reign of the Dead",
                    IDs = {
                        Normal = 47316,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Suffering's End",
                    IDs = {
                        Normal = 47322,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Hellscream Slicer",
                    IDs = {
                        Normal = 47314,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                {
                    Name = "Hellion Glaive",
                    IDs = {
                        Normal = 47329,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Horde",
                },

                -------------------------------------------------
                -- 25 Alliance
                -------------------------------------------------

                {
                    Name = "Maiden's Favor",
                    IDs = {
                        Normal = 47225,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Strength of the Nerub",
                    IDs = {
                        Normal = 47183,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Band of Deplorable Violence",
                    IDs = {
                        Normal = 47054,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Signet of the Traitor King",
                    IDs = {
                        Normal = 47149,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Footpads of the Icy Floe",
                    IDs = {
                        Normal = 47194,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Gloves of the Lifeless Touch",
                    IDs = {
                        Normal = 47235,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Leggings of the Deepening Void",
                    IDs = {
                        Normal = 47187,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Armbands of the Ashen Saint",
                    IDs = {
                        Normal = 47203,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Legwraps of the Awakening",
                    IDs = {
                        Normal = 47186,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Bracers of Dark Determination",
                    IDs = {
                        Normal = 47151,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Chestguard of Flowing Elements",
                    IDs = {
                        Normal = 47204,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Legguards of the Lurking Threat",
                    IDs = {
                        Normal = 47184,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Belt of Deathly Dominion",
                    IDs = {
                        Normal = 47152,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Greaves of the 7th Legion",
                    IDs = {
                        Normal = 47150,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Gloves of Bitter Reprisal",
                    IDs = {
                        Normal = 47234,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Belt of the Forgotten Martyr",
                    IDs = {
                        Normal = 47195,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Reign of the Unliving",
                    IDs = {
                        Normal = 47182,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Misery's End",
                    IDs = {
                        Normal = 47193,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Stormpike Cleaver",
                    IDs = {
                        Normal = 47148,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

                {
                    Name = "Archon Glaive",
                    IDs = {
                        Normal = 47233,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    Faction = "Alliance",
                },

            },

        },

    },

}

ImpLoot.Database:RegisterRaid(TOTC)
