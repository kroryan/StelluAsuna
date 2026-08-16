return function(award)
  -- Get set of slippery nodes
  local slippery_nodes = {}
  for node,def in pairs(minetest.registered_nodes) do
    local groups = def.groups
    if groups and groups.slippery and groups.slippery > 0 then
      slippery_nodes[node] = true
    end
  end

  -- Register interval callback to check node below players
  asuna_awards.register_on_interval(award,function(player)
    local below = minetest.get_node(player:get_pos():add(vector.new(0,-1,0))).name
    if below and slippery_nodes[below] then
      return award
    end
  end)

  -- Award definition
  return {
    title = "Slip Slidin' Away",
    description = "Walk on a slippery surface",
    difficulty = 30,
    icon = "[inventorycube{default_ice.png{default_ice.png{default_ice.png",
  }
end