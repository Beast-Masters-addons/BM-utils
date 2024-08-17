local version = '@project-version@'
local v_major, v_minor = _G['BMUtils-Version'].parse_version(version)

if not _G.LibStub:NewLibrary("BM-utils-" .. v_major, v_minor) then
    -- luacov: disable
    return    -- already loaded and no upgrade necessary
    -- luacov: enable
end

local lib = _G.LibStub("AceAddon-3.0"):NewAddon("BM-utils")

lib.version = version
lib.v_major, lib.v_minor = v_major, v_minor
lib.is_classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE

--Register with LibStub for external usage
_G['LibStub'].libs['BM-utils-' .. v_major] = lib
--Register global variable for internal usage
_G['BM-utils-@project-version@'] = lib