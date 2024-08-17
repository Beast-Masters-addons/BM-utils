local lu = require('luaunit')

loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('build_utils/utils/load_toc.lua')('../BM-utils.toc')

---@type BMUtilsTable
local utils = _G['BM-utils-@project-version@']:GetModule("BMUtilsTable")

_G['test'] = {}
local tests = _G['test']

function tests:testSubTableCheck()
    local data = {}
    utils.subTableCheck(data, 'key1', 'key2')
    lu.assertEquals(data, { key1 = { key2 = {} } })
end

os.exit(lu.LuaUnit.run())