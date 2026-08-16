return function(award)
  local mese_fruit_on_dig = minetest.registered_nodes["everness:mese_tree_fruit"].on_dig
  minetest.override_item("everness:mese_tree_fruit",{
    on_dig = function(pos,node,digger)
      if node.param2 == 0
        and minetest.get_node({ x = pos.x, y = pos.y + 1, z = pos.z }).name == "everness:mese_leaves"
        and digger
        and digger:is_player()
      then
        awards.unlock(digger:get_player_name(),award)
      end
      return mese_fruit_on_dig(pos,node,digger)
    end,
  })

  return {
    title = "Fruit of the Heavens",
    description = "Pluck a mese fruit from a mese tree",
    difficulty = 140,
    icon = "everness_mese_tree_fruit_item.png",
  }
end