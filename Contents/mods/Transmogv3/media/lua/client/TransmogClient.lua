-- use one of the 0 to 1000 tmog item
-- tell the server that item_X is now transmogged to item Y -- Maybe use 2 script items files? One for Hidden, and one for Cosmetic? TransmogV3.items.txt
-- OR tell the server that item_X is now the hidden version of item Y
-- server syncs this with other player
-- win?
require('TransmogCore')

local Commands = {};
Commands.Transmog = {};

Commands.Transmog.GivePlayerTransmogClone = function(args)
  local cloneId = args.cloneId;
  local sourceItemName = args.sourceItemName;

end

local onServerCommand = function(module, command, args)
  if Commands[module] and Commands[module][command] then
    Commands[module][command](args)
  end
end

if isClient() then
  Events.OnClientCommand.Add(onServerCommand);
end


local function onReceiveGlobalModData(module, transmogData)
  if module ~= "TransmogData" or not transmogData then
    return
  end

  ModData.add("TransmogData", transmogData)

  UpdateLocalTransmog()
end

Events.OnReceiveGlobalModData.Add(onReceiveGlobalModData);

function ResetTransmogModData()
  sendClientCommand("Transmog", "ResetModData", {});
end
