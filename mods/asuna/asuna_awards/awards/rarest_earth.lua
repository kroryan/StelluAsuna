return function(award)
  return {
    title = "Rarest Earth",
    description = "Mine a mese block",
    difficulty = 250,
    icon = "[inventorycube{default_mese_block.png{default_mese_block.png{default_mese_block.png",
    trigger = {
      type = "dig",
      node = "default:mese_block",
      target = 1,
    },
  }
end