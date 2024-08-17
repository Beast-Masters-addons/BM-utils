--luacheck: no global
local lu = require('luaunit')


-- Aliases required for LibStub
_G.debugstack = debug.traceback
_G.strmatch = string.match

loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('../libs/LibStub/LibStub.lua')()
loadfile('../libs/AceAddon-3.0/AceAddon-3.0.lua')()

loadfile('../addon/version.lua')()
loadfile('../addon/common.lua')('test')
loadfile('../addon/basic.lua')('test')

function testLoadInternal()
    ---@type BMUtils
    local lib = _G['BM-utils-@project-version@']
    local basic = lib:GetModule('BMUtilsBasic')
    lu.assertEquals(lib.version, '@project-version@')
    lu.assertFalse(basic.isFloat(1))
end

function testLoadLibStub()
    local lib = LibStub('BM-utils-2')
    local basic = lib:GetModule('BMUtilsBasic')
    lu.assertEquals(lib.version, '@project-version@')
    lu.assertFalse(basic.isFloat(1))
end

os.exit(lu.LuaUnit.run())