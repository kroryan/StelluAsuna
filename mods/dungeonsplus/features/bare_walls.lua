local vs = vector.subtract

return {
  name = "Bare Walls",
  surfaces = "wall",
  weight = 1,
  conditions = {
    room = {
      function(room)
        local size = vs(room.max,room.min)
        return size.x < 6 and size.z < 6
      end,
    },
  },
}