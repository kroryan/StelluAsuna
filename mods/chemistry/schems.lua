
local path = minetest.get_modpath("chemistry") .. "/schematics/"

dofile(path .. "volcanoes.lua")
dofile(path .. "trees.lua")
dofile(path .. "ponds.lua")

minetest.register_decoration({
   sidelen = 80,
	name = "chemistry:cesium_volcano",
	deco_type = "schematic",
	place_on = "chemistry:alkaline_sand",
   y_max = 40,
   y_min = 0,
	fill_ratio = 0.0015,
   flags = "place_center_x, place_center_z",
	biomes = {"alkaline_desert"},
	schematic = chemistry.cesium_volcano,
	spawn_by = "chemistry:alkaline_sand", num_spawn_by = 4,
	rotation = "random"
})
minetest.register_decoration({
   sidelen = 80,
	name = "chemistry:metal_volcano1",
	deco_type = "schematic",
	place_on = "chemistry:stone",
   y_max = -11000,
   y_min = -31000,
	flags = "all_floors, place_center_x, place_center_z",
	fill_ratio = 0.00003,
	biomes = {"strong_stone_layer"},
	schematic = chemistry.metal_volcano1,
	spawn_by = "chemistry:stone", num_spawn_by = 1,
	rotation = "random"
})
minetest.register_decoration({
   sidelen = 80,
	name = "chemistry:metal_volcano2",
	deco_type = "schematic",
	place_on = "chemistry:stone",
   y_max = -11000,
   y_min = -31000,
	flags = "all_floors, place_center_x, place_center_z",
	fill_ratio = 0.00003,
	biomes = {"strong_stone_layer"},
	schematic = chemistry.metal_volcano2,
	spawn_by = "chemistry:stone", num_spawn_by = 1,
	rotation = "random"
})
minetest.register_decoration({
   sidelen = 80,
	name = "chemistry:metal_volcano3",
	deco_type = "schematic",
	place_on = "chemistry:stone",
   y_max = -11000,
   y_min = -31000,
	flags = "all_floors, place_center_x, place_center_z",
	fill_ratio = 0.00003,
	biomes = {"strong_stone_layer"},
	schematic = chemistry.metal_volcano3,
	spawn_by = "chemistry:stone", num_spawn_by = 1,
	rotation = "random"
})
minetest.register_decoration({
   sidelen = 80,
	name = "chemistry:metal_volcano4",
	deco_type = "schematic",
	place_on = "chemistry:stone",
   y_max = -11000,
   y_min = -31000,
	flags = "all_floors, place_center_x, place_center_z",
	fill_ratio = 0.00003,
	biomes = {"hot_strong_cave"},
	schematic = chemistry.metal_volcano4,
	spawn_by = "chemistry:stone", num_spawn_by = 1,
	rotation = "random"
})
minetest.register_decoration({
   sidelen = 80,
	name = "chemistry:metal_volcano5",
	deco_type = "schematic",
	place_on = "chemistry:stone",
   y_max = -11000,
   y_min = -31000,
	flags = "all_floors, place_center_x, place_center_z",
	fill_ratio = 0.00003,
	biomes = {"hot_strong_cave"},
	schematic = chemistry.metal_volcano5,
	spawn_by = "chemistry:stone", num_spawn_by = 1,
	rotation = "random"
})
minetest.register_decoration({
   sidelen = 80,
	name = "chemistry:st_volcano",
	deco_type = "schematic",
	place_on = "chemistry:stone",
   y_max = -11000,
   y_min = -31000,
	flags = "all_floors, place_center_x, place_center_z",
	fill_ratio = 0.00003,
	biomes = {"hot_strong_cave"},
	schematic = chemistry.st_volcano,
	spawn_by = "chemistry:stone", num_spawn_by = 1,
	rotation = "random"
})
minetest.register_decoration({
	name = "chemistry:ionized_tree",
	deco_type = "schematic",
	place_on = {"chemistry:dirt_with_uranium"},
	sidelen = 16,
	noise_params = {
		offset = 0.024,
		scale = 0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"ionized_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = chemistry.ionized_tree,
	flags = "place_center_x, place_center_z",
	rotation = "random",
})


minetest.register_decoration({
	name = "chemistry:chestnut_tree",
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.024,
		scale = 0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"chestnut_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = chemistry.chestnut_tree,
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	name = "chemistry:anthracite_tree",
	deco_type = "schematic",
	place_on = {"chemistry:stone"},
	sidelen = 80,
	fill_ratio = 0.009,
	biomes = {"strong_stone_forest"},
	y_max = -11000,
	y_min = -31000,
	schematic = chemistry.anthracite_tree,
	flags = "all_floors, place_center_x, place_center_z",
	rotation = "random",
	place_offset_y=1
})

minetest.register_decoration({
	name = "chemistry:ash_tree",
	deco_type = "schematic",
	place_on = {"chemistry:dirt_with_ash"},
	sidelen = 16,
	noise_params = {
		offset = 0.024,
		scale = 0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"ash_forest"},
	y_max = 31000,
	y_min = 26,
	schematic = chemistry.ash_tree,
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	name = "chemistry:ash_tree",
	deco_type = "schematic",
	place_on = {"chemistry:dirt_with_ash"},
	sidelen = 16,
	fill_ratio = 0.001,
	noise_params = {
		offset = 0.024,
		scale = 0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"ash_plains"},
	y_max = 26,
	y_min = 1,
	schematic = chemistry.ash_tree,
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"group:alkaline_sand"},
	sidelen = 80, 
	fill_ratio = 0.0015, 
	y_min = 0, 
	y_max = 25,
	biomes = {"alkaline_desert"},
	decoration = {"chemistry:pond1"},
	spawn_by = "group:alkaline_sand", num_spawn_by = 8
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"group:strong_stone"},
	sidelen = 80, 
	fill_ratio = 0.00009, 
	y_min = -31000, 
	y_max = -20000,
	flags = "all_floors, force_placement",
	biomes = {"strong_stone_layer", "hot_strong_cave"},
	decoration = {"chemistry:pond2"},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"chemistry:dirt_with_ash"},
	sidelen = 80, 
	fill_ratio = 0.0015, 
	y_min = 0, 
	y_max = 25,
	biomes = {"ash_plains"},
	decoration = {"chemistry:pond3"},
	spawn_by = "chemistry:dirt_with_ash", num_spawn_by = 8
})
