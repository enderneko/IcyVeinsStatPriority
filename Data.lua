local addonName, IVSP = ...

local data = {
    -- 250 - Death Knight: Blood
    [250] = {
        {"Item Level > Versatility > Haste > Critical Strike > Mastery"},
    },
    -- 251 - Death Knight: Frost
    [251] = {
        {"Versatility > Mastery > Critical Strike > Haste"},
    },
    -- 252 - Death Knight: Unholy
    [252] = {
        {"Haste > Critical Strike = Versatility > Mastery"},
    },

    -- 577 - Demon Hunter: Havoc
    [577] = {
        {"Versatility > Critical Strike = Haste > Agility > Mastery"},
    },
    -- 581 - Demon Hunter: Vengeance
    [581] = {
        {"Agility > Haste > Versatility > Mastery > Critical Strike"},
    },

    -- 102 - Druid: Balance
    [102] = {
        {"Haste > Versatility = Critical Strike > Mastery > Intellect"},
    },
    -- 103 - Druid: Feral
    [103] = {
        {"Critical Strike > Mastery > Versatility > Haste > Agility"},
    },
    -- 104 - Druid: Guardian
    [104] = {
        {"Armor = Agility = Stamina > Versatility > Mastery > Haste > Critical Strike", "Survivability"},
        {"Haste ≥ Critical Strike ≥ Versatility ≥ Mastery", "Damage Output"},
    },
    -- Druid: Restoration
    [105] = {
        {"Mastery > Haste = Critical Strike = Versatility > Intellect", "Raid Healing"},
        {"Mastery = Haste > Versatility > Critical Strike > Intellect", "Dungeon Healing"},
    },

    -- 253 - Hunter: Beast Mastery
    [253] = {
        {"Critical Strike > Haste = Versatility > Mastery"},
    },
    -- 254 - Hunter: Marksmanship
    [254] = {
        {"Versatility = Mastery > Critical Strike = Haste"},
    },
    -- 255 - Hunter: Survival
    [255] = {
        {"Haste > Versatility = Critical Strike > Mastery"},
    },

    -- 62 - Mage: Arcane
    [62] = {
        {"Critical Strike > Haste > Mastery > Versatility > Intellect"},
    },
    -- 63 - Mage: Fire
    [63] = {
        {"Haste > Versatility > Mastery > Critical Strike > Intellect", "Single-Target"},
        {"Mastery (by far) > Haste > Versatility > Critical Strike > Intellect", "Multi-Target"},
    },
    -- 64 - Mage: Frost
    [64] = {
        {"Mastery > Critical Strike (to 33.34%) > Haste > Versatility > Intellect > (Critical Strike from 33.34)"},
    },

    -- 268 - Monk: Brewmaster
    [268] = {
        {"Agility > Mastery > Critical Strike = Versatility > Haste"},
    },
    -- 269 - Monk: Windwalker
    [269] = {
        {"Weapon Damage > Agility > Versatility > Mastery > Critical Strike > Haste"},
    },
    -- 270 - Monk: Mistweaver
    [270] = {
        {"Critical Strike > Mastery = Versatility > Intellect > Haste", "Mistweaving"},
        {"Critical Strike > Versatility > Haste > Mastery", "Fistweaving"},
        {"Intellect > Mastery ≥ Haste > Versatility > Critical Strike", "Mythic+"},
    },

    -- 65 - Paladin: Holy
    [65] = {
        {"Critical Strike > Haste > Versatility > Mastery > Intellect"},
    },
    -- 66 - Paladin: Protection
    [66] = {
        {"Haste > Mastery > Versatility > Critical Strike"},
    },
    -- 70 - Paladin: Retribution
    [70] = {
        {"Haste ≈ Critical Strike ≈ Versatility ≈ Mastery > Strength", "General"},
        {"Critical Strike > Haste ≈ Versatility ≈ Mastery > Strength", "Stacked Expurgation Azerite Trait"},
    },

    -- 256 - Priest: Discipline
    [256] = {
        {"Haste > Critical Strike > Intellect > Versatility > Mastery"},
    },
    -- 257 - Priest: Holy
    [257] = {
        {"Mastery = Critical Strike > Versatility > Intellect > Haste", "Raids"},
        {"Critical Strike > Haste > Versatility > Intellect > Mastery", "Dungeons"},
    },
    -- 258 - Priest: Shadow
    [258] = {
        {"Haste = Critical Strike >  Mastery = Versatility > Intellect"},
    },

    -- 259 - Rogue: Assassination
    [259] = {
        {"Critical Strike > Haste > Mastery > Versatility > Agility"},
    },
    -- 260 - Rogue: Outlaw
    [260] = {
        {"Critical Strike > Versatility > Haste > Mastery"},
    },
    -- 261 - Rogue: Subtlety
    [261] = {
        {"Critical Strike > Versatility > Haste > Mastery", "Single-Target"},
        {"Mastery > Critical Strike > Versatility > Haste", "Multi-Target"},
    },

    -- 262 - Shaman: Elemental
    [262] = {
        {"Intellect > Versatility > Critical Strike > Haste > Mastery"},
    },
    -- 263 - Shaman: Enhancement
    [263] = {
        {"Haste > Mastery > Critical Strike = Versatility > Agility", "Non Azerite Dependent"},
        {"Mastery > Haste > Critical Strike = Versatility > Agility", "Primal Primer"},
    },
    -- 264 - Shaman: Restoration
    [264] = {
        {"Intellect > Critical Strike > Versatility > Haste = Mastery"},
    },

    -- 265 - Warlock: Affliction
    [265] = {
        {"Haste ≈ Mastery > Critical Strike > Versatility > Intellect"},
    },
    -- 266 - Warlock: Demonology
    [266] = {
        {"Haste > Mastery ≈ Critical Strike > Versatility > Intellect", "Single-Target"},
        {"Critical Strike ≥ Versatility > Mastery > Haste > Intellect", "Explosive Potential"},
    },
    -- 267 - Warlock: Destruction
    [267] = {
        {"Mastery ≥ Haste > Critical Strike > Versatility > Intellect"},
    },

    -- 71 - Warrior: Arms
    [71] = {
        {"Weapon Damage > Haste > Critical Strike > Versatility > Mastery > Strength"},
    },
    -- 72 - Warrior: Fury
    [72] = {
        {"Weapon Damage > Critical Strike > Off Hand Weapon Damage > Mastery > Haste > Versatility > Strength"},
    },
    -- 73 - Warrior: Protection
    [73] = {
        {"Haste > Versatility > Mastery > Critical Strike > Strength > Armor"},
    },
}

function IVSP:GetSPText(specID, k)
    if not data[specID] then return end

    local selected = IVSP_Config["selected"][specID] or 1
    local text

    if selected > #data[specID] then -- isCustom
        if IVSP_Custom[specID] and IVSP_Custom[specID][selected - #data[specID]] then
            text = IVSP_Custom[specID][selected - #data[specID]][1]
        else -- data not exists
            IVSP_Config["selected"][specID] = 1
            selected = 1
        end
    else
        text = data[specID][selected][1]
    end

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
    text = string.gsub(text, "Item Level", STAT_AVERAGE_ITEM_LEVEL)
    return text
end

function IVSP:GetSPDesc(specID)
    if data[specID] and (#data[specID] ~= 1 or (IVSP_Custom[specID] and #IVSP_Custom[specID] ~= 0)) then
        local desc = {}
        for _, t in pairs(data[specID]) do
            table.insert(desc, {t[2] or "General"})
        end
        -- load custom
        if IVSP_Custom[specID] then
            for k, t in pairs(IVSP_Custom[specID]) do
                table.insert(desc, {t[2], k})
            end
        end
        return desc
    end
end