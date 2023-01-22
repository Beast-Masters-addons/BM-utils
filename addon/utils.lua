---@type BMUtils
local _, lib = ...
if not lib then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

--- Convert a color table with 0.0-1.0 floats to a 0-255 RGB int
--- @param r number|table Red or table with r, g and b as keys
--- @param g number Green
--- @param b number Blue
---@return number, number, number
function lib:ColorToRGB(r, g, b)
    local color
    if type(r) == 'table' then
        color = r
    else
        color = { r = r, g = g, b = b }
    end

    return 255 * color['r'], 255 * color['g'], 255 * color['b']
end

function lib:GenerateHexColor(r, g, b)
    return ("ff%.2x%.2x%.2x"):format(r, g, b);
end

-- Convert a color table with 0.0-1.0 floats to a RGB hex string
function lib:ColorToHex(color)
    local r, g, b = self:ColorToRGB(color)
    return self:GenerateHexColor(r, g, b)
end

---@param name string Difficulty name (medium, trivial, yellow, green, ...)
---@return int Difficulty number (3, 2, ...)
function lib.difficultyNameToNum(name)
    local difficulties = {
        ["optimal"]	= 4,
        ["orange"]	= 4,
        ["medium"]	= 3,
        ["yellow"]	= 3,
        ["easy"]	= 2,
        ["green"]	= 2,
        ["trivial"]	= 1,
        ["gray"]	= 1,
        ["grey"]	= 1,
    }
    assert(difficulties[name], 'Unknown difficulty ' .. name)
    return difficulties[name]
end

---Get difficulty name from number (3, 2, ...)
---@return string Difficulty name (medium, trivial, ...)
function lib.difficultyNumToName(number)
    local difficulties = {
        [4] = 'optimal',
        [3] = 'medium',
        [2] = 'easy',
        [1] = 'trivial',
    }
    assert(difficulties[number], 'Unknown difficulty ' .. number)
    return difficulties[number]
end

--/dump LibStub("BM-utils-2"):DifficultyColor("medium")
function lib.difficultyColor(difficulty, return_ColorMixin)
    assert(difficulty, 'Difficulty not set')
    local TradeSkillTypeColor = {}
    TradeSkillTypeColor["optimal"]	= { r = 1.00, g = 0.50, b = 0.25, font = "GameFontNormalLeftOrange" };
    TradeSkillTypeColor["medium"]	= { r = 1.00, g = 1.00, b = 0.00, font = "GameFontNormalLeftYellow" };
    TradeSkillTypeColor["easy"]		= { r = 0.25, g = 0.75, b = 0.25, font = "GameFontNormalLeftLightGreen" };
    TradeSkillTypeColor["trivial"]	= { r = 0.50, g = 0.50, b = 0.50, font = "GameFontNormalLeftGrey" };
    TradeSkillTypeColor["header"]	= { r = 1.00, g = 0.82, b = 0,    font = "GameFontNormalLeft" };

    if type(difficulty) == 'number' or TradeSkillTypeColor[difficulty] == nil then
        difficulty = lib.difficultyNumToName(difficulty)
    end

    if return_ColorMixin then
        local colors = TradeSkillTypeColor[difficulty]
        return _G.CreateColor(colors['r'], colors['g'], colors['b'], 255)
    else
        return TradeSkillTypeColor[difficulty]
    end
end

function lib.difficultyColorText(text, difficulty)
    local color = lib.difficultyColor(difficulty, true)
    --text = CreateColor(colors['r'], colors['g'], colors['b'], 255):WrapTextInColorCode(text)
    return color:WrapTextInColorCode(text)
end

--Reference:
--https://wowwiki.fandom.com/wiki/UI_escape_sequences
--https://wow.gamepedia.com/ItemLink
--https://wowwiki.fandom.com/wiki/ItemLink

--- Extract itemId from a link
--- @param itemLink string Item link
--- @return number Item ID
function lib.itemIdFromLink(itemLink)
    if itemLink == nil then
        return nil
    end
    return tonumber(string.match(itemLink, "item:(%d+)"))
end

--- Get item name from item link
--- @param itemLink string Item link
--- @return string Item name
function lib.itemNameFromLink(itemLink)
    return string.match(itemLink, "%[(.-)%]")
end

--- Localization safe method to cast spells
--- @param spellId number The ID of the spell to cast
function lib.CastSpellById(spellId)
    local spellName = _G.GetSpellInfo(spellId)
    return _G.CastSpellByName(spellName)
end