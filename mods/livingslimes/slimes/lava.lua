livingslimes.register_slime("Lava",{
  -- Mob Properties
  color = "#F80:190",
  size = 8,
  glow = 6,
  aquatic = true,
  max_health = 24,
  armor_groups = { fire = 0 },
  fire_resistance = 1,
  damage = 5,
  speed = 4.75,
  tracking_range = 11,
  behaviors = {
    "wander",
    "attack",
    "fire",
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
  spawn_chance = math.floor(livingslimes.settings.spawn_chance_hostile / 10), -- lava is typically more rare so spawn chance is higher
  spawn_cap = 3,
  spawn_nodes = {
    "group:lava",
  },
  min_height = -31000,
  max_height = 31000,
  min_light = 0,
  max_light = 16,
  min_group = 1,
  max_group = 2,

  -- Drops properties
  edible = -2,
  harmful = 2,
})