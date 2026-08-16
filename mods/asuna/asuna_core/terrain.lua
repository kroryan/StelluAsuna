--[[
	Boulders
	- Should be registered before surface/terrain overrides
]]

local function boulder(name,seed,nodes)
  minetest.register_decoration({
    deco_type = "schematic",
    place_on = nodes,
    fill_ratio = 0.00000000000000001,
    y_min = 2,
    y_max = 31000,
    flags = "force_placement,place_center_x,place_center_z",
    schematic = asuna.modpath .. "/schematics/boulders/" .. name .. ".mts",
    rotation = "random",
    place_offset_y = 0
  })
end

local seed = 90210

for _,name in ipairs({
  "cobblestone_boulder_small",
  "cobblestone_boulder_medium",
}) do
  boulder(name,seed,{
    "default:dirt_with_dry_grass",
    "default:dry_dirt_with_dry_grass",
    "default:dirt_with_snow",
    "naturalbiomes:savannalitter",
  })
  seed = seed + 13
end

for _,name in ipairs({
  "mossy_cobblestone_boulder_small",
  "mossy_cobblestone_boulder_medium",
}) do
  boulder(name,seed,{
    "default:dirt_with_grass",
    "default:dirt_with_coniferous_litter",
    "ethereal:grove_dirt",
    "naturalbiomes:alpine_litter",
    "naturalbiomes:heath_litter",
    "naturalbiomes:heath_litter2",
    "naturalbiomes:heath_litter3",
  })
  seed = seed + 17
end

for _,name in ipairs({
  "desert_boulder_small",
  "desert_boulder_medium",
}) do
  boulder(name,seed,{
    "default:desert_sand",
    "default:sandstone",
  })
  seed = seed + 19
end

--[[
  Terrain changes
  - Sweeping terrain changes that must be made before decorations are placed
]]

-- Special decoration handling
local mtrd = minetest.register_decoration
minetest.register_decoration = function(def)
	-- Set all_floors for all surface decorations
  local flags = def.flags or ""
  if not (flags:find("all_") or flags:find("liquid_")) then
    def.flags = #flags > 0 and (flags .. ",all_floors") or "all_floors"
  end

	-- Set negative y_min for select surface decorations
	if def.y_min == 1 and def.y_max and def.y_max > 1 and def.deco_type == "simple" then
		def.y_min = -20
	end

	-- Ensure spawning in water for underwater decorations
	if def.y_max and def.y_max < 1 and not def.spawn_by and (def.place_on == "default:sand" or def.place_on[1] == "default:sand") then
		def.spawn_by = "default:water_source"
		def.num_spawn_by = 1
	end

	-- Return original register_decoration call
  return mtrd(def)
end

-- Surface nodes that should be propagated through surface stone
local surface_spread = {
  "default:dirt_with_grass",
  "default:dry_dirt_with_dry_grass",
  "default:dirt_with_dry_grass",
  "default:dirt_with_rainforest_litter",
  "default:dirt_with_coniferous_litter",
  "naturalbiomes:savannalitter",
  "naturalbiomes:alpine_litter",
  "naturalbiomes:mediterran_litter",
  "naturalbiomes:alderswamp_litter",
  "naturalbiomes:outback_litter",
  "ethereal:grove_dirt",
  "ethereal:bamboo_dirt",
  "livingjungle:jungleground",
  "livingjungle:leafyjungleground",
  "ethereal:mushroom_dirt",
  "nightshade:nightshade_dirt_with_grass",
  "japaneseforest:japanese_dirt_with_grass",
  "bambooforest:dirt_with_bamboo",
  "dorwinion:dorwinion_grass",
  "badland:badland_grass",
  "frost_land:frost_land_grass",
  "prairie:prairie_dirt_with_grass",
  "everness:dirt_with_crystal_grass",
  "everness:dirt_with_cursed_grass",
  "everness:dirt_with_coral_grass",
  "ethereal:gray_dirt",
  "naturalbiomes:heath_litter",
  "naturalbiomes:bushland_bushlandlitter",
  "naturalbiomes:bushland_bushlandlitter2",
  "naturalbiomes:bushland_bushlandlitter3",
}

-- Replace some surface stone with grass; also causes some biome ingress into caves
for _,node in ipairs(surface_spread) do
  minetest.register_decoration({
    deco_type = "simple",
    place_on = {
      "group:stone",
      "default:stone_with_coal",
      "default:dirt",
      "default:silver_sand",
      "default:gravel",
      "everness:coral_desert_stone_with_coal",
      "everness:cursed_stone_carved_with_coal",
      "everness:crystal_stone_with_coal",
    },
    spawn_by = node,
    num_spawn_by = 1,
    sidelen = 4,
    y_min = 3,
    y_max = 31000,
    place_offset_y = -1,
    fill_ratio = 10,
    decoration = node,
    flags = "force_placement",
  })
end

-- Ocean floor nodes that should be replaced with proper ocean floor
local ocean_floor_replace = {
  "group:stone",
  "default:stone_with_coal",
  "everness:quartz_ore",
  "default:dirt",
  "default:dry_dirt",
  "default:gravel",
  "default:silver_sand",
  "default:dirt_with_grass",
  "default:dry_dirt_with_dry_grass",
  "default:dirt_with_dry_grass",
  "default:dirt_with_rainforest_litter",
  "default:dirt_with_coniferous_litter",
  "naturalbiomes:savannalitter",
  "naturalbiomes:alpine_litter",
  "naturalbiomes:mediterran_litter",
  "naturalbiomes:alderswamp_litter",
  "naturalbiomes:outback_litter",
  "ethereal:grove_dirt",
  "ethereal:bamboo_dirt",
  "livingjungle:jungleground",
  "livingjungle:leafyjungleground",
  "ethereal:mushroom_dirt",
  "nightshade:nightshade_dirt_with_grass",
  "japaneseforest:japanese_dirt_with_grass",
  "bambooforest:dirt_with_bamboo",
  "dorwinion:dorwinion_grass",
  "badland:badland_grass",
  "frost_land:frost_land_grass",
  "prairie:prairie_dirt_with_grass",
  "everness:dirt_with_crystal_grass",
  "everness:dirt_with_cursed_grass",
  "everness:coral_desert_stone_with_coal",
  "everness:cursed_stone_carved_with_coal",
  "everness:cursed_stone",
  "everness:crystal_stone_with_coal",
}

-- Ocean floor generation function
local function register_ocean_floor(name)
  -- Get above and shore biome names
  local above = name:sub(1,-7) -- to trim "_below" from the end of the biome name
  local shore = above .. "_shore"

  -- Get biome
  local biome = asuna.biomes[name]

  -- Register shore ocean floor terrain
  minetest.register_decoration({
    deco_type = "schematic",
    place_on = ocean_floor_replace,
    sidelen = 80,
    fill_ratio = 10, -- fill all
    biomes = {name,shore,above},
    y_max = 0,
    y_min = 0,
    decoration = "default:stone",
    spawn_by = "default:water_source",
    num_spawn_by = 1,
    place_offset_y = -1,
    flags = "all_floors,force_placement",
    schematic = {
      size = {
        x = 1,
        y = 2,
        z = 1,
      },
      data = {
        { name = "default:stone" , param1 = 255 , param2 = 0 },
        { name = biome.seabed , param1 = 255 , param2 = 0 },
      },
    },
  })

  -- Register ocean floor terrain
  minetest.register_decoration({
    deco_type = "schematic",
    place_on = ocean_floor_replace,
    sidelen = 80,
    fill_ratio = 10, -- fill all
    biomes = {name,shore,above},
    y_max = -1,
    y_min = -10,
    decoration = "default:stone",
    spawn_by = "default:water_source",
    num_spawn_by = 1,
    place_offset_y = -3,
    flags = "all_floors,force_placement",
    schematic = {
      size = {
        x = 1,
        y = 4,
        z = 1,
      },
      data = {
        { name = "default:stone" , param1 = 255 , param2 = 0 },
        { name = biome.seabed , param1 = 255 , param2 = 0 },
        { name = biome.seabed , param1 = 255 , param2 = 0 },
        { name = biome.seabed , param1 = 255 , param2 = 0 },
      },
    },
  })

    -- Register deep ocean floor terrain
    minetest.register_decoration({
      deco_type = "schematic",
      place_on = ocean_floor_replace,
      sidelen = 80,
      fill_ratio = 10, -- fill all
      biomes = {name,shore,above},
      y_max = -11,
      y_min = -36,
      decoration = "default:stone",
      spawn_by = "default:water_source",
      num_spawn_by = 1,
      place_offset_y = -3,
      flags = "all_floors,force_placement",
      schematic = {
        size = {
          x = 1,
          y = 4,
          z = 1,
        },
        data = {
          { name = "default:stone" , param1 = 255 , param2 = 0 },
          { name = biome.deep_seabed , param1 = 255 , param2 = 0 },
          { name = biome.deep_seabed , param1 = 255 , param2 = 0 },
          { name = biome.deep_seabed , param1 = 255 , param2 = 0 },
        },
      },
    })

  -- Replace underwater surface nodes below sea level
  minetest.register_decoration({
    deco_type = "schematic",
    place_on = surface_spread,
    spawn_by = {
      "default:sand",
      "default:water_source",
    },
    num_spawn_by = 1,
    sidelen = 4,
    y_max = 0,
    y_min = -10,
    place_offset_y = -3,
    fill_ratio = 10,
    biomes = {name,shore,above},
    schematic = {
      size = {
        x = 1,
        y = 4,
        z = 1,
      },
      data = {
        { name = "default:stone" , param1 = 255 , param2 = 0 },
        { name = biome.seabed , param1 = 255 , param2 = 0 },
        { name = biome.seabed , param1 = 255 , param2 = 0 },
        { name = biome.seabed , param1 = 255 , param2 = 0 },
      },
    },
    flags = "all_floors,force_placement",
  })
end

-- Generate ocean floor terrain
local seed = 124
for _,biome in ipairs(asuna.biome_groups.below) do
  register_ocean_floor(biome)
end

-- Maximum pool limits
local limits = {
  MAX_SCAN_DISTANCE = 3,
  MAX_DEPTH = 2,
  MAX_AREA = 89,
}

-- Relevant content IDs
local cids = nil
minetest.register_on_mods_loaded(function() -- load after mapgen aliases are defined
  cids = {
    lava = minetest.get_content_id("mapgen_lava_source"),
    water = minetest.get_content_id("mapgen_water_source"),
    air = minetest.CONTENT_AIR,
    ignore = minetest.CONTENT_IGNORE,
  }
end)

-- Array of flammable nodes to be avoided when placing lava along with invalid
-- pool edge nodes
local is_flammable = {}
local is_invalid = {
  [minetest.CONTENT_AIR] = true
}
minetest.register_on_mods_loaded(function()
	for node,def in pairs(minetest.registered_nodes) do
		if def.groups and def.groups.flammable and def.groups.flammable > 0 then
			is_flammable[minetest.get_content_id(node)] = true
			is_invalid[minetest.get_content_id(node)] = true
    elseif def.floodable
      or def.drawtype == "airlike"
      or def.drawtype == "liquid"
      or def.drawtype == "flowingliquid"
      or def.buildable_to
      or def.walkable == false
      or (def.groups and def.groups.not_in_creative_inventory and def.groups.not_in_creative_inventory > 0)
      or node:find("_marker") -- mapgen marker names used by some mods
    then
			is_invalid[minetest.get_content_id(node)] = true
		end
	end
end)

-- States that liquid pool nodes can be in
local nodestate = {
  -- Invalid states
  OUT_OF_BOUNDS = 128, -- outside of voxelarea or ignore nodes
  INVALID = 64, -- nodes that cannot be part of a pool or pool borders
  UNSATISFIABLE = 32, -- pool nodes that cannot be filled with liquid
  MASK_INVALID = 128 + 64 + 32, -- combination of invalid states

  -- Single nodes above the pool to be replaced with air
  ERASE = 16, -- surface nodes that have been flagged for erasure of nodes above
  MASK_ERASURE = 16 + 64, -- nodes that will be erased if the pool is generated

  -- Directions
  POSITIVE_Z = 8,
  POSITIVE_X = 4,
  NEGATIVE_Z = 2,
  NEGATIVE_X = 1,
  MASK_SATISFIED = 8 + 4 + 2 + 1, -- combination of all directions

  -- Blank state
  NONE = 0,
}

-- Monotonic map-like pool 'class' to track nodes and node states
local function Pool()
  local nodemap = {}
  local node_iterator = {} -- for fast, ordered, deterministic iteration
  local size = 0
  local scan_queue = {} -- for collecting non-terminated nodes to be scanned
  return {
    add = function(node,state)
      nodemap[node] = state
      table.insert(node_iterator,node)
      size = size + 1
      return state
    end,
    put = function(node,state)
      nodemap[node] = state
      return state
    end,
    get = function(node)
      return nodemap[node]
    end,
    foreach = function(start,fn)
      for i = start, size do
        if not fn(node_iterator[i]) then
          return false
        end
      end
      return true
    end,
    size = function()
      return size
    end,
  }
end

-- Register advanced decoration
abdecor.register_advanced_decoration("asuna_cave_pools",{
  target = {
    sidelen = 80,
    fill_ratio = 0.0000925,
    place_on = {
      "group:stone",
      "group:soil",
      "default:clay",
      "default:stone_with_coal_ore",
      "default:stone_with_iron_ore",
      "default:sand",
      "default:silver_sand",
      "default:desert_sand",
      "default:gravel",
      "default:coalblock",
      "caverealms:coal_dust",
      "everness:moss_block",
      "everness:forsaken_desert_sand",
      "everness:crystal_moss_block",
      "everness:emerald_ice",
      "everness:ancient_emerald_ice",
      "everness:dense_emerald_ice",
      "everness:frosted_ice",
      "everness:frosted_ice_translucent",
      "caverealms:stone_with_moss",
      "caverealms:stone_with_lichen",
      "caverealms:stone_with_algae",
      "caverealms:stone_with_salt",
      "caverealms:hot_cobble",
    },
    y_max = -36,
    y_min = -31000,
    flags = "all_floors",
  },
  fn = function(mapgen)
    -- Get provided values
    local va = mapgen.voxelarea
    local vdata = mapgen.data
    local pos = mapgen.pos

    -- Get stride values and set position
    local ystride = va.ystride
    local zstride = va.zstride
    local pos = va:index(pos.x,pos.y,pos.z)

    -- Determine pool liquid based on climate
    -- Dry/hot climates are more likely to be lava, vice-versa with water
    local liquid = (function()
      local heatmap = minetest.get_mapgen_object("heatmap") or {}
      local humiditymap = minetest.get_mapgen_object("humiditymap") or {}
      local pos2d = mapgen.index2d(mapgen.pos)
      local heat = heatmap[pos2d] or 50
      local humidity = humiditymap[pos2d] or 50
      local climate = 50 + (heat / 2 - 25) - (humidity / 2 - 25)
      local pos_random = PcgRandom(mapgen.seed):next(-29,29) + climate
      return pos_random > 50 and cids.lava or cids.water
    end)()

    -- Create new pool for nodes
    local pool = Pool()

    -- VoxelManip offset lookup by direction
    local adjacent = {
      [nodestate.POSITIVE_X] = 1,
      [nodestate.POSITIVE_Z] = zstride,
      [nodestate.NEGATIVE_X] = -1,
      [nodestate.NEGATIVE_Z] = -zstride,
    }

    -- Recursive scanning function
    local function scan(node,direction,distance,depth)
      -- Get the node's state if it exists, else initialize it based on depth
      -- and pool size limit
      local state = pool.get(node) or pool.add(node,(function()
        if depth == 1 and pool.size() > limits.MAX_AREA then
          if is_invalid[vdata[node]] then
            return nodestate.INVALID
          else
            return nodestate.UNSATISFIABLE
          end
        else
          return nodestate.NONE
        end
      end)())

      -- Return if this node is already in an invalid state
      if state > 31 then
        return bit.band(state,nodestate.MASK_INVALID)
      end

      -- Return if this node is already satisfied in the given direction
      if bit.band(state,direction) ~= 0 then
        return direction
      end

      -- Check if this node is out of bounds
      local content = vdata[node]
      if content == nil or content == cids.ignore then
        return nodestate.OUT_OF_BOUNDS
      end

      -- Check the validity of this node
      if is_invalid[content] then
        return pool.put(node,nodestate.INVALID)
      end

      -- Return unsatisfiable if the node below is invalid
      if is_invalid[vdata[node - ystride]] then
        return pool.put(node,nodestate.UNSATISFIABLE)
      end

      -- Return solution if this node is beyond the max scan distance
      if distance > limits.MAX_SCAN_DISTANCE then
        return direction
      end

      -- Checks based on depth
      local above = node + ystride
      if depth == 1 then
        -- Flag nodes above for erasure if the node above is solid and the node
        -- above that is air, but this node is unsatisfiable if both the node
        -- above and the node above that are solid
        if bit.band(state,nodestate.ERASE) == 0 and vdata[above] ~= cids.air then
          local above2 = above + ystride
          if vdata[above2] == cids.air then
            pool.add(above,nodestate.MASK_ERASURE)
          else
            -- Do not generate lava pools around flammable nodes that won't be
            -- erased
            if liquid == cids.lava and (is_flammable[vdata[above]] or is_flammable[vdata[above2]]) then
              return nodestate.OUT_OF_BOUNDS
            else
              return pool.put(node,nodestate.UNSATISFIABLE)
            end
          end
          state = bit.bor(state,nodestate.ERASE) -- flag this node as already having been checked for erasure
        end
      else
        -- At non-surface depths, the node above must have been fully satisfied
        -- in a previous scan
        if bit.band(pool.get(above) or nodestate.NONE,nodestate.MASK_SATISFIED) ~= nodestate.MASK_SATISFIED then
          return pool.put(node,nodestate.INVALID)
        end
      end

      -- Scan neighbor in the given direction
      local neighbor = node + adjacent[direction]
      local nstate = scan(neighbor,direction,distance + 1,depth)

      -- Return the direction if the neighbor is satisfied in the given direction
      if nstate == direction or nstate == nodestate.UNSATISFIABLE then
        pool.put(node,bit.bor(state,direction))
        return direction
      end

      -- If neighbor is out of bounds, then the entire pool is invalid
      if nstate == nodestate.OUT_OF_BOUNDS then
        return nodestate.OUT_OF_BOUNDS
      end

      -- If neighbor is invalid, then this node is unsatisfiable
      if nstate == nodestate.INVALID then
        return pool.put(node,nodestate.UNSATISFIABLE)
      end
    end

    -- Initialize pool with the target position and perform the scan
    for depth = 1, limits.MAX_DEPTH do
      pool.add(pos - (depth - 1) * ystride,nodestate.NONE)
      local scan_count = 4 -- each of four -/+ x/z directions
      local i = 0
      local scan_start = pool.size() -- optimization to skip nodes from prior scans
      while i < scan_count do
        local previous_size = pool.size()
        local direction = bit.lshift(1,i % 4) -- cycle through directions
        if not pool.foreach(scan_start,function(node)
          return scan(node,direction,1,depth) ~= nodestate.OUT_OF_BOUNDS -- stop scanning immediately if out of bounds
        end) then
          return -- cannot render out of bounds pools
        end
        if pool.size() > previous_size then
          scan_count = scan_count + 1 -- new nodes need additional scans
        end
        i = i + 1
      end
    end

    -- Fill the pool and erase nodes above
    pool.foreach(1,function(node)
      local state = pool.get(node)
      if bit.band(state,nodestate.MASK_SATISFIED) == nodestate.MASK_SATISFIED then
        vdata[node] = liquid
      elseif state == nodestate.MASK_ERASURE then
        vdata[node] = cids.air
      end
      return true
    end)
  end,
})

--[[
  Schematics
  - Placed before other biome mods in order to mitigate interference from trees, etc.
]]

local mpath = minetest.get_modpath("asuna_core")

-- Haunted house
minetest.register_decoration({
  name = "asuna_core:everness_haunted_house_badland",
  deco_type = 'schematic',
  place_on = "badland:badland_grass",
  spawn_by = "badland:badland_grass",
  num_spawn_by = 8,
  sidelen = 80,
  fill_ratio = 0.0000175,
  biomes = "badland",
  y_max = 31000,
  y_min = 7,
  place_offset_y = -1,
  schematic = mpath .. '/schematics/everness/everness_haunted_house_badland.mts',
  rotation = "random",
  flags = 'place_center_x,place_center_z,force_placement',
})

-- Jungle temple
minetest.register_decoration({
  name = "asuna_core:everness_jungle_temple_new",
  deco_type = 'schematic',
  place_on = "group:soil",
  spawn_by = "group:soil",
  num_spawn_by = 8,
  sidelen = 80,
  fill_ratio = 0.0000275,
  biomes = {
    "rainforest",
    "livingjungle:jungle",
  },
  y_max = 31000,
  y_min = 8,
  place_offset_y = -3,
  schematic = mpath .. '/schematics/everness/everness_jungle_temple_new.mts',
  rotation = "random",
  flags = 'place_center_x,place_center_z,force_placement',
})

-- Japanese shrine
minetest.register_decoration({
  name = "asuna_core:everness_japanese_shrine_new",
  deco_type = 'schematic',
  place_on = "group:soil",
  spawn_by = "group:soil",
  num_spawn_by = 7,
  sidelen = 80,
  fill_ratio = 0.0000175,
  biomes = {
    "bamboo",
    "japaneseforest",
  },
  y_max = 31000,
  y_min = 8,
  place_offset_y = -1,
  schematic = mpath .. '/schematics/everness/everness_japanese_shrine_new.mts',
  rotation = "random",
  flags = 'place_center_x,place_center_z,force_placement',
})

-- Populate chests with loot
local asuna_core_everness_dids = {}
for _,decoration in ipairs({
  "asuna_core:everness_haunted_house_badland",
  "asuna_core:everness_jungle_temple_new",
  "asuna_core:everness_japanese_shrine_new",
}) do
  local did = minetest.get_decoration_id(decoration)
  minetest.set_gen_notify({decoration = true},{did})
  asuna_core_everness_dids["decoration#" .. did] = true
end

minetest.register_on_generated(function(minp,maxp)
  if maxp.y > 4 then
    local gennotify = minetest.get_mapgen_object("gennotify")
    for decoration_id,decorations in pairs(gennotify) do
      if asuna_core_everness_dids[decoration_id] then
        local chest_positions = minetest.find_nodes_in_area(minp,maxp,{ 'everness:chest' })
        if #chest_positions > 0 then
          Everness:populate_loot_chests(chest_positions)
        end
        return
      end
    end
  end
end)