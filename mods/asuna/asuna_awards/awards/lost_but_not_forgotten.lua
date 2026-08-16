return function(award)
  minetest.override_item("lootchests_default:stone_chest",{
    on_rightclick = function(pos,node,clicker)
      if clicker:is_player() then
        awards.unlock(clicker:get_player_name(),award)
      end
    end,
  })

  return {
    title = "Lost But Not Forgotten",
    description = "Open an ancient stone chest",
    difficulty = 240,
    icon = "[inventorycube{lootchests_default_stone_chest_top.png{lootchests_default_stone_chest_front.png{lootchests_default_stone_chest_side.png",
  }
end