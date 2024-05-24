--This file contains dummy functions and variables to make WoW functions work in standalone lua

debugstack = debug.traceback
strmatch = string.match
addon = {}

_G.C_Container = {}
C_Timer = {}
function C_Timer:NewTicker(...) end


C_UIColor = {}
function C_UIColor.GetColors()
    return {}
end

function Round(value)
    return math.ceil(value)
end

if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
    loadfile('wow-ui-source/Interface/SharedXML/Color.lua')()
    loadfile('wow-ui-source/Interface/SharedXML/Mixin.lua')()
else
    loadfile('wow-ui-source/Interface/AddOns/Blizzard_SharedXML/Color.lua')()
    loadfile('wow-ui-source/Interface/AddOns/Blizzard_SharedXML/Mixin.lua')()
end

function GetItemQualityColor(quality)
    local colors = loadfile('wow-data/ColorData.lua')()
    return colors[quality][1], colors[quality][2], colors[quality][3], colors[quality][4]
end

function BuildItemQualityColors()
    ITEM_QUALITY_COLORS = { };
    for i = 0, 8 do
        local r, g, b = GetItemQualityColor(i);
        local color = CreateColor(r, g, b, 1);
        ITEM_QUALITY_COLORS[i] = { r = r, g = g, b = b, hex = color:GenerateHexColorMarkup(), color = color };
    end
end
