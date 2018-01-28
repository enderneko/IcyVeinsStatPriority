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

    frame:SetBackdropColor(unpack(IcyVeinsStatPriority["bgColor"]))
    frame:SetBackdropBorderColor(unpack(IcyVeinsStatPriority["borderColor"]))
    frame:SetHeight(fontSize + 7)

    if show then
        frame:Show()
    else
        frame:Hide()
    end
end

local function SetText(text)
    frame:SetText(text)
    frame:SetWidth(frame:GetFontString():GetStringWidth() + 20)
end

-----------------------------------------------
-- list
-----------------------------------------------
local items = {}
local function AddItem(text)
    local item = CreateFrame("Button", nil, frame)
    item:Hide()
    item:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1})
    item:SetPushedTextOffset(0, -1)
    item:SetBackdropColor(unpack(IcyVeinsStatPriority["bgColor"]))
    item:SetBackdropBorderColor(unpack(IcyVeinsStatPriority["borderColor"]))
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
        for _, i in pairs(items) do
            i:Hide()
        end
        IcyVeinsStatPriority["selected"][currentSpecID] = item.n
        SetText(IVSP:GetSPText(currentSpecID))
    end)
end

local function LoadList()
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
        IcyVeinsStatPriority["bgColor"] = {newR, newG, newB, newA}
        frame:SetBackdropColor(unpack(IcyVeinsStatPriority["bgColor"]))
        for _, i in pairs(items) do
            i:SetBackdropColor(unpack(IcyVeinsStatPriority["bgColor"]))
        end
    elseif colorPicker:GetName() == "IcyVeinsBorderColorPicker" then
        IcyVeinsStatPriority["borderColor"] = {newR, newG, newB, newA}
        frame:SetBackdropBorderColor(unpack(IcyVeinsStatPriority["borderColor"]))
        for _, i in pairs(items) do
            i:SetBackdropBorderColor(unpack(IcyVeinsStatPriority["borderColor"]))
        end
    elseif colorPicker:GetName() == "IcyVeinsFontColorPicker" then
        IcyVeinsStatPriority["fontColor"] = {newR, newG, newB, newA}
        IVSP_FONT:SetTextColor(unpack(IcyVeinsStatPriority["fontColor"]))
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
        ShowColorPicker(IcyVeinsStatPriority[colorTable], IVSPColorCallback)
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
        if type(IcyVeinsStatPriority) ~= "table" then IcyVeinsStatPriority = {} end
        if type(IcyVeinsStatPriority["show"]) ~= "boolean" then IcyVeinsStatPriority["show"] = true end
        if type(IcyVeinsStatPriority["bgColor"]) ~= "table" then IcyVeinsStatPriority["bgColor"] = {.1, .1, .1, .9} end
        if type(IcyVeinsStatPriority["borderColor"]) ~= "table" then IcyVeinsStatPriority["borderColor"] = {0, 0, 0, 1} end
        if type(IcyVeinsStatPriority["fontColor"]) ~= "table" then IcyVeinsStatPriority["fontColor"] = {1, 1, 1, 1} end
        if type(IcyVeinsStatPriority["fontSize"]) ~= "number" then IcyVeinsStatPriority["fontSize"] = 13 end
        if type(IcyVeinsStatPriority["selected"]) ~= "table" then IcyVeinsStatPriority["selected"] = {} end

        SetFrame(IcyVeinsStatPriority["bgColor"], 
            IcyVeinsStatPriority["borderColor"], 
            IcyVeinsStatPriority["fontColor"], 
            IcyVeinsStatPriority["fontSize"],
            IcyVeinsStatPriority["show"])

        bgColorPicker:SetBackdropColor(unpack(IcyVeinsStatPriority["bgColor"]))
        borderColorPicker:SetBackdropColor(unpack(IcyVeinsStatPriority["borderColor"]))
        fontColorPicker:SetBackdropColor(unpack(IcyVeinsStatPriority["fontColor"]))
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
        IcyVeinsStatPriority["show"] = true
    elseif command == "hide" then
        frame:Hide()
        IcyVeinsStatPriority["show"] = false
    elseif command == "font" then
        IcyVeinsStatPriority["fontSize"] = tonumber(rest) or 13
        IVSP_FONT:SetFont(GameFontNormal:GetFont(), IcyVeinsStatPriority["fontSize"])
        frame:SetHeight(IcyVeinsStatPriority["fontSize"] + 7)
    elseif command == "reset" then
        IcyVeinsStatPriority = nil
        ReloadUI()
    else -- help
        print("|cff69CCF0Icy Veins Stat Priority help:|r")
        print("|cff69CCF0/ivsp show/hide|r: show/hide IVSP.")
        print("|cff69CCF0/ivsp font [fontSize]|r: set font size (default 13).")
        print("|cff69CCF0/ivsp reset|r: reset all settings and reload UI.")
    end
end