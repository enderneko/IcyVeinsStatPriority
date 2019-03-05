local addonName, IVSP = ...

local data = {
    -- 250 - Death Knight: Blood
    [250] = {
        {"Item Level > Versatility > Haste > Critical Strike > Mastery"},
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
        {"Versatility > Critical Strike = Haste > Agility > Mastery"},
    },
    -- 581 - Demon Hunter: Vengeance
    [581] = {
        {"Agility > Haste > Versatility > Mastery > Critical Strike"},
    },

    -- 102 - Druid: Balance
    [102] = {
        {"Intellect > Haste > Mastery > Critical Strike > Versatility"},
    },
    -- 103 - Druid: Feral
    [103] = {
        {"Critical Strike > Mastery > Haste > Agility > Versatility"},
    },
    -- 104 - Druid: Guardian
    [104] = {
        {"Armor = Agility = Stamina > Mastery > Versatility > Haste > Critical Strike", "Survivability"},
        {"Haste ≥ Critical Strike ≥ Versatility ≥ Mastery", "Damage Output"},
    },
    -- Druid: Restoration
    [105] = {
        {"Mastery > Haste = Critical Strike = Versatility > Intellect", "Raid Healing"},
        {"Mastery = Haste > Versatility > Critical Strike > Intellect", "Dungeon Healing"},
    },

    -- 253 - Hunter: Beast Mastery
    [253] = {
        {"Critical Strike > Haste > Mastery > Versatility", "Single-Target"},
        {"Mastery > Haste > Critical Strike > Versatility", "Multi-Target"},
    },
    -- 254 - Hunter: Marksmanship
    [254] = {
        {"Mastery > Haste > Critical Strike > Versatility", "Single-Target"},
        {"Mastery > Critical Strike > Versatility > Haste", "Multi-Target"},
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
        {"Intellect > Critical Strike > Mastery = Versatility > Haste", "Raiding"},
        {"Intellect > Mastery ≥ Haste > Versatility > Critical Strike", "Mythic+"},
    },

    -- 65 - Paladin: Holy
    [65] = {
        {"Intellect > Critical Strike > Mastery > Haste > Versatility"},
    },
    -- 66 - Paladin: Protection
    [66] = {
        {"Item Level > Haste > Mastery > Versatility > Critical Strike", "Survivability"},
    },
    -- 70 - Paladin: Retribution
    [70] = {
        {"Strength > Haste > Critical Strike ≈ Versatility ≈ Mastery"},
    },

    -- 256 - Priest: Discipline
    [256] = {
        {"Intellect > Haste > Critical Strike > Versatility > Mastery"},
    },
    -- 257 - Priest: Holy
    [257] = {
        {"Intellect > Mastery = Critical Strike > Versatility > Haste", "Raids"},
        {"Intellect > Critical Strike > Haste > Versatility > Mastery", "Dungeons"},
    },
    -- 258 - Priest: Shadow
    [258] = {
        {"Haste = Critical Strike > Intellect > Mastery > Versatility"},
    },

    -- 259 - Rogue: Assassination
    [259] = {
        {"Agility > Haste > Critical Strike > Mastery > Versatility"},
    },
    -- 260 - Rogue: Outlaw
    [260] = {
        {"Agility > Critical Strike > Haste > Versatility > Mastery"},
    },
    -- 261 - Rogue: Subtlety
    [261] = {
        {"Versatility > Critical Strike > Mastery > Haste", "Single-Target"},
        {"Mastery > Critical Strike > Versatility > Haste", "Multi-Target"},
    },

    -- 262 - Shaman: Elemental
    [262] = {
        {"Intellect > Critical Strike > Haste > Versatility > Mastery"},
    },
    -- 263 - Shaman: Enhancement
    [263] = {
        {"Haste > Critical Strike = Versatility > Mastery > Agility", "Non Azerite Dependent"},
        {"Mastery > Haste > Critical Strike = Versatility > Agility", "Primal Primer"},
        {"Haste > Critical Strike > Mastery > Versatility > Agility", "Strength of Earth"},
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
        {"Intellect > Haste > Critical Strike > Versatility > Mastery", "Single-Target"},
        {"Mastery ≥ Critical Strike > Intellect > Versatility > Haste", "Explosive Potential"},
    },
    -- 267 - Warlock: Destruction
    [267] = {
        {"Mastery ≥ Haste > Critical Strike > Intellect > Versatility"},
    },

    -- 71 - Warrior: Arms
    [71] = {
        {"Weapon Damage > Haste > Critical Strike > Versatility > Mastery > Strength"},
    },
    -- 72 - Warrior: Fury
    [72] = {
        {"Weapon Damage > Critical Strike > Mastery > Haste > Versatility > Strength"},
    },
    -- 73 - Warrior: Protection
    [73] = {
        {"Item Level > Haste > Armor > Versatility > Mastery > Critical Strike > Strength"},
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