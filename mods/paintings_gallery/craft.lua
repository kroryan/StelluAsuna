if minetest.get_modpath("default") ~= nil then

	if minetest.get_modpath("dye") ~= nil then

		if minetest.get_modpath("wool") ~= nil then

-- The Basics

minetest.register_craft({
	output = "paintings_lib:1x1_blank1x1",
	recipe = {
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "group:wool", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_blank1x2",
	recipe = {
		{"paintings_lib:1x1_blank1x1"},
		{"paintings_lib:1x1_blank1x1"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_blank2x1",
	recipe = {
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_blank2x2",
	recipe = {
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_blank3x2",
	recipe = {
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_blank3x3",
	recipe = {
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
		{"paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1", "paintings_lib:1x1_blank1x1"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_blank4x2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", "paintings_lib:2x2_blank2x2"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_blank4x3",
	recipe = {
		{"paintings_lib:3x2_blank3x2", "paintings_lib:3x2_blank3x2"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_blank4x4",
	recipe = {
		{"paintings_lib:2x2_blank2x2", "paintings_lib:2x2_blank2x2"},
		{"paintings_lib:2x2_blank2x2", "paintings_lib:2x2_blank2x2"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_blank4x4",
	recipe = {
		{"paintings_lib:4x2_blank4x2"},
		{"paintings_lib:4x2_blank4x2"},
	}
})

-- The Paintings

-- 1x1

minetest.register_craft({
	output = "paintings_lib:1x1_blue_vase",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:blue", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_blue_vase_2",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:grey", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_cello",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:brown", "dye:dark_grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_cyan",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:cyan", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_exoplanet",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:cyan", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_exoplanet_2",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:orange", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_fajita",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:blue", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_highway",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:yellow", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_hills",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:white", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_larc_triumph",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:yellow", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_last_sunrise",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:red", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_lit_vase",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:white", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_minds_eye",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:cyan", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_ocean_rock",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:violet", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_painting",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:red", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_penguin",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:yellow", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_roses",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:white", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_seaside_paradise",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:blue", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_the_darkness",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:brown", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_tree_2",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:dark_green", "dye:green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_ufo",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:black", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x1_blue_vase",
	recipe = {
		{"paintings_lib:1x1_blank1x1", ""},
		{"dye:cyan", "dye:dark_grey"},
	}
})

-- 1x2

minetest.register_craft({
	output = "paintings_lib:1x2_abstract_expression",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:cyan", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_action_figure",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:brown", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_cat",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:black", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_evil_elf",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:pink", "dye:dark_grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_hungry",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:yellow", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_metal_sky",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:red", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_octopus",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:magenta", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_parrot_4",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:blue", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_poseidon",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:cyan", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_river",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:black", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_spicy",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:grey", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_time",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:grey", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:1x2_waterfall_2",
	recipe = {
		{"paintings_lib:1x2_blank1x2", ""},
		{"dye:white", "dye:cyan"},
	}
})

-- 2x1

minetest.register_craft({
	output = "paintings_lib:2x1_aurora",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:cyan", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_car_7",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:grey", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_jungle",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:green", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_metal_river",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:grey", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_mountain_landscape",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:white", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_pixel_punk",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:magenta", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_seafloor",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:blue", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_ufo_2",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:white", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_valley_2",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:brown", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x1_waterfall",
	recipe = {
		{"paintings_lib:2x1_blank2x1", ""},
		{"dye:dark_green", "dye:dark_green"},
	}
})

-- 2x2

minetest.register_craft({
	output = "paintings_lib:2x2_abstract_man",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:red", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_asia",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:cyan", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_baroque_cyborg",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:yellow", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_battle",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:cyan", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_bird",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:brown", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_bonzai",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:white", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_burning_cabin",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:orange", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_businessman",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:orange", "dye:dark_grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_cello_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:brown", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_cello_3",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:violet", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_exoplanet_3",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:blue", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_exoplanet_4",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:red", "dye:violet"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_fire_viking",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:orange", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_fishbowl",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:yellow", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_fishbowl_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:black", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_gingerbread_house",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:white", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_hamburger",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:grey", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_king",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:blue", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_larc_triumph_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:brown", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_lighthouse",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:blue", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_lumina",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:black", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_map_4",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:dark_green", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_mountain",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:brown", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_mushroom_city_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:blue", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_octopus_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:dark_green", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_panther",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:white", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_parrot_3",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:yellow", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_pixel_punk_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:yellow", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_pixel_punk_3",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:white", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_poseidon_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:white", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_rain",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:grey", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_red_dog",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:cyan", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_rooftop",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:yellow", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_skull_cuttingboard",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:white", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_stallman",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:black", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_super_saturn",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:violet", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_the_walk",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:dark_green", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_tree_2",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:dark_green", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_utah",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:brown", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_war_unicorn",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:grey", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_waterfall_6",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:cyan", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:2x2_wildfire",
	recipe = {
		{"paintings_lib:2x2_blank2x2", ""},
		{"dye:brown", "dye:orange"},
	}
})

-- 3x2

minetest.register_craft({
	output = "paintings_lib:3x2_billboard",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:red", "dye:green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_car_8",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:dark_grey", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_car_9",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:yellow", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_dangerous_seas",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:yellow", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_future_ruins",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:grey", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_galaxy",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:black", "dye:violet"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_japan",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:dark_green", "dye:pink"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_skull_sea",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:cyan", "dye:pink"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_solar_flare",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:black", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_space_machine",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:cyan", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_the_lake",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:brown", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x2_wolf",
	recipe = {
		{"paintings_lib:3x2_blank3x2", ""},
		{"dye:dark_grey", "dye:yellow"},
	}
})

-- 3x3

minetest.register_craft({
	output = "paintings_lib:3x3_baroque_cyborg_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:brown", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_battle_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:blue", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_blue_vase_3",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:magenta", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_bridge",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:brown", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_cello_4",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:grey", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_corgi",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:yellow", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_circuit_city",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_civilization",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_fantasy_forest",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:dark_green", "dye:green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_fire_elk",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:black", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_fire_mage",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:black", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_flamingo",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:pink"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_gooseberry",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:green", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_gundam",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:dark_green", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_japan_4",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_japan_6",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:dark_green", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_map",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:yellow", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_meerkat",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:brown", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_metal_skull",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_mother_nature",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_mountain_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:dark_grey", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_natural_room",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:brown", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_os",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:black", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_otherworld",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:yellow", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_parrot",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:brown", "dye:green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_portal",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:grey", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_portrait",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:blue", "dye:pink"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_samurai",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:dark_grey", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_seafloor_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:red", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_sea_god",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:blue", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_shave_robot",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:green", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_shipwreck",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:blue", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_shipwreck_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_skull_roses",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:yellow", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_shipwreck",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:yellow", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_stallman_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:black", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_stone_carving",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:grey", "dye:dark_grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_sunrise",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:yellow", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_tank_top",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:brown", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_touch_it",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:orange", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_tree",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:grey", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_war_unicorn_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:cyan", "dye:violet"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_wolf_2",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:dark_grey", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_xenos_mechanica",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:red", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:3x3_yggdrasil",
	recipe = {
		{"paintings_lib:3x3_blank3x3", ""},
		{"dye:orange", "dye:cyan"},
	}
})

-- 4x2

minetest.register_craft({
	output = "paintings_lib:4x2_canada",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:dark_green", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_car",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:grey", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_car_5",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:grey", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_civilization_3",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:magenta", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_civilization_4",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:white", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_cube",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:black", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_japan_2",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:cyan", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_japan_5",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:dark_green", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_leaves",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:orange", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_mountain_landscape_2",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:brown", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_ruins",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:grey", "dye:pink"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_sunset_shore",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:cyan", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x2_waterfall_5",
	recipe = {
		{"paintings_lib:4x2_blank4x2", ""},
		{"dye:black", "dye:green"},
	}
})

-- 4x3

minetest.register_craft({
	output = "paintings_lib:4x3_alley",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:yellow", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_autumn",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:orange", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_car_2",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:cyan", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_car_6",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:grey", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_civilization_2",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:cyan", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_coral",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:red", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_dragon",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:black", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_dust_storm",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:brown", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_eiffel_aurora",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:green", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_harbour",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:grey", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_japan_3",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:dark_green", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_mountain_3",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:grey", "dye:pink"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_neon_city",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:blue", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_neon_planets",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:cyan", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_pyramid",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:orange", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_starry_city",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:blue", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_still_life",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:grey", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_tv_portal",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:white", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_village",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:brown", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x3_waterfall_4",
	recipe = {
		{"paintings_lib:4x3_blank4x3", ""},
		{"dye:blue", "dye:blue"},
	}
})

-- 4x4

minetest.register_craft({
	output = "paintings_lib:4x4_car_3",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:black", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_car_4",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:orange", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_cello_5",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:cyan"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_city_lights",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:orange", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_cyberpunk",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:red", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_depot",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:cyan", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_fishbowl_3",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:dark_green", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_fishbowl_4",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_galaxy_2",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:dark_green", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_general",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:cyan", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_gingerbread_house",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:white"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_hearthfire",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_intellectual",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:white", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_man",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:yellow", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_map_2",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:yellow", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_map_3",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:cyan", "dye:green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_map_5",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:cyan", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_metal_and_hope",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:blue", "dye:violet"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_mushroom_city",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:yellow"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_parrot_2",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:blue", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_parrot_5",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:blue", "dye:green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_pizza",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:orange", "dye:red"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_read",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:dark_grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_read_2",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_skeleton_flowers",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:yellow", "dye:magenta"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_steelrender",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:dark_grey", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_super_saturn",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:white", "dye:blue"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_the_machine",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:black"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_the_surface",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_the_walk",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:cyan", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_the_wreckage",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:grey", "dye:grey"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_tree_4",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:brown", "dye:pink"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_universe",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:orange", "dye:orange"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_war_unicorn_3",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:violet", "dye:brown"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_waterfall_3",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:white", "dye:dark_green"},
	}
})

minetest.register_craft({
	output = "paintings_lib:4x4_winter",
	recipe = {
		{"paintings_lib:4x4_blank4x4", ""},
		{"dye:white", "dye:white"},
	}
})

		end
	end
end
