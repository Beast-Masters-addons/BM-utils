---@type BMUtils
local _, addon = ...
if not addon then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilsTable Table utilities
addon.table = {}
---@type BMUtilsTable
local lib = addon.table

function lib.subTableCheck(tableData, ...)
    --https://stackoverflow.com/questions/7183998/in-lua-what-is-the-right-way-to-handle-varargs-which-contains-nil
    for _, value in ipairs { ... } do
        if type(tableData[value]) ~= 'table' or addon.basic.empty(tableData[value]) then
            tableData[value] = {}
        end
        tableData = tableData[value]
    end
end

