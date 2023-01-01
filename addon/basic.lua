---@type BMUtils
local _, addon = ...
if not addon then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilBasic Basic utilities from other programming languages missing in lua
addon.basic = {}
local basic = addon.basic

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
    return num % 1 ~= 0
end

local next = _G.next
--- Check if a value if empty
function basic.empty(value)
    if value == nil then
        return true
    elseif type(value) == 'table' then
        return next(value) == nil
    elseif type(value) == 'string' then
        return value == ''
    elseif type(value) == 'boolean' then
        return not value
    end
    return false
end