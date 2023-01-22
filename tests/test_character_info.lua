local lu = require('luaunit')
---@type BMUtils
local addon = {}

loadfile('build_utils/wow_api/functions.lua')()

---@type BMUtils
local lib = {}
loadfile('../addon/CharacterInfo.lua')('', lib)

function testCharacterIcon()
    local _, coordinates = lib.character.icon('human', 'female')
    lu.assertEquals({ 0, 0.25, 0.5, 0.75 }, coordinates)
end

function testCharacterIconCurrentPlayer()
    local _, coordinates = lib.character.icon()
    lu.assertEquals({ 0.75, 1.0, 0.5, 0.75 }, coordinates)
end

function testGender()
    lu.assertEquals('unknown', lib.character.genderString(1))
    lu.assertEquals('male', lib.character.genderString(2))
    lu.assertEquals('female', lib.character.genderString(3))
end

os.exit(lu.LuaUnit.run())