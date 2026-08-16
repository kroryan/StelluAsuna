local asuna_mod_path = core.get_game_info().path .. "/mods"
local bundled_mods = core.get_dir_list(asuna_mod_path,true)
local warn

if asuna.settings.mod_override_warnings.enabled then
  local messages = {}
  warn = function(mod)
    local message = "MOD OVERRIDE WARNING: Mod '" .. mod .. "' is enabled externally which overrides Asuna's version of this mod. This may cause issues."
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
  warn = function(mod)
    core.log("warning","MOD OVERRIDE WARNING: Mod '" .. mod .. "' is enabled externally which overrides Asuna's version of this mod. This may cause issues.")
  end
end

for _,mod in ipairs(bundled_mods) do
  local mods = { mod }
  local mpath = asuna_mod_path .. "/" .. mod
  local mfiles = core.get_dir_list(mpath,false)

  for _,mfile in ipairs(mfiles) do
    if mfile:find("^modpack\\.") then
      mods = core.get_dir_list(mpath,true)
      break
    end
  end

  for _,mpath in ipairs(mods) do
    mod = mpath
    mpath = core.get_modpath(mpath)
    if mpath and not mpath:find("[\\/]games[\\/][^\\/]+[\\/]mods[\\/]") then
      warn(mod)
    end
  end
end