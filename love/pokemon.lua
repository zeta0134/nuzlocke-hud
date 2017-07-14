local editor = require("editor")
local palette = require("palette")
local pokedex = require("pokedex")
local sprites = require("sprites")

local pokemon  = {}

local Pokemon = {
  new=function(species, nickname)
    local pokemon = {}
    pokemon.species = species or 0
    pokemon.nickname = nickname
    return pokemon
  end
}

pokemon.collection = {}
pokemon.collection[0] = Pokemon.new(0)

pokemon.Slot = {
  new=function()
    local slot = {x=0,y=0,width=128,height=24,pokemon=nil,status="empty"}
    return slot
  end
}

pokemon.point_inside_slot = function(slot, x, y)
  x = x - slot.x
  y = y - slot.y
  return x > 0 and x < slot.width and y > 0 and y < slot.height
end

pokemon.move_slot = function(source, destination)
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

pokemon.draw_slot = function(slot, x, y, mx, my)

  if slot.status == "empty" then
    if mx > 0 and mx < slot.width and my > 0 and my < slot.height then
      love.graphics.setColor(unpack(palette.gb[2]))
      love.graphics.rectangle("fill", x, y, slot.width, slot.height)
      love.graphics.setColor(unpack(palette.gb[0]))
      love.graphics.print("Add", x + (slot.width / 2) - (3 * 4), y + 8)
    end
  end

  if slot.status == "missed" then
    love.graphics.setColor(unpack(palette.gb[2]))
    love.graphics.circle("fill", x + 12, y + 12, 11)
    love.graphics.setColor(255, 255, 255)
    local icon_path = "rby/missed"
    sprites.draw(icon_path, x + 4, y + 4, 16, 16)
    love.graphics.setColor(unpack(palette.gb[2]))
    love.graphics.print("Missed...", x + 32, y + 8)
  end

  if slot.status == "alive" or slot.status == "dead" then
    local pokemon = pokemon.collection[slot.pokemon] or pokemon.collection[0]
    local pokedex_data = pokedex[pokemon.species] or pokedex[0]
    love.graphics.setColor(unpack(palette.gb[2]))
    love.graphics.circle("fill", x + 12, y + 12, 11)
    love.graphics.setColor(255, 255, 255)
    if slot.status == "dead" then
      local icon_path = "rby/dead"
      sprites.draw(icon_path, x + 4, y + 4, 16, 16)
    else
      if pokedex_data.rby_icon then
        local icon_path = "rby/" .. pokedex_data.rby_icon
        sprites.draw(icon_path, x + 4, y + 4, 16, 16)
      end
    end

    if pokemon.nickname then
      love.graphics.setColor(unpack(palette.gb[1]))
      love.graphics.print(pokemon.nickname, x + 32, y + 0)
      love.graphics.setColor(unpack(palette.gb[1]))
      love.graphics.print(string.upper(pokedex_data.name), x + 32, y + 16)
    else
      love.graphics.setColor(unpack(palette.gb[1]))
      love.graphics.print(string.upper(pokedex_data.name), x + 32, y + 0)
    end

    local types = ""
    if pokedex_data.type1 then
      types = types .. string.upper(pokedex_data.type1)
    end
    if pokedex_data.type2 then
      types = types .. "/" .. string.upper(pokedex_data.type2)
    end
    love.graphics.setColor(unpack(palette.gb[0]))
    love.graphics.print(types, x + 32, y + 8)
  end
end

pokemon.slot_clicked = function(slot, mx, my)
  if slot.status == "empty" then
    if slot.pokemon == nil then
      table.insert(pokemon.collection, Pokemon.new(0))
      slot.pokemon = #pokemon.collection
    end
    slot.status = "alive"
    return
  end

  if slot.status == "alive" then
    if mx > 32 and mx < slot.width and
       my > 0 and my < 8 then
      editor.begin(pokemon.collection, slot.pokemon, "nickname", slot.x + 32, slot.y + 0, 10, false)
    end
  end

  if mx > 32 and mx < slot.width and
     my > 16 and my < 24 then
    editor.begin(pokemon.collection, slot.pokemon, "species", slot.x + 32, slot.y + 16, 3, true)
  end

  -- If we clicked on the portrait, cycle through the available statuses
  if slot.status ~= "empty" then
    if mx > 0 and mx < 32 then
      if slot.status == "alive" then
        slot.status = "dead"
      elseif slot.status == "dead" then
        slot.status = "missed"
      elseif slot.status == "missed" then
        slot.status = "empty"
      end
    end
  end
end

return pokemon
