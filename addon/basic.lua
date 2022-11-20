---@type BMUtils
local lib = _G['BMUtils-@project-version@']

---@class BMUtilBasic Basic utilities from other programming languages missing in lua
local basic = {}
lib.basic = basic

function basic.parseFloat(float)
    if _G.DECIMAL_SEPERATOR ~= '.' then
        float = float:gsub(_G.DECIMAL_SEPERATOR, '.')
    end
    return tonumber(float)
end

function basic.formatFloat(float)
    return tostring(float):gsub('%.', _G.DECIMAL_SEPERATOR)
end

function basic.isFloat(num)
    return num % 1 == 0
end