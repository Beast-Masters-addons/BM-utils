---@type BMUtils
if not _G['BM-utils-@project-version@'] then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilsText string utilities
local lib = _G['BM-utils-@project-version@']:NewModule("BMUtilsText")
---@type BMUtils
local utils = _G['BM-utils-@project-version@']:GetModule("BMUtils")

--/run print(LibStub('BM-utils-2'):colorize('red', 'ffff0000'))
--/run print(LibStub('BM-utils-2'):colorize('green', 'FF00FF00'))
--- Add the specified color to a string
--- @param str string Text to be colorized
--- @param r number|string Red or RGB string
--- @param g number Green
--- @param b number Blue
---@return string String with color
function lib.colorize(str, r, g, b)
    local rgb
    assert(str, 'Empty string')
    if type(r) == type(g) and type(g) == type(b) and type(r) == 'number' then
        rgb = utils:GenerateHexColor(r, g, b)
    elseif type(r) == 'string' and g == nil and b == nil then
        rgb = r
    else
        error('Invalid arguments')
    end

    return string.format('|c%s%s|r', rgb, str)
end

local DEFAULT_FONT_COLOR = { ["R"] = 1, ["G"] = 1, ["B"] = 1 }
function lib.SetDefaultFontColor(r, g, b)
    DEFAULT_FONT_COLOR = { ["R"] = r, ["G"] = g, ["B"] = b }
end

--/run LibStub('BM-utils-2'):cprint('red', 1, 0, 0)
--- Add a message to chat frame with colors
--- @param message string Message text
--- @param r number Red
--- @param g number Green
--- @param b number Blue
function lib.cprint(message, r, g, b)
    return _G.DEFAULT_CHAT_FRAME:AddMessage(message,
            (r or DEFAULT_FONT_COLOR["R"]),
            (g or DEFAULT_FONT_COLOR["G"]),
            (b or DEFAULT_FONT_COLOR["B"]));
end

--- Add a message to chat frame with red color
--- @param message string Message text
function lib.error(message)
    return lib.cprint(message, 1, 0, 0)
end
