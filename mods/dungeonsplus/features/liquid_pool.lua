local cids = {
  water_source = core.get_content_id("default:water_source"),
  lava_source = core.get_content_id("default:lava_source"),
}

local vn = vector.new
local vs = vector.subtract

return {
  name = "Liquid Pool",
  surfaces = "floor",
  weight = 2,
  conditions = {
    room = {
      function(room)
        local size = vs(room.max,room.min)
        return size.x > 5 and size.z > 5
      end,
      function(room)
        return room.enclosed.x and room.enclosed.y and room.enclosed.z
      end,
      function(room)
        return room.biome and room.heat
      end,
    },
    mods = {
      function(mod,path)
        return mod == "default" and path
      end,
      function(mod,path)
        return mod == "stairs" and path
      end,
    },
  },
  generate = function(data)
    local room = data.room
    local size = vs(room.max,room.min)
    local large_x = size.x > 7
    local large_z = size.z > 7
    local biome = core.registered_biomes[room.biome] or {
      node_dungeon = "default:cobble",
      node_dungeon_stair = "stairs:stair_cobble",
    }
    local dnode = core.get_content_id(core.registered_nodes[biome.node_dungeon] and biome.node_dungeon or "default:cobble")
    local stairname = core.registered_nodes[biome.node_dungeon_stair] and biome.node_dungeon_stair or "stairs:stair_cobble"
    local stair = core.get_content_id(stairname)
    local stair_outer = core.get_content_id(stairname:gsub(":stair_",":stair_outer_",1))

    local vdata = data.vdata
    local vparam2 = data.vparam2
    local ystride = data.va.ystride
    local zstride = data.va.zstride
    local pos = data.va:indexp(room.min) + (large_x and 3 or 2) + zstride * (large_z and 3 or 2) + ystride
    local pcgr = PcgRandom(pos)
    local liquid = (function()
      local lava_chance = 10
      if room.heat > 85 then
        lava_chance = lava_chance + 25
      end

      if room.humidity < 15 then
        lava_chance = lava_chance + 25
      end

      if room.biome:find("desert") then
        lava_chance = lava_chance + 25
      end

      return pcgr:next(1,100) < lava_chance and cids.lava_source or cids.water_source
    end)()

    if vdata[data.va:indexp(room.pos) - ystride] == cids.air then
      return false -- do not generate over rooms with open floors
    end

    local nodes = {
      [0] = { cid = liquid, param2 = 0 }, -- no min/max
      [1] = { cid = stair, param2 = 2 }, -- max z
      [2] = { cid = stair, param2 = 0 }, -- min z
      -- [3] invalid
      [4] = { cid = stair, param2 = 3 }, -- max x
      [5] = { cid = stair_outer, param2 = 3 }, -- max x, max z
      [6] = { cid = stair_outer, param2 = 0 }, -- max x, min z
      -- [7] invalid
      [8] = { cid = stair, param2 = 1 }, -- min x
      [9] = { cid = stair_outer, param2 = 2 }, -- min x, max z
      [10] = { cid = stair_outer, param2 = 1 }, -- min x, min z
      -- [11] invalid
      -- [12] invalid
      -- [13] invalid
      -- [14] invalid
      -- [15] invalid
    }

    local xmin = 0
    local xmax = size.x - (large_x and 6 or 4)
    local zmin = 0
    local zmax = (size.z - (large_z and 6 or 4)) * zstride

    for x = xmin, xmax, 1 do
      local nodebits = 0
      nodebits = (x == xmin) and bit.bor(nodebits,8) or bit.band(nodebits,7)
      nodebits = (x == xmax) and bit.bor(nodebits,4) or bit.band(nodebits,11)
      for z = zmin, zmax, zstride do
        nodebits = (z == zmin) and bit.bor(nodebits,2) or bit.band(nodebits,13)
        nodebits = (z == zmax) and bit.bor(nodebits,1) or bit.band(nodebits,14)
        local node = nodes[nodebits]
        local npos = pos + x + z
        vdata[npos] = node.cid
        vparam2[npos] = node.param2
        vdata[npos - ystride] = dnode
      end
    end
    return true
  end,
}