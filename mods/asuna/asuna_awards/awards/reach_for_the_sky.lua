return function(award)
  -- Register interval callback to look for nearby sequoia trunks
  asuna_awards.register_on_interval(award,function(player)
    local pos = player:get_pos()
    local tree_nodes = minetest.find_nodes_in_area(pos:add(vector.new(-10,0,-10)),pos:add(vector.new(10,2,10)),{"everness:sequoia_tree"},false)
    if #tree_nodes > 60 then
      return award
    end
  end)

  -- Award definition
  return {
    title = "Reach for the Sky",
    description = "Find a giant sequoia tree",
    difficulty = 115,
    icon = "everness_sequoia_tree_sapling.png",
  }
end