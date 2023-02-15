-- use one of the 0 to 1000 tmog item
-- tell the server that item_X is now transmogged to item Y -- Maybe use 2 script items files? One for Hidden, and one for Cosmetic? TransmogV3.items.txt
-- OR tell the server that item_X is now the hidden version of item Y
-- server syncs this with other player
-- win?

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

local joinArraylist = function (arrayList)
  local value = ""
  local size = arrayList:size() - 1
  for i = 0, size do
    local type = tostring(arrayList:get(i))
    value = value..type..(size < i and ";" or "")
  end
  return value
end

local manager = ScriptManager.instance
function TransmogItem(sourceItem)
  print("Transmogging: "..sourceItem:getName())
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

  --[ DoParam Fixes ]--
  -- BloodLocation
  local bloodClothingType = "BloodLocation = " .. joinArraylist(sourceItem:getBloodClothingType()) 
  print(bloodClothingType)
  transmogScriptItem:DoParam(bloodClothingType);

  -- Icon
  local icon = sourceItemScriptItem:getIcon()
  if sourceItemScriptItem:getIconsForTexture() and not transmogScriptItem:getIconsForTexture():isEmpty() then
      icon = sourceItemScriptItem:getIconsForTexture():get(0)
  end
  transmogScriptItem:DoParam("Icon = " .. tostring(icon));

  --[ Other Fixes ]--
  -- setDisplayName fixes
  transmogScriptItem:setDisplayName(sourceItem:getName()..' +Transmog')

  -- Spawn the item
  local spawnedItem = getPlayer():getInventory():AddItem(toSpawn);
end