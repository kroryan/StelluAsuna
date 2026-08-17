
local S = chemistry.getter

minetest.register_node("chemistry:hcl_acid", {
	description = S("Hydrochloric Acid"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_yellow_anim.png^[opacity:130",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_yellow_anim.png^[opacity:130",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:hcl_acid_flowing",
	liquid_alternative_source = "chemistry:hcl_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 0},
	groups = {liquid = 3, cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:hcl_acid_flowing", {
	description = S("Flowing Hydrochloric Acid"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid_yellow.png"},
	special_tiles = {
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:130",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:130",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:hcl_acid_flowing",
	liquid_alternative_source = "chemistry:hcl_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 0},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:hcl_acid",
		"chemistry:hcl_acid_flowing",
		"chemistry:hcl_acid_bucket",
		"yellow_wt_bucket_plastic.png",
		S("Hydrochloric Acid Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_node("chemistry:hydrogen_peroxide", {
	description = S("Hydrogen Peroxide"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:170",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:170",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:hydrogen_peroxide_flowing",
	liquid_alternative_source = "chemistry:hydrogen_peroxide",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:hydrogen_peroxide_flowing", {
	description = S("Flowing Hydrogen Peroxide"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:170",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:170",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:hydrogen_peroxide_flowing",
	liquid_alternative_source = "chemistry:hydrogen_peroxide",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:hydrogen_peroxide",
		"chemistry:hydrogen_peroxide_flowing",
		"chemistry:hydrogen_peroxide_bucket",
		"liquid_bucket_plastic.png",
		S("Hydrogen Peroxide Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:hcl_acid_bucket',
	recipe = {
		'chemistry:cwater_bucket', 'farming:salt_crystal',
	}
})

minetest.register_node("chemistry:cwater", {
	description = S("Caustic Water"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:180",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:cwater_flowing",
	liquid_alternative_source = "chemistry:cwater",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, water = 1, alkaline = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:cwater_flowing", {
	description = S("Flowing Caustic Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:180",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:cwater_flowing",
	liquid_alternative_source = "chemistry:cwater",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, water = 1, alkaline = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:cwater",
		"chemistry:cwater_flowing",
		"chemistry:cwater_bucket",
		"acid_bucket.png",
		S("Caustic Water Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_node("chemistry:ch3cooh_acid", {
	description = S("Acetic Acid"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:130",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:130",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:ch3cooh_acid_flowing",
	liquid_alternative_source = "chemistry:ch3cooh_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 2,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:ch3cooh_acid_flowing", {
	description = S("Flowing Acetic Acid"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:130",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:130",
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
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:ch3cooh_acid_flowing",
	liquid_alternative_source = "chemistry:ch3cooh_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 2,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:ch3cooh_acid",
		"chemistry:ch3cooh_acid_flowing",
		"chemistry:ch3cooh_acid_bucket",
		"acid_bucket.png",
		S("Acetic Acid Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_node("chemistry:hso_acid", {
	description = S("Sulfuric Acid"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:130",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:130",
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
   damage_per_second = 6,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:hso_acid_flowing",
	liquid_alternative_source = "chemistry:hso_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 2,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:hso_acid_flowing", {
	description = S("Flowing Sulfuric Acid"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:130",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:130",
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
   damage_per_second = 6,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:hso_acid_flowing",
	liquid_alternative_source = "chemistry:hso_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 2,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:hso_acid",
		"chemistry:hso_acid_flowing",
		"chemistry:hso_acid_bucket",
		"acid_bucket.png",
		S("Sulfuric Acid Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_node("chemistry:hno_acid", {
	description = S("Nitric Acid"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:110",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:110",
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
   damage_per_second = 7,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:hno_acid_flowing",
	liquid_alternative_source = "chemistry:hno_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 3,
   corrosion_flags = "contains_nitrogen",
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, acid = 1, igniter = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:hno_acid_flowing", {
	description = S("Flowing Nitric Acid"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:110",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:110",
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
   damage_per_second = 7,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:hno_acid_flowing",
	liquid_alternative_source = "chemistry:hno_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 3,
   corrosion_flags = "contains_nitrogen",
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, igniter = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:hno_acid",
		"chemistry:hno_acid_flowing",
		"chemistry:hno_acid_bucket",
		"acid_bucket.png",
		S("Nitric Acid Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_node("chemistry:aqua_regia", {
	description = S("Aqua Regia"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:110",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:110",
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
   damage_per_second = 8,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:aqua_regia_flowing",
	liquid_alternative_source = "chemistry:aqua_regia",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 4,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:aqua_regia_flowing", {
	description = S("Flowing Aqua Regia"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:110",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:110",
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
   damage_per_second = 8,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:aqua_regia_flowing",
	liquid_alternative_source = "chemistry:aqua_regia",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 4,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:aqua_regia",
		"chemistry:aqua_regia_flowing",
		"chemistry:aqua_regia_bucket",
		"acid_bucket.png",
		S("Aqua Regia Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:aqua_regia_bucket',
	recipe = {
		'chemistry:hcl_acid_bucket', 'chemistry:hno_acid_bucket',
	},
	replacements = {{'chemistry:hcl_acid_bucket', 'plastic_bucket:bucket_empty'}},
})


minetest.register_craftitem("chemistry:h2o2_bottle", {
	description = S("Hydrogen Peroxide Bottle"),
	inventory_image = "bottle_with_liquid.png",
})


minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:h2o2_bottle 3',
	recipe = {
		'chemistry:hydrogen_peroxide_bucket', 'vessels:glass_bottle',
      'vessels:glass_bottle', 'vessels:glass_bottle',
	},
	replacements = {{'chemistry:hydrogen_peroxide_bucket', 'plastic_bucket:bucket_empty'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:hydrogen_peroxide_bucket',
	recipe = {
		'plastic_bucket:bucket_empty', 'chemistry:h2o2_bottle',
      'chemistry:h2o2_bottle', 'chemistry:h2o2_bottle',
	},
	replacements = {{'chemistry:h2o2_bottle', 'vessels:glass_bottle'},{'chemistry:h2o2_bottle', 'vessels:glass_bottle'},{'chemistry:h2o2_bottle', 'vessels:glass_bottle'}},
})

minetest.register_node("chemistry:piranha_solution", {
	description = S("Piranha Solution"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:110",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:110",
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
   damage_per_second = 10,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:piranha_solution_flowing",
	liquid_alternative_source = "chemistry:piranha_solution",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 2,
   corrosion_flags = "carbon_turns_into_dioxide",
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:piranha_solution_flowing", {
	description = S("Flowing Piranha Solution"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:110",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:110",
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
   damage_per_second = 10,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:piranha_solution_flowing",
	liquid_alternative_source = "chemistry:piranha_solution",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 2,
   corrosion_flags = "carbon_turns_into_dioxide",
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, corrosive = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:piranha_solution",
		"chemistry:piranha_solution_flowing",
		"chemistry:piranha_solution_bucket",
		"acid_bucket.png",
		S("Piranha Solution Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:piranha_solution_bucket',
	recipe = {
		'chemistry:hso_acid_bucket', 'chemistry:h2o2_bottle',
	},
	replacements = {{'chemistry:h2o2_bottle', 'vessels:glass_bottle'}},
})

minetest.register_node("chemistry:hso_diluted_water", {
	description = S("Dilute Sulfuric Acid"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[colorize:cyan:100^[opacity:120",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[colorize:cyan:100^[opacity:120",
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
   damage_per_second = 3,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:hso_diluted_water_flowing",
	liquid_alternative_source = "chemistry:hso_diluted_water",
	liquid_viscosity = 1,
	liquid_renewable = true,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, water = 1, acid = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:hso_diluted_water_flowing", {
	description = S("Flowing Dilute Sulfuric Acid"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[colorize:cyan:100^[opacity:120",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[colorize:cyan:100^[opacity:120",
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
   damage_per_second = 3,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:hso_diluted_water_flowing",
	liquid_alternative_source = "chemistry:hso_diluted_water",
	liquid_viscosity = 1,
	liquid_renewable = true,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, water = 1, acid = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:hso_diluted_water",
		"chemistry:hso_diluted_water_flowing",
		"chemistry:hso_diluted_water_bucket",
		"acid_bucket.png",
		S("Diluted Sulfuric Acid Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_node("chemistry:crystalic_acid", {
	description = S("Crystalic Acid"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:160",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:160",
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
   damage_per_second = 10,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:crystalic_acid_flowing",
	liquid_alternative_source = "chemistry:crystalic_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 5,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, acid = 1, corrosive = 1, crystalic_acid = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:crystalic_acid_flowing", {
	description = S("Flowing Crystalic Acid"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:160",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:160",
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
   damage_per_second = 10,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:crystalic_acid_flowing",
	liquid_alternative_source = "chemistry:crystalic_acid",
	liquid_viscosity = 1,
	liquid_renewable = true,
	corrosive = true,
   corrosion_level = 5,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, acid = 1, corrosive = 1, crystalic_acid = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:crystalic_acid",
		"chemistry:crystalic_acid_flowing",
		"chemistry:crystalic_acid_bucket",
		"acid_bucket.png",
		S("Crystalic Acid Bucket"),
		{tool = 1, acid_bucket = 1}
	)

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:crystalic_acid_bucket',
	recipe = {
		'chemistry:crystal_shard','chemistry:crystal_shard', 'chemistry:crystal_shard',
		'chemistry:crystal_shard','chemistry:aqua_regia_bucket', 'chemistry:crystal_shard',
		'chemistry:crystal_shard','chemistry:crystal_shard', 'chemistry:crystal_shard',
	}
})

