-------------------------------------------------
-- The Obsidian Sanctum
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
--
-- Sartharion drops extra loot depending on how many
-- of the three drakes (Tenebron, Shadron, Vesperon)
-- are still alive at his death. That's tracked with
-- BonusLootGroup, same mechanism as Ulduar's hard
-- mode loot, just with three named tiers instead of
-- one. Untagged items are always-available base loot.
-------------------------------------------------

local OS_RAID = {

    Name = "Obsidian Sanctum",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "25",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Sartharion
        -------------------------------------------------

        {
            Order = 1,
            Name = "Sartharion",
            NPCID = 28860,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Gloves of the Lost Conqueror",
                    IDs = {
                        Normal = 40613,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gloves of the Lost Protector",
                    IDs = {
                        Normal = 40614,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gloves of the Lost Vanquisher",
                    IDs = {
                        Normal = 40615,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Satchel of Spoils",
                    IDs = {
                        Normal = 43347,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Bag",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Dragon Hide Bag",
                    IDs = {
                        Normal = 43345,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Bag",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gale-Proof Cloak",
                    IDs = {
                        Normal = 43988,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Signet of the Accord",
                    IDs = {
                        Normal = 40426,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Circle of Arcane Streams",
                    IDs = {
                        Normal = 40427,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Volitant Amulet",
                    IDs = {
                        Normal = 43992,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Majestic Dragon Figurine",
                    IDs = {
                        Normal = 40430,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Crimson Steel",
                    IDs = {
                        Normal = 40429,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Fist Weapon",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Blade-Scarred Tunic",
                    IDs = {
                        Normal = 43990,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Legguards of Composure",
                    IDs = {
                        Normal = 43991,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Titan's Outlook",
                    IDs = {
                        Normal = 40428,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Remembrance Girdle",
                    IDs = {
                        Normal = 43989,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Greatring of Collision",
                    IDs = {
                        Normal = 43993,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Enamored Cowl",
                    IDs = {
                        Normal = 43995,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Chestguard of Flagrant Prowess",
                    IDs = {
                        Normal = 43998,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Belabored Legplates",
                    IDs = {
                        Normal = 43994,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Reins of the Black Drake",
                    IDs = {
                        Normal = 43986,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Bonus Loot - Three Drakes Left",
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Gauntlets of the Lost Conqueror",
                    IDs = {
                        Normal = 40628,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Gauntlets of the Lost Protector",
                    IDs = {
                        Normal = 40629,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Gauntlets of the Lost Vanquisher",
                    IDs = {
                        Normal = 40630,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Large Satchel of Spoils",
                    IDs = {
                        Normal = 43346,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Bag",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Dragon Hide Bag",
                    IDs = {
                        Normal = 43345,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Bag",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Fury of the Five Flights",
                    IDs = {
                        Normal = 40431,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Illustration of the Dragon Soul",
                    IDs = {
                        Normal = 40432,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Staff of Restraint",
                    IDs = {
                        Normal = 40455,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Staff",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "The Sanctum's Flowing Vestments",
                    IDs = {
                        Normal = 44002,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Mantle of the Eternal Sentinel",
                    IDs = {
                        Normal = 40439,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Concealment Shoulderpads",
                    IDs = {
                        Normal = 40437,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Hyaline Helm of the Sniper",
                    IDs = {
                        Normal = 40451,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Bountiful Gauntlets",
                    IDs = {
                        Normal = 44004,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Council Chamber Epaulets",
                    IDs = {
                        Normal = 40438,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Upstanding Spaulders",
                    IDs = {
                        Normal = 44003,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Dragonstorm Breastplate",
                    IDs = {
                        Normal = 44000,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Chestplate of the Great Aspects",
                    IDs = {
                        Normal = 40453,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Dragon Brood Legguards",
                    IDs = {
                        Normal = 40446,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - One Drake Left",
                },

                {
                    Name = "Wyrmrest Band",
                    IDs = {
                        Normal = 40433,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Pennant Cloak",
                    IDs = {
                        Normal = 44005,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Unsullied Cuffs",
                    IDs = {
                        Normal = 44008,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Headpiece of Reconciliation",
                    IDs = {
                        Normal = 44007,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Leggings of the Honored",
                    IDs = {
                        Normal = 44011,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Obsidian Greathelm",
                    IDs = {
                        Normal = 44006,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - Two Drakes Left",
                },

                {
                    Name = "Reins of the Twilight Drake",
                    IDs = {
                        Normal = 43954,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Bonus Loot - Three Drakes Left",
                },

            },

        },

    },

}

ImpLoot.Database:RegisterRaid(OS_RAID)
