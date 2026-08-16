return function(award)
  minetest.register_on_player_hpchange(function(player, hp_change, reason)
    if reason.type == "node_damage" then
      awards.unlock(player:get_player_name(),award)
    end
  end)

  return {
    title = "Don't Touch That",
    description = "Take damage from a harmful node",
    difficulty = 15,
    icon = "fire_basic_flame.png",
    condition = core.settings:get_bool("enable_damage"),
  }
end