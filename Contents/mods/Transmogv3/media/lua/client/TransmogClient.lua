-- Make all clothing invisible
-- Use the clone items to generate the apperance items
-- Sync it with other clients
-- Win?

require('TransmogCore')

function ResetTransmogModData() -- To use in the Command Console when needed
  sendClientCommand("Transmog", "ResetModData", {});
end

local Commands = {};
Commands.Transmog = {};

Commands.Transmog.GivePlayerTransmogClone = function(args)
  local cloneId = args.cloneName;
  local sourceItemName = args.sourceItemName;

  local spawnedItem = getPlayer():getInventory():AddItem(args.cloneName);
end

local onServerCommand = function(module, command, args)
  print('onServerCommand' .. tostring(module) .. tostring(command))
  if Commands[module] and Commands[module][command] then
    Commands[module][command](args)
  end
end

Events.OnServerCommand.Add(onServerCommand);

local function onReceiveGlobalModData(module, transmogData)
  if module ~= "TransmogData" or not transmogData then
    return
  end

  ModData.add("TransmogData", transmogData)

  UpdateLocalTransmog()
end

Events.OnReceiveGlobalModData.Add(onReceiveGlobalModData);

local function hasTransmoggableBodylocation(item)
  local bodyLocation = item:getBodyLocation()

  return bodyLocation ~= "ZedDmg"
      and not string.find(bodyLocation, "MakeUp_")
      and not string.find(bodyLocation, "Transmog_")
      and not string.find(bodyLocation, "Hide_")
end

local function isItemTransmoggable(item)
  local typeString = item:getTypeString()
  local isClothing = typeString == 'Clothing'
  local isBackpack = false -- typeString == "Container" and item:getBodyLocation()
  local isClothingItemAsset = item:getClothingItemAsset() ~= nil
  local isWorldRender = item:isWorldRender()
  local isNotCosmetic = not item:isCosmetic()
  local isNotHidden = not item:isHidden()
  local isNotTransmog = item:getModuleName() ~= "TransmogV3"
  if (isClothing or isBackpack)
      and hasTransmoggableBodylocation(item)
      and isNotTransmog
      and isWorldRender
      and isClothingItemAsset
      and isNotHidden
      and isNotCosmetic then
    return true
  end
  return false
end

local function patchAllClothing()
  local sm = getScriptManager();
  local allItems = sm:getAllItems()
  local invisibleClothingItemAsset = sm:FindItem("TransmogV3.Hide_Everything"):getClothingItemAsset()

  local validItemsCount = 0
  local size = allItems:size() - 1;
  for i = 0, size do
    local item = allItems:get(i);
    if isItemTransmoggable(item) then
      item:setClothingItemAsset(invisibleClothingItemAsset)
      validItemsCount = validItemsCount + 1
    end
  end

  print('validItemsCount: '..tostring(validItemsCount))
  local player = getPlayer();
  player:resetModelNextFrame();
end

Events.OnLoad.Add(patchAllClothing);

-- getWornItems
