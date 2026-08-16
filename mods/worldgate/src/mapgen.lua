--
-- Worldgate mapgen
--

-- Do not register mapgen if worldgate mapgen is disabled
if not worldgate.settings.mapgen then
  return
end

-- Spawning flags
local underwaterspawn = worldgate.settings.underwaterspawn
local midairspawn = worldgate.settings.midairspawn

-- Telemosaic location hashing function
local function hash_pos(pos)
  return math.floor(pos.x + 0.5)..':'..
    math.floor(pos.y + 0.5)..':'..
    math.floor(pos.z + 0.5)
end

-- Common cached variables and functions
local vmcache = {} -- VoxelManip data cache, increases performance

local schematic_airspace = worldgate.modpath .. "/schematics/worldgate_airspace.mts"
local schematic_platform = worldgate.modpath .. "/schematics/worldgate_platform.mts"

local extender_break_chance = worldgate.settings.breakage

local quality_selector = {
  [0] = function(pcgr) -- 25% chance for tier 1 extender to be cobblestone
    return { name = (pcgr:next(1,4) == 1 and "default:cobble" or "telemosaic:extender_one"), param2 = 0 }
  end,
  function() return { name = "telemosaic:extender_one", param2 = 0 } end,
  function() return { name = "telemosaic:extender_two", param2 = 0 } end,
  function() return { name = "telemosaic:extender_three", param2 = 0 } end,
  function() return { name = "telemosaic:extender_three", param2 = 0 } end,
}

local water = {
  [minetest.get_content_id("mapgen_water_source")] = true,
  [minetest.get_content_id("mapgen_river_water_source")] = true,
}

local vn = vector.new

-- Disallowed nodes to spawn on; no prefix means group
local disallowed_nodes = {
  "leaves",
  "tree",
}
local disallowed_nodes_length = #disallowed_nodes
local disallowed_cids = {[minetest.CONTENT_AIR] = true}

minetest.register_on_mods_loaded(function()
  for node,def in pairs(minetest.registered_nodes) do
    for i = 1, disallowed_nodes_length do
      i = disallowed_nodes[i]
      if node == i or minetest.get_item_group(node,i) > 0 then
        disallowed_cids[minetest.get_content_id(node)] = true
      end
    end
  end
end)

-- Bricks to cobblestone map for quality degradation
local bricks_list = {
  "default:stonebrick",
  "stairs:stair_stonebrick",
  "stairs:stair_inner_stonebrick",
  "stairs:stair_outer_stonebrick",
  "stairs:slab_stonebrick",
}

local bricks_map = {
  ["default:stonebrick"] = "default:cobble",
  ["stairs:stair_stonebrick"] = "stairs:stair_cobble",
  ["stairs:stair_inner_stonebrick"] = "stairs:stair_inner_cobble",
  ["stairs:stair_outer_stonebrick"] = "stairs:stair_outer_cobble",
  ["stairs:slab_stonebrick"] = "stairs:slab_cobble",
}

local bricks_degrade_chance = {
  [-1] = 9,
  [0] = 42,
  [1] = 200,
}

-- Worldgate mapgen function
minetest.register_on_generated(function(minp,maxp,blockseed)
  -- Find all gates within the emerged area of the current mapchunk
  local gates = {}
  for x = 0, 4  do
    for y = 0, 4 do
      for z = 0, 4 do
        local hashed = worldgate.get_gates_for_mapblock(vn(minp.x + x * 16,minp.y + y * 16,minp.z + z * 16))
        for h = 1, #hashed do
          gates[#gates + 1] = hashed[h]
        end
      end
    end
  end

  if #gates == 0 then
    return -- no gates to generate
  end

  -- Get LVM values
  local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
  local va = VoxelArea(emin,emax)
  local ystride = va.ystride
  local zstride = va.zstride

  -- Generate the gates in this mapchunk, if any
  for gate = 1, #gates do
    gate = gates[gate]

    -- Random number generator
    local pcgr = PcgRandom(minetest.hash_node_position(gate.position))

    -- Define location variable
    local location = nil

    -- Variable for tracking location selection strategy
    local strategy = nil

    -- Set the exact position if gate is exact, else find a suitable location
    -- in the current mapchunk
    if gate.exact then
      location = gate.position
      strategy = "exact"
    else
      -- Load LVM data
      local vdata = vm:get_data(vmcache)

      -- Constrain the area to +/- 2 vertical mapblocks for more consistent and
      -- deterministic mapgen
      local mapblock = gate.position:divide(16):floor():multiply(16)
      emin = mapblock:add(vn(0,-32,0))
      emax = mapblock:add(vn(0,47,0))

      -- Function for indexing 2D heightmap array
      local function index2d(x,z) -- (portions of this function © FaceDeer 2018, licensed MIT, copied from https://github.com/minetest-mods/mapgen_helper/blob/2521562a42472271d9d761f2b1e84ead59250a14/noise_manager.lua)
        return x - minp.x +
        (maxp.x - minp.x + 1)
        *(z - minp.z)
        + 1
      end

      -- Probe heightmap for suitable location
      local heightmap = minetest.get_mapgen_object("heightmap") or {}
      for i = 1, 8 do repeat
        local randomx = pcgr:next(emin.x,emax.x)
        local randomz = pcgr:next(emin.z,emax.z)
        local heightmapy = heightmap[index2d(randomx,randomz)]

        if not heightmapy then
          break
        end

        local pos = va:index(randomx,heightmapy,randomz)
        local cid = vdata[pos]
        local above = vdata[pos + ystride]

        if cid and cid ~= minetest.CONTENT_AIR and cid ~= minetest.CONTENT_IGNORE and above and above ~= cid then
          -- Only spawn underwater if allowed
          if not underwaterspawn and (water[cid] or water[above]) then
            break
          end

          -- Check for valid space above
          for ypos = pos + ystride * 2, pos + ystride * 10, ystride do
            local ydata = vdata[ypos]
            if not ydata or ydata == minetest.CONTENT_IGNORE or (not underwaterspawn and water[ydata]) then
              break
            end
          end

          -- A valid location was found on the heightmap
          location = vn(randomx,heightmapy,randomz)
          strategy = "heightmap"
          i = 10 -- break outer loop
        end
      until true end

      -- If no heightmap location found, then generate on a random node under air
      if not location then
        local air, nodecount = minetest.find_nodes_in_area(emin,emax,"air")
        local nair = nodecount.air
        for i = 1, math.min(nair,8) do
          local pos = va:indexp(air[pcgr:next(1,nair)])
          while disallowed_cids[vdata[pos]] do
            pos = pos - ystride -- probe downwards until we find something that isn't air
          end
          if vdata[pos] and vdata[pos] ~= minetest.CONTENT_IGNORE then
            location = va:position(pos)
            strategy = "grounded"
            break
          end
        end
      end

      -- If mapchunk is completely solid or empty, then generate in a random location
      if not location then
        for i = 1, 8 do
          local randomx = pcgr:next(emin.x,emax.x)
          local randomy = pcgr:next(emin.y,emax.y)
          local randomz = pcgr:next(emin.z,emax.z)

          -- Only spawn in midair or underwater if allowed
          local pos = va:indexp(vn(randomx,randomy,randomz))
          for ypos = pos, pos + ystride * 11, ystride do
            local ydata = vdata[ypos]
            if ydata and ydata ~= minetest.CONTENT_IGNORE and (underwaterspawn or not water[ydata]) and (ypos == pos and (midairspawn or ydata ~= minetest.CONTENT_AIR) or true) then
              location = va:position(pos)
              strategy = "random"
              break
            end
          end
        end
      end

      -- Fail if no suitable location found
      if not location then
        -- Trigger failure callbacks
        for c = 1, #worldgate.worldgate_failed_callbacks do
          worldgate.worldgate_failed_callbacks[c](gate)
        end
        return -- cannot generate this worldgate
      end

      -- Adjust location by y + 1
      location = location:add(vn(0,1,0))
    end

    -- Place airspace
    minetest.place_schematic_on_vmanip(vm,location,schematic_airspace,"90",nil,true,"place_center_x,place_center_z")

    -- Place platform
    minetest.place_schematic_on_vmanip(vm,location:add(vn(0,-8,0)),schematic_platform,"random",nil,true,"place_center_x,place_center_z")

    -- Place base
    minetest.place_schematic_on_vmanip(vm,location,gate.base,"random",nil,false,"place_center_x,place_center_z")

    -- Place decor
    minetest.place_schematic_on_vmanip(vm,location:add(vn(0,3,0)),gate.decor,"random",nil,false,"place_center_x,place_center_z")

    -- Update liquids
    vm:update_liquids()

    -- Write back to LVM
    vm:write_to_map()

    -- Process extenders based on gate quality
    for _,epos in ipairs(minetest.find_nodes_in_area(location:add(vn(-6,0,-6)),location:add(vn(6,3,6)),"group:worldgate_extender")) do
      if pcgr:next(1,100) <= extender_break_chance then -- chance for any extender to be broken
        minetest.swap_node(epos,{ name = "default:cobble", param2 = 0 })
      else
        minetest.swap_node(epos,quality_selector[minetest.get_item_group(minetest.get_node(epos).name,"worldgate_extender") + gate.quality](pcgr))
      end
    end

    -- Replace bricks with cobblestone based on gate quality
    local bricks = minetest.find_nodes_in_area(location:add(vn(-6,0,-6)),location:add(vn(6,13,6)),bricks_list)
    local brick_degrade_chance = bricks_degrade_chance[gate.quality]
    for _,brick in ipairs(bricks) do
      if pcgr:next(1,brick_degrade_chance) == 1 then
        local brick_node = minetest.get_node(brick)
        local cobble_node = bricks_map[brick_node.name]
        if cobble_node then
          minetest.swap_node(brick,{ name = cobble_node, param2 = brick_node.param2 })
        end
      end
    end

    -- Write the gate's position to the beacon's node meta for linking purposes if possible
    local beacon = (function()
      for dy = 2, 0, -1 do
        local beacon_location = location:add(vn(0,dy,0))
        local beacon_node = minetest.get_node(beacon_location)
        if beacon_node and beacon_node.name:find("^telemosaic:beacon") then
          return beacon_location
        end
      end
    end)()

    if beacon then
      local nodemeta = minetest.get_meta(beacon)
      nodemeta:set_string("worldgate:source",minetest.pos_to_string(gate.position))
      if gate.destination then
        nodemeta:set_string("worldgate:destination",minetest.pos_to_string(gate.destination))
        minetest.swap_node(beacon,{ name = "telemosaic:beacon", param2 = 0 })
      end
    else
      minetest.log("warning","Unable to set beacon node meta for worldgate at " .. minetest.pos_to_string(location))
    end

    -- Fix lighting
    minetest.fix_light(location:add(vn(-6,-8,-6)),location:add(vn(6,11,6)))

    -- Trigger callbacks
    for c = 1, #worldgate.worldgate_generated_callbacks do
      worldgate.worldgate_generated_callbacks[c](location,gate,strategy)
    end
  end
end)