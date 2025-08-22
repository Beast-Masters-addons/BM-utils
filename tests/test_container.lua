local lu = require('luaunit')

loadfile('build_utils/wow_api/constants.lua')()
loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('build_utils/wow_api/container.lua')()
loadfile('build_utils/utils/load_toc.lua')('../BM-utils.toc')

if os.getenv('GAME_VERSION') == 'wrath' then
    os.exit(0)
end

---@type BMUtilsContainer
local container = _G.C_Container

_G.test = {}
local test = _G.test

function test:testNumFreeSlots()
    lu.assertEquals(container.GetContainerNumFreeSlots(1), 10)
end

function test:testNumSlots()
    lu.assertEquals(container.GetContainerNumSlots(1), 30)
end

function test:testGetContainerItemInfo()
    local item = container.GetContainerItemInfo(1, 1)
    lu.assertEquals(item['itemID'], 6948)
end

function test:testPickupContainerItem()
    lu.assertEquals(container.PickupContainerItem(1, 1), 6948)
end

os.exit(lu.LuaUnit.run())