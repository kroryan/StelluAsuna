return function(award)
  return {
    title = "Have a Heart",
    description = "Mine tin ore",
    difficulty = 30,
    icon = "[inventorycube{default_stone.png&default_mineral_tin.png{default_stone.png&default_mineral_tin.png{default_stone.png&default_mineral_tin.png",
    trigger = {
      type = "dig",
      node = "default:stone_with_tin",
      target = 1,
    },
  }
end