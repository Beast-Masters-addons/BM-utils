local lu = require('luaunit')
local addon = {}

loadfile('wow_functions.lua')()
loadfile('../addon/version.lua')()
loadfile('../addon/utils.lua')()
loadfile('../addon/basic.lua')('', addon)
loadfile('../addon/table.lua')('', addon)
loadfile('build_utils/wow_api/functions.lua')()

_G['test'] = {}
local tests = _G['test']

---@type BMUtilsTable
local utils = addon.table

function tests:testSubTableCheck()
    local data = {}
    utils.subTableCheck(data, 'key1', 'key2')
    lu.assertEquals(data, { key1 = { key2 = {} } })
end

os.exit(lu.LuaUnit.run())