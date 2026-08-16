return function(award)
  return {
    title = "Worth Its Weight",
    description = "Mine gold ore",
    difficulty = 90,
    icon = "[inventorycube{default_stone.png&default_mineral_gold.png{default_stone.png&default_mineral_gold.png{default_stone.png&default_mineral_gold.png",
    trigger = {
      type = "dig",
      node = "default:stone_with_gold",
      target = 1,
    },
  }
end