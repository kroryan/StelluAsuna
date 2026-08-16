return function(award)
  minetest.register_on_player_hpchange(function(player, hp_change, reason)
    if reason.type == "fall" then
      awards.unlock(player:get_player_name(),award)
    end
  end)

  return {
    title = "The Easy Way Down",
    description = "Take fall damage",
    icon = "drop_btn.png",
    condition = core.settings:get_bool("enable_damage"),
  }
end