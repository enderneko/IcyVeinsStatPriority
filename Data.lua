local addonName, IVSP = ...

local data = {
    -- 250 - Death Knight: Blood
    [250] = {
        {"Haste > Versatility > Mastery > Critical Strike"},
    },
    -- 251 - Death Knight: Frost
    [251] = {
        {"Mastery > Critical Strike > Versatility > Haste"},
    },
    -- 252 - Death Knight: Unholy
    [252] = {
        {"Haste > Critical Strike = Versatility > Mastery"},
    },

    -- 577 - Demon Hunter: Havoc
    [577] = {
        {"Agility > Haste = Versatility > Critical Strike > Mastery"},
    },
    -- 581 - Demon Hunter: Vengeance
    [581] = {
        {"Agility > Haste > Versatility > Mastery > Critical Strike"},
    },

    --  Druid: Balance
    [102] = {
        {"Intellect > Haste > Critical Strike > Versatility > Mastery"},
    },
    -- Druid: Feral
    [103] = {
        {"Agility > Haste > Critical Strike > Versatility > Mastery"},
    },
    -- Druid: Guardian
    [104] = {
        {"Armor = Agility = Stamina > Mastery > Versatility > Haste > Critical Strike", "Survivability"},
        {"Haste >= Critical Strike >= Versatility >= Mastery", "Damage Output"},
    },
    -- Druid: Restoration
    [105] = {
        {"Intellect > Haste = Critical Strike = Versatility > Mastery", "Raid Healing"},
        {"Mastery = Haste > Intellect > Versatility > Critical Strike", "Dungeon Healing"},
    },

    -- 253 - Hunter: Beast Mastery
    [253] = {
        {"Haste > Critical Strike > Mastery > Versatility", "Single-Target"},
        {"Mastery > Haste > Critical Strike > Versatility", "Multi-Target"},
    },
    -- 254 - Hunter: Marksmanship
    [254] = {
        {"Haste > Mastery > Versatility > Critical Strike", "Single-Target"},
        {"Mastery > Haste > Critical Strike > Versatility", "Multi-Target"},
    },
    -- 255 - Hunter: Survival
    [255] = {
        {"Haste > Critical Strike > Versatility > Mastery"},
    },

    -- 62 - Mage: Arcane
    [62] = {
        {"Intellect > Critical Strike > Haste > Mastery > Versatility"},
    },
    -- 63 - Mage: Fire
    [63] = {
        {"Intellect > Mastery > Versatility > Haste > Critical Strike"},
    },
    -- 64 - Mage: Frost
    [64] = {
        {"Intellect > Critical Strike 33.34% > Haste > Versatility > Mastery"},
    },

    -- 268 - Monk: Brewmaster
    [268] = {
        {"Agility > Critical Strike = Versatility = Mastery > Haste"},
    },
    -- 269 - Monk: Windwalker
    [269] = {
        {"Weapon Damage > Agility > Versatility > Mastery > Critical Strike > Haste"},
    },
    -- 270 - Monk: Mistweaver
    [270] = {
        {"Intellect > Critical Strike > Versatility > Haste > Mastery", "Raiding"},
        {"Intellect > Haste = Mastery > Versatility > Critical Strike", "Mythic+"},
    },

    -- 65 - Paladin: Holy
    [65] = {
        {"Intellect > Critical Strike > Mastery > Haste > Versatility"},
    },
    -- 66 - Paladin: Protection
    [66] = {
        {"Haste > Mastery > Versatility > Critical Strike", "Survivability"},
    },
    -- 70 - Paladin: Retribution
    [70] = {
        {"Strength > Haste > Critical Strike ≈ Versatility ≈ Mastery"},
    },

    -- 256 - Priest: Discipline
    [256] = {
        {"Intellect > Haste > Critical Strike > Mastery > Versatility"},
    },
    -- 257 - Priest: Holy
    [257] = {
        {"Intellect > Mastery = Critical Strike > Versatility > Haste", "Raids"},
        {"Intellect > Critical Strike > Haste > Versatility > Mastery", "Dungeons"},
    },
    -- 258 - Priest: Shadow
    [258] = {
        {"Intellect > Haste = Critical Strike > Mastery > Versatility"},
    },

    -- 259 - Rogue: Assassination
    [259] = {
        {"Agility > Haste > Critical Strike > Mastery > Versatility"},
    },
    -- 260 - Rogue: Outlaw
    [260] = {
        {"Agility > Haste > Versatility > Critical Strike > Mastery"},
    },
    -- 261 - Rogue: Subtlety
    [261] = {
        {"Critical Strike > Haste > Mastery > Versatility", "Single-Target"},
        {"Mastery > Critical Strike > Versatility > Haste", "Multi-Target"},
    },

    -- 262 - Shaman: Elemental
    [262] = {
        {"Intellect > Haste > Versatility > Critical Strike > Mastery", "Single-Target"},
        {"Intellect > Haste > Critical Strike > Versatility > Mastery", "Multi-Target"},
    },
    -- 263 - Shaman: Enhancement
    [263] = {
        {"Agility > Haste > Critical Strike = Versatility > Mastery"},
    },
    -- 264 - Shaman: Restoration
    [264] = {
        {"Intellect > Critical Strike > Versatility > Haste = Mastery"},
    },

    -- 265 - Warlock: Affliction
    [265] = {
        {"Mastery > Intellect > Haste > Critical Strike ≈ Versatility"},
    },
    -- 266 - Warlock: Demonology
    [266] = {
        {"Intellect > Haste > Critical Strike ≈ Mastery > Versatility"},
    },
    -- 267 - Warlock: Destruction
    [267] = {
        {"Intellect > Haste > Critical Strike ≈ Mastery > Versatility"},
    },

    -- 71 - Warrior: Arms
    [71] = {
        {"Strength > Haste > Critical Strike > Mastery > Versatility"},
    },
    -- 72 - Warrior: Fury
    [72] = {
        {"Strength > Haste > Mastery > Versatility > Critical Strike"},
    },
    -- 73 - Warrior: Protection
    [73] = {
        {"Haste > Armor > Versatility > Mastery > Critical Strike > Strength"},
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
    text = string.gsub(text, "Armor", STAT_ARMOR)
    text = string.gsub(text, "Stamina", ITEM_MOD_STAMINA_SHORT)
    text = string.gsub(text, "Strength", SPEC_FRAME_PRIMARY_STAT_STRENGTH)
    text = string.gsub(text, "Agility", SPEC_FRAME_PRIMARY_STAT_AGILITY)
    text = string.gsub(text, "Intellect", SPEC_FRAME_PRIMARY_STAT_INTELLECT)
    text = string.gsub(text, "Weapon Damage", DAMAGE_TOOLTIP)
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