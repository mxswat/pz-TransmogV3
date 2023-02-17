local TransmogV3 = require('TransmogV3')

if isClient() then
  local TransmogClient = require('TransmogClient')
  Events.OnLoad.Add(TransmogV3.patchAllClothing);
  Events.OnGameStart.Add(TransmogClient.requestTransmogModData);
  Events.OnReceiveGlobalModData.Add(TransmogClient.onReceiveGlobalModData);
end


if isServer() then
  local TransmogServer = require('TransmogServer')
  Events.OnServerStarted.Add(TransmogServer.generateTransmogModData)
end