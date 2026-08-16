-- --------- --
--  GLOBALS  --
-- --------- --

dungeonsplus = {
  modpath = core.get_modpath("dungeonsplus"),
  settings = {
    use_native = core.settings:get_bool("dungeonsplus.use_native",true),
    allow_exposed_decoration = core.settings:get_bool("dungeonsplus.allow_exposed_decoration",false),
    allow_submerged_decoration = core.settings:get_bool("dungeonsplus.allow_submerged_decoration",false),
  },
  dependencies = (function()
    local deps = {}
    for _,dep in ipairs({
      "dungeon_loot",
      "default",
      "ethereal",
      "bottles",
      "bottles_default",
      "stairs",
      "farming",
      "walls",
      "vessels",
      "fireflies",
      "flowers",
      "xpanes",
      "bones",
      "too_many_stones",
      "bonemeal",
    }) do
      deps[dep] = core.get_modpath(dep)
    end
    return deps
  end)(),
  features = {},
}

-- ---------------------- --
--  DISABLE DUNGEON_LOOT  --
-- ---------------------- --

if dungeonsplus.dependencies.dungeon_loot then
  dungeon_loot.CHESTS_MIN = 0
  dungeon_loot.CHESTS_MAX = 0
  dungeon_loot.registered_loot = {}
  dungeon_loot.register = function() end
end

-- ----------------- --
--  DUNGEON MAPPING  --
-- ----------------- --

local mgdungeons = core.settings:get("mg_flags"):find("dungeons") and true or false
local function noop() end

local surfaces = {
  floor = true,
  wall = true,
  ceiling = true,
}

dungeonsplus.register_dungeon_feature = mgdungeons and function(feature)
  -- Check for valid name
  if not feature.name or type(feature.name) ~= "string" or #feature.name < 1 then
    return false
  end

  -- Check for valid surfaces
  if not feature.surfaces then
    return false
  elseif type(feature.surfaces) == "string" then
    if not surfaces[feature.surfaces] then
      return false
    else
      feature.surfaces = { feature.surfaces }
      feature.surfaces[feature.surfaces[1]] = true
    end
  elseif type(feature.surfaces) == "table" then
    if #feature.surfaces < 1 then
      return false
    else
      for _,surface in ipairs(feature.surfaces) do
        if not surfaces[surface] then
          return false
        else
          feature.surfaces[surface] = true
        end
      end
    end
  else
    return false
  end

  -- Set defaults for optional fields
  feature.weight = feature.weight or 1
  feature.conditions = feature.conditions or {}
  feature.conditions.room = feature.conditions.room or {}
  feature.conditions.features = feature.conditions.features or {}
  feature.conditions.mods = feature.conditions.mods or {}
  feature.conditions.generic = feature.conditions.generic or {}
  feature.generate = feature.generate or function() return true end

  -- Check loaded mod conditions which cannot change after startup
  for _,condition in ipairs(feature.conditions.mods) do
    local satisfied = false
    for mod,path in pairs(dungeonsplus.dependencies) do
      if condition(mod,path) then
        satisfied = true
        break
      end
    end
    if not satisfied then
      return false
    end
  end

  -- Register feature
  table.insert(dungeonsplus.features,feature)
  return true
end or noop

-- Get notified for dungeons
core.set_gen_notify({ dungeon = true })

-- Map dungeons and add metadata
local vz = vector.zero
local cids = {
  air = core.CONTENT_AIR,
}

local liquid = {}
core.register_on_mods_loaded(function()
  for node,def in pairs(core.registered_nodes) do
    if def.liquidtype ~= "none" then
      liquid[core.get_content_id(node)] = true
    end
  end
end)

-- VoxelManip cache
local vdata = {}
local vparam2 = {}

-- Weighted feature lookup cache
local fcache = {}
local ntable = {}
for i = 1, 200 do
  table.insert(fcache,ntable)
end

core.register_on_generated(mgdungeons and function(minp, maxp, blockseed)
  -- Return if required gennotify isn't present
  local gennotify = core.get_mapgen_object("gennotify")

  if not gennotify or not gennotify.dungeon or #gennotify.dungeon < 1 then
    return
  end

  -- Get useful mapgen values
  local vm, emin, emax = core.get_mapgen_object("voxelmanip")
  local va = VoxelArea(emin,emax)
  local ystride = va.ystride
  local zstride = va.zstride
  local pcgr = PcgRandom(blockseed)

  -- Get VoxelManip data
  vm:get_data(vdata)
  vm:get_param2_data(vparam2)

  -- Map dungeon rooms in the current chunk
  for _,dungeon in ipairs(gennotify.dungeon or {}) do repeat
    local pos = va:indexp(dungeon)
    local room = {
      pos = dungeon,
      min = vz(),
      max = vz(),
      enclosed = {
        x = true,
        y = true,
        z = true,
      },
      submerged = false,
    }

    if liquid[vdata[pos - va.ystride]] then
      break -- do not generate rooms on liquid pools
    end

    -- Get dungeon biome/climate data
    local biome = core.get_biome_data(dungeon)
    room.biome = core.get_biome_name(biome.biome)
    room.heat = biome.heat
    room.humidity = biome.humidity

    -- Get room dimensions
    local dimensions = {
      x = {
        min = {
          vector = room.min,
          direction = -1,
          scan = { -zstride + ystride, ystride, 0, zstride + ystride, ystride * 2 },
          distance = 9,
        },
        max = {
          vector = room.max,
          direction = 1,
          scan = { -zstride + ystride, ystride, 0, zstride + ystride, ystride * 2 },
          distance = 9,
        },
      },
      y = {
        min = {
          vector = room.min,
          direction = -ystride,
          scan = { 0 },
          distance = 4,
        },
        max = {
          vector = room.max,
          direction = ystride,
          scan = { 0 },
          distance = 16,
        },
      },
      z = {
        min = {
          vector = room.min,
          direction = -zstride,
          scan = { -1 + ystride, ystride, 0, 1 + ystride, ystride * 2 },
          distance = 9,
        },
        max = {
          vector = room.max,
          direction = zstride,
          scan = { -1 + ystride, ystride, 0, 1 + ystride, ystride * 2 },
          distance = 9,
        },
      },
    }

    for dimension,mm in pairs(dimensions) do
      for _,bearing in pairs(mm) do
        local scanned = false
        for i = bearing.direction, bearing.distance * bearing.direction, bearing.direction do
          for _,offset in ipairs(bearing.scan) do
            local cid = vdata[pos + i + offset]
            if cid ~= cids.air and not liquid[cid] then
              bearing.vector[dimension] = dungeon[dimension] + (i / math.abs(bearing.direction))
              scanned = true
              break
            elseif liquid[cid] then
              room.submerged = true
            end
          end
          if scanned then
            break
          end
        end
        if not scanned then
          core.log("verbose","[dungeonsplus] failed scan at " .. core.pos_to_string(dungeon) .. ": dimension = " .. dimension)
          room.enclosed[dimension] = false
          bearing.vector[dimension] = dungeon[dimension]
        end
      end
    end

    -- Skip non-enclosed rooms under certain conditions
    if not (room.enclosed.x and room.enclosed.y and room.enclosed.z) then
      if not dungeonsplus.settings.allow_submerged_decoration and room.submerged then
        core.log("action","[dungeonsplus] skipping submerged dungeon room at " .. core.pos_to_string(dungeon))
        break
      end
      if not dungeonsplus.settings.allow_exposed_decoration and (core.get_natural_light(dungeon,0.5) or 0) > 0 then
        core.log("action","[dungeonsplus] skipping exposed dungeon room at " .. core.pos_to_string(dungeon))
        break
      end
    end

    -- Decorate room with features
    local features = {}
    local has_feature = {
      floor = false,
      wall = false,
      ceiling = false,
    }

    -- Decorate each surface and make multiple attempts to decorate each surface
    for _,surface in ipairs({
      "floor",
      "wall",
      "ceiling",
    }) do
      local invalid_features = {}
      for i = 1, 3 do
        -- Get features that are valid for the room
        local candidates = 0
        for _,feature in ipairs(dungeonsplus.features) do repeat
          -- Do not add features to surfaces that are already decorated
          local decorated = false
          for surface,flag in pairs(has_feature) do
            if flag and feature.surfaces[surface] then
              decorated = true
              break
            end
          end

          if decorated then
            break
          end

          -- Do not attempt to generate features that already failed to generate
          if invalid_features[feature.name] then
            break
          end

          -- Test feature for proper conditions
          local conditions = feature.conditions
          local satisfied = {
            room = #(conditions.room),
            features = #(conditions.features),
            generic = #(conditions.generic),
          }

          for _,condition in ipairs(conditions.room) do
            if condition(room) then
              satisfied.room = satisfied.room - 1
            else
              break
            end
          end

          for _,condition in ipairs(satisfied.room == 0 and conditions.features or {}) do
            local pass
            for _,feature in ipairs(features) do
              pass = condition(feature)
              if pass then
                satisfied.features = satisfied.features - 1
                break
              end
            end
            if not pass then
              break
            end
          end

          for _,condition in ipairs(satisfied.features == 0 and conditions.generic or {}) do
            if condition() then
              satisfied.generic = satisfied.generic - 1
            else
              break
            end
          end

          -- Add candidate feature if all conditions are met
          if (satisfied.room + satisfied.features + satisfied.generic) == 0 then
            for i = 1, feature.weight do
              candidates = candidates + 1
              fcache[candidates] = feature
            end
          end
        until true end

        -- Give up on the surface if there are no candidate features
        if candidates == 0 then
          break
        end

        -- Get a random feature
        local feature = fcache[pcgr:next(1,candidates)]

        -- Generate feature
        core.log("verbose","[dungeonsplus] generating " .. feature.name .. " at " .. core.pos_to_string(dungeon))
        if feature.generate({
          vm = vm,
          va = va,
          vdata = vdata,
          vparam2 = vparam2,
          room = room,
          features = features,
          blockseed = blockseed,
        }) then
          -- Mark all feature surfaces
          for _,surface in ipairs(feature.surfaces) do
            has_feature[surface] = true
          end

          -- Capture generated feature
          table.insert(features,feature)

          -- Log successful generation
          core.log("action","[dungeonsplus] generated " .. feature.name .. " at " .. core.pos_to_string(dungeon))

          -- Break retry loop
          break
        else
          invalid_features[feature.name] = true
          core.log("verbose","[dungeonsplus] failed to generate " .. feature.name .. " at " .. core.pos_to_string(dungeon))
        end
      end
    end
  until true end

  -- Write data back to VoxelManip
  vm:set_data(vdata)
  vm:set_param2_data(vparam2)
  vm:calc_lighting()
  vm:write_to_map(true)
end or noop)

-- ------------------ --
--  DUNGEON FEATURES  --
-- ------------------ --

if mgdungeons and dungeonsplus.settings.use_native then
  for _,file in ipairs(core.get_dir_list(dungeonsplus.modpath .. "/features",false)) do
    local feature = dofile(dungeonsplus.modpath .. "/features/" .. file) or { name = file }
    if dungeonsplus.register_dungeon_feature(feature) then
      core.log("action","[dungeonsplus] registered feature " .. feature.name)
    else
      core.log("warn","[dungeonsplus] could not register feature " .. feature.name)
    end
  end
end