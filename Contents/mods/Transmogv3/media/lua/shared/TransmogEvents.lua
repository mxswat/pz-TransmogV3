local TransmogV3 = require('TransmogV3')

if isClient() or (not isClient() and not isServer()) then -- the second condition is for SP
  local TransmogClient = require('TransmogClient')
  Events.OnLoad.Add(TransmogV3.patchAllClothing);
  Events.OnGameStart.Add(TransmogClient.requestTransmogModData);
  Events.OnReceiveGlobalModData.Add(TransmogClient.onReceiveGlobalModData);
end
-- itemVisuals.clear
-- itemVisual.clear
-- dressInClothingItem
if isServer() then
  local TransmogServer = require('TransmogServer')
  Events.OnServerStarted.Add(TransmogServer.generateTransmogModData)
end

function TestStuff()
  -- getPlayer():getHumanVisual():clear() -- this randomizes the body, skin, and hair and similiar
  local itemVisuals = ItemVisuals.new()
  getPlayer():getItemVisuals(itemVisuals)
  for i = 1, itemVisuals:size() do
    local clear = itemVisuals:get(i - 1):clear()
  end
  -- getPlayer():resetModelNextFrame();
end

-- local onClothingUpdated = function(player)
--   print('onClothingUpdated')
--   -- player:getWornItems():clear() -- This unequips all clothing the player is wearing :-|
--   -- player:getDescriptor():getHumanVisual():copyFrom()
--   -- local itemVisuals = ItemVisuals.new()
-- 	-- getPlayer():getItemVisuals(itemVisuals)
-- 	-- player:getItemVisuals():clear();
--   -- player:resetModelNextFrame();
--   player:dressInNamedOutfit("TutorialDad")
--   -- -- player.itemVisuals:clear();
--   -- player:resetModel();

--   -- local itemVisuals = ItemVisuals.new()
-- 	-- getPlayer():getItemVisuals(itemVisuals)
-- end
-- Events.OnClothingUpdated.Add(onClothingUpdated);
