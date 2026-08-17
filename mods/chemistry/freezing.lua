
local S = chemistry.getter

 --- Item for Crafting
minetest.register_craftitem("chemistry:insulation_flask", {
	description = S("Insulation Flask"),
	stack_max= 1,
	inventory_image = "insulation_flask.png",
})

  --- Crafts
minetest.register_craft({
	output = 'chemistry:dry_ice_compact',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:dry_ice', 'chemistry:dry_ice'},
	}
})

minetest.register_craft({
	output = 'chemistry:insulation_flask',
	recipe = {
		{'chemistry:tungsten', 'chemistry:steel_ingot', 'chemistry:tungsten'},
		{'chemistry:tungsten', 'chemistry:aluminium_block', 'chemistry:tungsten'},
		{'chemistry:tungsten', 'chemistry:steel_ingot', 'chemistry:tungsten'},
	}
})

minetest.register_craft({
	output = 'chemistry:dry_ice',
	recipe = {
		{'default:ice', 'default:ice', 'default:ice'},
		{'', 'chemistry:insulation_flask', ''},
		{'', 'chemistry:carbon_dioxide', ''},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

minetest.register_craft({
	output = 'chemistry:lnitrogen_bucket',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:nitrogen', 'chemistry:insulation_flask', 'chemistry:nitrogen'},
		{'chemistry:nitrogen', 'bucket:bucket_empty', 'chemistry:nitrogen'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

minetest.register_craft({
	output = 'chemistry:lmethane_bucket',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:methane', 'chemistry:insulation_flask', 'chemistry:methane'},
		{'chemistry:methane', 'bucket:bucket_empty', 'chemistry:methane'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

minetest.register_craft({
	output = 'chemistry:lbutane_bucket',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:butane', 'chemistry:insulation_flask', 'chemistry:butane'},
		{'chemistry:butane', 'bucket:bucket_empty', 'chemistry:butane'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

minetest.register_craft({
	output = 'chemistry:loxygen_bucket',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:oxygen', 'chemistry:insulation_flask', 'chemistry:oxygen'},
		{'chemistry:oxygen', 'bucket:bucket_empty', 'chemistry:oxygen'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})


minetest.register_craft({
	output = 'chemistry:lnitrogen_bucket_plastic',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:nitrogen', 'chemistry:insulation_flask', 'chemistry:nitrogen'},
		{'chemistry:nitrogen', 'plastic_bucket:bucket_empty', 'chemistry:nitrogen'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

minetest.register_craft({
	output = 'chemistry:lmethane_bucket_plastic',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:methane', 'chemistry:insulation_flask', 'chemistry:methane'},
		{'chemistry:methane', 'plastic_bucket:bucket_empty', 'chemistry:methane'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

minetest.register_craft({
	output = 'chemistry:lbutane_bucket_plastic',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:butane', 'chemistry:insulation_flask', 'chemistry:butane'},
		{'chemistry:butane', 'plastic_bucket:bucket_empty', 'chemistry:butane'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

minetest.register_craft({
	output = 'chemistry:loxygen_bucket_plastic',
	recipe = {
		{'chemistry:dry_ice', 'chemistry:dry_ice', 'chemistry:dry_ice'},
		{'chemistry:oxygen', 'chemistry:insulation_flask', 'chemistry:oxygen'},
		{'chemistry:oxygen', 'plastic_bucket:bucket_empty', 'chemistry:oxygen'},
	},
   replacements = {{'chemistry:insulation_flask', 'chemistry:insulation_flask'}}
})

  --- Freezing liquids or solids
minetest.register_node("chemistry:lnitrogen", {
	description = S("Liquid Nitrogen"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:lnitrogen_flowing",
	liquid_alternative_source = "chemistry:lnitrogen",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 255, g = 255, b = 255},
	groups = {light_liquid = 3, cools_lava = 1, snowy = 1, freezer = 1, puts_out_fire = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:lnitrogen_flowing", {
	description = S("Flowing Liquid Nitrogen"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png^[opacity:200"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:lnitrogen_flowing",
	liquid_alternative_source = "chemistry:lnitrogen",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 255, g = 255, b = 255},
	groups = {light_liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, snowy = 1, freezer = 1, puts_out_fire = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:lnitrogen",
		"chemistry:lnitrogen_flowing",
		"chemistry:lnitrogen_bucket",
		"lnitrogen_bucket.png",
		S("Liquid Nitrogen Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:lnitrogen",
		"chemistry:lnitrogen_flowing",
		"chemistry:lnitrogen_bucket_plastic",
		"lnitrogen_bucket_plastic.png",
		S("Liquid Nitrogen Bucket"),
		{tool = 1}
	)


minetest.register_node("chemistry:dry_ice", {
	description = S("Dry Ice"),
	tiles = {"dry_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 6, cools_water = 1},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("chemistry:dry_ice_compact", {
	description = S("Compact Dry Ice"),
	tiles = {"dry_ice_compact.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 9, cools_water = 1},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("chemistry:lbutane", {
	description = S("Liquid Butane"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:lbutane_flowing",
	liquid_alternative_source = "chemistry:lbutane",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 255, g = 255, b = 255},
	groups = {light_liquid = 3, cools_lava = 1, snowy = 1, freezer = 1, flammable_gas = 1, puts_out_fire = 1},
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:lbutane_flowing", {
	description = S("Flowing Liquid Butane"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png^[opacity:200"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:lbutane_flowing",
	liquid_alternative_source = "chemistry:lbutane",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 255, g = 255, b = 255},
	groups = {light_liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, snowy = 1, freezer = 1, flammable_gas = 1, puts_out_fire = 1},
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:lbutane",
		"chemistry:lbutane_flowing",
		"chemistry:lbutane_bucket",
		"lnitrogen_bucket.png",
		S("Liquid Butane Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:lbutane",
		"chemistry:lbutane_flowing",
		"chemistry:lbutane_bucket_plastic",
		"lnitrogen_bucket_plastic.png",
		S("Liquid Butane Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:lmethane", {
	description = S("Liquid Methane"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:lmethane_flowing",
	liquid_alternative_source = "chemistry:lmethane",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 255, g = 255, b = 255},
	groups = {light_liquid = 3, cools_lava = 1, snowy = 1, freezer = 1, flammable_gas = 1, puts_out_fire = 1},
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:lmethane_flowing", {
	description = S("Flowing Liquid Methane"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png^[opacity:200"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:lmethane_flowing",
	liquid_alternative_source = "chemistry:lmethane",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 255, g = 255, b = 255},
	groups = {light_liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, snowy = 1, freezer = 1, flammable_gas = 1, puts_out_fire = 1},
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:lmethane",
		"chemistry:lmethane_flowing",
		"chemistry:lmethane_bucket",
		"lnitrogen_bucket.png",
		S("Liquid Methane Bucket"),
		{tool = 1}
	)
	
	plastic_bucket.register_liquid(
		"chemistry:lmethane",
		"chemistry:lmethane_flowing",
		"chemistry:lmethane_bucket_plastic",
		"lnitrogen_bucket_plastic.png",
		S("Liquid Methane Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:loxygen", {
	description = S("Liquid Oxygen"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[colorize:cyan:50^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[colorize:cyan:50^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:loxygen_flowing",
	liquid_alternative_source = "chemistry:loxygen",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 205, g = 255, b = 255},
	groups = {light_liquid = 3, cools_lava = 1, snowy = 1, freezer = 1, puts_out_fire = 1, oxygen=1},
	sounds = default.node_sound_water_defaults(),
})


minetest.register_node("chemistry:loxygen_flowing", {
	description = S("Flowing Liquid Oxygen"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png^[colorize:cyan:50^[opacity:200"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[colorize:cyan:50^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[colorize:cyan:50^[opacity:200",
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
	liquid_alternative_flowing = "chemistry:loxygen_flowing",
	liquid_alternative_source = "chemistry:loxygen",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 205, g = 255, b = 255},
	groups = {light_liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, snowy = 1, freezer = 1, puts_out_fire = 1, oxygen=1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:loxygen",
		"chemistry:loxygen_flowing",
		"chemistry:loxygen_bucket",
		"loxygen_bucket.png",
		S("Liquid Oxygen Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:loxygen",
		"chemistry:loxygen_flowing",
		"chemistry:loxygen_bucket_plastic",
		"loxygen_bucket_plastic.png",
		S("Liquid Oxygen Bucket"),
		{tool = 1}
	)

