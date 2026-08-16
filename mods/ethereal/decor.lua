-- register decoration helper

local function register_decoration(enabled, def)

	if enabled ~= 1 then return end

	def.sidelen = def.sidelen or 80 -- some handy defaults
	def.deco_type = "simple"
	def.y_min = def.y_min or 1
	def.y_max = def.y_max or 31000

	core.register_decoration(def)
end

-- water pools in swamp areas

register_decoration(1, {
	place_on = {"default:dirt_with_grass"},
	sidelen = 4, fill_ratio = 0.02, y_min = 1, y_max = 3,
	biomes = {"swamp","marsh"},
	flags = "force_placement",
	decoration = "default:water_source", place_offset_y = -1,
	spawn_by = "default:dirt_with_grass", num_spawn_by = 8})

register_decoration(1, {
	place_on = {"default:dirt_with_grass"},
	sidelen = 4, fill_ratio = 0.33, y_min = 1, y_max = 32,
	biomes = {"marsh"},
	flags = "force_placement",
	decoration = "default:water_source", place_offset_y = -1,
	spawn_by = {"default:dirt_with_grass", "default:water_source"}, num_spawn_by = 8})

-- dry dirt patches

register_decoration(1, {
	place_on = {"default:dry_dirt_with_dry_grass"},
	sidelen = 4,
	noise_params = {offset = -1.5, scale = -1.5, spread = {x = 200, y = 200, z = 200},
			seed = 329, octaves = 4, persist = 1.0},
	biomes = {"plains"},
	decoration = "default:dry_dirt", place_offset_y = -1,
	flags = "force_placement"
})

-- rainforest litter in grove biome

register_decoration(1, {
	place_on = {"ethereal:grove_dirt"},
	sidelen = 4,
	noise_params = {offset = -0.0025, scale = 0.5, spread = {x = 100, y = 100, z = 100},
			seed = 329, octaves = 1, persist = 1.0},
	biomes = {"grove"},
	decoration = "default:dirt_with_rainforest_litter", place_offset_y = -1,
	flags = "force_placement"
})

-- farming redo check, salt crystal if found, strawberry if not

if core.get_modpath("farming") and farming.mod and farming.mod == "redo" then

	register_decoration(ethereal.grayness, {
		place_on = "default:silver_sand",
		fill_ratio = 0.001,
		decoration = "farming:salt_crystal"})
else
	register_decoration(1, {
		place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		sidelen = 16, y_min = 15, y_max = 55,
		noise_params = {offset = 0, scale = 0.002, spread = {x = 100, y = 100, z = 100},
				seed = 143, octaves = 3, persist = 0.6},
		decoration = "ethereal:strawberry_7"})
end

-- firethorn shrub

register_decoration(ethereal.glacier, {
	place_on = "default:snowblock",
	fill_ratio = 0.001, y_min = 1, y_max = 30,
	biomes = {"glacier"},
	decoration = "ethereal:firethorn"})

-- Special orange baked clay surface decor for mesa

register_decoration(ethereal.mesa,{
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 2,
	noise_params = {
		offset = -1,
		scale = -1.25,
		spread = {x = 100, y = 100, z = 100},
		seed = 4,
		octaves = 4,
		persist = 1.0
	},
	biomes = {"mesa"},
	y_max = 31000,
	y_min = 1,
	decoration = "bakedclay:orange",
	place_offset_y = -1,
	flags = "force_placement"
})

-- dry grass

register_decoration(ethereal.savanna, {
	place_on = {"default:dry_dirt_with_dry_grass", "default:dirt_with_dry_grass"},
	fill_ratio = 0.25,
	biomes = {"savanna"},
	decoration = {"default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4",
			"default:dry_grass_5"}})

register_decoration(ethereal.plains, {
	place_on = {"default:dry_dirt_with_dry_grass"},
	fill_ratio = 0.875,
	biomes = {"mesa_redwood"},
	decoration = {"default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4",
			"default:dry_grass_5","default:grass_1"}})

register_decoration(ethereal.mesa, {
	place_on = {"default:dirt_with_dry_grass"},
	fill_ratio = 0.25,
	biomes = {"mesa"},
	decoration = {"default:dry_grass_2", "default:dry_grass_3", "default:dry_grass_4",
			"default:dry_grass_5"}})

-- scorched tree

register_decoration(ethereal.fiery, {
	place_on = {"ethereal:fiery_dirt"},
	fill_ratio = 0.000275,
	biomes = {"fiery"},
	decoration = "ethereal:scorched_tree",
	height_max = 6})

-- fiery lava pits

register_decoration(ethereal.fiery, {
	place_on = {"ethereal:fiery_dirt"},
	place_offset_y = -1,
	spawn_by = "ethereal:fiery_dirt",
	num_spawn_by = 7,
	sidelen = 8,
	noise_params = {
		offset = 0.0125,
		scale = 0.025,
		spread = {x = 50, y = 50, z = 50},
		seed = 909,
		octaves = 2,
		persist = 1.0
	},
	biomes = {"fiery"},
	decoration = "default:lava_source",
	flags = "force_placement"})

-- dry shrub
register_decoration(ethereal.plains, {
	place_on = {"default:dry_dirt"},
	fill_ratio = 0.005,
	biomes = {"plains"},
	decoration = "default:dry_shrub"})

register_decoration(ethereal.jumble, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.00325,
	biomes = {"jumble"},
	decoration = "default:dry_shrub"})

register_decoration(ethereal.desert, {
	place_on = {"default:desert_sand"},
	fill_ratio = 0.0025,
	biomes = {"desert"},
	decoration = "default:dry_shrub"})

register_decoration(ethereal.sandstone, {
	place_on = {"default:sand"},
	fill_ratio = 0.0025,
	y_min = 5,
	biomes = {"sandstone_desert"},
	decoration = "default:dry_shrub"})

register_decoration(ethereal.mesa, {
	place_on = {"bakedclay:red","bakedclay:orange"},
	fill_ratio = 0.015,
	biomes = {"mesa"},
	decoration = "default:dry_shrub"})

register_decoration(ethereal.caves, {
	place_on = {"default:desert_stone"},
	fill_ratio = 0.005, y_min = 5, y_max = 42,
	biomes = {"caves"},
	decoration = {"default:dry_grass_2", "default:dry_grass_3", "default:dry_shrub"}})

-- crystal spike & grass

register_decoration(ethereal.frost, {
	place_on = {"ethereal:crystal_dirt"},
	fill_ratio = 0.02, y_min = 1, y_max = 1750,
	biomes = {"frost", "frost_floatland"},
	decoration = {"ethereal:crystal_spike", "ethereal:crystalgrass"}})

-- red shrub

register_decoration(ethereal.fiery, {
	place_on = {"ethereal:fiery_dirt"},
	fill_ratio = 0.10,
	biomes = {"fiery"},
	decoration = "ethereal:dry_shrub"})

-- snowy grass

register_decoration(ethereal.snowy, {
	place_on = {"ethereal:gray_dirt"},
	fill_ratio = 0.175,
	biomes = {"grayness"},
	decoration = "ethereal:snowygrass"})

-- cactus

register_decoration(1,{
	name = node,
	deco_type = "simple",
	sidelen = 8,
	place_on = {
		"default:desert_sand",
		"default:sand",
	},
	noise_params = {
		offset = -0.0069,
		scale = 0.0175,
		spread = {x = 8, y = 8, z = 8},
		seed = 60659,
		octaves = 2,
		persist = 0.7625,
		lacunarity = 0.6,
	},
	y_max = 31000,
	y_min = 1,
	biomes = {
		"desert",
		"sandstone_desert",
	},
	height_max = 4,
	decoration = "default:cactus",
})

-- wild red mushroom

register_decoration(ethereal.mushroom, {
	place_on = {"ethereal:mushroom_dirt"},
	fill_ratio = 0.25,
	biomes = {"mushroom"},
	decoration = "flowers:mushroom_red"})

-- spore grass

register_decoration(ethereal.mushroom, {
	place_on = {"ethereal:mushroom_dirt"},
	fill_ratio = 0.175,
	biomes = {"mushroom"},
	decoration = "ethereal:spore_grass"})

-- slime mold

register_decoration(ethereal.mushroom, {
	place_on = {"default:clay"},
	sidelen = 16,
	noise_params = {
		offset = -0.0125,
		scale = 0.0325,
		spread = {x = 80, y = 20, z = 80},
		seed = 357,
		octaves = 2,
		persistence = 0.6,
	}, y_min = 1, y_max = 5,
	biomes = {"mushroom_shore"},
	decoration = "ethereal:slime_mold"})

-- red & brown mushroom

register_decoration(1,{
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass",
		"default:dirt_with_rainforest_litter",
		"ethereal:prairie_dirt",
		"ethereal:mushroom_dirt",
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.009,
		spread = {x = 200, y = 200, z = 200},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {
		"rainforest",
		"deciduous_forest",
		"grassytwo",
		"prairie",
		"swamp",
		"marsh",
		"mushroom",
	},
	decoration = {"flowers:mushroom_brown", "flowers:mushroom_red"}
})

-- stumps

register_decoration(ethereal.jumble, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.00175,
	biomes = {"jumble"},
	y_min = 4,
	decoration = "default:tree",
	height_max = 4})

-- jungle grass

register_decoration(ethereal.junglee, {
	place_on = {"default:dirt_with_rainforest_litter"},
	fill_ratio = 0.1,
	biomes = {"rainforest"},
	decoration = "default:junglegrass"})

register_decoration(ethereal.jumble, {
	place_on = {"default:dirt_with_rainforest_litter"},
	fill_ratio = 0.1,
	biomes = {"jumble", "grove"},
	decoration = "default:junglegrass"})

register_decoration(ethereal.swamp, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.25,
	biomes = {"swamp","marsh"},
	decoration = "default:junglegrass"})

-- grass

register_decoration(ethereal.grassy, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.35,
	biomes = {"deciduous_forest"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

register_decoration(ethereal.grassytwo, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.35,
	biomes = {"grassytwo"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

register_decoration(ethereal.jumble, {
	place_on = {"default:dirt_with_grass","default:dirt_with_rainforest_litter"},
	fill_ratio = 0.35,
	biomes = {"jumble"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

register_decoration(ethereal.junglee, {
	place_on = {"default:dirt_with_rainforest_litter"},
	fill_ratio = 0.35,
	biomes = {"rainforest"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

register_decoration(ethereal.grove, {
	place_on = {"ethereal:grove_dirt","default:dirt_with_rainforest_litter"},
	fill_ratio = 0.375,
	biomes = {"grove"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

register_decoration(ethereal.mediterranean, {
	place_on = {"ethereal:grove_dirt"},
	fill_ratio = 0.35,
	biomes = {"mediterranean"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

register_decoration(ethereal.bamboo, {
	place_on = {"ethereal:bamboo_dirt"},
	fill_ratio = 0.35,
	biomes = {"bamboo"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

register_decoration(1, {
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.35,
	biomes = {"grassland","swamp","marsh"},
	decoration = {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}})

-- ferns

register_decoration(ethereal.grove, {
	place_on = {"default:dirt_with_rainforest_litter", "ethereal:grove_dirt"},
	fill_ratio = 0.2,
	biomes = {"grove"},
	decoration = "ethereal:fern"})

-- snow

register_decoration(1,{
	deco_type = "simple",
	place_on = "default:dirt_with_coniferous_litter",
	sidelen = 40,
	noise_params = {
		offset = 0.2,
		scale = 0.2,
		spread = {x = 100, y = 100, z = 100},
		seed = 2,
		octaves = 2,
		persist = 1.0
	},
	biomes = {"coniferous_forest"},
	decoration = "default:snow",
})

register_decoration(ethereal.alpine, {
	place_on = {"default:dirt_with_snow"},
	fill_ratio = 0.8, y_min = 40, y_max = 140,
	biomes = {"taiga"},
	decoration = "default:snow"})

-- wild onion and setting

local abundant = core.settings:get_bool("ethereal.abundant_onions") ~= false

-- wild onion

register_decoration(1,asuna.features.crops.onion.inject_decoration({
	deco_type = "simple",
	sidelen = 8,
	place_on = {"group:soil"},
	noise_params = {
			offset = -0.4125,
			scale = 0.3575,
			spread = {x = 14, y = 14, z = 14},
			seed = seed,
			octaves = 2,
			persist = 0.62,
			lacunarity = 0.675,
	},
	y_max = 31000,
	y_min = 1,
	decoration = {
			"ethereal:onion_3",
			"ethereal:onion_4",
			"ethereal:onion_5",
	},
}))

-- papyrus

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
	fill_ratio = 0.125, y_min = 1, y_max = 32,
	biomes = {"rainforest", "swamp", "marsh"},
	decoration = "default:papyrus", height_max = 4,
	spawn_by = "default:water_source", num_spawn_by = 1})

-- blue agave from wine mod

if minetest.get_modpath("wine") then
  
  register_decoration(ethereal.desert, {
    place_on = {"default:desert_sand"},
    sidelen = 16, fill_ratio = 0.001,
    biomes = {"desert"},
    decoration = {"wine:blue_agave"}})
end

-- default ferns

register_decoration(1, {
	place_on = {"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"},
	sidelen = 16, fill_ratio = 0.2,
	decoration = {"default:fern_1", "default:fern_2", "default:fern_3"} })

-- Tundra moss

register_decoration(ethereal.tundra, {
	place_on = {"default:permafrost_with_stones"},
	sidelen = 4, y_min = 2, y_max = 50,
	noise_params = {offset = -0.8, scale = 2.0, spread = {x = 100, y = 100, z = 100},
			seed = 53995, octaves = 3, persist = 1.0},
	biomes = {"tundra"},
	decoration = "default:permafrost_with_moss", place_offset_y = -1,
	flags = "force_placement"})

-- Tundra patchy snow

register_decoration(ethereal.tundra, {
	place_on = {"default:permafrost_with_moss", "default:permafrost_with_stones",
			"default:stone", "default:gravel"},
	sidelen = 4, y_min = 1, y_max = 50,
	noise_params = {offset = 0, scale = 1.0, spread = {x = 100, y = 100, z = 100},
			seed = 172555, octaves = 3, persist = 1.0},
	biomes = {"tundra", "tundra_shore"},
	decoration = "default:snow"})

-- Tundra very sparse grass and dry shrubs

register_decoration(1,{
  deco_type = "simple",
  place_on = {
    "default:permafrost_with_moss",
  },
  sidelen = 16,
  fill_ratio = 0.01,
  biomes = {"tundra"},
  y_max = 50,
  y_min = 1,
  decoration = {
    "default:grass_1",
    "default:dry_shrub",
  },
})

-- Coral Reef

register_decoration(1,{
  name = "default:corals",
  deco_type = "simple",
  place_on = {
    "default:sand",
    "everness:mineral_sand",
  },
  place_offset_y = -1,
  sidelen = 4,
  noise_params = {
    offset = -3,
    scale = 4,
    spread = {x = 50, y = 50, z = 50},
    seed = 7013,
    octaves = 3,
    persist = 0.7,
  },
  biomes = asuna.features.ocean.tropical,
  y_max = -2,
  y_min = -36,
  flags = "force_placement",
  decoration = {
    "default:coral_green", "default:coral_pink",
    "default:coral_cyan", "default:coral_brown",
    "default:coral_orange", "default:coral_skeleton"
  }
})

-- Kelp

register_decoration(1,{
  deco_type = "simple",
  place_on = {
    "default:sand",
    "everness:mineral_sand",
  },
  place_offset_y = -1,
  sidelen = 16,
  noise_params = {
    offset = -0.04,
    scale = 0.2,
    spread = {x = 200, y = 200, z = 200},
    seed = 87112,
    octaves = 3,
    persist = 0.7
  },
  biomes = asuna.biome_groups.below,
  y_max = -5,
  y_min = -36,
  flags = "force_placement",
  decoration = "default:sand_with_kelp",
  param2 = 48,
  param2_max = 96
})

-- illumishrooms using underground decoration placement

local function add_illumishroom(low, high, nodename)

	register_decoration(1, {
		place_on = {"default:stone_with_coal"},
		sidelen = 16, fill_ratio = 0.5, y_min = low, y_max = high,
		flags = "force_placement, all_floors",
		decoration = nodename})
end

add_illumishroom(-1000, -50, "ethereal:illumishroom")
add_illumishroom(-2000, -1000, "ethereal:illumishroom2")
add_illumishroom(-3000, -2000, "ethereal:illumishroom3")

--= Register Biome Decoration Using Plants Mega Pack Lite if Xanadu found

if core.get_modpath("xanadu") then

	--= Desert Biome

	-- Cactus
	register_decoration(1, {
		place_on = {"default:desert_sand", "default:sandstone"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"desert", "sandstone_desert"},
		decoration = {"xanadu:cactus_echinocereus", "xanadu:cactus_matucana",
				"xanadu:cactus_baseball", "xanadu:cactus_golden"}})

	-- Desert Plants
	register_decoration(1, {
		place_on = {"default:desert_sand", "default:sandstone", "default:sand"},
		sidelen = 16, fill_ratio = 0.004,
		biomes = {"desert", "sandstone_desert"},
		decoration = {"xanadu:desert_kangaroo", "xanadu:desert_brittle",
				"xanadu:desert_ocotillo", "xanadu:desert_whitesage"}})

	--=  Prairie Biome

	-- Grass
	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo"},
		decoration = {"xanadu:grass_prairie", "xanadu:grass_cord",
				"xanadu:grass_wheatgrass", "xanadu:desert_whitesage"}})

	-- Flowers
	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass",
				"ethereal:grove_dirt", "ethereal:bamboo_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo", "bamboo"},
		decoration = {"xanadu:flower_jacobsladder", "xanadu:flower_thistle",
				"xanadu:flower_wildcarrot"}})

	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass",
				"ethereal:grove_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo", "grove"},
		decoration = {"xanadu:flower_delphinium", "xanadu:flower_celosia",
				"xanadu:flower_daisy", "xanadu:flower_bluerose"}})

	-- Shrubs
	register_decoration(1, {
		place_on = {"ethereal:prairie_dirt", "default:dirt_with_grass",
				"ethereal:grove_dirt", "ethereal:jungle_grass", "ethereal:gray_dirt",
				"default:dirt_with_rainforest_litter"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"prairie", "deciduous_forest", "grassytwo", "grove", "rainforest",
				"grayness", "jumble"},
		decoration = {"xanadu:shrub_kerria", "xanadu:shrub_spicebush"}})

	--= Jungle Biome

	register_decoration(1, {
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16, fill_ratio = 0.007,
		biomes = {"rainforest", "jumble"},
		decoration = {"xanadu:rainforest_guzmania", "xanadu:rainforest_devil",
				"xanadu:rainforest_lazarus", "xanadu:rainforest_lollipop",
				"xanadu:mushroom_woolly"}})

	--= Cold Biomes

	register_decoration(1, {
		place_on = {"default:dirt_with_snow", "ethereal:gray_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"coniferous_forest", "taiga", "grayness"},
		decoration = {"xanadu:mountain_edelweiss", "xanadu:mountain_armeria",
				"xanadu:mountain_bellflower", "xanadu:mountain_willowherb",
				"xanadu:mountain_bistort"}})

	--= Mushroom Biome

	register_decoration(1, {
		place_on = {"ethereal:mushroom_dirt"},
		sidelen = 16, fill_ratio = 0.005,
		biomes = {"mushroom"},
		decoration = {"xanadu:mushroom_powderpuff", "xanadu:mushroom_chanterelle",
				"xanadu:mushroom_parasol"}})

	--= Lakeside

	register_decoration(1, {
		place_on = {"default:sand", "default:dirt_with_grass"},
		sidelen = 16, fill_ratio = 0.015,
		biomes = {"deciduous_forest_ocean", "grassland", "grassytwo", "jumble",
				"swamp"},
		decoration = {"xanadu:wetlands_cattails", "xanadu:wetlands_pickerel",
				"xanadu:wetlands_mannagrass", "xanadu:wetlands_turtle"},
		spawn_by = "default:water_source", num_spawn_by = 1})

	--= Harsh Biomes

	register_decoration(1, {
		place_on = {"ethereal:mushroom_dirt", "default:dirt_with_grass",
				"ethereal:gray_dirt", "ethereal:dirt_with_snow", "ethereal:prairie_dirt",
				"ethereal:grove_dirt", "ethereal:dry_dirt", "ethereal:fiery_dirt",
				"default:sand", "default:desert_sand", "ethereal:bamboo_dirt",
				"default:dirt_with_rainforest_litter", "default:permafrost_with_stones"},
		sidelen = 16, fill_ratio = 0.004,
		biomes = {"mushroom", "prairie", "grayness", "plains", "desert", "rainforest",
				"deciduous_forest", "grassytwo", "jumble", "coniferous_forest", "taiga",
				"fiery", "mesa", "bamboo", "tundra"},
		decoration = {"xanadu:spooky_thornbush", "xanadu:spooky_baneberry"}})

		--= Poppy's growing in Clearing Biome in memory of RealBadAngel

		register_decoration(1, {
			place_on = {"default:dirt_with_grass"},
			sidelen = 16, fill_ratio = 0.004,
			biomes = {"grassland"},
			decoration = {"xanadu:poppy"}})
end
