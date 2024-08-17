if not _G['BM-utils-@project-version@'] then
    -- luacov: disable
    return --Check if addon is loaded
    -- luacov: enable
end

---@class BMUtilsContainer Container API polyfill for WoW Classic
local container = _G['BM-utils-@project-version@']:NewModule("BMUtilsContainer")

local is_classic_era = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC

---Returns the number of free slots in a bag.
---@param bagID int The slot containing the bag, e.g. 0 for backpack, etc.
---@return int numberOfFreeSlots - The number of free slots in the specified bag.
---@return int bagType - The type of the container, described using bits to indicate its permissible contents
function container.GetContainerNumFreeSlots(bagID)
    if is_classic_era then
        return _G.GetContainerNumFreeSlots(bagID)
    else
        return _G.C_Container.GetContainerNumFreeSlots(bagID)
    end
end

---Returns the total number of slots in the bag specified by the index.
---@param bagID int The slot containing the bag, e.g. 0 for backpack, etc.
function container.GetContainerNumSlots(bagID)
    if is_classic_era then
        return _G.GetContainerNumSlots(bagID)
    else
        return _G.C_Container.GetContainerNumSlots(bagID)
    end
end

function container.GetContainerItemInfo(bagID, slot)
    if is_classic_era then
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
    if is_classic_era then
        return _G.PickupContainerItem(containerIndex, slotIndex)
    else
        return _G.C_Container.PickupContainerItem(containerIndex, slotIndex)
    end
end
