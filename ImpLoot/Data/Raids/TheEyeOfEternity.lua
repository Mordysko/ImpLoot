-------------------------------------------------
-- The Eye of Eternity
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
-------------------------------------------------

local EOE = {

    Name = "The Eye of Eternity",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "25",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Malygos
        -------------------------------------------------

        {
            Order = 1,
            Name = "Malygos",
            NPCID = 0,

            Loot = {

                -------------------------------------------------
                -- 10 Normal
                -------------------------------------------------
                
                {
                    Name = "Surge Needle Ring",
                    IDs = {
                        Normal = 40474,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Necklace of the Glittering Chamber",
                    IDs = {
                        Normal = 40486,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Ice Spire Scepter",
                    IDs = {
                        Normal = 40488,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Black Ice",
                    IDs = {
                        Normal = 40497,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Barricade of Eternity",
                    IDs = {
                        Normal = 40475,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Greatstaff of the Nexus",
                    IDs = {
                        Normal = 40489,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Hailstorm",
                    IDs = {
                        Normal = 40491,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "One-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Gown of the Spell-Weaver",
                    IDs = {
                        Normal = 40526,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Footsteps of Malygos",
                    IDs = {
                        Normal = 40519,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Focusing Energy Epaulets",
                    IDs = {
                        Normal = 40511,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Reins of the Blue Drake",
                    IDs = {
                        Normal = 43953,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                ---25 Normal
                -------------------------------------------------
            
                {
                    Name = "Living Ice Crystals",
                    IDs = {
                        Normal = 40532,
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
                    Name = "Mark of Norgannon",
                    IDs = {
                        Normal = 40531,
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
                    Name = "Blanketing Robes of Snow",
                    IDs = {
                        Normal = 40194,
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
                    Name = "Arcanic Tramplers",
                    IDs = {
                        Normal = 40558,
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
                    Name = "Hood of Rationality",
                    IDs = {
                        Normal = 40562,
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
                    Name = "Leggings of the Wanton Spellcaster",
                    IDs = {
                        Normal = 40560,
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
                    Name = "Mantle of Dissemination",
                    IDs = {
                        Normal = 40555,
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
                    Name = "Leash of Heedless Magic",
                    IDs = {
                        Normal = 40561,
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
                    Name = "Chestguard of the Recluse",
                    IDs = {
                        Normal = 40539,
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
                    Name = "Frosted Adroit Handguards",
                    IDs = {
                        Normal = 40541,
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
                    Name = "Spaulders of Catatonia",
                    IDs = {
                        Normal = 40594,
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
                    Name = "Unravelling Strands of Sanity",
                    IDs = {
                        Normal = 40566,
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
                    Name = "Tunic of the Artifact Guardian",
                    IDs = {
                        Normal = 40588,
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
                    Name = "Boots of the Renewed Flight",
                    IDs = {
                        Normal = 40549,
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
                    Name = "Winter Spectacle Gloves",
                    IDs = {
                        Normal = 40564,
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
                    Name = "Blue Aspect Helm",
                    IDs = {
                        Normal = 40543,
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
                    Name = "Melancholy Sabatons",
                    IDs = {
                        Normal = 40591,
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
                    Name = "Boots of Healing Energies",
                    IDs = {
                        Normal = 40592,
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
                    Name = "Legplates of Sovereignty",
                    IDs = {
                        Normal = 40589,
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
                    Name = "Elevated Lair Pauldrons",
                    IDs = {
                        Normal = 40590,
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
                    Name = "Reins of the Azure Drake",
                    IDs = {
                        Normal = 43952,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Mount",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                    AvailableIn = {
                        ["10"] = true,
                        ["25"] = true,
                    },
                },
            },
        },        
    },
}

ImpLoot.Database:RegisterRaid(EOE)