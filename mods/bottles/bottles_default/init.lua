bottles.register_filled_bottle({
  target = {"default:water_source","default:water_flowing"},
  sound = "default_water_footstep",
  name = "bottle_of_water",
  description = "Bottle of Water",
})

bottles.register_filled_bottle({
  target = {"default:river_water_source","default:river_water_flowing"},
  sound = "default_water_footstep",
  name = "bottle_of_river_water",
  description = "Bottle of River Water",
})

bottles.register_filled_bottle({
  target = {"default:lava_source","default:lava_flowing"},
  sound = "default_water_footstep",
  name = "bottle_of_lava",
  description = "Bottle of Lava",
})

bottles.register_filled_bottle({
  target = "default:sand",
  sound = "default_sand_footstep",
})

bottles.register_filled_bottle({
  target = "default:desert_sand",
  sound = "default_sand_footstep",
})

bottles.register_filled_bottle({
  target = "default:silver_sand",
  sound = "default_sand_footstep",
})

bottles.register_filled_bottle({
  target = "default:dirt",
  sound = "default_dig_crumbly",
})

bottles.register_filled_bottle({
  target = "default:dry_dirt",
  sound = "default_dig_crumbly",
  name = "bottle_of_dry_dirt",
  description = "Bottle of Dry Dirt",
})

bottles.register_filled_bottle({
  target = "default:dirt_with_grass",
  sound = "default_grass_footstep",
  name = "bottle_of_grass",
  description = "Bottle of Grass",
  replacement = "default:dirt",
})

bottles.register_filled_bottle({
  target = {"default:dirt_with_dry_grass","default:dry_dirt_with_dry_grass"},
  sound = "default_grass_footstep",
  name = "bottle_of_dry_grass",
  description = "Bottle of Dry Grass",
  replacement = "default:dry_dirt",
})

bottles.register_filled_bottle({
  target = "default:dirt_with_coniferous_litter",
  sound = "default_grass_footstep",
  name = "bottle_of_coniferous_litter",
  description = "Bottle of Coniferous Litter",
  replacement = "default:dirt",
})

bottles.register_filled_bottle({
  target = "default:dirt_with_rainforest_litter",
  sound = "default_grass_footstep",
  name = "bottle_of_rainforest_litter",
  description = "Bottle of Rainforest Litter",
  replacement = "default:dirt",
})

bottles.register_filled_bottle({
  target = "default:permafrost_with_moss",
  sound = "default_grass_footstep",
  name = "bottle_of_moss",
  description = "Bottle of Tundra Moss",
  replacement = "default:permafrost_with_stones",
})

bottles.register_filled_bottle({
  target = "default:gravel",
  sound = "default_gravel_footstep",
})

bottles.register_filled_bottle({
  target = {"default:snow","default:snowblock","default:dirt_with_snow"},
  sound = "default_sand_footstep",
})

bottles.register_filled_bottle({
  target = {"default:clay"},
})