--This file contains dummy functions and variables to make WoW functions work in standalone lua

debugstack = debug.traceback
strmatch = string.match
addon = {}
C_Timer = {}
function C_Timer:NewTicker(...) end


function GetBuildInfo()
    return "1.13.2", 32600, "Nov 20 2019", 11302
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