-----------------------Trees
minetest.register_decoration({
    name = "badland:badland_tree_1",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    noise_params = {
        offset = 0.00125,
        scale = 0.0075,
        spread = {x = 80, y = 20, z = 80},
        seed = 777,
        octaves = 1,
    },
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/badland_tree_1.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "badland:badland_tree_2",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00025,
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/badland_tree_2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "badland:badland_tree_3",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    noise_params = {
        offset = 0.001,
        scale = 0.0025,
        spread = {x = 40, y = 40, z = 40},
        seed = 999,
        octaves = 1,
    },
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/badland_tree_3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "badland:badland_tree_4",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    noise_params = {
        offset = -0.005,
        scale = 0.01,
        spread = {x = 80, y = 20, z = 80},
        seed = 101010,
        octaves = 2,
        persistence = 0.5,
        lacunarity = 0.9,
    },
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/badland_tree_4.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

---------------------------------------Bush
minetest.register_decoration({
    name = "badland:badland_brush",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.008265,
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/badland_bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})
----------------------------------Log 1
minetest.register_decoration({
    name = "badland:badland_log_1",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.008265,
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/badland_log_1.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})
----------------------------------Log 2
minetest.register_decoration({
    name = "badland:badland_log_2",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.008265,
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/badland_log_2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})
---------------------Racine
minetest.register_decoration({
    name = "badland:racine_1",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.000665,
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/racine_1.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})
---------------------------Puit
minetest.register_decoration({
    name = "badland:puit_1",
    deco_type = "schematic",
    place_on = {"badland:badland_grass"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.000165,
    biomes = {"badland"},
    y_max = 31000,
    y_min = -20,
    schematic = minetest.get_modpath("badland").."/schematics/puit_1.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})
---------------------------Grass
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"badland:badland_grass"},
	sidelen = 16,
	fill_ratio = 0.35,
	biomes = {"badland"},
	decoration = {
        "badland:badland_grass_1", "badland:badland_grass_2", "badland:badland_grass_3", "badland:badland_grass_4", "badland:badland_grass_5",
	}
})
---------------------------Pumpkins
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"badland:badland_grass"},
	sidelen = 16,
	fill_ratio = 0.0025,
    param2 = 0,
    param2_max = 3,
	biomes = {"badland"},
	decoration = {
        "badland:pumpkin_block",
	}
})