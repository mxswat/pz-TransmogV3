local TransmogV3 = require('TransmogV3')
local scriptManager = getScriptManager();

local function getTransmogModData()
  local TransmogModData = ModData.get("TransmogModData");
  return TransmogModData or {
        itemToCloneMap = {},
        cloneToItemMap = {},
      }
end

local function generateTransmogModData()
  print('TransmogV3:generateTransmogModData')
  local allItems = scriptManager:getAllItems()
  local TransmogModData = getTransmogModData()
  local itemToCloneMap = TransmogModData.itemToCloneMap or {}
  local cloneToItemMap = TransmogModData.cloneToItemMap or {}

  local serverTransmoggedItemCount = 0
  local size = allItems:size() - 1;
  for i = 0, size do
    local item = allItems:get(i);
    if TransmogV3.isItemTransmoggable(item) then
      local fullName = item:getFullName()
      serverTransmoggedItemCount = serverTransmoggedItemCount + 1
      if not itemToCloneMap[fullName] then
        table.insert(cloneToItemMap, fullName)
        itemToCloneMap[fullName] = #cloneToItemMap
      end
    end
  end

  if #cloneToItemMap >= 5000 then
    print("TransmogV3 ERROR: Reached limit of transmoggable items")
  end

  ModData.add("TransmogModData", TransmogModData)
  ModData.transmit("TransmogModData")

  print('TransmogV3 Transmogged items count: ' .. tostring(serverTransmoggedItemCount))
end

return {
  generateTransmogModData = generateTransmogModData
}
