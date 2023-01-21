if _G.GetContainerNumSlots ~= nil then
    return --Do not load if global functions already exists
end

_G.GetBagName = _G.C_Container.GetBagName
_G.GetContainerItemID = _.G.C_Container.GetContainerItemID
_G.GetContainerItemLink = _G.C_Container.GetContainerItemLink
_G.GetContainerNumFreeSlots = _G.C_Container.GetContainerNumFreeSlots
_G.GetContainerNumSlots = _G.C_Container.GetContainerNumSlots
_G.PickupContainerItem = _G.C_Container.PickupContainerItem
_G.SplitContainerItem = _G.C_Container.SplitContainerItem
_G.UseContainerItem = _G.C_Container.UseContainerItem

function _G.GetContainerItemInfo(bagID, slot)
    local item = _G.C_Container.GetContainerItemInfo(bagID, slot)
    if item == nil then
        return
    end
    return item['iconFileID'], item['stackCount'], item['isLocked'], item['quality'], item['isReadable'],
    item['hasLoot'], item['hyperlink'], item['isFiltered'], item['hasNoValue'], item['itemID'], item['isBound']
end

