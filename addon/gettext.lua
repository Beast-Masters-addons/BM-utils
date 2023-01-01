---@type BMUtils
local _, addon = ...
if not addon then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMGettext A simple gettext implementation for use in WoW addons
addon.gettext = {}
---@type BMGettext
local gettext = addon.gettext

gettext.locales = {}
gettext.strings = {}

function gettext:load(locales)
    local localeName = _G.GetLocale()
    if locales[localeName] ~= nil then
        self.strings = locales[localeName]
    else
        self.strings = {}
    end
end

function gettext:gettext(str)
    if self.strings[str] ~= nil then
        return self.strings[str]
    else
        return str
    end
end

function gettext:ngettext(singular, plural, num)
    local rule = self.strings['_plurals']
    if rule == nil then
        rule = '(n != 1)'
    end

    if rule == '(n > 1)' and num > 1 then
        return self:gettext(plural)
    elseif rule == '(n != 1)' and num ~= 1 then
        return self:gettext(plural)
    else
        return self:gettext(singular)
    end
end