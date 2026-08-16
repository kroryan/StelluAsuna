local cids = {
  air = core.CONTENT_AIR,
  cobble = core.get_content_id("default:cobble")
}

local vs = vector.subtract

local furnace_on_construct = core.registered_nodes["default:furnace"].on_construct
local furnace_on_timer = core.registered_nodes["default:furnace"].on_timer

return {
  name = "Forge",
  surfaces = {
    "floor",
    "ceiling",
  },
  weight = 3,
  conditions = {
    room = {
      function(room)
        return room.enclosed.y
      end,
      function(room)
        local size = vs(room.max,room.min)
        return size.x > 7 and size.y > 3 and size.z > 7
      end,
    },
    mods = {
      function(mod)
        return "default"
      end,
      function(mod)
        return "stairs"
      end,
    },
  },
  generate = function(data)
    local room = data.room
    local ystride = data.va.ystride
    local zstride = data.va.zstride
    local pos = data.va:indexp(room.pos)
    local vm = data.vm
    local va = data.va
    local vdata = data.vdata
    local vparam2 = data.vparam2

    -- Ensure solid floor space to place forge
    for x = -2, 2 do
      for z = -2, 2 do
        if vdata[pos + x + z * zstride - ystride] == cids.air then
          return false -- do not place forge over air gaps
        end
      end
    end

    vm:set_data(vdata)
    vm:set_param2_data(vparam2)
    core.place_schematic_on_vmanip(vm,room.pos,dungeonsplus.modpath .. "/schematics/forge.mts",0,nil,true,"place_center_x,place_center_z")
    vm:get_data(vdata)
    vm:get_param2_data(vparam2)

    local size = vs(room.max,room.min)
    for y = pos + 3 * ystride, pos + (size.y - 2) * ystride, ystride do
      vdata[y] = cids.cobble
    end

    local pcgr = PcgRandom(pos)
    for _,adj in ipairs({ -1, 1, zstride, -zstride}) do
      local lootpos = pos + ystride + adj
      local vlootpos = va:position(lootpos)
      furnace_on_construct(vlootpos)
      local chance = pcgr:next(1,100)
      if chance < 65 then
        local meta = core.get_meta(vlootpos)
        local inv = meta:get_inventory()
        inv:set_stack("fuel",1,ItemStack("default:coal_lump " .. (chance % 8 + 1)))
        for i = 1, 4 do
          chance = pcgr:next(1,100)
          if chance < 20 then
            inv:set_stack("dst",i,ItemStack("default:bronze_ingot " .. (chance % 3 + 2)))
          elseif chance < 30 then
            inv:set_stack("dst",i,ItemStack("default:steel_ingot " .. (chance % 3 + 1)))
          elseif chance < 35 then
            inv:set_stack("dst",i,ItemStack("default:gold_ingot " .. (chance % 3 + 1)))
          end
        end
      end
      furnace_on_timer(vlootpos,1)
    end

    return true
  end,
}