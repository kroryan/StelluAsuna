return function(award)
  -- Register interval callback to check node at each player's location
  asuna_awards.register_on_interval(award,function(player)
    local at = minetest.get_node(player:get_pos()).name
    if at == "x_farming:rope" then
      return award
    end
  end)

  -- Award definition
  return {
    title = "The Careful Way Down",
    description = "Climb on a rope made from vines, hemp, or barley",
    difficulty = 40,
    icon = "x_farming_rope_item.png",
  }
end