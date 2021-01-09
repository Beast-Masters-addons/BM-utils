---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Anders.
--- DateTime: 07.12.2019 19.47
---
local lu = require('luaunit')

loadfile('wow_functions.lua')()
loadfile('../addon/version.lua')()
loadfile('../addon/utils.lua')()

_G['test'] = {}
local test = _G['test']
test.utils = _G['BMUtils']

function test:testPrintf()
    local text = self.utils:printf('Quad%s', 'duo')
    lu.assertEquals(text, 'Quadduo')
end

function test:testSprintf()
    local text = self.utils:sprintf('Quad%s', 'duo')
    lu.assertEquals(text, 'Quadduo')
end

function test:testColorize()
    local text = self.utils:colorize('Quadduo', 'ff3fbf3f')
    lu.assertEquals(text, '|cff3fbf3fQuadduo|r')
end

function test:testColorizeInt()
    local text = self.utils:colorize('Quadduo', 0x3f, 0xbf, 0x3f)
    lu.assertEquals(text, '|cff3fbf3fQuadduo|r')
end

function test:testColorize1()
    local text = self.utils:colorize('Quadduo', self.utils:ColorToRGB(0, 0.5, 1))
    lu.assertEquals(text, '|cff007fffQuadduo|r')
end

function test:testDefaultFontColor()
    local _, r, g, b = self.utils:cprint('test')
    lu.assertEquals(r, 1)
    lu.assertEquals(g, 1)
    lu.assertEquals(b, 1)
    self.utils:SetDefaultFontColor(0, 0.25, 0.35)
    _, r, g, b = self.utils:cprint('test')
    lu.assertEquals(r, 0)
    lu.assertEquals(g, 0.25)
    lu.assertEquals(b, 0.35)
end

function test:testIsWoWClassic()
    local is_classic = self.utils:IsWoWClassic()
    lu.assertEquals(is_classic, os.getenv('CLASSIC_VERSION') ~= nil)
end

function test:testError()
    local error, r, g, b = self.utils:error('this is bad')
    lu.assertEquals(error, 'this is bad')
    lu.assertEquals(r, 1)
    lu.assertEquals(g, 0)
    lu.assertEquals(b, 0)
end

function test:testGetCharacterInfo()
    local character, realm = self.utils:GetCharacterInfo()
    lu.assertEquals(character, 'Quadduo')
    lu.assertEquals(realm, 'MirageRaceway')

    character, realm = self.utils:GetCharacterInfo('Quadgnome')
    lu.assertEquals(character, 'Quadgnome')
    lu.assertEquals(realm, 'MirageRaceway')
end

function test:testGetCharacterString()
    local string = self.utils:GetCharacterString()
    lu.assertEquals(string, 'Quadduo-MirageRaceway')
    string = self.utils:GetCharacterString('Quadgnome')
    lu.assertEquals(string, 'Quadgnome-MirageRaceway')
end

function test:testColor_to_rgb()
    local r,g,b = self.utils:ColorToRGB({ r = 0.25, g = 0.75, b = 0.25 })
    lu.assertEquals(r, 63.75)
    lu.assertEquals(g, 191.25)
    lu.assertEquals(b, 63.75)
end

function test:testGenerateHexColor()
    local hex = self.utils:GenerateHexColor(63.75, 191.25, 63.75)
    lu.assertEquals(hex, 'ff3fbf3f')
end

function test:testColor_to_hex()
    local hex = self.utils:ColorToHex({ r = 0.25, g = 0.75, b = 0.25 })
    lu.assertEquals(hex, 'ff3fbf3f')
end

function test:testDifficultyToNum()
    local num = self.utils:DifficultyToNum("medium")
    lu.assertEquals(num, 3)
end

function test:testSplitCharacterString()
    local character, realm = self.utils:SplitCharacterString('Quadduo-Mirage Raceway')
    lu.assertEquals(character, 'Quadduo')
    lu.assertEquals(realm, 'Mirage Raceway')
end

function test:testItemIdFromLink()
    local id = self.utils:ItemIdFromLink('|cffffffff|Hitem:2318::::::::25:::::::|h[Light Leather]|h|r')
    lu.assertEquals(id, 2318)
end

function test:testItemNameFromLink()
    local id = self.utils:ItemNameFromLink('|cffffffff|Hitem:2318::::::::25:::::::|h[Light Leather]|h|r')
    lu.assertEquals(id, 'Light Leather')
end

function test:testDifficultyColor()
    local color = self.utils:DifficultyColor("optimal")
    lu.assertEquals(color, { r = 1.00, g = 0.50, b = 0.25, font = "GameFontNormalLeftOrange" })
    local mixin = self.utils:DifficultyColor("optimal", true)
    local r, g, b = mixin:GetRGB()
    lu.assertEquals(r, 1.00)
    lu.assertEquals(g, 0.50)
    lu.assertEquals(b, 0.25)
end

function test:testDifficultyColorText()
    local text = self.utils:DifficultyColorText('colored', 'medium')
    lu.assertEquals(text, '|cffffff00colored|r')
end

function test:testCastSpellById()
    local spell = self.utils:CastSpellById(186257)
    lu.assertEquals(spell, 'Aspect of the Cheetah')
end


os.exit( lu.LuaUnit.run() )

