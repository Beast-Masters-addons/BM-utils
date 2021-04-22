--This file contains dummy functions and variables to make WoW functions work in standalone lua

debugstack = debug.traceback
strmatch = string.match
addon = {}
C_Timer = {}
function C_Timer:NewTicker(...) end

if os.getenv('GAME_VERSION') ~= 'retail' then
    loadfile('wow-ui-source/SharedXML/Util.lua')()
else
    loadfile('wow-ui-source/SharedXML/Color.lua')()
    loadfile('wow-ui-source/SharedXML/Mixin.lua')()
end

function GetBuildInfo()
    if os.getenv('GAME_VERSION') == 'classic' then
        return "1.13.2", 32600, "Nov 20 2019", 11302
    elseif os.getenv('GAME_VERSION') == 'bc' then
        return "2.5.1", 38364, "Apr 15 2021", 20501
    else
        return "9.0.1", "36492", "Oct 30 2020", 90001
    end
end

DEFAULT_CHAT_FRAME = {}
function DEFAULT_CHAT_FRAME:AddMessage(str, r, g, b)
    return str, r, g, b
end


function UnitName(unit)
    if unit=="player" then
        return "Quadduo"
    end
end

function GetRealmName()
    return "MirageRaceway"
end

function GetSpellInfo(spellId)
    if spellId  == 186257 then
        return "Aspect of the Cheetah", 132242, 0, 0, 0, 186257
    end
end

function CastSpellByName(spellName)
    return spellName
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
