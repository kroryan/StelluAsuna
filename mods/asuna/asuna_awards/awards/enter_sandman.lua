-- Get beds skip night setting
local is_night_skip_enabled = minetest.settings:get_bool("enable_bed_night_skip",true)

return function(award)
  -- Unlock for actual sleeping if night skip is enabled, else unlock for laying down
  if is_night_skip_enabled then
    local ogbsn = beds.skip_night
    beds.skip_night = function()
      for _,player in ipairs(minetest.get_connected_players()) do
        local player_name = player and player:get_player_name() or nil
        if player_name and beds.player[player_name] then
          awards.unlock(player_name,award)
        end
      end
      ogbsn()
    end
  else
    local ogborc = beds.on_rightclick
    beds.on_rightclick = function(pos, player)
      local retval = ogborc(pos, player)
      local player_name = player and player:get_player_name() or nil
      if beds.player[player_name] then
        awards.unlock(player_name,award)
      end
      return retval
    end
  end

  return {
    title = "Enter Sandman",
    description = "Sleep in a bed",
    difficulty = 240,
    icon = "beds_bed_fancy.png",
  }
end
