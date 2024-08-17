local lu = require('luaunit')

loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('build_utils/utils/load_toc.lua')('../BM-utils.toc')

---@type BMUtilsCharacterInfo
local lib = _G['BM-utils-@project-version@']:GetModule("BMUtilsCharacterInfo")

function testGetCharacterInfoDefault()
    local character, realm = lib.getCharacterInfo()
    lu.assertEquals(character, 'Quadduo')
    lu.assertEquals(realm, 'Mirage Raceway')
end

function testGetCharacterInfo()
    local character, realm = lib.getCharacterInfo('Quadgnome')
    lu.assertEquals(character, 'Quadgnome')
    lu.assertEquals(realm, 'Mirage Raceway')
end

function testGetCharacterStringDefault()
    local string = lib.getCharacterString()
    lu.assertEquals(string, 'Quadduo-Mirage Raceway')
end

function testGetCharacterString()
    local string = lib.getCharacterString('Quadgnome')
    lu.assertEquals(string, 'Quadgnome-Mirage Raceway')
end

function testSplitCharacterString()
    local character, realm = lib.splitCharacterString('Quadduo-Mirage Raceway')
    lu.assertEquals(character, 'Quadduo')
    lu.assertEquals(realm, 'Mirage Raceway')
end

function testRaceIcon()
    local _, coordinates = lib.raceIcon('human', 'female')
    lu.assertEquals({ 0, 0.25, 0.5, 0.75 }, coordinates)
end

function testRaceIconInt()
    local _, coordinates = lib.raceIcon('human', 3)
    lu.assertEquals({ 0, 0.25, 0.5, 0.75 }, coordinates)
end

function testRaceIconCurrentPlayer()
    local _, coordinates = lib.raceIcon()
    lu.assertEquals({ 0.75, 1.0, 0.5, 0.75 }, coordinates)
end

function testGender()
    lu.assertEquals('unknown', lib.genderString(1))
    lu.assertEquals('male', lib.genderString(2))
    lu.assertEquals('female', lib.genderString(3))
end

os.exit(lu.LuaUnit.run())