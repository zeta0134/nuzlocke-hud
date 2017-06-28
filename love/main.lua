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

-- setup a DEBUG party (todo: not this)
pokemon[1] = Pokemon.new(1, "Steven")
party[1].pokemon = 1
party[1].status  = "alive"

pokemon[2] = Pokemon.new(6, "Garnet")
party[2].pokemon = 2
party[2].status  = "alive"

pokemon[3] = Pokemon.new(7)
party[3].pokemon = 3
party[3].status  = "alive"

local main_canvas

function love.load()
  local rby_font = love.graphics.newImageFont("images/rby_font.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz():;[]?!0123456789./,@#$= ", 0)
  love.graphics.setFont(rby_font)
  love.window.setMode(8 * 19 * 2, 32 * 7 * 2)
  love.graphics.setDefaultFilter("nearest", "nearest")
  main_canvas = love.graphics.newCanvas()
end

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

    love.graphics.setCanvas()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(main_canvas, 0, 0, 0, 2, 2)
end

function love.mousereleased()
  local mx, my = love.mouse.getPosition()
  mx = mx / 2
  my = my / 2

  -- todo: handle drag / drop here
  party_clicked(mx, my)
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
