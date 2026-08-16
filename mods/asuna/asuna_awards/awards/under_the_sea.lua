return function(award)
  -- Register interval callback to check for deep water
  asuna_awards.register_on_interval(award,function(player)
    local pos = player:get_pos()
    local y = pos.y
    if y <= -20 and y >= -32 and minetest.get_node(pos).name:find("water") then
      return award
    end
  end)

  -- Award definition
  return {
    title = "Under the Sea",
    description = "Dive into deep ocean",
    difficulty = 50,
    icon = "bubble.png",
  }
end