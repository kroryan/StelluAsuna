-- ------- --
--  NODES  --
-- ------- --

local groups = {
  oddly_breakable_by_hand = 1,
  cracky = 2,
}

core.register_node(":astralcraft:astralite",{
  drawtype = "normal",
  description = "Astralite",
  tiles = { "astralcraft_astralite.png" },
  paramtype = "light",
  groups = groups,
  sounds = default.node_sound_glass_defaults(),
})

local sf = "astralcraft:star_fragment"
core.register_craft({
  recipe = {
    {sf, sf},
    {sf, sf},
  },
  output = "astralcraft:astralite 4",
})

if astralcraft.dependencies.stairs then
  -- Register stair
  stairs.register_stair(
    "astralite",
    "astralcraft:star_fragment",
    groups,
    { "astralcraft_astralite.png" },
    "Astralite Stair",
    default.node_sound_glass_defaults(),
    true
  )

  -- Register inner stair
  stairs.register_stair_inner(
    "astralite",
    "astralcraft:star_fragment",
    groups,
    { "astralcraft_astralite.png" },
    "Astralite Inner Stair",
    default.node_sound_glass_defaults(),
    true
  )

  -- Register outer stair
  stairs.register_stair_outer(
    "astralite",
    "astralcraft:star_fragment",
    groups,
    { "astralcraft_astralite.png" },
    "Astralite Outer Stair",
    default.node_sound_glass_defaults(),
    true
  )

  -- Register slab
  stairs.register_slab(
    "astralite",
    "astralcraft:star_fragment",
    groups,
    { "astralcraft_astralite.png" },
    "Astralite Slab",
    default.node_sound_glass_defaults(),
    true
  )
end

if astralcraft.dependencies.walls then
  -- Register wall
  walls.register(
    ":walls:astralite",
    "Astralite Wall",
    { "astralcraft_astralite.png" },
    "astralcraft:star_fragment",
    default.node_sound_glass_defaults()
  )
end

local astralite_nodes = {
  ["astralcraft:astralite"] = true,
  ["stairs:stair_astralite"] = true,
  ["stairs:stair_outer_astralite"] = true,
  ["stairs:stair_inner_astralite"] = true,
  ["stairs:slab_astralite"] = true,
  ["walls:astralite"] = true,
}

-- Add light to all Astralite nodes
for node,_ in pairs(astralite_nodes) do
  core.override_item(node,{
    light_source = 12,
  })
end

-- -------------- --
--  PLAYER STATE  --
-- -------------- --

local particles = {}
local Astralite = {
  -- State action functions
  add_jump_boost = function(player)
    player_monoids.jump:add_change(player,5,"astralcraft:astralite_jump_boost")
  end,

  remove_jump_boost = function(player)
    player_monoids.jump:del_change(player,"astralcraft:astralite_jump_boost")
  end,

  add_speed_boost = function(player)
    player_monoids.speed:add_change(player,5,"astralcraft:astralite_speed_boost")
  end,

  remove_speed_boost = function(player)
    player_monoids.speed:del_change(player,"astralcraft:astralite_speed_boost")
  end,

  reduce_gravity = function(player)
    player_monoids.gravity:add_change(player,0.5,"astralcraft:astralite_low_gravity")
  end,

  restore_gravity = function(player)
    player_monoids.gravity:del_change(player,"astralcraft:astralite_low_gravity")
  end,

  grant_fall_damage_immunity = function(player)
    armor_monoid.monoid:add_change(player,{fall_damage_add_percent=0},"astralcraft:astralite_fall_damage_immunity")
  end,

  remove_fall_damage_immunity = function(player)
    armor_monoid.monoid:del_change(player,"astralcraft:astralite_fall_damage_immunity")
  end,

  grant_skywalker_award = astralcraft.dependencies.awards and function(player)
    awards.unlock(player:get_player_name(),"astralcraft:skywalker")
  end or function() end,

  particles = {},
  add_particles = function(player)
    local pname = player:get_player_name()
    if not particles[pname] then
      local p = core.add_particlespawner({
        attached = player,
        amount = 32,
        time = 0,
        pos = {
          min = vector.new(-0.6,0,-0.6),
          max = vector.new(0.6,0,0.6),
        },
        minsize = 0.75,
        maxsize = 1,
        minvel = { x = 0, y = 0.125, z = 0 },
        maxvel = { x = 0, y = 0.25, z = 0 },
        minacc = { x = 0, y = 0.1, z = 0 },
        maxacc = { x = 0, y = 0.2, z = 0 },
        minexptime = 4,
        maxexptime = 3,
        texture = "plus.png^[multiply:#a27cb7",
        glow = 14,
        collisiondetection = false,
      })
      if p and p ~= -1 then
        particles[pname] = p
      end
    end
  end,

  remove_particles = function(player)
    local pname = player:get_player_name()
    local p = particles[pname]
    if p then
      core.delete_particlespawner(p)
      particles[pname] = nil
    end
  end,

  -- States enum/functions
  GROUNDED = function(self,player)
    local pos = player:get_pos()
    local below = pos:offset(0,-0.1,0)
    local on = core.get_node(below)

    if astralite_nodes[on.name] then
      self.add_jump_boost(player)
      self.reduce_gravity(player)
      self.add_particles(player)
      return "LAUNCHING"
    else
      return "GROUNDED"
    end
  end,

  init__GROUNDED = function(self,player)
    self.restore_gravity(player)
    self.remove_speed_boost(player)
    self.remove_particles(player)
    self.remove_fall_damage_immunity(player)
  end,

  LAUNCHING = function(self,player)
    local pos = player:get_pos()
    local below = pos:offset(0,-0.1,0)
    local on = core.get_node(below)
    local ondef = core.registered_nodes[on.name]

    if astralite_nodes[on.name] then
      return "LAUNCHING"
    elseif (player:get_velocity().y or 0) > 0 and (on.name == "air" or (ondef and not ondef.walkable and not ondef.climbable and ondef.liquidtype == "none")) then
      self.remove_jump_boost(player)
      self.add_speed_boost(player)
      self.grant_fall_damage_immunity(player)
      self.grant_skywalker_award(player)
      return "LEAPING"
    else
      self.remove_jump_boost(player)
      self.restore_gravity(player)
      self.remove_particles(player)
      return "GROUNDED"
    end
  end,

  init__LAUNCHING = function(self,player)
    self.add_jump_boost(player)
    self.reduce_gravity(player)
    self.add_particles(player)
  end,

  LEAPING = function(self,player)
    local pos = player:get_pos()
    local below = pos:offset(0,-0.1,0)
    local on = core.get_node(below)
    local ondef = core.registered_nodes[on.name]

    if on.name ~= "ignore" and ondef and (ondef.walkable or ondef.climbable or ondef.liquidtype ~= "none") then
      self.restore_gravity(player)
      self.remove_speed_boost(player)
      self.remove_particles(player)
      self.remove_fall_damage_immunity(player)
      return "GROUNDED"
    else
      return "LEAPING"
    end
  end,

  init__LEAPING = function(self,player)
    self.remove_jump_boost(player)
    self.add_speed_boost(player)
    self.grant_fall_damage_immunity(player)
    self.grant_skywalker_award(player)
  end,

  -- Player states
  player_states = (function()
    local saved_states = astralcraft.storage:get("astralite_states")
    return saved_states and core.deserialize(saved_states) or {}
  end)(),

  -- Flag to indicate that state was changed
  state_changed = false,

  -- Get player state
  get_player_state = function(self,player)
    return self.player_states[player:get_player_name()]
  end,

  -- Set player state
  set_player_state = function(self,player,state)
    -- Get name and state values
    local pname = player:get_player_name()
    local previous_state = self.player_states[pname]

    -- Set state
    self.player_states[pname] = state

    -- Set state change flag if state was actually changed
    if state ~= previous_state then
      self.state_changed = true
      return true
    else
      return false
    end
  end,

  -- Change player state based on their current state
  change_player_state = function(self,player,dtime)
    self:set_player_state(player,self[self:get_player_state(player)](self,player,dtime))
  end,

  -- Save state
  save = function(self)
    if self.state_changed then
      astralcraft.storage:set_string("astralite_states",core.serialize(self.player_states))
      self.state_changed = false
      return true
    else
      return false
    end
  end,
}

-- Add new players to Astralite state map
core.register_on_joinplayer(function(player)
  local saved_state = Astralite.player_states[player:get_player_name()] or "GROUNDED"
  Astralite:set_player_state(player,saved_state)
  Astralite["init__" .. saved_state](Astralite,player)
end)

-- Astralite state loop
local state_interval = astralcraft.settings.astralite.state_interval
local save_interval = astralcraft.settings.astralite.save_interval
local state_changed = false
core.register_globalstep(function(dtime)
  -- State check
  state_interval = state_interval - dtime
  if state_interval <= 0 then
    local delta = astralcraft.settings.astralite.state_interval - state_interval
    for _,player in ipairs(core.get_connected_players()) do
      if player then
        Astralite:change_player_state(player,delta)
      end
    end
    state_interval = astralcraft.settings.astralite.state_interval + state_interval
  end

  -- Save check
  save_interval = save_interval - dtime
  if save_interval <= 0 then
    Astralite:save()
    save_interval = astralcraft.settings.astralite.save_interval + save_interval
  end
end)

-- -------- --
--  AWARDS  --
-- -------- --

if astralcraft.dependencies.awards then
  awards.register_award("astralcraft:skywalker",{
    title = "Skywalker",
    description = "Launch into the air using Astralite",
    icon = "astralcraft_astralite.png",
    difficulty = 60,
  })
end