return function(award)
  return {
    title = "Sleepy Hollow",
    description = "Craft a pumpkin lantern",
    difficulty = 60,
    icon = "[inventorycube{x_farming_pumpkin_fruit_top.png{x_farming_pumpkin_fruit_side_on.png{x_farming_pumpkin_fruit_side.png",
    trigger = {
      type = "craft",
      item = "x_farming:pumpkin_lantern",
      target = 1,
    }
  }
end