-- Settings loaded from Asuna
local asuna_amount = asuna.settings.particles.amount
local asuna_enabled = asuna_amount ~= "none" and true or false
local asuna_chance = (function()
  if asuna_amount == "less" then
    return 29
  elseif asuna_amount == "more" then
    return 70
  elseif asuna_amount == "maximum" then
    return 100
  else
    return 1
  end
end)()
local asuna_interval = (function()
  if asuna_amount == "less" then
    return 5.25
  elseif asuna_amount == "more" then
    return 3.5
  elseif asuna_amount == "maximum" then
    return 2.0
  else
    return 60.0
  end
end)()

effervescence = {
  -- Settings loaded from settingtypes.txt
  settings = {
    environmental = {
      enabled = asuna_enabled,
      interval = asuna_interval,
      chance = asuna_chance,
      radius_x = tonumber(core.settings:get("effervescence.environmental.radius_x",18) or 18),
      radius_y = tonumber(core.settings:get("effervescence.environmental.radius_y",6) or 6),
      radius_z = tonumber(core.settings:get("effervescence.environmental.radius_z",18) or 18),
      look_dir_bias = tonumber(core.settings:get("effervescence.environmental.look_dir_bias",4) or 4),
    },
    player = {
      enabled = asuna_enabled,
      interval = tonumber(core.settings:get("effervescence.player.interval",0.5) or 0.5),
    },
  },

  -- Node meta decorator registration
  decorators = {},
  register_decorator = function(def)
    if type(def.name) ~= "string" or effervescence.decorators[def.name] then
      return false, "invalid name or name already in use"
    end

    if type(def.apply_to) ~= "function" then
      return false, "apply_to must be a function"
    end

    if type(def.decorate) ~= "function" then
      return false, "decorate must be a function"
    end

    effervescence.decorators[def.name] = def
    return true
  end,

  -- Player-based particle registration
  player_particles = {},
  register_player_particles = function(def)
    if type(def.name) ~= "string" or def.name:find(",") or effervescence.environmental_particles[def.name] then
      return false, "invalid name or name already in use"
    end

    if type(def.applies_to) ~= "function" then
      return false, "applies_to must be a function"
    end

    if type(def.emit) ~= "function" then
      return false, "emit must be a function"
    end

    def.check = (type(def.check) == "function" and def.check) or function() return true end

    effervescence.player_particles[def.name] = def
    return true
  end,

  -- Environmental particle registration
  environmental_particles = {},
  register_environmental_particles = function(def)
    if type(def.name) ~= "string" or def.name:find(",") or effervescence.environmental_particles[def.name] then
      return false, "invalid name or name already in use"
    end

    if type(def.applies_to) ~= "function" then
      return false, "applies_to must be a function"
    end

    if type(def.emit) ~= "function" then
      return false, "emit must be a function"
    end

    def.check = (type(def.check) == "function" and def.check) or function() return true end

    effervescence.environmental_particles[def.name] = def
    return true
  end,

  -- Add particle to node meta
  add_particle_meta = function(pos, particle)
    local meta = core.get_meta(pos)
    local particles = meta:get("effervescence.particles")
    if particles then
      meta:set_string("effervescence.particles",particles .. "," .. particle)
    else
      meta:set_string("effervescence.particles",particle)
    end
  end,
}

-- Player effect trigger
local math_sign = function(number)
  return (number > 0 and 1) or (number < 0 and -1) or 0
end

local math_round = function(number)
  return math_sign(number) * math.floor(math.abs(number) + 0.5)
end

local get_look_bias = effervescence.settings.environmental.look_dir_bias > 0 and function(look_dir)
  local bias = effervescence.settings.environmental.look_dir_bias
  return math_round(look_dir.x * bias), math_round(look_dir.y * bias / 2), math_round(look_dir.z * bias)
end or function() return 0, 0, 0 end

-- Environmental particles
local environmental_particles
if effervescence.settings.environmental.enabled then
  local etime = effervescence.settings.environmental.interval
  environmental_particles = function(dtime)
    etime = etime - dtime
    if etime < 0 then
      etime = effervescence.settings.environmental.interval
      local already_emitted = {}
      for _,player in ipairs(core.get_connected_players()) do
        if player then
          local pname = player:get_player_name()
          local pos = player:get_pos()
          local look_dir = player:get_look_dir()
          local bx, by, bz = get_look_bias(look_dir)
          for _,emitter in ipairs(
            core.find_nodes_with_meta(
              pos:offset(-effervescence.settings.environmental.radius_x + bx,-effervescence.settings.environmental.radius_y + by,-effervescence.settings.environmental.radius_z + bz),
              pos:offset(effervescence.settings.environmental.radius_x + bx,effervescence.settings.environmental.radius_y + by,effervescence.settings.environmental.radius_z + bz)
            )) do
            local hash = core.hash_node_position(emitter)
            if not already_emitted[hash] then
              local particles = core.get_meta(emitter):get("effervescence.particles")
              if particles and math.random(1,100) <= effervescence.settings.environmental.chance then
                particles = particles:split(",")
                local r = math.random(1,#particles)
                local len = #particles
                for i = r, len + r - 1, 1 do
                  local particle = effervescence.environmental_particles[particles[i % len + 1]]
                  if particle and particle:check(emitter) then
                    local pdef = particle:emit(emitter)
                    pdef.playername = pname,
                    core.add_particlespawner(pdef)
                    already_emitted[hash] = true
                    break
                  end
                end
              end
            end
          end
        end
      end
    end
  end
else
  environmental_particles = function()
    -- no-op; environmental particles are disabled
  end
end

-- Player walk particles
local player_particles
if effervescence.settings.player.enabled then
  -- Lookup map of players to particle trigger time
  local ptime = {}

  -- Initialize player in map on join
  core.register_on_joinplayer(function(player)
    ptime[player:get_player_name()] = effervescence.settings.player.interval
  end)

  -- Remove player time
  core.register_on_leaveplayer(function(player)
    ptime[player:get_player_name()] = nil
  end)

  -- Particle spawning function
  player_particles = function(dtime)
    for _,player in ipairs(core.get_connected_players()) do
      if player then
        local pname = player:get_player_name()
        if ptime[pname] then
          ptime[pname] = ptime[pname] - dtime
          if ptime[pname] < 0 then
            ptime[pname] = effervescence.settings.player.interval
            for name,particle in pairs(effervescence.player_particles) do
              if particle:check(player) then
                core.add_particlespawner(particle:emit(player))
              end
            end
          end
        end
      end
    end
  end
else
  player_particles = function()
    -- no-op; player particles are disabled
  end
end

-- Particle trigger loop
core.register_globalstep(function(dtime)
  environmental_particles(dtime)
  player_particles(dtime)
end)

-- Identify target nodes and decorators
core.register_on_mods_loaded(function()
  -- Node-particle map setup
  local npmap = {}
  for decorator,_ in pairs(effervescence.decorators) do
    npmap[decorator] = {}
  end

  for node,ndef in pairs(core.registered_nodes) do
    -- Environmental particles
    for particle,pdef in pairs(effervescence.environmental_particles) do
      local decorators = pdef:applies_to(node,ndef) or {}
      for _,decorator in ipairs(decorators) do
        npmap[decorator][node] = npmap[decorator][node] or {}
        table.insert(npmap[decorator][node],particle)
      end
    end

    -- Player particles
    for particle,pdef in pairs(effervescence.player_particles) do
      pdef:applies_to(node,ndef)
    end
  end

  -- Apply particles to decorators
  for name,decorator in pairs(effervescence.decorators) do
    decorator:apply_to(npmap[name])
  end

  -- Hack for VoxelLibre/Mineclonia
  local oggcm = core.get_current_modname
  core.get_current_modname = function()
    return "effervescence"
  end

  -- Trigger decorators during mapgen
  core.register_on_generated(function(minp, maxp, blockseed)
    for name,decorator in pairs(effervescence.decorators) do
      decorator:decorate(minp, maxp, blockseed)
    end
  end)

  -- Undo hack
  core.get_current_modname = oggcm
end)