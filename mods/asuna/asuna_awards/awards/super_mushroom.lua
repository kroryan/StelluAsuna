return function(award)
  return {
    title = "Super Mushroom",
    description = "Mine a giant red mushroom cap",
    difficulty = 35,
    icon = "[inventorycube{ethereal_mushroom_block.png{ethereal_mushroom_block.png{ethereal_mushroom_block.png",
    trigger = {
      type = "dig",
      node = "ethereal:mushroom",
      target = 1,
    },
  }
end