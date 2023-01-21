---@type BMUtils
local addonName, lib = ...

local version = '@project-version@'
local v_major, v_minor = _G['BMUtils-Version'].parse_version(version)
---@class BMUtils

if not _G.LibStub:NewLibrary("BM-utils-" .. v_major, v_minor) then
    -- luacov: disable
    return    -- already loaded and no upgrade necessary
    -- luacov: enable
end

lib.version = version
lib.v_major, lib.v_minor = v_major, v_minor
lib.is_classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE
lib.name = addonName

--All modules are registered here for code completion and type hinting
---@type BMUtilsCharacterInfo
lib.character = {}
---@type BMUtilsContainer
lib.container = {}
---@type BMUtilsBasic
lib.basic = {}
---@type BMGettext
lib.gettext = {}
---@type BMUtilsTable
lib.table = {}
---@type BMUtilsText
lib.text =  {}

_G['LibStub'].libs['BM-utils-' .. v_major] = lib
