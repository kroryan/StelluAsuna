-- --------- --
--  GLOBALS  --
-- --------- --

cloudcraft = {
  modpath = core.get_modpath("cloudcraft"),
  storage = core.get_mod_storage(),
  settings = {
    clouds = {
      y_min = tonumber(asuna.content.stratosphere.cloudcraft and (core.settings:get("cloudcraft.clouds.y_min",250) or 250) or -31000),
      y_max = tonumber(asuna.content.stratosphere.cloudcraft and (core.settings:get("cloudcraft.clouds.y_max",31000) or 31000) or -31000),
    },
  },
  dependencies = (function()
    local deps = {}
    for _,mod in ipairs({
      "default",
      "abdecor",
      "player_monoids",
      "armor_monoid",
      "awards",
      "3d_armor",
    }) do
      deps[mod] = core.get_modpath(mod)
    end
    return deps
  end)(),
}

-- ------- --
--  FILES  --
-- ------- --

local mpath = cloudcraft.modpath
for _,file in ipairs({
  "nodes",
  "tools",
  "mapgen",
  "armor",
  "awards",
}) do
  dofile(mpath .. "/src/" .. file .. ".lua")
end