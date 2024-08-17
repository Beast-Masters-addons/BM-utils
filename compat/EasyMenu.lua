--Copied from 10.2.7 UI source
--https://github.com/Gethe/wow-ui-source/blob/10.2.7/Interface/AddOns/Blizzard_FrameXML/EasyMenu.lua

-- Simplified Menu Display System
--	This is a basic system for displaying a menu from a structure table.
--
--	See UIDropDownMenu.lua for the menuList details.
--
--	Args:
--		menuList - menu table
--		menuFrame - the UI frame to populate
--		anchor - where to anchor the frame (e.g. CURSOR)
--		x - x offset
--		y - y offset
--		displayMode - border type
--		autoHideDelay - how long until the menu disappears
--
--

local function EasyMenuCustom_Initialize(frame, level, menuList)
    for index = 1, #menuList do
        local value = menuList[index]
        if (value.text) then
            value.index = index;
            UIDropDownMenu_AddButton(value, level);
        end
    end
end

local function EasyMenuCustom(menuList, menuFrame, anchor, x, y, displayMode, autoHideDelay)
    if (displayMode == "MENU") then
        menuFrame.displayMode = displayMode;
    end
    UIDropDownMenu_Initialize(menuFrame, EasyMenuCustom_Initialize, displayMode, nil, menuList);
    ToggleDropDownMenu(1, nil, menuFrame, anchor, x, y, menuList, nil, autoHideDelay);
end

if _G.EasyMenu == nil then
    _G.EasyMenu = EasyMenuCustom
end