return function(award)
  return {
    title = "Sixteen Tons",
    description = "Mine coal ore",
    difficulty = 20,
    icon = "[inventorycube{default_stone.png&default_mineral_coal.png{default_stone.png&default_mineral_coal.png{default_stone.png&default_mineral_coal.png",
    trigger = {
      type = "dig",
      node = "default:stone_with_coal",
      target = 1,
    },
  }
end