
-- path to default and ethereal schematics

local path = core.get_modpath("ethereal") .. "/schematics/"
local dpath = core.get_modpath("default") .. "/schematics/"

-- load schematic tables

dofile(path .. "orange_tree.lua")
dofile(path .. "banana_tree.lua")
dofile(path .. "bamboo_tree.lua")
dofile(path .. "birch_tree.lua")
dofile(path .. "bush.lua")
dofile(path .. "waterlily.lua")
dofile(path .. "volcanom.lua")
dofile(path .. "volcanol.lua")
dofile(path .. "frosttrees.lua")
dofile(path .. "palmtree.lua")
dofile(path .. "pinetree.lua")
dofile(path .. "yellowtree.lua")
dofile(path .. "mushroomone.lua")
dofile(path .. "mushroomtwo.lua")
dofile(path .. "willow.lua")
dofile(path .. "bigtree.lua")
dofile(path .. "redwood_tree.lua")
dofile(path .. "redwood_small_tree.lua")
dofile(path .. "vinetree.lua")
dofile(path .. "sakura.lua")
dofile(path .. "igloo.lua")
dofile(path .. "lemon_tree.lua")
dofile(path .. "olive_tree.lua")
dofile(path .. "basandra_bush.lua")
dofile(path .. "desertstone_spike.lua")
dofile(path .. "desertstone_under_spike.lua")
--dofile(path .. "pond.lua")

-- register decoration helper

local function register_decoration(enabled, def)

	if enabled ~= 1 then return end

	def.sidelen = def.sidelen or 80 -- some handy defaults
	def.deco_type = def.deco_type or "schematic"
	def.y_min = def.y_min or 1
	def.y_max = def.y_max or 31000
	def.flags = def.flags or "place_center_x, place_center_z"
	def.rotation = def.rotation or "random"

	core.register_decoration(def)
end

-- Special grass in jumble biome which must be place before schematics
register_decoration(ethereal.jumble, {
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter"},
	sidelen = 8,
	noise_params = {
		offset = -0.3125,
		scale = -1.25,
		spread = {x = 150, y = 100, z = 150},
		seed = 330,
		octaves = 3,
		persist = 0.95
	},
	biomes = {"jumble"},
	decoration = "default:dirt_with_grass",
	place_offset_y = -1,
	flags = "force_placement"
})

register_decoration(ethereal.bamboo, {
	name = "ethereal:small_sakura_tree",
	deco_type = "schematic",
	place_on = "ethereal:bamboo_dirt",
	sidelen = 80,
	fill_ratio = 0.00275,
	biomes = {"bamboo"},
	y_min = 5,
	y_max = 31000,
	schematic = path.."cherry_tree_1.mts",
	flags = "place_center_x,place_center_z",
	rotation = "random",
})

register_decoration(ethereal.bamboo, {
	name = "ethereal:large_sakura_tree",
	deco_type = "schematic",
	place_on = "ethereal:bamboo_dirt",
	sidelen = 80,
	fill_ratio = 0.000285,
	biomes = {"bamboo"},
	y_min = 5,
	y_max = 31000,
	schematic = path.."cherry_tree_2.mts",
	flags = "place_center_x,place_center_z",
	replacements = {
		["cherry:cherry_tree"] = "ethereal:sakura_trunk",
		["cherry:cherry_leaves"] = "ethereal:sakura_leaves",
	},
	rotation = "random",
})

if ethereal.bamboo == 1 then
	local did_sakura = minetest.get_decoration_id('ethereal:large_sakura_tree')
	minetest.set_gen_notify('decoration',{ did_sakura })
	did_sakura = 'decoration#' .. did_sakura

	minetest.register_on_generated(function(minp, maxp)
		if maxp.y > 4 then
			--
			-- Sakura Tree - fix light
			--
			local gennotify = minetest.get_mapgen_object('gennotify')
			for _, pos in ipairs(gennotify[did_sakura] or {}) do
				minetest.after(0.2,function() minetest.fix_light(pos:offset(-9, -1, -9), pos:offset(9, 20, 9)) end)
			end
		end
	end)

	minetest.register_abm({
		label = "Sakura petals",
		nodenames = {"ethereal:sakura_leaves"},
		interval = 6,
		chance = 25,
		catch_up = false,
		action = function(pos)
			minetest.add_particlespawner({
				amount = 1,
				time = 1,
				minpos = {x = pos.x, y = pos.y, z = pos.z},
				maxpos = {x = pos.x, y = pos.y, z = pos.z},
				minvel = {x = -0.75, y = -0.4, z = -0.75},
				maxvel = {x = 0.75, y = -0.2, z = 0.75},
				minacc = {x = -0.2, y = -0.4, z = -0.2},
				maxacc = {x = 0.2, y = -0.1, z = 0.2},
				minexptime = 8,
				maxexptime = 10,
				minsize = 1.5,
				maxsize = 1.75,
				texture = "cherry_leaves_particul.png",
				collisiondetection = true,
				collision_removal = true,
				vertical = false,
			})
		end,
	})
end

-- grove trees
for i,tree in ipairs({
	ethereal.bananatree,
	ethereal.orangetree,
	ethereal.lemontree,
}) do
	register_decoration(ethereal.grove, {
		deco_type = "schematic",
		sidelen = 16,
		place_on = {"ethereal:grove_dirt"},
		noise_params = {
			offset = -0.005,
			scale = 0.01125,
			spread = {x = 100, y = 20, z = 100},
			seed = 8888 - i,
			octaves = 1,
			persistence = 0.75,
			lacunarity = 0.9,
		},
		y_max = 31000,
		y_min = 5,
		biomes = {"grove"},
		schematic = tree,
	})
end

register_decoration(1, {
	deco_type = "schematic",
	sidelen = 16,
	place_on = {"group:soil"},
	noise_params = {
		offset = -0.005,
		scale = 0.00875,
		spread = {x = 100, y = 20, z = 100},
		seed = 76,
		octaves = 1,
		persistence = 0.75,
		lacunarity = 0.9,
	},
	y_max = 31000,
	y_min = 48,
	biomes = {
		"frost",
		"taiga",
		"glacier",
	},
	schematic = ethereal.yellowtree,
	flags = "place_center_x,place_center_z",
})

-- old biome setting (when enabled old heat/humidity values are used)

local old = core.settings:get_bool("ethereal.old_biomes")

-- desertstone spike

register_decoration(core.get_modpath("stairs") and ethereal.caves, {
	place_on = "default:desert_stone",
	sidelen = 16, fill_ratio = 0.01, y_min = 5, y_max = 42,
	biomes = {"caves"},
	schematic = ethereal.desertstone_spike,
	spawn_by = "default:desert_stone", num_spawn_by = 8,
	flags = "place_center_x, place_center_z, force_placement", rotation = "random"})

-- desertstone under spike

register_decoration(ethereal.caves, {
	place_on = "default:stone",
	sidelen = 16, fill_ratio = 0.01, y_min = 5, y_max = 42,
	biomes = {"caves"},
	schematic = ethereal.desertstone_under_spike,
	flags = "place_center_x, place_center_z, all_floors", rotation = "random"})

-- redwood tree

register_decoration(ethereal.mesa, {
	place_on = "default:dirt_with_dry_grass",
	fill_ratio = 0.000625,
	biomes = {"mesa"},
	schematic = ethereal.redwood_tree,
	flags = "place_center_x, place_center_z",
	spawn_by = "default:dirt_with_dry_grass", num_spawn_by = 8})

register_decoration(ethereal.mesa, {
	place_on = "default:dirt_with_dry_grass",
	fill_ratio = 0.000325,
	biomes = {"mesa"},
	schematic = ethereal.redwood_small_tree,
	flags = "place_center_x, place_center_z",
	spawn_by = "default:dirt_with_dry_grass", num_spawn_by = 8})

-- igloo

register_decoration(ethereal.glacier, {
	place_on = "default:snowblock",
	fill_ratio = 0.0005, y_min = 3, y_max = 30,
	biomes = {"glacier"},
	schematic = ethereal.igloo, place_offset_y = -1,
	spawn_by = "default:snowblock", num_spawn_by = 8,
	flags = "place_center_x, place_center_z, force_placement", rotation = "random"})

-- crystal frost tree

register_decoration(ethereal.frost, {
	place_on = "ethereal:crystal_dirt",
	fill_ratio = 0.01, y_min = 1, y_max = 1750,
	biomes = {"frost", "frost_floatland"},
	schematic = ethereal.frosttrees,
	spawn_by = "ethereal:crystal_dirt", num_spawn_by = 8})

-- giant red mushroom

register_decoration(ethereal.mushroom, {
	place_on = "ethereal:mushroom_dirt",
	sidelen = 16,
	noise_params = {
		offset = 0.01,
		scale = 0.0075,
		spread = {x = 100, y = 100, z = 100},
		seed = 328,
		octaves = 2,
		persist = 0.6
	},
	biomes = {"mushroom"},
	schematic = ethereal.mushroomone,
	spawn_by = "ethereal:mushroom_dirt", num_spawn_by = 8})

register_decoration(ethereal.jumble, {
	place_on = "default:dirt_with_rainforest_litter",
	fill_ratio = 0.000275,
	biomes = {"jumble"},
	schematic = ethereal.mushroomone,
	spawn_by = "default:dirt_with_rainforest_litter", num_spawn_by = 8,
	rotation = "random"})

-- giant brown mushroom

register_decoration(ethereal.mushroom, {
	place_on = "ethereal:mushroom_dirt",
	sidelen = 16,
	noise_params = {
		offset = 0.005,
		scale = 0.0075,
		spread = {x = 100, y = 100, z = 100},
		seed = 329,
		octaves = 2,
		persist = 0.9
	},
	biomes = {"mushroom"},
	schematic = ethereal.mushroomtwo,
	spawn_by = "ethereal:mushroom_dirt", num_spawn_by = 6,
	rotation = "random"})

register_decoration(ethereal.jumble, {
	place_on = "default:dirt_with_rainforest_litter",
	fill_ratio = 0.0001,
	biomes = {"jumble"},
	schematic = ethereal.mushroomtwo,
	spawn_by = "default:dirt_with_rainforest_litter", num_spawn_by = 8,
	rotation = "random"})

-- small lava crater

register_decoration(ethereal.fiery, {
	place_on = "ethereal:fiery_dirt",
	fill_ratio = 0.00275,
	biomes = {"fiery"},
	schematic = ethereal.volcanom,
	spawn_by = "ethereal:fiery_dirt", num_spawn_by = 8})

-- large lava crater

register_decoration(ethereal.fiery, {
	place_on = "ethereal:fiery_dirt",
	fill_ratio = 0.00125,
	biomes = {"fiery"},
	schematic = ethereal.volcanol,
	spawn_by = "ethereal:fiery_dirt", num_spawn_by = 8,
	rotation = "random"})

-- basandra bush

register_decoration(ethereal.fiery, {
	place_on = "ethereal:fiery_dirt",
	fill_ratio = 0.03,
	biomes = {"fiery"},
	schematic = ethereal.basandrabush})

-- default jungle tree

register_decoration(ethereal.junglee, {
	place_on = "default:dirt_with_rainforest_litter",
	fill_ratio = 0.08,
	biomes = {"rainforest"},
	schematic = dpath .. "jungle_tree.mts"})

-- special silver sand terrain for grayness which must be placed before trees
register_decoration(ethereal.grayness, {
	name = node,
	deco_type = "simple",
	sidelen = 16,
	place_on = {"ethereal:gray_dirt"},
	noise_params = {
		offset = -0.25,
		scale = 3,
		spread = {x = 100, y = 100, z = 100},
		seed = 666,
		octaves = 3,
		persist = 0.6,
		lacunarity = 1.2,
	},
	y_max = 31000,
	y_min = 1,
	biomes = {"grayness"},
	decoration = "default:silver_sand",
	place_offset_y = -1,
	flags = "force_placement",
})

-- willow tree

register_decoration(ethereal.grayness, {
	place_on = "ethereal:gray_dirt",
	fill_ratio = 0.015,
	biomes = {"grayness"},
	schematic = ethereal.willow,
	spawn_by = "ethereal:gray_dirt", num_spawn_by = 6})

-- small pine tree for shore elevation
register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_coniferous_litter"},
	fill_ratio = 0.025, y_min = 3, y_max = 9,
	biomes = {"coniferous_forest"},
	schematic = dpath .. "small_pine_tree.mts"}) -- ethereal.pinetree

-- small pine tree for lower elevation
register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_coniferous_litter"},
	fill_ratio = 0.03, y_min = 10, y_max = 48,
	biomes = {"coniferous_forest"},
	schematic = dpath .. "small_pine_tree.mts"}) -- ethereal.pinetree

-- default large pine tree for lower elevation
register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_coniferous_litter"},
	fill_ratio = 0.03, y_min = 10, y_max = 48,
	biomes = {"coniferous_forest"},
	schematic = dpath .. "pine_tree.mts"})

-- small pine for higher elevation
register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_snow"},
	fill_ratio = 0.03, y_min = 48, y_max = 31000,
	biomes = {"taiga"},
	schematic = dpath .. "snowy_small_pine_tree_from_sapling.mts"}) -- ethereal.pinetree

register_decoration(ethereal.snowy, {
	place_on = {"default:dirt_with_snow"},
	fill_ratio = 0.03, y_min = 48, y_max = 31000,
	biomes = {"taiga"},
	schematic = dpath .. "snowy_pine_tree_from_sapling.mts"})

-- default apple tree
register_decoration(ethereal.jumble, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_rainforest_litter"},
	fill_ratio = 0.0005,
	biomes = {"jumble"},
	schematic = dpath.."apple_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
	spawn_by = "default:dirt_with_rainforest_litter",
	num_spawn_by = 6,
})

register_decoration(ethereal.jumble, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 1,
	fill_ratio = 0.000275,
	biomes = {"jumble"},
	schematic = path.."gaunt_tree_1.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
	spawn_by = "default:dirt_with_grass",
	num_spawn_by = 5,
})

register_decoration(ethereal.jumble, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 1,
	fill_ratio = 0.0005,
	biomes = {"jumble"},
	schematic = path.."gaunt_tree_2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
	spawn_by = "default:dirt_with_grass",
	num_spawn_by = 5,
})

register_decoration(ethereal.jumble, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 1,
	fill_ratio = 0.0005,
	biomes = {"jumble"},
	schematic = path.."gaunt_tree_3.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
	spawn_by = "default:dirt_with_grass",
	num_spawn_by = 5,
})

-- deciduous forest trees
register_decoration(ethereal.grassy, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.0175,
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = path.."meadow_tree_1.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

register_decoration(ethereal.grassy, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.0025,
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = path.."meadow_tree_2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

register_decoration(ethereal.grassy, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.00275,
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = dpath.."apple_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- big old tree
register_decoration(ethereal.jumble, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass","default:dirt_with_rainforest_litter"},
	place_offset_y = 1,
	fill_ratio = 0.00225,
	biomes = {"jumble"},
	schematic = path.."overgrown_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
	spawn_by = "default:dirt_with_rainforest_litter",
	num_spawn_by = 6,
})

register_decoration(ethereal.jumble, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass","default:dirt_with_rainforest_litter"},
	place_offset_y = 1,
	fill_ratio = 0.00275,
	biomes = {"jumble"},
	schematic = ethereal.bigtree,
	flags = "place_center_x, place_center_z",
	rotation = "random",
	spawn_by = "default:dirt_with_rainforest_litter",
	num_spawn_by = 6,
})

-- default aspen tree
register_decoration(ethereal.grassytwo, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 1,
	fill_ratio = 0.0025,
	y_min = 1,
	y_max = 50,
	biomes = {"grassytwo"},
	schematic = dpath.."aspen_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- birch tree
register_decoration(ethereal.grassytwo, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 1,
	fill_ratio = 0.0025,
	y_min = 51,
	y_max = 31000,
	biomes = {"grassytwo"},
	schematic = ethereal.birchtree,
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- orange tree

register_decoration(ethereal.prairie, {
	place_on = "ethereal:prairie_dirt",
	fill_ratio = 0.01,
	biomes = {"prairie"},
	schematic = ethereal.orangetree})

-- default acacia tree

register_decoration(ethereal.savanna, {
	place_on = {"default:dry_dirt_with_dry_grass", "default:dirt_with_dry_grass"},
	fill_ratio = 0.004,
	biomes = {"savanna"},
	schematic = dpath .. "acacia_tree.mts"})


-- palm tree

register_decoration(1, {
	place_on = "default:sand",
	noise_params = {
		offset = 0,
		scale = 0.005,
		spread = {x = 100, y = 20, z = 100},
		seed = 4444333221,
		octaves = 1,
		persist = 1.0
	}, y_min = 1, y_max = 3,
	place_offset_y = 1,
	biomes = {"desert_shore", "naturalbiomes:mediterranean_shore", "sandstone_desert_shore",
			"grove_shore"},
	schematic = ethereal.palmtree})

-- bamboo tree

register_decoration(ethereal.bamboo, {
	place_on = "ethereal:bamboo_dirt",
	fill_ratio = 0.0025,
	biomes = {"bamboo"},
	place_offset_y = 1,
	schematic = ethereal.bambootree})

-- vine tree

register_decoration(ethereal.swamp, {
	place_on = "default:dirt_with_grass",
	fill_ratio = 0.0175,
	biomes = {"swamp"},
	schematic = ethereal.vinetree})

-- lemon tree

register_decoration(ethereal.mediterranean, {
	place_on = "ethereal:grove_dirt",
	fill_ratio = 0.004, y_min = 5, y_max = 50,
	biomes = {"mediterranean"},
	schematic = ethereal.lemontree})

-- olive tree

register_decoration(ethereal.mediterranean, {
	place_on = "ethereal:grove_dirt",
	fill_ratio = 0.004, y_min = 5, y_max = 45,
	biomes = {"mediterranean"},
	schematic = ethereal.olivetree})

-- default large cactus
register_decoration(ethereal.desert, {
	deco_type = "schematic",
	place_on = {
		"default:desert_sand",
		"default:sand",
	},
	sidelen = 80,
	noise_params = {
		offset = -0.0001,
		scale = 0.0005,
		spread = {x = 100, y = 100, z = 100},
		seed = 230,
		octaves = 1,
		persist = 0.6
	},
	biomes = {
		"desert",
		"sandstone_desert",
	},
	y_min = 5,
	y_max = 31000,
	schematic = dpath .. "large_cactus.mts",
	flags = "place_center_x",
	rotation = "random",
})

-- default bush

register_decoration(1, {
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
	sidelen = 16,
	noise_params = {
		offset = -0.004,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 137,
		octaves = 3,
		persist = 0.7,
	},
	biomes = {"deciduous_forest", "grassytwo"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})

-- extra bushes for jumble biome
register_decoration(ethereal.jumble, {
	deco_type = "schematic",
	place_on = {"default:dirt_with_rainforest_litter"},
	spawn_by = "default:dirt_with_rainforest_litter",
	num_spawn_by = 3,
	sidelen = 16,
	noise_params = {
		offset = 0.0125,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 34343,
		octaves = 2,
		persist = 0.6,
	},
	biomes = {"jumble"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})

-- default tropical bush
register_decoration(1, {
	deco_type = "schematic",
	place_on = {"ethereal:grove_dirt", "default:dirt_with_rainforest_litter"},
	replacements = {["default:bush_leaves"] = "default:jungleleaves"},
	--sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 137,
		octaves = 3,
		persist = 0.5
	},
	biomes = {"grove", "rainforest"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})


-- default acacia bush
register_decoration(1, {
	deco_type = "schematic",
	place_on = {
		"default:dirt_with_dry_grass",
		"default:dry_dirt_with_dry_grass",
		"naturalbiomes:savannalitter"
	},
	sidelen = 16,
	noise_params = {
		offset = -0.00525,
		scale = 0.0125,
		spread = {x = 7, y = 7, z = 7},
		seed = 90155,
		octaves = 2,
		persist = 0.8,
		lacunarity = 1.5,
	},
	biomes = {"mesa","savanna"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "acacia_bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})


-- default pine bush

register_decoration((core.registered_nodes["default:pine_bush"] and 1), {
	name = "default:pine_bush",
	place_on = {"default:dirt_with_snow", "default:cold_dirt"},
	sidelen = 16, y_min = 4, y_max = 120,
	noise_params = {
		offset = -0.004, scale = 0.01, spread = {x = 100, y = 100, z = 100},
		seed = 137, octaves = 3, persist = 0.7},
	biomes = {"taiga", "snowy_grassland"},
	schematic = dpath .. "pine_bush.mts"})

-- default blueberry bush

register_decoration((core.registered_nodes["default:blueberry_bush_leaves"] and 1), {
	name = "default:blueberry_bush",
	deco_type = "schematic",
	place_on = {
		"default:dirt_with_coniferous_litter", "default:dirt_with_snow", "ethereal:grove_dirt"},
	sidelen = 16,
	fill_ratio = 0.00075,
	biomes = {"coniferous_forest", "taiga", "grove"},
	y_max = 31000,
	y_min = 1,
	place_offset_y = 1,
	schematic = dpath .. "blueberry_bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})

-- place waterlily in beach areas

local sandy_biomes = {}
local hot_biomes = {
	desert_shore = true,
	sandstone_desert_shore = true,
	["naturalbiomes:mediterranean_shore"] = true,
	["naturalbiomes:outback_shore"] = true,
	["fiery_shore"] = true,
	savanna = true,
}
for biome,def in pairs(asuna.biomes) do
	if def.shore == "default:sand" and
		(def.ocean == "temperate") and
		not hot_biomes[biome]
	then
		table.insert(sandy_biomes,biome)
	end
end

register_decoration(1, {
	deco_type = "schematic",
	place_on = {
		"default:sand",
		"default:clay",
		"default:dirt",
	},
	sidelen = 16,
	noise_params = {
		offset = -0.0475,
		scale = 0.0875,
		spread = {x = 100, y = 100, z = 100},
		seed = 33,
		octaves = 2,
		persistence = 0.6,
	},
	biomes = sandy_biomes,
	y_min = 0,
	y_max = 0,
	schematic = ethereal.waterlily,
	rotation = "random"
})

-- extra waterlily in swamps

register_decoration(1, {
	deco_type = "schematic",
	place_on = {
		"default:sand",
		"default:clay",
		"default:dirt",
	},
	sidelen = 80,
	fill_ratio = 0.0275,
	biomes = {
		"swamp_shore",
		"marsh_shore",
		"naturalbiomes:alderswamp_shore",
		"jumble_shore",
	},
	y_min = 0,
	y_max = 0,
	schematic = ethereal.waterlily,
	rotation = "random"
})

-- coral reef

if ethereal.reefs == 1 then

	-- override corals so crystal shovel can pick them up intact
	core.override_item("default:coral_skeleton", {groups = {crumbly = 3}})
	core.override_item("default:coral_orange", {groups = {crumbly = 3}})
	core.override_item("default:coral_brown", {groups = {crumbly = 3}})

	--[[register_decoration(1, {
		deco_type = "schematic",
		place_on = {"default:sand"},
		noise_params = {
			offset = -0.15, scale = 0.1, spread = {x = 100, y = 100, z = 100},
			seed = 7013, octaves = 3, persist = 1},
		biomes = {"desert_ocean", "grove_ocean"},
		y_min = -8, y_max = -2,
		schematic = path .. "corals.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random"
	})]]
end

-- tree logs

if ethereal.logs == 1 then

	register_decoration(ethereal.prairie, {
		name = "default:apple_log",
		place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		sidelen = 16, fill_ratio = 0.001,
		biomes = {"deciduous_forest", "jumble", "swamp", "prairie"},
		schematic = dpath .. "apple_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"default:dirt_with_grass", "ethereal:prairie_dirt"}, num_spawn_by = 8})

	register_decoration(ethereal.junglee, {
		name = "default:jungle_log",
		place_on = {"default:dirt_with_rainforest_litter"},
		fill_ratio = 0.005,
		biomes = {"rainforest"},
		schematic = dpath .. "jungle_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "default:dirt_with_rainforest_litter", num_spawn_by = 8})

	register_decoration(ethereal.snowy, {
		name = "default:pine_log",
		place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
		fill_ratio = 0.0018, y_min = 4, y_max = 100,
		biomes = {"taiga", "coniferous_forest"},
		schematic = dpath .. "pine_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
		num_spawn_by = 8})

	register_decoration(ethereal.savanna, {
		name = "default:acacia_log",
		deco_type = "schematic",
		place_on = {"default:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0, scale = 0.001, spread = {x = 250, y = 250, z = 250},
			seed = 2, octaves = 3, persist = 0.66},
		biomes = {"savanna"},
		schematic = dpath .. "acacia_log.mts", place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "default:dry_dirt_with_dry_grass", num_spawn_by = 8})

	register_decoration(ethereal.plains, {
		name = "ethereal:scorched_log",
		place_on = {"ethereal:dry_dirt"},
		fill_ratio = 0.0018, y_min = 4, y_max = 100,
		biomes = {"plains"},
		schematic = {
			size = {x = 3, y = 1, z = 1},
			data = {
				{name = "ethereal:scorched_tree", param1 = 201, param2 = 16},
				{name = "ethereal:scorched_tree", param1 = 255, param2 = 16},
				{name = "ethereal:scorched_tree", param1 = 255, param2 = 16}
			}
		}, place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "ethereal:dry_dirt", num_spawn_by = 8})

	register_decoration(ethereal.grove, {
		name = "ethereal:banana_log",
		place_on = {"ethereal:grove_dirt"},
		fill_ratio = 0.0018, y_min = 4, y_max = 100,
		biomes = {"grove"},
		schematic = {
			size = {x = 3, y = 1, z = 1},
			data = {
				{name = "ethereal:banana_trunk", param1 = 255, param2 = 16},
				{name = "ethereal:banana_trunk", param1 = 255, param2 = 16},
				{name = "ethereal:banana_trunk", param1 = 201, param2 = 16}
			}
		}, place_offset_y = 1,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "ethereal:grove_dirt", num_spawn_by = 8})
end

-- deep see fumerole / vent

register_decoration(core.get_modpath("nether") and 1, {
	name = "nether:fumarole",
	place_on = {"default:sand"},
	sidelen = 16, y_min = -192, y_max = -45,
	fill_ratio = 0.0001,
	schematic = {
		size = {x = 1, y = 2, z = 2},
		data = {
			{name = "default:lava_source", param1 = 255, force_place = true},
			{name = "nether:fumarole", param1 = 255, force_place = true},
			{name = "default:sand", param1 = 192, force_place = true},
			{name = "ethereal:sandy", param1 = 192, force_place = true},
		}
	},
	place_offset_y = -1,
	spawn_by = {"default:water_source"}, num_spawn_by = 8})

if core.get_modpath("nether") then

	core.register_lbm({
		name = ":nether:extra_fumarole_timer",
		nodenames = {"nether:fumarole"},
		run_at_every_load = false,

		action = function(pos) core.get_node_timer(pos):start(10) end
	})
end
