-- ---------- --
--  ENTITIES  --
-- ---------- --

local is_creative = core.settings:get_bool("creative_mode",false)
local wear_per_distance = is_creative and 0 or astralcraft.settings.warp_star.wear_per_distance
local wear_per_failure = is_creative and 0 or astralcraft.settings.warp_star.wear_per_failure

local throw_velocity = astralcraft.settings.warp_star.throw_velocity
local timeout = astralcraft.settings.warp_star.timeout

core.register_entity(":astralcraft:warp_star_thrown",{
  initial_properties = {
    visual = "cube",
    textures = { 
      "[fill:16x16:#fffedd",
      "[fill:16x16:#fffedd",
      "[fill:16x16:#fffedd",
      "[fill:16x16:#fffedd",
      "[fill:16x16:#fffedd",
      "[fill:16x16:#fffedd",
    },
    visual_size = {
      x = 0.05,
      y = 0.05,
      z = 0.05,
    },
    glow = 10,
    shaded = false,
    pointable = false,
    collide_with_objects = false,
  },

  on_step = function(self, dtime)
    -- Check for timeout
    self.timer = self.timer + dtime
    if self.timer >= timeout then
      self:reset(wear_per_failure)
      return
    end

    -- Get position and check for collision
    local pos = self.object:get_pos()
    local node = core.get_node(pos)
    local def = core.registered_nodes[node.name]

    if def and (def.walkable or def.climbable or def.liquidtype ~= "none") then
      self.hit = true
      local player = core.get_player_by_name(self.thrower)
      if player then
        -- Check for zero distance throw
        local distance = vector.distance(self.last_pos,player:get_pos())
        if distance == 0 then
          self:reset()
          return
        end

        -- Add wear
        local item = ItemStack(self.itemstring)
        item:add_wear(math.floor(distance * wear_per_distance))

        -- Get biased landing position in favor of nearby air nodes
        local bias = vector.copy(self.last_pos)
        for i = -0.5, 0.5, 1 do
          for _,d in ipairs({"x","y","z"}) do
            self.last_pos[d] = self.last_pos[d] + i
            if core.get_node(self.last_pos).name == "air" then
              bias[d] = bias[d] + i
            end
            self.last_pos[d] = self.last_pos[d] - i
          end
        end

        -- Drop item
        core.add_item(bias,item)

        -- Teleport player
        player:set_pos(bias)

        -- Play teleportation sound
        core.sound_play("astralcraft_warp_star_teleport",{
          pos = bias,
          gain = 0.5,
          max_hear_distance = 32,
        })

        -- Add landing particles
        core.add_particlespawner({
          amount = 128,
          time = 0.1,
          pos = bias,
          texture = "plus.png^[multiply:#faface",
          glow = 10,
          minexptime = 0.75,
          maxexptime = 1,
          minsize = 0.75,
          maxsize = 1,
          minvel = { x = -2, y = -1, z = -2 },
          maxvel = { x = 2, y = 1, z = 2 },
          collisiondetection = false,
        })

        -- Possibly grant "Across the Universe" award
        if astralcraft.dependencies.awards and vector.distance(self.start_pos,bias) >= 100 then
          awards.unlock(player:get_player_name(),"astralcraft:across_the_universe")
        end

        -- Destroy self
        self:destroy()
      end
    elseif not def or node.name == "ignore" then
      self:reset(wear_per_failure)
    else
      self.last_pos = pos
    end
  end,

  on_activate = function(self,staticdata)
    -- Make immortal
    self.object:set_armor_groups({ immortal = 1 })

    -- Capture static data
    if staticdata then
      staticdata = staticdata:split("\x28")
      self.thrower = staticdata[1]
      self.itemstring = staticdata[2]
      self.hit = false
      self.last_pos = self.object:get_pos():offset(0,-1.5,0)
      self.start_pos = self.last_pos
      self.timer = 0
    end

    -- Self-destruct if unloaded
    if not self.thrower then
      self:destroy()
      return
    end

    -- Add trailing particles
    core.add_particlespawner({
      attached = self.object,
      amount = 32,
      time = 0,
      pos = vector.new(0,0.1,0),
      texture = "plus.png^[multiply:#faface",
      glow = 10,
      minexptime = 1,
      maxexptime = 2,
      minsize = 0.1,
      maxsize = 0.125,
      minvel = { x = -0.05, y = -0.05, z = -0.05 },
      maxvel = { x = 0.05, y = 0.05, z = 0.05 },
      collisiondetection = false,
    })

    local player = core.get_player_by_name(self.thrower)
    if player then
      -- Set entity physics based on player look direction
      local look_dir = player:get_look_dir()
      self.object:set_velocity({
        x = look_dir.x * throw_velocity,
        y = look_dir.y * throw_velocity,
        z = look_dir.z * throw_velocity,
      })
      self.object:set_acceleration({
        x = 0,
        y = -9.81, -- gravity
        z = 0,
      })
      self.object:set_yaw(player:get_look_horizontal() - math.pi / 2)

      -- Play throwing sound
      core.sound_play("astralcraft_shooting_star_appear",{
        pos = self.start_pos,
        gain = 0.25,
        max_hear_distance = 32,
      })
    else
      self:destroy()
    end
  end,

  on_deactivate = function(self,removal)
    if not removal and not self.hit then
      self:reset(wear_per_failure)
    end
  end,

  destroy = function(self)
    self.object:remove()
  end,

  reset = function(self,wear)
    -- Do not reset if already reset
    if not self.thrower then
      self:destroy()
      return
    end

    -- Add wear penalty
    local item = ItemStack(self.itemstring)
    if wear and wear > 0 then
      item:add_wear(wear_per_failure)
    end

    -- Drop warp star at player's location if possible, else drop at self location
    local player = core.get_player_by_name(self.thrower)
    if player then
      core.add_item(player:get_pos():offset(0,0.5,0),item)
    else
      core.add_item(self.object:get_pos(),item)
    end

    -- Play teleport sound
    core.sound_play("astralcraft_warp_star_teleport",{
      pos = self.start_pos,
      gain = 0.5,
      max_hear_distance = 32,
    })

    -- Destroy this entity
    self:destroy()
  end,
})

-- ------- --
--  ITEMS  --
-- ------- --

core.register_tool(":astralcraft:warp_star",{
  description = "Warp Star",
  inventory_image = "astralcraft_warp_star.png",
  wield_image = "astralcraft_warp_star.png^[transformFX",
  wield_scale = {
    x = 0.75,
    y = 0.75,
    z = 0.5,
  },
  glow = 10,
  light_source = 10,
  groups = {
    astral = 1,
  },
  on_use = function(item, player)
    local wi = player:get_wield_index()
    local item = player:get_inventory():get_stack("main",wi)
    player:get_inventory():set_stack("main",wi,ItemStack())
    local thrower = player:get_player_name()
    core.add_entity(player:get_pos():offset(0,1.5,0),"astralcraft:warp_star_thrown",thrower .. "\x28" .. item:to_string())
    return nil
  end,
})

-- --------- --
--  RECIPES  --
-- --------- --

core.register_craft({
  recipe = {
    { "", "default:mese_crystal_fragment", "" },
    { "default:mese_crystal_fragment", "astralcraft:shooting_star", "default:mese_crystal_fragment" },
    { "", "default:mese_crystal_fragment", "" },
  },
  output = "astralcraft:warp_star",
})

core.register_craft({
  type = "shapeless",
  recipe = { "astralcraft:warp_star", "default:mese_crystal_fragment" },
  output = "astralcraft:warp_star",
})

-- -------- --
--  AWARDS  --
-- -------- --

if astralcraft.dependencies.awards then
  awards.register_award("astralcraft:across_the_universe",{
    title = "Across the Universe",
    description = "Use a Warp Star to teleport a distance of at least 100 nodes",
    icon = "astralcraft_warp_star.png",
    difficulty = 160,
  })
end