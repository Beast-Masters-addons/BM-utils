local lu = require('luaunit')

loadfile('build_utils/wow_api/constants.lua')()
local is_classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE

if is_classic then
    loadfile('build_utils/wow_api/container_classic.lua')()
else
    loadfile('build_utils/wow_api/container.lua')()
end

loadfile('../addon/version.lua')()
loadfile('../addon/utils.lua')()
loadfile('../addon/Container.lua')()

---@type BMGettext
local lib = _G['BMUtils']
---@type BMUtilsContainer
local container = lib.container

_G.test = {}
local test = _G.test

function test:testNumSlots()
    lu.assertEquals(container.GetContainerNumSlots(1), 30)
end

function test:testGetContainerItemInfo()
    local item = container.GetContainerItemInfo(1, 1)
    lu.assertEquals(item['itemID'], 6948)
end

os.exit(lu.LuaUnit.run())