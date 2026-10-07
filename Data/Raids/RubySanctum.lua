-------------------------------------------------
-- Ruby Sanctum
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
-------------------------------------------------

local RS = {

    Name = "Ruby Sanctum",
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
            Name = "Halion",
            NPCID = 39863,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Baltharus' Gift",
                    IDs = {
                        Normal = 53103,
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
                    Name = "Saviana's Tribute",
                    IDs = {
                        Normal = 53116,
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
                    Name = "Zarithrian's Offering",
                    IDs = {
                        Normal = 53110,
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
                    Name = "Abduction's Cover",
                    IDs = {
                        Normal = 53115,
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
                    Name = "Misbegotten Belt",
                    IDs = {
                        Normal = 53118,
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
                    Name = "Gloaming Sark",
                    IDs = {
                        Normal = 53114,
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
                    Name = "Changeling Gloves",
                    IDs = {
                        Normal = 53117,
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
                    Name = "Twilight Scale Shoulders",
                    IDs = {
                        Normal = 53113,
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
                    Name = "Boots of Divided Being",
                    IDs = {
                        Normal = 53119,
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
                    Name = "Bracers of the Heir",
                    IDs = {
                        Normal = 53112,
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
                    Name = "Surrogate Belt",
                    IDs = {
                        Normal = 53121,
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
                    Name = "Scion's Treads",
                    IDs = {
                        Normal = 53111,
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
                -- 10 Heroic
                -------------------------------------------------
                {
                    Name = "Baltharus' Gift",
                    IDs = {
                        Normal = nil,
                        Heroic = 54557,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Saviana's Tribute",
                    IDs = {
                        Normal = nil,
                        Heroic = 54563,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Zarithrian's Offering",
                    IDs = {
                        Normal = nil,
                        Heroic = 54567,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Abduction's Cover",
                    IDs = {
                        Normal = nil,
                        Heroic = 54556,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Misbegotten Belt",
                    IDs = {
                        Normal = nil,
                        Heroic = 54562,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Gloaming Sark",
                    IDs = {
                        Normal = nil,
                        Heroic = 54561,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Changeling Gloves",
                    IDs = {
                        Normal = nil,
                        Heroic = 54560,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Twilight Scale Shoulders",
                    IDs = {
                        Normal = nil,
                        Heroic = 54566,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Boots of Divided Being",
                    IDs = {
                        Normal = nil,
                        Heroic = 54558,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Bracers of the Heir",
                    IDs = {
                        Normal = nil,
                        Heroic = 54559,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Surrogate Belt",
                    IDs = {
                        Normal = nil,
                        Heroic = 54565,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                {
                    Name = "Scion's Treads",
                    IDs = {
                        Normal = nil,
                        Heroic = 54564,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "10 Heroic",
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Sharpened Twilight Scale",
                    IDs = {
                        Normal = 54569,
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
                    Name = "Charred Twilight Scale",
                    IDs = {
                        Normal = 54572,
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
                    Name = "Petrified Twilight Scale",
                    IDs = {
                        Normal = 54571,
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
                    Name = "Glowing Twilight Scale",
                    IDs = {
                        Normal = 54573,
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
                    Name = "Penumbra Pendant",
                    IDs = {
                        Normal = 53132,
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
                    Name = "Signet of Twilight",
                    IDs = {
                        Normal = 53133,
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
                    Name = "Ring of Phased Regeneration",
                    IDs = {
                        Normal = 53490,
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
                    Name = "Cloak of Burning Dusk",
                    IDs = {
                        Normal = 53489,
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
                    Name = "Bracers of Fiery Night",
                    IDs = {
                        Normal = 53486,
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
                    Name = "Umbrage Armbands",
                    IDs = {
                        Normal = 53126,
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
                    Name = "Phaseshifter's Bracers",
                    IDs = {
                        Normal = 53134,
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
                    Name = "Split Shape Belt",
                    IDs = {
                        Normal = 53488,
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
                    Name = "Returning Footfalls",
                    IDs = {
                        Normal = 53127,
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
                    Name = "Foreshadow Steps",
                    IDs = {
                        Normal = 53487,
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
                    Name = "Apocalypse's Advance",
                    IDs = {
                        Normal = 53125,
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
                    Name = "Treads of Impending Resurrection",
                    IDs = {
                        Normal = 53129,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25",
                },

                -------------------------------------------------
                -- 25 Heroic
                -------------------------------------------------
                {
                    Name = "Sharpened Twilight Scale",
                    IDs = {
                        Normal = nil,
                        Heroic = 54590,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Charred Twilight Scale",
                    IDs = {
                        Normal = nil,
                        Heroic = 54588,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Petrified Twilight Scale",
                    IDs = {
                        Normal = nil,
                        Heroic = 54591,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Glowing Twilight Scale",
                    IDs = {
                        Normal = nil,
                        Heroic = 54589,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Penumbra Pendant",
                    IDs = {
                        Normal = nil,
                        Heroic = 54581,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Signet of Twilight",
                    IDs = {
                        Normal = nil,
                        Heroic = 54576,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Ring of Phased Regeneration",
                    IDs = {
                        Normal = nil,
                        Heroic = 54585,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Cloak of Burning Dusk",
                    IDs = {
                        Normal = nil,
                        Heroic = 54583,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Bracers of Fiery Night",
                    IDs = {
                        Normal = nil,
                        Heroic = 54582,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Umbrage Armbands",
                    IDs = {
                        Normal = nil,
                        Heroic = 54580,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Phaseshifter's Bracers",
                    IDs = {
                        Normal = nil,
                        Heroic = 54584,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Split Shape Belt",
                    IDs = {
                        Normal = nil,
                        Heroic = 54587,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Returning Footfalls",
                    IDs = {
                        Normal = nil,
                        Heroic = 54577,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Foreshadow Steps",
                    IDs = {
                        Normal = nil,
                        Heroic = 54586,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Apocalypse's Advance",
                    IDs = {
                        Normal = nil,
                        Heroic = 54578,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },

                {
                    Name = "Treads of Impending Resurrection",
                    IDs = {
                        Normal = nil,
                        Heroic = 54579,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    Difficulty = "25 Heroic",
                },
            },
        },        
    },
}

ImpLoot.Database:RegisterRaid(RS)