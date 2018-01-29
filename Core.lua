local addonName, IVSP = ...

local currentSpecID
-----------------------------------------------
-- frame (button)
-----------------------------------------------
local frame = CreateFrame("Button", "IcyVeinsStatPriorityFrame", CharacterFrame)
frame:SetPoint("BOTTOMRIGHT", CharacterFrame, "TOPRIGHT", 0, 1)
frame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1})
frame:SetPushedTextOffset(0, -1)

-- text
CreateFont("IVSP_FONT")
IVSP_FONT:SetShadowColor(0, 0, 0)
IVSP_FONT:SetShadowOffset(1, -1)
IVSP_FONT:SetJustifyH("CENTER")
IVSP_FONT:SetJustifyV("MIDDLE")

-- function
local function SetFrame(bgColor, borderColor, fontColor, fontSize, show)
    IVSP_FONT:SetFont(GameFontNormal:GetFont(), fontSize)
    IVSP_FONT:SetTextColor(unpack(fontColor))
    
    frame:SetNormalFontObject(IVSP_FONT)

    frame:SetBackdropColor(unpack(IVSP_Config["bgColor"]))
    frame:SetBackdropBorderColor(unpack(IVSP_Config["borderColor"]))
    frame:SetHeight(fontSize + 7)

    if show then
        frame:Show()
    else
        frame:Hide()
    end
end

local function SetText(text)
    if not text then return end
    frame:SetText(text)
    frame:SetWidth(frame:GetFontString():GetStringWidth() + 20)
end

-----------------------------------------------
-- color picker -- https://wow.gamepedia.com/Using_the_ColorPickerFrame
-----------------------------------------------
local colorPicker
local function IVSPColorCallback(restore)
    local newR, newG, newB, newA
    if restore then -- canceled
        newR, newG, newB, newA = unpack(restore)
    else
        newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
    end
    
    colorPicker:SetBackdropColor(newR, newG, newB, newA)
    if colorPicker:GetName() == "IcyVeinsBGColorPicker" then
        IVSP_Config["bgColor"] = {newR, newG, newB, newA}
        frame:SetBackdropColor(unpack(IVSP_Config["bgColor"]))
        for _, i in pairs(items) do
            i:SetBackdropColor(unpack(IVSP_Config["bgColor"]))
        end
    elseif colorPicker:GetName() == "IcyVeinsBorderColorPicker" then
        IVSP_Config["borderColor"] = {newR, newG, newB, newA}
        frame:SetBackdropBorderColor(unpack(IVSP_Config["borderColor"]))
        for _, i in pairs(items) do
            i:SetBackdropBorderColor(unpack(IVSP_Config["borderColor"]))
        end
    elseif colorPicker:GetName() == "IcyVeinsFontColorPicker" then
        IVSP_Config["fontColor"] = {newR, newG, newB, newA}
        IVSP_FONT:SetTextColor(unpack(IVSP_Config["fontColor"]))
    end
end

local function ShowColorPicker(colorTable, changedCallback)
    local r, g, b, a = unpack(colorTable)
    ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a
    ColorPickerFrame.previousValues = {r, g, b, a}
    ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 
        changedCallback, changedCallback, changedCallback
    ColorPickerFrame:SetColorRGB(r, g, b)
    ColorPickerFrame:Hide() -- Need to run the OnShow handler.
    ColorPickerFrame:Show()
end

local function CreateColorPicker(name, colorTable)
    local picker = CreateFrame("Button", name, frame)
    picker:SetSize(15, 15)
    picker:Hide()
    picker:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1})
    picker:SetBackdropBorderColor(.8, .8, .8, 1)
    picker:SetScript("OnHide", function() picker:Hide() end)
    picker:SetScript("OnClick", function()
        colorPicker = picker
        ShowColorPicker(IVSP_Config[colorTable], IVSPColorCallback)
    end)
    return picker
end

local bgColorPicker = CreateColorPicker("IcyVeinsBGColorPicker", "bgColor")
bgColorPicker:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, 1)

local borderColorPicker = CreateColorPicker("IcyVeinsBorderColorPicker", "borderColor")
borderColorPicker:SetPoint("RIGHT", bgColorPicker, "LEFT", -1, 0)

local fontColorPicker = CreateColorPicker("IcyVeinsFontColorPicker", "fontColor")
fontColorPicker:SetPoint("RIGHT", borderColorPicker, "LEFT", -1, 0)

-----------------------------------------------
-- list
-----------------------------------------------
local items = {}
local function AddItem(text)
    local item = CreateFrame("Button", nil, frame)
    item:Hide()
    item:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1})
    item:SetPushedTextOffset(0, -1)
    item:SetBackdropColor(unpack(IVSP_Config["bgColor"]))
    item:SetBackdropBorderColor(unpack(IVSP_Config["borderColor"]))
    item:SetNormalFontObject(IVSP_FONT)
    item:SetWidth(200)
    item:SetHeight(select(2, IVSP_FONT:GetFont()) + 7)
    
    item:SetText(text)
    item:GetFontString():SetPoint("LEFT", 5, 0)
    item:GetFontString():SetPoint("RIGHT", -5, 0)

    table.insert(items, item)
    item.n = #items
    
    item:SetScript("OnHide", function() item:Hide() end)

    item:SetScript("OnClick", function()
        bgColorPicker:Hide()
        borderColorPicker:Hide()
        fontColorPicker:Hide()

        for _, i in pairs(items) do
            i:Hide()
        end
        IVSP_Config["selected"][currentSpecID] = item.n
        SetText(IVSP:GetSPText(currentSpecID))
    end)
end

local function LoadList()
    bgColorPicker:Hide()
    borderColorPicker:Hide()
    fontColorPicker:Hide()

    for _, i in pairs(items) do
        i:ClearAllPoints()
        i:Hide()
        i:SetParent(nil)
    end
    wipe(items)

    local desc = IVSP:GetSPDesc(currentSpecID)
    if not desc then return end

    for k, s in pairs(desc) do
        AddItem(s)
        if k == 1 then
            items[1]:SetPoint("TOPLEFT", frame, "TOPRIGHT", 1, 0)
        else
            items[k]:SetPoint("TOP", items[k-1], "BOTTOM", 0, -1)
        end
    end
end

-----------------------------------------------
-- frame OnClick
-----------------------------------------------
frame:SetScript("OnClick", function()
    for _, i in pairs(items) do
        if i:IsShown() then
            i:Hide()
        else
            i:Show()
        end
    end

    if bgColorPicker:IsShown() then
        bgColorPicker:Hide()
    else
        bgColorPicker:Show()
    end

    if borderColorPicker:IsShown() then
        borderColorPicker:Hide()
    else
        borderColorPicker:Show()
    end

    if fontColorPicker:IsShown() then
        fontColorPicker:Hide()
    else
        fontColorPicker:Show()
    end
end)

-----------------------------------------------
-- event
-----------------------------------------------
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

function frame:ADDON_LOADED(arg1)
    if arg1 == addonName then
        if type(IVSP_Config) ~= "table" then IVSP_Config = {} end
        if type(IVSP_Config["show"]) ~= "boolean" then IVSP_Config["show"] = true end
        if type(IVSP_Config["bgColor"]) ~= "table" then IVSP_Config["bgColor"] = {.1, .1, .1, .9} end
        if type(IVSP_Config["borderColor"]) ~= "table" then IVSP_Config["borderColor"] = {0, 0, 0, 1} end
        if type(IVSP_Config["fontColor"]) ~= "table" then IVSP_Config["fontColor"] = {1, 1, 1, 1} end
        if type(IVSP_Config["fontSize"]) ~= "number" then IVSP_Config["fontSize"] = 13 end
        if type(IVSP_Config["selected"]) ~= "table" then IVSP_Config["selected"] = {} end

        SetFrame(IVSP_Config["bgColor"], 
            IVSP_Config["borderColor"], 
            IVSP_Config["fontColor"], 
            IVSP_Config["fontSize"],
            IVSP_Config["show"])

        bgColorPicker:SetBackdropColor(unpack(IVSP_Config["bgColor"]))
        borderColorPicker:SetBackdropColor(unpack(IVSP_Config["borderColor"]))
        fontColorPicker:SetBackdropColor(unpack(IVSP_Config["fontColor"]))
    end
end

function frame:PLAYER_ENTERING_WORLD()
    frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    currentSpecID = GetSpecializationInfoForClassID(select(3, UnitClass("player")), GetSpecialization())
    SetText(IVSP:GetSPText(currentSpecID))
    LoadList()
end

function frame:ACTIVE_TALENT_GROUP_CHANGED()
    -- specID, name, description, iconID, role, isRecommended, isAllowed = GetSpecializationInfoForClassID(classID, specNum)
    local specID = GetSpecializationInfoForClassID(select(3, UnitClass("player")), GetSpecialization())
    if specID ~= currentSpecID then
        currentSpecID = specID
        SetText(IVSP:GetSPText(currentSpecID))
        LoadList()
    end
end

SLASH_ICYVEINSSTATPRIORITY1 = "/ivsp"
function SlashCmdList.ICYVEINSSTATPRIORITY(msg, editbox)
    local command, rest = msg:match("^(%S*)%s*(.-)$")
    if command == "show" then
        frame:Show()
        IVSP_Config["show"] = true
    elseif command == "hide" then
        frame:Hide()
        IVSP_Config["show"] = false
    elseif command == "font" then
        IVSP_Config["fontSize"] = tonumber(rest) or 13
        IVSP_FONT:SetFont(GameFontNormal:GetFont(), IVSP_Config["fontSize"])
        frame:SetHeight(IVSP_Config["fontSize"] + 7)
    elseif command == "reset" then
        IVSP_Config = nil
        ReloadUI()
    else -- help
        print("|cff69CCF0Icy Veins Stat Priority help:|r")
        print("|cff69CCF0/ivsp show/hide|r: show/hide IVSP.")
        print("|cff69CCF0/ivsp font [fontSize]|r: set font size (default 13).")
        print("|cff69CCF0/ivsp reset|r: reset all settings and reload UI.")
    end
end