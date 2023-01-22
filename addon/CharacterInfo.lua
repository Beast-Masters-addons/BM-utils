---@type BMUtils
local _, addon = ...
if not addon then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilsCharacterInfo Character info utils
addon.character = {}
---@type BMUtilsCharacterInfo
local character = addon.character


--- Get character name and realm, fall back to current player if character not specified
---@param characterName string Character name (use current character name if not specified)
---@param realm string Realm name (use current realm if not specified)
function character.getCharacterInfo(characterName, realm)
    if not characterName or characterName == "" then
        characterName = _G.UnitName("player")
    end
    if not realm then
        realm = _G.GetRealmName()
    end
    return characterName, realm
end

--- Format character name and realm as a string
---@param characterName string Character name (use current character name if not specified)
---@param realm string Realm name (use current realm if not specified)
---@return string Character and realm string (Quadduo-Mirage Raceway)
function character.getCharacterString(characterName, realm)
    characterName, realm = character.getCharacterInfo(characterName, realm)
    return ('%s-%s'):format(characterName, realm)
end

---Split a string with realm and character name
---@param name string Character and realm string (Quadduo-Mirage Raceway)
---@return string characterName, realm
function character.splitCharacterString(name)
    return string.match(name, "(.+)-(.+)")
end

---Get character race icon
---@param raceFile string Localization-independent race name
---@param genderString string Gender string (male or female)
function character.icon(raceFile, genderString)

    --https://wow.gamepedia.com/API_UnitRace
    if raceFile == nil then
        _, raceFile = _G.UnitRace('player')
    end

    if genderString == nil then
        genderString = character.genderString(_G.UnitSex('player'))
    end

    --https://wow.gamepedia.com/API_UnitClass
    --o.className, o.classFilename, o.classId = _G.UnitClass('player')

    local atlas = 'Interface/Glues/CharacterCreate/UI-CharacterCreate-Races'
    local race_coordinates = {
        HUMAN_MALE = { 0, 0.25, 0, 0.25 },
        DWARF_MALE = { 0.25, 0.5, 0, 0.25 },
        GNOME_MALE = { 0.5, 0.75, 0, 0.25 },
        NIGHTELF_MALE = { 0.75, 1.0, 0, 0.25 },
        TAUREN_MALE = { 0, 0.25, 0.25, 0.5 },
        SCOURGE_MALE = { 0.25, 0.5, 0.25, 0.5 },
        TROLL_MALE = { 0.5, 0.75, 0.25, 0.5 },
        ORC_MALE = { 0.75, 1.0, 0.25, 0.5 },
        HUMAN_FEMALE = { 0, 0.25, 0.5, 0.75 },
        DWARF_FEMALE = { 0.25, 0.5, 0.5, 0.75 },
        GNOME_FEMALE = { 0.5, 0.75, 0.5, 0.75 },
        NIGHTELF_FEMALE = { 0.75, 1.0, 0.5, 0.75 },
        TAUREN_FEMALE = { 0, 0.25, 0.75, 1.0 },
        SCOURGE_FEMALE = { 0.25, 0.5, 0.75, 1.0 },
        TROLL_FEMALE = { 0.5, 0.75, 0.75, 1.0 },
        ORC_FEMALE = { 0.75, 1.0, 0.75, 1.0 },
    }
    local key = raceFile:upper() .. '_' .. genderString:upper()
    assert(race_coordinates[key], 'Invalid race/gender combination')
    return atlas, race_coordinates[key]
end

---Convert gender id to string
function character.genderString(gender)
    if gender == 3 then
        return 'female'
    elseif gender == 2 then
        return 'male'
    else
        return 'unknown'
    end
end