-- local utils = require('TransmogUtils')
-- local joinArraylist = utils.joinArraylist

-- function CanBeTransmogged(item)
--   if item.getScriptItem then
--     item = item:getScriptItem()
--   end

--   if item:getModuleName() == "TransmogV3" then
--     return
--   end

--   local typeString = item:getTypeString()
--   local isClothing = typeString == 'Clothing'
--   local isBackpack = false -- typeString == "Container" and item:getBodyLocation() -- Not for now
--   -- if it has no clothingItemAsset there is no point in trasmoging it since it will not be transmogged anyway
--   local clothingItemAsset = item:getClothingItemAsset()
--   if (isClothing or isBackpack) and clothingItemAsset ~= nil then
--     return true
--   end
-- end

-- function UpdateLocalTransmog()
--   local transmogData = ModData.getOrCreate("TransmogData");
--   for cloneId, value in pairs(transmogData) do
--     SetTransmogClone(cloneId, value.source)
--     SetTransmogCloneAppearance(cloneId, value.appearance)
--   end
-- end

-- local manager = ScriptManager.instance
-- function SetTransmogClone(cloneName, sourceItemName)
--   local cloneScriptItem = manager:getItem(cloneName);
--   local sourceScriptItem = manager:getItem(sourceItemName);
--   local sourceItem = InventoryItemFactory.CreateItem(sourceItemName);

--   local params = {
--     ["Temperature"] = "Temperature",
--     ["Insulation"] = "Insulation",
--     ["ConditionLowerChance"] = "ConditionLowerChanceOneIn",
--     ["StompPower"] = "StompPower",
--     ["RunSpeedModifier"] = "RunSpeedModifier",
--     ["CombatSpeedModifier"] = "CombatSpeedModifier",
--     ["CanHaveHoles"] = "CanHaveHoles",
--     ["WeightWet"] = "WeightWet",
--     ["BiteDefense"] = "BiteDefense",
--     ["BulletDefense"] = "BulletDefense",
--     ["NeckProtectionModifier"] = "NeckProtectionModifier",
--     ["ScratchDefense"] = "ScratchDefense",
--     ["ChanceToFall"] = "ChanceToFall",
--     ["Windresistance"] = "WindResistance", -- <- Devs typo "r/R"
--     ["WaterResistance"] = "WaterResistance",
--     ["FabricType"] = "FabricType",
--     ["ActualWeight"] = "Weight",
--     ["BodyLocation"] = "BodyLocation",
--     ["DisplayCategory"] = "DisplayCategory",
--     -- ["RemoveOnBroken"] = "RemoveOnBroken", -- Unused
--     -- ["BloodClothingType"] = "BloodLocation", -- <- Why the this has a different name???
--   }

--   for invItemKey, DoParamKey in pairs(params) do
--     local getParam = "get" .. invItemKey;
--     if sourceItem[getParam] then
--       local value = tostring(sourceItem[getParam](sourceItem));
--       -- print(getParam .. ":" .. tostring(value));
--       cloneScriptItem:DoParam(DoParamKey .. " = " .. value);

--       local setParam = "set" .. invItemKey;
--       if cloneScriptItem[setParam] then
--         cloneScriptItem[setParam](cloneScriptItem, sourceItem[getParam](sourceItem));
--       end
--     end
--   end

--   --[ DoParam Extra Fixes ]--
--   local bloodClothingType = "BloodLocation = " .. joinArraylist(sourceScriptItem:getBloodClothingType())
--   -- print(bloodClothingType)
--   cloneScriptItem:DoParam(bloodClothingType);

--   local icon = sourceScriptItem:getIcon()
--   if sourceScriptItem:getIconsForTexture() and not sourceScriptItem:getIconsForTexture():isEmpty() then
--     icon = sourceScriptItem:getIconsForTexture():get(0)
--   end
--   cloneScriptItem:DoParam("Icon = " .. tostring(icon));

--   cloneScriptItem:setDisplayName(sourceItem:getName() .. '+Tmog')
-- end

-- function SetTransmogCloneAppearance(cloneName, appearanceItemName)
--   local cloneScriptItem = manager:getItem(cloneName);
--   local appearanceScriptItem = manager:getItem(appearanceItemName);

--   cloneScriptItem:setClothingItemAsset(appearanceScriptItem:getClothingItemAsset())
-- end
