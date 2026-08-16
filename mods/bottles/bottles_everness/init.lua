for node,data in pairs({
  ["everness:coral_desert_stone_with_moss"] = { "Coral Cave Moss", "everness:coral_desert_stone" },
  ["everness:mold_stone_with_moss"] = { "Moldy Moss" },
  ["everness:coral_dirt"] = {},
  ["everness:cursed_dirt"] = {},
  ["everness:crystal_dirt"] = { "Crystal Dirt", "air", "everness_crystal_dirt" },
  ["everness:forsaken_tundra_dirt"] = {},
  ["everness:forsaken_tundra_dirt_with_grass"] = { "Forsaken Tundra Grass", "everness:forsaken_tundra_dirt" },
  ["everness:dirt_with_coral_grass"] = { "Coral Grass", "everness:coral_dirt" },
  ["everness:dirt_with_cursed_grass"] = { "Cursed Grass", "everness:cursed_dirt" },
  ["everness:dirt_with_crystal_grass"] = { "Crystal Grass", "everness:crystal_dirt" },
  ["everness:dry_ocean_dirt"] = {},
  ["everness:crystal_cave_dirt"] = {},
  ["everness:crystal_cave_dirt_with_moss"] = { "Crystal Cave Moss" },
  ["everness:moss_block"] = { "Moss" },
  ["everness:crystal_moss_block"] = { "Crystal Moss" },
  ["everness:coral_sand"] = {},
  ["everness:coral_white_sand"] = {},
  ["everness:cursed_sand"] = {},
  ["everness:crystal_sand"] = {},
  ["everness:forsaken_tundra_beach_sand"] = {},
  ["everness:forsaken_desert_sand"] = {},
  ["everness:coral_forest_deep_ocean_sand"] = {},
  ["everness:cursed_lands_deep_ocean_sand"] = {},
  ["everness:crystal_forest_deep_ocean_sand"] = {},
  ["everness:mineral_sand"] = {},
  ["everness:frosted_snowblock"] = { "Frosted Snow" },
  ["everness:cursed_mud"] = {},
  ["everness:mineral_lava_stone_with_moss"] = { "Mineral Cave Moss", "everness:mineral_cave_stone" }
}) do
  bottles.register_filled_bottle({
    name = data[3],
    target = node,
    description = data[1] and ("Bottle of " .. data[1]) or nil,
    replacement = data[2]
  })
end

-- Mineral water has an extra target
bottles.register_filled_bottle({
  target = {
    "everness:mineral_water_source",
    "everness:mineral_water_flowing",
  },
  description = "Bottle of Mineral Water",
})