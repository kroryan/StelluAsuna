local cids = {
  air = core.CONTENT_AIR,
  torch = core.get_content_id("default:torch_wall"),
}

local vs = vector.subtract

local dungeon_nodes = {}
core.register_on_mods_loaded(function()
  for id,biome in pairs(core.registered_biomes) do
    local dnode = core.get_content_id(core.registered_nodes[biome.node_dungeon] and biome.node_dungeon or "default:cobble")
    local dalt = core.get_content_id(core.registered_nodes[biome.node_dungeon_alt] and biome.node_dungeon_alt or "default:mossycobble")
    dungeon_nodes[dnode] = true
    dungeon_nodes[dalt] = true
  end
end)

return {
  name = "Wall Torches",
  surfaces = "wall",
  weight = 12,
  conditions = {
    room = {
      function(room)
        return room.biome
      end,
    },
    mods = {
      function(mod,path)
        return mod == "default" and path
      end,
    },
  },
  generate = function(data)
    local room = data.room
    local ystride = data.va.ystride
    local zstride = data.va.zstride
    local min = data.va:indexp(room.min) + 2 * ystride
    local vdata = data.vdata
    local vparam2 = data.vparam2

    local size = vs(room.max,room.min)
    for _,npos in ipairs({
      { min + 2 + zstride, 5, -zstride },
      { min + size.x - 2 + zstride, 5, -zstride },
      { min + 2 + (size.z - 1) * zstride, 4, zstride },
      { min + size.x - 2 + (size.z - 1) * zstride, 4, zstride },
      { min + 2 * zstride + 1, 3, -1 },
      { min + (size.z - 2) * zstride + 1, 3, -1 },
      { min + 2 * zstride + size.x - 1, 2, 1 },
      { min + (size.z - 2) * zstride + size.x - 1, 2, 1 },
    }) do
      local node = vdata[npos[1] + npos[3]]
      local at = npos[1]
      if vdata[at] == cids.air and dungeon_nodes[node] then
        vdata[at] = cids.torch
        vparam2[at] = npos[2]
      end
    end
    return true
  end,
}