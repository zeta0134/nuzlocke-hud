local csv = require("csv")
local editor = require("editor")
local palette = require("palette")
local pokedex = require("pokedex")
local pokemon = require("pokemon")

local screen_width = 38 * 8

local party = {}
local column_width = screen_width / 2
local row_height = 32
for x = 0, 1 do
  for y = 0, 2 do
    local i = (x * 3 + y) + 1
    party[i] = pokemon.Slot.new()
    party[i].x = x * column_width + 8
    party[i].y = row_height * y + 16
  end
end

local active_layout = party

function draw_party(mx, my)
  for i = 1, 6 do
    local slot = party[i]
    pokemon.draw_slot(slot, slot.x, slot.y, mx - slot.x, my - slot.y)
  end
end

function party_clicked(mx, my)
  for i = 1, 6 do
    local slot = party[i]
    if mx > slot.x and mx < slot.x + slot.width and
       my > slot.y and my < slot.y + slot.height then
      pokemon.slot_clicked(slot, mx - slot.x, my - slot.y)
    end
  end
end

local main_canvas
local drag_ghost

function love.load()
  local rby_font = love.graphics.newImageFont("images/rby_font.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz():;[]?!0123456789./,@#$= ", 0)
  love.graphics.setFont(rby_font)
  love.window.setMode(8 * 38 * 2, 32 * 4 * 2)
  love.graphics.setDefaultFilter("nearest", "nearest")
  main_canvas = love.graphics.newCanvas()
  drag_ghost = love.graphics.newCanvas()
end

local mouse_start = {x=0, y=0}
local mouse_current = {x=0, y=0}
local mouse_pressed = false
local drag_slot = nil
local drag_active = false
local drag_offset = {x=0, y=0}

function love.draw()
    local mx, my = love.mouse.getPosition()
    mx = mx / 2
    my = my / 2

    love.graphics.setCanvas(main_canvas)
    love.graphics.clear(unpack(palette.gb[3]))
    love.graphics.setColor(unpack(palette.gb[0]))
    love.graphics.print("================ PARTY ===============", 0, 0)
    draw_party(mx, my)
    if editor.active then
      editor.draw()
    end

    if drag_active then
      -- Draw a ghost of the thing we're dragging
      love.graphics.setCanvas(drag_ghost)
      love.graphics.clear(255, 255, 255, 0)
      -- a drop shadow, and a background rectangle
      love.graphics.setColor(0, 0, 0, 128)
      love.graphics.rectangle("fill", 2, 2, drag_slot.width, drag_slot.height)
      love.graphics.setColor(unpack(palette.gb[3]))
      love.graphics.rectangle("fill", 0, 0, drag_slot.width, drag_slot.height)

      pokemon.draw_slot(drag_slot, 0, 0, -1, -1)
      love.graphics.setCanvas(main_canvas)
      love.graphics.setColor(255, 255, 255)
      local dx = math.floor(mouse_current.x - drag_offset.x)
      local dy = math.floor(mouse_current.y - drag_offset.y)
      love.graphics.draw(drag_ghost, dx, dy)
      love.graphics.setColor(255, 255, 255)
    end

    love.graphics.setCanvas()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(main_canvas, 0, 0, 0, 2, 2)
end

function love.mousepressed(mx, my)
  mouse_start.x = mx / 2
  mouse_start.y = my / 2

  drag_slot = nil
  for i = 1, #active_layout do
    if pokemon.point_inside_slot(active_layout[i], mouse_start.x, mouse_start.y) and active_layout[i].status ~= "empty" then
      drag_slot = active_layout[i]
      drag_offset.x = mouse_start.x - drag_slot.x
      drag_offset.y = mouse_start.y - drag_slot.y
    end
  end

  mouse_pressed = true
end

local function distance(x1, y1, x2, y2)
  dx = x2 - x1
  dy = y2 - y1
  return math.sqrt(dx * dx + dy * dy)
end

function love.mousemoved(mx, my)
  mouse_current.x = mx / 2
  mouse_current.y = my / 2

  if mouse_pressed then
    -- Implement a threshold for dragging, so clicks aren't recognized as drags
    -- unless we actually move the mouse a little bit.
    if drag_slot ~= nil and distance(mouse_current.x, mouse_current.y, mouse_start.x, mouse_start.y) > 5 then
      drag_active = true
    end
  end
end

function love.mousereleased(mx, my)
  mx = mx / 2
  my = my / 2

  -- todo: handle drag / drop here
  if drag_active then
    for i = 1, #active_layout do
      if pokemon.point_inside_slot(active_layout[i], mx, my) then
        pokemon.move_slot(drag_slot, active_layout[i])
      end
    end
  else
    party_clicked(mx, my)
  end

  drag_active = false
  drag_slot = nil
  mouse_pressed = false
end

function love.textinput(text)
  if editor.active then
    editor.handle_char(text)
  end
end

function love.keypressed(key)
  if editor.active then
    editor.handle_key(key)
  else
    if key == "s" then
      love.filesystem.write("pokedex.csv", csv.encode(pokedex))
      love.filesystem.write("pokemon.csv", csv.encode(pokemon.collection))
      love.filesystem.write("party.csv", csv.encode(party))
    end
  end
end
