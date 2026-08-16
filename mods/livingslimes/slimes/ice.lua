livingslimes.register_slime("Ice",{
  -- Mob Properties
  color = "#8BF:180",
  size = 5,
  aquatic = false,
  max_health = 14,
  damage = 2,
  speed = 3.25,
  tracking_range = 13,
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
    ["group:snowy"] = 5,
    ["group:food"] = 2,
    any = 1,
  },

  -- Spawning properties
  spawn_chance = livingslimes.settings.spawn_chance_hostile,
  spawn_cap = 1,
  spawn_biomes = {
    "tundra",
    "tundra_highland",
    "taiga",
    "coniferous_forest",
    "frost_land",
    "glacier",
    "everness_frosted_icesheet",
    "everness:frosted_icesheet",
    "icesheet",
    "snowy_grassland",
    "frost",
    "frost_floatland",
    "IcePlains",
    "IcePlainsSpikes",
    "ColdTaiga",
  },
  spawn_nodes = {
    "group:soil",
    "group:snowy",
    "group:ice",
  },
  min_height = 0,
  max_height = 31000,
  min_light = 0,
  max_light = 16,
  min_group = 1,
  max_group = 1,

  -- Drops properties
  edible = 2,
  harmful = 0,
  drops = (function()
    local d = {}

    if livingslimes.dependencies.default then
      d[#d + 1] = {
        name = "default:ice",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    if livingslimes.dependencies.mcl_core then
      d[#d + 1] = {
        name = "mcl_core:ice",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    return d
  end)(),
})