local lu = require('luaunit')

loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/constants.lua')()
loadfile('build_utils/wow_api/container.lua')()

loadfile('../compat/ContainerCompat.lua')()

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