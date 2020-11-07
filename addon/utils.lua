_G['BMUtils'] = {}
local lib = _G['BMUtils']
lib.version = '@project-version@'

if LibStub then
	lib = LibStub:NewLibrary("BM-utils-1.0", 1)
end

if not lib then
    -- luacov: disable
    return	-- already loaded and no upgrade necessary
    -- luacov: enable
end

function lib:printf(str, ...)
    return DEFAULT_CHAT_FRAME:AddMessage(string.format(str, ...))
end

function lib:sprintf(str, ...)
    return string.format(str, ...)
end

function lib:parse_version(version)
    local major, minor = version:match('v(%d+).(%d+)')
    major = tonumber(major)
    minor = tonumber(minor)
    return major, minor
end

function lib:version_check(version, wanted_major, wanted_minor)
    local major, minor = self:parse_version(version)

    if wanted_major ~= major then
        return false, lib:sprintf('Required major version %s, loaded is %s', wanted_major, major)
    elseif wanted_minor > minor then
        return false, lib:sprintf('Required at least version %d.%d, loaded version is %d.%d (%s)',
                wanted_major, wanted_minor, major, minor, version)
    else
        return true
    end
end

--- Add a message to chat frame with specified color
--/run print(LibStub('BM-utils-1.0'):colorize('red', 'ffff0000'))
--/run print(LibStub('BM-utils-1.0'):colorize('green', 'FF00FF00'))
function lib:colorize(str, rgb)
    --@debug@
    self:printf('RGB: %s', rgb)
    --@end-debug@
    return string.format('|c%s%s|r', rgb, str)
end

lib.DEFAULT_FONT_COLOR = {["R"]=1, ["G"]=1, ["B"]=1}
function lib:SetDefaultFontColor(r, g, b)
    self.DEFAULT_FONT_COLOR = {["R"]=r, ["G"]=g, ["B"]=b}
end

--/run LibStub('BM-utils-1.0'):cprint('red', 1, 0, 0)
--- Add a message to chat frame with colors
--- @param message string Message text
--- @param r number Red
--- @param g number Green
--- @param b number Blue
function lib:cprint(message, r, g, b)
    return DEFAULT_CHAT_FRAME:AddMessage(message,
            (r or self.DEFAULT_FONT_COLOR["R"]),
            (g or self.DEFAULT_FONT_COLOR["G"]),
            (b or self.DEFAULT_FONT_COLOR["B"]));
end

function lib:IsWoWClassic()
    return select(4, GetBuildInfo()) < 20000
end

--- Add a message to chat frame with red color
--- @param message string Message text
function lib:error(message)
    return self:cprint(message, 1, 0,0)
end

--- Get character name and realm, fall back to current player if character not specified
function lib:GetCharacterInfo(character, realm)
    if not character or character == "" then
        character = UnitName("player")
    end
    if not realm then
        realm = GetRealmName()
    end
    return character, realm
end

--- Get character name and realm as a string
function lib:GetCharacterString(character, realm)
    character, realm = self:GetCharacterInfo(character, realm)
    return string.format('%s-%s', character, realm)
end

function lib:SplitCharacterString(name)
    return string.match(name, "(.+)-(.+)")
end


--- Convert a color table with 0.0-1.0 floats to a 0-255 RGB int
function lib:ColorToRGB(color)
    return 255*color['r'], 255*color['g'], 255*color['b']
end

function lib:GenerateHexColor(r, g, b)
    return ("ff%.2x%.2x%.2x"):format(r, g, b);
    -- return string.format('%02X%02X%02X', r, g, b)
end

-- Convert a color table with 0.0-1.0 floats to a RGB hex string
function lib:ColorToHex(color)
    local r, g, b = self:ColorToRGB(color)
    return self:GenerateHexColor(r, g, b)
end

--/dump LibStub("BM-utils-1.0"):DifficultyToNum("medium")
function lib:DifficultyToNum(difficulty)
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
    return difficulties[difficulty]
end

--/dump LibStub("BM-utils-1.0"):DifficultyColor("medium")
function lib:DifficultyColor(difficulty, return_ColorMixin)
    local TradeSkillTypeColor = {}
    TradeSkillTypeColor["optimal"]	= { r = 1.00, g = 0.50, b = 0.25, font = "GameFontNormalLeftOrange" };
    TradeSkillTypeColor["medium"]	= { r = 1.00, g = 1.00, b = 0.00, font = "GameFontNormalLeftYellow" };
    TradeSkillTypeColor["easy"]		= { r = 0.25, g = 0.75, b = 0.25, font = "GameFontNormalLeftLightGreen" };
    TradeSkillTypeColor["trivial"]	= { r = 0.50, g = 0.50, b = 0.50, font = "GameFontNormalLeftGrey" };
    TradeSkillTypeColor["header"]	= { r = 1.00, g = 0.82, b = 0,    font = "GameFontNormalLeft" };

    if return_ColorMixin then
        local colors = TradeSkillTypeColor[difficulty]
        return CreateColor(colors['r'], colors['g'], colors['b'], 255)
    else
        return TradeSkillTypeColor[difficulty]
    end
end

function lib:DifficultyColorText(text, difficulty)
    local color = self:DifficultyColor(difficulty, true)
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
function lib:ItemIdFromLink(itemLink)
    if itemLink == nil then return nil end
    return tonumber(string.match(itemLink, "item:(%d+)"))
end

--- Get item name from item link
--- @param itemLink string Item link
--- @return string Item name
function lib:ItemNameFromLink(itemLink)
    return string.match(itemLink, "%[(.-)%]")
end

--- Localization safe method to cast spells
--- @param spellId number The ID of the spell to cast
function lib:CastSpellById(spellId)
	local spellName = GetSpellInfo(spellId)
	return CastSpellByName(spellName)
end