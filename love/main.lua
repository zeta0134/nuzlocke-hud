local pokedex = require("pokedex")
local sprites = require("sprites")

local gb_palette = {}
gb_palette[0] = {0,   0,   0  }
gb_palette[1] = {96,  96,  96 }
gb_palette[2] = {192, 192, 192}
gb_palette[3] = {248, 248, 248}

local Pokemon = {
  new=function(species, nickname)
    local pokemon = {}
    pokemon.species = species or 0
    pokemon.nickname = nickname
    return pokemon
  end
}

local pokemon = {}
pokemon[0] = Pokemon.new(0)

local PokemonSlot = {
  new=function()
    local slot = {x=0,y=0,width=128,height=24,pokemon=nil,status="empty"}
    return slot
  end
}

local function point_inside_slot(slot, x, y)
  x = x - slot.x
  y = y - slot.y
  return x > 0 and x < slot.width and y > 0 and y < slot.height
end

local function move_slot(source, destination)
  local temp_pokemon = destination.pokemon
  local temp_status = destination.status

  destination.pokemon = source.pokemon
  destination.status = source.status

  if temp_status == "empty" then
    source.status = "empty"
    source.pokemon = nil
  else
    source.status = temp_status
    source.pokemon = temp_pokemon
  end
end

local function draw_slot(slot, x, y, mx, my)

  if slot.status == "empty" then
    if mx > 0 and mx < slot.width and my > 0 and my < slot.height then
      love.graphics.setColor(unpack(gb_palette[2]))
      love.graphics.rectangle("fill", x, y, slot.width, slot.height)
      love.graphics.setColor(unpack(gb_palette[0]))
      love.graphics.print("Add", x + (slot.width / 2) - (3 * 4), y + 8)
    end
  end

  if slot.status == "alive" then
    local pokemon = pokemon[slot.pokemon] or pokemon[0]
    local pokedex_data = pokedex[pokemon.species] or pokedex[0]
    if pokedex_data.rby_icon then
      local icon_path = "rby/" .. pokedex_data.rby_icon
      love.graphics.setColor(unpack(gb_palette[2]))
      love.graphics.circle("fill", x + 12, y + 12, 11)
      love.graphics.setColor(255, 255, 255)
      sprites.draw(icon_path, x + 4, y + 4, 16, 16)
    end

    if pokemon.nickname then
      love.graphics.setColor(unpack(gb_palette[1]))
      love.graphics.print(pokemon.nickname, x + 32, y + 0)
      love.graphics.setColor(unpack(gb_palette[2]))
      love.graphics.print(string.upper(pokedex_data.name), x + 32, y + 16)
    else
      love.graphics.setColor(unpack(gb_palette[1]))
      love.graphics.print(string.upper(pokedex_data.name), x + 32, y + 0)
    end

    local types = ""
    if pokedex_data.type1 then
      types = types .. string.upper(pokedex_data.type1)
    end
    if pokedex_data.type2 then
      types = types .. "/" .. string.upper(pokedex_data.type2)
    end
    love.graphics.setColor(unpack(gb_palette[0]))
    love.graphics.print(types, x + 32, y + 8)
  end
end

local editor = {}
editor.active = false
editor.index = 0
editor.field = ""
editor.x = 0
editor.y = 0
editor.value = ""
editor.numeric = false
editor.max_length = 10

local function save_edit()
  if editor.numeric then
    pokemon[editor.index][editor.field] = tonumber(editor.value)
  else
    if editor.value == "" then
      pokemon[editor.index][editor.field] = nil
    else
      pokemon[editor.index][editor.field] = editor.value
    end
  end
  editor.active = false
end

local function abandon_edit()
  editor.active = false
end

local function begin_edit(index, fieldname, x, y, max_length, numeric)
  if editor.active then
    save_edit()
  end
  editor.active = true
  editor.index = index
  editor.field = fieldname
  editor.x = x
  editor.y = y
  editor.max_length = max_length
  editor.numeric = numeric
  editor.value = tostring(pokemon[editor.index][editor.field] or "")
end

local function draw_editor()
  love.graphics.setColor(unpack(gb_palette[2]))
  love.graphics.rectangle("fill", editor.x, editor.y, 12 * 8, 8)
  love.graphics.setColor(unpack(gb_palette[0]))
  love.graphics.print(editor.value, editor.x, editor.y)
  love.graphics.setColor(unpack(gb_palette[0]))
  love.graphics.rectangle("fill", editor.x + (8 * #editor.value) + 1, editor.y, 1, 8)
end

local function editor_handle_char(char)
  if editor.numeric then
    if char < "0" or char > "9" then
      return
    end
  end

  if #editor.value < editor.max_length then
    editor.value = editor.value .. char
  end
end

local function editor_handle_key(key)
  if key == "backspace" and #editor.value > 0 then
    editor.value = string.sub(editor.value, 1, #editor.value - 1)
  end
  if key == "return" then
    save_edit()
  end
  if key == "escape" then
    abandon_edit()
  end
end

local function slot_clicked(slot, mx, my)
  if slot.status == "empty" then
    if slot.pokemon == nil then
      table.insert(pokemon, Pokemon.new(0))
      slot.pokemon = #pokemon
    end
    slot.status = "alive"
    return
  end

  if slot.status == "alive" then
    if mx > 32 and mx < slot.width and
       my > 0 and my < 8 then
      begin_edit(slot.pokemon, "nickname", slot.x + 32, slot.y + 0, 10, false)
    end
  end

  if mx > 32 and mx < slot.width and
     my > 16 and my < 24 then
    begin_edit(slot.pokemon, "species", slot.x + 32, slot.y + 16, 3, true)
  end
end

local party = {}
for i = 1, 6 do
  party[i] = PokemonSlot.new()
  party[i].x = 8
  party[i].y = 32 * (i - 1) + 16
end

local active_layout = party

function draw_party(mx, my)
  for i = 1, 6 do
    local slot = party[i]
    draw_slot(slot, slot.x, slot.y, mx - slot.x, my - slot.y)
  end
end

function party_clicked(mx, my)
  for i = 1, 6 do
    local slot = party[i]
    if mx > slot.x and mx < slot.x + slot.width and
       my > slot.y and my < slot.y + slot.height then
      slot_clicked(slot, mx - slot.x, my - slot.y)
    end
  end
end

local main_canvas
local drag_ghost

function love.load()
  local rby_font = love.graphics.newImageFont("images/rby_font.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz():;[]?!0123456789./,@#$= ", 0)
  love.graphics.setFont(rby_font)
  love.window.setMode(8 * 19 * 2, 32 * 7 * 2)
  love.graphics.setDefaultFilter("nearest", "nearest")
  main_canvas = love.graphics.newCanvas()
  drag_ghost = love.graphics.newCanvas()

  print("STUFF?????")
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
    love.graphics.clear(unpack(gb_palette[3]))
    love.graphics.setColor(unpack(gb_palette[0]))
    love.graphics.print("====== PARTY ======", 0, 0)
    draw_party(mx, my)
    if editor.active then
      draw_editor()
    end

    if drag_active then
      -- Draw a ghost of the thing we're dragging
      love.graphics.setCanvas(drag_ghost)
      love.graphics.clear(255, 255, 255, 0)
      -- a drop shadow, and a background rectangle
      love.graphics.setColor(0, 0, 0, 128)
      love.graphics.rectangle("fill", 2, 2, drag_slot.width, drag_slot.height)
      love.graphics.setColor(unpack(gb_palette[3]))
      love.graphics.rectangle("fill", 0, 0, drag_slot.width, drag_slot.height)

      draw_slot(drag_slot, 0, 0, -1, -1)
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
    if point_inside_slot(active_layout[i], mouse_start.x, mouse_start.y) and active_layout[i].status ~= "empty" then
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
      if point_inside_slot(active_layout[i], mx, my) then
        move_slot(drag_slot, active_layout[i])
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
    editor_handle_char(text)
  end
end

function love.keypressed(key)
  if editor.active then
    editor_handle_key(key)
  end
end
