--This file contains dummy functions and variables to make WoW functions work in standalone lua

debugstack = debug.traceback
strmatch = string.match
addon = {}
C_Timer = {}
function C_Timer:NewTicker(...) end


function GetBuildInfo()
    if os.getenv('CLASSIC_VERSION') then
        return "1.13.2", 32600, "Nov 20 2019", 11302
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