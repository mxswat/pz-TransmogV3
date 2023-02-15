local joinArraylist = function(arrayList)
  local value = ""
  local size = arrayList:size() - 1
  for i = 0, size do
    local type = tostring(arrayList:get(i))
    value = value .. type .. (size < i and ";" or "")
  end
  return value
end

return {
  joinArraylist = joinArraylist
}