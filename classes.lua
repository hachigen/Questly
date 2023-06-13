-- classes.lua

-- Demo Class: ExampleClass
-- This is a demo class that shows how to use the child class files.
-- You can reference this class structure to understand how to use the child classes for other EverQuest classes.

local class_info = {
    {
        classShortName = "EXM",
        className = "ExampleClass",
        Invisibility = {
            {
                name = "Invisibility",
                activation = {
                    ability = "cast Invisibility",
                    level = 8,
                    type = "spell" -- Valid types: ability, aa (Alternate Advancement), spell
                }
            }
        },
        ivu = {
            {
                name = "IvU Evade",
                activation = {
                    ability = "IvU Evade",
                    level = 12,
                    type = "ability" -- Valid types: ability, aa (Alternate Advancement), spell
                }
            }
        },
        evade = {
            {
                name = "Evade",
                activation = {
                    ability = "Evade",
                    level = 6,
                    type = "ability" -- Valid types: ability, aa (Alternate Advancement), spell
                }
            }
        },
        sos = {
            {
                name = "SOS",
                activation = {
                    ability = "SOS",
                    level = 18,
                    type = "ability" -- Valid types: ability, aa (Alternate Advancement), spell
                }
            }
        }
    },
    -- Include the other EverQuest class files
    dofile("classes/Bard.lua"),
    dofile("classes/Beastlord.lua"),
    dofile("classes/Berserker.lua"),
    dofile("classes/Cleric.lua"),
    dofile("classes/Druid.lua"),
    dofile("classes/Enchanter.lua"),
    dofile("classes/Magician.lua"),
    dofile("classes/Monk.lua"),
    dofile("classes/Necromancer.lua"),
    dofile("classes/Paladin.lua"),
    dofile("classes/Ranger.lua"),
    dofile("classes/Rogue.lua"),
    dofile("classes/Shadowknight.lua"),
    dofile("classes/Shaman.lua"),
    dofile("classes/Warrior.lua"),
    dofile("classes/Wizard.lua")
}

return class_info
