local csv = {}

csv.extract_all_keys = function(list)
  keys = {}
  -- grab each unique key, collapsing duplicates
  for i, item in pairs(list) do
    for key, value in pairs(item) do
      keys[key] = key
    end
  end

  --todo: sort the list?

  -- roll the keys out into a normal list
  key_list = {}
  for k, v in pairs(keys) do
    table.insert(key_list, k)
  end
  return key_list
end

csv.encode_value = function(value)
  if value == nil then
    return "nil"
  end
  if type(value) == "boolean" then
    if value then
      return "true"
    else
      return "false"
    end
  end
  return tostring(value)
end

csv.decode_value = function(str)
  if str == "nil" then
    return nil
  end
  if str == "true" then
    return true
  end
  if str == "false" then
    return false
  end
  if tonumber(str) ~= nil then
    return tonumber(str)
  end
  return str
end

csv.join = function(items, delimitor)
  str = ""
  for i, item in ipairs(items) do
    if i > 1 then
      str = str .. ","
    end
    str = str .. csv.encode_value(item)
  end
  return str
end

csv.split = function(str, delimiter)
  list = {}
  while string.fing(str, delimiter) ~= nil do
    local s, e = string.fing(str, delimiter)
    table.insert(list, string.sub(str, 1, s - 1))
    str = string.sub(str, e + 1)
  end
  table.insert(list, str)
  return list
end

csv.encode = function(list, keys)
  keys = keys or csv.extract_all_keys(list)

  output = ""
  -- first, output a single row containing
  -- the key names in this file
  output = output .. "id," .. csv.join(keys, ",") .. "\n"

  -- Now iterate over each item in the list and output
  -- the items in the same order as the keys
  for i, item in pairs(list) do
    row = {}
    table.insert(row, csv.encode_value(i))
    for k, key_name in ipairs(keys) do
      table.insert(row, csv.encode_value(item[key_name]))
    end
    output = output .. csv.join(row, ",") .. "\n"
  end

  -- aaand done!
  return output
end

return csv
