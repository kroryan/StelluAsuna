
local S = chemistry.getter

 ---
 --- Ore Register
 ---

	minetest.register_node("chemistry:antimony_crystal", {
		description = S("Antimony Crystal Ore"),
		drawtype = "plantlike",
		tiles = {"antimony_mineral.png"},
		inventory_image = "antimony_mineral.png",
		wield_image = "antimony_mineral.png",
		paramtype = "light",
		light_source = 5,
		sunlight_propagates = true,
		walkable = true,
		damage_per_second = 0,
		groups = {cracky = 1, falling_node=1, level=1},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		node_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		drop = "chemistry:antimony",
	})

	minetest.register_node("chemistry:uranyl_crystal", {
		description = S("Uranyl Crystal"),
		drawtype = "plantlike",
		tiles = {"uranyl_crystal.png"},
		inventory_image = "uranyl_crystal.png",
		wield_image = "uranyl_crystal.png",
		paramtype = "light",
		light_source = 7,
		sunlight_propagates = true,
		walkable = true,
		damage_per_second = 1,
		groups = {cracky = 1, falling_node=1, level=1, radioactive = 2},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		node_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		drop = "chemistry:uranyl_nitrate",
	})

minetest.register_node("chemistry:gas_seep", {
	description = S("Natural Gas Seep"),
	tiles = {"default_stone.png^[combine:16x80:0,-16=crack_anylength.png"},
	groups = {cracky = 3, pickaxey=1, building_block=1, material_stone=1, conc_gas=1},
	sounds = default.node_sound_stone_defaults(),
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:methane 1'},
				rarity = 4,
			},
			{
				items = {'default:cobble'},
			},
			{
				items = {'chemistry:butane 1'},
				rarity = 4,
			},
			{
				items = {'chemistry:methane 1'},
				rarity = 8,
			},
			{
				items = {'chemistry:butane 1'},
				rarity = 8,
			},
		}
	},
	is_ground_content = true,
})

minetest.register_node("chemistry:sulfide_seep", {
	description = S("Hydrogen Sulfide Seep"),
	tiles = {"default_stone.png^sulfur_mineral.png^[combine:16x80:0,-16=crack_anylength.png"},
	groups = {cracky = 3, pickaxey=1, building_block=1, material_stone=1, conc_gas=1},
	sounds = default.node_sound_stone_defaults(),
	drop = {
		max_items = 1,
		items = {
			{
				items = {'chemistry:sulfur'},
				rarity = 3,
			},
			{
				items = {'default:cobble'},
			},
		}
	},
	is_ground_content = true,
})

minetest.register_node("chemistry:stone_with_magnesium", {
	description = S("Magnesium Ore"),
	tiles = {"default_stone.png^magnesium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:magnesium'},
			},
			{
				items = {'chemistry:magnesium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_anthracite", {
	description = S("Anthracite Ore"),
	tiles = {"default_stone.png^anthracite_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = "chemistry:anthracite",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_arsenic", {
	description = S("Arsenic Ore"),
	tiles = {"default_stone.png^arsenic_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:arsenic'},
			},
			{
				items = {'chemistry:arsenic'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_calcium", {
	description = S("Calcium Ore"),
	tiles = {"default_stone.png^calcium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "chemistry:calcium",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_manganese", {
	description = S("Manganese Ore"),
	tiles = {"default_stone.png^manganese_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 4,
		items = {
			{
				items = {'chemistry:manganese'},  
			},
			{
				items = {'chemistry:manganese'},    
				rarity = 5,
			},
			{
				items = {'chemistry:manganese_oxide'},    
			},
			{
				items = {'chemistry:manganese_oxide'},
				rarity = 5,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_molybdenum", {
	description = S("Molybdenum Ore"),
	tiles = {"default_stone.png^molybdenum_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:molybdenum'},  
			},
			{
				items = {'chemistry:molybdenum'},    
				rarity = 5,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_titanium", {
	description = S("Titanium Ore"),
	tiles = {"default_stone.png^titanium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level=3},
	drop = {
		max_items = 4,
		items = {
			{
				items = {'chemistry:titanium_raw'},
			},
			{
				items = {'chemistry:titanium_raw'},
				rarity = 2,
			},
			{
				items = {'chemistry:titanium_raw'},
				rarity = 5,
			},
			{
				items = {'chemistry:titanium_raw'},
				rarity = 8,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("chemistry:stone_with_cobalt", {
	description = S("Cobalt Ore"),
	tiles = {"default_stone.png^cobalt_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 4},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:cobalt_raw'},
			},
			{
				items = {'chemistry:cobalt_raw'},
				rarity = 4,
			},
			{
				items = {'chemistry:cobalt_raw'},
				rarity = 8,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("chemistry:stone_with_osmium", {
	description = S("Osmium Ore"),
	tiles = {"default_stone.png^osmium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 5},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:osmium_raw'},
			},
			{
				items = {'chemistry:osmium_raw'},
				rarity = 8,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("chemistry:stone_with_tungsten", {
	description = S("Tungsten Ore"),
	tiles = {"default_stone.png^tungsten_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 6},
	drop = "chemistry:tungsten_raw",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_sulfur", {
	description = S("Sulfur Ore"),
	tiles = {"default_stone.png^sulfur_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:sulfur'},
			},
			{
				items = {'chemistry:sulfur'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_bismuth", {
	description = S("Bismuth Ore"),
	tiles = {"default_stone.png^bismuth_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:bismuth'},
			},
			{
				items = {'chemistry:bismuth'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_gallium", {
	description = S("Gallium Ore"),
	tiles = {"default_stone.png^gallium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:gallium'},
			},
			{
				items = {'chemistry:gallium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_aluminium", {
	description = S("Aluminium Ore"),
	tiles = {"default_stone.png^aluminium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 4,
		items = {
			{
				items = {'chemistry:aluminium_raw'},
			},
			{
				items = {'chemistry:aluminium_raw'},
				rarity = 2,
			},
			{
				items = {'chemistry:aluminium_raw'},
				rarity = 3,
			},
			{
				items = {'chemistry:aluminium_raw'},
				rarity = 5,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

if minetest.get_modpath("technic") then
minetest.register_node("chemistry:thorite", {
	description = S("Thorite"),
	tiles = {"thorite.png"},
	is_ground_content = true,
	groups = {cracky=2, radioactive = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:thorium_raw'},
			},
			{
				items = {'chemistry:thorium_raw'}, 
				rarity = 4,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:uraninite", {
	description = S("Uraninite"),
	tiles = {"uraninite.png"},
	is_ground_content = true,
	groups = {cracky=2, radioactive = 1},
	drop = {
		max_items = 4,
		items = {
			{
				items = {'chemistry:radium_raw'},
            	rarity = 10,
			},
			{
				items = {'chemistry:polonium'}, 
				rarity = 10,
			},
			{
				items = {'chemistry:plutonium_raw'}, 
				rarity = 20,
			},
			{
				items = {'technic:uranium_lump'}, 
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})
end
minetest.register_node("chemistry:stone_with_lithium", {
	description = S("Lithium Ore"),
	tiles = {"default_stone.png^lithium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "chemistry:lithium",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_sodium", {
	description = S("Sodium Ore"),
	tiles = {"default_stone.png^sodium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "chemistry:sodium",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_potassium", {
	description = S("Potassium Ore"),
	tiles = {"default_stone.png^potassium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "chemistry:potassium",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_rubidium", {
	description = S("Rubidium Ore"),
	tiles = {"default_stone.png^rubidium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "chemistry:rubidium",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_cesium", {
	description = S("Cesium Ore"),
	tiles = {"default_stone.png^cesium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "chemistry:cesium_shard",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:stone_with_francium", {
	description = S("Francium Ore"),
	tiles = {"default_stone.png^francium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=2, radioactive = 2, alkaline = 1},
	drop = "chemistry:francium",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:strong_stone_with_anthracite", {
	description = S("Strong Anthracite Ore"),
	tiles = {"strong_stone.png^anthracite_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 1},
	drop = "chemistry:anthracite",
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:strong_stone_with_titanium", {
	description = S("Strong Titanium Ore"),
	tiles = {"strong_stone.png^titanium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level=3},
	drop = {
		max_items = 4,
		items = {
			{
				items = {'chemistry:titanium_raw 2'},
			},
			{
				items = {'chemistry:titanium_raw'},
				rarity = 2,
			},
			{
				items = {'chemistry:titanium_raw'},
				rarity = 5,
			},
		}
	},
	sounds = chemistry.node_sound_strong(),
})
minetest.register_node("chemistry:strong_stone_with_cobalt", {
	description = S("Strong Cobalt Ore"),
	tiles = {"strong_stone.png^cobalt_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 4},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:cobalt_raw'},
			},
			{
				items = {'chemistry:cobalt_raw'},
				rarity = 2,
			},
			{
				items = {'chemistry:cobalt_raw'},
				rarity = 5,
			},
		}
	},
	sounds = chemistry.node_sound_strong(),
})
minetest.register_node("chemistry:strong_stone_with_osmium", {
	description = S("Strong Osmium Ore"),
	tiles = {"strong_stone.png^osmium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 5},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:osmium_raw'},
			},
			{
				items = {'chemistry:osmium_raw'},
				rarity = 4,
			},
		}
	},
	sounds = chemistry.node_sound_strong(),
})
minetest.register_node("chemistry:strong_stone_with_tungsten", {
	description = S("Strong Tungsten Ore"),
	tiles = {"strong_stone.png^tungsten_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 6},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:tungsten_raw'},
			},
			{
				items = {'chemistry:tungsten_raw'},
				rarity = 8,
			},
		}
	},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:strong_stone_with_diamond", {
	description = S("Strong Diamond Ore"),
	tiles = {"strong_stone.png^default_mineral_diamond.png"},
	groups = {cracky = 1, level = 2},
	drop = "default:diamond",
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:strong_stone_with_magnesium", {
	description = S("Strong Magnesium Ore"),
	tiles = {"strong_stone.png^magnesium_mineral.png"},
	is_ground_content = true,
	groups = {cracky=1, level = 1},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:magnesium 2'},
			},
			{
				items = {'chemistry:magnesium'},
				rarity = 2,
			},
		}
	},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:strong_gas_seep", {
	description = S("Strong Natural Gas Seep"),
	tiles = {"strong_stone.png^[combine:16x80:0,-32=crack_anylength.png"},
	groups = {cracky = 1, pickaxey=1, building_block=1, material_stone=1, conc_gas=1},
	sounds = chemistry.node_sound_strong(),
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:methane 1'},
				rarity = 2,
			},
			{
				items = {'chemistry:stone_cobble'},
			},
			{
				items = {'chemistry:butane 1'},
				rarity = 2,
			},
			{
				items = {'chemistry:butane 1'},
				rarity = 4,
			},
			{
				items = {'chemistry:methane 1'},
				rarity = 4,
			},
		}
	},
	is_ground_content = true,
})

minetest.register_node("chemistry:strong_stone_with_gold", {
	description = S("Strong Gold Ore"),
	tiles = {"strong_stone.png^default_mineral_gold.png"},
	groups = {cracky = 1, level = 1},
	drop = "default:gold_lump",
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:strong_stone_with_mese", {
	description = S("Strong Mese Ore"),
	tiles = {"strong_stone.png^default_mineral_mese.png"},
	groups = {cracky = 1, level = 2},
	drop = "default:mese_crystal",
	sounds = chemistry.node_sound_strong(),
})


minetest.register_craftitem("chemistry:stone_ingot", {
	description = S("Stronger Stone Ingot"),
	inventory_image = "stronger_stone_ingot.png",
})

minetest.register_craftitem("chemistry:stone_lump", {
	description = S("Stronger Stone Lump"),
	inventory_image = "stronger_stone_lump.png",
})

minetest.register_node("chemistry:strong_stone_with_gem", {
	description = S("Strong Gem Ore"),
	tiles = {
		{
			name = "strong_stone_gradient.png^strong_gem_mineral_anim.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 4.0
			}
		}
	},
	groups = {cracky = 1, level = 10},
	sounds = chemistry.node_sound_strong(),
	light_source = 7,
   	glow = 7,
	drop = "chemistry:strong_gem"
})

minetest.register_node("chemistry:st_obsidian_with_gem", {
	description = S("Strong Obsidian Gem Ore"),
	tiles = {
		{
			name = "st_obsidian_gradient.png^strong_gem_mineral_anim.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 4.0
			}
		}
	},
	groups = {cracky = 1, level = 10},
	sounds = chemistry.node_sound_strong(),
	light_source = 7,
   	glow = 7,
	drop = "chemistry:strong_gem"
})

 --
 ---- Ore Generation (spawns the ores at the default node "default:stone")
 --
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_lithium",
	wherein        = "default:stone",
	clust_scarcity = 6 * 6 * 6,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = 100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_lithium",
	wherein        = "default:stone",
	clust_scarcity = 5 * 5 * 5,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -2290,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_sodium",
	wherein        = "default:stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -1,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_sodium",
	wherein        = "default:stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_potassium",
	wherein        = "default:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -89,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_potassium",
	wherein        = "default:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 5,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_rubidium",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -129,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_rubidium",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 3,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_cesium",
	wherein        = "default:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 1,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -199,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_cesium",
	wherein        = "default:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 5,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_francium",
	wherein        = "default:stone",
	clust_scarcity = 29 * 29 * 29,
	clust_num_ores = 1,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -289,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_francium",
	wherein        = "default:stone",
	clust_scarcity = 25 * 25 * 25,
	clust_num_ores = 1,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:iodine_block",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -1,
})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:mineral_oil",
		wherein         = {"default:stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = 100,
		y_min           = -30010,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:limestone",
		wherein         = {"default:stone"},
		clust_scarcity  = 26 * 26 * 26,
		clust_size      = 5,
		y_max           = 100,
		y_min           = -30010,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:petroleum",
		wherein         = {"default:stone"},
		clust_scarcity  = 76 * 76 * 76,
		clust_size      = 10,
		y_max           = 100,
		y_min           = -30010,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})


	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:bleach",
		wherein         = {"default:dirt"},
		clust_scarcity  = 26 * 26 * 26,
		clust_size      = 2,
		y_max           = 100,
		y_min           = -20,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:glycerin",
		wherein         = {"default:dirt"},
		clust_scarcity  = 26 * 26 * 26,
		clust_size      = 3,
		y_max           = 1000,
		y_min           = -30,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:vinegar",
		wherein         = {"default:dirt"},
		clust_scarcity  = 26 * 26 * 26,
		clust_size      = 3,
		y_max           = 1000,
		y_min           = -30,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:hcl_acid",
		wherein         = {"default:stone"},
		clust_scarcity  = 46 * 46 * 46,
		clust_size      = 3,
		y_max           = 0,
		y_min           = -30000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:hso_acid",
		wherein         = {"default:stone"},
		clust_scarcity  = 66 * 66 * 66,
		clust_size      = 3,
		y_max           = -10,
		y_min           = -30000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})


	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:hno_acid",
		wherein         = {"chemistry:stone"},
		clust_scarcity  = 66 * 66 * 66,
		clust_size      = 3,
		y_max           = -11000,
		y_min           = -30000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

if minetest.get_modpath("technic") then
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:uraninite",
	wherein        = "chemistry:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 2,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:uraninite",
	wherein        = "default:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 2,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:thorite",
	wherein        = "default:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 5,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:thorite",
	wherein        = "chemistry:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 6,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = -11000,
})
end

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_aluminium",
	wherein        = "default:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = 100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_aluminium",
	wherein        = "default:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 6,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -50,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_gallium",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_gallium",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -300,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_bismuth",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_bismuth",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -300,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_sulfur",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -5,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_sulfur",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 7,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -50,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_calcium",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = 0,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_calcium",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = 0,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_titanium",
	wherein        = "default:stone",
	clust_scarcity = 26 * 26 * 26,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -550,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_titanium",
	wherein        = "default:stone",
	clust_scarcity = 19 * 19 * 19,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_cobalt",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_cobalt",
	wherein        = "default:stone",
	clust_scarcity = 20 * 20 * 20,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -1500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_osmium",
	wherein        = "default:stone",
	clust_scarcity = 26 * 26 * 26,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -1500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_osmium",
	wherein        = "default:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -2000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_tungsten",
	wherein        = "default:stone",
	clust_scarcity = 31 * 31 * 31,
	clust_num_ores = 2,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -2000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_tungsten",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -3500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_magnesium",
	wherein        = "default:stone",
	clust_scarcity = 29 * 29 * 29,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = 120,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_magnesium",
	wherein        = "default:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = 0,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_anthracite",
	wherein        = "default:stone",
	clust_scarcity = 32 * 32 * 32,
	clust_num_ores = 20,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = 120,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_anthracite",
	wherein        = "default:stone",
	clust_scarcity = 25 * 25 * 25,
	clust_num_ores = 15,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = 0,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_manganese",
	wherein        = "default:stone",
	clust_scarcity = 46 * 46 * 46,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = 120,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_manganese",
	wherein        = "default:stone",
	clust_scarcity = 19 * 19 * 19,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_molybdenum",
	wherein        = "default:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:gas_seep",
	wherein        = "default:stone",
	clust_scarcity = 25 * 25 * 25,
	clust_num_ores = 1,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:gas_seep",
	wherein        = "default:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 1,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:phosphorus_red",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 6,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:phosphorus_red",
	wherein        = "default:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 7,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:phosphorus_purple",
	wherein        = "default:stone",
	clust_scarcity = 20 * 20* 20,
	clust_num_ores = 6,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:phosphorus_purple",
	wherein        = "default:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 7,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_arsenic",
	wherein        = "default:stone",
	clust_scarcity = 20 * 20* 20,
	clust_num_ores = 6,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone_with_arsenic",
	wherein        = "default:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 7,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -689,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:anthracite_block",
	wherein        = "chemistry:stone",
	clust_scarcity = 20 * 20* 20,
	clust_num_ores = 1,
	clust_size     = 1,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:anthracite_block",
	wherein        = "chemistry:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -15500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:anthracite_block",
	wherein        = "chemistry:stone",
	clust_scarcity = 20 * 20* 20,
	clust_num_ores = 3,
	clust_size     = 2,
	biomes = {"strong_stone_forest"},
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:anthracite_block",
	wherein        = "chemistry:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 6,
	clust_size     = 4,
	biomes = {"strong_stone_forest"},
	y_min     = -31000,
	y_max     = -15500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:lithium_block",
	wherein        = "default:stone",
	clust_scarcity = 20 * 20* 20,
	clust_num_ores = 1,
	clust_size     = 1,
	y_min     = -31000,
	y_max     = -10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sulfide_seep",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -50,
	biomes = {"acid_caves"},
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sulfide_seep",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 7,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = -5000,
	biomes = {"acid_caves"},
})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "chemistry:alkaline_stone",
		wherein         = {"default:stone"},
		clust_scarcity  = 21 * 21 * 21,
		clust_size      = 5,
		y_max           = -100,
		y_min           = -5000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	biomes = {"alkaline_caves"},
	})

	minetest.register_decoration({
		name = "chemistry:antimony_crystal",
		deco_type = "simple",
		place_on = {"default:stone"},
		sidelen = 16,
		flags = "force_placement, all_floors",
	    fill_ratio = 0.001,
		y_max = 0,
		y_min = -31000,
		decoration = "chemistry:antimony_crystal",
	})

	minetest.register_decoration({
		name = "chemistry:uranyl_crystal",
		deco_type = "simple",
		place_on = {"chemistry:uranium_dioxide"},
		sidelen = 16,
		flags = "all_floors",
	    fill_ratio = 0.008,
		y_max = 100,
		y_min = -31000,
		decoration = "chemistry:uranyl_crystal",
	})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_lithium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -3100,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_lithium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -3100,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_sodium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3000,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_sodium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_potassium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_potassium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_rubidium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 6,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_rubidium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 6,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_cesium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sand_with_cesium",
	wherein        = {"chemistry:alkaline_sand"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_lithium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -3100,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_lithium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -3100,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_sodium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3000,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_sodium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_potassium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_potassium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_rubidium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 6,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_rubidium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 6,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_cesium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:sandstone_with_cesium",
	wherein        = {"chemistry:alkaline_sandstone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})





minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_lithium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -3100,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_lithium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -3100,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_sodium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3000,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_sodium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_potassium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_potassium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 7,
	clust_size     = 2,
	y_min     = -9000,
	y_max     = 3100,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_rubidium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 6,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_rubidium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 6,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_cesium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_cesium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -10000,
	y_max     = 3100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_francium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 2,
	clust_size     = 1,
	y_min     = -10000,
	y_max     = 3100,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alk_stone_with_francium",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 2,
	clust_size     = 1,
	y_min     = -10000,
	y_max     = 3100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_magnesium",
	wherein        = "chemistry:stone",
	clust_scarcity = 19 * 19 * 19,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_magnesium",
	wherein        = "chemistry:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -11500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_diamond",
	wherein        = "chemistry:stone",
	clust_scarcity = 19 * 19 * 19,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_diamond",
	wherein        = "chemistry:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -11500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_mese",
	wherein        = "chemistry:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_mese",
	wherein        = "chemistry:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -11500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_gold",
	wherein        = "chemistry:stone",
	clust_scarcity = 19 * 19 * 19,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_gold",
	wherein        = "chemistry:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -11500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_anthracite",
	wherein        = "chemistry:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 12,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_anthracite",
	wherein        = "chemistry:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 15,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -16000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_anthracite",
	wherein        = "chemistry:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 24,
	clust_size     = 10,
	biomes = {"strong_stone_forest"},
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_anthracite",
	wherein        = "chemistry:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 30,
	clust_size     = 10,
	biomes = {"strong_stone_forest"},
	y_min     = -31000,
	y_max     = -16000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_gas_seep",
	wherein        = "default:stone",
	clust_scarcity = 30 * 30 * 30,
	clust_num_ores = 1,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_gas_seep",
	wherein        = "chemistry:stone",
	clust_scarcity = 20 * 20 * 20,
	clust_num_ores = 3,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -16000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_titanium",
	wherein        = "chemistry:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_titanium",
	wherein        = "chemistry:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = -16500,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_cobalt",
	wherein        = "chemistry:stone",
	clust_scarcity = 18 * 18 * 18,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_cobalt",
	wherein        = "chemistry:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -18000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_osmium",
	wherein        = "chemistry:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_osmium",
	wherein        = "chemistry:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -19000,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_tungsten",
	wherein        = "chemistry:stone",
	clust_scarcity = 21 * 21 * 21,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -11000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_tungsten",
	wherein        = "chemistry:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -21000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_gem",
	wherein        = "chemistry:stone",
	clust_scarcity = 45 * 45 * 45,
	clust_num_ores = 2,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -21000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:strong_stone_with_gem",
	wherein        = "chemistry:stone",
	clust_scarcity = 50 * 50 * 50,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -27500,
})
