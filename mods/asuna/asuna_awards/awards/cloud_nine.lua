return function(award)
  -- Register interval callback to check y value
  asuna_awards.register_on_interval(award,function(player)
    if player:get_pos().y >= 1000 then
      return award
    end
  end)

  -- Award definition
  local tile = core.registered_nodes["cloudcraft:cloud"].tiles[1]
  local icon = core.inventorycube(tile,tile,tile)
  return {
    title = "Cloud Nine",
    description = "Reach a height of 1000",
    difficulty = 185,
    icon = icon,
  }
end