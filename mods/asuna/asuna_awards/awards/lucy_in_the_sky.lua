return function(award)
  return {
    title = "Lucy in the Sky",
    description = "Mine diamond ore",
    difficulty = 205,
    icon = "[inventorycube{default_stone.png&default_mineral_diamond.png{default_stone.png&default_mineral_diamond.png{default_stone.png&default_mineral_diamond.png",
    trigger = {
      type = "dig",
      node = "default:stone_with_diamond",
      target = 1,
    },
  }
end