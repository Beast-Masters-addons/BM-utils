local lu = require('luaunit')
---@type BMUtils
local addon = {}

loadfile('build_utils/wow_api/functions.lua')()
loadfile('../addon/basic.lua')('', addon)

---@type BMUtilsBasic
local basic = addon.basic

function testIsFloat()
    lu.assertTrue(basic.isFloat(2.1))
end

function testIsNotFloat()
    lu.assertFalse(basic.isFloat(1))
end

function testParseFloat()
    _G.DECIMAL_SEPERATOR = ','
    lu.assertEquals(basic.parseFloat('1,1'), 1.1)
end

function testFormatFloat()
    _G.DECIMAL_SEPERATOR = ','
    lu.assertEquals(basic.formatFloat(1.1), '1,1')
end

function testEmpty()
    lu.assertTrue(basic.empty(''))
    lu.assertTrue(basic.empty(nil))
    lu.assertTrue(basic.empty({}))
    lu.assertTrue(basic.empty(false))
    lu.assertFalse(basic.empty({ test = 2 }))
    lu.assertFalse(basic.empty('test'))
    lu.assertFalse(basic.empty(true))
    lu.assertFalse(basic.empty({ first = nil, key = false }))
    lu.assertFalse(basic.empty(1))
    lu.assertFalse(basic.empty(0))
end

function testPrintf()
    local text = basic.printf('Quad%s', 'duo')
    lu.assertEquals(text, 'Quadduo')
end

function testSprintf()
    local text = basic.sprintf('Quad%s', 'duo')
    lu.assertEquals(text, 'Quadduo')
end

os.exit(lu.LuaUnit.run())