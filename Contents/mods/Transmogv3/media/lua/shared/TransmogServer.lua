local Transmog = {}

function Transmog:newClonedItem(sourceItemName)
  local TransmogData = ModData.getOrCreate("TransmogData");
  local TransmogClones = ModData.getOrCreate("TransmogClones");
  local availableId = #TransmogClones + 1

  if availableId > 500 then
    print('Transmog Error: limit of items reached (Max 500)')
    return
  end

  TransmogData[sourceItemName] = sourceItemName
  TransmogClones[availableId] = sourceItemName

  ModData.add("TransmogData", TransmogData)

  ModData.transmit("TransmogData")
end

function Transmog:itemHasClone(sourceItemName)
  local TransmogData = ModData.getOrCreate("TransmogData");
  if TransmogData[sourceItemName] then
    return true
  end
  return false
end

local Commands = {};
Commands.Transmog = {};
Commands.Transmog.RequestTransmog = function(source, args) --- Event Triggered from ../client/Transmog.lua#L21-L23.
  local sourceId = source:getOnlineID(); -- Player id who triggered the event.
  local itemName = args.itemName;

  print("Player "..source:getUsername().."[".. sourceId .."] requested transmog for: ".. itemName)

  if Transmog:itemHasClone(itemName) then
    return -- it's already transmogged
  end

  Transmog:newClonedItem(itemName)
end

local onClientCommand = function(module, command, source, args) -- Events Constructor.
  if Commands[module] and Commands[module][command] then
    Commands[module][command](source, args);
  end
end

if isServer() then Events.OnClientCommand.Add(onClientCommand); end;

-- Mod data stuff
local function onServerReceiveGlobalModData(module, packet)
  if not isServer() then
    return
  end

  if module ~= "TransmogData" then
      return
  end

  if not packet then
      return
  end

  ModData.add(module, packet)

  ModData.transmit(module)
end

Events.OnReceiveGlobalModData.Add(onServerReceiveGlobalModData);
