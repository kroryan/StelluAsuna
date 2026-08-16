return function(award)
  minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "music_settings" and fields.play then
      awards.unlock(player:get_player_name(),award)
    end
  end)

  return {
    title = "Play That Funky Music",
    description = "Use the music settings to play a music track",
    difficulty = 4,
    icon = "music_sfinv_buttons_icon.png",
  }
end