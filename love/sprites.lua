local sprites = {}

sprites.library = {}

local function load_sprite(name)
  local path = "images/" .. name .. ".png"
  if love.filesystem.exists(path) then
    sprites.library[name] = love.graphics.newImage(path)
  end
end
load_sprite("error")

sprites.draw = function(name, x, y, width, height)
  -- check to see if this sprite is loaded, and
  -- load it on the fly if it's not
  if sprites.library[name] == nil then
    load_sprite(name)
  end
  local sprite = sprites.library[name] or sprites.library["error"]
  local radians = 0
  local sx = width / sprite:getWidth()
  local xy = height / sprite:getHeight()
  love.graphics.draw(sprite, x, y, radians, sx, sy)
end

return sprites
