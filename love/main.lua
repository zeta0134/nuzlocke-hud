local gb_palette = {}
gb_palette[0] = {0,   0,   0  }
gb_palette[1] = {128, 128, 128}
gb_palette[2] = {192, 192, 192}
gb_palette[3] = {248, 248, 248}

local sprites = {}
local function load_sprite(name)
  local path = "images/" .. name .. ".png"
  if love.filesystem.exists(path) then
    sprites[name] = love.graphics.newImage(path)
  end
end
load_sprite("error")

local function draw_sprite(name, x, y, width, height)
  -- check to see if this sprite is loaded, and
  -- load it on the fly if it's not
  if sprites[name] == nil then
    load_sprite(name)
  end
  local sprite = sprites[name] or sprites["error"]
  local radians = 0
  local sx = width / sprite:getWidth()
  local xy = height / sprite:getHeight()
  love.graphics.draw(sprite, x, y, radians, sx, sy)
end

local pokedex = {}
pokedex[000] = {name="MissingNo.", type1=nil,     type2=nil,      rby_icon=nil}
pokedex[001] = {name="Bulbasaur",  type1="grass", type2="poison", rby_icon="plant"}
pokedex[002] = {name="Ivysaur",    type1="grass", type2="poison", rby_icon="plant"}
pokedex[003] = {name="Venusaur",   type1="grass", type2="poison", rby_icon="plant"}
pokedex[004] = {name="Charmander", type1="fire",  type2=nil,      rby_icon="biped"}
pokedex[005] = {name="Charmeleon", type1="fire",  type2=nil,      rby_icon="biped"}
pokedex[006] = {name="Charizard",  type1="fire",  type2="flying", rby_icon="biped"}
pokedex[007] = {name="Squirtle",   type1="water", type2=nil,      rby_icon="water"}
pokedex[008] = {name="Wartortle",  type1="water", type2=nil,      rby_icon="water"}
pokedex[009] = {name="Blastoise",  type1="water", type2=nil,      rby_icon="water"}

local Pokemon = {
  new=function(species, nickname)
    local pokemon = {}
    pokemon.species = species or 0
    pokemon.nickname = nickname
    return pokemon
  end
}

local PokemonSlot = {
  new=function()
    local slot = {x=0,y=0,pokemon=nil,status="empty"}
    return slot
  end
}

local pokemon = {}

local function draw_slot(slot, x, y)
  if slot.status == "empty" then
    -- for RBY, do absolutely nothing
    return
  end
  if slot.status == "alive" then
    pokedex_data = pokedex[slot.pokemon.species] or pokedex[0]
    if pokedex_data.rby_icon then
      local icon_path = "rby/" .. pokedex_data.rby_icon
      love.graphics.setColor(unpack(gb_palette[2]))
      love.graphics.circle("fill", x + 12, y + 12, 11)
      love.graphics.setColor(255, 255, 255)
      draw_sprite(icon_path, x + 4, y + 4, 16, 16)
    end

    if slot.pokemon.nickname then
      love.graphics.setColor(unpack(gb_palette[0]))
      love.graphics.print(slot.pokemon.nickname, x + 32, y + 0)
      love.graphics.setColor(unpack(gb_palette[1]))
      love.graphics.print(string.upper(pokedex_data.name), x + 32, y + 8)
    else
      love.graphics.setColor(unpack(gb_palette[0]))
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
    love.graphics.print(types, x + 32, y + 16)
  end
end

local function click_slot(slot, mx, my)

end

local party = {}
for i = 1, 6 do
  party[i] = PokemonSlot.new()
end

function draw_party()
  for i = 1, 6 do
    draw_slot(party[i], 8, 32 * (i - 1) + 16)
  end
end

-- setup a DEBUG party (todo: not this)
party[1].pokemon = Pokemon.new(1, "Harry")
party[1].status  = "alive"

party[2].pokemon = Pokemon.new(4, "Fred")
party[2].status  = "alive"

party[3].pokemon = Pokemon.new(7)
party[3].status  = "alive"

function love.load()
  local rby_font = love.graphics.newImageFont("images/rby_font.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz():;[]?!0123456789./,@#$= ", 0)
  love.graphics.setFont(rby_font)
  love.window.setMode(8 * 19, 32 * 7)
end

function love.draw()
    love.graphics.clear(unpack(gb_palette[3]))
    love.graphics.setColor(unpack(gb_palette[0]))
    love.graphics.print("====== PARTY ======")
    draw_party()
end
