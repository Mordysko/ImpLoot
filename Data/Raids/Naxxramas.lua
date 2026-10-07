-------------------------------------------------
-- Naxxramas
--
-- This must load after Modules\Database.lua, since
-- RegisterRaid() below runs immediately at load time.
--
-- STATUS: Gluth has no fixed loot table of its own -- it can drop
-- any item from any other Naxxramas boss (except Sapphiron
-- and Kel'Thuzad), so its Loot table is intentionally empty.
-------------------------------------------------

local NAX = {

    Name = "Naxxramas",
    Expansion = "Wrath of the Lich King",

    Difficulties = {
        "10",
        "25",
    },

    Bosses = {

        -------------------------------------------------
        -- 1. Anub'Rekhan
        -------------------------------------------------

        {
            Order = 1,
            Name = "Anub'Rekhan",
            NPCID = 15956,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Knife of Incision",
                    IDs = {
                        Normal = 39140,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Collar of Dissolution",
                    IDs = {
                        Normal = 39146,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Deflection Band",
                    IDs = {
                        Normal = 39141,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Band of Neglected Pleas",
                    IDs = {
                        Normal = 39193,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Agonal Sash",
                    IDs = {
                        Normal = 39190,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Gloves of Dark Gestures",
                    IDs = {
                        Normal = 39192,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Splint-Bound Leggings",
                    IDs = {
                        Normal = 39191,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Boots of Persistence",
                    IDs = {
                        Normal = 39189,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Chivalric Chestguard",
                    IDs = {
                        Normal = 39188,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Ravaging Sabatons",
                    IDs = {
                        Normal = 39139,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Gemmed Wand of the Nerubians",
                    IDs = {
                        Normal = 39712,
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
                    Name = "Webbed Death",
                    IDs = {
                        Normal = 39714,
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
                    Name = "Shield of Assimilation",
                    IDs = {
                        Normal = 39716,
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
                    Name = "Strong-Handed Ring",
                    IDs = {
                        Normal = 40074,
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
                    Name = "Ruthlessness",
                    IDs = {
                        Normal = 40075,
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
                    Name = "Lost Jewel",
                    IDs = {
                        Normal = 40080,
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
                    Name = "Sand-Worn Band",
                    IDs = {
                        Normal = 40107,
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
                    Name = "Seized Beauty",
                    IDs = {
                        Normal = 40108,
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
                    Name = "Thunderstorm Amulet",
                    IDs = {
                        Normal = 40064,
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
                    Name = "Fool's Trial",
                    IDs = {
                        Normal = 40065,
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
                    Name = "Heritage",
                    IDs = {
                        Normal = 40069,
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
                    Name = "Chains of Adoration",
                    IDs = {
                        Normal = 40071,
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
                    Name = "Leggings of Atrophy",
                    IDs = {
                        Normal = 39720,
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
                    Name = "Mantle of the Locusts",
                    IDs = {
                        Normal = 39719,
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
                    Name = "Sash of the Parlor",
                    IDs = {
                        Normal = 39721,
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
                    Name = "Dawnwalkers",
                    IDs = {
                        Normal = 39701,
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
                    Name = "Swarm Bindings",
                    IDs = {
                        Normal = 39722,
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
                    Name = "Corpse Scarab Handguards",
                    IDs = {
                        Normal = 39718,
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
                    Name = "Arachnoid Gold Band",
                    IDs = {
                        Normal = 39702,
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
                    Name = "Sabatons of Sudden Reprisal",
                    IDs = {
                        Normal = 39706,
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
                    Name = "Inexorable Sabatons",
                    IDs = {
                        Normal = 39717,
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
                    Name = "Rescinding Grips",
                    IDs = {
                        Normal = 39703,
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
                    Name = "Pauldrons of Unnatural Death",
                    IDs = {
                        Normal = 39704,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 2. Grand Widow Faerlina
        -------------------------------------------------

        {
            Order = 2,
            Name = "Grand Widow Faerlina",
            NPCID = 15953,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Watchful Eye",
                    IDs = {
                        Normal = 39199,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Grieving Spellblade",
                    IDs = {
                        Normal = 39200,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Sash of Mortal Desire",
                    IDs = {
                        Normal = 39216,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Boots of the Worshiper",
                    IDs = {
                        Normal = 39196,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Boots of the Follower",
                    IDs = {
                        Normal = 39215,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Rusted-Link Spiked Gauntlets",
                    IDs = {
                        Normal = 39194,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Avenging Combat Leggings",
                    IDs = {
                        Normal = 39217,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Gauntlets of the Master",
                    IDs = {
                        Normal = 39197,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Frostblight Pauldrons",
                    IDs = {
                        Normal = 39198,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Bracers of Lost Sentiments",
                    IDs = {
                        Normal = 39195,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Widow's Fury",
                    IDs = {
                        Normal = 39730,
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
                    Name = "Totem of Misery",
                    IDs = {
                        Normal = 39728,
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
                    Name = "Idol of Worship",
                    IDs = {
                        Normal = 39757,
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
                    Name = "Strong-Handed Ring",
                    IDs = {
                        Normal = 40074,
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
                    Name = "Ruthlessness",
                    IDs = {
                        Normal = 40075,
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
                    Name = "Lost Jewel",
                    IDs = {
                        Normal = 40080,
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
                    Name = "Sand-Worn Band",
                    IDs = {
                        Normal = 40107,
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
                    Name = "Seized Beauty",
                    IDs = {
                        Normal = 40108,
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
                    Name = "Thunderstorm Amulet",
                    IDs = {
                        Normal = 40064,
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
                    Name = "Fool's Trial",
                    IDs = {
                        Normal = 40065,
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
                    Name = "Heritage",
                    IDs = {
                        Normal = 40069,
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
                    Name = "Chains of Adoration",
                    IDs = {
                        Normal = 40071,
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
                    Name = "Gloves of Token Respect",
                    IDs = {
                        Normal = 39733,
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
                    Name = "Faerlina's Madness",
                    IDs = {
                        Normal = 39732,
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
                    Name = "Belt of False Dignity",
                    IDs = {
                        Normal = 39735,
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
                    Name = "Punctilious Bindings",
                    IDs = {
                        Normal = 39731,
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
                    Name = "Tunic of Prejudice",
                    IDs = {
                        Normal = 39756,
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
                    Name = "Dislocating Handguards",
                    IDs = {
                        Normal = 39727,
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
                    Name = "Atonement Greaves",
                    IDs = {
                        Normal = 39734,
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
                    Name = "Cult's Chestguard",
                    IDs = {
                        Normal = 39724,
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
                    Name = "Bracers of the Tyrant",
                    IDs = {
                        Normal = 39729,
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
                    Name = "Fire-Scorched Greathelm",
                    IDs = {
                        Normal = 39723,
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
                    Name = "Callous-Hearted Gauntlets",
                    IDs = {
                        Normal = 39726,
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
                    Name = "Epaulets of the Grieving Servant",
                    IDs = {
                        Normal = 39725,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 3. Maexxna
        -------------------------------------------------

        {
            Order = 3,
            Name = "Maexxna",
            NPCID = 15952,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Maexxna's Femur",
                    IDs = {
                        Normal = 39226,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Wraith Spear",
                    IDs = {
                        Normal = 39221,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Aegis of Damnation",
                    IDs = {
                        Normal = 39233,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Embrace of the Spider",
                    IDs = {
                        Normal = 39229,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Cloak of Armed Strife",
                    IDs = {
                        Normal = 39225,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Timeworn Silken Band",
                    IDs = {
                        Normal = 39231,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Pendant of Lost Vocations",
                    IDs = {
                        Normal = 39232,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Leggings of Discord",
                    IDs = {
                        Normal = 39224,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Spaulders of the Monstrosity",
                    IDs = {
                        Normal = 39230,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Web Cocoon Grips",
                    IDs = {
                        Normal = 39228,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Wraith Strike",
                    IDs = {
                        Normal = 39763,
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
                    Name = "The Jawbone",
                    IDs = {
                        Normal = 39758,
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
                    Name = "Matriarch's Spawn",
                    IDs = {
                        Normal = 39766,
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
                    Name = "Dying Curse",
                    IDs = {
                        Normal = 40255,
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
                    Name = "Grim Toll",
                    IDs = {
                        Normal = 40256,
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
                    Name = "Defender's Code",
                    IDs = {
                        Normal = 40257,
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
                    Name = "Forethought Talisman",
                    IDs = {
                        Normal = 40258,
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
                    Name = "Aged Winter Cloak",
                    IDs = {
                        Normal = 40250,
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
                    Name = "Shroud of Luminosity",
                    IDs = {
                        Normal = 40251,
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
                    Name = "Cloak of the Shadowed Sun",
                    IDs = {
                        Normal = 40252,
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
                    Name = "Shawl of the Old Maid",
                    IDs = {
                        Normal = 40253,
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
                    Name = "Cloak of Averted Crisis",
                    IDs = {
                        Normal = 40254,
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
                    Name = "Digested Silken Robes",
                    IDs = {
                        Normal = 40062,
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
                    Name = "Distorted Limbs",
                    IDs = {
                        Normal = 40060,
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
                    Name = "Cowl of the Perished",
                    IDs = {
                        Normal = 39768,
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
                    Name = "Infectious Skitterer Leggings",
                    IDs = {
                        Normal = 39761,
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
                    Name = "Mantle of Shattered Kinship",
                    IDs = {
                        Normal = 40063,
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
                    Name = "Sinner's Bindings",
                    IDs = {
                        Normal = 39765,
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
                    Name = "Quivering Tunic",
                    IDs = {
                        Normal = 40061,
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
                    Name = "Torn Web Wrapping",
                    IDs = {
                        Normal = 39762,
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
                    Name = "Undiminished Battleplate",
                    IDs = {
                        Normal = 39767,
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
                    Name = "Helm of Diminished Pride",
                    IDs = {
                        Normal = 39760,
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
                    Name = "Ablative Chitin Girdle",
                    IDs = {
                        Normal = 39759,
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
                    Name = "Bindings of the Hapless Prey",
                    IDs = {
                        Normal = 39764,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 4. Noth the Plaguebringer
        -------------------------------------------------

        {
            Order = 4,
            Name = "Noth the Plaguebringer",
            NPCID = 15954,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Dark Shroud of the Scourge",
                    IDs = {
                        Normal = 39241,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Ring of the Fated",
                    IDs = {
                        Normal = 39244,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Robes of Hoarse Breaths",
                    IDs = {
                        Normal = 39242,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Noth's Curse",
                    IDs = {
                        Normal = 39240,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Spaulders of Resumed Battle",
                    IDs = {
                        Normal = 39237,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Trespasser's Boots",
                    IDs = {
                        Normal = 39236,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Handgrips of the Foredoomed",
                    IDs = {
                        Normal = 39243,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Chestplate of the Risen Soldier",
                    IDs = {
                        Normal = 39239,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Plague-Impervious Boots",
                    IDs = {
                        Normal = 39234,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Bone-Framed Bracers",
                    IDs = {
                        Normal = 39235,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Angry Dread",
                    IDs = {
                        Normal = 40189,
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
                    Name = "Spinning Fate",
                    IDs = {
                        Normal = 40190,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Thrown",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },

                {
                    Name = "Accursed Spine",
                    IDs = {
                        Normal = 40192,
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
                    Name = "Strong-Handed Ring",
                    IDs = {
                        Normal = 40074,
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
                    Name = "Ruthlessness",
                    IDs = {
                        Normal = 40075,
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
                    Name = "Lost Jewel",
                    IDs = {
                        Normal = 40080,
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
                    Name = "Sand-Worn Band",
                    IDs = {
                        Normal = 40107,
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
                    Name = "Seized Beauty",
                    IDs = {
                        Normal = 40108,
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
                    Name = "Thunderstorm Amulet",
                    IDs = {
                        Normal = 40064,
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
                    Name = "Fool's Trial",
                    IDs = {
                        Normal = 40065,
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
                    Name = "Heritage",
                    IDs = {
                        Normal = 40069,
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
                    Name = "Chains of Adoration",
                    IDs = {
                        Normal = 40071,
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
                    Name = "Libram of Radiance",
                    IDs = {
                        Normal = 40191,
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
                    Name = "Robes of Mutation",
                    IDs = {
                        Normal = 40602,
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
                    Name = "Gloves of the Fallen Wizard",
                    IDs = {
                        Normal = 40197,
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
                    Name = "Bands of Impurity",
                    IDs = {
                        Normal = 40198,
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
                    Name = "Belt of Potent Chanting",
                    IDs = {
                        Normal = 40200,
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
                    Name = "Thrusting Bands",
                    IDs = {
                        Normal = 40186,
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
                    Name = "Tunic of Masked Suffering",
                    IDs = {
                        Normal = 40193,
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
                    Name = "Crippled Treads",
                    IDs = {
                        Normal = 40184,
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
                    Name = "Legguards of the Undisturbed",
                    IDs = {
                        Normal = 40196,
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
                    Name = "Poignant Sabatons",
                    IDs = {
                        Normal = 40187,
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
                    Name = "Gauntlets of the Disobedient",
                    IDs = {
                        Normal = 40188,
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
                    Name = "Shoulderguards of Opportunity",
                    IDs = {
                        Normal = 40185,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 5. Heigan the Unclean
        -------------------------------------------------

        {
            Order = 5,
            Name = "Heigan the Unclean",
            NPCID = 15936,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Demise",
                    IDs = {
                        Normal = 39245,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Staff of the Plague Beast",
                    IDs = {
                        Normal = 39255,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Ring of Holy Cleansing",
                    IDs = {
                        Normal = 39250,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Amulet of Autopsy",
                    IDs = {
                        Normal = 39246,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Saltarello Shoes",
                    IDs = {
                        Normal = 39254,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Preceptor's Bindings",
                    IDs = {
                        Normal = 39252,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Cuffs of Dark Shadows",
                    IDs = {
                        Normal = 39247,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Tunic of the Lost Pack",
                    IDs = {
                        Normal = 39248,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Necrogenic Belt",
                    IDs = {
                        Normal = 39251,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Shoulderplates of Bloodshed",
                    IDs = {
                        Normal = 39249,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Cryptfiend's Bite",
                    IDs = {
                        Normal = 40208,
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
                    Name = "The Undeath Carrier",
                    IDs = {
                        Normal = 40233,
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
                    Name = "Dying Curse",
                    IDs = {
                        Normal = 40255,
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
                    Name = "Grim Toll",
                    IDs = {
                        Normal = 40256,
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
                    Name = "Defender's Code",
                    IDs = {
                        Normal = 40257,
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
                    Name = "Forethought Talisman",
                    IDs = {
                        Normal = 40258,
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
                    Name = "Aged Winter Cloak",
                    IDs = {
                        Normal = 40250,
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
                    Name = "Shroud of Luminosity",
                    IDs = {
                        Normal = 40251,
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
                    Name = "Cloak of the Shadowed Sun",
                    IDs = {
                        Normal = 40252,
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
                    Name = "Shawl of the Old Maid",
                    IDs = {
                        Normal = 40253,
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
                    Name = "Cloak of Averted Crisis",
                    IDs = {
                        Normal = 40254,
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
                    Name = "Sigil of Awareness",
                    IDs = {
                        Normal = 40207,
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
                    Name = "Heigan's Putrid Vestments",
                    IDs = {
                        Normal = 40234,
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
                    Name = "Serene Echoes",
                    IDs = {
                        Normal = 40236,
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
                    Name = "Gloves of the Dancing Bear",
                    IDs = {
                        Normal = 40238,
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
                    Name = "Stalk-Skin Belt",
                    IDs = {
                        Normal = 40205,
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
                    Name = "Eruption-Scarred Boots",
                    IDs = {
                        Normal = 40237,
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
                    Name = "Helm of Pilgrimage",
                    IDs = {
                        Normal = 40235,
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
                    Name = "Leggings of Colossal Strides",
                    IDs = {
                        Normal = 40201,
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
                    Name = "Bindings of the Decrepit",
                    IDs = {
                        Normal = 40209,
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
                    Name = "Breastplate of Tormented Rage",
                    IDs = {
                        Normal = 40203,
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
                    Name = "Chestguard of Bitter Charms",
                    IDs = {
                        Normal = 40210,
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
                    Name = "Iron-Spring Jumpers",
                    IDs = {
                        Normal = 40206,
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
                    Name = "Legguards of the Apostle",
                    IDs = {
                        Normal = 40204,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 6. Loatheb
        -------------------------------------------------

        {
            Order = 6,
            Name = "Loatheb",
            NPCID = 16011,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Sulfur Stave",
                    IDs = {
                        Normal = 39256,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Loatheb's Shadow",
                    IDs = {
                        Normal = 39257,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Fungi-Stained Coverings",
                    IDs = {
                        Normal = 39259,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Helm of the Corrupted Mind",
                    IDs = {
                        Normal = 39260,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Legplates of Inescapable Death",
                    IDs = {
                        Normal = 39258,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "The Hand of Nerub",
                    IDs = {
                        Normal = 40239,
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
                    Name = "The Impossible Dream",
                    IDs = {
                        Normal = 40244,
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
                    Name = "Fading Glow",
                    IDs = {
                        Normal = 40245,
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
                    Name = "Boots of Impetuous Ideals",
                    IDs = {
                        Normal = 40246,
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
                    Name = "Cowl of Innocent Delight",
                    IDs = {
                        Normal = 40247,
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
                    Name = "Vest of Vitality",
                    IDs = {
                        Normal = 40249,
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
                    Name = "Footwraps of Vile Deceit",
                    IDs = {
                        Normal = 40243,
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
                    Name = "Grotesque Handgrips",
                    IDs = {
                        Normal = 40242,
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
                    Name = "Greaves of Turbulence",
                    IDs = {
                        Normal = 40240,
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
                    Name = "Girdle of Unity",
                    IDs = {
                        Normal = 40241,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Spaulders of the Lost Conqueror",
                    IDs = {
                        Normal = 40622,
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
                    Name = "Spaulders of the Lost Protector",
                    IDs = {
                        Normal = 40623,
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
                    Name = "Spaulders of the Lost Vanquisher",
                    IDs = {
                        Normal = 40624,
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
                    Name = "Mantle of the Lost Conqueror",
                    IDs = {
                        Normal = 40637,
                        Heroic = nil,
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
                    Name = "Mantle of the Lost Protector",
                    IDs = {
                        Normal = 40638,
                        Heroic = nil,
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
                    Name = "Mantle of the Lost Vanquisher",
                    IDs = {
                        Normal = 40639,
                        Heroic = nil,
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
        -- 7. Instructor Razuvious
        -------------------------------------------------

        {
            Order = 7,
            Name = "Instructor Razuvious",
            NPCID = 16061,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Accursed Bow of the Elite",
                    IDs = {
                        Normal = 39296,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Scepter of Murmuring Spirits",
                    IDs = {
                        Normal = 39311,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Off Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Cloak of Darkening",
                    IDs = {
                        Normal = 39297,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Leggings of the Instructor",
                    IDs = {
                        Normal = 39309,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Mantle of the Extensive Mind",
                    IDs = {
                        Normal = 39310,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Rapid Attack Gloves",
                    IDs = {
                        Normal = 39299,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Girdle of Lenience",
                    IDs = {
                        Normal = 39308,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Iron Rings of Endurance",
                    IDs = {
                        Normal = 39307,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Waistguard of the Tutor",
                    IDs = {
                        Normal = 39298,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Plated Gloves of Relief",
                    IDs = {
                        Normal = 39306,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Idol of the Shooting Star",
                    IDs = {
                        Normal = 40321,
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
                    Name = "Totem of Dueling",
                    IDs = {
                        Normal = 40322,
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
                    Name = "Boots of Forlorn Wishes",
                    IDs = {
                        Normal = 40326,
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
                    Name = "Bindings of the Expansive Mind",
                    IDs = {
                        Normal = 40325,
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
                    Name = "Chestpiece of Suspicion",
                    IDs = {
                        Normal = 40319,
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
                    Name = "Spaulders of Egotism",
                    IDs = {
                        Normal = 40305,
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
                    Name = "Esteemed Bindings",
                    IDs = {
                        Normal = 40323,
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
                    Name = "Shoulderpads of Secret Arts",
                    IDs = {
                        Normal = 40315,
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
                    Name = "Girdle of Recuperation",
                    IDs = {
                        Normal = 40327,
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
                    Name = "Bands of Mutual Respect",
                    IDs = {
                        Normal = 40324,
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
                    Name = "Faithful Steel Sabatons",
                    IDs = {
                        Normal = 40320,
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
                    Name = "Gauntlets of Guiding Touch",
                    IDs = {
                        Normal = 40316,
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
                    Name = "Legplates of Double Strikes",
                    IDs = {
                        Normal = 40318,
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
                    Name = "Girdle of Razuvious",
                    IDs = {
                        Normal = 40317,
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
                    Name = "Bracers of the Unholy Knight",
                    IDs = {
                        Normal = 40306,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 8. Gothik the Harvester
        -------------------------------------------------

        {
            Order = 8,
            Name = "Gothik the Harvester",
            NPCID = 16060,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Slayer of the Lifeless",
                    IDs = {
                        Normal = 39344,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Spirit-World Glass",
                    IDs = {
                        Normal = 39388,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Signet of the Malevolent",
                    IDs = {
                        Normal = 39389,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Veiled Amulet of Life",
                    IDs = {
                        Normal = 39392,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Resurgent Phantom Bindings",
                    IDs = {
                        Normal = 39390,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Tunic of Dislocation",
                    IDs = {
                        Normal = 39386,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Heinous Mail Chestguard",
                    IDs = {
                        Normal = 39391,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Spectral Rider's Girdle",
                    IDs = {
                        Normal = 39379,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Sabatons of Deathlike Gloom",
                    IDs = {
                        Normal = 39369,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Girdle of the Ascended Phantom",
                    IDs = {
                        Normal = 39345,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Touch of Horror",
                    IDs = {
                        Normal = 40335,
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
                    Name = "Life and Death",
                    IDs = {
                        Normal = 40336,
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
                    Name = "Dying Curse",
                    IDs = {
                        Normal = 40255,
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
                    Name = "Grim Toll",
                    IDs = {
                        Normal = 40256,
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
                    Name = "Defender's Code",
                    IDs = {
                        Normal = 40257,
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
                    Name = "Forethought Talisman",
                    IDs = {
                        Normal = 40258,
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
                    Name = "Aged Winter Cloak",
                    IDs = {
                        Normal = 40250,
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
                    Name = "Shroud of Luminosity",
                    IDs = {
                        Normal = 40251,
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
                    Name = "Cloak of the Shadowed Sun",
                    IDs = {
                        Normal = 40252,
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
                    Name = "Shawl of the Old Maid",
                    IDs = {
                        Normal = 40253,
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
                    Name = "Cloak of Averted Crisis",
                    IDs = {
                        Normal = 40254,
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
                    Name = "Libram of Resurgence",
                    IDs = {
                        Normal = 40337,
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
                    Name = "Idol of Awakening",
                    IDs = {
                        Normal = 40342,
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
                    Name = "Gothik's Cowl",
                    IDs = {
                        Normal = 40339,
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
                    Name = "Bindings of Yearning",
                    IDs = {
                        Normal = 40338,
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
                    Name = "Hood of the Exodus",
                    IDs = {
                        Normal = 40329,
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
                    Name = "Leggings of Fleeting Moments",
                    IDs = {
                        Normal = 40333,
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
                    Name = "Shackled Cinch",
                    IDs = {
                        Normal = 40341,
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
                    Name = "Helm of Unleashed Energy",
                    IDs = {
                        Normal = 40340,
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
                    Name = "Leggings of Failed Escape",
                    IDs = {
                        Normal = 40331,
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
                    Name = "Helm of Vital Protection",
                    IDs = {
                        Normal = 40328,
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
                    Name = "Burdened Shoulderplates",
                    IDs = {
                        Normal = 40334,
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
                    Name = "Bracers of Unrelenting Attack",
                    IDs = {
                        Normal = 40330,
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
                    Name = "Abetment Bracers",
                    IDs = {
                        Normal = 40332,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 9. The Four Horsemen
        -------------------------------------------------

        {
            Order = 9,
            Name = "The Four Horsemen",
            NPCID = nil,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Claymore of Ancient Power",
                    IDs = {
                        Normal = 39393,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Charmed Cierge",
                    IDs = {
                        Normal = 39394,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Gown of Blaumeux",
                    IDs = {
                        Normal = 39396,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Pauldrons of Havoc",
                    IDs = {
                        Normal = 39397,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Thane's Tainted Greathelm",
                    IDs = {
                        Normal = 39395,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Damnation",
                    IDs = {
                        Normal = 40348,
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
                    Name = "Armageddon",
                    IDs = {
                        Normal = 40343,
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
                    Name = "Broken Promise",
                    IDs = {
                        Normal = 40345,
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
                    Name = "Final Voyage",
                    IDs = {
                        Normal = 40346,
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
                    Name = "Urn of Lost Memories",
                    IDs = {
                        Normal = 40350,
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
                    Name = "Mantle of the Corrupted",
                    IDs = {
                        Normal = 40286,
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
                    Name = "Gloves of Peaceful Death",
                    IDs = {
                        Normal = 40349,
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
                    Name = "Helm of the Grave",
                    IDs = {
                        Normal = 40344,
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
                    Name = "Pauldrons of Havoc",
                    IDs = {
                        Normal = 39397,
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
                    Name = "Leggings of Voracious Shadows",
                    IDs = {
                        Normal = 40352,
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
                    Name = "Zeliek's Gauntlets",
                    IDs = {
                        Normal = 40347,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Chestguard of the Lost Conqueror",
                    IDs = {
                        Normal = 40610,
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
                    Name = "Chestguard of the Lost Protector",
                    IDs = {
                        Normal = 40611,
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
                    Name = "Chestguard of the Lost Vanquisher",
                    IDs = {
                        Normal = 40612,
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
                    Name = "Breastplate of the Lost Conqueror",
                    IDs = {
                        Normal = 40625,
                        Heroic = nil,
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
                    Name = "Breastplate of the Lost Protector",
                    IDs = {
                        Normal = 40626,
                        Heroic = nil,
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
                    Name = "Breastplate of the Lost Vanquisher",
                    IDs = {
                        Normal = 40627,
                        Heroic = nil,
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
        -- 10. Patchwerk
        -------------------------------------------------

        {
            Order = 10,
            Name = "Patchwerk",
            NPCID = 16028,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Blade of Dormant Memories",
                    IDs = {
                        Normal = 39271,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Hatestrike",
                    IDs = {
                        Normal = 39270,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Drape of Surgery",
                    IDs = {
                        Normal = 39272,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Sullen Cloth Boots",
                    IDs = {
                        Normal = 39273,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Contagion Gloves",
                    IDs = {
                        Normal = 39275,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Retcher's Shoulderpads",
                    IDs = {
                        Normal = 39274,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Gauntlets of Combined Strength",
                    IDs = {
                        Normal = 39262,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Abomination Shoulderblades",
                    IDs = {
                        Normal = 39267,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Tainted Girdle of Mending",
                    IDs = {
                        Normal = 39261,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Split Greathammer",
                    IDs = {
                        Normal = 40264,
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
                    Name = "Arrowsong",
                    IDs = {
                        Normal = 40265,
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
                    Name = "Hero's Surrender",
                    IDs = {
                        Normal = 40266,
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
                    Name = "Surplus Limb",
                    IDs = {
                        Normal = 40273,
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
                    Name = "Strong-Handed Ring",
                    IDs = {
                        Normal = 40074,
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
                    Name = "Ruthlessness",
                    IDs = {
                        Normal = 40075,
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
                    Name = "Lost Jewel",
                    IDs = {
                        Normal = 40080,
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
                    Name = "Sand-Worn Band",
                    IDs = {
                        Normal = 40107,
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
                    Name = "Seized Beauty",
                    IDs = {
                        Normal = 40108,
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
                    Name = "Thunderstorm Amulet",
                    IDs = {
                        Normal = 40064,
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
                    Name = "Fool's Trial",
                    IDs = {
                        Normal = 40065,
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
                    Name = "Heritage",
                    IDs = {
                        Normal = 40069,
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
                    Name = "Chains of Adoration",
                    IDs = {
                        Normal = 40071,
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
                    Name = "Totem of Hex",
                    IDs = {
                        Normal = 40267,
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
                    Name = "Libram of Tolerance",
                    IDs = {
                        Normal = 40268,
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
                    Name = "Boots of Persuasion",
                    IDs = {
                        Normal = 40269,
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
                    Name = "Sash of Solitude",
                    IDs = {
                        Normal = 40271,
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
                    Name = "Boots of Septic Wounds",
                    IDs = {
                        Normal = 40270,
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
                    Name = "Belt of the Tortured",
                    IDs = {
                        Normal = 40260,
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
                    Name = "Gloves of Calculated Risk",
                    IDs = {
                        Normal = 40262,
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
                    Name = "Girdle of the Gambit",
                    IDs = {
                        Normal = 40272,
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
                    Name = "Crude Discolored Battlegrips",
                    IDs = {
                        Normal = 40261,
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
                    Name = "Fleshless Girdle",
                    IDs = {
                        Normal = 40263,
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
                    Name = "Waistguard of Divine Grace",
                    IDs = {
                        Normal = 40259,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 11. Grobbulus
        -------------------------------------------------

        {
            Order = 11,
            Name = "Grobbulus",
            NPCID = 15931,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "The Skull of Ruin",
                    IDs = {
                        Normal = 39276,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shield",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Infection Repulser",
                    IDs = {
                        Normal = 39281,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Sealing Ring of Grobbulus",
                    IDs = {
                        Normal = 39277,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Bone-Linked Amulet",
                    IDs = {
                        Normal = 39282,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Handgrips of Turmoil",
                    IDs = {
                        Normal = 39285,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Miasma Mantle",
                    IDs = {
                        Normal = 39284,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Blistered Belt of Decay",
                    IDs = {
                        Normal = 39279,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Putrescent Bands",
                    IDs = {
                        Normal = 39283,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Bands of Anxiety",
                    IDs = {
                        Normal = 39278,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Leggings of Innumerable Barbs",
                    IDs = {
                        Normal = 39280,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Origin of Nightmares",
                    IDs = {
                        Normal = 40280,
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
                    Name = "Twilight Mist",
                    IDs = {
                        Normal = 40281,
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
                    Name = "Plague Igniter",
                    IDs = {
                        Normal = 40284,
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
                    Name = "Dying Curse",
                    IDs = {
                        Normal = 40255,
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
                    Name = "Grim Toll",
                    IDs = {
                        Normal = 40256,
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
                    Name = "Defender's Code",
                    IDs = {
                        Normal = 40257,
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
                    Name = "Forethought Talisman",
                    IDs = {
                        Normal = 40258,
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
                    Name = "Aged Winter Cloak",
                    IDs = {
                        Normal = 40250,
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
                    Name = "Shroud of Luminosity",
                    IDs = {
                        Normal = 40251,
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
                    Name = "Cloak of the Shadowed Sun",
                    IDs = {
                        Normal = 40252,
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
                    Name = "Shawl of the Old Maid",
                    IDs = {
                        Normal = 40253,
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
                    Name = "Cloak of Averted Crisis",
                    IDs = {
                        Normal = 40254,
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
                    Name = "Cowl of Vanity",
                    IDs = {
                        Normal = 40287,
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
                    Name = "Sympathetic Amice",
                    IDs = {
                        Normal = 40289,
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
                    Name = "Mantle of the Fatigued Sage",
                    IDs = {
                        Normal = 40351,
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
                    Name = "Tunic of Indulgence",
                    IDs = {
                        Normal = 40277,
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
                    Name = "Desecrated Past",
                    IDs = {
                        Normal = 40285,
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
                    Name = "Fallout Impervious Tunic",
                    IDs = {
                        Normal = 40283,
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
                    Name = "Spaulders of Incoherence",
                    IDs = {
                        Normal = 40288,
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
                    Name = "Depraved Linked Belt",
                    IDs = {
                        Normal = 40275,
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
                    Name = "Slime Stream Bands",
                    IDs = {
                        Normal = 40282,
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
                    Name = "Chestguard of the Exhausted",
                    IDs = {
                        Normal = 40279,
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
                    Name = "Girdle of Chivalry",
                    IDs = {
                        Normal = 40278,
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
                    Name = "Bracers of Liberation",
                    IDs = {
                        Normal = 40274,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Wrist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 12. Gluth
        -------------------------------------------------

        {
            Order = 12,
            Name = "Gluth",
            NPCID = 15932,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Drape of Surgery",
                    IDs = {
                        Normal = 39272,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Miasma Mantle",
                    IDs = {
                        Normal = 39284,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Gown of Blaumeux",
                    IDs = {
                        Normal = 39396,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Leggings of the Instructor",
                    IDs = {
                        Normal = 39309,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Spaulders of Resumed Battle",
                    IDs = {
                        Normal = 39237,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Blistered Belt of Decay",
                    IDs = {
                        Normal = 39279,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Splint-Bound Leggings",
                    IDs = {
                        Normal = 39191,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Boots of the Follower",
                    IDs = {
                        Normal = 39215,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Feet",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Arc-Scorched Helmet",
                    IDs = {
                        Normal = 39294,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Tunic of the Lost Pack",
                    IDs = {
                        Normal = 39248,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Rusted-Link Spiked Gauntlets",
                    IDs = {
                        Normal = 39194,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Hands",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Necrogenic Belt",
                    IDs = {
                        Normal = 39251,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Spectral Rider's Girdle",
                    IDs = {
                        Normal = 39379,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Chivalric Chestguard",
                    IDs = {
                        Normal = 39188,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Girdle of the Ascended Phantom",
                    IDs = {
                        Normal = 39345,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Waist",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Collar of Dissolution",
                    IDs = {
                        Normal = 39146,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Pendant of Lost Vocations",
                    IDs = {
                        Normal = 39232,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Band of Neglected Pleas",
                    IDs = {
                        Normal = 39193,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Spirit-World Glass",
                    IDs = {
                        Normal = 39388,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Grieving Spellblade",
                    IDs = {
                        Normal = 39200,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },
                
                {
                    Name = "Slayer of the Lifeless",
                    IDs = {
                        Normal = 39344,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Infection Repulser",
                    IDs = {
                        Normal = 39281,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Charmed Cierge",
                    IDs = {
                        Normal = 39394,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Cowl of Innocent Delight",
                    IDs = {
                        Normal = 40247,
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
                    Name = "Sympathetic Amice",
                    IDs = {
                        Normal = 40289,
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
                    Name = "Robes of Mutation",
                    IDs = {
                        Normal = 40602,
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
                    Name = "Gloves of Token Respect",
                    IDs = {
                        Normal = 39733,
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
                    Name = "Wraps of the Persecuted",
                    IDs = {
                        Normal = 40303,
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
                    Name = "Boots of Forlorn Wishes",
                    IDs = {
                        Normal = 40326,
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
                    Name = "Cover of Silence",
                    IDs = {
                        Normal = 40296,
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
                    Name = "Cowl of the Perished",
                    IDs = {
                        Normal = 39768,
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
                    Name = "Chestpiece of Suspicion",
                    IDs = {
                        Normal = 40319,
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
                    Name = "Belt of the Tortured",
                    IDs = {
                        Normal = 40260,
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
                    Name = "Stalk-Skin Belt",
                    IDs = {
                        Normal = 40205,
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
                    Name = "Boots of Septic Wounds",
                    IDs = {
                        Normal = 40270,
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
                    Name = "Tunic of Masked Suffering",
                    IDs = {
                        Normal = 40193,
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
                    Name = "Bindings of the Decrepit",
                    IDs = {
                        Normal = 40209,
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
                    Name = "Benefactor's Gauntlets",
                    IDs = {
                        Normal = 40302,
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
                    Name = "Corpse Scarab Handguards",
                    IDs = {
                        Normal = 39718,
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
                    Name = "Grotesque Handgrips",
                    IDs = {
                        Normal = 40242,
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
                    Name = "Helm of Diminished Pride",
                    IDs = {
                        Normal = 39760,
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
                    Name = "Shoulderguards of Opportunity",
                    IDs = {
                        Normal = 40185,
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
                    Name = "Breastplate of Tormented Rage",
                    IDs = {
                        Normal = 40203,
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
                    Name = "Abetment Bracers",
                    IDs = {
                        Normal = 40332,
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
                    Name = "Gauntlets of the Disobedient",
                    IDs = {
                        Normal = 40188,
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
                    Name = "Waistguard of Divine Grace",
                    IDs = {
                        Normal = 40259,
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
                    Name = "Legguards of the Apostle",
                    IDs = {
                        Normal = 40204,
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
                    Name = "Inexorable Sabatons",
                    IDs = {
                        Normal = 39717,
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
                    Name = "Iron-Spring Jumpers",
                    IDs = {
                        Normal = 40206,
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
                    Name = "Sabatons of Endurance",
                    IDs = {
                        Normal = 40297,
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
                    Name = "Urn of Lost Memories",
                    IDs = {
                        Normal = 40350,
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
                    Name = "Libram of Radiance",
                    IDs = {
                        Normal = 40191,
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
                    Name = "Twilight Mist",
                    IDs = {
                        Normal = 40281,
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
                    Name = "Webbed Death",
                    IDs = {
                        Normal = 39714,
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
                    Name = "Widow's Fury",
                    IDs = {
                        Normal = 39730,
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
                    Name = "Armageddon",
                    IDs = {
                        Normal = 40343,
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
                    Name = "The Hand of Nerub",
                    IDs = {
                        Normal = 40239,
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
                    Name = "Origin of Nightmares",
                    IDs = {
                        Normal = 40280,
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
                    Name = "Shield of Assimilation",
                    IDs = {
                        Normal = 39716,
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
                    Name = "Arrowsong",
                    IDs = {
                        Normal = 40265,
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
                    Name = "Final Voyage",
                    IDs = {
                        Normal = 40346,
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
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Spaulders of the Lost Conqueror",
                    IDs = {
                        Normal = 40622,
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
                    Name = "Spaulders of the Lost Protector",
                    IDs = {
                        Normal = 40623,
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
                    Name = "Spaulders of the Lost Vanquisher",
                    IDs = {
                        Normal = 40624,
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
                    Name = "Chestguard of the Lost Conqueror",
                    IDs = {
                        Normal = 40610,
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
                    Name = "Chestguard of the Lost Protector",
                    IDs = {
                        Normal = 40611,
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
                    Name = "Chestguard of the Lost Vanquisher",
                    IDs = {
                        Normal = 40612,
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
                    Name = "Leggings of the Lost Conqueror",
                    IDs = {
                        Normal = 40619,
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
                    Name = "Leggings of the Lost Protector",
                    IDs = {
                        Normal = 40620,
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
                    Name = "Leggings of the Lost Vanquisher",
                    IDs = {
                        Normal = 40621,
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
                    Name = "Mantle of the Lost Conqueror",
                    IDs = {
                        Normal = 40637,
                        Heroic = nil,
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
                    Name = "Mantle of the Lost Protector",
                    IDs = {
                        Normal = 40638,
                        Heroic = nil,
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
                    Name = "Mantle of the Lost Vanquisher",
                    IDs = {
                        Normal = 40639,
                        Heroic = nil,
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
                    Name = "Breastplate of the Lost Conqueror",
                    IDs = {
                        Normal = 40625,
                        Heroic = nil,
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
                    Name = "Breastplate of the Lost Protector",
                    IDs = {
                        Normal = 40626,
                        Heroic = nil,
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
                    Name = "Breastplate of the Lost Vanquisher",
                    IDs = {
                        Normal = 40627,
                        Heroic = nil,
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
                    Name = "Legplates of the Lost Conqueror",
                    IDs = {
                        Normal = 40634,
                        Heroic = nil,
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
                    Name = "Legplates of the Lost Protector",
                    IDs = {
                        Normal = 40635,
                        Heroic = nil,
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
                    Name = "Legplates of the Lost Vanquisher",
                    IDs = {
                        Normal = 40636,
                        Heroic = nil,
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
        -- 13. Thaddius
        -------------------------------------------------

        {
            Order = 13,
            Name = "Thaddius",
            NPCID = 15928,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Torment of the Banished",
                    IDs = {
                        Normal = 39291,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Repelling Charge",
                    IDs = {
                        Normal = 39292,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Trinket",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Cowl of Sheet Lightning",
                    IDs = {
                        Normal = 39295,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Arc-Scorched Helmet",
                    IDs = {
                        Normal = 39294,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Blackened Legplates of Feugen",
                    IDs = {
                        Normal = 39293,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Spire of Sunset",
                    IDs = {
                        Normal = 40300,
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
                    Name = "Wraps of the Persecuted",
                    IDs = {
                        Normal = 40303,
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
                    Name = "Cincture of Polarity",
                    IDs = {
                        Normal = 40301,
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
                    Name = "Cover of Silence",
                    IDs = {
                        Normal = 40296,
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
                    Name = "Headpiece of Fungal Bloom",
                    IDs = {
                        Normal = 40304,
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
                    Name = "Benefactor's Gauntlets",
                    IDs = {
                        Normal = 40302,
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
                    Name = "Pauldrons of the Abandoned",
                    IDs = {
                        Normal = 40299,
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
                    Name = "Sabatons of Endurance",
                    IDs = {
                        Normal = 40297,
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
                    Name = "Faceguard of the Succumbed",
                    IDs = {
                        Normal = 40298,
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
                    Name = "Riveted Abomination Leggings",
                    IDs = {
                        Normal = 40294,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Leggings of the Lost Conqueror",
                    IDs = {
                        Normal = 40619,
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
                    Name = "Leggings of the Lost Protector",
                    IDs = {
                        Normal = 40620,
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
                    Name = "Leggings of the Lost Vanquisher",
                    IDs = {
                        Normal = 40621,
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
                    Name = "Legplates of the Lost Conqueror",
                    IDs = {
                        Normal = 40634,
                        Heroic = nil,
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
                    Name = "Legplates of the Lost Protector",
                    IDs = {
                        Normal = 40635,
                        Heroic = nil,
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
                    Name = "Legplates of the Lost Vanquisher",
                    IDs = {
                        Normal = 40636,
                        Heroic = nil,
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
        -- 14. Sapphiron
        -------------------------------------------------

        {
            Order = 14,
            Name = "Sapphiron",
            NPCID = 15989,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Key to the Focusing Iris",
                    IDs = {
                        Normal = 44569,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Quest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Cloak of Mastery",
                    IDs = {
                        Normal = 39404,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Shroud of the Citadel",
                    IDs = {
                        Normal = 39415,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Circle of Death",
                    IDs = {
                        Normal = 39401,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Circle of Life",
                    IDs = {
                        Normal = 39407,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Finger",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Cowl of Winged Fear",
                    IDs = {
                        Normal = 39409,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Leggings of Sapphiron",
                    IDs = {
                        Normal = 39408,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Helm of the Vast Legions",
                    IDs = {
                        Normal = 39399,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Helmet of the Inner Sanctum",
                    IDs = {
                        Normal = 39405,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Massive Skeletal Ribcage",
                    IDs = {
                        Normal = 39398,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Chest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Helm of the Unsubmissive",
                    IDs = {
                        Normal = 39403,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Heroic Key to the Focusing Iris",
                    IDs = {
                        Normal = 44577,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Quest",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },

                {
                    Name = "Murder",
                    IDs = {
                        Normal = 40368,
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
                    Name = "Bandit's Insignia",
                    IDs = {
                        Normal = 40371,
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
                    Name = "Rune of Repulsion",
                    IDs = {
                        Normal = 40372,
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
                    Name = "Extract of Necromantic Power",
                    IDs = {
                        Normal = 40373,
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
                    Name = "Soul of the Dead",
                    IDs = {
                        Normal = 40382,
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
                    Name = "Gatekeeper",
                    IDs = {
                        Normal = 40370,
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
                    Name = "Ring of Decaying Beauty",
                    IDs = {
                        Normal = 40375,
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
                    Name = "Icy Blast Amulet",
                    IDs = {
                        Normal = 40369,
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
                    Name = "Cosmic Lights",
                    IDs = {
                        Normal = 40374,
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
                    Name = "Ceaseless Pity",
                    IDs = {
                        Normal = 40378,
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
                    Name = "Sympathy",
                    IDs = {
                        Normal = 40381,
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
                    Name = "Gloves of Grandeur",
                    IDs = {
                        Normal = 40380,
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
                    Name = "Legwraps of the Defeated Dragon",
                    IDs = {
                        Normal = 40376,
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
                    Name = "Gloves of Fast Reactions",
                    IDs = {
                        Normal = 40362,
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
                    Name = "Legguards of the Boneyard",
                    IDs = {
                        Normal = 40379,
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
                    Name = "Boots of the Great Construct",
                    IDs = {
                        Normal = 40367,
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
                    Name = "Breastplate of Frozen Pain",
                    IDs = {
                        Normal = 40365,
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
                    Name = "Platehelm of the Great Wyrm",
                    IDs = {
                        Normal = 40366,
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
                    Name = "Bone-Inlaid Legguards",
                    IDs = {
                        Normal = 40363,
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
                    Name = "Noble Birthright Pauldrons",
                    IDs = {
                        Normal = 40377,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Shoulder",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },
            },
        },

        -------------------------------------------------
        -- 15. Kel'Thuzad
        -------------------------------------------------

        {
            Order = 15,
            Name = "Kel'Thuzad",
            NPCID = 15990,

            Loot = {

                -------------------------------------------------
                -- 10 Man
                -------------------------------------------------

                {
                    Name = "Helm of the Lost Conqueror",
                    IDs = {
                        Normal = 40616,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = true,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Helm of the Lost Protector",
                    IDs = {
                        Normal = 40617,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = true,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Helm of the Lost Vanquisher",
                    IDs = {
                        Normal = 40618,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Head",
                    Token = true,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Kel'Thuzad's Reach",
                    IDs = {
                        Normal = 39416,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Death's Bite",
                    IDs = {
                        Normal = 39417,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Nerubian Conquerer",
                    IDs = {
                        Normal = 39419,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Anarchy",
                    IDs = {
                        Normal = 39420,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Staff of the Plaguehound",
                    IDs = {
                        Normal = 39422,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Two-Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Hammer of the Astral Plane",
                    IDs = {
                        Normal = 39423,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "The Soulblade",
                    IDs = {
                        Normal = 39424,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Main Hand",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Wand of the Archlich",
                    IDs = {
                        Normal = 39426,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Ranged",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Cloak of the Dying",
                    IDs = {
                        Normal = 39425,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Back",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                {
                    Name = "Gem of Imprisoned Vassals",
                    IDs = {
                        Normal = 39421,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Neck",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                },

                -------------------------------------------------
                -- 25 Man
                -------------------------------------------------

                {
                    Name = "Calamity's Grasp",
                    IDs = {
                        Normal = 40383,
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
                    Name = "Betrayer of Humanity",
                    IDs = {
                        Normal = 40384,
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
                    Name = "Envoy of Mortality",
                    IDs = {
                        Normal = 40385,
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
                    Name = "Sinister Revenge",
                    IDs = {
                        Normal = 40386,
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
                    Name = "Journey's End",
                    IDs = {
                        Normal = 40388,
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
                    Name = "Torch of Holy Fire",
                    IDs = {
                        Normal = 40395,
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
                    Name = "The Turning Tide",
                    IDs = {
                        Normal = 40396,
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
                    Name = "Wall of Terror",
                    IDs = {
                        Normal = 40400,
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
                    Name = "Voice of Reason",
                    IDs = {
                        Normal = 40401,
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
                    Name = "Last Laugh",
                    IDs = {
                        Normal = 40402,
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
                    Name = "Drape of the Deadly Foe",
                    IDs = {
                        Normal = 40403,
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
                    Name = "Cape of the Unworthy Wizard",
                    IDs = {
                        Normal = 40405,
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
                    Name = "Signet of Manifested Pain",
                    IDs = {
                        Normal = 40399,
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
                    Name = "Boundless Ambition",
                    IDs = {
                        Normal = 40387,
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
                    Name = "Leggings of Mortal Arrogance",
                    IDs = {
                        Normal = 40398,
                        Heroic = nil,
                    },
                    Quality = 4,
                    Slot = "Legs",
                    Token = false,
                    Classes = nil,
                    Notes = nil,
                Difficulty = "25",
                    },

                -------------------------------------------------
                -- Tier Tokens
                -------------------------------------------------

                {
                    Name = "Crown of the Lost Conqueror",
                    IDs = {
                        Normal = 40631,
                        Heroic = nil,
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
                    Name = "Crown of the Lost Protector",
                    IDs = {
                        Normal = 40632,
                        Heroic = nil,
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
                    Name = "Crown of the Lost Vanquisher",
                    IDs = {
                        Normal = 40633,
                        Heroic = nil,
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
    },

    -------------------------------------------------
    -- Trash
    -------------------------------------------------

    Trash = {

        -------------------------------------------------
        -- 10 Man
        -------------------------------------------------

        {
            Name = "Omen of Ruin",
            IDs = {
                Normal = 39427,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Main Hand",
            Token = false,
            Classes = nil,
            Notes = nil,
        },

        {
            Name = "The Stray",
            IDs = {
                Normal = 39468,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Off Hand",
            Token = false,
            Classes = nil,
            Notes = nil,
        },

        {
            Name = "Contortion",
            IDs = {
                Normal = 39473,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Ranged",
            Token = false,
            Classes = nil,
            Notes = nil,
        },

        {
            Name = "Medallion of the Disgraced",
            IDs = {
                Normal = 39470,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Neck",
            Token = false,
            Classes = nil,
            Notes = nil,
        },

        {
            Name = "Chain of Latent Energies",
            IDs = {
                Normal = 39472,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Neck",
            Token = false,
            Classes = nil,
            Notes = nil,
        },

        {
            Name = "Minion Bracers",
            IDs = {
                Normal = 39467,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Wrist",
            Token = false,
            Classes = nil,
            Notes = nil,
        },

        -------------------------------------------------
        -- 25 Man
        -------------------------------------------------

        {
            Name = "Inevitable Defeat",
            IDs = {
                Normal = 40406,
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
            Name = "Silent Crusader",
            IDs = {
                Normal = 40407,
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
            Name = "Haunting Call",
            IDs = {
                Normal = 40408,
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
            Name = "Shadow of the Ghoul",
            IDs = {
                Normal = 40410,
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
            Name = "Ousted Bead Necklace",
            IDs = {
                Normal = 40412,
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
            Name = "Boots of the Escaped Captive",
            IDs = {
                Normal = 40409,
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
            Name = "Shoulderguards of the Undaunted",
            IDs = {
                Normal = 40414,
                Heroic = nil,
            },
            Quality = 4,
            Slot = "Shoulder",
            Token = false,
            Classes = nil,
            Notes = nil,
            Difficulty = "25",
        },

    },

}

ImpLoot.Database:RegisterRaid(NAX)