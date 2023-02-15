local Commands = {};
Commands.Transmog = {};

Commands.Transmog.RequestTransmog = function(source, args) --- Event Triggered from ../client/Transmog.lua#L21-L23.
  local sourceId = source:getOnlineID(); -- Player id who triggered the event.
  local itemName = args.itemName;

  print("Player "..source:getUsername().."[".. sourceId .."] requested transmog for: ".. itemName)

  local TransmogData = ModData.getOrCreate("TransmogData");
  if TransmogData[itemName] then
    return -- it's already transmogged
  end
  -- Not transmogged - Find first available TransmogV3.TransmogClone_1
  local TransmogClones = ModData.getOrCreate("TransmogClones");
  print('#TransmogClones = '..#TransmogClones)
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
