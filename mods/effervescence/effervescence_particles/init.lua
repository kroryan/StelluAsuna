-- Extract particle graphics from a node texture
local function extract_tile(tiles,color)
  if not tiles then
    return "blank.png"
  end

  if not color and tiles.color then
    color = tiles.color
  end

  if type(tiles[1]) == "string" then
    return tiles[1], color
  elseif type(tiles[1]) == "table" then
    return tiles[1].name or tiles[1].image, color
  else
    return "blank.png"
  end
end

local function extract_particles(tiles,color,coords)
  tiles, color = extract_tile(tiles,color)
  return tiles .. "^[resize:16x16^[sheet:8x8:" .. (coords or (math.random(0,7) .. "," .. math.random(0,7))) .. (color and ("^[multiply:" .. color) or "")
end

-- Get texture blend value
local blend_method = core.features.particle_blend_clip and "clip" or "alpha"

-- Dusty particles (sand, dry grass, etc.)
effervescence.register_environmental_particles({
  name = "effervescence:dusty",
  check = function(self, pos)
    return (pos.y < 0 or pos.y > 6) and core.get_node(pos:offset(0,1,0)).name == "air"
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local does_apply = (groups.stone and groups.stone > 0) or (groups.sand and groups.sand > 0) or (groups.everness_sand and groups.everness_sand > 0) or node:find("dry_") or node:find("clay") or node:find("gravel") or node:find("litter$") or node:find("podzol")
    return does_apply and { "effervescence:floors" }
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(56,64),
      time = 5,
      pos = {
        min = pos:add(vector.new(-6,0.575,-6)),
        max = pos:add(vector.new(6,1,6)),
      },
      minsize = 0.2,
      maxsize = 0.275,
      minvel = { x = -1, y = -0.02, z = -1 },
      maxvel = { x = 1, y = 0.02, z = 1 },
      minexptime = 6,
      maxexptime = 8,
      minacc = {x = -1.5, y = 0, z = -1.5},
      maxacc = {x = 1.5, y = 0.05, z = 1.5},
      texture = {
        name = extract_particles(ndef.tiles,ndef.color),
        blend = blend_method,
      },
      collisiondetection = false,
      vertical = false,
    }
  end,
})

-- Crumbly particles (falling bits of stone, dirt, gravel, etc.)
effervescence.register_environmental_particles({
  name = "effervescence:crumbly",
  check = function(self, pos)
    return core.get_node(pos:offset(0,-1,0)).name == "air"
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local does_apply = (groups.stone and groups.stone > 0) or (groups.crumbly and groups.crumbly > 0) or (groups.soil and groups.soil > 0) or node:find("gravel") or node:find("ore") or node:find("moss") or node:find(":dirt_")
    return does_apply and { "effervescence:ceilings" }
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = 6,
      time = 0.5,
      pos = {
        min = pos:add(vector.new(-0.45,-0.75,-0.45)),
        max = pos:add(vector.new(0.45,-0.9,0.45)),
      },
      minvel = {x = 0, y = -5, z = 0},
      maxvel = {x = -0.1, y = -7, z = -0.1},
      minacc = {x = -0.1, y = -2, z = -0.1},
      maxacc = {x = 0.1, y = -3, z = 0.1},
      minexptime = 0.25,
      maxexptime = 1,
      minsize = 0.25,
      maxsize = 1.25,
      glow = ndef.glow or ndef.light_source,
      texture = {
        name = extract_particles(ndef.tiles,ndef.color),
        blend = blend_method,
      },
      collisiondetection = false,
      vertical = false,
    }
  end,
})

-- Bustling particles (bit of grasses and mosses lifting off the ground)
effervescence.register_environmental_particles({
  name = "effervescence:bustling",
  check = function(self, pos)
    return core.get_node(pos:offset(0,1,0)).name == "air"
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local does_apply = node:find("grass") or node:find("moss") or node:find("lichen") or node:find("^ethereal:.+_dirt$") or node:find("litter$") or node:find("mycelium")
    return does_apply and { "effervescence:floors" }
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(40,48),
      time = 6,
      pos = {
        min = pos:add(vector.new(-8,0.5,-8)),
        max = pos:add(vector.new(8,0.75,8)),
      },
      minvel = {x = -0.5, y = 0.1, z = -0.5},
      maxvel = {x = 0.5, y = 0.175, z = 0.5},
      minacc = {x = -0.325, y = 0.325, z = -0.325},
      maxacc = {x = 0.325, y = 0.5, z = 0.325},
      minexptime = 6,
      maxexptime = 12,
      minsize = 0.25,
      maxsize = 0.375,
      glow = ndef.glow or ndef.light_source,
      texture = {
        name = extract_particles(ndef.tiles,ndef.color),
        blend = blend_method,
      },
      collisiondetection = false,
      vertical = false,
    }
  end,
})

-- Snowy particles (snowflakes gusting up from the ground)
effervescence.register_environmental_particles({
  name = "effervescence:snowy",
  check = function(self, pos)
    return core.get_node(pos:offset(0,1,0)).name == "air"
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local is_snow = (groups.snowy and groups.snowy > 0) or node:find(":snow") or node:find("_with_snow")
    if is_snow then
      return { def.drawtype == "nodebox" and "effervescence:rare" or "effervescence:floors" }
    else
      return nil
    end
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(8,40),
      time = 2,
      pos = {
        min = pos:add(vector.new(-3,0,-3)),
        max = pos:add(vector.new(3,0.4,3)),
      },
      minvel = {x = -4, y = 2, z = -4},
      maxvel = {x = 4, y = 3, z = 4},
      minacc = {x = -1.75, y = 1, z = -1.75},
      maxacc = {x = 1.75, y = 1.5, z = 1.75},
      minexptime = 3,
      maxexptime = 5,
      minsize = 0.175,
      maxsize = 0.225,
      texture = {
        name = extract_particles(ndef.tiles,ndef.color),
        blend = blend_method,
      },
      collisiondetection = false,
      vertical = false,
    }
  end,
})

-- Leafy particles (falling leaves and snow on leaves)
local leaves = {
  air = true, -- special exception for easier check logic
}

effervescence.register_environmental_particles({
  name = "effervescence:leafy",
  check = function(self, pos)
    local below = core.get_node(pos:offset(0,-1,0)).name
    return leaves[below]
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local is_leaves = groups.leaves and groups.leaves > 0
    if is_leaves then
      leaves[node] = true
      return { "effervescence:few" }
    elseif node:find(":snow$") then
      return { "effervescence:many" }
    else
      return nil
    end
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(1,2),
      time = 3,
      pos = {
        min = pos:add(vector.new(-0.45,-0.3,-0.45)),
        max = pos:add(vector.new(0.45,-0.475,0.45)),
      },
      minvel = {x = -1, y = -0.75, z = -1},
      maxvel = {x = 1, y = -1.5, z = 1},
      minacc = {x = -0.75, y = -1, z = -0.75},
      maxacc = {x = 0.75, y = -1.5, z = 0.75},
      minexptime = 4,
      maxexptime = 6,
      minsize = 1,
      maxsize = 1.5,
      glow = ndef.glow or ndef.light_source,
      texture = {
        name = extract_particles(ndef.tiles,ndef.color),
        blend = blend_method,
      },
      collisiondetection = false,
      vertical = false,
    }
  end,
})

-- Blossoming particles (flower petals on the breeze)
local colors = {
  black = "#000000",
  white = "#ffffff",
  blue = "#1f75fe",
  cyan = "#00b7eb",
  orange = "#ff8c00",
  yellow = "#ffd700",
  purple = "#6f2da8",
  violet = "#6f2da8",
  magenta = "#ff33cc",
  red = "#ff2400",
  pink = "#ffc0cb",
  green = "#7cfc00",
  dark_green = "#013220",
  dark_gray = "#333333",
  darkgray = "#333333",
  grey = "#9a9a9a",
  brown = "#704214",
}

local flowers = { -- special cases listed here
  ["farming:sunflower_8"] = "#ffd700",
  ["farming:cotton_8"] = "#ffffff",
  ["x_farming:cotton_8"] = "#ffffff",
  ["dorwinion:dorwinion_glow_leaves"] = "self",
  ["nightshade:nightshade_glowin_leaves_1"] = "self",
  ["naturalbiomes:heatherflowernode"] = "self",
  ["naturalbiomes:heatherflower2node"] = "self",
  ["naturalbiomes:heatherflower3node"] = "self",
  ["naturalbiomes:heatherflower4node"] = "self",
}

effervescence.register_environmental_particles({
  name = "effervescence:blossoming",
  check = function(self, pos)
    return core.get_node(pos:offset(0,1,0)).name == "air"
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local is_plant = not def.walkable and def.drawtype:find("plant") and not node:find("shroom") and ((groups.flower and groups.flower > 0) or node:find("flower"))
    if is_plant then
      local dye = core.get_craft_result({
        method = "normal",
        width = 1,
        items = { node },
      })
      if not dye.item:is_empty() and dye.item:get_name():find("dye") then
        local dgroups = core.registered_items[dye.item:get_name()].groups
        for color,hex in pairs(colors) do
          if (dgroups["color_" .. color] and dgroups["color_" .. color] > 0) or (dgroups["basecolor_" .. color] and dgroups["basecolor_" .. color] > 0) then
            flowers[node] = hex
            break
          end
        end
      end
    end
    return flowers[node] and { "effervescence:many" }
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(2,3),
      time = 1,
      pos = {
        min = pos:add(vector.new(-0.25,-0.125,-0.25)),
        max = pos:add(vector.new(0.25,0.25,0.25)),
      },
      minvel = {x = -3, y = -0.05, z = -3},
      maxvel = {x = 3, y = 1.5, z = 3},
      minacc = {x = -0.125, y = -0.125, z = -0.125},
      maxacc = {x = 0.125, y = 0.75, z = 0.125},
      minexptime = 3,
      maxexptime = 5,
      minsize = 0.375,
      maxsize = 0.5,
      glow = ndef.glow or ndef.light_source,
      texture = {
        name = extract_particles(flowers[node.name] == "self" and ndef.tiles or {[1] = "effervescence_petals.png"},flowers[node.name] ~= "self" and flowers[node.name]),
        blend = blend_method,
      },
      collisiondetection = true,
      collision_removal = true,
      vertical = false,
    }
  end,
})

-- Sporogenic particles (primarily mushrooms, glow worms, and certain vines)
effervescence.register_environmental_particles({
  name = "effervescence:sporogenic",
  check = function(self, pos)
    return true
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local does_apply = not def.walkable and def.drawtype:find("plant") and (node:find("glow_worm") or node:find("shroom") or node:find("fung") or node:find("myc") or node:find("coral_grass") or node:find("coral_plant") or node:find("[:_]vine") or node:find("spore") or (groups.mushroom and groups.mushroom > 0))
    return does_apply and { "effervescence:many" }
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(9,12),
      time = 1.5,
      pos = {
        min = pos:add(vector.new(-0.25,-0.1,-0.25)),
        max = pos:add(vector.new(0.25,0.1,0.25)),
      },
      minvel = {x = -0.625, y = -0.075, z = -0.625},
      maxvel = {x = 0.625, y = -0.05, z = 0.625},
      minacc = {x = 0, y = -0.25, z = 0},
      maxacc = {x = 0, y = -0.125, z = 0},
      minexptime = 5,
      maxexptime = 8,
      minsize = 0.25,
      maxsize = 0.325,
      glow = ndef.glow or ndef.light_source or 2,
      texture = {
        name = extract_particles(ndef.tiles,ndef.color,"4,7"),
        blend = blend_method,
      },
      collisiondetection = true,
      collision_removal = true,
      vertical = false,
    }
  end,
})

-- Sparkly particles (glistening crystals or ice)
local neighbors = {
  vector.new(0,1,0),
  vector.new(1,0,0),
  vector.new(0,0,1),
  vector.new(-1,0,0),
  vector.new(0,0,-1),
  vector.new(0,-1,0),
}

effervescence.register_environmental_particles({
  name = "effervescence:sparkly",
  check = function(self, pos)
    for _,direction in ipairs(neighbors) do
      if core.get_node(pos:add(direction)).name == "air" then
        return true
      end
    end
    return false
  end,
  applies_to = function(self, node, def)
    local does_apply = (def.drawtype:find("plant") and (node:find("[:_]crystal") or node:find("[:_]gem") or node:find("^caverealms:spike$") or node:find("icicle")) or node:find("[:_]ice$") or node:find("[:_]cave_ice$"))
    return does_apply and { "effervescence:many" }
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(9,11),
      time = 4,
      pos = {
        min = pos:add(vector.new(-0.75,-0.25,-0.75)),
        max = pos:add(vector.new(0.75,0.575,0.75)),
      },
      minvel = {x = 0, y = -0.05, z = 0},
      maxvel = {x = 0, y = 0, z = 0},
      minacc = {x = 0, y = 0, z = 0},
      maxacc = {x = 0, y = 0, z = 0},
      minexptime = 3,
      maxexptime = 6,
      minsize = 0.1,
      maxsize = 0.2,
      glow = ndef.glow or ndef.light_source or 2,
      texture = {
        name = extract_particles(ndef.tiles,nil,"4,7") .. "^[sheet:4x4:1,1^[opacity:255^[brighten",
        blend = blend_method,
      },
      collisiondetection = false,
      vertical = false,
    }
  end,
})

-- Tiny bubbles at the surface of water
effervescence.register_environmental_particles({
  name = "effervescence:bubbling",
  check = function(self, pos)
    return core.get_node(pos:offset(0,1,0)).name == "air"
  end,
  applies_to = function(self, node, def)
    local does_apply = (def.liquidtype == "source" and node:find("[:_]water"))
    return does_apply and { "effervescence:liquid_surface" }
  end,
  emit = function(self, pos)
    local node = core.get_node(pos)
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(4,6),
      time = math.random(3,4),
      pos = {
        min = pos:add(vector.new(-0.45,0.5,-0.45)),
        max = pos:add(vector.new(0.45,0.525,0.45)),
      },
      minvel = {x = -0.0275, y = -0.025, z = -0.0275},
      maxvel = {x = 0.0275, y = 0, z = 0.0275},
      minacc = {x = 0, y = 0, z = 0},
      maxacc = {x = 0, y = 0, z = 0},
      minexptime = 1,
      maxexptime = 2,
      minsize = 1,
      maxsize = 1.25,
      glow = ndef.glow or ndef.light_source,
      texture = extract_particles(ndef.tiles,ndef.color) .. "^[brighten^[opacity:127",
      collisiondetection = false,
      vertical = false,
    }
  end,
})

-- Player walk particles (bits of dirt, snow, etc. kicked up underfoot)
local walking_nodes = {}

effervescence.register_player_particles({
  name = "effervescence:walking",
  check = function(self, player)
    local velocity = player:get_velocity()
    if math.abs(velocity.x) > 0.025 or math.abs(velocity.z) > 0.025 then
      local below = core.get_node(player:get_pos():offset(0,-0.1,0)).name
      return walking_nodes[below]
    end
  end,
  applies_to = function(self, node, def)
    local groups = def.groups or {}
    local does_apply = (groups.crumbly and groups.crumbly > 0) or (groups.soil and groups.soil > 0) or (groups.sand and groups.sand > 0) or (groups.leaves and groups.leaves > 0) or (groups.snowy and groups.snowy > 0) or node:find(":snow") or node:find("_with_snow")
    if does_apply then
      walking_nodes[node] = true
      return true
    else
      return false
    end
  end,
  emit = function(self, player)
    local pos = player:get_pos()
    local node = core.get_node(pos:offset(0,-0.1,0))
    local ndef = core.registered_nodes[node.name]
    return {
      amount = math.random(3,4),
      time = 0.25,
      pos = {
        min = pos:add(vector.new(-0.45,0.175,-0.45)),
        max = pos:add(vector.new(0.45,0.275,0.45)),
      },
      minvel = {x = -1, y = 0.75, z = -1},
      maxvel = {x = 1, y = 1, z = 1},
      minacc = {x = 0, y = -9.81, z = 0},
      maxacc = {x = 0, y = -9.81, z = 0},
      minexptime = 1,
      maxexptime = 1,
      minsize = 0.75,
      maxsize = 1,
      glow = ndef.glow or ndef.light_source,
      texture = {
        name = extract_particles(ndef.tiles,ndef.color),
        blend = blend_method,
      },
      collisiondetection = true,
      collision_removal = true,
      vertical = false,
    }
  end,
})