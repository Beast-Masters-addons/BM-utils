---@class BMUtilsTable Table utilities
local lib = _G.LibStub:NewLibrary("BMUtilsTable", 0)
if not lib then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@type BMUtilsBasic
local basic = _G.LibStub("BMUtilsBasic")

function lib.subTableCheck(tableData, ...)
    --https://stackoverflow.com/questions/7183998/in-lua-what-is-the-right-way-to-handle-varargs-which-contains-nil
    for _, value in ipairs { ... } do
        if type(tableData[value]) ~= 'table' or basic.empty(tableData[value]) then
            tableData[value] = {}
        end
        tableData = tableData[value]
    end
end

