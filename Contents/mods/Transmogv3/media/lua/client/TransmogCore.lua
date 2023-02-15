local utils = require('TransmogUtils')
local joinArraylist = utils.joinArraylist

function CanBeTransmogged(item)
  if item.getScriptItem then
    item = item:getScriptItem()
  end

  local typeString = item:getTypeString()
  local isClothing = typeString == 'Clothing'
  local isBackpack = false -- typeString == "Container" and item:getBodyLocation() -- Not for now
  -- if it has no clothingItemAsset there is no point in trasmoging it since it will not be transmogged anyway
  local clothingItemAsset = item:getClothingItemAsset()
  if (isClothing or isBackpack) and clothingItemAsset ~= nil then
    return true
  end
end

local manager = ScriptManager.instance
function TransmogItem(sourceItem)
  print("Transmogging: " .. sourceItem:getName())
  local toSpawn = "TransmogV3.TransmogClone_1"
  local sourceItemScriptItem = sourceItem:getScriptItem()
  local transmogScriptItem = manager:getItem(toSpawn);

  local params = {
    ["Temperature"] = "Temperature",
    ["Insulation"] = "Insulation",
    ["ConditionLowerChance"] = "ConditionLowerChance",
    ["StompPower"] = "StompPower",
    ["RunSpeedModifier"] = "RunSpeedModifier",
    ["CombatSpeedModifier"] = "CombatSpeedModifier",
    ["CanHaveHoles"] = "CanHaveHoles",
    ["WeightWet"] = "WeightWet",
    ["BiteDefense"] = "BiteDefense",
    ["BulletDefense"] = "BulletDefense",
    ["NeckProtectionModifier"] = "NeckProtectionModifier",
    ["ScratchDefense"] = "ScratchDefense",
    ["ChanceToFall"] = "ChanceToFall",
    ["Windresistance"] = "WindResistance", -- <- Devs typo "r/R"
    ["WaterResistance"] = "WaterResistance",
    ["FabricType"] = "FabricType",
    ["ActualWeight"] = "Weight",
    ["BodyLocation"] = "BodyLocation",
    -- ["RemoveOnBroken"] = "RemoveOnBroken", -- Unused
    -- ["BloodClothingType"] = "BloodLocation", -- <- Why the this has a different name???
  }

  for invItemKey, DoParamKey in pairs(params) do
    local getParam = "get" .. invItemKey;
    if sourceItem[getParam] then
      local value = tostring(sourceItem[getParam](sourceItem));
      print(getParam .. ":" .. tostring(value));
      transmogScriptItem:DoParam(DoParamKey .. " = " .. value);
    end
  end

  --[ DoParam Extra Fixes ]--
  local bloodClothingType = "BloodLocation = " .. joinArraylist(sourceItem:getBloodClothingType())
  print(bloodClothingType)
  transmogScriptItem:DoParam(bloodClothingType);

  local icon = sourceItemScriptItem:getIcon()
  if sourceItemScriptItem:getIconsForTexture() and not transmogScriptItem:getIconsForTexture():isEmpty() then
    icon = sourceItemScriptItem:getIconsForTexture():get(0)
  end
  transmogScriptItem:DoParam("Icon = " .. tostring(icon));

  --[ Other Fixes ]--
  transmogScriptItem:setDisplayName(sourceItem:getName() .. ' +Transmog')

  -- Spawn the item
  local spawnedItem = getPlayer():getInventory():AddItem(toSpawn);
end