require('TransmogClient')

local TransmogContextMenu = function(player, context, items)
  local testItem = nil
  local clothing = nil
  for _, v in ipairs(items) do
    testItem = v;
    if not instanceof(v, "InventoryItem") then
      testItem = v.items[1];
    end
    if CanBeTransmogged(testItem) then
      clothing = testItem;
    end
  end

  if tostring(#items) == "1" and clothing then
    local transmog = context:addOption("Transmog", clothing, TransmogItem);
  end

  return context
end


Events.OnFillInventoryObjectContextMenu.Add(TransmogContextMenu);