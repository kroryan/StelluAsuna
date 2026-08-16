return function(award)
  minetest.override_item("default:mese_block",{
    dropped_step = function(self,pos)
      -- Check if player explicitly dropped it
      local dropper = self.dropped_by
      if dropper and minetest.get_player_by_name(dropper) then
        local groups = minetest.registered_nodes[minetest.get_node(pos).name].groups
        if groups and groups.lava and groups.lava > 0 then
          awards.unlock(dropper,award)
        end
      end
      return true
    end,
  })

  return {
    title = "Fellowship of the Mese",
    description = "Drop a mese block into lava",
    difficulty = 280,
    icon = "[inventorycube{default_mese_block.png{default_mese_block.png{default_mese_block.png^fire_basic_flame.png",
  }
end