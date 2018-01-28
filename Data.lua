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
}

function IVSP:GetSPText(specID)
    local selected = IcyVeinsStatPriority["selected"][specID] or 1
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
    if #data[specID] ~= 1 then
        local desc = {}
        for _, t in pairs(data[specID]) do
            table.insert(desc, t[2] or " ")
        end
        return desc
    end
end