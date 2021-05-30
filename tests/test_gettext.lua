local lu = require('luaunit')
loadfile('../addon/gettext.lua')()
---@type BMGettext
local gettext = _G['BMUtils-gettext-@version@']

_G.test = {}
local test = _G.test

function _G.GetLocale()
    return 'enUS'
end

function test:setUp()
    gettext:load({})
end

function test:testGettext()
    lu.assertEquals(gettext:gettext('test string'), 'test string')
end

function test:testNGettext()
    gettext.strings['_plurals'] = '(n != 1)'

    lu.assertEquals(gettext:ngettext('string', 'strings', 0), 'strings')
    lu.assertEquals(gettext:ngettext('string', 'strings', 1), 'string')
    lu.assertEquals(gettext:ngettext('string', 'strings', 2), 'strings')
end

function test:testNGettext2()
    gettext.strings['_plurals'] = '(n > 1)'

    lu.assertEquals(gettext:ngettext('string', 'strings', 0), 'string')
    lu.assertEquals(gettext:ngettext('string', 'strings', 1), 'string')
    lu.assertEquals(gettext:ngettext('string', 'strings', 2), 'strings')
end

os.exit(lu.LuaUnit.run())

