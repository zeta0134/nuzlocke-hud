local csv = {}

csv.extract_all_keys = function(list)
  local keys = {}
  -- grab each unique key, collapsing duplicates
  for i, item in pairs(list) do
    for key, value in pairs(item) do
      keys[key] = key
    end
  end

  --todo: sort the list?

  -- roll the keys out into a normal list
  local key_list = {}
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
  local str = ""
  for i, item in ipairs(items) do
    if i > 1 then
      str = str .. ","
    end
    str = str .. csv.encode_value(item)
  end
  return str
end

csv.split = function(str, delimiter)
  local list = {}
  while string.find(str, delimiter) ~= nil do
    local s, e = string.find(str, delimiter)
    table.insert(list, string.sub(str, 1, s - 1))
    str = string.sub(str, e + 1)
  end
  table.insert(list, str)
  return list
end

csv.encode = function(list, keys)
  keys = keys or csv.extract_all_keys(list)

  local output = ""
  -- first, output a single row containing
  -- the key names in this file
  output = output .. "id," .. csv.join(keys, ",") .. "\n"

  -- Now iterate over each item in the list and output
  -- the items in the same order as the keys
  for i, item in pairs(list) do
    local row = {}
    table.insert(row, csv.encode_value(i))
    for k, key_name in ipairs(keys) do
      table.insert(row, csv.encode_value(item[key_name]))
    end
    output = output .. csv.join(row, ",") .. "\n"
  end

  -- aaand done!
  return output
end

csv.decode = function(str)
  -- please note: this is tailor-made for this
  -- project, and is NOT at ALL a complete implementation
  -- of the CSV format. It makes assumptions based
  -- on how it expects files to have been saved,
  -- and will very likely break with arbitrary
  -- data.
  local lines = csv.split(str, "\n")

  -- the first line encodes our key names, so
  -- pull those out
  local key_list = csv.split(lines[1], ",")
  local output = {}
  for i = 2, #lines do
    local row = {}
    local column_list = csv.split(lines[i], ",")
    for index, key_name in ipairs(key_list) do
      row[key_name] = csv.decode_value(column_list[index])
    end
    if row.id then
      local id = row.id
      row.id = nil
      output[id] = row
    else
      table.insert(output, row)
    end
  end
  return output
end

return csv
