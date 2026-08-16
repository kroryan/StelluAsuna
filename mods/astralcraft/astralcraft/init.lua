-- --------- --
--  GLOBALS  --
-- --------- --

astralcraft = {
  modpath = core.get_modpath("astralcraft"),
  storage = core.get_mod_storage(),
  settings = {
    shooting_star = {
      spawners = tonumber(asuna.content.stratosphere.astralcraft and (core.settings:get("astralcraft.shooting_star.spawners",2) or 2) or 0),
      y_min = tonumber(asuna.content.stratosphere.astralcraft and (core.settings:get("astralcraft.shooting_star.y_min",1) or 1) or -31000),
      y_max = tonumber(asuna.content.stratosphere.astralcraft and (core.settings:get("astralcraft.shooting_star.y_max",31000) or 31000) or -31000),
      interval_min = tonumber(core.settings:get("astralcraft.shooting_star.interval_min",60) or 60),
      interval_max = tonumber(core.settings:get("astralcraft.shooting_star.interval_max",100) or 100),
      chance_min = tonumber(core.settings:get("astralcraft.shooting_star.chance_min",40) or 40),
      chance_max = tonumber(core.settings:get("astralcraft.shooting_star.chance_max",100) or 100),
      chance_step = tonumber(core.settings:get("astralcraft.shooting_star.chance_step",10) or 10),
      node_radius = tonumber(core.settings:get("astralcraft.shooting_star.node_radius",64) or 64),
      fragments_per_star = tonumber(core.settings:get("astralcraft.shooting_star.fragments_per_star",5) or 5),
    },
    warp_star = {
      wear_per_distance = tonumber(core.settings:get("astralcraft.warp_star.wear_per_distance",50) or 50),
      wear_per_failure = tonumber(core.settings:get("astralcraft.warp_star.wear_per_failure",5000) or 5000),
      throw_velocity = tonumber(core.settings:get("astralcraft.warp_star.throw_velocity",30) or 30),
      timeout = tonumber(core.settings:get("astralcraft.warp_star.timeout",6) or 6),
    },
    astralite = {
      state_interval = tonumber(core.settings:get("astralcraft.astralite.state_interval",200) or 200) / 1000,
      save_interval = tonumber(core.settings:get("astralcraft.astralite.save_interval",2) or 2),
    },
  },
  dependencies = (function()
    local deps = {}
    for _,mod in ipairs({
      "player_monoids",
      "default",
      "stairs",
      "walls",
      "awards",
      "wielded_light",
    }) do
      deps[mod] = core.get_modpath(mod)
    end
    return deps
  end)(),
}