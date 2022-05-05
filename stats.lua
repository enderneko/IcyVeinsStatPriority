local AddOn = select(2, ...)

if AddOn.IsClassic then
    AddOn:AddStatPriority("DRUID"):SetPriority("Caster", "Hit 16% > Crit > SpDam > Int > Spirit > Stam"):SetPriority(
        "Melee",
        "Hit 9% > Agil > Str > Crit > AttPwr > Int > Stam > Spirit"
    ):SetPriority("Tank", "Armour > Stam > Def > Agil = Dodge > Hit 9% > Str > AttPwr > Crit"):SetPriority(
        "Healer",
        "HealPwr > Mana > Int > Spirit > SpCrit > Stam"
    )

    AddOn:AddStatPriority("HUNTER"):SetDefaultPriority("Hit 9% > Crit > Agil > AttPwr > Stam > Int > Spirit")

    AddOn:AddStatPriority("MAGE"):SetDefaultPriority("SpHit > SpCrit > SpDam > Int > Stam > Resist > Mana > Spirit")

    AddOn:AddStatPriority("PALADIN"):SetPriority("Holy", "HealPwr > Int > Crit > Mana > Stam > Spirit"):SetPriority(
        "Protect",
        "Stam > Def > Str > Agil > Armour > Int > Hit > SpPwr > Str > Int"
    ):SetPriority("Retadin", "Hit 9% > Str > Agil = Crit > Att > SpPwr > Stam > Int")

    AddOn:AddStatPriority("PRIEST"):SetPriority(
        "Shadow",
        "Hit 6% > SpDam = ShadowDam > Mana > Int > SpCrit > Spirit > Stam"
    ):SetPriority("Healer", "HealPwr > Mana > Spirit > Int > SpCrit > Stam")

    AddOn:AddStatPriority("ROGUE"):SetDefaultPriority("Hit 9% > Agil > Str = Att > Crit")

    AddOn:AddStatPriority("SHAMAN"):SetPriority(
        "Elemental",
        "SpHit 16% > SpDam > SpCrit > Mana > Int > SpPen > Stam > Resist > Spirit"
    ):SetPriority("Enhancement", "Weapon > Hit 6% > Crit > Str = Att > Agil > Mana > Int > Stam"):SetPriority(
        "Healer",
        "Mana > Int > Heal > SpCrit > Spirit > Stam > Resist > SpHit"
    )

    AddOn:AddStatPriority("WARLOCK"):SetDefaultPriority("SpPwr > SpCrit > Hit 16% > SpPen > Int > Stam > Spirit")

    AddOn:AddStatPriority("WARRIOR"):SetPriority(
        "DPS",
        "Weapon > Hit 6% > Crit > Str = Att > Agil > Stam > Armour > Parry > Def"
    ):SetPriority("Tank", "Stam > Armour > Parry > Def > Agil > Str > Block > Weapon > Hit 6% > Crit")
elseif AddOn.IsBCC then
    AddOn:AddStatPriority("DRUID"):SetPriority(
        "Balance",
        "SpHit 16% (3% PVP) > SpDam > SpHaste > SpCrit > Int > Spirit > Mana > Stam > SpPen"
    ):SetPriority(
        "Cat DPS",
        "Agil > Hit 9% (5% PVP)> Expert 6.5% > Str > Crit > Haste > AttPwr > ArmPen > Stam = Int = Spirit = Mana"
    ):SetPriority(
        "Cat Tank",
        "Expert 6.5% > Agil > Stam > Hit 9% (5% PVP) > Str > Crit > Dodge > Def > AttPwr > Resil > Armour > ArmPen"
    ):SetPriority("Healer", "SpHeal > Spirit > Mana > Int > SpHaste > SpCrit > Stam")

    AddOn:AddStatPriority("HUNTER"):SetPriority("BeastMaster", "Hit 9% > ArmPen > Agil > AttPwr > Crit"):SetPriority(
        "Marksman",
        "Hit 9% > ArmPen > Agil > AttPwr > Crit"
    ):SetPriority("Charge Marksman", "Hit 9% > ArmPen > Agil > Crit > AttPwr"):SetPriority(
        "Survivalist",
        "Agil > Crit > Hit 6% (2% Raid) > ArmPen > AttPwr"
    )

    AddOn:AddStatPriority("MAGE"):SetPriority(
        "Arcane",
        "SpDam = SpHeal > Int > SpCrit > SpHaste > SpHit 6% > Spirit > Mana"
    ):SetPriority("Fire/Frost", "SpDam > SpCrit > SpHaste > SPHit 13% > Spirit > Mana > Int")

    AddOn:AddStatPriority("PALADIN"):SetPriority(
        "Holy Damage",
        "SpDam > Bonus Heal > SpHit > Stam > Str > AttPwr > Haste"
    ):SetPriority("Holy Healer", "HealPwr > Mana > SpCrit > Int > SpHaste"):SetPriority(
        "Protect",
        "Hit 9% > Str > SpDam > Stam > AttPwr > Haste > Agil = Crit"
    ):SetPriority("Protect Tank", "Def 490 > Avoid 102.4% (Block > Dodge > Parry) > Stam > SpDam > Hit > Expert"):SetPriority(
        "Retribution",
        "Hit 9% > Expert > Str > AttPwr > Stam > Haste > ArmPen > Agil = Crit"
    )

    AddOn:AddStatPriority("PRIEST"):SetDefaultPriority("Int > Bonus Heal > Spirit > Mana > Stam"):SetPriority(
        "Healer",
        "SPHaste > Bonus Heal > SpCrit > Spirit > Int > Mana > Stam"
    ):SetPriority("Shadow", "SpHit > SpDam > SPHaste > SpCrit > Int > Spirit > Mana > Stam")

    AddOn:AddStatPriority("ROGUE"):SetDefaultPriority("Expert > Hit > Agil > Crit > AttPwr > Str > Stam")

    AddOn:AddStatPriority("SHAMAN"):SetPriority(
        "Elemental",
        "SpHit 16% (3% PVP) > SPDam > SpCrit > SpHaste > Int > Stam > SpPen > Mana > Spirit"
    ):SetPriority(
        "Enhance",
        "Hit 9% (5% PVP > Expert 6.25% > Str = AttPwr > Crit > Agil > Hit 9%+ > Haste > ArmPen > Int > Stam > Mana > Spirit"
    ):SetPriority("Healer", "SpHeal > Mana > Int > SpHaste > SpCrit > Stam > Spirit")

    AddOn:AddStatPriority("WARLOCK"):SetDefaultPriority("SPDam > Stam > SpHit > SpCrit > Int > Spirit")

    AddOn:AddStatPriority("WARRIOR"):SetPriority("Arms", "Hit > Expert > Crit > Str = AttPwr > Agil > Haste"):SetPriority(
        "Fury",
        "Hit > Expert > Str = AttPwr > Crit > Agil > Haste"
    ):SetPriority("Protect Survival", "Stam > Armor > Resist > Def > Dodge > Agil > Parry > Block > Resil"):SetPriority(
        "Protect Damage",
        "Expert > Hit 9% > Weapon > Haste > Agil > Crit > Str = AttPwr"
    )
else
    AddOn:AddStatPriority("DEATHKNIGHT-250", "BLOOD KNIGHT"):SetPriority(
        "Standard",
        "Str > Arm > ilvl > Haste > Vers > Crit > Mast > Stam"
    ):SetPriority("Alternate", "Str > Arm > Haste > Crit > ilvl > Vers > Mast > Stam")
    AddOn:AddStatPriority("DEATHKNIGHT-251", "FROST KNIGHT"):SetDefaultPriority("Str > Mast > Crit > Haste > Vers"):SetPriority(
        "PVP",
        "Str > Vers > Mast = Haste > Crit"
    )
    AddOn:AddStatPriority("DEATHKNIGHT-252", "UNHOLY KNIGHT"):SetPriority("Solo", "Str > Mast > Haste > Crit > Vers"):SetPriority(
        "Multi",
        "Str > Mast > Crit > Haste > Vers"
    ):SetPriority("PVP", "Str > Vers > Mast = Haste > Crit")

    AddOn:AddStatPriority("DRUID-102", "BOOMKIN"):SetDefaultPriority("Int > Mast > Haste > Vers > Crit"):SetPriority(
        "PVP",
        "Int > Vers > Haste > Mast > Crit"
    )
    AddOn:AddStatPriority("DRUID-103", "CAT DROOD"):SetDefaultPriority("Agil > Crit > Mast > Vers > Haste"):SetPriority(
        "PVP",
        "Agil > Vers > Mast > Haste > Crit"
    )
    AddOn:AddStatPriority("DRUID-104", "BEAR DROOD"):SetPriority(
        "Survival",
        "ilvl > Armor = Agil = Stam > Vers > Mast > Haste > Crit"
    ):SetPriority("Damage", "Agil > Vers >= Haste >= Crit > Mast")
    AddOn:AddStatPriority("DRUID-105", "TREE DROOD"):SetPriority("Raid", "Int > Haste > Mast = Crit = Vers"):SetPriority(
        "Dungeon",
        "Int > Mast = Haste > Vers > Crit"
    ):SetPriority("Damage", "Int > Haste > Vers > Crit > Mast"):SetPriority("PVP", "Int > Vers > Haste > Mast > Crit")

    AddOn:AddStatPriority("HUNTER-253", "BEAST TAMER"):SetDefaultPriority("Agil > Crit > Vers > Haste > Mast"):SetPriority(
        "PVP",
        "Agil > Vers > Haste > Mast > Crit"
    )
    AddOn:AddStatPriority("HUNTER-254", "SHARPSHOOTER"):SetDefaultPriority("Agil > Mast = Crit > Vers > Haste"):SetPriority(
        "PVP",
        "Agil > Vers > Mast > Haste > Crit"
    )
    AddOn:AddStatPriority("HUNTER-255", "SURVIVALIST"):SetDefaultPriority("Agil > Haste > Vers = Crit > Mast"):SetPriority(
        "PVP",
        "Agil > Vers > Haste > Mast > Crit"
    )

    AddOn:AddStatPriority("MAGE-62", "ARCANE"):SetDefaultPriority("Int > Crit > Mast > Vers > Haste"):SetPriority(
        "PVP",
        "Int > Haste > Vers > Mast > Crit"
    )
    AddOn:AddStatPriority("MAGE-63", "FIRE"):SetDefaultPriority("Int > Haste > Vers > Mast > Crit"):SetPriority(
        "PVP",
        "Int > Haste > Vers > Crit > Mast"
    )
    AddOn:AddStatPriority("MAGE-64", "ICE"):SetDefaultPriority("Int > Crit 33% > Haste > Vers > Mast > Crit 33%+"):SetPriority(
        "PVP",
        "Int > Haste > Vers > Crit > Mast"
    )

    AddOn:AddStatPriority("MONK-268", "DRUNK MONK"):SetPriority("Defense", "Vers = Mast = Crit > Haste > Agil"):SetPriority(
        "Offense",
        "Agil > Vers = Crit > Haste > Mast"
    )
    AddOn:AddStatPriority("MONK-269", "WINDWALKER"):SetDefaultPriority("Weapon Dam > Agi > Vers > Crit > Mast > Haste"):SetPriority(
        "PVP",
        "Agil > Vers > Mast > Haste > Crit"
    )
    AddOn:AddStatPriority("MONK-270", "MISTWEAVER"):SetPriority("Mistweaving", "Int > Crit > Haste > Vers > Mast"):SetPriority(
        "Fistweaving",
        "Int > Crit > Vers > Haste > Mast"
    ):SetPriority("Dungeon", "Int > Crit => Mast = Vers >= Haste"):SetPriority(
        "PVP",
        "Int > Vers > Mast > Haste > Crit"
    )

    AddOn:AddStatPriority("PALADIN-65", "HEALADIN"):SetPriority("Raid", "Int > Haste > Mast > Vers > Crit"):SetPriority(
        "Dungeon",
        "Int > Haste > Vers > Crit > Mast"
    ):SetPriority("PVP", "Int > Crit > Vers > Haste > Mast")
    AddOn:AddStatPriority("PALADIN-66", "TANKADIN"):SetDefaultPriority("Haste > Mast > Vers > Crit > Str = Stam")
    AddOn:AddStatPriority("PALADIN-70", "LOLADIN"):SetDefaultPriority("Str > Haste > Mast = Vers = Crit"):SetPriority(
        "PVP",
        "Str > Haste > Vers > Mast > Crit"
    )

    AddOn:AddStatPriority("PRIEST-256", "CLERIC"):SetDefaultPriority("Int > Haste > Crit > Vers > Mast"):SetPriority(
        "PVP",
        "Int > Vers > Haste > Crit > Mast"
    )
    AddOn:AddStatPriority("PRIEST-257", "PRIEST"):SetPriority("Raid", "Int > Mast = Crit > Vers > Haste"):SetPriority(
        "Dungeon",
        "Int > Crit = Haste > Vers > Mast"
    ):SetPriority("PVP", "Int > Vers > Mast > Haste > Crit")
    AddOn:AddStatPriority("PRIEST-258", "CULTIST"):SetDefaultPriority("Int > Haste = Mast > Crit > Vers"):SetPriority(
        "PVP",
        "Int > Vers > Haste > Crit > Mast"
    )

    AddOn:AddStatPriority("ROGUE-259", "ASSASSIN"):SetPriority("Raid", "Agil > Crit > Haste > Vers > Mast"):SetPriority(
        "Dungeon",
        "Agil > Crit > Mast > Haste > Vers"
    ):SetPriority("PVP", "Agil > Vers > Haste > Mast > Crit")
    AddOn:AddStatPriority("ROGUE-260", "PIRATE"):SetDefaultPriority("Agil > Vers > Crit > Haste > Mast"):SetPriority(
        "Dungeon",
        "Agil > Crit > Mast > Haste > Vers"
    ):SetPriority("PVP", "Agil > Vers > Haste > Mast > Crit")
    AddOn:AddStatPriority("ROGUE-261", "THIEF"):SetPriority("Solo", "Agil > Vers > Crit > Haste > Mast"):SetPriority(
        "Multi",
        "Agil > Crit > Vers > Mast > Haste"
    ):SetPriority("PVP", "Agil > Vers > Mast > Crit > Haste")

    AddOn:AddStatPriority("SHAMAN-262", "TRUE SHAMAN"):SetDefaultPriority("Int > Vers > Crit > Haste > Mast"):SetPriority(
        "PVP",
        "Int > Vers > Crit > Haste > Mast"
    )
    AddOn:AddStatPriority("SHAMAN-263", "PUNK SHAMAN"):SetDefaultPriority("Agil > Haste > Mast > Vers > Crit"):SetPriority(
        "Venthyr",
        "Agil > Haste > Crit > Vers > Mast"
    ):SetPriority("PVP", "Agil > Vers > Haste = Mast > Crit")
    AddOn:AddStatPriority("SHAMAN-264", "HEAL SHAMAN"):SetPriority("Healer", "Int > ilvl > Vers = Crit > Haste = Mast"):SetPriority(
        "Damage",
        "Int > ilvl > Vers = Haste > Crit > Mast"
    ):SetPriority("PVP", "Int > Vers > Mast > Crit > Haste")

    AddOn:AddStatPriority("WARLOCK-265", "PLAGUEBRINGER"):SetDefaultPriority("Int > Mast > Haste > Crit > Vers"):SetPriority(
        "PVP",
        "Int > Vers > Haste > Mast > Crit"
    )
    AddOn:AddStatPriority("WARLOCK-266", "DEMONOLOGIST"):SetDefaultPriority("Int > Haste > Mast > Crit > Vers"):SetPriority(
        "Sac. Souls",
        "Int > Haste > Vers > Crit > Mast"
    ):SetPriority("PVP", "Int > Vers > Haste > Mast > Crit")
    AddOn:AddStatPriority("WARLOCK-267", "DESTRUCTION"):SetDefaultPriority("Int > Haste >= Mast > Crit > Vers"):SetPriority(
        "Tier Gear",
        "Int > Haste > Crit > Vers > Mast"
    ):SetPriority("PVP", "Int > Haste > Vers > Mast > Crit")

    AddOn:AddStatPriority("WARRIOR-71", "FIGHTER"):SetDefaultPriority("Str > Crit > Mast > Vers > Haste"):SetPriority(
        "PVP",
        "Str > Vers > Crit = Haste >= Mast"
    ):SetPriority("PVP EM", "Str > Vers > Crit > Haste >= Mast"):SetPriority(
        "PVP EB",
        "Str > Vers > Haste > Crit >= Mast"
    )
    AddOn:AddStatPriority("WARRIOR-72", "BESERKER"):SetDefaultPriority("Str > Haste > Mast > Crit > Vers"):SetPriority(
        "PVP",
        "Str > Vers > Haste > Mast > Crit"
    ):SetPriority("PVP EM", "Str > Vers > Crit > Haste > Mast")
    AddOn:AddStatPriority("WARRIOR-73", "CAVALIER"):SetDefaultPriority(
        "ilvl > Haste > Vers > Mast > Crit > Armor > Str"
    ):SetPriority("Dungeon", "ilvl > Haste > Vers >= Crit > Mast > Armor > Str"):SetPriority(
        "PVP",
        "Str > Vers > Haste = Mast = Crit"
    )

    AddOn:AddStatPriority("DEMONHUNTER-577", "HAVOC"):SetDefaultPriority("Agil > Haste = Vers > Crit > Mast"):SetPriority(
        "PVP",
        "Agil > Haste > Vers > Crit > Mast"
    )
    AddOn:AddStatPriority("DEMONHUNTER-581", "MALICE"):SetDefaultPriority("Agil > Haste >= Vers > Crit > Mast")
end
