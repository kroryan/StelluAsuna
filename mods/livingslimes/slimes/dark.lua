livingslimes.register_slime("Dark",{
  -- Mob Properties
  color = "#100015:120",
  size = 5,
  aquatic = false,
  max_health = 18,
  damage = 4,
  speed = 2.5,
  tracking_range = 14,
  behaviors = {
    "wander",
    "attack",
    "eat",
    "digest",
  },
  diet = {
    ["group:sword"] = 10,
    ["group:pickaxe"] = 9,
    ["group:axe"] = 8,
    ["group:shovel"] = 7,
    ["group:hoe"] = 7,
    ["group:food"] = 2,
    any = 1,
  },

  -- Spawning properties
  spawn_chance = livingslimes.settings.spawn_chance_hostile,
  spawn_cap = 1,
  spawn_biomes = nil,
  spawn_nodes = {
    "group:soil",
    "group:stone",
  },
  min_height = -31000,
  max_height = -32,
  min_light = 0,
  max_light = 7,
  min_group = 1,
  max_group = 1,

  -- Drops properties
  edible = 2,
  harmful = 0,
})