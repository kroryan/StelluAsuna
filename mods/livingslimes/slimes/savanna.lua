livingslimes.register_slime("Savanna",{
  -- Mob Properties
  color = "#dfbb30:180",
  size = 5,
  aquatic = false,
  max_health = 14,
  damage = 2,
  speed = 3.25,
  tracking_range = 13,
  behaviors = {
    "wander",
    "attack",
    "dig",
    "eat",
    "digest",
  },
  diet = {
    ["group:sword"] = 10,
    ["group:pickaxe"] = 9,
    ["group:axe"] = 8,
    ["group:shovel"] = 8,
    ["group:hoe"] = 8,
    ["group:grass"] = 5,
    ["group:food"] = 2,
    any = 1,
  },

  -- Spawning properties
  spawn_chance = livingslimes.settings.spawn_chance_hostile,
  spawn_cap = 1,
  spawn_biomes = {
    "savanna",
    "naturalbiomes:wetsavanna",
    "plains",
    "outback",
    "naturalbiomes:outback",
    "mesa",
    "everness_baobab_savanna",
    "everness:baobab_savanna",
    "Savanna",
    "SavannaM",
  },
  spawn_nodes = {
    "group:soil",
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
        name = "default:dry_grass_1",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    if livingslimes.dependencies.mcl_flowers then
      d[#d + 1] = {
        name = "mcl_flowers:tallgrass",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    return d
  end)(),
})