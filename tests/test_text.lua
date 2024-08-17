local lu = require('luaunit')

loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('build_utils/utils/load_toc.lua')('../BM-utils.toc')

---@type BMUtilsText
local lib = _G['BM-utils-@project-version@']:GetModule("BMUtilsText")
---@type BMUtils
local utils = _G['BM-utils-@project-version@']:GetModule("BMUtils")

function testColorize()
    local text = lib.colorize('Quadduo', 'ff3fbf3f')
    lu.assertEquals(text, '|cff3fbf3fQuadduo|r')
end

function testColorizeInt()
    local text = lib.colorize('Quadduo', 0x3f, 0xbf, 0x3f)
    lu.assertEquals(text, '|cff3fbf3fQuadduo|r')
end

function testColorizeInt10()
    local text = lib.colorize('Quadduo', 255, 0, 0)
    lu.assertEquals(text, '|cffff0000Quadduo|r')
end

function testColorize1()
    local text = lib.colorize('Quadduo', utils:ColorToRGB(0, 0.5, 1))
    lu.assertEquals(text, '|cff007fffQuadduo|r')
end

function testColorizeInvalidArgument()

    lu.assertErrorMsgContains('Invalid arguments', function()
        lib.colorize('Quadduo', 'bad1', 'bad2')
    end)
end

function testDefaultFontColor()
    local _, r, g, b = lib.cprint('test')
    lu.assertEquals(r, 1)
    lu.assertEquals(g, 1)
    lu.assertEquals(b, 1)
    lib.SetDefaultFontColor(0, 0.25, 0.35)
    _, r, g, b = lib.cprint('test')
    lu.assertEquals(r, 0)
    lu.assertEquals(g, 0.25)
    lu.assertEquals(b, 0.35)
end

function testError()
    local error, r, g, b = lib.error('this is bad')
    lu.assertEquals(error, 'this is bad')
    lu.assertEquals(r, 1)
    lu.assertEquals(g, 0)
    lu.assertEquals(b, 0)
end

os.exit(lu.LuaUnit.run())