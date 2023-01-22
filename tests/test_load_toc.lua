--luacheck: no global
local lu = require('luaunit')

loadfile('build_utils/wow_api/functions.lua')()
loadfile('wow_functions.lua')()
loadfile('build_utils/utils/load_toc.lua')('../BM-utils.toc')

---@type BMUtils
local addon = {}
loadfile('../addon/basic.lua')('', addon)
local basic = addon.basic

function testLoadLibStub()
    local lib = LibStub('BM-utils-0')
    lu.assertEquals(lib.version, '@project-version@')
    lu.assertFalse(lib.basic.isFloat(1))

    for key, value in pairs(lib) do
        lu.assertNotNil(value, ('%s is nil'):format(key))
        lu.assertFalse(basic.empty(value), ('%s is empty'):format(key))
    end

end

os.exit(lu.LuaUnit.run())