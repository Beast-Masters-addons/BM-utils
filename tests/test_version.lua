local lu = require('luaunit')
loadfile('../addon/utils.lua')()

_G['test'] = {}
local test = _G['test']
test.utils = _G['BMUtils']

function test:testInvalidMajorVersion()
    local status, message = self.utils:version_check('v1.1.1', 2, 1)
    lu.assertEquals(message, 'Required major version 2, loaded is 1')
    lu.assertFalse(status)
end

function test:testInvalidMinorVersion()
    local status, message = self.utils:version_check('v2.1.1', 2, 2)
    lu.assertEquals(message, 'Required at least version 2.2, loaded version is 2.1 (v2.1.1)')
    lu.assertFalse(status)
end

function test:testCompatibleVersion()
    local status = self.utils:version_check('v1.2', 1, 1)
    lu.assertTrue(status)
end

function test:testSameVersion()
    local status = self.utils:version_check('v1.0', 1, 0)
    lu.assertTrue(status)
end

os.exit(lu.LuaUnit.run())