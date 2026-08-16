return function(award)
  return {
    title = "Strike While It's Hot",
    description = "Mine iron ore",
    difficulty = 40,
    icon = "[inventorycube{default_stone.png&default_mineral_iron.png{default_stone.png&default_mineral_iron.png{default_stone.png&default_mineral_iron.png",
    trigger = {
      type = "dig",
      node = "default:stone_with_iron",
      target = 1,
    },
  }
end