---@type BMUtils
if not _G['BM-utils-@project-version@'] then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilsBasic Basic utilities from other programming languages missing in lua
local basic = _G['BM-utils-@project-version@']:NewModule("BMUtilsBasic")

---Parse a float from a string with localized decimal separator
function basic.parseFloat(float)
    if _G.DECIMAL_SEPERATOR ~= '.' then
        float = float:gsub(_G.DECIMAL_SEPERATOR, '.')
    end
    return tonumber(float)
end

---Format a float as a string with localized decimal separator
function basic.formatFloat(float)
    return tostring(float):gsub('%.', _G.DECIMAL_SEPERATOR)
end

---Check if a number is a decimal number
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

function basic.printf(str, ...)
    return _G.DEFAULT_CHAT_FRAME:AddMessage(string.format(str, ...))
end

function basic.sprintf(str, ...)
    return string.format(str, ...)
end