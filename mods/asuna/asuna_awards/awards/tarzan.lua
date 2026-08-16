return function(award)
  -- Register interval callback to check y value
  asuna_awards.register_on_interval(award,function(player)
    local pos = player:get_pos()
    if minetest.get_item_group(minetest.get_node(pos:add(vector.new(0,-0.5,0))).name,"leaves") > 0 then
      local tree_nodes = minetest.find_nodes_in_area(pos:add(vector.new(-3,-3,-3)),pos:add(vector.new(3,3,3)),{"group:tree"},false)
      if #tree_nodes > 1 and #minetest.find_nodes_in_area(pos:add(vector.new(0,-3,0)),pos,{"group:soil","group:stone"},false) == 0 then
        return award
      end
    end
  end)

  -- Award definition
  return {
    title = "Tarzan",
    description = "Climb a tree",
    difficulty = 20,
    icon = "[inventorycube{default_leaves.png{default_leaves.png{default_leaves.png",
  }
end