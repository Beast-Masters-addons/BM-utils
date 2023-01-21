local lu = require('luaunit')
loadfile('build_utils/wow_api/constants.lua')()
_G.C_Container = {}

if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
    function GetContainerNumSlots()
        --Create dummy function to skip loading of compatibility functions
    end
end

---@type BMUtils
local lib = {}
loadfile('../addon/ContainerCompat.lua')('', lib)

function _G.C_Container.GetContainerItemInfo(containerIndex, slotIndex)
    if containerIndex == 1 and slotIndex == 1 then
        return {
            hasLoot = false,
            hyperlink = "|cffffffff|Hitem:6948::::::::49:253:::::|h[Hearthstone]|h|r",
            iconFileID = 134414,
            hasNoValue = true,
            isLocked = false,
            itemID = 6948,
            isBound = true,
            stackCount = 1,
            isFiltered = false,
            isReadable = false,
            quality = 1,
        }
    end
end

if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
    --Compat should not be loaded on classic era
    function testCompatLoaded()
        lu.assertNil(_G.ContainerCompatLoaded)
    end
else
    function testCompatLoaded()
        lu.assertTrue(_G.ContainerCompatLoaded())
    end

    function testContainerItemNil()
        lu.assertNil(GetContainerItemInfo(1, 99))
    end

    function testGetContainerItemInfo()
        local icon = GetContainerItemInfo(1, 1)
        lu.assertEquals(134414, icon)
    end
end

os.exit(lu.LuaUnit.run())