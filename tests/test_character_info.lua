local lu = require('luaunit')
loadfile('build_utils/wow_api/functions.lua')()

---@type BMUtils
local lib = {}
loadfile('../addon/CharacterInfo.lua')('', lib)

function testGetCharacterInfoDefault()
    local character, realm = lib.character.getCharacterInfo()
    lu.assertEquals(character, 'Quadduo')
    lu.assertEquals(realm, 'Mirage Raceway')
end

function testGetCharacterInfo()
    local character, realm = lib.character.getCharacterInfo('Quadgnome')
    lu.assertEquals(character, 'Quadgnome')
    lu.assertEquals(realm, 'Mirage Raceway')
end

function testGetCharacterStringDefault()
    local string = lib.character.getCharacterString()
    lu.assertEquals(string, 'Quadduo-Mirage Raceway')
end

function testGetCharacterString()
    local string = lib.character.getCharacterString('Quadgnome')
    lu.assertEquals(string, 'Quadgnome-Mirage Raceway')
end

function testSplitCharacterString()
    local character, realm = lib.character.splitCharacterString('Quadduo-Mirage Raceway')
    lu.assertEquals(character, 'Quadduo')
    lu.assertEquals(realm, 'Mirage Raceway')
end

function testRaceIcon()
    local _, coordinates = lib.character.raceIcon('human', 'female')
    lu.assertEquals({ 0, 0.25, 0.5, 0.75 }, coordinates)
end

function testRaceIconInt()
    local _, coordinates = lib.character.raceIcon('human', 3)
    lu.assertEquals({ 0, 0.25, 0.5, 0.75 }, coordinates)
end

function testRaceIconCurrentPlayer()
    local _, coordinates = lib.character.raceIcon()
    lu.assertEquals({ 0.75, 1.0, 0.5, 0.75 }, coordinates)
end

function testGender()
    lu.assertEquals('unknown', lib.character.genderString(1))
    lu.assertEquals('male', lib.character.genderString(2))
    lu.assertEquals('female', lib.character.genderString(3))
end

os.exit(lu.LuaUnit.run())