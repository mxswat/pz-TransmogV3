local group = BodyLocations.getGroup("Human")
group:getOrCreateLocation("Transmog_OutfitBagOne")
group:getOrCreateLocation("Transmog_OutfitBagTwo")

for i = 1, 5000, 1 do
  group:getOrCreateLocation("Transmog_Location_" .. i)
end
