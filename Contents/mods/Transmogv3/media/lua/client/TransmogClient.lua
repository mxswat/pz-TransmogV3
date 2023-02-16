-- use one of the 0 to 1000 tmog item
-- tell the server that item_X is now transmogged to item Y -- Maybe use 2 script items files? One for Hidden, and one for Cosmetic? TransmogV3.items.txt
-- OR tell the server that item_X is now the hidden version of item Y
-- server syncs this with other player
-- win?
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
  print('onServerCommand'..tostring(module)..tostring(command))
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

local function OnLoad()
  ModData.request("TransmogData")
  print('OnLoad')
  UpdateLocalTransmog()
end

Events.OnLoad.Add(OnLoad);

local function OnGameStart()
  ModData.request("TransmogData")
  print('OnGameStart')
  UpdateLocalTransmog()
end
Events.OnGameStart.Add(OnGameStart);