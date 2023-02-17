local TransmogV3 = require('TransmogV3')

local function onReceiveGlobalModData(module, packet)
  print('TransmogV3:onReceiveGlobalModData: '..module)
  if module ~= "TransmogModData" or not packet then
    return
  end

  ModData.add("TransmogModData", packet)

  TransmogV3.applyTransmogFromModData()
end

local function requestTransmogModData()
  print('TransmogV3:requestTransmogModData')
  ModData.request("TransmogModData")
end

return {
  requestTransmogModData = requestTransmogModData,
  onReceiveGlobalModData = onReceiveGlobalModData
}
