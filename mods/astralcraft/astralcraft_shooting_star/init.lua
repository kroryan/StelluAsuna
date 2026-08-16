-- ---------- --
--  ENTITIES  --
-- ---------- --

core.register_entity(":astralcraft:shooting_star",{
  initial_properties = {
    visual = "cube",
    textures = { 
      "[fill:16x16:#ffffff",
      "[fill:16x16:#ffffff",
      "[fill:16x16:#ffffff",
      "[fill:16x16:#ffffff",
      "[fill:16x16:#ffffff",
      "[fill:16x16:#ffffff",
    },
    visual_size = {
      x = 0.1,
      y = 0.1,
      z = 0.1,
    },
    glow = 14,
    shaded = false,
    pointable = false,
    collide_with_objects = false,
    automatic_rotate = 15,
  },

  on_activate = function(self,staticdata)
    -- Make immortal
    self.object:set_armor_groups({ immortal = 1 })

    -- Capture initial data
    self.start_pos = self.object:get_pos()
    self.last_pos = self.start_pos
    self.end_pos = self.start_pos:offset(math.random(-4,4),math.random(-8,-6),math.random(-4,4))

    -- Set velocity
    local velocity = vector.direction(self.start_pos,self.end_pos):multiply(15,15,15)
    self.object:add_velocity(velocity)

    -- Play appearance sound
    core.sound_play("astralcraft_shooting_star_appear",{
      pos = self.start_pos,
      gain = 0.25,
      pitch = 1.25,
      max_hear_distance = 256,
    })

    -- Add trailing particles
    self.particles = core.add_particlespawner({
      attached = self.object,
      amount = 128,
      time = 0,
      minpos = vector.new(-0.5,-0.5,-0.5),
      maxpos = vector.new(0.5,0.5,0.5),
      texture = {
        name = "plus.png",
        blend = "add",
      },
      glow = 14,
      minexptime = 1,
      maxexptime = 2,
      minsize = 1,
      maxsize = 1.25,
      vel = velocity:multiply(-1,-1,-1),
    })
  end,

  on_deactivate = function(self,removal)
    if not removal then
      self.object:remove()
    end
  end,

  on_step = function(self,dtime)
    -- Stop and spawn shooting star item if beyond end pos
    local pos = self.object:get_pos()
    local node = core.get_node(pos)
    if node.name ~= "air" and node.name ~= "ignore" then
      -- Add landing particles
      core.add_particlespawner({
        amount = 256,
        time = 0.1,
        pos = pos,
        texture = {
          name = "plus.png",
          blend = "add",
        },
        glow = 14,
        minexptime = 0.75,
        maxexptime = 1,
        minsize = 2,
        maxsize = 2.5,
        minvel = { x = -5, y = -5, z = -5 },
        maxvel = { x = 5, y = 5, z = 5 },
        collisiondetection = false,
      })

      -- Play landing sound
      core.sound_play("astralcraft_shooting_star_landing",{
        pos = pos,
        gain = 1.0,
        max_hear_distance = 256,
      })

      -- Remove entity
      self.object:remove()

      -- Drop a shooting star item
      local item = core.add_item(self.last_pos:offset(0,0.5,0),ItemStack("astralcraft:shooting_star"))

      -- Add sparkling particles to the item
      core.add_particlespawner({
        attached = item,
        amount = 32,
        time = 0,
        pos = vector.zero(),
        texture = {
          name = "plus.png",
          blend = "add",
        },
        glow = 14,
        minexptime = 1.5,
        maxexptime = 2,
        minsize = 0.5,
        maxsize = 0.75,
        minvel = { x = -0.5, y = 0, z = -0.5 },
        maxvel = { x = 0.5, y = 0.5, z = 0.5 },
        collisiondetection = false,
      })

      -- Mark as untouched if Awards mod is available
      if astralcraft.dependencies.awards and item then
        local entity = item:get_luaentity()
        local itemstring = entity.itemstring
        local itemstack = ItemStack(itemstring)
        itemstack:get_meta():set_string("untouched","1")
        entity.itemstring = itemstack:to_string()
      end
    else
      self.last_pos = pos
    end
  end,
})

-- ------- --
--  ITEMS  --
-- ------- --

core.register_craftitem(":astralcraft:shooting_star",{
  description = "Shooting Star",
  inventory_image = "astralcraft_shooting_star.png",
  wield_image = "astralcraft_shooting_star_wield.png",
  wield_scale = {
    x = 0.75,
    y = 0.75,
    z = 0.5,
  },
  light_source = 12,
  on_pickup = astralcraft.dependencies.awards and function(itemstack,picker,...)
    local meta = itemstack:get_meta()
    if meta:get("untouched") then
      awards.unlock(picker:get_player_name(),"astralcraft:wish_upon_a_star")
    end
    meta:set_string("untouched","")
    return core.item_pickup(itemstack,picker,...)
  end or nil,
})

core.register_craftitem(":astralcraft:star_fragment",{
  description = "Star Fragment",
  inventory_image = "astralcraft_star_fragment.png",
  light_source = 8,
})

-- ---------- --
--  CRAFTING  --
-- ---------- --

core.register_craft({
  recipe = {
    { "astralcraft:shooting_star" },
  },
  output = "astralcraft:star_fragment " .. astralcraft.settings.shooting_star.fragments_per_star,
})

-- ----------- --
--  FUNCTIONS  --
-- ----------- --

local day_check_timer = 5
local is_day = false

astralcraft.registered_shooting_star_spawners = {}

function astralcraft.register_shooting_star_spawner(def)
  local spawner = {
    -- Variable properties
    interval = def.interval_min,
    chance = def.chance_min,

    -- Fixed properties
    interval_min = def.interval_min,
    interval_max = def.interval_max,
    chance_min = def.chance_min,
    chance_max = def.chance_max,
    node_radius = def.node_radius,
    chance_step = def.chance_step,
    y_min = def.y_min,
    y_max = def.y_max,
    is_player_eligible = def.is_player_eligible or function() return true end,

    -- Function that attempts to spawn shooting stars
    trigger = function(self,dtime)
      -- Tick interval
      self.interval = self.interval - dtime
      if self.interval > 0 then
        return
      else
        self.interval = math.random(self.interval_min,self.interval_max)
      end

      -- Calculate chance
      if math.random(1,100) > self.chance then
        self.chance = self.chance + self.chance_step
        return
      else
        self.chance = self.chance_min
      end

      -- Select a point high above a valid player
      local players = {}
      for _,player in ipairs(core.get_connected_players()) do
        if player and self:is_player_eligible(player) then
          local pos = player:get_pos()
          if pos.y >= self.y_min and pos.y <= self.y_max then
            table.insert(players,player)
          end
        end
      end

      local player = (#players > 0) and players[math.random(1,#players)]
      local pos
      if player then
        for i = 1, 3 do
          local radius = self.node_radius
          local delta_x = math.random(-radius,radius)
          local delta_z = math.random(-radius,radius)
          pos = player:get_pos():offset(delta_x,32,delta_z)
          if core.get_node(pos) == "air" then
            break
          end
        end
      else
        return -- no valid player
      end

      -- Create shooting star entity at the selected origin point
      if pos then
        core.add_entity(pos,"astralcraft:shooting_star")
      end
    end,
  }
  table.insert(astralcraft.registered_shooting_star_spawners,spawner)
end

local star_destroy_interval = 5
core.register_globalstep(function(dtime)
  -- Do not check for shooting stars during the day
  day_check_timer = day_check_timer - dtime
  if day_check_timer <= 0 then
    local time_of_day = core.get_timeofday()
    if time_of_day < 0.205 or time_of_day > 0.76 then
      is_day = false
    else
      is_day = true
    end
  end

  -- Destroy shooting star items during the day
  if is_day then
    star_destroy_interval = star_destroy_interval - dtime
    if star_destroy_interval <= 0 then
      for id,entity in pairs(core.luaentities) do
        local name = entity.name
        if entity.object and entity.object:is_valid() and entity.name == "__builtin:item" and entity.itemstring and entity.itemstring:find("^astralcraft:shooting_star") and (core.get_natural_light(entity.object:get_pos(),0) or 0) > 0 then
          entity.object:remove()
        end
      end
      star_destroy_interval = 5
    end
  else -- Trigger shooting stars at night
    for _,spawner in ipairs(astralcraft.registered_shooting_star_spawners) do
      spawner:trigger(dtime)
    end
  end
end)

-- ----------------- --
--  NATIVE SPAWNERS  --
-- ----------------- --

local settings = astralcraft.settings.shooting_star
for i = 1, astralcraft.settings.shooting_star.spawners do
  astralcraft.register_shooting_star_spawner({
    interval_min = settings.interval_min,
    interval_max = settings.interval_max,
    chance_min = settings.chance_min,
    chance_max = settings.chance_max,
    node_radius = settings.node_radius,
    chance_step = settings.chance_step,
    y_min = settings.y_min,
    y_max = settings.y_max,
  })
end

-- -------- --
--  AWARDS  --
-- -------- --

if astralcraft.dependencies.awards then
  awards.register_award("astralcraft:wish_upon_a_star",{
    title = "Wish Upon a Star",
    description = "Collect a shooting star that falls from the night sky",
    icon = "astralcraft_shooting_star.png",
    difficulty = 45,
  })
end