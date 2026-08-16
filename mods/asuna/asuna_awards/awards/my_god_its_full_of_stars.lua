return function(award)
  local ogtt = telemosaic.teleport
  telemosaic.teleport = function(player,src,dst)
    ogtt(player,src,dst)
    awards.unlock(player:get_player_name(),award)
  end

  return {
    title = "My God, It's Full of Stars",
    description = "Teleport using a teleportation beacon",
    difficulty = 60,
    icon = "[inventorycube{telemosaic_beacon_top.png{telemosaic_beacon_side.png{telemosaic_beacon_side.png",
    condition = asuna.content.wayfarer.worldgate,
  }
end