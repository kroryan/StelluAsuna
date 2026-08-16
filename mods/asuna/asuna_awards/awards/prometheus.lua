return function(award)
  local ogfsou = minetest.registered_items["fire:flint_and_steel"].on_use
  minetest.override_item("fire:flint_and_steel",{
    on_use = function(itemstack,user,pointed_thing)
      ogfsou(itemstack,user,pointed_thing)
      if pointed_thing.type == "node" and minetest.get_node(pointed_thing.above).name:find("^fire:") then
        awards.unlock(user:get_player_name(),award)
      end
    end
  })

  return {
    title = "Prometheus",
    description = "Start a fire using Flint and Steel",
    difficulty = 240,
    icon = "fire_flint_steel.png",
  }
end