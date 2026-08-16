return function(award)
  local forc = minetest.registered_items["flowerpot:empty"].on_rightclick
  minetest.override_item("flowerpot:empty",{
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
      local retval = forc(pos, node, clicker, itemstack, pointed_thing)
      local node = minetest.get_node(pos).name
      if node ~= "flowerpot:empty" and node:find("^flowerpot:") then
        awards.unlock(clicker:get_player_name(),award)
      end
      return retval
    end,
  })

  return {
    title = "Home Gardening",
    description = "Pot a flower in a flowerpot",
    difficulty = 30,
    icon = "pia.png",
  }
end