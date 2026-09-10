-------------------------------------------------
-- Vault of Archavon
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
--
-- Sourced from AtlasLoot's own WotLK data file, which
-- already tags every item by class + spec (and, for
-- Koralon's tier tokens specifically, by faction --
-- same mechanism as Trial of the Crusader).
--
-- BonusLootGroup carries the spec name for classes
-- that split by role (e.g. Paladin: Holy/Protection/
-- Retribution); single-profile classes (Mage, Warlock,
-- Hunter, Rogue) fall back to a plain Tier Tokens /
-- PvP Season Gear split. Class-agnostic PvP accessory
-- pieces (wrist/waist/feet) are tagged with every class
-- that shares their armor type.
-------------------------------------------------

local VOA_RAID = {

    Name = "Vault of Archavon",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "25",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Archavon the Stone Watcher
        -------------------------------------------------

        {
            Order = 1,
            Name = "Archavon the Stone Watcher",
            NPCID = 31125,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Heroes' Dreadnaught Battleplate",
                    IDs = {
                        Normal = 39606,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Heroes' Dreadnaught Gauntlets",
                    IDs = {
                        Normal = 39609,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Heroes' Dreadnaught Legplates",
                    IDs = {
                        Normal = 39607,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hateful Gladiator's Plate Chestpiece",
                    IDs = {
                        Normal = 40783,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hateful Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 40801,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hateful Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 40840,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Heroes' Dreadnaught Breastplate",
                    IDs = {
                        Normal = 39611,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Heroes' Dreadnaught Handguards",
                    IDs = {
                        Normal = 39622,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Heroes' Dreadnaught Legguards",
                    IDs = {
                        Normal = 39612,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Heroes' Redemption Gloves",
                    IDs = {
                        Normal = 39632,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Heroes' Redemption Greaves",
                    IDs = {
                        Normal = 39630,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Heroes' Redemption Tunic",
                    IDs = {
                        Normal = 39629,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Hateful Gladiator's Ornamented Chestguard",
                    IDs = {
                        Normal = 40904,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Hateful Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 40925,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Hateful Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 40937,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Heroes' Redemption Breastplate",
                    IDs = {
                        Normal = 39638,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Heroes' Redemption Handguards",
                    IDs = {
                        Normal = 39639,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Heroes' Redemption Legguards",
                    IDs = {
                        Normal = 39641,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Heroes' Redemption Chestpiece",
                    IDs = {
                        Normal = 39633,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Heroes' Redemption Gauntlets",
                    IDs = {
                        Normal = 39634,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Heroes' Redemption Legplates",
                    IDs = {
                        Normal = 39636,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Hateful Gladiator's Scaled Chestpiece",
                    IDs = {
                        Normal = 40782,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Hateful Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 40802,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Hateful Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 40842,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Heroes' Crypstalker Handguards",
                    IDs = {
                        Normal = 39582,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Crypstalker Legguards",
                    IDs = {
                        Normal = 39580,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Crypstalker Tunic",
                    IDs = {
                        Normal = 39579,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Hateful Gladiator's Chain Armor",
                    IDs = {
                        Normal = 41085,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 41141,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 41203,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Heroes' Bonescythe Breastplate",
                    IDs = {
                        Normal = 39558,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Bonescythe Gauntlets",
                    IDs = {
                        Normal = 39560,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Bonescythe Legplates",
                    IDs = {
                        Normal = 39564,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Hateful Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 41765,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 41653,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Leather Tunic",
                    IDs = {
                        Normal = 41648,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Heroes' Gloves of Faith",
                    IDs = {
                        Normal = 39519,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Heroes' Leggings of Faith",
                    IDs = {
                        Normal = 39517,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Heroes' Robe of Faith",
                    IDs = {
                        Normal = 39515,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Hateful Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 41872,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Hateful Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 41862,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Hateful Gladiator's Mooncloth Robe",
                    IDs = {
                        Normal = 41857,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Heroes' Handwraps of Faith",
                    IDs = {
                        Normal = 39530,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Heroes' Pants of Faith",
                    IDs = {
                        Normal = 39528,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Heroes' Raiments of Faith",
                    IDs = {
                        Normal = 39523,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Hateful Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 41938,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Hateful Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 41925,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Hateful Gladiator's Satin Robe",
                    IDs = {
                        Normal = 41919,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Heroes' Scourgeborne Battleplate",
                    IDs = {
                        Normal = 39617,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Heroes' Scourgeborne Gauntlets",
                    IDs = {
                        Normal = 39618,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Heroes' Scourgeborne Legplates",
                    IDs = {
                        Normal = 39620,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hateful Gladiator's Dreadplate Chestpiece",
                    IDs = {
                        Normal = 40781,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hateful Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 40803,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hateful Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 40841,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Heroes' Scourgeborne Chestguard",
                    IDs = {
                        Normal = 39623,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Heroes' Scourgeborne Handguards",
                    IDs = {
                        Normal = 39624,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Heroes' Scourgeborne Legguards",
                    IDs = {
                        Normal = 39626,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Heroes' Earthshatter Gloves",
                    IDs = {
                        Normal = 39593,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Heroes' Earthshatter Hauberk",
                    IDs = {
                        Normal = 39592,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Heroes' Earthshatter Kilt",
                    IDs = {
                        Normal = 39595,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Hateful Gladiator's Mail Armor",
                    IDs = {
                        Normal = 40989,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Hateful Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 41005,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Hateful Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 41031,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Heroes' Earthshatter Chestguard",
                    IDs = {
                        Normal = 39597,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Heroes' Earthshatter Grips",
                    IDs = {
                        Normal = 39601,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Heroes' Earthshatter War-Kilt",
                    IDs = {
                        Normal = 39603,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Hateful Gladiator's Linked Armor",
                    IDs = {
                        Normal = 41079,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Hateful Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 41135,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Hateful Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 41162,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Heroes' Earthshatter Handguards",
                    IDs = {
                        Normal = 39591,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Heroes' Earthshatter Legguards",
                    IDs = {
                        Normal = 39589,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Heroes' Earthshatter Tunic",
                    IDs = {
                        Normal = 39588,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Hateful Gladiator's Ringmail Armor",
                    IDs = {
                        Normal = 40988,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Hateful Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 40999,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Hateful Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 41025,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Heroes' Frostfire Gloves",
                    IDs = {
                        Normal = 39495,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Frostfire Leggings",
                    IDs = {
                        Normal = 39493,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Frostfire Robe",
                    IDs = {
                        Normal = 39492,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Hateful Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 41969,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Silk Raiment",
                    IDs = {
                        Normal = 41950,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 41957,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Heroes' Plagueheart Gloves",
                    IDs = {
                        Normal = 39500,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Plagueheart Leggings",
                    IDs = {
                        Normal = 39498,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Heroes' Plagueheart Robe",
                    IDs = {
                        Normal = 39497,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Hateful Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 42015,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Felweave Raiment",
                    IDs = {
                        Normal = 42001,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Hateful Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 42003,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Heroes' Dreamwalker Gloves",
                    IDs = {
                        Normal = 39544,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Heroes' Dreamwalker Trousers",
                    IDs = {
                        Normal = 39546,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Heroes' Dreamwalker Vestments",
                    IDs = {
                        Normal = 39547,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Hateful Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 41291,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Hateful Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 41302,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Hateful Gladiator's Wyrmhide Robes",
                    IDs = {
                        Normal = 41314,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Heroes' Dreamwalker Handgrips",
                    IDs = {
                        Normal = 39557,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Heroes' Dreamwalker Legguards",
                    IDs = {
                        Normal = 39555,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Heroes' Dreamwalker Raiments",
                    IDs = {
                        Normal = 39554,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Hateful Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 41771,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Hateful Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 41665,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Hateful Gladiator's Dragonhide Robes",
                    IDs = {
                        Normal = 41659,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Heroes' Dreamwalker Handguards",
                    IDs = {
                        Normal = 39543,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Heroes' Dreamwalker Leggings",
                    IDs = {
                        Normal = 39539,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Heroes' Dreamwalker Robe",
                    IDs = {
                        Normal = 39538,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Hateful Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 41284,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Hateful Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 41296,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Hateful Gladiator's Kodohide Robes",
                    IDs = {
                        Normal = 41308,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Valorous Dreadnaught Battleplate",
                    IDs = {
                        Normal = 40525,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Dreadnaught Gauntlets",
                    IDs = {
                        Normal = 40527,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Dreadnaught Legplates",
                    IDs = {
                        Normal = 40529,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Plate Chestpiece",
                    IDs = {
                        Normal = 40786,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 40804,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 40844,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Dreadnaught Breastplate",
                    IDs = {
                        Normal = 40544,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Dreadnaught Handguards",
                    IDs = {
                        Normal = 40545,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Dreadnaught Legguards",
                    IDs = {
                        Normal = 40547,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Redemption Gloves",
                    IDs = {
                        Normal = 40570,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Redemption Greaves",
                    IDs = {
                        Normal = 40572,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Redemption Tunic",
                    IDs = {
                        Normal = 40569,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Ornamented Chestguard",
                    IDs = {
                        Normal = 40905,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 40926,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 40938,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Redemption Breastplate",
                    IDs = {
                        Normal = 40579,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Redemption Handguards",
                    IDs = {
                        Normal = 40580,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Redemption Legguards",
                    IDs = {
                        Normal = 40583,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Redemption Chestpiece",
                    IDs = {
                        Normal = 40574,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Valorous Redemption Gauntlets",
                    IDs = {
                        Normal = 40575,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Valorous Redemption Legplates",
                    IDs = {
                        Normal = 40577,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Deadly Gladiator's Scaled Chestpiece",
                    IDs = {
                        Normal = 40785,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Deadly Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 40805,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Deadly Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 40846,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Valorous Crypstalker Handguards",
                    IDs = {
                        Normal = 40504,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Crypstalker Legguards",
                    IDs = {
                        Normal = 40506,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Crypstalker Tunic",
                    IDs = {
                        Normal = 40503,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Chain Armor",
                    IDs = {
                        Normal = 41086,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 41142,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 41204,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Bonescythe Breastplate",
                    IDs = {
                        Normal = 40495,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Bonescythe Gauntlets",
                    IDs = {
                        Normal = 40496,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Bonescythe Legplates",
                    IDs = {
                        Normal = 40500,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 41766,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 41654,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Leather Tunic",
                    IDs = {
                        Normal = 41649,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Gloves of Faith",
                    IDs = {
                        Normal = 40445,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Leggings of Faith",
                    IDs = {
                        Normal = 40448,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Robe of Faith",
                    IDs = {
                        Normal = 40449,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 41873,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 41863,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Mooncloth Robe",
                    IDs = {
                        Normal = 41858,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Handwraps of Faith",
                    IDs = {
                        Normal = 40454,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Valorous Pants of Faith",
                    IDs = {
                        Normal = 40457,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Valorous Raiments of Faith",
                    IDs = {
                        Normal = 40458,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Deadly Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 41939,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Deadly Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 41926,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Deadly Gladiator's Satin Robe",
                    IDs = {
                        Normal = 41920,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Valorous Scourgeborne Battleplate",
                    IDs = {
                        Normal = 40550,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Scourgeborne Gauntlets",
                    IDs = {
                        Normal = 40552,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Scourgeborne Legplates",
                    IDs = {
                        Normal = 40556,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Dreadplate Chestpiece",
                    IDs = {
                        Normal = 40784,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 40806,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 40845,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Scourgeborne Chestguard",
                    IDs = {
                        Normal = 40559,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Valorous Scourgeborne Handguards",
                    IDs = {
                        Normal = 40563,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Valorous Scourgeborne Legguards",
                    IDs = {
                        Normal = 40567,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Valorous Earthshatter Gloves",
                    IDs = {
                        Normal = 40515,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Valorous Earthshatter Hauberk",
                    IDs = {
                        Normal = 40514,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Valorous Earthshatter Kilt",
                    IDs = {
                        Normal = 40517,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Deadly Gladiator's Mail Armor",
                    IDs = {
                        Normal = 40991,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Deadly Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 41006,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Deadly Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 41032,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Valorous Earthshatter Chestguard",
                    IDs = {
                        Normal = 40523,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Valorous Earthshatter Grips",
                    IDs = {
                        Normal = 40520,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Valorous Earthshatter War-Kilt",
                    IDs = {
                        Normal = 40522,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Deadly Gladiator's Linked Armor",
                    IDs = {
                        Normal = 41080,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Deadly Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 41136,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Deadly Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 41198,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Valorous Earthshatter Handguards",
                    IDs = {
                        Normal = 40509,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Earthshatter Legguards",
                    IDs = {
                        Normal = 40512,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Earthshatter Tunic",
                    IDs = {
                        Normal = 40508,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Ringmail Armor",
                    IDs = {
                        Normal = 40990,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 41000,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 41026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Frostfire Gloves",
                    IDs = {
                        Normal = 40415,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Frostfire Leggings",
                    IDs = {
                        Normal = 40417,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Frostfire Robe",
                    IDs = {
                        Normal = 40418,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 41970,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Silk Raiment",
                    IDs = {
                        Normal = 41951,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 41958,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Plagueheart Gloves",
                    IDs = {
                        Normal = 40420,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Plagueheart Leggings",
                    IDs = {
                        Normal = 40422,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Plagueheart Robe",
                    IDs = {
                        Normal = 40423,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 42016,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Felweave Raiment",
                    IDs = {
                        Normal = 41997,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 42004,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Dreamwalker Gloves",
                    IDs = {
                        Normal = 40466,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Valorous Dreamwalker Trousers",
                    IDs = {
                        Normal = 40468,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Valorous Dreamwalker Vestments",
                    IDs = {
                        Normal = 40469,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Deadly Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 41292,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Deadly Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 41303,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Deadly Gladiator's Wyrmhide Robes",
                    IDs = {
                        Normal = 41315,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Valorous Dreamwalker Handgrips",
                    IDs = {
                        Normal = 40472,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Valorous Dreamwalker Legguards",
                    IDs = {
                        Normal = 40493,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Valorous Dreamwalker Raiments",
                    IDs = {
                        Normal = 40471,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Deadly Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 41772,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Deadly Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 41666,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Deadly Gladiator's Dragonhide Robes",
                    IDs = {
                        Normal = 41660,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Valorous Dreamwalker Handguards",
                    IDs = {
                        Normal = 40460,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Dreamwalker Leggings",
                    IDs = {
                        Normal = 40462,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Dreamwalker Robe",
                    IDs = {
                        Normal = 40463,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 41286,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 41297,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Kodohide Robes",
                    IDs = {
                        Normal = 41309,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

            },

        },

        -------------------------------------------------
        -- 2. Emalon the Storm Watcher
        -------------------------------------------------

        {
            Order = 2,
            Name = "Emalon the Storm Watcher",
            NPCID = 33993,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Valorous Siegebreaker Gauntlets",
                    IDs = {
                        Normal = 45430,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Siegebreaker Legplates",
                    IDs = {
                        Normal = 45432,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 40804,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 40844,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Siegebreaker Handguards",
                    IDs = {
                        Normal = 45426,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Siegebreaker Legguards",
                    IDs = {
                        Normal = 45427,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Aegis Gloves",
                    IDs = {
                        Normal = 45370,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Aegis Greaves",
                    IDs = {
                        Normal = 45371,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 40926,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 40938,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Aegis Handguards",
                    IDs = {
                        Normal = 45383,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Aegis Legguards",
                    IDs = {
                        Normal = 45384,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Valorous Aegis Gauntlets",
                    IDs = {
                        Normal = 45376,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Valorous Aegis Legplates",
                    IDs = {
                        Normal = 45379,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Deadly Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 40805,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Deadly Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 40846,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Valorous Scourgestalker Handguards",
                    IDs = {
                        Normal = 45360,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Scourgestalker Legguards",
                    IDs = {
                        Normal = 45362,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 41142,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 41204,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Terrorblade Gauntlets",
                    IDs = {
                        Normal = 45397,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Terrorblade Legplates",
                    IDs = {
                        Normal = 45399,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 41766,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 41654,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Gloves of Sanctification",
                    IDs = {
                        Normal = 45387,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Leggings of Sanctification",
                    IDs = {
                        Normal = 45388,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 41873,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Deadly Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 41863,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Valorous Handwraps of Sanctification",
                    IDs = {
                        Normal = 45392,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Valorous Pants of Sanctification",
                    IDs = {
                        Normal = 45394,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Deadly Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 41939,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Deadly Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 41926,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Valorous Darkruned Gauntlets",
                    IDs = {
                        Normal = 45341,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Darkruned Legplates",
                    IDs = {
                        Normal = 45343,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 40806,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Deadly Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 40845,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Valorous Darkruned Handguards",
                    IDs = {
                        Normal = 45337,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Valorous Darkruned Legguards",
                    IDs = {
                        Normal = 45338,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Valorous Worldbreaker Gloves",
                    IDs = {
                        Normal = 45406,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Valorous Worldbreaker Kilt",
                    IDs = {
                        Normal = 45409,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Deadly Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 41006,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Deadly Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 41032,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Valorous Worldbreaker Grips",
                    IDs = {
                        Normal = 45414,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Valorous Worldbreaker War-Kilt",
                    IDs = {
                        Normal = 45416,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Deadly Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 41136,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Deadly Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 41198,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Valorous Worldbreaker Handguards",
                    IDs = {
                        Normal = 45401,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Worldbreaker Legguards",
                    IDs = {
                        Normal = 45403,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 41000,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 41026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Kirin'dor Gauntlets",
                    IDs = {
                        Normal = 46131,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Kirin'dor Leggings",
                    IDs = {
                        Normal = 45367,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 41970,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 41958,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Deathbringer Gloves",
                    IDs = {
                        Normal = 45419,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Valorous Deathbringer Leggings",
                    IDs = {
                        Normal = 45420,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Deadly Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 42016,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 42004,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Valorous Nightsong Gloves",
                    IDs = {
                        Normal = 45351,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Valorous Nightsong Trousers",
                    IDs = {
                        Normal = 45353,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Deadly Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 41292,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Deadly Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 41303,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Valorous Nightsong Handgrips",
                    IDs = {
                        Normal = 45355,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Valorous Nightsong Legguards",
                    IDs = {
                        Normal = 45357,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Deadly Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 41772,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Deadly Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 41666,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Valorous Nightsong Handguards",
                    IDs = {
                        Normal = 45345,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Valorous Nightsong Leggings",
                    IDs = {
                        Normal = 45347,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 41286,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 41297,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Deadly Gladiator's Cord of Dominance",
                    IDs = {
                        Normal = 41897,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cord of Salvation",
                    IDs = {
                        Normal = 41880,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cuffs of Dominance",
                    IDs = {
                        Normal = 41908,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cuffs of Salvation",
                    IDs = {
                        Normal = 41892,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Treads of Dominance",
                    IDs = {
                        Normal = 41902,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Treads of Salvation",
                    IDs = {
                        Normal = 41884,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Armwraps of Dominance",
                    IDs = {
                        Normal = 41639,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Armwraps of Salvation",
                    IDs = {
                        Normal = 41624,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Armwraps of Triumph",
                    IDs = {
                        Normal = 41839,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Belt of Dominance",
                    IDs = {
                        Normal = 41629,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Belt of Salvation",
                    IDs = {
                        Normal = 41616,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Belt of Triumph",
                    IDs = {
                        Normal = 41831,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Boots of Dominance",
                    IDs = {
                        Normal = 41634,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Boots of Salvation",
                    IDs = {
                        Normal = 41620,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Boots of Triumph",
                    IDs = {
                        Normal = 41835,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Sabatons of Dominance",
                    IDs = {
                        Normal = 41074,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Sabatons of Salvation",
                    IDs = {
                        Normal = 41054,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Sabatons of Triumph",
                    IDs = {
                        Normal = 41229,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Waistguard of Dominance",
                    IDs = {
                        Normal = 41069,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Waistguard of Salvation",
                    IDs = {
                        Normal = 41048,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Waistguard of Triumph",
                    IDs = {
                        Normal = 41234,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Wristguards of Dominance",
                    IDs = {
                        Normal = 41064,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Wristguards of Salvation",
                    IDs = {
                        Normal = 41059,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Wristguards of Triumph",
                    IDs = {
                        Normal = 41224,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Bracers of Salvation",
                    IDs = {
                        Normal = 40982,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Bracers of Triumph",
                    IDs = {
                        Normal = 40888,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Girdle of Salvation",
                    IDs = {
                        Normal = 40974,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Girdle of Triumph",
                    IDs = {
                        Normal = 40879,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Greaves of Salvation",
                    IDs = {
                        Normal = 40975,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Greaves of Triumph",
                    IDs = {
                        Normal = 40880,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Band of Ascendancy",
                    IDs = {
                        Normal = 42114,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Band of Victory",
                    IDs = {
                        Normal = 42115,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cloak of Ascendancy",
                    IDs = {
                        Normal = 42064,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cloak of Deliverance",
                    IDs = {
                        Normal = 42066,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cloak of Dominance",
                    IDs = {
                        Normal = 42062,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cloak of Salvation",
                    IDs = {
                        Normal = 42065,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cloak of Subjugation",
                    IDs = {
                        Normal = 42063,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cloak of Triumph",
                    IDs = {
                        Normal = 42067,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Cloak of Victory",
                    IDs = {
                        Normal = 42068,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Pendant of Ascendancy",
                    IDs = {
                        Normal = 42030,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Pendant of Deliverance",
                    IDs = {
                        Normal = 42032,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Pendant of Dominance",
                    IDs = {
                        Normal = 42029,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Pendant of Salvation",
                    IDs = {
                        Normal = 42033,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Pendant of Subjugation",
                    IDs = {
                        Normal = 42031,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Pendant of Triumph",
                    IDs = {
                        Normal = 42027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Deadly Gladiator's Pendant of Victory",
                    IDs = {
                        Normal = 42028,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Conqueror's Siegebreaker Gauntlets",
                    IDs = {
                        Normal = 46148,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Conqueror's Siegebreaker Legplates",
                    IDs = {
                        Normal = 46150,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Furious Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 40807,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Furious Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 40847,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Conqueror's Siegebreaker Handguards",
                    IDs = {
                        Normal = 46164,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Conqueror's Siegebreaker Legguards",
                    IDs = {
                        Normal = 46169,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Conqueror's Aegis Gloves",
                    IDs = {
                        Normal = 46179,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Conqueror's Aegis Greaves",
                    IDs = {
                        Normal = 46181,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Furious Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 40927,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Furious Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 40939,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Conqueror's Aegis Handguards",
                    IDs = {
                        Normal = 46174,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Conqueror's Aegis Legguards",
                    IDs = {
                        Normal = 46176,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Conqueror's Aegis Gauntlets",
                    IDs = {
                        Normal = 46155,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Conqueror's Aegis Legplates",
                    IDs = {
                        Normal = 46153,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Furious Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 40808,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Furious Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 40849,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Conqueror's Scourgestalker Handguards",
                    IDs = {
                        Normal = 46142,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Conqueror's Scourgestalker Legguards",
                    IDs = {
                        Normal = 46144,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Furious Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 41143,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 41205,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Conqueror's Terrorblade Gauntlets",
                    IDs = {
                        Normal = 46124,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Conqueror's Terrorblade Legplates",
                    IDs = {
                        Normal = 46126,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Furious Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 41767,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 41655,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Conqueror's Gloves of Sanctification",
                    IDs = {
                        Normal = 46188,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Conqueror's Leggings of Sanctification",
                    IDs = {
                        Normal = 46195,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Furious Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 41874,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Furious Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 41864,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Conqueror's Handwraps of Sanctification",
                    IDs = {
                        Normal = 46163,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Conqueror's Pants of Sanctification",
                    IDs = {
                        Normal = 46170,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Furious Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 41940,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Furious Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 41927,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Conqueror's Darkruned Gauntlets",
                    IDs = {
                        Normal = 46113,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Conqueror's Darkruned Legplates",
                    IDs = {
                        Normal = 46116,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Furious Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 40809,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Furious Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 40848,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Conqueror's Darkruned Handguards",
                    IDs = {
                        Normal = 46119,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Conqueror's Darkruned Legguards",
                    IDs = {
                        Normal = 46121,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Conqueror's Worldbreaker Gloves",
                    IDs = {
                        Normal = 46207,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Conqueror's Worldbreaker Kilt",
                    IDs = {
                        Normal = 46210,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Furious Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 41007,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Furious Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 41033,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Conqueror's Worldbreaker Grips",
                    IDs = {
                        Normal = 46200,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Conqueror's Worldbreaker War-Kilt",
                    IDs = {
                        Normal = 46208,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Furious Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 41137,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Furious Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 41199,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Conqueror's Worldbreaker Handguards",
                    IDs = {
                        Normal = 46199,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Conqueror's Worldbreaker Legguards",
                    IDs = {
                        Normal = 46202,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 41001,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 41027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Conqueror's Kirin'dor Gauntlets",
                    IDs = {
                        Normal = 46132,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Conqueror's Kirin'dor Leggings",
                    IDs = {
                        Normal = 46133,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Furious Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 41971,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 41959,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Conqueror's Deathbringer Gloves",
                    IDs = {
                        Normal = 46135,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Conqueror's Deathbringer Leggings",
                    IDs = {
                        Normal = 46139,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Furious Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 42017,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 42005,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Conqueror's Nightsong Gloves",
                    IDs = {
                        Normal = 46189,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Conqueror's Nightsong Trousers",
                    IDs = {
                        Normal = 46192,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Furious Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 41293,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Furious Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 41304,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Conqueror's Nightsong Handgrips",
                    IDs = {
                        Normal = 46158,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Conqueror's Nightsong Legguards",
                    IDs = {
                        Normal = 46160,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Furious Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 41773,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Furious Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 41667,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Conqueror's Nightsong Handguards",
                    IDs = {
                        Normal = 46183,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Conqueror's Nightsong Leggings",
                    IDs = {
                        Normal = 46185,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 41287,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 41298,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Cord of Dominance",
                    IDs = {
                        Normal = 41898,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cord of Salvation",
                    IDs = {
                        Normal = 41881,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cuffs of Dominance",
                    IDs = {
                        Normal = 41909,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cuffs of Salvation",
                    IDs = {
                        Normal = 41893,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Slippers of Dominance",
                    IDs = {
                        Normal = 41903,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Slippers of Salvation",
                    IDs = {
                        Normal = 41885,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Armwraps of Dominance",
                    IDs = {
                        Normal = 41640,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Armwraps of Salvation",
                    IDs = {
                        Normal = 41625,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Armwraps of Triumph",
                    IDs = {
                        Normal = 41840,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Belt of Dominance",
                    IDs = {
                        Normal = 41630,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Belt of Salvation",
                    IDs = {
                        Normal = 41617,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Belt of Triumph",
                    IDs = {
                        Normal = 41832,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Boots of Dominance",
                    IDs = {
                        Normal = 41635,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Boots of Salvation",
                    IDs = {
                        Normal = 41621,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Boots of Triumph",
                    IDs = {
                        Normal = 41836,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Sabatons of Dominance",
                    IDs = {
                        Normal = 41075,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Sabatons of Salvation",
                    IDs = {
                        Normal = 41055,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Sabatons of Triumph",
                    IDs = {
                        Normal = 41230,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Waistguard of Dominance",
                    IDs = {
                        Normal = 41070,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Waistguard of Salvation",
                    IDs = {
                        Normal = 41051,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Waistguard of Triumph",
                    IDs = {
                        Normal = 41235,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Wristguards of Dominance",
                    IDs = {
                        Normal = 41065,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Wristguards of Salvation",
                    IDs = {
                        Normal = 41060,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Wristguards of Triumph",
                    IDs = {
                        Normal = 41225,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Bracers of Salvation",
                    IDs = {
                        Normal = 40983,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Bracers of Triumph",
                    IDs = {
                        Normal = 40889,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Girdle of Salvation",
                    IDs = {
                        Normal = 40976,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Girdle of Triumph",
                    IDs = {
                        Normal = 40881,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Greaves of Salvation",
                    IDs = {
                        Normal = 40977,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Greaves of Triumph",
                    IDs = {
                        Normal = 40882,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Band of Dominance",
                    IDs = {
                        Normal = 42116,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Band of Triumph",
                    IDs = {
                        Normal = 42117,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Ascendancy",
                    IDs = {
                        Normal = 42071,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Deliverance",
                    IDs = {
                        Normal = 42073,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Dominance",
                    IDs = {
                        Normal = 42069,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Salvation",
                    IDs = {
                        Normal = 42072,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Subjugation",
                    IDs = {
                        Normal = 42070,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Triumph",
                    IDs = {
                        Normal = 42074,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Victory",
                    IDs = {
                        Normal = 42075,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Ascendancy",
                    IDs = {
                        Normal = 42037,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Deliverance",
                    IDs = {
                        Normal = 42039,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Dominance",
                    IDs = {
                        Normal = 42036,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Salvation",
                    IDs = {
                        Normal = 42040,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Subjugation",
                    IDs = {
                        Normal = 42038,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Sundering",
                    IDs = {
                        Normal = 46373,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Triumph",
                    IDs = {
                        Normal = 42034,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Victory",
                    IDs = {
                        Normal = 42035,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

            },

        },

        -------------------------------------------------
        -- 3. Koralon the Flame Watcher
        -------------------------------------------------

        {
            Order = 3,
            Name = "Koralon the Flame Watcher",
            NPCID = 35013,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Hellscream's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48387,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Hellscream's Legplates of Conquest",
                    IDs = {
                        Normal = 48389,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Wrynn's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48375,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Wrynn's Legplates of Conquest",
                    IDs = {
                        Normal = 48373,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 40807,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Furious Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 40847,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hellscream's Handguards of Conquest",
                    IDs = {
                        Normal = 48457,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Hellscream's Legguards of Conquest",
                    IDs = {
                        Normal = 48459,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Wrynn's Handguards of Conquest",
                    IDs = {
                        Normal = 48449,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Wrynn's Legguards of Conquest",
                    IDs = {
                        Normal = 48445,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Liadrin's Gloves of Conquest",
                    IDs = {
                        Normal = 48598,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Liadrin's Greaves of Conquest",
                    IDs = {
                        Normal = 48596,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Turalyon's Gloves of Conquest",
                    IDs = {
                        Normal = 48574,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Turalyon's Greaves of Conquest",
                    IDs = {
                        Normal = 48568,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 40927,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Furious Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 40939,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Liadrin's Handguards of Conquest",
                    IDs = {
                        Normal = 48653,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Liadrin's Legguards of Conquest",
                    IDs = {
                        Normal = 48655,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Turalyon's Handguards of Conquest",
                    IDs = {
                        Normal = 48633,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Turalyon's Legguards of Conquest",
                    IDs = {
                        Normal = 48635,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Liadrin's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48630,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                    Faction = "Horde",
                },

                {
                    Name = "Liadrin's Legplates of Conquest",
                    IDs = {
                        Normal = 48628,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                    Faction = "Horde",
                },

                {
                    Name = "Turalyon's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48603,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                    Faction = "Alliance",
                },

                {
                    Name = "Turalyon's Legplates of Conquest",
                    IDs = {
                        Normal = 48605,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 40808,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Furious Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 40849,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Windrunner's Handguards of Conquest",
                    IDs = {
                        Normal = 48254,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Windrunner's Handguards of Conquest",
                    IDs = {
                        Normal = 48276,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Windrunner's Legguards of Conquest",
                    IDs = {
                        Normal = 48252,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Windrunner's Legguards of Conquest",
                    IDs = {
                        Normal = 48278,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Furious Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 41143,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 41205,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Garona's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48244,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Garona's Legplates of Conquest",
                    IDs = {
                        Normal = 48246,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "VanCleef's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48222,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "VanCleef's Legplates of Conquest",
                    IDs = {
                        Normal = 48220,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 41767,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 41655,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Velen's Gloves of Conquest",
                    IDs = {
                        Normal = 47982,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Velen's Leggings of Conquest",
                    IDs = {
                        Normal = 47980,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Zabra's Gloves of Conquest",
                    IDs = {
                        Normal = 48067,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Zabra's Leggings of Conquest",
                    IDs = {
                        Normal = 48069,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Furious Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 41874,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Furious Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 41864,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Velen's Handwraps of Conquest",
                    IDs = {
                        Normal = 48072,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                    Faction = "Alliance",
                },

                {
                    Name = "Velen's Pants of Conquest",
                    IDs = {
                        Normal = 48074,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                    Faction = "Alliance",
                },

                {
                    Name = "Zabra's Handwraps of Conquest",
                    IDs = {
                        Normal = 48097,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                    Faction = "Horde",
                },

                {
                    Name = "Zabra's Pants of Conquest",
                    IDs = {
                        Normal = 48099,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                    Faction = "Horde",
                },

                {
                    Name = "Furious Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 41940,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Furious Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 41927,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Koltira's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48502,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Koltira's Legplates of Conquest",
                    IDs = {
                        Normal = 48504,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Thassarian's Gauntlets of Conquest",
                    IDs = {
                        Normal = 48480,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Thassarian's Legplates of Conquest",
                    IDs = {
                        Normal = 48476,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 40809,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Furious Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 40848,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Koltira's Handguards of Conquest",
                    IDs = {
                        Normal = 48559,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                    Faction = "Horde",
                },

                {
                    Name = "Koltira's Legguards of Conquest",
                    IDs = {
                        Normal = 48561,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                    Faction = "Horde",
                },

                {
                    Name = "Thassarian's Handguards of Conquest",
                    IDs = {
                        Normal = 48537,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                    Faction = "Alliance",
                },

                {
                    Name = "Thassarian's Legguards of Conquest",
                    IDs = {
                        Normal = 48533,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's Gloves of Conquest",
                    IDs = {
                        Normal = 48312,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's Kilt of Conquest",
                    IDs = {
                        Normal = 48314,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                    Faction = "Alliance",
                },

                {
                    Name = "Thrall's Gloves of Conquest",
                    IDs = {
                        Normal = 48337,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                    Faction = "Horde",
                },

                {
                    Name = "Thrall's Kilt of Conquest",
                    IDs = {
                        Normal = 48339,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                    Faction = "Horde",
                },

                {
                    Name = "Furious Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 41007,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Furious Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 41033,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Nobundo's Grips of Conquest",
                    IDs = {
                        Normal = 48342,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's War-Kilt of Conquest",
                    IDs = {
                        Normal = 48344,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                    Faction = "Alliance",
                },

                {
                    Name = "Thrall's Grips of Conquest",
                    IDs = {
                        Normal = 48367,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                    Faction = "Horde",
                },

                {
                    Name = "Thrall's War-Kilt of Conquest",
                    IDs = {
                        Normal = 48369,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                    Faction = "Horde",
                },

                {
                    Name = "Furious Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 41137,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Furious Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 41199,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Nobundo's Handguards of Conquest",
                    IDs = {
                        Normal = 48284,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's Legguards of Conquest",
                    IDs = {
                        Normal = 48282,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Thrall's Handguards of Conquest",
                    IDs = {
                        Normal = 48296,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Thrall's Legguards of Conquest",
                    IDs = {
                        Normal = 48298,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Furious Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 41001,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 41027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Khadgar's Gauntlets of Conquest",
                    IDs = {
                        Normal = 47752,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Khadgar's Leggings of Conquest",
                    IDs = {
                        Normal = 47750,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Sunstrider's Gauntlets of Conquest",
                    IDs = {
                        Normal = 47773,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Sunstrider's Leggings of Conquest",
                    IDs = {
                        Normal = 47775,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Furious Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 41971,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 41959,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Gul'dan's Gloves of Conquest",
                    IDs = {
                        Normal = 47802,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Gul'dan's Leggings of Conquest",
                    IDs = {
                        Normal = 47800,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Kel'Thuzad's Gloves of Conquest",
                    IDs = {
                        Normal = 47783,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Kel'Thuzad's Leggings of Conquest",
                    IDs = {
                        Normal = 47785,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 42017,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 42005,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Runetotem's Gloves of Conquest",
                    IDs = {
                        Normal = 48183,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                    Faction = "Horde",
                },

                {
                    Name = "Runetotem's Trousers of Conquest",
                    IDs = {
                        Normal = 48185,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                    Faction = "Horde",
                },

                {
                    Name = "Stormrage's Gloves of Conquest",
                    IDs = {
                        Normal = 48162,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                    Faction = "Alliance",
                },

                {
                    Name = "Stormrage's Trousers of Conquest",
                    IDs = {
                        Normal = 48160,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 41293,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Furious Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 41304,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Runetotem's Handgrips of Conquest",
                    IDs = {
                        Normal = 48192,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                    Faction = "Horde",
                },

                {
                    Name = "Runetotem's Legguards of Conquest",
                    IDs = {
                        Normal = 48190,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                    Faction = "Horde",
                },

                {
                    Name = "Stormrage's Handgrips of Conquest",
                    IDs = {
                        Normal = 48213,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                    Faction = "Alliance",
                },

                {
                    Name = "Stormrage's Legguards of Conquest",
                    IDs = {
                        Normal = 48215,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 41773,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Furious Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 41667,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Runetotem's Handguards of Conquest",
                    IDs = {
                        Normal = 48153,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Runetotem's Leggings of Conquest",
                    IDs = {
                        Normal = 48155,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Stormrage's Handguards of Conquest",
                    IDs = {
                        Normal = 48132,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Stormrage's Leggings of Conquest",
                    IDs = {
                        Normal = 48130,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Furious Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 41287,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 41298,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Furious Gladiator's Cord of Dominance",
                    IDs = {
                        Normal = 41898,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cord of Salvation",
                    IDs = {
                        Normal = 41881,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cuffs of Dominance",
                    IDs = {
                        Normal = 41909,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cuffs of Salvation",
                    IDs = {
                        Normal = 41893,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Slippers of Dominance",
                    IDs = {
                        Normal = 41903,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Slippers of Salvation",
                    IDs = {
                        Normal = 41885,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Armwraps of Dominance",
                    IDs = {
                        Normal = 41640,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Armwraps of Salvation",
                    IDs = {
                        Normal = 41625,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Armwraps of Triumph",
                    IDs = {
                        Normal = 41840,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Belt of Dominance",
                    IDs = {
                        Normal = 41630,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Belt of Salvation",
                    IDs = {
                        Normal = 41617,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Belt of Triumph",
                    IDs = {
                        Normal = 41832,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Boots of Dominance",
                    IDs = {
                        Normal = 41635,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Boots of Salvation",
                    IDs = {
                        Normal = 41621,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Boots of Triumph",
                    IDs = {
                        Normal = 41836,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Sabatons of Dominance",
                    IDs = {
                        Normal = 41075,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Sabatons of Salvation",
                    IDs = {
                        Normal = 41055,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Sabatons of Triumph",
                    IDs = {
                        Normal = 41230,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Waistguard of Dominance",
                    IDs = {
                        Normal = 41070,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Waistguard of Salvation",
                    IDs = {
                        Normal = 41051,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Waistguard of Triumph",
                    IDs = {
                        Normal = 41235,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Wristguards of Dominance",
                    IDs = {
                        Normal = 41065,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Wristguards of Salvation",
                    IDs = {
                        Normal = 41060,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Wristguards of Triumph",
                    IDs = {
                        Normal = 41225,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Bracers of Salvation",
                    IDs = {
                        Normal = 40983,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Bracers of Triumph",
                    IDs = {
                        Normal = 40889,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Girdle of Salvation",
                    IDs = {
                        Normal = 40976,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Girdle of Triumph",
                    IDs = {
                        Normal = 40881,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Greaves of Salvation",
                    IDs = {
                        Normal = 40977,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Greaves of Triumph",
                    IDs = {
                        Normal = 40882,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Band of Dominance",
                    IDs = {
                        Normal = 42116,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Band of Triumph",
                    IDs = {
                        Normal = 42117,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Ascendancy",
                    IDs = {
                        Normal = 42071,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Deliverance",
                    IDs = {
                        Normal = 42073,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Dominance",
                    IDs = {
                        Normal = 42069,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Salvation",
                    IDs = {
                        Normal = 42072,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Subjugation",
                    IDs = {
                        Normal = 42070,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Triumph",
                    IDs = {
                        Normal = 42074,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Cloak of Victory",
                    IDs = {
                        Normal = 42075,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Ascendancy",
                    IDs = {
                        Normal = 42037,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Deliverance",
                    IDs = {
                        Normal = 42039,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Dominance",
                    IDs = {
                        Normal = 42036,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Salvation",
                    IDs = {
                        Normal = 42040,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Subjugation",
                    IDs = {
                        Normal = 42038,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Sundering",
                    IDs = {
                        Normal = 46373,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Triumph",
                    IDs = {
                        Normal = 42034,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Furious Gladiator's Pendant of Victory",
                    IDs = {
                        Normal = 42035,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Hellscream's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48392,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Hellscream's Legplates of Triumph",
                    IDs = {
                        Normal = 48394,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Wrynn's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48377,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Wrynn's Legplates of Triumph",
                    IDs = {
                        Normal = 48379,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 40810,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Relentless Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 40850,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Hellscream's Handguards of Triumph",
                    IDs = {
                        Normal = 48462,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Hellscream's Legguards of Triumph",
                    IDs = {
                        Normal = 48464,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Wrynn's Handguards of Triumph",
                    IDs = {
                        Normal = 48452,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Wrynn's Legguards of Triumph",
                    IDs = {
                        Normal = 48446,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Liadrin's Gloves of Triumph",
                    IDs = {
                        Normal = 48593,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Liadrin's Greaves of Triumph",
                    IDs = {
                        Normal = 48591,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Turalyon's Gloves of Triumph",
                    IDs = {
                        Normal = 48576,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Turalyon's Greaves of Triumph",
                    IDs = {
                        Normal = 48578,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 40928,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Relentless Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 40940,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Liadrin's Handguards of Triumph",
                    IDs = {
                        Normal = 48658,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Liadrin's Legguards of Triumph",
                    IDs = {
                        Normal = 48660,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Horde",
                },

                {
                    Name = "Turalyon's Handguards of Triumph",
                    IDs = {
                        Normal = 48640,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Turalyon's Legguards of Triumph",
                    IDs = {
                        Normal = 48638,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                    Faction = "Alliance",
                },

                {
                    Name = "Liadrin's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48625,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                    Faction = "Horde",
                },

                {
                    Name = "Liadrin's Legplates of Triumph",
                    IDs = {
                        Normal = 48623,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                    Faction = "Horde",
                },

                {
                    Name = "Turalyon's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48608,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                    Faction = "Alliance",
                },

                {
                    Name = "Turalyon's Legplates of Triumph",
                    IDs = {
                        Normal = 48610,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 40812,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Relentless Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 40852,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Windrunner's Handguards of Triumph",
                    IDs = {
                        Normal = 48256,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Windrunner's Handguards of Triumph",
                    IDs = {
                        Normal = 48273,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Windrunner's Legguards of Triumph",
                    IDs = {
                        Normal = 48258,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Windrunner's Legguards of Triumph",
                    IDs = {
                        Normal = 48271,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Relentless Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 41144,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 41206,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Garona's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48241,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Garona's Legplates of Triumph",
                    IDs = {
                        Normal = 48239,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "VanCleef's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48224,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "VanCleef's Legplates of Triumph",
                    IDs = {
                        Normal = 48226,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 41768,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 41656,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Velen's Gloves of Triumph",
                    IDs = {
                        Normal = 47983,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Velen's Leggings of Triumph",
                    IDs = {
                        Normal = 47985,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Alliance",
                },

                {
                    Name = "Zabra's Gloves of Triumph",
                    IDs = {
                        Normal = 48066,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Zabra's Leggings of Triumph",
                    IDs = {
                        Normal = 48064,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                    Faction = "Horde",
                },

                {
                    Name = "Relentless Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 41875,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Relentless Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 41865,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Velen's Handwraps of Triumph",
                    IDs = {
                        Normal = 48077,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                    Faction = "Alliance",
                },

                {
                    Name = "Velen's Pants of Triumph",
                    IDs = {
                        Normal = 48079,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                    Faction = "Alliance",
                },

                {
                    Name = "Zabra's Handwraps of Triumph",
                    IDs = {
                        Normal = 48096,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                    Faction = "Horde",
                },

                {
                    Name = "Zabra's Pants of Triumph",
                    IDs = {
                        Normal = 48094,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                    Faction = "Horde",
                },

                {
                    Name = "Relentless Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 41941,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Relentless Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 41928,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Koltira's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48499,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Koltira's Legplates of Triumph",
                    IDs = {
                        Normal = 48497,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Horde",
                },

                {
                    Name = "Thassarian's Gauntlets of Triumph",
                    IDs = {
                        Normal = 48482,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Thassarian's Legplates of Triumph",
                    IDs = {
                        Normal = 48484,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 40811,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Relentless Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 40851,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Koltira's Handguards of Triumph",
                    IDs = {
                        Normal = 48556,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                    Faction = "Horde",
                },

                {
                    Name = "Koltira's Legguards of Triumph",
                    IDs = {
                        Normal = 48554,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                    Faction = "Horde",
                },

                {
                    Name = "Thassarian's Handguards of Triumph",
                    IDs = {
                        Normal = 48539,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                    Faction = "Alliance",
                },

                {
                    Name = "Thassarian's Legguards of Triumph",
                    IDs = {
                        Normal = 48541,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's Gloves of Triumph",
                    IDs = {
                        Normal = 48317,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's Kilt of Triumph",
                    IDs = {
                        Normal = 48319,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                    Faction = "Alliance",
                },

                {
                    Name = "Thrall's Gloves of Triumph",
                    IDs = {
                        Normal = 48334,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                    Faction = "Horde",
                },

                {
                    Name = "Thrall's Kilt of Triumph",
                    IDs = {
                        Normal = 48332,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                    Faction = "Horde",
                },

                {
                    Name = "Relentless Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 41008,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Relentless Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 41034,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Nobundo's Grips of Triumph",
                    IDs = {
                        Normal = 48347,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's War-Kilt of Triumph",
                    IDs = {
                        Normal = 48349,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                    Faction = "Alliance",
                },

                {
                    Name = "Thrall's Grips of Triumph",
                    IDs = {
                        Normal = 48364,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                    Faction = "Horde",
                },

                {
                    Name = "Thrall's War-Kilt of Triumph",
                    IDs = {
                        Normal = 48362,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                    Faction = "Horde",
                },

                {
                    Name = "Relentless Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 41138,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Relentless Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 41200,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Nobundo's Handguards of Triumph",
                    IDs = {
                        Normal = 48286,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Nobundo's Legguards of Triumph",
                    IDs = {
                        Normal = 48288,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Thrall's Handguards of Triumph",
                    IDs = {
                        Normal = 48301,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Thrall's Legguards of Triumph",
                    IDs = {
                        Normal = 48303,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Relentless Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 41002,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 41028,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Khadgar's Gauntlets of Triumph",
                    IDs = {
                        Normal = 47753,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Khadgar's Leggings of Triumph",
                    IDs = {
                        Normal = 47755,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Sunstrider's Gauntlets of Triumph",
                    IDs = {
                        Normal = 47772,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Sunstrider's Leggings of Triumph",
                    IDs = {
                        Normal = 47770,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Relentless Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 41972,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 41960,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Gul'dan's Gloves of Triumph",
                    IDs = {
                        Normal = 47803,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Gul'dan's Leggings of Triumph",
                    IDs = {
                        Normal = 47805,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Horde",
                },

                {
                    Name = "Kel'Thuzad's Gloves of Triumph",
                    IDs = {
                        Normal = 47782,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Kel'Thuzad's Leggings of Triumph",
                    IDs = {
                        Normal = 47780,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 42018,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 42006,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Runetotem's Gloves of Triumph",
                    IDs = {
                        Normal = 48182,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                    Faction = "Horde",
                },

                {
                    Name = "Runetotem's Trousers of Triumph",
                    IDs = {
                        Normal = 48180,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                    Faction = "Horde",
                },

                {
                    Name = "Stormrage's Gloves of Triumph",
                    IDs = {
                        Normal = 48163,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                    Faction = "Alliance",
                },

                {
                    Name = "Stormrage's Trousers of Triumph",
                    IDs = {
                        Normal = 48165,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 41294,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Relentless Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 41305,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Runetotem's Handgrips of Triumph",
                    IDs = {
                        Normal = 48193,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                    Faction = "Horde",
                },

                {
                    Name = "Runetotem's Legguards of Triumph",
                    IDs = {
                        Normal = 48195,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                    Faction = "Horde",
                },

                {
                    Name = "Stormrage's Handgrips of Triumph",
                    IDs = {
                        Normal = 48212,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                    Faction = "Alliance",
                },

                {
                    Name = "Stormrage's Legguards of Triumph",
                    IDs = {
                        Normal = 48210,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 41774,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Relentless Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 41668,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Runetotem's Handguards of Triumph",
                    IDs = {
                        Normal = 48152,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Runetotem's Leggings of Triumph",
                    IDs = {
                        Normal = 48150,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Horde",
                },

                {
                    Name = "Stormrage's Handguards of Triumph",
                    IDs = {
                        Normal = 48133,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Stormrage's Leggings of Triumph",
                    IDs = {
                        Normal = 48135,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                    Faction = "Alliance",
                },

                {
                    Name = "Relentless Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 41288,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 41299,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Cord of Alacrity",
                    IDs = {
                        Normal = 49179,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cord of Dominance",
                    IDs = {
                        Normal = 41899,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cord of Salvation",
                    IDs = {
                        Normal = 41882,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cuffs of Alacrity",
                    IDs = {
                        Normal = 49181,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cuffs of Dominance",
                    IDs = {
                        Normal = 41910,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cuffs of Salvation",
                    IDs = {
                        Normal = 41894,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Treads of Alacrity",
                    IDs = {
                        Normal = 49183,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Treads of Dominance",
                    IDs = {
                        Normal = 41904,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Treads of Salvation",
                    IDs = {
                        Normal = 41886,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Armwraps of Dominance",
                    IDs = {
                        Normal = 41641,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Armwraps of Salvation",
                    IDs = {
                        Normal = 41626,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Armwraps of Triumph",
                    IDs = {
                        Normal = 41841,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Belt of Dominance",
                    IDs = {
                        Normal = 41631,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Belt of Salvation",
                    IDs = {
                        Normal = 41618,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Belt of Triumph",
                    IDs = {
                        Normal = 41833,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Boots of Dominance",
                    IDs = {
                        Normal = 41636,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Boots of Salvation",
                    IDs = {
                        Normal = 41622,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Boots of Triumph",
                    IDs = {
                        Normal = 41837,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Sabatons of Dominance",
                    IDs = {
                        Normal = 41076,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Sabatons of Salvation",
                    IDs = {
                        Normal = 41056,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Sabatons of Triumph",
                    IDs = {
                        Normal = 41231,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Waistguard of Dominance",
                    IDs = {
                        Normal = 41071,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Waistguard of Salvation",
                    IDs = {
                        Normal = 41052,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Waistguard of Triumph",
                    IDs = {
                        Normal = 41236,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Wristguards of Dominance",
                    IDs = {
                        Normal = 41066,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Wristguards of Salvation",
                    IDs = {
                        Normal = 41061,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Wristguards of Triumph",
                    IDs = {
                        Normal = 41226,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Bracers of Salvation",
                    IDs = {
                        Normal = 40984,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Bracers of Triumph",
                    IDs = {
                        Normal = 40890,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Girdle of Salvation",
                    IDs = {
                        Normal = 40978,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Girdle of Triumph",
                    IDs = {
                        Normal = 40883,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Greaves of Salvation",
                    IDs = {
                        Normal = 40979,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Greaves of Triumph",
                    IDs = {
                        Normal = 40884,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Band of Ascendancy",
                    IDs = {
                        Normal = 42118,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Band of Victory",
                    IDs = {
                        Normal = 42119,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Ascendancy",
                    IDs = {
                        Normal = 42078,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Deliverance",
                    IDs = {
                        Normal = 42080,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Dominance",
                    IDs = {
                        Normal = 42076,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Salvation",
                    IDs = {
                        Normal = 42079,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Subjugation",
                    IDs = {
                        Normal = 42077,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Triumph",
                    IDs = {
                        Normal = 42081,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Victory",
                    IDs = {
                        Normal = 42082,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Ascendancy",
                    IDs = {
                        Normal = 42044,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Deliverance",
                    IDs = {
                        Normal = 42046,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Dominance",
                    IDs = {
                        Normal = 42043,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Salvation",
                    IDs = {
                        Normal = 42047,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Subjugation",
                    IDs = {
                        Normal = 42045,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Sundering",
                    IDs = {
                        Normal = 46374,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Triumph",
                    IDs = {
                        Normal = 42041,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Victory",
                    IDs = {
                        Normal = 42042,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

            },

        },

        -------------------------------------------------
        -- 4. Toravon the Ice Watcher
        -------------------------------------------------

        {
            Order = 4,
            Name = "Toravon the Ice Watcher",
            NPCID = 38433,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Ymirjar Lord's Gauntlets",
                    IDs = {
                        Normal = 50079,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Ymirjar Lord's Legplates",
                    IDs = {
                        Normal = 50081,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Relentless Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 40810,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Relentless Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 40850,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Ymirjar Lord's Handguards",
                    IDs = {
                        Normal = 50849,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Ymirjar Lord's Legguards",
                    IDs = {
                        Normal = 50847,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Lightsworn Gloves",
                    IDs = {
                        Normal = 50868,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Lightsworn Greaves",
                    IDs = {
                        Normal = 50866,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Relentless Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 40928,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Relentless Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 40940,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Lightsworn Handguards",
                    IDs = {
                        Normal = 50863,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Lightsworn Legguards",
                    IDs = {
                        Normal = 50861,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Lightsworn Gauntlets",
                    IDs = {
                        Normal = 50327,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Lightsworn Legplates",
                    IDs = {
                        Normal = 50325,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Relentless Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 40812,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Relentless Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 40852,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Ahn'Kahar Blood Hunter's Handguards",
                    IDs = {
                        Normal = 50114,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Ahn'Kahar Blood Hunter's Legguards",
                    IDs = {
                        Normal = 50116,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Relentless Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 41144,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 41206,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Shadowblade Gauntlets",
                    IDs = {
                        Normal = 50088,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Shadowblade Legplates",
                    IDs = {
                        Normal = 50090,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Relentless Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 41768,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 41656,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Crimson Acolyte Gloves",
                    IDs = {
                        Normal = 50766,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Crimson Acolyte Leggings",
                    IDs = {
                        Normal = 50769,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Relentless Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 41875,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Relentless Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 41865,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Crimson Acolyte Handwraps",
                    IDs = {
                        Normal = 50391,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Crimson Acolyte Pants",
                    IDs = {
                        Normal = 50393,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Relentless Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 41941,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Relentless Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 41928,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Scourgelord Gauntlets",
                    IDs = {
                        Normal = 50095,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Scourgelord Legplates",
                    IDs = {
                        Normal = 50097,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Relentless Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 40811,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Relentless Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 40851,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Scourgelord Handguards",
                    IDs = {
                        Normal = 50856,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Scourgelord Legguards",
                    IDs = {
                        Normal = 50854,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Frost Witch's Gloves",
                    IDs = {
                        Normal = 50842,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Frost Witch's Kilt",
                    IDs = {
                        Normal = 50844,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Relentless Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 41008,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Relentless Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 41034,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Frost Witch's Grips",
                    IDs = {
                        Normal = 50831,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Frost Witch's War-Kilt",
                    IDs = {
                        Normal = 50833,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Relentless Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 41138,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Relentless Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 41200,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Frost Witch's Handguards",
                    IDs = {
                        Normal = 50836,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Frost Witch's Legguards",
                    IDs = {
                        Normal = 50838,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 41002,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 41028,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Bloodmage Gloves",
                    IDs = {
                        Normal = 50275,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Bloodmage Leggings",
                    IDs = {
                        Normal = 50277,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Relentless Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 41972,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 41960,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Dark Coven Gloves",
                    IDs = {
                        Normal = 50240,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Dark Coven Leggings",
                    IDs = {
                        Normal = 50242,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Relentless Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 42018,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 42006,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Lasherweave's Gloves",
                    IDs = {
                        Normal = 50822,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Lasherweave's Trousers",
                    IDs = {
                        Normal = 50820,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Relentless Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 41294,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Relentless Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 41305,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Lasherweave's Handgrips",
                    IDs = {
                        Normal = 50827,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Lasherweave's Legguards",
                    IDs = {
                        Normal = 50825,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Relentless Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 41774,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Relentless Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 41668,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Lasherweave's Gauntlets",
                    IDs = {
                        Normal = 50107,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Lasherweave's Legplates",
                    IDs = {
                        Normal = 50109,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 41288,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 41299,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Relentless Gladiator's Cord of Alacrity",
                    IDs = {
                        Normal = 49179,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cord of Dominance",
                    IDs = {
                        Normal = 41899,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cord of Salvation",
                    IDs = {
                        Normal = 41882,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cuffs of Alacrity",
                    IDs = {
                        Normal = 49181,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cuffs of Dominance",
                    IDs = {
                        Normal = 41910,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cuffs of Salvation",
                    IDs = {
                        Normal = 41894,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Treads of Alacrity",
                    IDs = {
                        Normal = 49183,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Treads of Dominance",
                    IDs = {
                        Normal = 41904,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Treads of Salvation",
                    IDs = {
                        Normal = 41886,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Armwraps of Dominance",
                    IDs = {
                        Normal = 41641,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Armwraps of Salvation",
                    IDs = {
                        Normal = 41626,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Armwraps of Triumph",
                    IDs = {
                        Normal = 41841,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Belt of Dominance",
                    IDs = {
                        Normal = 41631,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Belt of Salvation",
                    IDs = {
                        Normal = 41618,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Belt of Triumph",
                    IDs = {
                        Normal = 41833,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Boots of Dominance",
                    IDs = {
                        Normal = 41636,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Boots of Salvation",
                    IDs = {
                        Normal = 41622,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Boots of Triumph",
                    IDs = {
                        Normal = 41837,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Sabatons of Dominance",
                    IDs = {
                        Normal = 41076,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Sabatons of Salvation",
                    IDs = {
                        Normal = 41056,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Sabatons of Triumph",
                    IDs = {
                        Normal = 41231,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Waistguard of Dominance",
                    IDs = {
                        Normal = 41071,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Waistguard of Salvation",
                    IDs = {
                        Normal = 41052,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Waistguard of Triumph",
                    IDs = {
                        Normal = 41236,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Wristguards of Dominance",
                    IDs = {
                        Normal = 41066,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Wristguards of Salvation",
                    IDs = {
                        Normal = 41061,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Wristguards of Triumph",
                    IDs = {
                        Normal = 41226,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Bracers of Salvation",
                    IDs = {
                        Normal = 40984,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Bracers of Triumph",
                    IDs = {
                        Normal = 40890,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Girdle of Salvation",
                    IDs = {
                        Normal = 40978,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Girdle of Triumph",
                    IDs = {
                        Normal = 40883,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Greaves of Salvation",
                    IDs = {
                        Normal = 40979,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Greaves of Triumph",
                    IDs = {
                        Normal = 40884,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Band of Ascendancy",
                    IDs = {
                        Normal = 42118,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Band of Victory",
                    IDs = {
                        Normal = 42119,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Ascendancy",
                    IDs = {
                        Normal = 42078,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Deliverance",
                    IDs = {
                        Normal = 42080,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Dominance",
                    IDs = {
                        Normal = 42076,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Salvation",
                    IDs = {
                        Normal = 42079,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Subjugation",
                    IDs = {
                        Normal = 42077,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Triumph",
                    IDs = {
                        Normal = 42081,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Cloak of Victory",
                    IDs = {
                        Normal = 42082,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Ascendancy",
                    IDs = {
                        Normal = 42044,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Deliverance",
                    IDs = {
                        Normal = 42046,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Dominance",
                    IDs = {
                        Normal = 42043,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Salvation",
                    IDs = {
                        Normal = 42047,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Subjugation",
                    IDs = {
                        Normal = 42045,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Sundering",
                    IDs = {
                        Normal = 46374,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Triumph",
                    IDs = {
                        Normal = 42041,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Relentless Gladiator's Pendant of Victory",
                    IDs = {
                        Normal = 42042,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "10",
                    BonusLootGroup = "PvP Season Gear",
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Ymirjar Lord's Gauntlets",
                    IDs = {
                        Normal = 51213,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Ymirjar Lord's Legplates",
                    IDs = {
                        Normal = 51211,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Wrathful Gladiator's Plate Gauntlets",
                    IDs = {
                        Normal = 51542,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Wrathful Gladiator's Plate Legguards",
                    IDs = {
                        Normal = 51544,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Ymirjar Lord's Handguards",
                    IDs = {
                        Normal = 51217,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Ymirjar Lord's Legguards",
                    IDs = {
                        Normal = 51216,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warrior" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Sanctified Lightsworn Gloves",
                    IDs = {
                        Normal = 51169,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Sanctified Lightsworn Greaves",
                    IDs = {
                        Normal = 51168,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Wrathful Gladiator's Ornamented Gloves",
                    IDs = {
                        Normal = 51469,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Wrathful Gladiator's Ornamented Legplates",
                    IDs = {
                        Normal = 51471,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Sanctified Lightsworn Handguards",
                    IDs = {
                        Normal = 51172,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Sanctified Lightsworn Legguards",
                    IDs = {
                        Normal = 51171,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Protection",
                },

                {
                    Name = "Sanctified Lightsworn Gauntlets",
                    IDs = {
                        Normal = 51163,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Sanctified Lightsworn Legplates",
                    IDs = {
                        Normal = 51161,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Wrathful Gladiator's Scaled Gauntlets",
                    IDs = {
                        Normal = 51475,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Wrathful Gladiator's Scaled Legguards",
                    IDs = {
                        Normal = 51477,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Paladin" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Retribution",
                },

                {
                    Name = "Sanctified Ahn'Kahar Blood Hunter's Handguards",
                    IDs = {
                        Normal = 51154,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Sanctified Ahn'Kahar Blood Hunter's Legguards",
                    IDs = {
                        Normal = 51152,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Wrathful Gladiator's Chain Gauntlets",
                    IDs = {
                        Normal = 51459,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Chain Leggings",
                    IDs = {
                        Normal = 51461,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Hunter" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Sanctified Shadowblade Gauntlets",
                    IDs = {
                        Normal = 51188,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Sanctified Shadowblade Legplates",
                    IDs = {
                        Normal = 51186,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Wrathful Gladiator's Leather Gloves",
                    IDs = {
                        Normal = 51493,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Leather Legguards",
                    IDs = {
                        Normal = 51495,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Rogue" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Sanctified Crimson Acolyte Gloves",
                    IDs = {
                        Normal = 51179,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Sanctified Crimson Acolyte Leggings",
                    IDs = {
                        Normal = 51177,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Wrathful Gladiator's Mooncloth Gloves",
                    IDs = {
                        Normal = 51483,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Wrathful Gladiator's Mooncloth Leggings",
                    IDs = {
                        Normal = 51485,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Holy",
                },

                {
                    Name = "Sanctified Crimson Acolyte Handwraps",
                    IDs = {
                        Normal = 51183,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Sanctified Crimson Acolyte Pants",
                    IDs = {
                        Normal = 51181,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Wrathful Gladiator's Satin Gloves",
                    IDs = {
                        Normal = 51488,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Wrathful Gladiator's Satin Leggings",
                    IDs = {
                        Normal = 51490,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Priest" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Shadow",
                },

                {
                    Name = "Sanctified Scourgelord Gauntlets",
                    IDs = {
                        Normal = 51128,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Sanctified Scourgelord Legplates",
                    IDs = {
                        Normal = 51126,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Wrathful Gladiator's Dreadplate Gauntlets",
                    IDs = {
                        Normal = 51414,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Wrathful Gladiator's Dreadplate Legguards",
                    IDs = {
                        Normal = 51416,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "DPS",
                },

                {
                    Name = "Sanctified Scourgelord Handguards",
                    IDs = {
                        Normal = 51132,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Sanctified Scourgelord Legguards",
                    IDs = {
                        Normal = 51131,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tanking",
                },

                {
                    Name = "Sanctified Frost Witch's Gloves",
                    IDs = {
                        Normal = 51201,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Sanctified Frost Witch's Kilt",
                    IDs = {
                        Normal = 51203,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Wrathful Gladiator's Mail Gauntlets",
                    IDs = {
                        Normal = 51510,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Wrathful Gladiator's Mail Leggings",
                    IDs = {
                        Normal = 51512,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Elemental",
                },

                {
                    Name = "Sanctified Frost Witch's Grips",
                    IDs = {
                        Normal = 51196,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Sanctified Frost Witch's War-Kilt",
                    IDs = {
                        Normal = 51198,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Wrathful Gladiator's Linked Gauntlets",
                    IDs = {
                        Normal = 51504,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Wrathful Gladiator's Linked Leggings",
                    IDs = {
                        Normal = 51506,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Enhancement",
                },

                {
                    Name = "Sanctified Frost Witch's Handguards",
                    IDs = {
                        Normal = 51191,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Sanctified Frost Witch's Legguards",
                    IDs = {
                        Normal = 51193,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Wrathful Gladiator's Ringmail Gauntlets",
                    IDs = {
                        Normal = 51498,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Wrathful Gladiator's Ringmail Leggings",
                    IDs = {
                        Normal = 51500,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Sanctified Bloodmage Gloves",
                    IDs = {
                        Normal = 51159,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Sanctified Bloodmage Leggings",
                    IDs = {
                        Normal = 51157,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Wrathful Gladiator's Silk Handguards",
                    IDs = {
                        Normal = 51464,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Silk Trousers",
                    IDs = {
                        Normal = 51466,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Mage" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Sanctified Dark Coven Gloves",
                    IDs = {
                        Normal = 51209,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Sanctified Dark Coven Leggings",
                    IDs = {
                        Normal = 51207,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Tier Tokens",
                },

                {
                    Name = "Wrathful Gladiator's Felweave Handguards",
                    IDs = {
                        Normal = 51537,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Felweave Trousers",
                    IDs = {
                        Normal = 51539,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Sanctified Lasherweave's Gloves",
                    IDs = {
                        Normal = 51148,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Sanctified Lasherweave's Trousers",
                    IDs = {
                        Normal = 51146,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Wrathful Gladiator's Wyrmhide Gloves",
                    IDs = {
                        Normal = 51434,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Wrathful Gladiator's Wyrmhide Legguards",
                    IDs = {
                        Normal = 51436,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Balance",
                },

                {
                    Name = "Sanctified Lasherweave's Handgrips",
                    IDs = {
                        Normal = 51144,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Sanctified Lasherweave's Legguards",
                    IDs = {
                        Normal = 51142,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Wrathful Gladiator's Dragonhide Gloves",
                    IDs = {
                        Normal = 51426,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Wrathful Gladiator's Dragonhide Legguards",
                    IDs = {
                        Normal = 51428,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Feral",
                },

                {
                    Name = "Sanctified Lasherweave's Gauntlets",
                    IDs = {
                        Normal = 51138,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Sanctified Lasherweave's Legplates",
                    IDs = {
                        Normal = 51136,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Wrathful Gladiator's Kodohide Gloves",
                    IDs = {
                        Normal = 51420,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Wrathful Gladiator's Kodohide Legguards",
                    IDs = {
                        Normal = 51422,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = { "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "Restoration",
                },

                {
                    Name = "Wrathful Gladiator's Cord of Alacrity",
                    IDs = {
                        Normal = 51337,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cord of Dominance",
                    IDs = {
                        Normal = 51327,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cord of Salvation",
                    IDs = {
                        Normal = 51365,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cuffs of Alacrity",
                    IDs = {
                        Normal = 51339,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cuffs of Dominance",
                    IDs = {
                        Normal = 51329,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cuffs of Salvation",
                    IDs = {
                        Normal = 51367,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Treads of Alacrity",
                    IDs = {
                        Normal = 51338,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Treads of Dominance",
                    IDs = {
                        Normal = 51328,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Treads of Salvation",
                    IDs = {
                        Normal = 51366,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Mage", "Priest", "Warlock" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Armwraps of Dominance",
                    IDs = {
                        Normal = 51345,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Armwraps of Salvation",
                    IDs = {
                        Normal = 51342,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Armwraps of Triumph",
                    IDs = {
                        Normal = 51370,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Belt of Dominance",
                    IDs = {
                        Normal = 51343,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Belt of Salvation",
                    IDs = {
                        Normal = 51340,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Belt of Triumph",
                    IDs = {
                        Normal = 51368,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Boots of Dominance",
                    IDs = {
                        Normal = 51344,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Boots of Salvation",
                    IDs = {
                        Normal = 51341,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Boots of Triumph",
                    IDs = {
                        Normal = 51369,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Rogue", "Druid" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Sabatons of Dominance",
                    IDs = {
                        Normal = 51375,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Sabatons of Salvation",
                    IDs = {
                        Normal = 51372,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Sabatons of Triumph",
                    IDs = {
                        Normal = 51351,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Waistguard of Dominance",
                    IDs = {
                        Normal = 51374,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Waistguard of Salvation",
                    IDs = {
                        Normal = 51371,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Waistguard of Triumph",
                    IDs = {
                        Normal = 51350,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Wristguards of Dominance",
                    IDs = {
                        Normal = 51376,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Wristguards of Salvation",
                    IDs = {
                        Normal = 51373,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Wristguards of Triumph",
                    IDs = {
                        Normal = 51352,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Hunter", "Shaman" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Bracers of Salvation",
                    IDs = {
                        Normal = 51361,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Bracers of Triumph",
                    IDs = {
                        Normal = 51364,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Girdle of Salvation",
                    IDs = {
                        Normal = 51359,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Girdle of Triumph",
                    IDs = {
                        Normal = 51362,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Greaves of Salvation",
                    IDs = {
                        Normal = 51360,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Greaves of Triumph",
                    IDs = {
                        Normal = 51363,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = { "Warrior", "Paladin", "Death Knight" },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Band of Dominance",
                    IDs = {
                        Normal = 51336,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Band of Triumph",
                    IDs = {
                        Normal = 51358,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cloak of Ascendancy",
                    IDs = {
                        Normal = 51334,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cloak of Deliverance",
                    IDs = {
                        Normal = 51348,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cloak of Dominance",
                    IDs = {
                        Normal = 51330,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cloak of Salvation",
                    IDs = {
                        Normal = 51346,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cloak of Subjugation",
                    IDs = {
                        Normal = 51332,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cloak of Triumph",
                    IDs = {
                        Normal = 51354,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Cloak of Victory",
                    IDs = {
                        Normal = 51356,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Ascendancy",
                    IDs = {
                        Normal = 51335,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Deliverance",
                    IDs = {
                        Normal = 51349,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Dominance",
                    IDs = {
                        Normal = 51331,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Salvation",
                    IDs = {
                        Normal = 51347,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Subjugation",
                    IDs = {
                        Normal = 51333,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Sundering",
                    IDs = {
                        Normal = 51353,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Triumph",
                    IDs = {
                        Normal = 51355,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

                {
                    Name = "Wrathful Gladiator's Pendant of Victory",
                    IDs = {
                        Normal = 51357,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = {  },
                    Notes = nil,
                    Difficulty = "25",
                    BonusLootGroup = "PvP Season Gear",
                },

            },

        },

    },

}

ImpLoot.Database:RegisterRaid(VOA_RAID)
