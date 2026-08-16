local vs = vector.subtract

return {
  name = "Bare Floor",
  surfaces = "floor",
  weight = 2,
  conditions = {
    room = {
      function(room)
        local size = vs(room.max,room.min)
        return size.x < 6 and size.z < 6
      end,
    },
  },
}