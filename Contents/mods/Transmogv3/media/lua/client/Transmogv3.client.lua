-- use one of the 0 to 1000 tmog item
-- tell the server that item_X is now transmogged to item Y -- Maybe use 2 script items files? One for Hidden, and one for Cosmetic? TransmogV3.items.txt
-- OR tell the server that item_X is now the hidden version of item Y
-- server syncs this with other player
-- win?

local canBeTransmogged = function(item)
  if item.getScriptItem then
    item = item:getScriptItem()
  end

  local typeString = item:getTypeString()
  local isClothing = typeString == 'Clothing'
  local isBackpack = typeString == "Container" and item:getBodyLocation()
  -- if it has no clothingItemAsset there is no point in trasmoging it since it will not be transmogged anyway
  local clothingItemAsset = item:getClothingItemAsset()
  if (isClothing or isBackpack) and clothingItemAsset ~= nil then
    return true
  end
end

local manager = ScriptManager.instance
local function TransmogItem(sourceItem)
  local transmogScriptItem = manager:getItem("TransmogV3.TransmogHide_1");

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
    ["Windresistance"] = "WindResistance", -- <- Devs typo
    ["WaterResistance"] = "WaterResistance",
    ["FabricType"] = "FabricType",
    ["ActualWeight"] = "Weight",
    -- ["RemoveOnBroken"] = "RemoveOnBroken", -- Unused
    -- ["BloodClothingType"] = "BloodLocation", -- <- Why the this has a different name???
  }

  -- BloodLocation
  for invItemKey, DoParamKey in pairs(params) do
    local getParam = "get" .. invItemKey;
    if sourceItem[getParam] then
      local value = tostring(sourceItem[getParam](sourceItem));
      print(getParam .. ":" .. tostring(value));
      transmogScriptItem:DoParam(DoParamKey .. " = " .. value);
    end
  end

  local bloodClothingType = sourceItem:getBloodClothingType()
  local value = ""
  local size = bloodClothingType:size() - 1
  for i = 0, size do
    local type = tostring(bloodClothingType:get(i))
    value = value..type..(size < i and ";" or "")
  end

  print("BloodLocation = "..value)
  transmogScriptItem:DoParam("BloodLocation = " .. value);

  local spawnedItem = getPlayer():getInventory():AddItem("TransmogV3.TransmogHide_1");

  spawnedItem:setName(sourceItem:getName());
end

local old_ISInventoryPaneContextMenu_createMenu = ISInventoryPaneContextMenu.createMenu
ISInventoryPaneContextMenu.createMenu = function(player, isInPlayerInventory, items, x, y, origin)
  local context = old_ISInventoryPaneContextMenu_createMenu(player, isInPlayerInventory, items, x, y, origin)
  local testItem = nil
  local clothing = nil
  for _, v in ipairs(items) do
    testItem = v;
    if not instanceof(v, "InventoryItem") then
      testItem = v.items[1];
    end
    if canBeTransmogged(testItem) then
      clothing = testItem;
    end
  end

  if tostring(#items) == "1" and clothing then
    local transmog = context:addOption("Transmog", clothing, TransmogItem);
  end

  return context
end
