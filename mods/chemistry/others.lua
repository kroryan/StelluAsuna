
local S = chemistry.getter

 -- Sodium Hydroxide (used to make caustic water)

minetest.register_craftitem("chemistry:sodium_hydroxide", {
	description = S("Sodium Hydroxide Grains"),
	inventory_image = "sodium_hydroxide.png",
})

minetest.register_craftitem("chemistry:potassium_hydroxide", {
	description = S("Potassium Hydroxide Powder"),
	inventory_image = "potassium_hydroxide.png",
})

minetest.register_craftitem("chemistry:baking_soda", {
	description = S("Baking Soda Powder"),
	inventory_image = "zinc_sulfide.png",
})

minetest.register_craftitem("chemistry:powdered_glass", {
	description = S("Powdered Glass"),
	inventory_image = "zinc_sulfide.png^[brighten:75",
})

minetest.register_craftitem("chemistry:potassium_chloride", {
	description = S("Potassium Chloride Powder"),
	inventory_image = "zinc_sulfide.png",
})

minetest.register_craftitem("chemistry:potassium_chlorate", {
	description = S("Potassium Chlorate Powder"),
	inventory_image = "potassium_hydroxide.png^[brighten:50",
})

minetest.register_craftitem("chemistry:baking_soda_comp", {
	description = S("Baking Soda Compound"),
	inventory_image = "liquid_bucket.png",
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:potassium_chloride',
	recipe = {
		'chemistry:hcl_acid_bucket', 'chemistry:potassium',
	},
	replacements = {{'chemistry:hcl_acid_bucket', 'chemistry:hcl_acid_bucket'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'dyes:white',
	recipe = {
		'group:dyes', 'chemistry:bleach_bucket',
	},
	replacements = {{'chemistry:hcl_acid_bucket', 'chemistry:hcl_acid_bucket'}},
})

minetest.register_craft({
   type = "shapeless",
	output = "chemistry:potassium_chlorate",
	recipe = {
		"chemistry:conc_sodium_hypochlorite", "chemistry:potassium_chloride"
	},
	replacements = {{'chemistry:conc_sodium_hypochlorite', 'bucket:bucket_empty'}},
})

minetest.register_craft({
   type = "shapeless",
	output = "chemistry:powdered_glass",
	recipe = {
		'vessels:glass_fragments',
	}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:sodium_hydroxide',
	recipe = {
		'bucket:bucket_water', 'chemistry:sodium',
	},
	replacements = {{'bucket:bucket_water', 'bucket:bucket_empty'}, {'chemistry:sodium', 'chemistry:hydrogen 20'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:potassium_hydroxide',
	recipe = {
		'bucket:bucket_water', 'chemistry:potassium',
	},
	replacements = {{'bucket:bucket_water', 'bucket:bucket_empty'}, {'chemistry:potassium', 'chemistry:hydrogen 20'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:cwater_bucket',
	recipe = {
		'plastic_bucket:bucket_water', 'chemistry:sodium_hydroxide',
	}
})

-- Aluminium (reactive, same as lithium but protected with oxide layer)


minetest.register_craftitem("chemistry:aluminium_raw", {
	description = S("Raw Aluminium"),
	inventory_image = "aluminium_raw.png",
})

minetest.register_craftitem("chemistry:aluminium", {
	description = S("Aluminium Ingot"),
	inventory_image = "aluminium.png",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "chemistry:aluminium",
	recipe = "chemistry:aluminium_raw"
})

minetest.register_node("chemistry:aluminium_block", {
	description = S("Aluminium Block"),
	tiles = {"aluminium_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 1},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_craft({
	output = 'chemistry:aluminium_block',
	recipe = {
		{'chemistry:aluminium', 'chemistry:aluminium', 'chemistry:aluminium'},
		{'chemistry:aluminium', 'chemistry:aluminium', 'chemistry:aluminium'},
		{'chemistry:aluminium', 'chemistry:aluminium', 'chemistry:aluminium'},
	}
})

-- Aluminum Items from Aluminium Block Crafting
minetest.register_craft({
	output = 'chemistry:aluminium 9',
	recipe = {
		{'chemistry:aluminium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

-- Gallium (low melting point, can react with aluminum to create a soft alloy)

-- Gallium Item
minetest.register_craftitem("chemistry:gallium", {
	description = S("Gallium Brick"),
	inventory_image = "gallium.png",
})


minetest.register_node("chemistry:gallium_block", {
	description = S("Gallium Block"),
	tiles = {"gallium_block.png"},
	is_ground_content = true,
	groups = {cracky = 1},
    on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:lgallium"})
    end,
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_craft({
	output = 'chemistry:gallium_block',
	recipe = {
		{'chemistry:gallium', 'chemistry:gallium', 'chemistry:gallium'},
		{'chemistry:gallium', 'chemistry:gallium', 'chemistry:gallium'},
		{'chemistry:gallium', 'chemistry:gallium', 'chemistry:gallium'},
	}
})

-- Gallium Items from Gallium Block Crafting
minetest.register_craft({
	output = 'chemistry:gallium 9',
	recipe = {
		{'chemistry:gallium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_node("chemistry:lgallium", {
	description = S("Liquid Gallium"),
	drawtype = "liquid",
	tiles = {
		{
			name = "lmetal_source_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "lmetal_source_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	paramtype = "light",
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:lgallium_flowing",
	liquid_alternative_source = "chemistry:lgallium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 0,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 5},
})

minetest.register_node("chemistry:lgallium_flowing", {
	description = S("Flowing Liquid Gallium"),
	drawtype = "flowingliquid",
	tiles = {"lmetal.png"},
	special_tiles = {
		{
			name = "lmetal_flowing_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "lmetal_flowing_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:lgallium_flowing",
	liquid_alternative_source = "chemistry:lgallium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 0,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 5, not_in_creative_inventory = 1},
})

	bucket.register_liquid(
		"chemistry:lgallium",
		"chemistry:lgallium_flowing",
		"chemistry:lgallium_bucket",
		"lmetal_bucket.png",
		S("Liquid Gallium Bucket"),
		{tool = 1}
	)

minetest.register_craftitem("chemistry:bismuth", {
	description = S("Bismuth Lump"),
	inventory_image = "bismuth.png",
})


minetest.register_node("chemistry:bismuth_block", {
	description = S("Bismuth Block"),
	tiles = {"bismuth_block.png"},
	is_ground_content = true,
	groups = {cracky = 1},
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:lbismuth"})
   end,
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_craft({
	output = 'chemistry:bismuth_block',
	recipe = {
		{'chemistry:bismuth', 'chemistry:bismuth', 'chemistry:bismuth'},
		{'chemistry:bismuth', 'chemistry:bismuth', 'chemistry:bismuth'},
		{'chemistry:bismuth', 'chemistry:bismuth', 'chemistry:bismuth'},
	}
})

minetest.register_craft({
	output = 'chemistry:bismuth 9',
	recipe = {
		{'chemistry:bismuth_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_node("chemistry:bismuth_crystal", {
	description = S("Bismuth Crystal"),
	drawtype = "plantlike",
	tiles = {"bismuth_crystal.png"},
	inventory_image = "bismuth_crystal.png",
	wield_image = "bismuth_crystal.png",
	paramtype = "light",
	light_source = 0,
	sunlight_propagates = true,
	walkable = true,
	damage_per_second = 1,
	groups = {cracky = 1, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
	},
	node_box = {
		type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
	},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'chemistry:bismuth'},  --The first and second drops ever
			},
      }
   },
})

minetest.register_node("chemistry:lbismuth", {
	description = S("Liquid Bismuth"),
	drawtype = "liquid",
	tiles = {
		{
			name = "lbismuth_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 6.0,
			},
		},
		{
			name = "lbismuth_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 6.0,
			},
		},
	},
	paramtype = "light",
	light_source = 7,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:lbismuth_flowing",
	liquid_alternative_source = "chemistry:lbismuth",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 5,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 5, igniter=1},
})

minetest.register_node("chemistry:lbismuth_flowing", {
	description = S("Flowing Liquid Bismuth"),
	drawtype = "flowingliquid",
	tiles = {"lbismuth.png"},
	special_tiles = {
		{
			name = "lbismuth_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 4,
			},
		},
		{
			name = "lbismuth_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 4,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 7,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:lbismuth_flowing",
	liquid_alternative_source = "chemistry:lbismuth",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 5,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 5, not_in_creative_inventory = 1, igniter=1},
})

	bucket.register_liquid(
		"chemistry:lbismuth",
		"chemistry:lbismuth_flowing",
		"chemistry:lbismuth_bucket",
		"lbismuth_bucket.png",
		S("Liquid Bismuth Bucket"),
		{tool = 1}
	)

-- Aluminium alloy Block (Same as aluminium but the oxide layer is destroyed due to gallium, can react with water and it is soluble)

local input_node = {name="chemistry:gallium_aluminium_alloy"}
	minetest.register_abm({
		label = "chemistry: gallium and aluminium reaction",
		nodenames = {"chemistry:aluminium_block"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"chemistry:lgallium", "chemistry:lgallium_flowing"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.set_node(pos, input_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_node("chemistry:gallium_aluminium_alloy", {
	description = S("Aluminium Alloy Block"),
	tiles = {"aluminium_block.png^gallium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_stone_defaults(),
})

local input_node = {name="chemistry:hydrogen"}
	minetest.register_abm({
		label = "chemistry: aluminium ignition",
		nodenames = {"group:water"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"chemistry:gallium_aluminium_alloy"},
		interval = 1.0,
		chance = 2,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, input_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

local output_node = {name="air"}
	minetest.register_abm({
		label = "chemistry: aluminium ignition",
		nodenames = {"chemistry:gallium_aluminium_alloy"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:water"},
		interval = 1.0,
		chance = 15,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, output_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

if chemistry.config.allow_node_melt then
local input_node2 = {name="chemistry:lgallium"}
	minetest.register_abm({
		label = "chemistry: gallium melting",
		nodenames = {"chemistry:gallium_block"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:fire", "group:lava"},
		interval = 1.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, input_node2)
			end	
		end,
	})

local input_node2 = {name="chemistry:lbismuth"}
	minetest.register_abm({
		label = "chemistry: bismuth melting",
		nodenames = {"chemistry:bismuth_block"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:lava", "group:magnesium_fire"},
		interval = 10.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, input_node2)
			end	
		end,
	})

local input_node2 = {name="chemistry:mtin"}
	minetest.register_abm({
		label = "chemistry: tin melting",
		nodenames = {"default:tinblock"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:lava", "group:magnesium_fire"},
		interval = 10.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, input_node2)
			end	
		end,
	})

local input_node2 = {name="chemistry:lava"}
	minetest.register_abm({
		label = "chemistry:stone Melting",
		nodenames = {"default:stone"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:magnesium_fire"},
		interval = 10.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, input_node2)
			end	
		end,
	})
end

local input_node2 = {name="chemistry:bismuth_crystal"}
	minetest.register_abm({
		label = "chemistry: bismuth cooling",
		nodenames = {"chemistry:lbismuth_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, input_node2)
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local input_node2 = {name="chemistry:bismuth_block"}
	minetest.register_abm({
		label = "chemistry: bismuth cooling",
		nodenames = {"chemistry:lbismuth"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, input_node2)
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local input_node2 = {name="chemistry:gallium_block"}
	minetest.register_abm({
		label = "chemistry: gallium cooling",
		nodenames = {"chemistry:lgallium"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"air"},
		interval = 1.0,
		chance = 15,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "chemistry:gallium_block") then
				minetest.set_node(pos, input_node2)
			end	
		end,
	})

-- Sulfur (non-metal that has many uses in metals reactions and products)


minetest.register_craftitem("chemistry:sulfur", {
	description = S("Sulfur Dioxide"),
	inventory_image = "sulfur.png",
})

minetest.register_node("chemistry:sulfur_block", {
	description = S("Sulfur Dioxide Block"),
	tiles = {"sulfur_block.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = 'chemistry:sulfur_block',
	recipe = {
		{'chemistry:sulfur', 'chemistry:sulfur', 'chemistry:sulfur'},
		{'chemistry:sulfur', 'chemistry:sulfur', 'chemistry:sulfur'},
		{'chemistry:sulfur', 'chemistry:sulfur', 'chemistry:sulfur'},
	}
})


minetest.register_craft({
	output = 'chemistry:sulfur 9',
	recipe = {
		{'chemistry:sulfur_block'},
	}
})

-- Ore generation
-- -1 <-> -255

minetest.register_craftitem("chemistry:sulfur_comp", {
	description = S("Sulfuric Compound"),
	inventory_image = "sulfur_comp.png",
})

minetest.register_craft({
	output = 'chemistry:sulfur_comp',
	recipe = {
		{'fire:flint_and_steel', 'chemistry:sulfur', 'chemistry:sodium_hydroxide'},
	},
	replacements = {{'fire:flint_and_steel', 'fire:flint_and_steel'}},
})


minetest.register_craft({
	output = 'chemistry:sulfur_comp',
	recipe = {
		{'chemistry:blowtorch', 'chemistry:sulfur', 'chemistry:sodium_hydroxide'},
	},
	replacements = {{'chemistry:blowtorch', 'chemistry:blowtorch'}},
})

minetest.register_craft({
	type = "shapeless",
	output = 'chemistry:hso_acid_bucket',
	recipe = {
		'chemistry:sulfur_comp', 'plastic_bucket:bucket_water',
	},
	replacements = {{'plastic_bucket:bucket_water', 'plastic_bucket:bucket_empty'}},
})

minetest.register_craft({
	type = "shapeless",
	output = 'chemistry:hso_acid_bucket',
	recipe = {
		'chemistry:sulfur', 'chemistry:hso_diluted_water_bucket',
	},
	replacements = {{'chemistry:hso_diluted_water_bucket', 'plastic_bucket:bucket_empty'}},
})

minetest.register_craftitem("chemistry:zinc_sulfide", {
	description = S("Zinc Sulfide Powder"),
	inventory_image = "zinc_sulfide.png",
})

minetest.register_craft({
	output = 'chemistry:zinc_sulfide',
	recipe = {
		{'chemistry:sulfur', 'chemistry:zinc_dust', 'fire:flint_and_steel'},
	},
	replacements = {{'fire:flint_and_steel', 'fire:flint_and_steel'}},
})

minetest.register_craft({
	output = 'chemistry:zinc_sulfide',
	recipe = {
		{'chemistry:sulfur', 'chemistry:zinc_dust', 'chemistry:blowtorch'},
	},
	replacements = {{'chemistry:blowtorch', 'chemistry:blowtorch'}},
})

minetest.register_node("chemistry:ethanol", {
	description = S("Ethanol"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:150",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:ethanol_flowing",
	liquid_alternative_source = "chemistry:ethanol",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, flammable = 1, very_flammable = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:ethanol_flowing", {
	description = S("Flowing Ethanol"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:150",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:ethanol_flowing",
	liquid_alternative_source = "chemistry:ethanol",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, flammable =1, very_flammable = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:ethanol",
		"chemistry:ethanol_flowing",
		"chemistry:ethanol_bucket",
		"arsenic_wt_bucket.png",
		S("Ethanol Bucket"),
		{tool = 1, volatile = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:ethanol",
		"chemistry:ethanol_flowing",
		"chemistry:ethanol_bucket_plastic",
		"acid_bucket.png",
		S("Ethanol Bucket"),
		{tool = 1, volatile = 1}
	)

local output_node5 = {name="fire:basic_flame"}
minetest.register_abm({
		label = "chemistry: ethanol ignition",
		nodenames = {"air"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:very_flammable"},
		interval = 1.0,
		chance = 6,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, output_node5)
				if math.random() < 0.0001 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_craft({
	type = "cooking",
	cooktime = 6,
	output = "chemistry:red_phosphorus",
	recipe = "chemistry:purple_phosphorus"
})


minetest.register_craftitem("chemistry:titanium", {
	description = S("Titanium Ingot"),
	inventory_image = "titanium.png",
})

minetest.register_craftitem("chemistry:titanium_raw", {
	description = S("Raw Titanium"),
	inventory_image = "titanium_raw.png",
})

minetest.register_node("chemistry:titanium_block", {
	description = S("Titanium Block"),
	tiles = {"titanium_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 4},
	on_blast = function() end,
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "chemistry:titanium",
	recipe = "chemistry:titanium_raw"
})

minetest.register_craft({
	output = 'chemistry:titanium_block',
	recipe = {
		{'chemistry:titanium', 'chemistry:titanium', 'chemistry:titanium'},
		{'chemistry:titanium', 'chemistry:titanium', 'chemistry:titanium'},
		{'chemistry:titanium', 'chemistry:titanium', 'chemistry:titanium'},
	}
})

minetest.register_craft({
	output = 'chemistry:titanium 9',
	recipe = {
		{'chemistry:titanium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_craftitem("chemistry:magnesium", {
	description = S("Magnesium Lumps"),
	inventory_image = "magnesium.png",
})

minetest.register_node("chemistry:magnesium_block", {
	description = S("Magnesium Block"),
	tiles = {"magnesium_block.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	output = 'chemistry:magnesium_block',
	recipe = {
		{'chemistry:magnesium', 'chemistry:magnesium', 'chemistry:magnesium'},
		{'chemistry:magnesium', 'chemistry:magnesium', 'chemistry:magnesium'}, 
      {'chemistry:magnesium', 'chemistry:magnesium', 'chemistry:magnesium'},
	}
})

minetest.register_craft({
	output = 'chemistry:magnesium 9',
	recipe = {
		{'chemistry:magnesium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_node("chemistry:magnesium_fire", {
	description = S("Magnesium Fire"),
	drawtype = "firelike",
	tiles = {{
		name = "magnesium_fire_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "magnesium_fire.png",
	paramtype = "light",
	light_source = 14,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = false,
	damage_per_second = 6,
	groups = {igniter = 2, fire = 1, magnesium_fire = 1},
	drop = "",
   on_timer = function(pos)
	if not minetest.find_node_near(pos, 1, {"chemistry:magnesium_block"}) then
		minetest.remove_node(pos)
		return
	end
	return true
end,
   on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(5, 10))
end,
})

minetest.register_node("chemistry:permanent_magnesium_fire", {
	description = S("Permanent Magnesium Fire"),
	drawtype = "firelike",
	tiles = {{
		name = "magnesium_fire_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "magnesium_fire.png",
	paramtype = "light",
	light_source = 14,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = false,
	damage_per_second = 6,
	groups = {igniter = 2, fire = 1, magnesium_fire = 1},
	drop = "",
})

	minetest.register_abm({
		label = "Remove magnesium nodes",
		nodenames = {"chemistry:magnesium_fire"},
		neighbors = "chemistry:magnesium_block",
		interval = 5,
		chance = 18,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"chemistry:magnesium_block"})
			if not p then
				return
			end
			local flammable_node = minetest.get_node(p)
			local def = minetest.registered_nodes[flammable_node.name]
			if def.on_burn then
				def.on_burn(p)
			else
				minetest.remove_node(p)
				minetest.check_for_falling(p)
			end
		end,
	})

	minetest.register_abm({
		label = "Ignite flame",
		nodenames = {"air"},
		neighbors = {"chemistry:magnesium_block"},
		interval = 5,
		chance = 12,
		catch_up = true,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"group:igniter"})
			if p then
				minetest.set_node(pos, {name = "chemistry:magnesium_fire"})
			end
		end
	})

minetest.register_node("chemistry:vinegar", {
	description = S("White Vinegar"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:150",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:vinegar_flowing",
	liquid_alternative_source = "chemistry:vinegar",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {heavy_liquid = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:vinegar_flowing", {
	description = S("Flowing White Vinegar"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:150",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:vinegar_flowing",
	liquid_alternative_source = "chemistry:vinegar",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {heavy_liquid = 1, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:vinegar",
		"chemistry:vinegar_flowing",
		"chemistry:vinegar_bucket",
		"liquid_bucket.png",
		S("White Vinegar Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:vinegar",
		"chemistry:vinegar_flowing",
		"chemistry:vinegar_bucket_plastic",
		"liquid_bucket_plastic.png",
		S("White Vinegar Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:sodium_acetate_crystals", {
	description = S("Sodium Acetate Crystals"),
	tiles = {"sodium_acetate_crystals.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand = 2},
	sounds = default.node_sound_snow_defaults(),
})

minetest.register_node("chemistry:saturated_sodium_acetate", {
	description = S("Supersaturated Sodium Acetate"),
	tiles = {"saturated_sodium_acetate.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:saturated_sodium_acetate_2", {
	description = S("Supersaturated Sodium Acetate"),
	tiles = {"saturated_sodium_acetate.png"},
	is_ground_content = true,
	drop = {
		max_items = 1,
		items = {
			{
				items = {'chemistry:saturated_sodium_acetate 1'},  --The first and second drops ever
			}
      }
   },
	groups = {oddly_breakable_by_hand = 1, cracky = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 30,
	output = "chemistry:sodium_acetate_bucket",
	recipe = "chemistry:baking_soda_comp"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 40,
	output = "chemistry:ch3cooh_acid_bucket",
	recipe = "chemistry:vinegar_bucket"
})

minetest.register_craft({
	output = 'chemistry:baking_soda_comp',
	recipe = {
      {'chemistry:baking_soda', 'chemistry:baking_soda', 'chemistry:baking_soda'},
		{'chemistry:baking_soda', 'chemistry:ch3cooh_acid_bucket', 'chemistry:baking_soda'},
      {'chemistry:baking_soda', 'chemistry:baking_soda', 'chemistry:baking_soda'},
	},
	replacements = {{'chemistry:ch3cooh_acid_bucket', 'chemistry:sodium_acetate_crystals'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}, {'chemistry:baking_soda', 'chemistry:carbon_dioxide 2'}},
})


minetest.register_craft({
   type = "shapeless",
	output = "chemistry:carbon_dioxide 2",
	recipe = {
      'chemistry:vinegar_bucket', 'chemistry:baking_soda'
	},
	replacements = {{'chemistry:vinegar_bucket', 'chemistry:vinegar_bucket'}},
})

minetest.register_node("chemistry:sodium_acetate", {
	description = S("Sodium Acetate"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:190",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:190",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:sodium_acetate_flowing",
	liquid_alternative_source = "chemistry:sodium_acetate",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {heavy_iquid = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:sodium_acetate_flowing", {
	description = S("Flowing Sodium Acetate"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:190",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:190",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:sodium_acetate_flowing",
	liquid_alternative_source = "chemistry:sodium_acetate",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {heavy_liquid = 1, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:sodium_acetate",
		"chemistry:sodium_acetate_flowing",
		"chemistry:sodium_acetate_bucket",
		"liquid_bucket.png",
		S("Sodium Acetate Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:sodium_acetate",
		"chemistry:sodium_acetate_flowing",
		"chemistry:sodium_acetate_bucket_plastic",
		"liquid_bucket_plastic.png",
		S("Sodium Acetate Bucket"),
		{tool = 1}
	)

local sodium_acetate = {"chemistry:sodium_acetate", "chemistry:sodium_acetate_flowing"}
local saturated_sodium_acetate = {"chemistry:sodium_acetate_crystals", "chemistry:saturated_sodium_acetate"}
local output_node = {name="chemistry:saturated_sodium_acetate_2"}
	minetest.register_abm({
		label = "chemistry:sodium acetate form",
		nodenames = sodium_acetate,
		neighbors = saturated_sodium_acetate,
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, saturated_sodium_acetate) then
				minetest.set_node(pos, output_node)
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:sodium acetate form",
		nodenames = {"chemistry:saturated_sodium_acetate_2"}, 
		neighbors = saturated_sodium_acetate,
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, saturated_sodium_acetate) then
				minetest.set_node(pos, {name="chemistry:saturated_sodium_acetate"})
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:sodium acetate melting",
		nodenames = {"default:ice"}, 
		neighbors = {"chemistry:saturated_sodium_acetate"},
		interval = 20.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, saturated_sodium_acetate) then
				minetest.set_node(pos, {name="default:water_source"})
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:sodium acetate melting",
		nodenames = {"chemistry:gallium_block"}, 
		neighbors = {"chemistry:saturated_sodium_acetate"},
		interval = 10.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, saturated_sodium_acetate) then
				minetest.set_node(pos, {name="chemistry:lgallium"})
			end	
		end,
	})

minetest.register_craftitem("chemistry:tungsten", {
	description = S("Tungsten Plate"),
	inventory_image = "tungsten.png",
})

minetest.register_craftitem("chemistry:tungsten_raw", {
	description = S("Raw Tungsten"),
	inventory_image = "tungsten_raw.png",
})

minetest.register_node("chemistry:tungsten_block", {
	description = S("Tungsten Block"),
	tiles = {"tungsten_block.png"},
	is_ground_content = true,
	on_blast = function() end,
	groups = {cracky = 1, level = 7},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("chemistry:tungsten_brick", {
	description = S("Tungsten Brick"),
	tiles = {"tungsten_brick.png"},
	is_ground_content = true,
	on_blast = function() end,
	groups = {cracky = 1, level = 7},
	sounds = default.node_sound_metal_defaults(),
})

stairs.register_stair(
	"tungsten_brick",
	"chemistry:tungsten_brick",
	{cracky = 1, level = 7},
	{"tungsten_brick.png"},
	S("Tungsten Brick Stair"),
	default.node_sound_metal_defaults()
)
stairs.register_slab(
	"tungsten_brick",
	"chemistry:tungsten_brick",
	{cracky = 1, level = 7},
	{"tungsten_brick.png"},
	S("Tungsten Brick Slab"),
	default.node_sound_metal_defaults()
)

stairs.register_slab(
	"tungsten_block",
	"chemistry:tungsten_block",
	{cracky = 1, level = 7},
	{"tungsten_block.png", "tungsten_block.png", "tungsten_slab_side.png"},
	S("Tungsten Slab"),
	default.node_sound_metal_defaults()
)

if minetest.global_exists("doors") then
	doors.register("tungsten_door", {
		tiles = {{name = "tungsten_door.png", backface_culling = true}},
		description = S("Tungsten Door"),
		inventory_image = "item_tungsten_door.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 7},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		gain_open = 0.2,
		gain_close = 0.2,
		recipe = {
			{"chemistry:tungsten", "chemistry:tungsten"},
			{"chemistry:tungsten", "chemistry:tungsten"},
			{"chemistry:tungsten", "chemistry:tungsten"},
		}
	})
end

minetest.register_craft({
	type = "cooking",
	cooktime = 17,
	output = "chemistry:tungsten",
	recipe = "chemistry:tungsten_raw"
})

minetest.register_craft({
	output = 'chemistry:tungsten_block',
	recipe = {
		{'chemistry:tungsten', 'chemistry:tungsten', 'chemistry:tungsten'},
		{'chemistry:tungsten', 'chemistry:tungsten', 'chemistry:tungsten'},
		{'chemistry:tungsten', 'chemistry:tungsten', 'chemistry:tungsten'},
	}
})

minetest.register_craft({
	output = 'chemistry:tungsten_brick 4',
	recipe = {
		{'chemistry:tungsten_block', 'chemistry:tungsten_block', ''},
		{'chemistry:tungsten_block', 'chemistry:tungsten_block', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:tungsten 9',
	recipe = {
		{'chemistry:tungsten_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_craftitem("chemistry:manganese", {
	description = S("Manganese Shard"),
	inventory_image = "manganese.png",
})

minetest.register_craftitem("chemistry:manganese_oxide", {
	description = S("Manganese Oxide Pebbles"),
	inventory_image = "manganese_oxide.png",
})

minetest.register_node("chemistry:steelblock", {
	description = S("Steel-Manganese alloy Block"),
	tiles = {"default_steel_block.png^[colorize:red:50"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craftitem("chemistry:steel_ingot", {
	description = S("Steel-Manganese alloy Ingot"),
	inventory_image = "default_steel_ingot.png^[colorize:red:50"
})

minetest.register_craft({
	output = 'chemistry:steelblock',
	recipe = {
		{'chemistry:steel_ingot', 'chemistry:steel_ingot', 'chemistry:steel_ingot'},
		{'chemistry:steel_ingot', 'chemistry:steel_ingot', 'chemistry:steel_ingot'},
		{'chemistry:steel_ingot', 'chemistry:steel_ingot', 'chemistry:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'chemistry:steel_ingot 9',
	recipe = {
		{'chemistry:steelblock'},
	}
})

if not minetest.get_modpath("technic") then
minetest.register_craftitem("chemistry:manganese_comp_bucket", {
	description = S("Bucket with Steel and Manganese"),
	inventory_image = "manganese_comp_bucket.png"
})

minetest.register_craft({
	output = 'chemistry:manganese_comp_bucket',
	recipe = {
		{'default:steel_ingot', 'chemistry:manganese', 'default:steel_ingot'},
		{'default:steel_ingot', 'bucket:bucket_empty', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craftitem("chemistry:red_hot_comp_bucket", {
	description = S("Bucket with Red Hot Steel"),
	inventory_image = "manganese_comp_bucket.png^[colorize:red:125"
})

minetest.register_craft({
   output = 'chemistry:red_hot_steel_ingot 8',
   recipe = {
      {'chemistry:red_hot_comp_bucket'},
	},
   replacements = {{'chemistry:red_hot_comp_bucket', 'bucket:bucket_empty'}}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "chemistry:red_hot_comp_bucket",
	recipe = "chemistry:manganese_comp_bucket"
})

minetest.register_craftitem("chemistry:red_hot_steel_ingot", {
	description = S("Red Hot Steel-Manganese alloy Ingot"),
	inventory_image = "default_steel_ingot.png^[colorize:red:150"
})

minetest.register_craft({
   output = 'chemistry:steel_ingot 8',
   recipe = {
      {'chemistry:red_hot_steel_ingot', 'chemistry:red_hot_steel_ingot', 'chemistry:red_hot_steel_ingot'},
      {'chemistry:red_hot_steel_ingot', 'group:water_bucket', 'chemistry:red_hot_steel_ingot'},
	  {'chemistry:red_hot_steel_ingot', 'chemistry:red_hot_steel_ingot', 'chemistry:red_hot_steel_ingot'},
	},
   replacements = {{'group:water_bucket', 'bucket:bucket_empty'}}
})
end

minetest.register_craftitem("chemistry:calcium", {
	description = S("Calcium Lump"),
	inventory_image = "calcium.png",
})

minetest.register_node("chemistry:calcium_block", {
	description = S("Calcium Block"),
	tiles = {"calcium_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = 'chemistry:calcium_block',
	recipe = {
		{'chemistry:calcium', 'chemistry:calcium', 'chemistry:calcium'},
		{'chemistry:calcium', 'chemistry:calcium', 'chemistry:calcium'},
		{'chemistry:calcium', 'chemistry:calcium', 'chemistry:calcium'},
	}
})

-- Calcium Items from Aluminium Block Crafting
minetest.register_craft({
	output = 'chemistry:calcium 9',
	recipe = {
		{'chemistry:calcium_block'},
	}
})

local remove = {name="air"}
	minetest.register_abm({
		label = "chemistry: lithium ignition",
		nodenames = {"chemistry:calcium_block"}, 
		neighbors = {"group:water"},
		interval = 12.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, remove)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

local input_node = {name="chemistry:hydrogen"}
	minetest.register_abm({
		label = "chemistry: lithium ignition",
		nodenames = {"group:water"}, 
		neighbors = {"chemistry:calcium_block"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, input_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

if minetest.get_modpath("farming") then
   minetest.register_craft( {
      type = "shapeless",
	   output = "chemistry:ethanol_bucket",
	   recipe = {
		   "farming:bottle_ethanol", "farming:bottle_ethanol", "farming:bottle_ethanol",
		   "bucket:bucket_empty"
	   }
   })

    minetest.register_craft( {
        type = "shapeless",
	    output = "chemistry:ethanol_bucket_plastic",
	    recipe = {
		    "farming:bottle_ethanol", "farming:bottle_ethanol", "farming:bottle_ethanol",
		    "plastic_bucket:bucket_empty"
	    }
    })
end

minetest.register_craftitem("chemistry:cobalt", {
	description = S("Cobalt Ingot"),
	inventory_image = "cobalt_ingot.png",
})

minetest.register_craftitem("chemistry:cobalt_raw", {
	description = S("Raw Cobalt"),
	inventory_image = "cobalt_raw.png",
})

minetest.register_node("chemistry:cobalt_block", {
	description = S("Cobalt Block"),
	tiles = {"cobalt_block.png"},
	is_ground_content = true,
	on_blast = function() end,
	groups = {cracky = 1, level = 5},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 7,
	output = "chemistry:cobalt",
	recipe = "chemistry:cobalt_raw"
})

minetest.register_craft({
	output = 'chemistry:cobalt_block',
	recipe = {
		{'chemistry:cobalt', 'chemistry:cobalt', 'chemistry:cobalt'},
		{'chemistry:cobalt', 'chemistry:cobalt', 'chemistry:cobalt'},
		{'chemistry:cobalt', 'chemistry:cobalt', 'chemistry:cobalt'},
	}
})

minetest.register_craft({
	output = 'chemistry:cobalt 9',
	recipe = {
		{'chemistry:cobalt_block'},
	}
})

-- Ore generation
-- -128 <-> -255


minetest.register_craftitem("chemistry:osmium", {
	description = S("Osmium Bar"),
	inventory_image = "osmium.png",
})

minetest.register_craftitem("chemistry:osmium_raw", {
	description = S("Raw Osmium"),
	inventory_image = "osmium_raw.png",
})

minetest.register_node("chemistry:osmium_block", {
	description = S("Osmium Block"),
	tiles = {"osmium_block.png"},
	is_ground_content = true,
	on_blast = function() end,
	groups = {cracky = 1, level = 6},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 12,
	output = "chemistry:osmium",
	recipe = "chemistry:osmium_raw"
})

minetest.register_craft({
	output = 'chemistry:osmium_block',
	recipe = {
		{'chemistry:osmium', 'chemistry:osmium', 'chemistry:osmium'},
		{'chemistry:osmium', 'chemistry:osmium', 'chemistry:osmium'},
		{'chemistry:osmium', 'chemistry:osmium', 'chemistry:osmium'},
	}
})

minetest.register_craft({
	output = 'chemistry:osmium 9',
	recipe = {
		{'chemistry:osmium_block'},
	}
})


minetest.register_craftitem("chemistry:iron_iii_oxide", {
	description = S("Iron(III) Oxide Powder"),
	inventory_image = "iron_iii_oxide.png",
})

minetest.register_craft({
	output = 'chemistry:iron_iii_oxide',
	recipe = {
		{'default:steel_ingot', 'bucket:bucket_water'},
	},
   replacements = {{'bucket:bucket_water', 'bucket:bucket_water'}}
})


minetest.register_craft({
	output = 'chemistry:iron_iii_oxide',
	recipe = {
		{'technic:wrought_iron_dust', 'bucket:bucket_water'},
	},
   replacements = {{'bucket:bucket_water', 'bucket:bucket_water'}}
})

	minetest.register_craftitem("chemistry:antimony", {
		description = S("Antimony Rock"),
		inventory_image = "antimony.png",
	})

minetest.register_craftitem("chemistry:antimony_trisulfide", {
	description = S("Antimony Trisulfide"),
	inventory_image = "aluminium_dust.png^[colorize:black:200",
})

minetest.register_craft({
   type = "shapeless",
	output = "chemistry:antimony_trisulfide",
	recipe = {
		'chemistry:antimony', 'chemistry:sulfur', 'fire:flint_and_steel',
	},
	replacements = {{'fire:flint_and_steel', 'fire:flint_and_steel'}},
})
