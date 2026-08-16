local cids = {
  air = core.CONTENT_AIR,
  bookshelf = core.get_content_id("default:bookshelf"),
  torch = core.get_content_id("default:torch"),
  wood = core.get_content_id("default:wood"),
  stair = nil, -- get stair node after mods loaded below
  lamp = core.get_content_id("default:mese_post_light"),
}

local preserve = {
  [core.CONTENT_AIR] = true,
  [core.get_content_id("default:water_source")] = true,
  [core.get_content_id("default:lava_source")] = true,
}
core.register_on_mods_loaded(function()
  cids.stair = core.get_content_id("stairs:stair_outer_wood")
  for node,def in pairs(core.registered_nodes) do
    if node:find("^stairs:stair_") then
      preserve[core.get_content_id(node)] = true
    end
  end
end)

local vs = vector.subtract
local ma = math.abs

local bookshelf_on_construct = core.registered_nodes["default:bookshelf"].on_construct
local function bookshelf(pos)
  bookshelf_on_construct(pos)
  local pcgr = PcgRandom(core.hash_node_position(pos))
  local meta = core.get_meta(pos)
  local inv = meta:get_inventory()
  for i = 1, 8*2 do
    if pcgr:next(1,100) < 25 then
      inv:set_stack("books",i,ItemStack("default:book"))
    end
  end
  bookshelf_on_construct(pos)
  return cids.bookshelf
end

return {
  name = "Library",
  surfaces = {
    "floor",
    "wall",
    "ceiling",
  },
  weight = 6,
  conditions = {
    room = {
      function(room)
        return room.enclosed.y
      end,
      function(room)
        local size = vs(room.max,room.min)
        return size.x > 5
          and size.z > 5
          and size.y > 3
          and room.pos.x - room.min.x > 2
          and room.pos.z - room.min.z > 2
          and room.max.x - room.pos.x > 2
          and room.max.z - room.pos.z > 2
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
    local va = data.va
    local ystride = va.ystride
    local zstride = va.zstride
    local pos = va:indexp(room.min)
    local center = va:indexp(room.pos)
    local vdata = data.vdata
    local vparam2 = data.vparam2

    -- Ensure solid floor and ceiling space to place central library pillar
    local size = vs(room.max,room.min)
    for _,spos in ipairs({ center, center + (size.y + 1) * ystride }) do
      for x = -1, 1 do
        for z = -1, 1 do
          if vdata[spos + x + z * zstride - ystride] == cids.air then
            return false -- do not place pillar over air gaps
          end
        end
      end
    end

    local xmin = 0
    local xmax = size.x
    local ymin = ystride
    local ylight = ymin + ystride
    local ymax = (size.y - 1) * ystride
    local zmin = 0
    local zmax = size.z * zstride
    for x = xmin, xmax, 1 do
      local center_x = (room.min.x + x == room.pos.x)
      for y = ymin, ymax, ystride do
        for z = zmin, zmax, zstride do
          local center_z = (room.min.z + (z / zstride) == room.pos.z)
          local npos = pos + x + y + z
          if (x == xmin or x == xmax) and not (z == zmin or z == zmax) and not preserve[vdata[npos]] and vparam2[npos] == 0 and (preserve[vdata[npos - 1]] or preserve[vdata[npos + 1]]) then
            local is_lamp = (y == ylight and center_z)
            vdata[npos] = is_lamp and cids.lamp or bookshelf(va:position(npos))
            vparam2[npos] = is_lamp and 0 or 1
          elseif (z == zmin or z == zmax) and not (x == xmin or x == xmax) and not preserve[vdata[npos]] and vparam2[npos] == 0 and (preserve[vdata[npos - zstride]] or preserve[vdata[npos + zstride]]) then
            vdata[npos] = (y == ylight and center_x) and cids.lamp or bookshelf(va:position(npos))
          elseif center_x and center_z then
            vdata[npos] = cids.wood
            for _,adj in ipairs({
              { npos - 1, 1 },
              { npos + 1, 1 },
              { npos + zstride, 0 },
              { npos - zstride, 0 },
            }) do
              vdata[adj[1]] = bookshelf(va:position(adj[1]))
              vparam2[adj[1]] = adj[2]
            end
            if y == ymin then
              for _,adj in ipairs({
                { npos - 1 + zstride, 2 },
                { npos + 1 + zstride, 3 },
                { npos - 1 - zstride, 1 },
                { npos + 1 - zstride, 0 },
              }) do
                vdata[adj[1]] = cids.stair
                vparam2[adj[1]] = adj[2]
              end
            elseif y == ymax then
              for _,adj in ipairs({
                { npos - 1 + zstride, 23 },
                { npos + 1 + zstride, 22 },
                { npos - 1 - zstride, 20 },
                { npos + 1 - zstride, 21 },
              }) do
                vdata[adj[1]] = cids.stair
                vparam2[adj[1]] = adj[2]
              end
            end
          end
        end
      end
    end
    return true
  end,
}
