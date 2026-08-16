-- Globals
livingslimes = {
  storage = minetest.get_mod_storage(),
  settings = {
    allow_attack = minetest.settings:get_bool("livingslimes.allow_attack",true) and minetest.settings:get_bool("enable_damage",true),
    allow_eat = minetest.settings:get_bool("livingslimes.allow_eat",true),
    allow_dig = minetest.settings:get_bool("livingslimes.allow_dig",true),
    dig_limit = tonumber(minetest.settings:get("livingslimes.dig_limit",8) or 8),
    allow_steal = minetest.settings:get_bool("livingslimes.allow_steal",true),
    steal_chance = tonumber(minetest.settings:get("livingslimes.steal_chance",36) or 36),
    allow_digest = minetest.settings:get_bool("livingslimes.allow_digest",true),
    digest_timer = tonumber(minetest.settings:get("livingslimes.digest_timer",240) or 240),
    allow_poison = minetest.settings:get_bool("livingslimes.allow_poison",true),
    allow_fire = minetest.settings:get_bool("livingslimes.allow_fire",true),
    spawn_chance_docile = tonumber(minetest.settings:get("livingslimes.spawn_chance_docile",8500) or 8500),
    spawn_chance_hostile = tonumber(minetest.settings:get("livingslimes.spawn_chance_hostile",12750) or 12750),
  },
  dependencies = (function()
    local deps = {}
    for _,dependency in ipairs({
      "default",
      "fire",
      "ethereal",
      "everness",
      "naturalbiomes",
      "variety",
      "asuna_core",
      "mcl_biomes",
      "mcl_core",
      "mcl_fire",
      "mcl_flowers",
      "mcl_mushrooms",
    }) do
      deps[dependency] = minetest.get_modpath(dependency) and true or false
    end
    return deps
  end)(),
  fire = (function()
    if minetest.get_modpath("fire") then
      return {
        node = "fire:basic_flame",
        texture = "fire_basic_flame_animated.png",
        sound = "fire_extinguish_flame",
      }
    elseif minetest.get_modpath("mcl_fire") then
      return {
        node = "mcl_fire:fire",
        texture = "fire_basic_flame_animated.png",
        sound = "fire_extinguish_flame",
      }
    else
      return nil
    end
  end)(),
}

-- Do not spawn slimes in Asuna if slimes are disabled
if not asuna.content.menagerie.slimes then
  livingslimes.settings.spawn_chance_docile = -1
  livingslimes.settings.spawn_chance_hostile = -1
end

-- Get mod path
local mpath = minetest.get_modpath("livingslimes")

-- Load slime behaviors
dofile(mpath .. "/behaviors.lua")

-- Load functions
dofile(mpath .. "/functions.lua")

-- Load slimes
local slimes_path = mpath .. "/slimes/"
local slime_files = minetest.get_dir_list(slimes_path,false)
for i = 1, #slime_files do
  dofile(slimes_path .. slime_files[i])
end