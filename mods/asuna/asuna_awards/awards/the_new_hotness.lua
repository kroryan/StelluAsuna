return function(award)
  local ogbou = minetest.registered_craftitems["bucket:bucket_empty"].on_use
  minetest.override_item("bucket:bucket_empty",{
    on_use = function(itemstack, player, pointed_thing)
      local was_lava = pointed_thing.type == "node" and (minetest.get_node(pointed_thing.under).name == "default:lava_source") or false
      local retval = ogbou(itemstack, player, pointed_thing)
      if retval and was_lava and minetest.get_node(pointed_thing.under).name ~= "default:lava_source" then
        awards.unlock(player:get_player_name(),award)
      end
      return retval
    end,
  })

  return {
    title = "The New Hotness",
    description = "Collect a bucket of lava",
    difficulty = 45,
    icon = "bucket_lava.png",
  }
end