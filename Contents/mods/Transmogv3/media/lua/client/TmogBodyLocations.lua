function UpdateBodyLocations()
  print('-------START UpdateBodyLocations--------')
  local group = BodyLocations.getGroup("Human")
  group:getOrCreateLocation("Transmog_OutfitBagOne")
  group:getOrCreateLocation("Transmog_OutfitBagTwo")
  group:getOrCreateLocation("Transmog_Hidden")
  group:getOrCreateLocation("Transmog_Cosmetic")
end

Events.OnGameBoot.Add(UpdateBodyLocations)

-- local manager = ScriptManager.instance

-- function TransmogTweaks()
--   -- Changes to icons
--   manager:getItem("TransmogV3.TransmogHide_1"):DoParam("Icon = JacketBlack");
--   print('TransmogTweaks - Done')
-- end

-- function TransmogTweaksPost()
--   -- Changes to icons
--   manager:getItem("TransmogV3.TransmogHide_1"):DoParam("Icon = ShirtCamoGreen");
--   manager:getItem("TransmogV3.TransmogHide_1"):DoParam("Weight = 2");
--   print('TransmogTweaksPost - Done')
--   getPlayer():getInventory():AddItem("TransmogV3.TransmogHide_1");
-- end

-- TransmogTweaks()
