-- Get relevant content ID's
local cids = {
  cloud = core.get_content_id("cloudcraft:cloud"),
  air = core.CONTENT_AIR,
  ignore = core.CONTENT_IGNORE,
}

-- Function for generating clouds
local function generate_cloud(mapgen,min_size,max_size,y_offset)
  -- Get provided values
  local pos = mapgen.pos
  local va = mapgen.voxelarea
  local vdata = mapgen.data
  local vparam2 = mapgen.param2

  -- Get stride values and set position
  local ystride = va.ystride
  local zstride = va.zstride
  pos = va:index(pos.x,pos.y + (y_offset or 0) + 1,pos.z)

  -- Generate cloud parameters
  local pcgr = PcgRandom(mapgen.seed + pos)
  local xmax = pcgr:next(min_size,max_size)
  local zmax = pcgr:next(min_size,max_size)

  -- Probe for mapchunk boundaries and set limits accordingly
  for x = -xmax, xmax, 1 do
    if vdata[pos + x] == cids.ignore then
      local nxmax = math.abs(x) - 1
      if nxmax < xmax then
        xmax = nxmax
      end
    end
  end

  for z = -zmax, zmax, 1 do
    if vdata[pos + z * zstride] == cids.ignore then
      local nzmax = math.abs(z) - 1
      if nzmax < zmax then
        zmax = nzmax
      end
    end
  end

  -- Don't generate clouds that are too small
  if xmax < 6 or zmax < 6 then
    return
  end

  -- Generate cloud layers
  for layer = 0, 2, 1 do
    pos = pos - ystride
    xmax = xmax - (layer == 1 and -1 or 1)
    zmax = zmax - (layer == 1 and -1 or 1)
    for x = -xmax, xmax, 1 do
      for z = -zmax, zmax, 1 do
        if math.abs(x) < xmax or math.abs(z) < zmax then
          local i = pos + x + z * zstride
          if vdata[i] == cids.air then
            vdata[i] = cids.cloud
          end
        end
      end
    end
  end
end

-- Many clouds will spawn under floatland formations
local disallowed_nodes = {
  "everness:coral_bones",
  "cobble",
  "brick",
}

abdecor.register_advanced_decoration("cloudcraft_underside_clouds",{
  target = {
    place_on = {
      "group:stone",
      "group:soil",
      "default:ice",
      "default:cave_ice",
      "everness:frosted_cave_ice",
    },
    sidelen = 80,
    fill_ratio = 0.0021,
    y_max = cloudcraft.settings.clouds.y_max,
    y_min = cloudcraft.settings.clouds.y_min,
    flags = "all_ceilings",
  },
  fn = function(mapgen)
    local name = core.get_node(mapgen.pos).name or ""
    for _,pattern in ipairs(disallowed_nodes) do
      if name:find(pattern) then
        return
      end
    end
    generate_cloud(mapgen,6,10,-4)
  end,
})

-- Randomly placed clouds are placed via midair marker nodes
core.register_ore({
  ore_type = "scatter",
  ore = "cloudcraft:cloud_marker",
  wherein = "air",
  clust_scarcity = 80 * 80 * 80,
  clust_num_ores = 1,
  clust_size = 1,
  y_min = cloudcraft.settings.clouds.y_min,
  y_max = cloudcraft.settings.clouds.y_max,
})

-- Random floating clouds
abdecor.register_advanced_decoration("cloudcraft_floating_clouds",{
  target = {
    place_on = {
      "cloudcraft:cloud_marker",
    },
    sidelen = 80,
    fill_ratio = 10,
    place_offset_y = -1,
    y_max = cloudcraft.settings.clouds.y_max,
    y_min = cloudcraft.settings.clouds.y_min,
    flags = "all_floors,force_placement",
  },
  fn = function(mapgen)
    local pcgr = PcgRandom(mapgen.seed + mapgen.pos.x + mapgen.pos.y + mapgen.pos.z)
    if pcgr:next(1,4) == 1 then
      for _,cloudpos in ipairs({
        {0,0},
        {pcgr:next(3,8),pcgr:next(3,8)},
      }) do
        mapgen.pos.x = mapgen.pos.x + cloudpos[1]
        mapgen.pos.z = mapgen.pos.z + cloudpos[2]
        generate_cloud(mapgen,8,16)
      end
    end
  end,
})

-- Disperse sparse clouds
local vc = vector.copy
core.register_abm({
  label = "Sparse Cloud Dispersal",
  nodenames = {"cloudcraft:cloud"},
  interval = 4,
  chance = 2,
  catch_up = false,
  action = function(pos)
    local at = core.get_node(pos)
    if at.param2 == 1 then
      return -- clouds placed by players should not disperse
    end

    local npos = vc(pos)
    local not_cloud = 0
    for x = -1, 1, 1 do
      npos.x = pos.x + x
      for z = -1, 1, 1 do
        npos.z = pos.z + z
        if x == 0 or z == 0 then
          not_cloud = not_cloud + (core.get_node(npos).name ~= "cloudcraft:cloud" and 1 or 0)
        end
      end
      if not_cloud > 2 then
        core.set_node(pos,{ name = "air" })
        return
      end
    end
  end,
})