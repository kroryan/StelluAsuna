return function(award)
  return {
    title = "Rare Earth",
    description = "Mine mese ore",
    difficulty = 200,
    icon = "[inventorycube{default_stone.png&default_mineral_mese.png{default_stone.png&default_mineral_mese.png{default_stone.png&default_mineral_mese.png",
    trigger = {
      type = "dig",
      node = "default:stone_with_mese",
      target = 1,
    },
  }
end