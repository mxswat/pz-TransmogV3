local Transmog = {}

function Transmog:newClonedItem(sourceItemName)
  local TransmogData = ModData.getOrCreate("TransmogData");
  local TransmogClones = ModData.getOrCreate("TransmogClones");
  local availableId = #TransmogClones + 1

  print("New Transmog clone with id: " .. availableId)

  if availableId > 500 then
    print('Transmog Error: limit of items reached (Max 500)')
    return
  end

  local cloneId = 'TransmogV3.TransmogClone_' .. availableId

  TransmogData[cloneId] = {
    source = sourceItemName,
    appearance = sourceItemName,
  }
  TransmogClones[availableId] = sourceItemName

  ModData.add("TransmogData", TransmogData)

  ModData.transmit("TransmogData")

  return cloneId
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

  print("Player " .. source:getUsername() .. "[" .. sourceId .. "] requested transmog for: " .. itemName)

  if Transmog:itemHasClone(itemName) then
    return -- it's already transmogged
  end

  local cloneId = Transmog:newClonedItem(itemName)

  sendServerCommand(source, "Transmog", "GivePlayerTransmogClone", {
    cloneId = cloneId,
    sourceItemName = itemName
  });
end

Commands.Transmog.ResetModData = function(source, args) --- Event Triggered from ../client/Transmog.lua#L21-L23.
  ModData.add("TransmogData", {})
  ModData.transmit("TransmogData")

  ModData.add("TransmogClones", {})
end

local onClientCommand = function(module, command, source, args) -- Events Constructor.
  if Commands[module] and Commands[module][command] then
    Commands[module][command](source, args);
  end
end

if isServer() then
  Events.OnClientCommand.Add(onClientCommand);
end
