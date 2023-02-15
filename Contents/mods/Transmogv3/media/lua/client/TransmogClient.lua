-- use one of the 0 to 1000 tmog item
-- tell the server that item_X is now transmogged to item Y -- Maybe use 2 script items files? One for Hidden, and one for Cosmetic? TransmogV3.items.txt
-- OR tell the server that item_X is now the hidden version of item Y
-- server syncs this with other player
-- win?

local function onReceiveGlobalModData(module, packet)
  if module ~= "TransmogData" or not packet then
    return
  end

  ModData.add("TransmogData", packet)
end

Events.OnReceiveGlobalModData.Add(onReceiveGlobalModData);

function ResetTransmogModData()
  sendClientCommand("Transmog", "ResetModData", {});
end
