return function(award)
  return {
    title = "Timeless",
    description = "Mine quartz ore",
    difficulty = 25,
    icon = "[inventorycube{default_stone.png&everness_quartz_ore.png{default_stone.png&everness_quartz_ore.png{default_stone.png&everness_quartz_ore.png",
    trigger = {
      type = "dig",
      node = "everness:quartz_ore",
      target = 1,
    },
  }
end