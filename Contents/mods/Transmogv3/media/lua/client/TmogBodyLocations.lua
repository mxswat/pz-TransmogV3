function UpdateBodyLocations()
  print('-------START UpdateBodyLocations--------')
  local group = BodyLocations.getGroup("Human")
  group:getOrCreateLocation("Transmog_OutfitBagOne")
  group:getOrCreateLocation("Transmog_OutfitBagTwo")
  group:getOrCreateLocation("Transmog_Hidden")
  group:getOrCreateLocation("Transmog_Cosmetic")
end

Events.OnGameBoot.Add(UpdateBodyLocations)
