local Transmog = {}

function Transmog:newClonedItem(sourceItemName)
  local TransmogData = ModData.getOrCreate("TransmogData");
  local TransmogClones = ModData.getOrCreate("TransmogClones");
  local TransmogSources = ModData.getOrCreate("TransmogSources");
  local cloneId = #TransmogClones + 1

  print("New Transmog clone with id: " .. cloneId)

  if cloneId > 500 then
    print('Transmog Error: limit of items reached (Max 500)')
    return
  end

  local cloneName = 'TransmogV3.TransmogClone_' .. cloneId

  TransmogData[cloneName] = {
    source = sourceItemName,
    appearance = sourceItemName,
  }
  TransmogClones[cloneId] = sourceItemName -- Use id as number, so I can use the `#` to count the items
  TransmogSources[sourceItemName] = cloneName

  ModData.add("TransmogData", TransmogData)

  ModData.transmit("TransmogData")

  return cloneName
end

function Transmog:getCloneName(sourceItemName)
  local TransmogSources = ModData.getOrCreate("TransmogSources");
  return TransmogSources[sourceItemName]
end

local Commands = {};
Commands.Transmog = {};
Commands.Transmog.RequestTransmog = function(source, args)
  local itemName = args.itemName;
  
  local sourceId = source:getOnlineID();
  print("Player " .. source:getUsername() .. "[" .. sourceId .. "] requested transmog clone for: " .. itemName)

  local cloneName = Transmog:getCloneName(itemName)
  if not cloneName then
    cloneName = Transmog:newClonedItem(itemName)
  end

  sendServerCommand(source, "Transmog", "GivePlayerTransmogClone", {
    cloneName = cloneName,
    sourceItemName = itemName
  });
end

Commands.Transmog.ResetModData = function(source, args)
  ModData.add("TransmogData", {})
  ModData.transmit("TransmogData")

  ModData.remove("TransmogClones", {})
  ModData.remove("TransmogSources", {})
end

local onClientCommand = function(module, command, source, args)
  if Commands[module] and Commands[module][command] then
    Commands[module][command](source, args);
  end
end

if isServer() then
  Events.OnClientCommand.Add(onClientCommand);
end
