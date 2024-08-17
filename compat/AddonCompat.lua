--Do not load if global functions already exists
if _G.GetAddOnInfo == nil and _G.C_AddOns and _G.C_AddOns.GetAddOnInfo then
    _G.GetAddOnDependencies = _G.C_AddOns.GetAddOnDependencies
    _G.GetAddOnInfo = _G.C_AddOns.GetAddOnInfo
    _G.GetAddOnMetadata = _G.C_AddOns.GetAddOnMetadata
    _G.GetNumAddOns = _G.C_AddOns.GetNumAddOns
    _G.IsAddonLoaded = _G.C_AddOns.IsAddonLoaded
    _G.IsAddOnLoadOnDemand = _G.C_AddOns.IsAddOnLoadOnDemand
    _G.LoadAddOn = _G.C_AddOns.LoadAddOn
end