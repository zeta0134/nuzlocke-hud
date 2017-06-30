local palette = require("palette")

local editor = {}

editor.active = false
editor.index = 0
editor.field = ""
editor.x = 0
editor.y = 0
editor.value = ""
editor.numeric = false
editor.max_length = 10
editor.table = nil

editor.save = function()
  if editor.numeric then
    editor.table[editor.index][editor.field] = tonumber(editor.value)
  else
    if editor.value == "" then
      editor.table[editor.index][editor.field] = nil
    else
      editor.table[editor.index][editor.field] = editor.value
    end
  end
  editor.active = false
end

editor.abandon = function()
  editor.active = false
end

editor.begin = function(t, index, fieldname, x, y, max_length, numeric)
  if editor.active then
    editor.save()
  end
  editor.active = true
  editor.table = t
  editor.index = index
  editor.field = fieldname
  editor.x = x
  editor.y = y
  editor.max_length = max_length
  editor.numeric = numeric
  editor.value = tostring(editor.table[editor.index][editor.field] or "")
end

editor.draw = function()
  love.graphics.setColor(unpack(palette.gb[2]))
  love.graphics.rectangle("fill", editor.x, editor.y, 12 * 8, 8)
  love.graphics.setColor(unpack(palette.gb[0]))
  love.graphics.print(editor.value, editor.x, editor.y)
  love.graphics.setColor(unpack(palette.gb[0]))
  love.graphics.rectangle("fill", editor.x + (8 * #editor.value) + 1, editor.y, 1, 8)
end

editor.handle_char = function(char)
  if editor.numeric then
    if char < "0" or char > "9" then
      return
    end
  end

  if #editor.value < editor.max_length then
    editor.value = editor.value .. char
  end
end

editor.handle_key = function(key)
  if key == "backspace" and #editor.value > 0 then
    editor.value = string.sub(editor.value, 1, #editor.value - 1)
  end
  if key == "return" then
    editor.save()
  end
  if key == "escape" then
    editor.abandon()
  end
end

return editor
