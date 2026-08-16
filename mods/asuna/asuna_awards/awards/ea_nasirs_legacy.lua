return function(award)
  return {
    title = "Ea-nāṣir's Legacy",
    description = "Mine copper ore",
    difficulty = 20,
    icon = "[inventorycube{default_stone.png&default_mineral_copper.png{default_stone.png&default_mineral_copper.png{default_stone.png&default_mineral_copper.png",
    trigger = {
      type = "dig",
      node = "default:stone_with_copper",
      target = 1,
    },
  }
end