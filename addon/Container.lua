---@type BMUtils
local _, addon = ...
if not addon then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilsContainer Container API polyfill for WoW Classic
addon.container = {}
local container = addon.container

local is_classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE

---Returns the total number of slots in the bag specified by the index.
---@param bagID int The slot containing the bag, e.g. 0 for backpack, etc.
function container.GetContainerNumSlots(bagID)
    if is_classic then
        return _G.GetContainerNumSlots(bagID)
    else
        return _G.C_Container.GetContainerNumSlots(bagID)
    end
end

function container.GetContainerItemInfo(bagID, slot)
    if is_classic then
        local icon, itemCount, locked, quality, readable, lootable,
        itemLink, isFiltered, noValue, itemID, isBound = _G.GetContainerItemInfo(bagID, slot)
        return {
            hasLoot = lootable,
            hyperlink = itemLink,
            iconFileID = icon,
            hasNoValue = noValue,
            isLocked = locked,
            itemID = itemID,
            isBound = isBound,
            stackCount = itemCount,
            isFiltered = isFiltered,
            isReadable = readable,
            quality = quality,
        }
    else
        return _G.C_Container.GetContainerItemInfo(bagID, slot)
    end
end

function container.PickupContainerItem(containerIndex, slotIndex)
    if is_classic then
        return _G.PickupContainerItem(containerIndex, slotIndex)
    else
        return _G.C_Container.PickupContainerItem(containerIndex, slotIndex)
    end
end
