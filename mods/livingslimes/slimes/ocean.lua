livingslimes.register_slime("Ocean",{
  -- Mob Properties
  color = "#00C:170",
  size = 3,
  aquatic = true,
  max_health = 10,
  damage = 1,
  speed = 3.75,
  tracking_range = 13,
  behaviors = {
    "wander",
    "neutral",
    "eat",
    "digest",
  },
  diet = {
    any = 1,
  },

  -- Spawning properties
  spawn_chance = livingslimes.settings.spawn_chance_docile,
  spawn_cap = 2,
  spawn_biomes = nil,
  spawn_nodes = {
    "group:water",
    "mapgen_water_source",
    "mapgen_river_water_source",
  },
  min_height = 0,
  max_height = 1,
  min_light = 0,
  max_light = 16,
  min_group = 1,
  max_group = 2,

  -- Drops properties
  edible = 1,
  harmful = 0,
})