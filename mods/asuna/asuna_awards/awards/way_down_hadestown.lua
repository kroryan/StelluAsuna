return function(award)
  -- Register interval callback to check y value
  asuna_awards.register_on_interval(award,function(player)
    if player:get_pos().y <= -1000 then
      return award
    end
  end)

  -- Award definition
  return {
    title = "Way Down Hadestown",
    description = "Reach a depth of -1000",
    difficulty = 110,
    icon = "everness_weeping_obsidian.png",
  }
end