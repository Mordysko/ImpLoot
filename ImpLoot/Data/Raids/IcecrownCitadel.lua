-------------------------------------------------
-- Icecrown Citadel
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
-------------------------------------------------

local ICC = {

    Name = "Icecrown Citadel",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "10 Heroic",
        "25",
        "25 Heroic",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Lord Marrowgar
        -------------------------------------------------

        {
            Order = 1,
            Name = "Lord Marrowgar",
            NPCID = 36612,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Marrowgar's Scratching Choker",
                    IDs = {
                        Normal = 50763,
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
                    Name = "Shawl of Nerubian Silk",
                    IDs = {
                        Normal = 50764,
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
                    Name = "Cord of the Patronizing Practitioner",
                    IDs = {
                        Normal = 50773,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Coldwraith Bracers",
                    IDs = {
                        Normal = 50774,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Linked Scourge Vertebrae",
                    IDs = {
                        Normal = 50762,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Ancient Skeletal Boots",
                    IDs = {
                        Normal = 50772,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Corrupted Silverplate Leggings",
                    IDs = {
                        Normal = 50775,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Sliver of Pure Ice",
                    IDs = {
                        Normal = 50339,
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
                    Name = "Frost Needle",
                    IDs = {
                        Normal = 50771,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Bone Warden's Splitter",
                    IDs = {
                        Normal = 50759,
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
                    Name = "Bonebreaker Scepter",
                    IDs = {
                        Normal = 50760,
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
                    Name = "Citadel Enforcer's Claymore",
                    IDs = {
                        Normal = 50761,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Marrowgar's Scratching Choker",
                    IDs = {
                        Normal = nil,
                        Heroic = 51934,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Shawl of Nerubian Silk",
                    IDs = {
                        Normal = nil,
                        Heroic = 51933,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Cord of the Patronizing Practitioner",
                    IDs = {
                        Normal = nil,
                        Heroic = 51930,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Coldwraith Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51929,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Linked Scourge Vertebrae",
                    IDs = {
                        Normal = nil,
                        Heroic = 51935,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Ancient Skeletal Boots",
                    IDs = {
                        Normal = nil,
                        Heroic = 51931,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Corrupted Silverplate Leggings",
                    IDs = {
                        Normal = nil,
                        Heroic = 51928,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Sliver of Pure Ice",
                    IDs = {
                        Normal = nil,
                        Heroic = 50346,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Frost Needle",
                    IDs = {
                        Normal = nil,
                        Heroic = 51932,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bone Warden's Splitter",
                    IDs = {
                        Normal = nil,
                        Heroic = 51938,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bonebreaker Scepter",
                    IDs = {
                        Normal = nil,
                        Heroic = 51937,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Citadel Enforcer's Claymore",
                    IDs = {
                        Normal = nil,
                        Heroic = 51936,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Band of the Bone Colossus",
                    IDs = {
                        Normal = 49949,
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
                    Name = "Bone Sentinel's Amulet",
                    IDs = {
                        Normal = 49975,
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
                    Name = "Loop of the Endless Labyrinth",
                    IDs = {
                        Normal = 49977,
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
                    Name = "Marrowgar's Frigid Eye",
                    IDs = {
                        Normal = 49967,
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
                    Name = "Crushing Coldwraith Belt",
                    IDs = {
                        Normal = 49978,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Frostbitten Fur Boots",
                    IDs = {
                        Normal = 49950,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Handguards of Winter's Respite",
                    IDs = {
                        Normal = 49979,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Snowserpent Mail Helm",
                    IDs = {
                        Normal = 49952,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Bracers of Dark Reckoning",
                    IDs = {
                        Normal = 49960,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Gendarme's Cuirass",
                    IDs = {
                        Normal = 49951,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Legguards of Lost Hope",
                    IDs = {
                        Normal = 49964,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Rusted Bonespike Pauldrons",
                    IDs = {
                        Normal = 49980,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Bulwark of Smouldering Steel",
                    IDs = {
                        Normal = 49976,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Frozen Bonespike",
                    IDs = {
                        Normal = 49968,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Bryntroll, the Bone Arbiter",
                    IDs = {
                        Normal = 50415,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Band of the Bone Colossus",
                    IDs = {
                        Normal = nil,
                        Heroic = 50604,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bone Sentinel's Amulet",
                    IDs = {
                        Normal = nil,
                        Heroic = 50609,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Loop of the Endless Labyrinth",
                    IDs = {
                        Normal = nil,
                        Heroic = 50614,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Marrowgar's Frigid Eye",
                    IDs = {
                        Normal = nil,
                        Heroic = 50610,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Crushing Coldwraith Belt",
                    IDs = {
                        Normal = nil,
                        Heroic = 50613,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Frostbitten Fur Boots",
                    IDs = {
                        Normal = nil,
                        Heroic = 50607,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Handguards of Winter's Respite",
                    IDs = {
                        Normal = nil,
                        Heroic = 50615,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Snowserpent Mail Helm",
                    IDs = {
                        Normal = nil,
                        Heroic = 50605,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bracers of Dark Reckoning",
                    IDs = {
                        Normal = nil,
                        Heroic = 50611,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Gendarme's Cuirass",
                    IDs = {
                        Normal = nil,
                        Heroic = 50606,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Legguards of Lost Hope",
                    IDs = {
                        Normal = nil,
                        Heroic = 50612,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Rusted Bonespike Pauldrons",
                    IDs = {
                        Normal = nil,
                        Heroic = 50617,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bulwark of Smouldering Steel",
                    IDs = {
                        Normal = nil,
                        Heroic = 50616,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Frozen Bonespike",
                    IDs = {
                        Normal = nil,
                        Heroic = 50608,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bryntroll, the Bone Arbiter",
                    IDs = {
                        Normal = nil,
                        Heroic = 50709,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },

        -------------------------------------------------
        -- 2. Lady Deathwhisper
        -------------------------------------------------

        {
            Order = 2,
            Name = "Lady Deathwhisper",
            NPCID = 36855,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Bracers of Dark Blessings",
                    IDs = {
                        Normal = 50785,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Sister's Handshrouds",
                    IDs = {
                        Normal = 50782,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Boots of the Frozen Seed",
                    IDs = {
                        Normal = 50783,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Chestguard of the Frigid Noose",
                    IDs = {
                        Normal = 50780,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Soulthief's Braided Belt",
                    IDs = {
                        Normal = 50778,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Deathspeaker Disciple's Belt",
                    IDs = {
                        Normal = 50784,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Handgrips of Frost and Sleet",
                    IDs = {
                        Normal = 50777,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Deathspeaker Zealot's Helm",
                    IDs = {
                        Normal = 50779,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Ghoul Commander's Cuirass",
                    IDs = {
                        Normal = 50786,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Whispering Fanged Skull",
                    IDs = {
                        Normal = 50342,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Scourgelord's Baton",
                    IDs = {
                        Normal = 50781,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Njorndar Bone Bow",
                    IDs = {
                        Normal = 50776,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Bracers of Dark Blessings",
                    IDs = {
                        Normal = nil,
                        Heroic = 51918,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Sister's Handshrouds",
                    IDs = {
                        Normal = nil,
                        Heroic = 51921,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Boots of the Frozen Seed",
                    IDs = {
                        Normal = nil,
                        Heroic = 51920,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Chestguard of the Frigid Noose",
                    IDs = {
                        Normal = nil,
                        Heroic = 51923,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Soulthief's Braided Belt",
                    IDs = {
                        Normal = nil,
                        Heroic = 51925,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Deathspeaker Disciple's Belt",
                    IDs = {
                        Normal = nil,
                        Heroic = 51919,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Handgrips of Frost and Sleet",
                    IDs = {
                        Normal = nil,
                        Heroic = 51926,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Deathspeaker Zealot's Helm",
                    IDs = {
                        Normal = nil,
                        Heroic = 51924,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Ghoul Commander's Cuirass",
                    IDs = {
                        Normal = nil,
                        Heroic = 51917,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Whispering Fanged Skull",
                    IDs = {
                        Normal = nil,
                        Heroic = 50343,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Scourgelord's Baton",
                    IDs = {
                        Normal = nil,
                        Heroic = 51922,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Njorndar Bone Bow",
                    IDs = {
                        Normal = nil,
                        Heroic = 51927,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Ahn'kahar Onyx Neckguard",
                    IDs = {
                        Normal = 49989,
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
                    Name = "Juggernaut Band",
                    IDs = {
                        Normal = 49985,
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
                    Name = "Ring of Maddening Whispers",
                    IDs = {
                        Normal = 49990,
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
                    Name = "Shoulders of Mercy Killing",
                    IDs = {
                        Normal = 49991,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "The Lady's Brittle Bracers",
                    IDs = {
                        Normal = 49994,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Cultist's Bloodsoaked Spaulders",
                    IDs = {
                        Normal = 49987,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Deathwhisper Raiment",
                    IDs = {
                        Normal = 49996,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Leggings of Northern Lights",
                    IDs = {
                        Normal = 49988,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Necrophotic Greaves",
                    IDs = {
                        Normal = 49993,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Blood-Soaked Saronite Stompers",
                    IDs = {
                        Normal = 49983,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Broken Ram Skull Helm",
                    IDs = {
                        Normal = 49986,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Fallen Lord's Handguards",
                    IDs = {
                        Normal = 49995,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Heartpierce",
                    IDs = {
                        Normal = 49982,
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
                    Name = "Zod's Repeating Longbow",
                    IDs = {
                        Normal = 50034,
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
                    Name = "Nibelung",
                    IDs = {
                        Normal = 49992,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Ahn'kahar Onyx Neckguard",
                    IDs = {
                        Normal = nil,
                        Heroic = 50647,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Juggernaut Band",
                    IDs = {
                        Normal = nil,
                        Heroic = 50642,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Ring of Maddening Whispers",
                    IDs = {
                        Normal = nil,
                        Heroic = 50644,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Shoulders of Mercy Killing",
                    IDs = {
                        Normal = nil,
                        Heroic = 50643,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "The Lady's Brittle Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 50651,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Cultist's Bloodsoaked Spaulders",
                    IDs = {
                        Normal = nil,
                        Heroic = 50646,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Deathwhisper Raiment",
                    IDs = {
                        Normal = nil,
                        Heroic = 50649,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Leggings of Northern Lights",
                    IDs = {
                        Normal = nil,
                        Heroic = 50645,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Necrophotic Greaves",
                    IDs = {
                        Normal = nil,
                        Heroic = 50652,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Blood-Soaked Saronite Stompers",
                    IDs = {
                        Normal = nil,
                        Heroic = 50639,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Broken Ram Skull Helm",
                    IDs = {
                        Normal = nil,
                        Heroic = 50640,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Fallen Lord's Handguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 50650,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Heartpierce",
                    IDs = {
                        Normal = nil,
                        Heroic = 50641,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Zod's Repeating Longbow",
                    IDs = {
                        Normal = nil,
                        Heroic = 50638,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Nibelung",
                    IDs = {
                        Normal = nil,
                        Heroic = 50648,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },

        -------------------------------------------------
        -- 3. Gunship Battle
        -------------------------------------------------

        {
            Order = 3,
            Name = "Gunship Battle",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Abomination's Bloody Ring",
                    IDs = {
                        Normal = 50790,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Saronite Gargoyle Cloak",
                    IDs = {
                        Normal = 50791,
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
                    Name = "Cord of Dark Suffering",
                    IDs = {
                        Normal = 50795,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Icecrown Rampart Bracers",
                    IDs = {
                        Normal = 50789,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Ice-Reinforced Vrykul Helm",
                    IDs = {
                        Normal = 50797,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Pauldrons of Lost Hope",
                    IDs = {
                        Normal = 50792,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Bone Drake's Enameled Boots",
                    IDs = {
                        Normal = 50788,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Bracers of Pale Illumination",
                    IDs = {
                        Normal = 50796,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Neverending Winter",
                    IDs = {
                        Normal = 50794,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Muradin's Spyglass",
                    IDs = {
                        Normal = 50340,
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
                    Name = "Frost Giant's Cleaver",
                    IDs = {
                        Normal = 50787,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Midnight Sun",
                    IDs = {
                        Normal = 50793,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Abomination's Bloody Ring",
                    IDs = {
                        Normal = nil,
                        Heroic = 51913,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Saronite Gargoyle Cloak",
                    IDs = {
                        Normal = nil,
                        Heroic = 51912,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Cord of Dark Suffering",
                    IDs = {
                        Normal = nil,
                        Heroic = 51908,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Icecrown Rampart Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51914,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Ice-Reinforced Vrykul Helm",
                    IDs = {
                        Normal = nil,
                        Heroic = 51906,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Pauldrons of Lost Hope",
                    IDs = {
                        Normal = nil,
                        Heroic = 51911,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bone Drake's Enameled Boots",
                    IDs = {
                        Normal = nil,
                        Heroic = 51915,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bracers of Pale Illumination",
                    IDs = {
                        Normal = nil,
                        Heroic = 51907,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Neverending Winter",
                    IDs = {
                        Normal = nil,
                        Heroic = 51909,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Muradin's Spyglass",
                    IDs = {
                        Normal = nil,
                        Heroic = 50345,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Frost Giant's Cleaver",
                    IDs = {
                        Normal = nil,
                        Heroic = 51916,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Midnight Sun",
                    IDs = {
                        Normal = nil,
                        Heroic = 51910,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Amulet of the Silent Eulogy",
                    IDs = {
                        Normal = 50005,
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
                    Name = "Ring of Rapid Ascent",
                    IDs = {
                        Normal = 50008,
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
                    Name = "Skeleton Lord's Circle",
                    IDs = {
                        Normal = 49999,
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
                    Name = "Shadowvault Slayer's Cloak",
                    IDs = {
                        Normal = 49998,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Corp'rethar Ceremonial Crown",
                    IDs = {
                        Normal = 50006,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Gunship Captain's Mittens",
                    IDs = {
                        Normal = 50011,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Boots of Unnatural Growth",
                    IDs = {
                        Normal = 50009,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Ikfirus's Sack of Wonder",
                    IDs = {
                        Normal = 50001,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Scourge Hunter's Vambraces",
                    IDs = {
                        Normal = 50000,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Boneguard Commander's Pauldrons",
                    IDs = {
                        Normal = 50003,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Polar Bear Claw Bracers",
                    IDs = {
                        Normal = 50002,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Waistband of Righteous Fury",
                    IDs = {
                        Normal = 50010,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Althor's Abacus",
                    IDs = {
                        Normal = 50359,
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
                    Name = "Corpse Tongue Coin",
                    IDs = {
                        Normal = 50352,
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
                    Name = "Scourgeborne Waraxe",
                    IDs = {
                        Normal = 50411,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Amulet of the Silent Eulogy",
                    IDs = {
                        Normal = nil,
                        Heroic = 50658,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Ring of Rapid Ascent",
                    IDs = {
                        Normal = nil,
                        Heroic = 50664,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Skeleton Lord's Circle",
                    IDs = {
                        Normal = nil,
                        Heroic = 50657,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Shadowvault Slayer's Cloak",
                    IDs = {
                        Normal = nil,
                        Heroic = 50653,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Corp'rethar Ceremonial Crown",
                    IDs = {
                        Normal = nil,
                        Heroic = 50661,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Gunship Captain's Mittens",
                    IDs = {
                        Normal = nil,
                        Heroic = 50663,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Boots of Unnatural Growth",
                    IDs = {
                        Normal = nil,
                        Heroic = 50665,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Ikfirus's Sack of Wonder",
                    IDs = {
                        Normal = nil,
                        Heroic = 50656,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Scourge Hunter's Vambraces",
                    IDs = {
                        Normal = nil,
                        Heroic = 50655,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Boneguard Commander's Pauldrons",
                    IDs = {
                        Normal = nil,
                        Heroic = 50660,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Polar Bear Claw Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 50659,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Waistband of Righteous Fury",
                    IDs = {
                        Normal = nil,
                        Heroic = 50667,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Althor's Abacus",
                    IDs = {
                        Normal = nil,
                        Heroic = 50366,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Corpse Tongue Coin",
                    IDs = {
                        Normal = nil,
                        Heroic = 50349,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Scourgeborne Waraxe",
                    IDs = {
                        Normal = nil,
                        Heroic = 50654,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },

        -------------------------------------------------
        -- 4. Deathbringer Saurfang
        -------------------------------------------------

        {
            Order = 4,
            Name = "Deathbringer Saurfang",
            NPCID = 37813,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Thaumaturge's Crackling Cowl",
                    IDs = {
                        Normal = 50807,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Icecrown Spire Sandals",
                    IDs = {
                        Normal = 50804,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Scourge Stranglers",
                    IDs = {
                        Normal = 50799,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Leggings of Unrelenting Blood",
                    IDs = {
                        Normal = 50806,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Hauberk of a Thousand Cuts",
                    IDs = {
                        Normal = 50800,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Blade-Scored Carapace",
                    IDs = {
                        Normal = 50801,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gargoyle Spit Bracers",
                    IDs = {
                        Normal = 50802,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Deathforged Legplates",
                    IDs = {
                        Normal = 50808,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Soulcleave Pendant",
                    IDs = {
                        Normal = 50809,
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
                    Name = "Saurfang's Cold-Forged Band",
                    IDs = {
                        Normal = 50803,
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
                    Name = "Ramaladni's Blade of Culling",
                    IDs = {
                        Normal = 50798,
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
                    Name = "Mag'hari Chieftain's Staff",
                    IDs = {
                        Normal = 50805,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Thaumaturge's Crackling Cowl",
                    IDs = {
                        Normal = nil,
                        Heroic = 51896,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Icecrown Spire Sandals",
                    IDs = {
                        Normal = nil,
                        Heroic = 51899,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Scourge Stranglers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51904,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Leggings of Unrelenting Blood",
                    IDs = {
                        Normal = nil,
                        Heroic = 51897,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Hauberk of a Thousand Cuts",
                    IDs = {
                        Normal = nil,
                        Heroic = 51903,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Blade-Scored Carapace",
                    IDs = {
                        Normal = nil,
                        Heroic = 51902,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Gargoyle Spit Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51901,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Deathforged Legplates",
                    IDs = {
                        Normal = nil,
                        Heroic = 51895,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Soulcleave Pendant",
                    IDs = {
                        Normal = nil,
                        Heroic = 51894,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Saurfang's Cold-Forged Band",
                    IDs = {
                        Normal = nil,
                        Heroic = 51900,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Ramaladni's Blade of Culling",
                    IDs = {
                        Normal = nil,
                        Heroic = 51905,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Mag'hari Chieftain's Staff",
                    IDs = {
                        Normal = nil,
                        Heroic = 51898,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Greatcloak of the Turned Champion",
                    IDs = {
                        Normal = 50014,
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
                    Name = "Toskk's Maximized Wristguards",
                    IDs = {
                        Normal = 50333,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Belt of the Blood Nova",
                    IDs = {
                        Normal = 50015,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Deathbringer's Will",
                    IDs = {
                        Normal = 50362,
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
                    Name = "Bloodvenom Blade",
                    IDs = {
                        Normal = 50412,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Greatcloak of the Turned Champion",
                    IDs = {
                        Normal = nil,
                        Heroic = 50668,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Toskk's Maximized Wristguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 50670,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Belt of the Blood Nova",
                    IDs = {
                        Normal = nil,
                        Heroic = 50671,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Deathbringer's Will",
                    IDs = {
                        Normal = nil,
                        Heroic = 50363,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bloodvenom Blade",
                    IDs = {
                        Normal = nil,
                        Heroic = 50672,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = 52027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = 52026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = 52025,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52030,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52029,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52028,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 5. Festergut
        -------------------------------------------------

        {
            Order = 5,
            Name = "Festergut",
            NPCID = 36626,

            Loot = {
                
                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Cloak of Many Skins",
                    IDs = {
                        Normal = 50859,
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
                    Name = "Precious's Putrid Collar",
                    IDs = {
                        Normal = 50852,
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
                    Name = "Signet of Putrefaction",
                    IDs = {
                        Normal = 50986,
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
                    Name = "Bloodstained Surgeon's Shoulderguards",
                    IDs = {
                        Normal = 50988,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Kilt of Untreated Wounds",
                    IDs = {
                        Normal = 50990,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Plague-Soaked Leather Leggings",
                    IDs = {
                        Normal = 50858,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Wrists of Septic Shock",
                    IDs = {
                        Normal = 50985,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Taldron's Long Neglected Boots",
                    IDs = {
                        Normal = 50812,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Festergut's Gaseous Gloves",
                    IDs = {
                        Normal = 50967,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Festering Fingerguards",
                    IDs = {
                        Normal = 50811,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gutbuster",
                    IDs = {
                        Normal = 50810,
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
                    Name = "Abracadaver",
                    IDs = {
                        Normal = 50966,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Cloak of Many Skins",
                    IDs = {
                        Normal = nil,
                        Heroic = 51888,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Precious's Putrid Collar",
                    IDs = {
                        Normal = nil,
                        Heroic = 51890,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Signet of Putrefaction",
                    IDs = {
                        Normal = nil,
                        Heroic = 51884,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bloodstained Surgeon's Shoulderguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 51883,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Kilt of Untreated Wounds",
                    IDs = {
                        Normal = nil,
                        Heroic = 51882,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Plague-Soaked Leather Leggings",
                    IDs = {
                        Normal = nil,
                        Heroic = 51889,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Wrists of Septic Shock",
                    IDs = {
                        Normal = nil,
                        Heroic = 51885,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Taldron's Long Neglected Boots",
                    IDs = {
                        Normal = nil,
                        Heroic = 51891,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Festergut's Gaseous Gloves",
                    IDs = {
                        Normal = nil,
                        Heroic = 51886,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Festering Fingerguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 51892,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Gutbuster",
                    IDs = {
                        Normal = nil,
                        Heroic = 51893,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Abracadaver",
                    IDs = {
                        Normal = nil,
                        Heroic = 51887,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Holiday's Grace",
                    IDs = {
                        Normal = 50061,
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
                    Name = "Might of Blight",
                    IDs = {
                        Normal = 50414,
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
                    Name = "Lingering Illness",
                    IDs = {
                        Normal = 50063,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Plague Scientist's Boots",
                    IDs = {
                        Normal = 50062,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Plaguebringer's Stained Pants",
                    IDs = {
                        Normal = 50056,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Gangrenous Leggings",
                    IDs = {
                        Normal = 50042,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Leather of Stitched Scourge Parts",
                    IDs = {
                        Normal = 50041,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Carapace of Forgotten Kings",
                    IDs = {
                        Normal = 50038,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Horrific Flesh Epaulets",
                    IDs = {
                        Normal = 50059,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Nerub'ar Stalker's Cord",
                    IDs = {
                        Normal = 50413,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Unclean Surgical Gloves",
                    IDs = {
                        Normal = 50064,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Belt of Broken Bones",
                    IDs = {
                        Normal = 50036,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Faceplate of the Forgotten",
                    IDs = {
                        Normal = 50060,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Fleshrending Gauntlets",
                    IDs = {
                        Normal = 50037,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Black Bruise",
                    IDs = {
                        Normal = 50035,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Distant Land",
                    IDs = {
                        Normal = 50040,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Holiday's Grace",
                    IDs = {
                        Normal = nil,
                        Heroic = 50700,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Might of Blight",
                    IDs = {
                        Normal = nil,
                        Heroic = 50693,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Lingering Illness",
                    IDs = {
                        Normal = nil,
                        Heroic = 50702,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Plague Scientist's Boots",
                    IDs = {
                        Normal = nil,
                        Heroic = 50699,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Plaguebringer's Stained Pants",
                    IDs = {
                        Normal = nil,
                        Heroic = 50694,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Gangrenous Leggings",
                    IDs = {
                        Normal = nil,
                        Heroic = 50697,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Leather of Stitched Scourge Parts",
                    IDs = {
                        Normal = nil,
                        Heroic = 50696,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Carapace of Forgotten Kings",
                    IDs = {
                        Normal = nil,
                        Heroic = 50689,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Horrific Flesh Epaulets",
                    IDs = {
                        Normal = nil,
                        Heroic = 50698,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Nerub'ar Stalker's Cord",
                    IDs = {
                        Normal = nil,
                        Heroic = 50688,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Unclean Surgical Gloves",
                    IDs = {
                        Normal = nil,
                        Heroic = 50703,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Belt of Broken Bones",
                    IDs = {
                        Normal = nil,
                        Heroic = 50691,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Faceplate of the Forgotten",
                    IDs = {
                        Normal = nil,
                        Heroic = 50701,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Fleshrending Gauntlets",
                    IDs = {
                        Normal = nil,
                        Heroic = 50690,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Black Bruise",
                    IDs = {
                        Normal = nil,
                        Heroic = 50692,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Distant Land",
                    IDs = {
                        Normal = nil,
                        Heroic = 50695,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },

        -------------------------------------------------
        -- 6. Rotface
        -------------------------------------------------

        {
            Order = 6,
            Name = "Rotface",
            NPCID = 36627,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Choker of Filthy Diamonds",
                    IDs = {
                        Normal = 51008,
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
                    Name = "Rotface's Rupturing Ring",
                    IDs = {
                        Normal = 51001,
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
                    Name = "Ether-Soaked Bracers",
                    IDs = {
                        Normal = 51007,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Gloves of Broken Fingers",
                    IDs = {
                        Normal = 51005,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Chestguard of the Failed Experiment",
                    IDs = {
                        Normal = 51009,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Shuffling Shoes",
                    IDs = {
                        Normal = 51006,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Taldron's Short-Sighted Helm",
                    IDs = {
                        Normal = 51002,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Flesh-Shaper's Gurney Strap",
                    IDs = {
                        Normal = 51000,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Abomination Knuckles",
                    IDs = {
                        Normal = 51003,
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
                    Name = "Lockjaw",
                    IDs = {
                        Normal = 51004,
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
                    Name = "Shaft of Glacial Ice",
                    IDs = {
                        Normal = 50998,
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
                    Name = "Gluth's Fetching Knife",
                    IDs = {
                        Normal = 50999,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Thrown",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Choker of Filthy Diamonds",
                    IDs = {
                        Normal = nil,
                        Heroic = 51871,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Rotface's Rupturing Ring",
                    IDs = {
                        Normal = nil,
                        Heroic = 51878,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Ether-Soaked Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51872,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Gloves of Broken Fingers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51874,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Chestguard of the Failed Experiment",
                    IDs = {
                        Normal = nil,
                        Heroic = 51870,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Shuffling Shoes",
                    IDs = {
                        Normal = nil,
                        Heroic = 51873,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Taldron's Short-Sighted Helm",
                    IDs = {
                        Normal = nil,
                        Heroic = 51877,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Flesh-Shaper's Gurney Strap",
                    IDs = {
                        Normal = nil,
                        Heroic = 51879,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Abomination Knuckles",
                    IDs = {
                        Normal = nil,
                        Heroic = 51876,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Lockjaw",
                    IDs = {
                        Normal = nil,
                        Heroic = 51875,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Shaft of Glacial Ice",
                    IDs = {
                        Normal = nil,
                        Heroic = 51881,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Gluth's Fetching Knife",
                    IDs = {
                        Normal = nil,
                        Heroic = 51880,
                    },
                    Quality = 4,
                    Slot = "Thrown",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
               -------------------------------------------------
            
                {
                    Name = "Bile-Encrusted Medallion",
                    IDs = {
                        Normal = 50023,
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
                    Name = "Seal of Many Mouths",
                    IDs = {
                        Normal = 50025,
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
                    Name = "Winding Sheet",
                    IDs = {
                        Normal = 50019,
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
                    Name = "Death Surgeon's Sleeves",
                    IDs = {
                        Normal = 50032,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Aldriana's Gloves of Secrecy",
                    IDs = {
                        Normal = 50021,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Helm of the Elder Moon",
                    IDs = {
                        Normal = 50026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Bloodsunder's Bracers",
                    IDs = {
                        Normal = 50030,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Dual-Bladed Pauldrons",
                    IDs = {
                        Normal = 50022,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Blightborne Warplate",
                    IDs = {
                        Normal = 50024,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Raging Behemoth's Shoulderplates",
                    IDs = {
                        Normal = 50020,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Rot-Resistant Breastplate",
                    IDs = {
                        Normal = 50027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Dislodged Foreign Object",
                    IDs = {
                        Normal = 50353,
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
                    Name = "Trauma",
                    IDs = {
                        Normal = 50028,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Rib Spreader",
                    IDs = {
                        Normal = 50016,
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
                    Name = "Corpse-Impaling Spike",
                    IDs = {
                        Normal = 50033,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Bile-Encrusted Medallion",
                    IDs = {
                        Normal = nil,
                        Heroic = 50682,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Seal of Many Mouths",
                    IDs = {
                        Normal = nil,
                        Heroic = 50678,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Winding Sheet",
                    IDs = {
                        Normal = nil,
                        Heroic = 50677,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Death Surgeon's Sleeves",
                    IDs = {
                        Normal = nil,
                        Heroic = 50686,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Aldriana's Gloves of Secrecy",
                    IDs = {
                        Normal = nil,
                        Heroic = 50675,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Helm of the Elder Moon",
                    IDs = {
                        Normal = nil,
                        Heroic = 50679,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bloodsunder's Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 50687,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Dual-Bladed Pauldrons",
                    IDs = {
                        Normal = nil,
                        Heroic = 50673,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Blightborne Warplate",
                    IDs = {
                        Normal = nil,
                        Heroic = 50681,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Raging Behemoth's Shoulderplates",
                    IDs = {
                        Normal = nil,
                        Heroic = 50674,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Rot-Resistant Breastplate",
                    IDs = {
                        Normal = nil,
                        Heroic = 50680,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Dislodged Foreign Object",
                    IDs = {
                        Normal = nil,
                        Heroic = 50348,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Trauma",
                    IDs = {
                        Normal = nil,
                        Heroic = 50685,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Rib Spreader",
                    IDs = {
                        Normal = nil,
                        Heroic = 50676,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Corpse-Impaling Spike",
                    IDs = {
                        Normal = nil,
                        Heroic = 50684,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },

        -------------------------------------------------
        -- 7. Professor Putricide
        -------------------------------------------------

        {
            Order = 7,
            Name = "Professor Putricide",
            NPCID = 36678,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
           
                {
                    Name = "Shoulders of Ruinous Senility",
                    IDs = {
                        Normal = 51020,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Cauterized Cord",
                    IDs = {
                        Normal = 51017,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Discarded Bag of Entrails",
                    IDs = {
                        Normal = 51013,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Shoulderpads of the Morbid Ritual",
                    IDs = {
                        Normal = 51015,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Rippling Flesh Kilt",
                    IDs = {
                        Normal = 51019,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Scalpel-Sharpening Shoulderguards",
                    IDs = {
                        Normal = 51014,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Chestplate of Septic Stitches",
                    IDs = {
                        Normal = 51018,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Infected Choker",
                    IDs = {
                        Normal = 51012,
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
                    Name = "Pendant of Split Veins",
                    IDs = {
                        Normal = 51016,
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
                    Name = "Unidentifiable Organ",
                    IDs = {
                        Normal = 50341,
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
                    Name = "Flesh-Carving Scalpel",
                    IDs = {
                        Normal = 51011,
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
                    Name = "The Facelifter",
                    IDs = {
                        Normal = 51010,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Shoulders of Ruinous Senility",
                    IDs = {
                        Normal = nil,
                        Heroic = 51859,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Cauterized Cord",
                    IDs = {
                        Normal = nil,
                        Heroic = 51862,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Discarded Bag of Entrails",
                    IDs = {
                        Normal = nil,
                        Heroic = 51866,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Shoulderpads of the Morbid Ritual",
                    IDs = {
                        Normal = nil,
                        Heroic = 51864,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Rippling Flesh Kilt",
                    IDs = {
                        Normal = nil,
                        Heroic = 51860,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Scalpel-Sharpening Shoulderguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 51865,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Chestplate of Septic Stitches",
                    IDs = {
                        Normal = nil,
                        Heroic = 51861,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Infected Choker",
                    IDs = {
                        Normal = nil,
                        Heroic = 51867,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Pendant of Split Veins",
                    IDs = {
                        Normal = nil,
                        Heroic = 51863,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Unidentifiable Organ",
                    IDs = {
                        Normal = nil,
                        Heroic = 50344,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Flesh-Carving Scalpel",
                    IDs = {
                        Normal = nil,
                        Heroic = 51868,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "The Facelifter",
                    IDs = {
                        Normal = nil,
                        Heroic = 51869,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Astrylian's Sutured Cinch",
                    IDs = {
                        Normal = 50067,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Professor's Bloodied Smock",
                    IDs = {
                        Normal = 50069,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Tiny Abomination in a Jar",
                    IDs = {
                        Normal = 50351,
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
                    Name = "Rigormortis",
                    IDs = {
                        Normal = 50068,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Last Word",
                    IDs = {
                        Normal = 50179,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Astrylian's Sutured Cinch",
                    IDs = {
                        Normal = nil,
                        Heroic = 50707,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Professor's Bloodied Smock",
                    IDs = {
                        Normal = nil,
                        Heroic = 50705,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Tiny Abomination in a Jar",
                    IDs = {
                        Normal = nil,
                        Heroic = 50706,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Rigormortis",
                    IDs = {
                        Normal = nil,
                        Heroic = 50704,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Last Word",
                    IDs = {
                        Normal = nil,
                        Heroic = 50708,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = 52027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = 52026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = 52025,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52030,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52029,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52028,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 8. Blood Prince Council
        -------------------------------------------------

        {
            Order = 8,
            Name = "Blood Prince Council",
            NPCID = 37970,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Cerise Coiled Ring",
                    IDs = {
                        Normal = 51381,
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
                    Name = "Heartsick Mender's Cape",
                    IDs = {
                        Normal = 51382,
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
                    Name = "Thrice Fanged Signet",
                    IDs = {
                        Normal = 51024,
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
                    Name = "Bloodsoul Raiment",
                    IDs = {
                        Normal = 51379,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Pale Corpse Boots",
                    IDs = {
                        Normal = 51380,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Taldaram's Soft Slippers",
                    IDs = {
                        Normal = 51023,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Blood-Drinker's Girdle",
                    IDs = {
                        Normal = 51325,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Battle-Maiden's Legguards",
                    IDs = {
                        Normal = 51025,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Spaulders of the Blood Princes",
                    IDs = {
                        Normal = 51383,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Soulbreaker",
                    IDs = {
                        Normal = 51021,
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
                    Name = "Hersir's Greatspear",
                    IDs = {
                        Normal = 51022,
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
                    Name = "Wand of Ruby Claret",
                    IDs = {
                        Normal = 51326,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Cerise Coiled Ring",
                    IDs = {
                        Normal = nil,
                        Heroic = 51849,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Heartsick Mender's Cape",
                    IDs = {
                        Normal = nil,
                        Heroic = 51848,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Thrice Fanged Signet",
                    IDs = {
                        Normal = nil,
                        Heroic = 51855,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bloodsoul Raiment",
                    IDs = {
                        Normal = nil,
                        Heroic = 51851,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Pale Corpse Boots",
                    IDs = {
                        Normal = nil,
                        Heroic = 51850,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Taldaram's Soft Slippers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51856,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Blood-Drinker's Girdle",
                    IDs = {
                        Normal = nil,
                        Heroic = 51853,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Battle-Maiden's Legguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 51854,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Spaulders of the Blood Princes",
                    IDs = {
                        Normal = nil,
                        Heroic = 51847,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Soulbreaker",
                    IDs = {
                        Normal = nil,
                        Heroic = 51858,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Hersir's Greatspear",
                    IDs = {
                        Normal = nil,
                        Heroic = 51857,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Wand of Ruby Claret",
                    IDs = {
                        Normal = nil,
                        Heroic = 51852,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Incarnadine Band of Mending",
                    IDs = {
                        Normal = 50174,
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
                    Name = "Royal Crimson Cloak",
                    IDs = {
                        Normal = 50074,
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
                    Name = "Valanar's Other Signet Ring",
                    IDs = {
                        Normal = 50170,
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
                    Name = "Sanguine Silk Robes",
                    IDs = {
                        Normal = 50172,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "San'layn Ritualist Gloves",
                    IDs = {
                        Normal = 50176,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Geistlord's Punishment Sack",
                    IDs = {
                        Normal = 50073,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Shoulders of Frost-Tipped Thorns",
                    IDs = {
                        Normal = 50171,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Mail of Crimson Coins",
                    IDs = {
                        Normal = 50177,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Treads of the Wasteland",
                    IDs = {
                        Normal = 50071,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Crypt Keeper's Bracers",
                    IDs = {
                        Normal = 50175,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Landsoul's Horned Greathelm",
                    IDs = {
                        Normal = 50072,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Taldaram's Plated Fists",
                    IDs = {
                        Normal = 50075,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Keleseth's Seducer",
                    IDs = {
                        Normal = 50184,
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
                    Name = "Shadow Silk Spindle",
                    IDs = {
                        Normal = 50173,
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
                    Name = "Cryptmaker",
                    IDs = {
                        Normal = 49919,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Incarnadine Band of Mending",
                    IDs = {
                        Normal = nil,
                        Heroic = 50720,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Royal Crimson Cloak",
                    IDs = {
                        Normal = nil,
                        Heroic = 50718,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Valanar's Other Signet Ring",
                    IDs = {
                        Normal = nil,
                        Heroic = 50714,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Sanguine Silk Robes",
                    IDs = {
                        Normal = nil,
                        Heroic = 50717,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "San'layn Ritualist Gloves",
                    IDs = {
                        Normal = nil,
                        Heroic = 50722,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Geistlord's Punishment Sack",
                    IDs = {
                        Normal = nil,
                        Heroic = 50713,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Shoulders of Frost-Tipped Thorns",
                    IDs = {
                        Normal = nil,
                        Heroic = 50715,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Mail of Crimson Coins",
                    IDs = {
                        Normal = nil,
                        Heroic = 50723,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Treads of the Wasteland",
                    IDs = {
                        Normal = nil,
                        Heroic = 50711,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Crypt Keeper's Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 50721,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Landsoul's Horned Greathelm",
                    IDs = {
                        Normal = nil,
                        Heroic = 50712,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Taldaram's Plated Fists",
                    IDs = {
                        Normal = nil,
                        Heroic = 50716,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Keleseth's Seducer",
                    IDs = {
                        Normal = nil,
                        Heroic = 50710,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Shadow Silk Spindle",
                    IDs = {
                        Normal = nil,
                        Heroic = 50719,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Cryptmaker",
                    IDs = {
                        Normal = nil,
                        Heroic = 50603,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },

        -------------------------------------------------
        -- 9. Blood-Queen Lana'thel
        -------------------------------------------------

        {
            Order = 9,
            Name = "Blood-Queen Lana'thel",
            NPCID = 37955,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Collar of Haughty Disdain",
                    IDs = {
                        Normal = 51548,
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
                    Name = "Seal of the Twilight Queen",
                    IDs = {
                        Normal = 51387,
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
                    Name = "Cowl of Malefic Repose",
                    IDs = {
                        Normal = 51554,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Ivory-Inlaid Leggings",
                    IDs = {
                        Normal = 51550,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Shoulderpads of the Searing Kiss",
                    IDs = {
                        Normal = 51552,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Chestguard of Siphoned Elements",
                    IDs = {
                        Normal = 51551,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Throatrender Handguards",
                    IDs = {
                        Normal = 51386,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Tightening Waistband",
                    IDs = {
                        Normal = 51555,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Veincrusher Gauntlets",
                    IDs = {
                        Normal = 51556,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Bloodsipper",
                    IDs = {
                        Normal = 51384,
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
                    Name = "Lana'thel's Bloody Nail",
                    IDs = {
                        Normal = 51553,
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
                    Name = "Stakethrower",
                    IDs = {
                        Normal = 51385,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Collar of Haughty Disdain",
                    IDs = {
                        Normal = nil,
                        Heroic = 51842,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Seal of the Twilight Queen",
                    IDs = {
                        Normal = nil,
                        Heroic = 51843,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Cowl of Malefic Repose",
                    IDs = {
                        Normal = nil,
                        Heroic = 51837,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Ivory-Inlaid Leggings",
                    IDs = {
                        Normal = nil,
                        Heroic = 51841,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Shoulderpads of the Searing Kiss",
                    IDs = {
                        Normal = nil,
                        Heroic = 51839,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Chestguard of Siphoned Elements",
                    IDs = {
                        Normal = nil,
                        Heroic = 51840,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Throatrender Handguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 51844,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Tightening Waistband",
                    IDs = {
                        Normal = nil,
                        Heroic = 51836,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Veincrusher Gauntlets",
                    IDs = {
                        Normal = nil,
                        Heroic = 51835,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bloodsipper",
                    IDs = {
                        Normal = nil,
                        Heroic = 51846,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Lana'thel's Bloody Nail",
                    IDs = {
                        Normal = nil,
                        Heroic = 51838,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Stakethrower",
                    IDs = {
                        Normal = nil,
                        Heroic = 51845,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Blood Queen's Crimson Choker",
                    IDs = {
                        Normal = 50182,
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
                    Name = "Lana'thel's Chain of Flagellation",
                    IDs = {
                        Normal = 50180,
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
                    Name = "Icecrown Glacial Wall",
                    IDs = {
                        Normal = 50065,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Bauble of True Blood",
                    IDs = {
                        Normal = 50354,
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
                    Name = "Bloodfall",
                    IDs = {
                        Normal = 50178,
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
                    Name = "Dying Light",
                    IDs = {
                        Normal = 50181,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                ------------
                -- 25 Heroic
                ------------
                {
                    Name = "Blood Queen's Crimson Choker",
                    IDs = {
                        Normal = nil,
                        Heroic = 50724,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Lana'thel's Chain of Flagellation",
                    IDs = {
                        Normal = nil,
                        Heroic = 50728,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Icecrown Glacial Wall",
                    IDs = {
                        Normal = nil,
                        Heroic = 50729,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bauble of True Blood",
                    IDs = {
                        Normal = nil,
                        Heroic = 50726,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bloodfall",
                    IDs = {
                        Normal = nil,
                        Heroic = 50727,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Dying Light",
                    IDs = {
                        Normal = nil,
                        Heroic = 50725,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = 52027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = 52026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = 52025,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52030,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52029,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52028,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 10. Valithria Dreamwalker
        -------------------------------------------------

        {
            Order = 10,
            Name = "Valithria Dreamwalker",
            NPCID = 36789,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Lich Wrappings",
                    IDs = {
                        Normal = 51584,
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
                    Name = "Leggings of the Refracted Mind",
                    IDs = {
                        Normal = 51777,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Sister Svalna's Spangenhelm",
                    IDs = {
                        Normal = 51585,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Skinned Whelp Shoulders",
                    IDs = {
                        Normal = 51565,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Stormbringer Gloves",
                    IDs = {
                        Normal = 51583,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Legguards of the Twisted Dream",
                    IDs = {
                        Normal = 51566,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Emerald Saint's Spaulders",
                    IDs = {
                        Normal = 51586,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Taiga Bindings",
                    IDs = {
                        Normal = 51563,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Ironrope Belt of Ymirjar",
                    IDs = {
                        Normal = 51564,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Oxheart",
                    IDs = {
                        Normal = 51562,
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
                    Name = "Sister Svalna's Aether Staff",
                    IDs = {
                        Normal = 51582,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Staff",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Dreamhunter's Carbine",
                    IDs = {
                        Normal = 51561,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Lich Wrappings",
                    IDs = {
                        Normal = nil,
                        Heroic = 51826,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Leggings of the Refracted Mind",
                    IDs = {
                        Normal = nil,
                        Heroic = 51823,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Sister Svalna's Spangenhelm",
                    IDs = {
                        Normal = nil,
                        Heroic = 51825,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Skinned Whelp Shoulders",
                    IDs = {
                        Normal = nil,
                        Heroic = 51830,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Stormbringer Gloves",
                    IDs = {
                        Normal = nil,
                        Heroic = 51827,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Legguards of the Twisted Dream",
                    IDs = {
                        Normal = nil,
                        Heroic = 51829,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Emerald Saint's Spaulders",
                    IDs = {
                        Normal = nil,
                        Heroic = 51824,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Taiga Bindings",
                    IDs = {
                        Normal = nil,
                        Heroic = 51832,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Ironrope Belt of Ymirjar",
                    IDs = {
                        Normal = nil,
                        Heroic = 51831,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Oxheart",
                    IDs = {
                        Normal = nil,
                        Heroic = 51833,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Sister Svalna's Aether Staff",
                    IDs = {
                        Normal = nil,
                        Heroic = 51828,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Dreamhunter's Carbine",
                    IDs = {
                        Normal = nil,
                        Heroic = 51834,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Devium's Eternally Cold Ring",
                    IDs = {
                        Normal = 50185,
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
                    Name = "Frostbinder's Shredded Cape",
                    IDs = {
                        Normal = 50205,
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
                    Name = "Frostbrood Sapphire Ring",
                    IDs = {
                        Normal = 50186,
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
                    Name = "Noose of Malachite",
                    IDs = {
                        Normal = 50195,
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
                    Name = "Robe of the Waking Nightmare",
                    IDs = {
                        Normal = 50418,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Bracers of Eternal Dreaming",
                    IDs = {
                        Normal = 50417,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Anub'ar Stalker's Gloves",
                    IDs = {
                        Normal = 50188,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Snowstorm Helm",
                    IDs = {
                        Normal = 50202,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Boots of the Funeral March",
                    IDs = {
                        Normal = 50416,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Coldwraith Links",
                    IDs = {
                        Normal = 50187,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Grinning Skull Greatboots",
                    IDs = {
                        Normal = 50190,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Leggings of Dying Candles",
                    IDs = {
                        Normal = 50199,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Scourge Reaver's Legplates",
                    IDs = {
                        Normal = 50192,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Lungbreaker",
                    IDs = {
                        Normal = 50183,
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
                    Name = "Nightmare Ender",
                    IDs = {
                        Normal = 50472,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Devium's Eternally Cold Ring",
                    IDs = {
                        Normal = nil,
                        Heroic = 50622,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Frostbinder's Shredded Cape",
                    IDs = {
                        Normal = nil,
                        Heroic = 50628,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Frostbrood Sapphire Ring",
                    IDs = {
                        Normal = nil,
                        Heroic = 50618,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Noose of Malachite",
                    IDs = {
                        Normal = nil,
                        Heroic = 50627,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Robe of the Waking Nightmare",
                    IDs = {
                        Normal = nil,
                        Heroic = 50629,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bracers of Eternal Dreaming",
                    IDs = {
                        Normal = nil,
                        Heroic = 50630,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Anub'ar Stalker's Gloves",
                    IDs = {
                        Normal = nil,
                        Heroic = 50619,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Snowstorm Helm",
                    IDs = {
                        Normal = nil,
                        Heroic = 50626,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Boots of the Funeral March",
                    IDs = {
                        Normal = nil,
                        Heroic = 50632,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Coldwraith Links",
                    IDs = {
                        Normal = nil,
                        Heroic = 50620,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Grinning Skull Greatboots",
                    IDs = {
                        Normal = nil,
                        Heroic = 50625,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Leggings of Dying Candles",
                    IDs = {
                        Normal = nil,
                        Heroic = 50623,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Scourge Reaver's Legplates",
                    IDs = {
                        Normal = nil,
                        Heroic = 50624,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Lungbreaker",
                    IDs = {
                        Normal = nil,
                        Heroic = 50621,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Nightmare Ender",
                    IDs = {
                        Normal = nil,
                        Heroic = 50631,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },

        -------------------------------------------------
        -- 11. Sindragosa
        -------------------------------------------------

        {
            Order = 11,
            Name = "Sindragosa",
            NPCID = 36853,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Rimetooth Pendant",
                    IDs = {
                        Normal = 51779,
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
                    Name = "Robes of Azure Downfall",
                    IDs = {
                        Normal = 51790,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Icicle Shapers",
                    IDs = {
                        Normal = 51789,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Vambraces of the Frost Wyrm Queen",
                    IDs = {
                        Normal = 51783,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },
                    Difficulty = "10",

                {
                    Name = "Shoulderguards of Crystalline Bone",
                    IDs = {
                        Normal = 51792,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Wyrmwing Treads",
                    IDs = {
                        Normal = 51785,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Etched Dragonbone Girdle",
                    IDs = {
                        Normal = 51782,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Legplates of Aetheric Strife",
                    IDs = {
                        Normal = 51786,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Scourge Fanged Stompers",
                    IDs = {
                        Normal = 51787,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Lost Pavise of the Blue Flight",
                    IDs = {
                        Normal = 51791,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Bleak Coldarra Carver",
                    IDs = {
                        Normal = 51788,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Splintershard",
                    IDs = {
                        Normal = 51784,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Fist Weapon",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Rimetooth Pendant",
                    IDs = {
                        Normal = nil,
                        Heroic = 51822,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Robes of Azure Downfall",
                    IDs = {
                        Normal = nil,
                        Heroic = 51813,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Icicle Shapers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51814,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Vambraces of the Frost Wyrm Queen",
                    IDs = {
                        Normal = nil,
                        Heroic = 51820,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Shoulderguards of Crystalline Bone",
                    IDs = {
                        Normal = nil,
                        Heroic = 51811,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Wyrmwing Treads",
                    IDs = {
                        Normal = nil,
                        Heroic = 51818,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Etched Dragonbone Girdle",
                    IDs = {
                        Normal = nil,
                        Heroic = 51821,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Legplates of Aetheric Strife",
                    IDs = {
                        Normal = nil,
                        Heroic = 51817,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Scourge Fanged Stompers",
                    IDs = {
                        Normal = nil,
                        Heroic = 51816,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Lost Pavise of the Blue Flight",
                    IDs = {
                        Normal = nil,
                        Heroic = 51812,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bleak Coldarra Carver",
                    IDs = {
                        Normal = nil,
                        Heroic = 51815,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Splintershard",
                    IDs = {
                        Normal = nil,
                        Heroic = 51819,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Memory of Malygos",
                    IDs = {
                        Normal = 50424,
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
                    Name = "Sindragosa's Cruel Claw",
                    IDs = {
                        Normal = 50421,
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
                    Name = "Phylactery of the Nameless Lich",
                    IDs = {
                        Normal = 50360,
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
                    Name = "Sindragosa's Flawless Fang",
                    IDs = {
                        Normal = 50361,
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
                    Name = "Sundial of Eternal Dusk",
                    IDs = {
                        Normal = 50423,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                
                {
                    Name = "Memory of Malygos",
                    IDs = {
                        Normal = nil,
                        Heroic = 50636,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Sindragosa's Cruel Claw",
                    IDs = {
                        Normal = nil,
                        Heroic = 50633,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Phylactery of the Nameless Lich",
                    IDs = {
                        Normal = nil,
                        Heroic = 50365,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Sindragosa's Flawless Fang",
                    IDs = {
                        Normal = nil,
                        Heroic = 50364,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Sundial of Eternal Dusk",
                    IDs = {
                        Normal = nil,
                        Heroic = 50635,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = 52027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = 52026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = 52025,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52030,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52029,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52028,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 12. The Lich King
        -------------------------------------------------

        {
            Order = 12,
            Name = "The Lich King",
            NPCID = 36597,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Pugius, Fist of Defiance",
                    IDs = {
                        Normal = 51801,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Tel'thas, Dagger of the Blood King",
                    IDs = {
                        Normal = 51803,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Valius, Gavel of the Lightbringer",
                    IDs = {
                        Normal = 51798,
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
                    Name = "Stormfury, Black Blade of the Betrayer",
                    IDs = {
                        Normal = 51800,
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
                    Name = "Troggbane, Axe of the Frostborne King",
                    IDs = {
                        Normal = 51795,
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
                    Name = "Halion, Staff of Forgotten Love",
                    IDs = {
                        Normal = 51799,
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
                    Name = "Tainted Twig of Nordrassil",
                    IDs = {
                        Normal = 51797,
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
                    Name = "Warmace of Menethil",
                    IDs = {
                        Normal = 51796,
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
                    Name = "Windrunner's Heartseeker",
                    IDs = {
                        Normal = 51802,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Pugius, Fist of Defiance",
                    IDs = {
                        Normal = nil,
                        Heroic = 51941,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Tel'thas, Dagger of the Blood King",
                    IDs = {
                        Normal = nil,
                        Heroic = 51939,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Valius, Gavel of the Lightbringer",
                    IDs = {
                        Normal = nil,
                        Heroic = 51944,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Stormfury, Black Blade of the Betrayer",
                    IDs = {
                        Normal = nil,
                        Heroic = 51942,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Troggbane, Axe of the Frostborne King",
                    IDs = {
                        Normal = nil,
                        Heroic = 51947,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Halion, Staff of Forgotten Love",
                    IDs = {
                        Normal = nil,
                        Heroic = 51943,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Tainted Twig of Nordrassil",
                    IDs = {
                        Normal = nil,
                        Heroic = 51945,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Warmace of Menethil",
                    IDs = {
                        Normal = nil,
                        Heroic = 51946,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Windrunner's Heartseeker",
                    IDs = {
                        Normal = nil,
                        Heroic = 51940,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Bloodsurge, Kel'Thuzad's Blade of Agony",
                    IDs = {
                        Normal = 50427,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Royal Scepter of Terenas II",
                    IDs = {
                        Normal = 50428,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Havoc's Call, Blade of Lordaeron Kings",
                    IDs = {
                        Normal = 50012,
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
                    Name = "Heaven's Fall, Kryss of a Thousand Lies",
                    IDs = {
                        Normal = 50426,
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
                    Name = "Mithrios, Bronzebeard's Legacy",
                    IDs = {
                        Normal = 49997,
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
                    Name = "Archus, Greatstaff of Antonidas",
                    IDs = {
                        Normal = 50429,
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
                    Name = "Glorenzelg, High-Blade of the Silver Hand",
                    IDs = {
                        Normal = 50070,
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
                    Name = "Oathbinder, Charge of the Ranger-General",
                    IDs = {
                        Normal = 50425,
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
                    Name = "Fal'inrush, Defender of Quel'thalas",
                    IDs = {
                        Normal = 49981,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Bloodsurge, Kel'Thuzad's Blade of Agony",
                    IDs = {
                        Normal = nil,
                        Heroic = 50732,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Royal Scepter of Terenas II",
                    IDs = {
                        Normal = nil,
                        Heroic = 50734,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Havoc's Call, Blade of Lordaeron Kings",
                    IDs = {
                        Normal = nil,
                        Heroic = 50737,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Heaven's Fall, Kryss of a Thousand Lies",
                    IDs = {
                        Normal = nil,
                        Heroic = 50736,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Mithrios, Bronzebeard's Legacy",
                    IDs = {
                        Normal = nil,
                        Heroic = 50738,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Archus, Greatstaff of Antonidas",
                    IDs = {
                        Normal = nil,
                        Heroic = 50731,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Glorenzelg, High-Blade of the Silver Hand",
                    IDs = {
                        Normal = nil,
                        Heroic = 50730,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Oathbinder, Charge of the Ranger-General",
                    IDs = {
                        Normal = nil,
                        Heroic = 50735,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Fal'inrush, Defender of Quel'thalas",
                    IDs = {
                        Normal = nil,
                        Heroic = 50733,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Invincible's Reins",
                    IDs = {
                        Normal = nil,
                        Heroic = 50818,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = 52027,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = 52026,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = 52025,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10 Heroic"] = true,
                        ["25"] = true,
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Conqueror's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52030,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Protector's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52029,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },

                {
                    Name = "Vanquisher's Mark of Sanctification",
                    IDs = {
                        Normal = nil,
                        Heroic = 52028,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25 Heroic"] = true,
                    },
                },
            },
        },
    },

    -------------------------------------------------
    -- Trash
    -------------------------------------------------

    Trash = {
        {
            Name = "Wodin's Lucky Necklace",
            IDs = {
                Normal = 50452,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Neck",
            Token = false,
            Classes = nil,
            Notes = nil,

            AvailableIn = {
                ["10"] = true,
                ["10 Heroic"] = true,
                ["25"] = true,
                ["25 Heroic"] = true,
            },
        },

        {
            Name = "Harbinger's Bone Band",
            IDs = {
                Normal = 50447,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Finger",
            Token = false,
            Classes = nil,
            Notes = nil,

            AvailableIn = {
                ["10"] = true,
                ["10 Heroic"] = true,
                ["25"] = true,
                ["25 Heroic"] = true,
            },
        },

        {
            Name = "Ring of Rotting Sinew",
            IDs = {
                Normal = 50453,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Finger",
            Token = false,
            Classes = nil,
            Notes = nil,

            AvailableIn = {
                ["10"] = true,
                ["10 Heroic"] = true,
                ["25"] = true,
                ["25 Heroic"] = true,
            },
        },

        {
            Name = "Stiffened Corpse Shoulderpads",
            IDs = {
                Normal = 50449,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Shoulder",
            Token = false,
            Classes = nil,
            Notes = nil,

            AvailableIn = {
                ["10"] = true,
                ["10 Heroic"] = true,
                ["25"] = true,
                ["25 Heroic"] = true,
            },
        },

        {
            Name = "Leggings of Dubious Charms",
            IDs = {
                Normal = 50450,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Legs",
            Token = false,
            Classes = nil,
            Notes = nil,

            AvailableIn = {
                ["10"] = true,
                ["10 Heroic"] = true,
                ["25"] = true,
                ["25 Heroic"] = true,
            },
        },

        {
            Name = "Belt of the Lonely Noble",
            IDs = {
                Normal = 50451,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Waist",
            Token = false,
            Classes = nil,
            Notes = nil,
            AvailableIn = {
                ["10"] = true,
                ["10 Heroic"] = true,
                ["25"] = true,
                ["25 Heroic"] = true,
            },
        },

        {
            Name = "Rowan's Rifle of Silver Bullets",
            IDs = {
                Normal = 50444,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Ranged",
            Token = false,
            Classes = nil,
            Notes = nil,
            AvailableIn = {
                ["10"] = true,
                ["10 Heroic"] = true,
                ["25"] = true,
                ["25 Heroic"] = true,
            },
        },
    },
}

ImpLoot.Database:RegisterRaid(ICC)