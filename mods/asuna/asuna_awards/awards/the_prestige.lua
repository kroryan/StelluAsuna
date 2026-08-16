return function(award)
  local ogacp = awards.clear_player
  awards.clear_player = function(name)
    local had_cosmopolitan = awards.player(name).unlocked["asuna_awards:cosmopolitan"]
    local retval = ogacp(name)
    if had_cosmopolitan then
      awards.unlock(name,award)
    end
    return retval
  end

  return {
    title = "The Prestige",
    description = "Reset your awards after earning Cosmopolitan",
    difficulty = 1000,
    icon = "cdb_update.png",
    secret = true,
  }
end