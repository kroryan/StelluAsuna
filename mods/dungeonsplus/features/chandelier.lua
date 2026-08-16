local cids = {
  air = core.CONTENT_AIR,
  fence = core.get_content_id("default:fence_wood"),
  wood = core.get_content_id("default:wood"),
  torch = core.get_content_id("default:torch"),
}

local vs = vector.subtract

return {
  name = "Chandelier",
  surfaces = "ceiling",
  weight = 9,
  conditions = {
    room = {
      function(room)
        local size = vs(room.max,room.min)
        return size.x > 4 and size.z > 4 and size.y > 8
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
    local va = data.va
    local ystride = va.ystride
    local zstride = va.zstride
    local size = vs(room.max,room.min)
    local pos = va:indexp(room.pos) + (size.y - 1) * ystride
    local vdata = data.vdata
    local vparam2 = data.vparam2

    if vdata[pos] == cids.air then
      return false -- cannot place if ceiling doesn't actually exist
    end

    for y = 1, size.y - 7 do
      vdata[pos - y * ystride] = cids.fence
    end
    pos = pos - (size.y - 8) * ystride

    for x = -1, 1, 1 do
      for z = -zstride, zstride, zstride do
        local npos = pos + x + z
        if x == 0 and z == 0 then
          vdata[npos] = cids.fence
        elseif x == 0 or z == 0 then
          vdata[npos] = cids.torch
          vparam2[npos] = 1
        end
      end
    end

    pos = pos - ystride

    for x = -1, 1, 1 do
      for z = -zstride, zstride, zstride do
        local npos = pos + x + z
        if x == 0 and z == 0 then
          vdata[npos] = cids.wood
        elseif x == 0 or z == 0 then
          vdata[npos] = cids.fence
        end
      end
    end
    return true
  end,
}