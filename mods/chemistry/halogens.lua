
local S = chemistry.getter

minetest.register_node("chemistry:chlorine", {
	description = S("Chlorine Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 10,
   damage_per_second = 2.5,
	post_effect_color = {a = 122, r = 122, g = 122, b = 0},
	tiles = {"chlorine.png^[opacity:175"},
	wield_image = "chlorine_wl.png",
	inventory_image = "chlorine_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, heavy_gas=1, gaseous = 1, toxic=1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_node("chemistry:lchlorine", {
	description = S("Liquid Chlorine"),
	drawtype = "liquid",
	tiles = {
		{
			name = "liquid_yellow_anim.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_yellow_anim.png^[opacity:180",
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
	use_texture_alpha = "blend",
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:lchlorine_flowing",
	liquid_alternative_source = "chemistry:lchlorine",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 10,
	post_effect_color = {a = 122, r = 255, g = 255, b = 0},
	groups = {liquid = 2, igniter = 0, freezer = 1,toxic=1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:lchlorine_flowing", {
	description = S("Flowing Liquid Chlorine"),
	drawtype = "flowingliquid",
	tiles = {"liquid_yellow.png"},
	special_tiles = {
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:180",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	use_texture_alpha = "blend",
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:lchlorine_flowing",
	liquid_alternative_source = "chemistry:lchlorine",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 10,
	post_effect_color = {a = 122, r = 255, g = 255, b = 0},
	groups = {liquid = 2, igniter = 0,
		not_in_creative_inventory = 1, freezer = 1,toxic=1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:lchlorine",
		"chemistry:lchlorine_flowing",
		"chemistry:lchlorine_bucket",
		"yellow_wt_bucket.png",
		S("Liquid Chlorine Bucket"),
		{tool = 1, oxidizer = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:lchlorine",
		"chemistry:lchlorine_flowing",
		"chemistry:lchlorine_bucket_plastic",
		"yellow_wt_bucket_plastic.png",
		S("Liquid Chlorine Bucket"),
		{tool = 1, oxidizer = 1}
	)

minetest.register_node("chemistry:bleach", {
	description = S("Bleach"),
	drawtype = "liquid",
	tiles = {
		{
			name = "liquid_yellow_anim.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
		{
			name = "liquid_yellow_anim.png^[opacity:150",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	paramtype = "light",
	use_texture_alpha = "blend",
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:bleach_flowing",
	liquid_alternative_source = "chemistry:bleach",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 1,
	post_effect_color = {a = 122, r = 155, g = 155, b = 0},
	groups = {liquid = 1, igniter = 0},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:bleach_flowing", {
	description = S("Flowing Bleach"),
	drawtype = "flowingliquid",
	tiles = {"liquid_yellow.png"},
	special_tiles = {
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:150",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	use_texture_alpha = "blend",
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:bleach_flowing",
	liquid_alternative_source = "chemistry:bleach",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 1,
	post_effect_color = {a = 122, r = 155, g = 155, b = 0},
	groups = {liquid = 1, igniter = 0,
		not_in_creative_inventory = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:bleach",
		"chemistry:bleach_flowing",
		"chemistry:bleach_bucket",
		"yellow_wt_bucket.png",
		S("Bleach Bucket"),
		{tool = 1, oxidizer = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:bleach",
		"chemistry:bleach_flowing",
		"chemistry:bleach_bucket_plastic",
		"yellow_wt_bucket_plastic.png",
		S("Bleach Bucket"),
		{tool = 1, oxidizer = 1}
	)

minetest.register_craft({
	type = "shapeless",
	output = 'wool:white',
	recipe = {
		'group:wool', 'chemistry:bleach_bucket',
	},
   replacements = {{"chemistry:bleach_bucket", "bucket:bucket_empty"}},
})

minetest.register_craft({
	type = "shapeless",
	output = 'dye:white',
	recipe = {
		'group:dye', 'chemistry:bleach_bucket',
	},
   replacements = {{"chemistry:bleach_bucket", "chemistry:bleach_bucket"}},
})

minetest.register_craft({
	type = "shapeless",
	output = 'wool:white',
	recipe = {
		'group:wool', 'chemistry:bleach_bucket_plastic',
	},
   replacements = {{"chemistry:bleach_bucket_plastic", "plastic_bucket:bucket_empty"}},
})

minetest.register_craft({
	type = "shapeless",
	output = 'dye:white',
	recipe = {
		'group:dye', 'chemistry:bleach_bucket_plastic',
	},
   replacements = {{"chemistry:bleach_bucket_plastic", "chemistry:bleach_bucket_plastic"}},
})

local discolore = {name="wool:white"}
minetest.register_abm({
		label = "chemistry:bleach discoloring",
		nodenames = {"chemistry:bleach", "chemistry:bleach_flowing"}, 
		interval = 1.0,
		chance = 14,
		catch_up = true,
		action = function(pos, node)
			local p = minetest.find_node_near(pos, 1, {"group:wool"})
			if p then
				minetest.set_node(p, discolore)
			end
		end,
	})

local input_node = {name="chemistry:chlorine"}
	minetest.register_abm({
		label = "chemistry:liquid chlorine vaporation",
		nodenames = {"chemistry:lchlorine", "chemistry:lchlorine_flowing"}, -- liquid gases turn back into gases
		neighbors = {"air"},
		interval = 1.0,
		chance = 25,
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

	minetest.register_abm({
		label = "chemistry:liquid chlorine vaporation",
		nodenames = {"chemistry:bleach", "chemistry:bleach_flowing"}, -- liquid gases turn back into gases
		neighbors = {"group:acid"},
		interval = 1.0,
		chance = 25,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:acid") then
				minetest.set_node(pos, input_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_node("chemistry:bromine", {
	description = S("Bromine"),
	drawtype = "liquid",
	tiles = {"black.png^[colorize:red:37"},
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
	liquid_alternative_flowing = "chemistry:bromine_flowing",
	liquid_alternative_source = "chemistry:bromine",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 5,
	post_effect_color = {a = 255, r = 1, g = 1, b = 1},
	groups = {liquid = 4, igniter = 0,toxic=1},
})

minetest.register_node("chemistry:bromine_flowing", {
	description = S("Flowing Bromine"),
	drawtype = "flowingliquid",
	tiles = {"black.png^[colorize:red:37"},
   special_tiles = {"black.png^[colorize:red:37", "black.png^[colorize:red:37"},
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
	liquid_alternative_flowing = "chemistry:bromine_flowing",
	liquid_alternative_source = "chemistry:bromine",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 5,
	post_effect_color = {a = 255, r = 1, g = 1, b = 1},
	groups = {liquid = 4, igniter = 0,
		not_in_creative_inventory = 1,toxic=1},
})

	bucket.register_liquid(
		"chemistry:bromine",
		"chemistry:bromine_flowing",
		"chemistry:bromine_bucket",
		"black_bucket.png",
	   S("Bromine Bucket"),
		{tool = 1, oxidizer = 1}
	)

local orthogonal = {
	{x=0,y=0,z=1},
	{x=0,y=1,z=0},
	{x=1,y=0,z=0},
	{x=0,y=0,z=-1},
	{x=0,y=-1,z=0},
	{x=-1,y=0,z=0},
}

minetest.register_abm({
	label = "chemistry:bromine vaporation",
	nodenames = {"chemistry:bromine", "chemistry:bromine_flowing"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 5,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:bromine_vapour"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"",
					{pos = pos, max_hear_distance = 8, gain = 0.05}
				)
			end
		end	
	end,
})

minetest.register_node("chemistry:bromine_vapour", {
	description = S("Bromine Vapour"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 10,
   damage_per_second = 2.5,
	post_effect_color = {a = 122, r = 255, g = 83, b = 73},
	tiles = {"bromine_vapour.png^[opacity:45"},
	wield_image = "bromine_vapour.png",
	inventory_image = "bromine_vapour.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=1, ropes_can_extend_into=1, not_solid=1, not_opaque=1, igniter = 1, heavy_gas=1, gaseous = 1,toxic=1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

local output_node = {name="farming:salt_crystal"}
	minetest.register_abm({
		label = "chemistry: sodium transformation",
		nodenames = {"chemistry:chlorine", "chemistry:lchlorine", "chemistry:lchlorine_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"chemistry:sodium_block"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.set_node(pos, output_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

local input_node = {name="chemistry:iodine_crystals"}
	minetest.register_abm({
		label = "chemistry: iodine crystalization",
		nodenames = {"chemistry:iodine_vapour"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava", "group:snowy"},
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

minetest.register_node("chemistry:iodine_crystals", {
	description = S("Iodine Crystals"),
	tiles = {"iodine_crystals.png"},
	inventory_image = "iodine_crystals.png",
	wield_image = "iodine_crystals.png",
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 8,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node("chemistry:iodine_block", {
	description = S("Iodine Block"),
	tiles = {"iodine_block.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("chemistry:iodine", {
	description = S("Iodine Grains"),
	inventory_image = "iodine.png",
})

minetest.register_node("chemistry:iodine_vapour", {
	description = S("Iodine Vapour"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 30,
   damage_per_second = 1,
	post_effect_color = {a = 122, r = 57, g = 0, b = 255},
	tiles = {"iodine_vapour.png^[opacity:105"},
	wield_image = "iodine_vapour.png",
	inventory_image = "iodine_vapour.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=1, ropes_can_extend_into=1, not_solid=1, not_opaque=1, heavy_gas=1, gaseous = 1,toxic=1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_abm({
	label = "chemistry:iodine sublimation",
	nodenames = {"chemistry:iodine_block"},
	neighbors = {"group:fire", "group:lava"},
	interval = 1.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:iodine_vapour"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"",
					{pos = pos, max_hear_distance = 8, gain = 0.05}
				)
			end
		end	
	end,
})

minetest.register_craft({
	output = 'chemistry:iodine_block',
	recipe = {
		{'chemistry:iodine', 'chemistry:iodine', 'chemistry:iodine'},
		{'chemistry:iodine', 'chemistry:iodine', 'chemistry:iodine'},
		{'chemistry:iodine', 'chemistry:iodine', 'chemistry:iodine'},
	}
})

minetest.register_craft({
	output = 'chemistry:iodine 9',
	recipe = {
		{'chemistry:iodine_block'},
	}
})

minetest.register_craft({
	output = 'chemistry:iodine',
	recipe = {
		{'chemistry:iodine_crystals'},
	}
})


local input_node2 = {name="fire:basic_flame"}
	minetest.register_abm({
		label = "chemistry: alumnium and bromine reaction",
		nodenames = {"chemistry:bromine_vapour"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"chemistry:aluminium_block"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "chemistry:bromine_vapour") then
				minetest.set_node(pos, input_node2)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

local remove = {name="air"}
	minetest.register_abm({
		label = "chemistry: aluminium shredding",
		nodenames = {"chemistry:aluminium_block"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"fire:basic_flame"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "chemistry:bromine_vapour") then
				minetest.set_node(pos, remove)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})


minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "chemistry:conc_sodium_hypochlorite",
	recipe = "chemistry:bleach_bucket"
})

minetest.register_craftitem("chemistry:conc_sodium_hypochlorite", {
	description = S("Concentrated Sodium Hypochlorite Bucket"),
	inventory_image = "conc_sodium_hypochlorite.png",
})

