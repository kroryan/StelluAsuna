livingslimes.register_slime("Algae",{
  -- Mob Properties
  color = "#0C9:170",
  size = 4,
  glow = 1,
  aquatic = true,
  max_health = 10,
  damage = 1,
  speed = 3.5,
  tracking_range = 13,
  behaviors = {
    "wander",
    "neutral",
    "dig",
    "eat",
    "digest",
  },
  diet = {
    ["group:mushroom"] = 5,
    ["group:grass"] = 1,
    ["group:flora"] = 1,
  },

  -- Spawning properties
  spawn_chance = livingslimes.settings.spawn_chance_docile,
  spawn_cap = 2,
  spawn_biomes = {
    "swamp",
    "alderswamp",
    "naturalbiomes:alderswamp",
    "marsh",
    "Swampland",
    "MangroveSwamp",
  },
  spawn_nodes = {
    "group:soil",
    "group:water",
  },
  min_height = 0,
  max_height = 31000,
  min_light = 0,
  max_light = 16,
  min_group = 1,
  max_group = 2,

  -- Drops properties
  edible = 1,
  harmful = 0,
  drops = (function()
    local d = {}

    if livingslimes.dependencies.default then
      d[#d + 1] = {
        name = "flowers:mushroom_red",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    if livingslimes.dependencies.mcl_mushrooms then
      d[#d + 1] = {
        name = "mcl_mushrooms:mushroom_red",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    return d
  end)(),
})