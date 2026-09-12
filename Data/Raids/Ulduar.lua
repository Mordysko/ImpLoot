-------------------------------------------------
-- Ulduar
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
-------------------------------------------------

local ULD = {

    Name = "Ulduar",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "25",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Flame Leviathan
        -------------------------------------------------

        {
            Order = 1,
            Name = "Flame Leviathan",
            NPCID = 33113,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Might of the Leviathan",
                    IDs = {
                        Normal = 45385,
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
                    Name = "Lifespark Visage",
                    IDs = {
                        Normal = 45289,
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
                    Name = "Combustion Bracers",
                    IDs = {
                        Normal = 45291,
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
                    Name = "Firestrider Chestguard",
                    IDs = {
                        Normal = 45288,
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
                    Name = "Firesoul",
                    IDs = {
                        Normal = 45287,
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
                    Name = "Kinetic Ripper",
                    IDs = {
                        Normal = 45284,
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
                    Name = "Flamewatch Armguards",
                    IDs = {
                        Normal = 45283,
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
                    Name = "Twirling Blades",
                    IDs = {
                        Normal = 45296,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Thrown",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                {
                    Name = "Energy Siphon",
                    IDs = {
                        Normal = 45292,
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
                    Name = "Pyrite Infuser",
                    IDs = {
                        Normal = 45286,
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
                    Name = "Ironsoul",
                    IDs = {
                        Normal = 45282,
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
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Shimmering Seal",
                    IDs = {
                        Normal = nil,
                        Heroic = 45297,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Handguards of Potent Cures",
                    IDs = {
                        Normal = nil,
                        Heroic = 45293,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Mantle of Fiery Vengeance",
                    IDs = {
                        Normal = nil,
                        Heroic = 45300,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Gilded Steel Legplates",
                    IDs = {
                        Normal = nil,
                        Heroic = 45295,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Freya's Choker of Warding",
                    IDs = {
                        Normal = 45116,
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
                    Name = "Steamcaller's Totem",
                    IDs = {
                        Normal = 45114,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Glowing Ring of Reclamation",
                    IDs = {
                        Normal = 45113,
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
                    Name = "Strength of the Automaton",
                    IDs = {
                        Normal = 45106,
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
                    Name = "The Leviathan's Coil",
                    IDs = {
                        Normal = 45112,
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
                    Name = "Boots of Fiery Resolution",
                    IDs = {
                        Normal = 45135,
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
                    Name = "Constructor's Handwraps",
                    IDs = {
                        Normal = 45117,
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
                    Name = "Embrace of the Leviathan",
                    IDs = {
                        Normal = 45119,
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
                    Name = "Mechanist's Bindings",
                    IDs = {
                        Normal = 45108,
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
                    Name = "Gloves of the Fiery Behemoth",
                    IDs = {
                        Normal = 45109,
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
                    Name = "Steamworker's Goggles",
                    IDs = {
                        Normal = 45118,
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
                    Name = "Leviathan Fueling Manual",
                    IDs = {
                        Normal = 45115,
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
                    Name = "Titanguard",
                    IDs = {
                        Normal = 45110,
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
                    Name = "Iron Riveted War Helm",
                    IDs = {
                        Normal = 45107,
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
                    Name = "Mimiron's Inferno Couplings",
                    IDs = {
                        Normal = 45111,
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
                    Name = "Rising Sun",
                    IDs = {
                        Normal = 45086,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Thrown",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Hard Mode
                -------------------------------------------------
                {
                    Name = "Pendant of Fiery Havoc",
                    IDs = {
                        Normal = nil,
                        Heroic = 45133,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Shoulderpads of Dormant Energies",
                    IDs = {
                        Normal = nil,
                        Heroic = 45136,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Golden Saronite Dragon",
                    IDs = {
                        Normal = nil,
                        Heroic = 45132,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Plated Leggings of Ruination",
                    IDs = {
                        Normal = nil,
                        Heroic = 45134,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },
            },
        },

        -------------------------------------------------
        -- 2. Ignis the Furnace Master
        -------------------------------------------------

        {
            Order = 2,
            Name = "Ignis the Furnace Master",
            NPCID = 33118,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Drape of Fuming Anger",
                    IDs = {
                        Normal = 45318,
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
                    Name = "Shawl of the Caretaker",
                    IDs = {
                        Normal = 45317,
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
                    Name = "Gloves of Smoldering Touch",
                    IDs = {
                        Normal = 45312,
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
                    Name = "Armbraces of the Vibrant Flame",
                    IDs = {
                        Normal = 45316,
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
                    Name = "Igniter Rod",
                    IDs = {
                        Normal = 45314,
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
                    Name = "Gauntlets of the Iron Furnace",
                    IDs = {
                        Normal = 45310,
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
                    Name = "Pauldrons of Tempered Will",
                    IDs = {
                        Normal = 45321,
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
                    Name = "Rifle of the Platinum Guard",
                    IDs = {
                        Normal = 45309,
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
                    Name = "Furnace Stone",
                    IDs = {
                        Normal = 45313,
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
                    Name = "Relentless Edge",
                    IDs = {
                        Normal = 45311,
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
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Totem of the Dancing Flame",
                    IDs = {
                        Normal = 45169,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Cindershard Ring",
                    IDs = {
                        Normal = 45157,
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
                    Name = "Pyrelight Circle",
                    IDs = {
                        Normal = 45168,
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
                    Name = "Soot-Covered Mantle",
                    IDs = {
                        Normal = 45186,
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
                    Name = "Flamestalker Boots",
                    IDs = {
                        Normal = 45162,
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
                    Name = "Flamewrought Cinch",
                    IDs = {
                        Normal = 45185,
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
                    Name = "Helm of the Furnace Master",
                    IDs = {
                        Normal = 45164,
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
                    Name = "Wristguards of the Firetender",
                    IDs = {
                        Normal = 45187,
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
                    Name = "Lifeforge Breastplate",
                    IDs = {
                        Normal = 45167,
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
                    Name = "Charred Saronite Greaves",
                    IDs = {
                        Normal = 45166,
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
                    Name = "Girdle of Embers",
                    IDs = {
                        Normal = 45161,
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
                    Name = "Scepter of Creation",
                    IDs = {
                        Normal = 45170,
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
                    Name = "Heart of Iron",
                    IDs = {
                        Normal = 45158,
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
                    Name = "Worldcarver",
                    IDs = {
                        Normal = 45165,
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
                    Name = "Intensity",
                    IDs = {
                        Normal = 45171,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },
            },
        },

        -------------------------------------------------
        -- 3. Razorscale
        -------------------------------------------------

        {
            Order = 3,
            Name = "Razorscale",
            NPCID = 33186,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Band of Draconic Guile",
                    IDs = {
                        Normal = 45303,
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
                    Name = "Binding of the Dragon Matriarch",
                    IDs = {
                        Normal = 45306,
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
                    Name = "Treads of the Invader",
                    IDs = {
                        Normal = 45302,
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
                    Name = "Ironscale Leggings",
                    IDs = {
                        Normal = 45307,
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
                    Name = "Bracers of the Smothering Inferno",
                    IDs = {
                        Normal = 45301,
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
                    Name = "Razorscale Talon",
                    IDs = {
                        Normal = 45298,
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
                    Name = "Breastplate of the Afterlife",
                    IDs = {
                        Normal = 45305,
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
                    Name = "Dragonsteel Faceplate",
                    IDs = {
                        Normal = 45299,
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
                    Name = "Stormtempered Girdle",
                    IDs = {
                        Normal = 45304,
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
                    Name = "Eye of the Broodmother",
                    IDs = {
                        Normal = 45308,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Drape of the Drakerider",
                    IDs = {
                        Normal = 45138,
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
                    Name = "Libram of Discord",
                    IDs = {
                        Normal = 45510,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Sigil of Deflection",
                    IDs = {
                        Normal = 45144,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Collar of the Wyrmhunter",
                    IDs = {
                        Normal = 45150,
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
                    Name = "Shackles of the Odalisque",
                    IDs = {
                        Normal = 45146,
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
                    Name = "Proto-hide Leggings",
                    IDs = {
                        Normal = 45141,
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
                    Name = "Bracers of the Broodmother",
                    IDs = {
                        Normal = 45149,
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
                    Name = "Saronite Mesh Legguards",
                    IDs = {
                        Normal = 45143,
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
                    Name = "Belt of the Fallen Wyrm",
                    IDs = {
                        Normal = 45151,
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
                    Name = "Guiding Star",
                    IDs = {
                        Normal = 45147,
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
                    Name = "Remorse",
                    IDs = {
                        Normal = 45142,
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
                    Name = "Razorscale Shoulderguards",
                    IDs = {
                        Normal = 45140,
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
                    Name = "Dragonslayer's Brace",
                    IDs = {
                        Normal = 45139,
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
                    Name = "Veranus' Bane",
                    IDs = {
                        Normal = 45137,
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
                    Name = "Living Flame",
                    IDs = {
                        Normal = 45148,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },
            },
        },

        -------------------------------------------------
        -- 4. XT-002 Deconstructor
        -------------------------------------------------

        {
            Order = 4,
            Name = "XT-002 Deconstructor",
            NPCID = 33293,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Power Enhancing Loop",
                    IDs = {
                        Normal = 45675,
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
                    Name = "Conductive Cord",
                    IDs = {
                        Normal = 45694,
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
                    Name = "Vest of the Glowing Crescent",
                    IDs = {
                        Normal = 45686,
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
                    Name = "Treacherous Shoulderpads",
                    IDs = {
                        Normal = 45677,
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
                    Name = "Gloves of Taut Grip",
                    IDs = {
                        Normal = 45679,
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
                    Name = "Helm of Veiled Energies",
                    IDs = {
                        Normal = 45687,
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
                    Name = "Plasma Foil",
                    IDs = {
                        Normal = 45685,
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
                    Name = "Pulsing Spellshield",
                    IDs = {
                        Normal = 45682,
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
                    Name = "Chestplate of Vicious Potency",
                    IDs = {
                        Normal = 45676,
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
                    Name = "Armbands of the Construct",
                    IDs = {
                        Normal = 45680,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Seal of Ulduar",
                    IDs = {
                        Normal = nil,
                        Heroic = 45871,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Fluxing Energy Coils",
                    IDs = {
                        Normal = nil,
                        Heroic = 45869,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Breastplate of the Stoneshaper",
                    IDs = {
                        Normal = nil,
                        Heroic = 45867,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Magnetized Projectile Emitter",
                    IDs = {
                        Normal = nil,
                        Heroic = 45870,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Aesir's Edge",
                    IDs = {
                        Normal = nil,
                        Heroic = 45868,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Sigil of the Vengeful Heart",
                    IDs = {
                        Normal = 45254,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Thunderfall Totem",
                    IDs = {
                        Normal = 45255,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Crazed Construct Ring",
                    IDs = {
                        Normal = 45250,
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
                    Name = "Signet of the Earthshaker",
                    IDs = {
                        Normal = 45247,
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
                    Name = "Sandals of Rash Temperament",
                    IDs = {
                        Normal = 45258,
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
                    Name = "Mantle of Wavering Calm",
                    IDs = {
                        Normal = 45253,
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
                    Name = "Boots of Hasty Revival",
                    IDs = {
                        Normal = 45260,
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
                    Name = "Quartz-studded Harness",
                    IDs = {
                        Normal = 45259,
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
                    Name = "Brass-lined Boots",
                    IDs = {
                        Normal = 45249,
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
                    Name = "Golem-Shard Sticker",
                    IDs = {
                        Normal = 45246,
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
                    Name = "Clockwork Legplates",
                    IDs = {
                        Normal = 45248,
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
                    Name = "Shoulderplates of the Deconstructor",
                    IDs = {
                        Normal = 45251,
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
                    Name = "Horologist's Wristguards",
                    IDs = {
                        Normal = 45252,
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
                    Name = "Quartz Crystal Wand",
                    IDs = {
                        Normal = 45257,
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
                    Name = "Twisted Visage",
                    IDs = {
                        Normal = 45256,
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
                -- 25 Hard Mode
                -------------------------------------------------
                {
                    Name = "Charm of Meticulous Timing",
                    IDs = {
                        Normal = nil,
                        Heroic = 45443,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Grasps of Reason",
                    IDs = {
                        Normal = nil,
                        Heroic = 45446,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Gloves of the Steady Hand",
                    IDs = {
                        Normal = nil,
                        Heroic = 45444,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Sorthalis, Hammer of the Watchers",
                    IDs = {
                        Normal = nil,
                        Heroic = 45442,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Breastplate of the Devoted",
                    IDs = {
                        Normal = nil,
                        Heroic = 45445,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },
            },
        },

        -------------------------------------------------
        -- 5. Assembly of Iron
        -------------------------------------------------

        {
            Order = 5,
            Name = "Assembly of Iron",
            NPCID = 32867,

            Loot = {
                
                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Cloak of the Iron Council",
                    IDs = {
                        Normal = 45322,
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
                    Name = "Watchful Eye of Fate",
                    IDs = {
                        Normal = 45447,
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
                    Name = "Lady Maye's Sapphire Ring",
                    IDs = {
                        Normal = 45418,
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
                    Name = "Runetouch Wristwraps",
                    IDs = {
                        Normal = 45423,
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
                    Name = "Boots of the Petrified Forest",
                    IDs = {
                        Normal = 45378,
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
                    Name = "Leggings of Swift Reflexes",
                    IDs = {
                        Normal = 45324,
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
                    Name = "Belt of the Crystal Tree",
                    IDs = {
                        Normal = 45455,
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
                    Name = "Circlet of True Sight",
                    IDs = {
                        Normal = 45329,
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
                    Name = "Belt of the Iron Servant",
                    IDs = {
                        Normal = 45333,
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
                    Name = "Stormtip",
                    IDs = {
                        Normal = 45332,
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
                    Name = "Rune-Etched Nightblade",
                    IDs = {
                        Normal = 45331,
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
                    Name = "Greaves of Iron Intensity",
                    IDs = {
                        Normal = 45330,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Loop of the Agile",
                    IDs = {
                        Normal = nil,
                        Heroic = 45456,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "The Masticator",
                    IDs = {
                        Normal = nil,
                        Heroic = 45449,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Perilous Bite",
                    IDs = {
                        Normal = nil,
                        Heroic = 45448,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Archivum Data Disc",
                    IDs = {
                        Normal = nil,
                        Heroic = 45506,
                    },
                    Quality = 4,
                    Slot = "Quest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Drape of the Lithe",
                    IDs = {
                        Normal = 45224,
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
                    Name = "Insurmountable Fervor",
                    IDs = {
                        Normal = 45193,
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
                    Name = "Unblinking Eye",
                    IDs = {
                        Normal = 45236,
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
                    Name = "Radiant Seal",
                    IDs = {
                        Normal = 45235,
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
                    Name = "Raiments of the Iron Council",
                    IDs = {
                        Normal = 45240,
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
                    Name = "Overload Legwraps",
                    IDs = {
                        Normal = 45238,
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
                    Name = "Phaelia's Vestments of the Sprouting Seed",
                    IDs = {
                        Normal = 45237,
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
                    Name = "Runed Ironhide Boots",
                    IDs = {
                        Normal = 45232,
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
                    Name = "Greaves of Swift Vengeance",
                    IDs = {
                        Normal = 45244,
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
                    Name = "Runeshaper's Gloves",
                    IDs = {
                        Normal = 45239,
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
                    Name = "Iron-studded Mantle",
                    IDs = {
                        Normal = 45227,
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
                    Name = "Fang of Oblivion",
                    IDs = {
                        Normal = 45607,
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
                    Name = "Steelbreaker's Embrace",
                    IDs = {
                        Normal = 45225,
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
                    Name = "Handguards of the Enclave",
                    IDs = {
                        Normal = 45228,
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
                    Name = "Ancient Iron Heaume",
                    IDs = {
                        Normal = 45226,
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
                    Name = "Rapture",
                    IDs = {
                        Normal = 45234,
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
                    Name = "Stormrune Edge",
                    IDs = {
                        Normal = 45233,
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
                -- 25 Hard Mode
                -------------------------------------------------
                {
                    Name = "Drape of Mortal Downfall",
                    IDs = {
                        Normal = nil,
                        Heroic = 45242,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Sapphire Amulet of Renewal",
                    IDs = {
                        Normal = nil,
                        Heroic = 45243,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Shoulderpads of the Intruder",
                    IDs = {
                        Normal = nil,
                        Heroic = 45245,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Belt of Colossal Rage",
                    IDs = {
                        Normal = nil,
                        Heroic = 45241,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Archivum Data Disc",
                    IDs = {
                        Normal = nil,
                        Heroic = 45857,
                    },
                    Quality = 4,
                    Slot = "Quest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },
            },
        },

        -------------------------------------------------
        -- 6. Kologarn
        -------------------------------------------------

        {
            Order = 6,
            Name = "Kologarn",
            NPCID = 36627,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Shawl of the Shattered Giant",
                    IDs = {
                        Normal = 45704,
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
                    Name = "Mark of the Unyielding",
                    IDs = {
                        Normal = 45696,
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
                    Name = "Pendant of the Piercing Glare",
                    IDs = {
                        Normal = 45699,
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
                    Name = "Emerald Signet Ring",
                    IDs = {
                        Normal = 45702,
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
                    Name = "Greaves of the Earthbinder",
                    IDs = {
                        Normal = 45701,
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
                    Name = "Stoneguard",
                    IDs = {
                        Normal = 45700,
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
                    Name = "Sabatons of the Iron Watcher",
                    IDs = {
                        Normal = 45698,
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
                    Name = "Shoulderguards of the Solemn Watch",
                    IDs = {
                        Normal = 45697,
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
                    Name = "Spark of Hope",
                    IDs = {
                        Normal = 45703,
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
                    Name = "Spire of Withering Dreams",
                    IDs = {
                        Normal = 45695,
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
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Necklace of Unerring Mettle",
                    IDs = {
                        Normal = 45262,
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
                    Name = "Idol of the Crying Wind",
                    IDs = {
                        Normal = 45270,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Robes of the Umbral Brute",
                    IDs = {
                        Normal = 45272,
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
                    Name = "Handwraps of Plentiful Recovery",
                    IDs = {
                        Normal = 45273,
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
                    Name = "Bracers of Unleashed Magic",
                    IDs = {
                        Normal = 45275,
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
                    Name = "Shoulderpads of the Monolith",
                    IDs = {
                        Normal = 45265,
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
                    Name = "Leggings of the Stoneweaver",
                    IDs = {
                        Normal = 45274,
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
                    Name = "Ironmender",
                    IDs = {
                        Normal = 45271,
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
                    Name = "Malice",
                    IDs = {
                        Normal = 45266,
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
                    Name = "Gloves of the Pythonic Guardian",
                    IDs = {
                        Normal = 45268,
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
                    Name = "Saronite Plated Legguards",
                    IDs = {
                        Normal = 45267,
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
                    Name = "Decimator's Armguards",
                    IDs = {
                        Normal = 45264,
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
                    Name = "Unfaltering Armguards",
                    IDs = {
                        Normal = 45269,
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
                    Name = "Giant's Bane",
                    IDs = {
                        Normal = 45261,
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
                    Name = "Wrathstone",
                    IDs = {
                        Normal = 45263,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },
            },
        },

        -------------------------------------------------
        -- 7. Auriaya
        -------------------------------------------------

        {
            Order = 7,
            Name = "Auriaya",
            NPCID = 33515,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
           
                {
                    Name = "Raiments of the Corrupted",
                    IDs = {
                        Normal = 45865,
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
                    Name = "Mantle of the Preserver",
                    IDs = {
                        Normal = 45832,
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
                    Name = "Cover of the Keepers",
                    IDs = {
                        Normal = 45864,
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
                    Name = "Nimble Climber's Belt",
                    IDs = {
                        Normal = 45709,
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
                    Name = "Ironaya's Discarded Mantle",
                    IDs = {
                        Normal = 45711,
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
                    Name = "Shieldwall of the Breaker",
                    IDs = {
                        Normal = 45707,
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
                    Name = "Chestplate of Titanic Fury",
                    IDs = {
                        Normal = 45712,
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
                    Name = "Archaedas' Lost Legplates",
                    IDs = {
                        Normal = 45708,
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
                    Name = "Nurturing Touch",
                    IDs = {
                        Normal = 45713,
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
                    Name = "Elemental Focus Stone",
                    IDs = {
                        Normal = 45866,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Cloak of the Makers",
                    IDs = {
                        Normal = 45319,
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
                    Name = "Libram of the Resolute",
                    IDs = {
                        Normal = 45436,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Platinum Band of the Aesir",
                    IDs = {
                        Normal = 45326,
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
                    Name = "Ring of the Faithful Servant",
                    IDs = {
                        Normal = 45438,
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
                    Name = "Sandals of the Ancient Keeper",
                    IDs = {
                        Normal = 45441,
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
                    Name = "Cowl of the Absolute",
                    IDs = {
                        Normal = 45435,
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
                    Name = "Gloves of the Stonereaper",
                    IDs = {
                        Normal = 45325,
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
                    Name = "Unwavering Stare",
                    IDs = {
                        Normal = 45439,
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
                    Name = "Amice of the Stoic Watch",
                    IDs = {
                        Normal = 45440,
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
                    Name = "Runescribed Blade",
                    IDs = {
                        Normal = 45437,
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
                    Name = "Stonerender",
                    IDs = {
                        Normal = 45315,
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
                    Name = "Unbreakable Chestguard",
                    IDs = {
                        Normal = 45334,
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
                    Name = "Greaves of the Rockmender",
                    IDs = {
                        Normal = 45434,
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
                    Name = "Shoulderplates of the Eternal",
                    IDs = {
                        Normal = 45320,
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
                    Name = "Siren's Cry",
                    IDs = {
                        Normal = 45327,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },
            },
        },

        -------------------------------------------------
        -- 8. Freya
        -------------------------------------------------

        {
            Order = 8,
            Name = "Freya",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Tunic of the Limber Stalker",
                    IDs = {
                        Normal = 45940,
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
                    Name = "Chestguard of the Lasher",
                    IDs = {
                        Normal = 45941,
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
                    Name = "Ironbark Faceguard",
                    IDs = {
                        Normal = 45935,
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
                    Name = "Legplates of Flourishing Resolve",
                    IDs = {
                        Normal = 45936,
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
                    Name = "Petrified Ivy Sprig",
                    IDs = {
                        Normal = 45294,
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
                    Name = "Unraveling Reach",
                    IDs = {
                        Normal = 45934,
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
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Seed of Budding Carnage",
                    IDs = {
                        Normal = nil,
                        Heroic = 45945,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Fire Orchid Signet",
                    IDs = {
                        Normal = nil,
                        Heroic = 45946,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Gloves of Whispering Winds",
                    IDs = {
                        Normal = nil,
                        Heroic = 45943,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Serilas, Blood Blade of Invar One-Arm",
                    IDs = {
                        Normal = nil,
                        Heroic = 45947,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Nymph Heart Charm",
                    IDs = {
                        Normal = 45480,
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
                    Name = "Boots of the Servant",
                    IDs = {
                        Normal = 45483,
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
                    Name = "Leggings of the Lifetender",
                    IDs = {
                        Normal = 45482,
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
                    Name = "Gauntlets of Ruthless Reprisal",
                    IDs = {
                        Normal = 45481,
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
                    Name = "Dreambinder",
                    IDs = {
                        Normal = 45613,
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
                    Name = "The Lifebinder",
                    IDs = {
                        Normal = 45479,
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
                -- 25 Hard Mode
                -------------------------------------------------
                {
                    Name = "Drape of the Sullen Goddess",
                    IDs = {
                        Normal = nil,
                        Heroic = 45486,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Bronze Pendant of the Vanir",
                    IDs = {
                        Normal = nil,
                        Heroic = 45485,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Leggings of the Enslaved Idol",
                    IDs = {
                        Normal = nil,
                        Heroic = 45488,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Bladetwister",
                    IDs = {
                        Normal = nil,
                        Heroic = 45484,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Handguards of Revitalization",
                    IDs = {
                        Normal = nil,
                        Heroic = 45487,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Gloves of the Wayward Conqueror",
                    IDs = {
                        Normal = 45644,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Gloves of the Wayward Protector",
                    IDs = {
                        Normal = 45645,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Gloves of the Wayward Vanquisher",
                    IDs = {
                        Normal = 45646,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Legplates of the Wayward Conqueror",
                    IDs = {
                        Normal = nil,
                        Heroic = 45653,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Legplates of the Wayward Protector",
                    IDs = {
                        Normal = nil,
                        Heroic = 45654,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Legplates of the Wayward Vanquisher",
                    IDs = {
                        Normal = nil,
                        Heroic = 45655,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 9. Hodir
        -------------------------------------------------

        {
            Order = 9,
            Name = "Hodir",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Winter's Frigid Embrace",
                    IDs = {
                        Normal = 45873,
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
                    Name = "Signet of Winter",
                    IDs = {
                        Normal = 45874,
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
                    Name = "Cowl of Icy Breaths",
                    IDs = {
                        Normal = 45464,
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
                    Name = "Avalanche",
                    IDs = {
                        Normal = 45872,
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
                    Name = "Stormedge",
                    IDs = {
                        Normal = 45458,
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
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Bitter Cold Armguards",
                    IDs = {
                        Normal = nil,
                        Heroic = 45888,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Ice Layered Barrier",
                    IDs = {
                        Normal = nil,
                        Heroic = 45887,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "The Boreal Guard",
                    IDs = {
                        Normal = nil,
                        Heroic = 45877,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Shiver",
                    IDs = {
                        Normal = nil,
                        Heroic = 45876,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Icecore Staff",
                    IDs = {
                        Normal = nil,
                        Heroic = 45886,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Frozen Loop",
                    IDs = {
                        Normal = 45451,
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
                    Name = "Winter's Icy Embrace",
                    IDs = {
                        Normal = 45453,
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
                    Name = "Frost-bound Chain Bracers",
                    IDs = {
                        Normal = 45454,
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
                    Name = "Frostplate Greaves",
                    IDs = {
                        Normal = 45452,
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
                    Name = "Northern Barrier",
                    IDs = {
                        Normal = 45450,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 10 Hard Mode
                -------------------------------------------------
                
                {
                    Name = "Drape of Icy Intent",
                    IDs = {
                        Normal = 45461,
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
                    Name = "Frigid Strength of Hodir",
                    IDs = {
                        Normal = 45459,
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
                    Name = "Gloves of the Frozen Glade",
                    IDs = {
                        Normal = 45462,
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
                    Name = "Bindings of Winter Gale",
                    IDs = {
                        Normal = 45460,
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
                    Name = "Staff of Endless Winter",
                    IDs = {
                        Normal = 45457,
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
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Leggings of the Wayward Conqueror",
                    IDs = {
                        Normal = 45650,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Leggings of the Wayward Protector",
                    IDs = {
                        Normal = 45651,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Leggings of the Wayward Vanquisher",
                    IDs = {
                        Normal = 45652,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Breastplate of the Wayward Conqueror",
                    IDs = {
                        Normal = nil,
                        Heroic = 45632,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Breastplate of the Wayward Protector",
                    IDs = {
                        Normal = nil,
                        Heroic = 45633,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Breastplate of the Wayward Vanquisher",
                    IDs = {
                        Normal = nil,
                        Heroic = 45634,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 10. Mimiron
        -------------------------------------------------

        {
            Order = 10,
            Name = "Mimiron",
            NPCID = 36789,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Stylish Power Cape",
                    IDs = {
                        Normal = 45973,
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
                    Name = "Static Charge Handwraps",
                    IDs = {
                        Normal = 45976,
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
                    Name = "Shoulderguards of Assimilation",
                    IDs = {
                        Normal = 45974,
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
                    Name = "Cable of the Metrognome",
                    IDs = {
                        Normal = 45975,
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
                    Name = "Pulse Baton",
                    IDs = {
                        Normal = 45972,
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
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Mimiron's Flight Goggles",
                    IDs = {
                        Normal = nil,
                        Heroic = 45993,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Tempered Mercury Greaves",
                    IDs = {
                        Normal = nil,
                        Heroic = 45989,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Fusion Blade",
                    IDs = {
                        Normal = nil,
                        Heroic = 45990,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Greaves of the Iron Army",
                    IDs = {
                        Normal = nil,
                        Heroic = 45988,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Fused Alloy Legplates",
                    IDs = {
                        Normal = nil,
                        Heroic = 45982,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Asimov's Drape",
                    IDs = {
                        Normal = 45493,
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
                    Name = "Malleable Steelweave Mantle",
                    IDs = {
                        Normal = 45492,
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
                    Name = "Waistguard of the Creator",
                    IDs = {
                        Normal = 45491,
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
                    Name = "Insanity's Grip",
                    IDs = {
                        Normal = 45489,
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
                    Name = "Pandora's Plea",
                    IDs = {
                        Normal = 45490,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Hard Mode
                -------------------------------------------------
                {
                    Name = "Titanskin Cloak",
                    IDs = {
                        Normal = nil,
                        Heroic = 45496,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Conductive Seal",
                    IDs = {
                        Normal = 45495,
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
                    Name = "Crown of Luminescence",
                    IDs = {
                        Normal = 45497,
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
                    Name = "Delirium's Touch",
                    IDs = {
                        Normal = 45494,
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
                    Name = "Armbands of Bedlam",
                    IDs = {
                        Normal = 45663,
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
                    Name = "Starshard Edge",
                    IDs = {
                        Normal = 45320,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },
                
                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Helm of the Wayward Conqueror",
                    IDs = {
                        Normal = 45647,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Helm of the Wayward Protector",
                    IDs = {
                        Normal = 45648,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Helm of the Wayward Vanquisher",
                    IDs = {
                        Normal = 45649,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Gauntlets of the Wayward Conqueror",
                    IDs = {
                        Normal = nil,
                        Heroic = 45641,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Gauntlets of the Wayward Protector",
                    IDs = {
                        Normal = nil,
                        Heroic = 45642,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Gauntlets of the Wayward Vanquisher",
                    IDs = {
                        Normal = nil,
                        Heroic = 45643,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 11. Thorim
        -------------------------------------------------

        {
            Order = 11,
            Name = "Thorim",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Handwraps of Resonance",
                    IDs = {
                        Normal = 45927,
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
                    Name = "Leggings of Unstable Discharge",
                    IDs = {
                        Normal = 45894,
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
                    Name = "Guise of the Midgard Serpent",
                    IDs = {
                        Normal = 45893,
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
                    Name = "Belt of the Blood Pit",
                    IDs = {
                        Normal = 45895,
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
                    Name = "Legacy of Thunder",
                    IDs = {
                        Normal = 45892,
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
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Pendant of the Shallow Grave",
                    IDs = {
                        Normal = nil,
                        Heroic = 45933,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Combatant's Bootblade",
                    IDs = {
                        Normal = nil,
                        Heroic = 45930,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Gauntlets of the Thunder God",
                    IDs = {
                        Normal = nil,
                        Heroic = 45928,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Mjolnir Runestone",
                    IDs = {
                        Normal = nil,
                        Heroic = 45931,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Sif's Remembrance",
                    IDs = {
                        Normal = nil,
                        Heroic = 45929,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Sif's Promise",
                    IDs = {
                        Normal = 45469,
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
                    Name = "Leggings of Lost Love",
                    IDs = {
                        Normal = 45468,
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
                    Name = "Belt of the Betrayed",
                    IDs = {
                        Normal = 45467,
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
                    Name = "Vulmir, the Northern Tempest",
                    IDs = {
                        Normal = 45463,
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
                    Name = "Scale of Fates",
                    IDs = {
                        Normal = 45466,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Hard Mode
                -------------------------------------------------
                
                {
                    Name = "Fate's Clutch",
                    IDs = {
                        Normal = nil,
                        Heroic = 45471,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Embrace of the Gladiator",
                    IDs = {
                        Normal = nil,
                        Heroic = 45473,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Pauldrons of the Combatant",
                    IDs = {
                        Normal = nil,
                        Heroic = 45474,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Wisdom's Hold",
                    IDs = {
                        Normal = nil,
                        Heroic = 45470,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Warhelm of the Champion",
                    IDs = {
                        Normal = nil,
                        Heroic = 45472,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Skyforge Crossbow",
                    IDs = {
                        Normal = nil,
                        Heroic = 45570,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Spaulders of the Wayward Conqueror",
                    IDs = {
                        Normal = 45659,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Spaulders of the Wayward Protector",
                    IDs = {
                        Normal = 45660,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Spaulders of the Wayward Vanquisher",
                    IDs = {
                        Normal = 45661,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Crown of the Wayward Conqueror",
                    IDs = {
                        Normal = nil,
                        Heroic = 45638,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Crown of the Wayward Protector",
                    IDs = {
                        Normal = nil,
                        Heroic = 45639,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Crown of the Wayward Vanquisher",
                    IDs = {
                        Normal = nil,
                        Heroic = 45640,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },
            },
        },

        -------------------------------------------------
        -- 12. General Vezax
        -------------------------------------------------

        {
            Order = 12,
            Name = "General Vezax",
            NPCID = 36597,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Saronite Animus Cloak",
                    IDs = {
                        Normal = 46014,
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
                    Name = "Choker of the Abyss",
                    IDs = {
                        Normal = 46008,
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
                    Name = "Pendant of Endless Despair",
                    IDs = {
                        Normal = 46015,
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
                    Name = "Darkstone Ring",
                    IDs = {
                        Normal = 46010,
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
                    Name = "Vestments of the Piercing Light",
                    IDs = {
                        Normal = 46012,
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
                    Name = "Underworld Mantle",
                    IDs = {
                        Normal = 46013,
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
                    Name = "Bindings of the Depths",
                    IDs = {
                        Normal = 46009,
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
                    Name = "Shadowbite",
                    IDs = {
                        Normal = 46011,
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
                    Name = "Gauntlets of the Wretched",
                    IDs = {
                        Normal = 45997,
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
                    Name = "Hoperender",
                    IDs = {
                        Normal = 45996,
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
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Drape of the Faceless General",
                    IDs = {
                        Normal = nil,
                        Heroic = 46032,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Leggings of Profound Darkness",
                    IDs = {
                        Normal = nil,
                        Heroic = 46034,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Aesuga, Hand of the Ardent Champion",
                    IDs = {
                        Normal = nil,
                        Heroic = 46035,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Void Sabre",
                    IDs = {
                        Normal = nil,
                        Heroic = 46036,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Tortured Earth",
                    IDs = {
                        Normal = nil,
                        Heroic = 46033,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },                

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Idol of the Corruptor",
                    IDs = {
                        Normal = 45509,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Libram of the Sacred Shield",
                    IDs = {
                        Normal = 45145,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Relic",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                {
                    Name = "Metallic Loop of the Sufferer",
                    IDs = {
                        Normal = 45503,
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
                    Name = "Ring of the Vacant Eye",
                    IDs = {
                        Normal = 45515,
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
                    Name = "Mantle of the Unknowing",
                    IDs = {
                        Normal = 45514,
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
                    Name = "Belt of the Darkspeaker",
                    IDs = {
                        Normal = 45508,
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
                    Name = "Grips of the Unbroken",
                    IDs = {
                        Normal = 45512,
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
                    Name = "Boots of the Forgotten Depths",
                    IDs = {
                        Normal = 45513,
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
                    Name = "Darkcore Leggings",
                    IDs = {
                        Normal = 45504,
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
                    Name = "Boots of the Underdweller",
                    IDs = {
                        Normal = 45501,
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
                    Name = "Helm of the Faceless",
                    IDs = {
                        Normal = 45502,
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
                    Name = "Belt of Clinging Hope",
                    IDs = {
                        Normal = 45505,
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
                    Name = "Scepter of Lost Souls",
                    IDs = {
                        Normal = 45511,
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
                    Name = "The General's Heart",
                    IDs = {
                        Normal = 45507,
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
                    Name = "Lotrafen, Spear of the Damned",
                    IDs = {
                        Normal = 45498,
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
                -- 25 Hard Mode
                -------------------------------------------------
                {
                    Name = "Pendulum of Infinity",
                    IDs = {
                        Normal = nil,
                        Heroic = 45517,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Handwraps of the Vigilant",
                    IDs = {
                        Normal = nil,
                        Heroic = 45520,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Vestments of the Blind Denizen",
                    IDs = {
                        Normal = nil,
                        Heroic = 45519,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Flare of the Heavens",
                    IDs = {
                        Normal = nil,
                        Heroic = 45518,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Voldrethar, Dark Blade of Oblivion",
                    IDs = {
                        Normal = nil,
                        Heroic = 45516,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },                
            },
        },

        -------------------------------------------------
        -- 13. Yogg-Saron
        -------------------------------------------------

        {
            Order = 13,
            Name = "Yogg-Saron",
            NPCID = 36597,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Pendant of a Thousand Maws",
                    IDs = {
                        Normal = 46022,
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
                    Name = "Treads of the Dragon Council",
                    IDs = {
                        Normal = 46030,
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
                    Name = "Leggings of the Insatiable",
                    IDs = {
                        Normal = 46019,
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
                    Name = "Touch of Madness",
                    IDs = {
                        Normal = 46031,
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
                    Name = "Kingsbane",
                    IDs = {
                        Normal = 46024,
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
                    Name = "Faceguard of the Eyeless Horror",
                    IDs = {
                        Normal = 46028,
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
                    Name = "Deliverance",
                    IDs = {
                        Normal = 46018,
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
                    Name = "Royal Seal of King Llane",
                    IDs = {
                        Normal = 46021,
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
                    Name = "Vanquished Clutches of Yogg-Saron",
                    IDs = {
                        Normal = 46312,
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
                    Name = "Devotion",
                    IDs = {
                        Normal = 46025,
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
                    Name = "Abaddon",
                    IDs = {
                        Normal = 46016,
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
                -- 10 Hard Mode
                -------------------------------------------------
                {
                    Name = "Signet of Soft Lament",
                    IDs = {
                        Normal = nil,
                        Heroic = 46096,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Amice of Inconceivable Horror",
                    IDs = {
                        Normal = nil,
                        Heroic = 46068,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Soul-Devouring Cinch",
                    IDs = {
                        Normal = nil,
                        Heroic = 46095,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Caress of Insanity",
                    IDs = {
                        Normal = nil,
                        Heroic = 46097,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Hammer of Crushing Whispers",
                    IDs = {
                        Normal = nil,
                        Heroic = 46067,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                BonusLootGroup = "Hard Mode Loot",
                },                

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Shawl of Haunted Memories",
                    IDs = {
                        Normal = 45529,
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
                    Name = "Godbane Signet",
                    IDs = {
                        Normal = 45525,
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
                    Name = "Sanity's Bond",
                    IDs = {
                        Normal = 45530,
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
                    Name = "Cowl of Dark Whispers",
                    IDs = {
                        Normal = 45532,
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
                    Name = "Garona's Guise",
                    IDs = {
                        Normal = 45523,
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
                    Name = "Chestguard of Insidious Intent",
                    IDs = {
                        Normal = 45524,
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
                    Name = "Chestguard of the Fallen God",
                    IDs = {
                        Normal = 45531,
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
                    Name = "Soulscribe",
                    IDs = {
                        Normal = 45527,
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
                    Name = "Blood of the Old God",
                    IDs = {
                        Normal = 45522,
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
                    Name = "Earthshaper",
                    IDs = {
                        Normal = 45521,
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
                    Name = "Mimiron's Head",
                    IDs = {
                        Normal = 45693,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },                

                -------------------------------------------------
                -- 25 Hard Mode
                -------------------------------------------------
                
                {
                    Name = "Seal of the Betrayed King",
                    IDs = {
                        Normal = nil,
                        Heroic = 45534,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },
                
                {
                    Name = "Treads of the False Oracle",
                    IDs = {
                        Normal = nil,
                        Heroic = 45537,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },
                
                {
                    Name = "Legguards of Cunning Deception",
                    IDs = {
                        Normal = nil,
                        Heroic = 45536,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Show of Faith",
                    IDs = {
                        Normal = nil,
                        Heroic = 45535,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                {
                    Name = "Dark Edge of Depravity",
                    IDs = {
                        Normal = nil,
                        Heroic = 45533,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                BonusLootGroup = "Hard Mode Loot",
                },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Chestguard of the Wayward Conqueror",
                    IDs = {
                        Normal = 45635,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Chestguard of the Wayward Protector",
                    IDs = {
                        Normal = 45636,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Chestguard of the Wayward Vanquisher",
                    IDs = {
                        Normal = 45637,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["10"] = true,
                    },
                },

                {
                    Name = "Mantle of the Wayward Conqueror",
                    IDs = {
                        Normal = nil,
                        Heroic = 45656,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Mantle of the Wayward Protector",
                    IDs = {
                        Normal = nil,
                        Heroic = 45657,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },

                {
                    Name = "Mantle of the Wayward Vanquisher",
                    IDs = {
                        Normal = nil,
                        Heroic = 45658,
                    },
                    Quality = 4,
                    Slot = "Tier Token",
                    Token = true,
                    Type = "TIER_TOKEN",
                    Classes = nil,
                    Notes = nil,

                    AvailableIn = {
                        ["25"] = true,
                    },
                },
            },
        },
        
        -------------------------------------------------
        -- 14. Algalon the Observer
        -------------------------------------------------

        {
            Order = 14,
            Name = "Algalon the Observer",
            NPCID = 36597,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Drape of the Messenger",
                    IDs = {
                        Normal = 46042,
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
                    Name = "Pendant of the Somber Witness",
                    IDs = {
                        Normal = 46047,
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
                    Name = "Strength of the Heavens",
                    IDs = {
                        Normal = 46040,
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
                    Name = "Band of Lights",
                    IDs = {
                        Normal = 46048,
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
                    Name = "Nebula Band",
                    IDs = {
                        Normal = 46046,
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
                    Name = "Starlight Treads",
                    IDs = {
                        Normal = 46050,
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
                    Name = "Pulsar Gloves",
                    IDs = {
                        Normal = 46045,
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
                    Name = "Gloves of the Endless Dark",
                    IDs = {
                        Normal = 46043,
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
                    Name = "Zodiac Leggings",
                    IDs = {
                        Normal = 46049,
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
                    Name = "Observer's Mantle",
                    IDs = {
                        Normal = 46044,
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
                    Name = "Breastplate of the Timeless",
                    IDs = {
                        Normal = 46039,
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
                    Name = "Shoulderplates of the Celestial Watch",
                    IDs = {
                        Normal = 46037,
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
                    Name = "Starfall Girdle",
                    IDs = {
                        Normal = 46041,
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
                    Name = "Dark Matter",
                    IDs = {
                        Normal = 46038,
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
                    Name = "Meteorite Crystal",
                    IDs = {
                        Normal = 46051,
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
                    Name = "Reply-Code Alpha",
                    IDs = {
                        Normal = 46052,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Quest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10",
                },

                

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Pharos Gloves",
                    IDs = {
                        Normal = 45665,
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
                    Name = "Starwatcher's Binding",
                    IDs = {
                        Normal = 45619,
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
                    Name = "Star-beaded Clutch",
                    IDs = {
                        Normal = 45616,
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
                    Name = "Solar Bindings",
                    IDs = {
                        Normal = 45611,
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
                    Name = "Planewalker Treads",
                    IDs = {
                        Normal = 45615,
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
                    Name = "Boundless Gaze",
                    IDs = {
                        Normal = 45610,
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
                    Name = "Starshard Edge",
                    IDs = {
                        Normal = 45620,
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
                    Name = "Constellus",
                    IDs = {
                        Normal = 45612,
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
                    Name = "Cosmos",
                    IDs = {
                        Normal = 45617,
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
                    Name = "Bulwark of Algalon",
                    IDs = {
                        Normal = 45587,
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
                    Name = "Sabatons of Lifeless Night",
                    IDs = {
                        Normal = 45599,
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
                    Name = "Legplates of the Endless Void",
                    IDs = {
                        Normal = 45594,
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
                    Name = "Comet's Trail",
                    IDs = {
                        Normal = 45609,
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
                    Name = "Dreambinder",
                    IDs = {
                        Normal = 45613,
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
                    Name = "Skyforge Crossbow",
                    IDs = {
                        Normal = 45570,
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
                    Name = "Reply-Code Alpha",
                    IDs = {
                        Normal = 46053,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Quest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },
            },
        },
    },

    -------------------------------------------------
    -- Trash
    -------------------------------------------------

    Trash = {

        -------------------------------------------------
        -- 10 Man
        -------------------------------------------------

        {
            Name = "Cloak of the Dormant Blaze",
            IDs = {
                Normal = 46347,
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
            Name = "Drape of the Spellweaver",
            IDs = {
                Normal = 46341,
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
            Name = "Fervor of the Protectorate",
            IDs = {
                Normal = 46343,
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
            Name = "Iceshear Mantle",
            IDs = {
                Normal = 46344,
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
            Name = "Boots of Unsettled Prey",
            IDs = {
                Normal = 46346,
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
            Name = "Bloodcrush Cudgel",
            IDs = {
                Normal = 46351,
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
            Name = "Adamant Handguards",
            IDs = {
                Normal = 46340,
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
            Name = "Bracers of Righteous Reformation",
            IDs = {
                Normal = 46345,
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
            Name = "Golemheart Longbow",
            IDs = {
                Normal = 46342,
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
            Name = "Mimiron's Repeater",
            IDs = {
                Normal = 46339,
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
            Name = "Pillar of Fortitude",
            IDs = {
                Normal = 46350,
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
        -- 25 Man
        -------------------------------------------------

        {
            Name = "Shroud of Alteration",
            IDs = {
                Normal = 45541,
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
            Name = "Pendant of Focused Energies",
            IDs = {
                Normal = 45539,
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
            Name = "Titanstone Pendant",
            IDs = {
                Normal = 45538,
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
            Name = "Bladebearer's Signet",
            IDs = {
                Normal = 45540,
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
            Name = "Grips of Chaos",
            IDs = {
                Normal = 45549,
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
            Name = "Belt of the Sleeper",
            IDs = {
                Normal = 45548,
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
            Name = "Relic Hunter's Cord",
            IDs = {
                Normal = 45547,
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
            Name = "Leggings of the Tortured Earth",
            IDs = {
                Normal = 45544,
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
            Name = "Shoulders of Misfortune",
            IDs = {
                Normal = 45543,
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
            Name = "Daschal's Bite",
            IDs = {
                Normal = 45605,
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
            Name = "Greaves of the Stonewarder",
            IDs = {
                Normal = 45542,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Feet",
            Token = false,
            Classes = nil,
            Notes = nil,
            Difficulty = "25",
        },
    },

    -------------------------------------------------
    -- Extra Drops
    --
    -- Items that can drop from any boss in the raid
    -- rather than one specific boss's table -- Ulduar's
    -- crafting currencies. More may be added here later
    -- (recipes/formulas).
    -------------------------------------------------

    ExtraDrops = {

        {
            Name = "Runed Orb",
            IDs = {
                Normal = 45087,
                Heroic = nil,
            },
            Quality = 3,
            Slot = nil,
            Token = false,
            Classes = nil,
            Notes = "Can drop from any boss, 10 or 25 man.",
            AvailableIn = {
                ["10"] = true,
                ["25"] = true,
            },
        },

        {
            Name = "Fragment of Val'anyr",
            IDs = {
                Normal = 45038,
                Heroic = nil,
            },
            Quality = 5,
            Slot = nil,
            Token = false,
            Classes = { "Paladin", "Priest", "Shaman", "Druid" },
            Notes = "Can drop from any boss, 25 man only.",
            Difficulty = "25",
        },
    },
}

ImpLoot.Database:RegisterRaid(ULD)