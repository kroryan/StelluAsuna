livingslimes.register_slime("Mineral",{
  -- Mob Properties
  color = "#803010:220",
  size = 6,
  max_health = 30,
  damage = 3,
  speed = 3,
  tracking_range = 14,
  behaviors = {
    "wander",
    "neutral",
    "dig",
    "eat",
    "digest",
  },
  diet = {
    ["default:mese"] = 19,
    ["mcl_core:stone_with_diamond"] = 19,
    ["default:stone_with_diamond"] = 18,
    ["mcl_core:stone_with_emerald"] = 18,
    ["default:stone_with_mese"] = 17,
    ["mcl_core:stone_with_redstone"] = 17,
    ["mcl_core:stone_with_lapis"] = 17,
    ["mcl_core:stone_with_redstone"] = 17,
    ["default:stone_with_gold"] = 16,
    ["mcl_core:stone_with_gold"] = 16,
    ["default:stone_with_iron"] = 15,
    ["mcl_core:stone_with_iron"] = 15,
    ["default:stone_with_tin"] = 14,
    ["everness:quartz_ore"] = 14,
    ["everness:pyrite_ore"] = 14,
    ["default:stone_with_coal"] = 13,
    ["mcl_core:stone_with_coal"] = 13,
    ["group:stone"] = 12,
    ["group:sword"] = 10,
    ["group:pickaxe"] = 9,
    ["group:axe"] = 8,
    ["group:shovel"] = 7,
    ["group:hoe"] = 7,
  },

  -- Spawning properties
  spawn_chance = livingslimes.settings.spawn_chance_docile,
  spawn_cap = 2,
  spawn_nodes = {
    "group:stone",
    "group:soil",
  },
  min_height = -31000,
  max_height = -32,
  min_light = 0,
  max_light = 9,
  min_group = 1,
  max_group = 1,

  -- Drops properties
  edible = 2,
  harmful = 0,
  drops = (function()
    local d = {}

    if livingslimes.dependencies.default then
      d[#d + 1] = {
        name = "default:cobble",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    if livingslimes.dependencies.mcl_core then
      d[#d + 1] = {
        name = "mcl_core:cobble",
        min = 1,
        max = 1,
        chance = 10,
      }
    end

    return d
  end)(),
})