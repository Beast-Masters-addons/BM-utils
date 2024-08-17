if not _G['BM-utils-@project-version@'] then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilsTable Table utilities
local lib = _G['BM-utils-@project-version@']:NewModule("BMUtilsTable")
local basic = _G['BM-utils-@project-version@']:GetModule("BMUtilsBasic")

function lib.subTableCheck(tableData, ...)
    --https://stackoverflow.com/questions/7183998/in-lua-what-is-the-right-way-to-handle-varargs-which-contains-nil
    for _, value in ipairs { ... } do
        if type(tableData[value]) ~= 'table' or basic.empty(tableData[value]) then
            tableData[value] = {}
        end
        tableData = tableData[value]
    end
end

