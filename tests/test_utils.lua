local lu = require('luaunit')

loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/mixin.lua')()
loadfile('build_utils/wow_api/Color.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('build_utils/utils/load_toc.lua')('../BM-utils.toc')

---@type BMUtils
local utils = _G['BM-utils-@project-version@']:GetModule("BMUtils")

_G['test'] = {}
local test = _G['test']

function test:testColor_to_rgb()
    local r, g, b = utils:ColorToRGB({ r = 0.25, g = 0.75, b = 0.25 })
    lu.assertEquals(r, 63.75)
    lu.assertEquals(g, 191.25)
    lu.assertEquals(b, 63.75)
end

function test:testGenerateHexColor()
    local hex = utils:GenerateHexColor(63.75, 191.25, 63.75)
    lu.assertEquals(hex, 'ff3fbf3f')
end

function test:testColor_to_hex()
    local hex = utils:ColorToHex({ r = 0.25, g = 0.75, b = 0.25 })
    lu.assertEquals(hex, 'ff3fbf3f')
end

function test:testDifficultyNameToNum()
    lu.assertEquals(3, utils.difficultyNameToNum('medium'))
end

function test:testDifficultyNumToName()
    lu.assertEquals('medium', utils.difficultyNumToName(3))
end

function test:testItemIdFromLink()
    local id = utils.itemIdFromLink('|cffffffff|Hitem:2318::::::::25:::::::|h[Light Leather]|h|r')
    lu.assertEquals(id, 2318)
end

function test:testItemNameFromLink()
    local id = utils.itemNameFromLink('|cffffffff|Hitem:2318::::::::25:::::::|h[Light Leather]|h|r')
    lu.assertEquals(id, 'Light Leather')
end

function test:testDifficultyColor()
    local color = utils.difficultyColor("optimal")
    lu.assertEquals(color, { r = 1.00, g = 0.50, b = 0.25, font = "GameFontNormalLeftOrange" })
    local mixin = utils.difficultyColor("optimal", true)
    local r, g, b = mixin:GetRGB()
    lu.assertEquals(r, 1.00)
    lu.assertEquals(g, 0.50)
    lu.assertEquals(b, 0.25)
end

function test:testDifficultyColorNum()
    local color = utils.difficultyColor(2)
    lu.assertEquals(color, { r = 0.25, g = 0.75, b = 0.25, font = "GameFontNormalLeftLightGreen" })
end

function test:testDifficultyColorText()
    local text = utils.difficultyColorText('colored', 'medium')
    lu.assertEquals(text, '|cffffff00colored|r')
end

function test:testCastSpellById()
    local spell = utils.CastSpellById(186257)
    lu.assertEquals(spell, 'Aspect of the Cheetah')
end

function test:gettext()
    lu.assertNotNil(utils.gettext)
end

os.exit(lu.LuaUnit.run())

