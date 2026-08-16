if asuna.settings.mapgen_warning.enabled then
  local messages = {}
  warn = function(mapgen)
    local message = "MAPGEN WARNING: This world uses mapgen '" .. mapgen .. "' which Asuna does not officially support. This may cause issues. Only mapgen 'v7' is officially supported."
    core.log("warning",message)
    table.insert(messages,core.colorize("#eeee00",message))
  end
  core.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local privs = core.get_player_privs(name)
    if privs.server or privs.debug or name == "singleplayer" then
      for _,message in ipairs(messages) do
        core.chat_send_player(name,message)
      end
    end
  end)
else
  warn = function(mapgen)
    core.log("warning","MAPGEN WARNING: This world uses mapgen '" .. mapgen .. "' which Asuna does not officially support. This may cause issues. Only mapgen 'v7' is officially supported.")
  end
end

local mapgen = core.get_mapgen_setting("mg_name")
if mapgen ~= "v7" then
  warn(mapgen)
end