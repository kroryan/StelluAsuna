local cids = {
  air = core.CONTENT_AIR,
  grass = core.get_content_id("default:dirt_with_grass"),
  grass1 = core.get_content_id("default:grass_1"),
  grass2 = core.get_content_id("default:grass_2"),
  grass3 = core.get_content_id("default:grass_3"),
  grass4 = core.get_content_id("default:grass_4"),
  grass5 = core.get_content_id("default:grass_5"),
  firefly = core.get_content_id("fireflies:firefly"),
  mushroom_red = core.get_content_id("flowers:mushroom_red"),
  mushroom_brown = core.get_content_id("flowers:mushroom_brown"),
  fence = core.get_content_id("default:fence_wood"),
}

local preserve = {
  [core.CONTENT_AIR] = true,
  [core.get_content_id("default:water_source")] = true,
  [core.get_content_id("default:lava_source")] = true,
}
core.register_on_mods_loaded(function()
  for node,def in pairs(core.registered_nodes) do
    if node:find("^stairs:stair_") then
      preserve[core.get_content_id(node)] = true
    end
  end
end)

local vs = vector.subtract

return {
  name = "Garden",
  surfaces = "floor",
  weight = 1,
  conditions = {
    room = {
      function(room)
        local size = vs(room.max,room.min)
        return size.x > 4 and size.z > 4
      end,
      function(room)
        return room.biome and room.heat and room.heat >= 40 and room.humidity >= 40
      end,
    },
    mods = {
      function(mod,path)
        return mod == "default" and path
      end,
      function(mod,path)
        return mod == "fireflies" and path
      end,
      function(mod,path)
        return mod == "flowers" and path
      end,
    },
  },
  generate = function(data)
    local room = data.room
    local ystride = data.va.ystride
    local zstride = data.va.zstride
    local min = data.va:indexp(room.min)
    local vdata = data.vdata
    local vparam2 = data.vparam2
    local pcgr = PcgRandom(min)

    local size = vs(room.max,room.min)
    local xmin = 1
    local xmax = size.x - 1
    local zmin = 1
    local zmax = size.z - 1

    -- Make the floor grass and track where grass is placed
    local grassy = {}
    for x = xmin, xmax do
      for z = zmin, zmax do
        local npos = min + x + z * zstride
        if not preserve[vdata[npos]] and pcgr:next(1,100) < 80 then
          vdata[npos] = cids.grass
          table.insert(grassy,npos + ystride)
        end
      end
    end

    -- Place fences at closed corners
    for _,corner in ipairs({
      { min + 1 + zstride, { -1, -zstride } },
      { min + 2 + zstride, { -zstride } },
      { min + 1 + zstride * 2, { -1 } },
      { min + (size.x - 1) + zstride, { 1, -zstride } },
      { min + (size.x - 2) + zstride, { -zstride } },
      { min + (size.x - 1) + zstride * 2, { 1 } },
      { min + 1 + (size.z - 1) * zstride, { -1, zstride } },
      { min + 2 + (size.z - 1) * zstride, { zstride } },
      { min + 1 + (size.z - 2) * zstride, { -1 } },
      { min + (size.x - 1) + (size.z - 1) * zstride, { 1, zstride } },
      { min + (size.x - 2) + (size.z - 1) * zstride, { zstride } },
      { min + (size.x - 1) + (size.z - 2) * zstride, { 1 } },
    }) do repeat
      local cpos = corner[1]
      if vdata[cpos] == cids.air then
        break
      end
      cpos = cpos + ystride
      if vdata[cpos] ~= cids.air then
        break
      end
      local is_blocked = false
      for _,wall in ipairs(corner[2]) do
        if vdata[cpos + wall] ~= cids.air then
          is_blocked = true
          break
        end
      end
      if is_blocked then
        vdata[cpos] = cids.fence
      else
        break
      end
    until true end

    -- Place stuff on grassy dirt
    for _,npos in ipairs(grassy) do
      if vdata[npos] == cids.air then
        local chance = pcgr:next(1,100)
        if chance < 20 then
          vdata[npos] = cids["grass" .. pcgr:next(1,5)]
        elseif chance < 22 then
          vdata[npos] = cids.firefly
        elseif chance < 24 then
          vdata[npos] = chance % 2 == 0 and cids.mushroom_red or cids.mushroom_brown
        end
      end
    end

    return true
  end,
}