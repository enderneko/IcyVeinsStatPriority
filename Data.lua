local addonName, IVSP = ...

local data = {
    -- 250 - Death Knight: Blood
    [250] = {
        {"Haste > Versatility > Critical Strike > Mastery", "Balanced (Recommended)"},
        {"Haste > Versatility > Mastery > Critical Strike", "Survivability"},
        {"Haste > Critical Strike > Versatility > Mastery", "DPS-oriented"},
    },
    -- 251 - Death Knight: Frost
    [251] = {
        {"Strength > Mastery 40% > Haste 30% > Critical Strike 30% > Versatility"},
    },
    -- 252 - Death Knight: Unholy
    [252] = {
        {"Strength > Haste 26% > Mastery > Critical Strike = Versatility"},
    },

    -- 577 - Demon Hunter: Havoc
    [577] = {
        {"Critical Strike > Mastery > Versatility > Haste > Agility", "Demonic Build"},
        {"Critical Strike > Haste > Versatility > Agility > Mastery", "Classic Demon Blades Build"},
    },
    -- 581 - Demon Hunter: Vengeance
    [581] = {
        {"Agility > Haste 20% > Versatility >= Mastery > Critical Strike", "Survivability (Tier 21)"},
        {"Agility > Haste 20% >= Mastery > Versatility > Critical Strike", "Survivability"},
        {"Agility > Mastery > Versatility > Haste > Critical Strike", "Mythic+"},
        {"Agility > Critical Strike >= Versatility >= Mastery >= Haste", "Damage Output"},
    },

    --  Druid: Balance
    [102] = {
        {"Mastery = Haste > Critical Strike = Versatility > Intellect"},
    },
    -- Druid: Feral
    [103] = {
        {"Versatility > Critical Strike > Haste > Agility > Mastery", "Incarnation/Moment of Clarity"},
    },
    -- Druid: Guardian
    [104] = {
        {"Mastery = Haste > Critical Strike = Versatility > Intellect"},
    },
    -- Druid: Restoration
    [105] = {
        {"Mastery = Haste > Critical Strike = Versatility > Intellect"},
    },

    -- 253 - Hunter: Beast Mastery
    [253] = {
        {"Critical Strike > Haste > Mastery > Versatility"},
    },
    -- 254 - Hunter: Marksmanship
    [254] = {
        {"Mastery > Critical Strike > Haste > Versatility"},
    },
    -- 255 - Hunter: Survival
    [255] = {
        {"Haste > Critical Strike = Versatility > Mastery"},
    },

    -- 62 - Mage: Arcane
    [62] = {
        {"Haste > Versatility > Critical Strike > Mastery > Intellect"},
    },
    -- 63 - Mage: Fire
    [63] = {
        {"Critical Strike > Haste = Mastery > Versatility > Intellect", "Tier 21 4-piece"},
        {"Mastery > Haste = Mastery > Intellect > Critical Strike", "General"},
    },
    -- 64 - Mage: Frost
    [64] = {
        {"Versatility = Haste > Critical Strike ~30% > Intellect > Mastery"},
    },

    -- 268 - Monk: Brewmaster
    [268] = {
        {"Mastery = Critical Strike = Versatility > Haste 14.3%"},
    },
    -- 269 - Monk: Windwalker
    [269] = {
        {"Agility > Mastery > Critical Strike > Versatility > Haste", "Single Target"},
        {"Agility > Mastery > Haste > Critical Strike > Versatility", "Multiple Target"},
    },
    -- 270 - Monk: Mistweaver
    [270] = {
        {"Intellect > Critical Strike > Versatility > Haste > Mastery", "Mistweaving"},
        {"Intellect > Versatility > Haste >= Critical Strike > Mastery", "Fistweaving"},
        {"Intellect > Haste = Mastery > Versatility > Critical Strike", "Mythic+"},
    },

    -- 65 - Paladin: Holy
    [65] = {
        {"Intellect > Critical Strike > Mastery > Versatility > Haste"},
    },
    -- 66 - Paladin: Protection
    [66] = {
        {"Haste > Versatility > Mastery > Critical Strike", "Survivability"},
        {"Haste > Critical Strike > Mastery > Versatility", "DPS"},
    },
    -- 70 - Paladin: Retribution
    [70] = {
        {"Mastery ≈ Haste > Versatility ≈ Critical Strike = Strength"},
    },

    -- 256 - Priest: Discipline
    [256] = {
        {"Intellect > Haste > Critical Strike >= Mastery > Versatility"},
    },
    -- 257 - Priest: Holy
    [257] = {
        {"Intellect > Mastery > Critical Strike > Haste > Versatility"},
    },
    -- 258 - Priest: Shadow
    [258] = {
        {"Haste > Critical Strike > Mastery > Versatility > Intellect"},
    },

    -- 259 - Rogue: Assassination
    [259] = {
        {"Agility > Mastery > Versatility > Critical Strike > Haste", "Master Poisoner/Toxic Blade"},
        {"Agility > Mastery > Versatility > Critical Strike > Haste", "Elaborate Planning/Alacrity"},
        {"Agility > Versatility > Critical Strike > Mastery > Haste", "Elaborate Planning/Exsanguinate"},
    },
    -- 260 - Rogue: Outlaw
    [260] = {
        {"Versatility ≈ Haste > Agility > Critical Strike > Mastery"},
    },
    -- 261 - Rogue: Subtlety
    [261] = {
        {"Critical Strike > Versatility > Mastery > Agility > Haste", "Tier 21 4-piece"},
        {"Agility > Mastery >= Versatility > Critical Strike > Haste", "Tier 21 4-piece"},
    },

    -- 262 - Shaman: Elemental
    [262] = {
        {"Intellect > Critical Strike > Haste > Mastery = Versatility", "Gambler Build"},
        {"Intellect > Critical Strike > Mastery > Haste > Versatility", "Ascendance Build"},
        {"Intellect > Critical Strike > Haste > Mastery = Versatility", "Lightning Build"},
        {"Intellect > Critical Strike > Haste > Mastery = Versatility", "Icefury Build"},
    },
    -- 263 - Shaman: Enhancement
    [263] = {
        {"Haste = Mastery > Versatility > Critical Strike > Agility"},
    },
    -- 264 - Shaman: Restoration
    [264] = {
        {"Critical Strike > Versatility = Mastery = Haste > Intellect"},
    },

    -- 265 - Warlock: Affliction
    [265] = {
        {"Mastery > Haste > Critical Strike > Versatility > Intellect"},
    },
    -- 266 - Warlock: Demonology
    [266] = {
        {"Haste > Critical Strike = Mastery > Intellect > Versatility"},
    },
    -- 267 - Warlock: Destruction
    [267] = {
        {"Haste > Critical Strike > Intellect > Versatility > Mastery", "Without Tier 20 4-piece"},
        {"Haste > Mastery > Intellect > Critical Strike > Versatility", "With Tier 20 4-piece"},
    },

    -- 71 - Warrior: Arms
    [71] = {
        {"Mastery > Haste = Versatility = Critical Strike > Strength"},
    },
    -- 72 - Warrior: Fury
    [72] = {
        {"Haste >= Mastery > Versatility > Critical Strike > Strength"},
    },
    -- 73 - Warrior: Protection
    [73] = {
        {"Strength > Haste > Mastery >= Versatility > Critical Strike"},
    },
}

function IVSP:GetSPText(specID)
    if not data[specID] then return end

    local selected = IVSP_Config["selected"][specID] or 1
    if not data[specID][selected] then selected = 1 end -- data not exists
    local text = data[specID][selected][1]
    -- localize
    text = string.gsub(text, "Haste", STAT_HASTE)
    text = string.gsub(text, "Critical Strike", STAT_CRITICAL_STRIKE)
    text = string.gsub(text, "Mastery", STAT_MASTERY)
    text = string.gsub(text, "Versatility", STAT_VERSATILITY)
    text = string.gsub(text, "Strength", SPEC_FRAME_PRIMARY_STAT_STRENGTH)
    text = string.gsub(text, "Agility", SPEC_FRAME_PRIMARY_STAT_AGILITY)
    text = string.gsub(text, "Intellect", SPEC_FRAME_PRIMARY_STAT_INTELLECT)
    return text
end

function IVSP:GetSPDesc(specID)
    if data[specID] and #data[specID] ~= 1 then
        local desc = {}
        for _, t in pairs(data[specID]) do
            table.insert(desc, t[2] or " ")
        end
        return desc
    end
end