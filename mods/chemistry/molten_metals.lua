

local S = chemistry.getter

minetest.register_node("chemistry:msteel", {
	description = S("Molten Steel"),
	drawtype = "liquid",
	tiles = {
		{
			name = "molten_metal_source.png^[colorize:yellow:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "molten_metal_source.png^[colorize:yellow:150",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:msteel_flowing",
	liquid_alternative_source = "chemistry:msteel",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 8,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 195, b = 0},
	groups = {liquid = 4, igniter=1, lava=1, mmetal=1},
})

minetest.register_node("chemistry:msteel_flowing", {
	description = S("Flowing Molten Steel"),
	drawtype = "flowingliquid",
	tiles = {"molten_metal.png^[colorize:yellow:150"},
	special_tiles = {
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:msteel_flowing",
	liquid_alternative_source = "chemistry:msteel",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 8,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 195, b = 0},
	groups = {liquid = 4, not_in_creative_inventory = 1, igniter = 1, lava=1, mmetal=1},
})

	bucket.register_liquid(
		"chemistry:msteel",
		"chemistry:msteel_flowing",
		"chemistry:msteel_bucket",
		"msteel_bucket.png",
		S("Molten Steel Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:mcopper", {
	description = S("Molten Copper"),
	drawtype = "liquid",
	tiles = {
		{
			name = "molten_metal_source.png^[colorize:yellow:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "molten_metal_source.png^[colorize:yellow:100",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:mcopper_flowing",
	liquid_alternative_source = "chemistry:mcopper",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 7,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 165, b = 0},
	groups = {liquid = 4, igniter = 1, lava=1, mmetal=1},
})

minetest.register_node("chemistry:mcopper_flowing", {
	description = S("Flowing Molten Copper"),
	drawtype = "flowingliquid",
	tiles = {"molten_metal.png^[colorize:yellow:100"},
	special_tiles = {
		{
			name = "molten_metal_flowing.png^[colorize:yellow:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "molten_metal_flowing.png^[colorize:yellow:100",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:mcopper_flowing",
	liquid_alternative_source = "chemistry:mcopper",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 7,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 165, b = 0},
	groups = {liquid = 4, not_in_creative_inventory = 1, igniter=1, lava=1, mmetal=1},
})

	bucket.register_liquid(
		"chemistry:mcopper",
		"chemistry:mcopper_flowing",
		"chemistry:mcopper_bucket",
		"mcopper_bucket.png",
		S("Molten Copper Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:mtin", {
	description = S("Molten Tin"),
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
	light_source = 7,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:mtin_flowing",
	liquid_alternative_source = "chemistry:mtin",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 4,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 4, igniter = 1, hot_metal=1},
})

minetest.register_node("chemistry:mtin_flowing", {
	description = S("Flowing Molten Tin"),
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
	light_source = 7,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:mtin_flowing",
	liquid_alternative_source = "chemistry:mtin",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 4,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 4, not_in_creative_inventory = 1, igniter=1, hot_metal=1},
})

	bucket.register_liquid(
		"chemistry:mtin",
		"chemistry:mtin_flowing",
		"chemistry:mtin_bucket",
		"lmetal_bucket.png",
		S("Molten Tin Bucket"),
		{tool = 1}
	)


	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:msteel"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, {name="default:steelblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:msteel_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, {name="chemistry:impurities_steelblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})


	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mcopper"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, {name="default:copperblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mcopper_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, {name="chemistry:impurities_copperblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})


	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtin"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, {name="default:tinblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtin_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, {name="chemistry:impurities_tinblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})



	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:msteel"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="default:steelblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:msteel_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="chemistry:impurities_steelblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mcopper"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="default:copperblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mcopper_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="chemistry:impurities_copperblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtin"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="default:tinblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtin_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="chemistry:impurities_tinblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

minetest.override_item("default:tinblock", {
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:mtin"})
   end,
})

minetest.register_node("chemistry:impurities_steelblock", {
	description = S("Steel Block with Impurities"),
	tiles = {"impurities_steelblock.png"},
	drop = {
		max_items = 5,
		items = {
			{
				items = {"default:steel_ingot"},
			},
			{
				items = {"default:steel_ingot"},
				rarity = 2,
			},
			{
				items = {"default:steel_ingot"},
				rarity = 3,
			},
			{
				items = {"default:steel_ingot"},
				rarity = 4,
			},
			{
				items = {"default:steel_ingot"},
				rarity = 5,
			},
      }
   },
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

if minetest.get_modpath("technic") then
   minetest.override_item("chemistry:impurities_steelblock", {
	   tiles = {"impurities_wroughtironblock.png"},
   })
end

minetest.register_node("chemistry:impurities_copperblock", {
	description = S("Copper Block with Impurities"),
	tiles = {"impurities_copperblock.png"},
	drop = {
		max_items = 5,
		items = {
			{
				items = {"default:copper_ingot"},
			},
			{
				items = {"default:copper_ingot"},
				rarity = 2,
			},
			{
				items = {"default:copper_ingot"},
				rarity = 3,
			},
			{
				items = {"default:copper_ingot"},
				rarity = 4,
			},
			{
				items = {"default:copper_ingot"},
				rarity = 5,
			},
      }
   },
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_node("chemistry:impurities_tinblock", {
	description = S("Tin Block with Impurities"),
	tiles = {"impurities_tinblock.png"},
	drop = {
		max_items = 5,
		items = {
			{
				items = {"default:tin_ingot"},
			},
			{
				items = {"default:tin_ingot"},
				rarity = 2,
			},
			{
				items = {"default:tin_ingot"},
				rarity = 3,
			},
			{
				items = {"default:tin_ingot"},
				rarity = 4,
			},
			{
				items = {"default:tin_ingot"},
				rarity = 5,
			},
      }
   },
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

--- Alkali Metals

minetest.register_node("chemistry:msodium", {
	description = S("Molten Sodium"),
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
	liquid_alternative_flowing = "chemistry:msodium_flowing",
	liquid_alternative_source = "chemistry:msodium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 2,
	liquid_range = 3,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 1},
})

minetest.register_node("chemistry:msodium_flowing", {
	description = S("Flowing Molten Sodium"),
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
	liquid_alternative_flowing = "chemistry:msodium_flowing",
	liquid_alternative_source = "chemistry:msodium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 2,
	liquid_range = 3,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 1, not_in_creative_inventory = 1},
})

	bucket.register_liquid(
		"chemistry:msodium",
		"chemistry:msodium_flowing",
		"chemistry:msodium_bucket",
		"lmetal_bucket.png",
		S("Molten Sodium Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:mpotassium", {
	description = S("Molten Potassium"),
	drawtype = "liquid",
	tiles = {
		{
			name = "lmetal_source_anim.png^[colorize:blue:25",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "lmetal_source_anim.png^[colorize:blue:25",
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
	liquid_alternative_flowing = "chemistry:mpotassium_flowing",
	liquid_alternative_source = "chemistry:mpotassium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 1,
	liquid_range = 3,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 1},
})

minetest.register_node("chemistry:mpotassium_flowing", {
	description = S("Flowing Molten Potassium"),
	drawtype = "flowingliquid",
	tiles = {"lmetal.png"},
	special_tiles = {
		{
			name = "lmetal_flowing_anim.png^[colorize:blue:25",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "lmetal_flowing_anim.png^[colorize:blue:25",
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
	liquid_alternative_flowing = "chemistry:mpotassium_flowing",
	liquid_alternative_source = "chemistry:mpotassium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 1,
	liquid_range = 3,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 1, not_in_creative_inventory = 1},
})

	bucket.register_liquid(
		"chemistry:mpotassium",
		"chemistry:mpotassium_flowing",
		"chemistry:mpotassium_bucket",
		"lmetal_bucket.png",
		S("Molten Potassium Bucket"),
		{tool = 1}
	)

minetest.register_craftitem("chemistry:bucket_with_sand", {
	description = S("Bucket With Sand"),
	inventory_image = "bucket_with_sand.png",
})

minetest.register_craft({
   output = 'chemistry:bucket_with_sand',
   recipe = {
      {'bucket:bucket_empty', 'group:sand'},
	}
})

minetest.register_node("chemistry:mglass", {
	description = S("Molten Glass"),
	drawtype = "liquid",
	tiles = {
		{
			name = "molten_metal_source.png^[opacity:170^[colorize:yellow:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "molten_metal_source.png^[opacity:170^[colorize:yellow:100",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:mglass_flowing",
	liquid_alternative_source = "chemistry:mglass",
	liquid_viscosity = 5,
	liquid_renewable = false,
	damage_per_second = 8,
	post_effect_color = {a = 220, r = 255, g = 145, b = 0},
	groups = {liquid = 4, igniter=1, lava=1, mglass=1},
})

minetest.register_node("chemistry:mglass_flowing", {
	description = S("Flowing Molten Glass"),
	drawtype = "flowingliquid",
	tiles = {"molten_metal.png^[opacity:190^[colorize:yellow:150"},
	special_tiles = {
		{
			name = "molten_metal_flowing.png^[opacity:170^[colorize:yellow:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
		{
			name = "molten_metal_flowing.png^[opacity:170^[colorize:yellow:100",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:mglass_flowing",
	liquid_alternative_source = "chemistry:mglass",
	liquid_viscosity = 5,
	liquid_renewable = false,
	liquid_range = 5,
	damage_per_second = 8,
	post_effect_color = {a = 220, r = 255, g = 145, b = 0},
	groups = {liquid = 4, not_in_creative_inventory = 1, igniter = 1, lava=1, mglass=1},
})

	bucket.register_liquid(
		"chemistry:mglass",
		"chemistry:mglass_flowing",
		"chemistry:mglass_bucket",
		"mcopper_bucket.png",
		S("Molten Glass Bucket"),
		{tool = 1}
	)

minetest.register_craft({
	type = "cooking",
	cooktime = 12,
	output = "chemistry:mglass_bucket",
	recipe = "chemistry:bucket_with_sand"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 6,
	output = "default:glass",
	recipe = "chemistry:impurities_glass"
})


minetest.register_node("chemistry:impurities_glass", {
	description = S("Glass with Impurities"),
	tiles = {"impurities_glass.png"},
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("chemistry:impurities_glass_low", {
	description = S("Low Glass with Impurities"),
	tiles = {"impurities_glass.png"},
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	paramtype = "light",
	drawtype = "nodebox",
	use_texture_alpha = "blend",
	node_box = {
		type = "connected",
		fixed = {{-0.5, -0.5, -0.5, 0.5, 0, 0.5}},
		connect_top = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	collision_box = {
		type = "connected",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		connect_top = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
		connects_to = {"chemistry:impurities_glass", "chemistry:impurities_glass_low"},
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
   type = "shapeless",
   output = 'chemistry:impurities_glass',
   recipe = {
      'chemistry:impurities_glass_low', 'chemistry:impurities_glass_low',
	}
})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"group:mglass"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
	      if node.name == "chemistry:mglass" then
			   minetest.set_node(pos, {name="chemistry:impurities_glass"})
			   minetest.sound_play(
		   		"default_cool_lava",
		   		{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
	      elseif node.name == "chemistry:mglass_flowing" then
			   minetest.set_node(pos, {name="chemistry:impurities_glass_low"})
			   minetest.sound_play(
		   		"default_cool_lava",
		   		{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
         end
		end,
	})

minetest.register_node("chemistry:mtitanium", {
	description = S("Molten Titanium"),
	drawtype = "liquid",
	tiles = {
		{
			name = "molten_metal_source.png^[colorize:yellow:150^[colorize:white:50",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "molten_metal_source.png^[colorize:yellow:150^[colorize:white:50",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:mtitanium_flowing",
	liquid_alternative_source = "chemistry:mtitanium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 10,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 205, b = 0},
	groups = {liquid = 4, igniter=1, lava=1, mmetal=1},
})

minetest.register_node("chemistry:mtitanium_flowing", {
	description = S("Flowing Molten Titanium"),
	drawtype = "flowingliquid",
	tiles = {"molten_metal.png^[colorize:yellow:150^[colorize:white:50"},
	special_tiles = {
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150^[colorize:white:50",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150^[colorize:white:50",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:mtitanium_flowing",
	liquid_alternative_source = "chemistry:mtitanium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 10,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 205, b = 0},
	groups = {liquid = 4, not_in_creative_inventory = 1, igniter = 1, lava=1, mmetal=1},
})

	bucket.register_liquid(
		"chemistry:mtitanium",
		"chemistry:mtitanium_flowing",
		"chemistry:mtitanium_bucket",
		"mtitanium_bucket.png",
		S("Molten Titanium Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:impurities_titaniumblock", {
	description = S("Titanium Block with Impurities"),
	tiles = {"impurities_titaniumblock.png"},
	drop = {
		max_items = 5,
		items = {
			{
				items = {"chemistry:titanium"},
			},
			{
				items = {"chemistry:titanium"},
				rarity = 2,
			},
			{
				items = {"chemistry:titanium"},
				rarity = 3,
			},
			{
				items = {"chemistry:titanium"},
				rarity = 4,
			},
			{
				items = {"chemistry:titanium"},
				rarity = 5,
			},
      }
   },
	is_ground_content = false,
	groups = {cracky = 1, level = 4},
	sounds = default.node_sound_metal_defaults(),
})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtitanium"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="chemistry:titanium_block"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtitanium_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="chemistry:impurities_titaniumblock"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

minetest.register_node("chemistry:mtungsten", {
	description = S("Molten Tungsten"),
	drawtype = "liquid",
	tiles = {
		{
			name = "molten_metal_source.png^[colorize:yellow:150^[colorize:white:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "molten_metal_source.png^[colorize:yellow:150^[colorize:white:100",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:mtungsten_flowing",
	liquid_alternative_source = "chemistry:mtungsten",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 25,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 205, b = 0},
	groups = {liquid = 4, igniter=1, lava=1, mmetal=1, super_hot_metal = 1},
})

minetest.register_node("chemistry:mtungsten_flowing", {
	description = S("Flowing Molten Tungsten"),
	drawtype = "flowingliquid",
	tiles = {"molten_metal.png^[colorize:yellow:150^[colorize:white:100"},
	special_tiles = {
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150^[colorize:white:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150^[colorize:white:100",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:mtungsten_flowing",
	liquid_alternative_source = "chemistry:mtungsten",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 25,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 205, b = 0},
	groups = {liquid = 4, not_in_creative_inventory = 1, igniter = 1, lava=1, mmetal=1, super_hot_metal = 1},
})

	bucket.register_liquid(
		"chemistry:mtungsten",
		"chemistry:mtungsten_flowing",
		"chemistry:mtungsten_bucket",
		"mtungsten_bucket.png",
		S("Molten Tungsten Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:impurities_tungstenblock", {
	description = S("Tungsten Block with Impurities"),
	tiles = {"impurities_tungstenblock.png"},
	drop = {
		max_items = 5,
		items = {
			{
				items = {"chemistry:tungsten"},
			},
			{
				items = {"chemistry:tungsten"},
				rarity = 2,
			},
			{
				items = {"chemistry:tungsten"},
				rarity = 3,
			},
			{
				items = {"chemistry:tungsten"},
				rarity = 4,
			},
			{
				items = {"chemistry:tungsten"},
				rarity = 5,
			},
      }
   },
	is_ground_content = false,
	groups = {cracky = 1, level = 7},
	sounds = default.node_sound_metal_defaults(),
})

if chemistry.config.allow_node_melt then
	minetest.register_abm({
		label = "chemistry: bismuth melting",
		nodenames = {"group:cracky", "group:level", "group:crumbly", "group:choppy"},
		neighbors = {"chemistry:mtungsten", "chemistry:mtungsten_flowing"},
		interval = 5.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
	      if minetest.get_item_group(node.name, "stone") > 0 then
		      minetest.swap_node(pos, {name = "default:lava_source"})
	      elseif node.name == "default:obsidian" then
		      minetest.swap_node(pos, {name = "default:lava_source"})
	      elseif minetest.get_item_group(node.name, "strong_stone") > 0 then
		      minetest.swap_node(pos, {name = "chemistry:st_lava_temp"})
	      elseif node.name == "chemistry:obsidian" then
		      minetest.swap_node(pos, {name = "chemistry:st_lava_temp"})
	      elseif node.name == "default:steelblock" then
		      minetest.swap_node(pos, {name = "chemistry:msteel"})
	      elseif node.name == "default:copperblock" then
		      minetest.swap_node(pos, {name = "chemistry:mcopper"})
	      elseif node.name == "chemistry:bismuth_block" then
		      minetest.swap_node(pos, {name = "chemistry:lbismuth"})
	      elseif node.name == "default:sand" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "default:silver_sand" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "default:desert_sand" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "default:glass" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "chemistry:impurities_glass" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "chemistry:impurities_glass_low" then
		      minetest.swap_node(pos, {name = "chemistry:mglass_flowing"})
	      elseif node.name == "chemistry:thermite" then
            minetest.swap_node(pos, {name = "chemistry:thermite_burning"})
	      end
		end,
	})
end

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtungsten_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_water", "group:freezer"},
		interval = 2.0,
		chance = 6,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:impurities_tungstenblock"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 18, gain = 0.05}
          )
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mtungsten"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_water", "group:freezer"},
		interval = 2.0,
		chance = 6,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:tungsten_block"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 18, gain = 0.05}
          )
		end,
	})

minetest.register_node("chemistry:mosmium", {
	description = S("Molten Osmium"),
	drawtype = "liquid",
	tiles = {
		{
			name = "molten_metal_source.png^[colorize:yellow:150^[colorize:white:75",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "molten_metal_source.png^[colorize:yellow:150^[colorize:white:75",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:mosmium_flowing",
	liquid_alternative_source = "chemistry:mosmium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 22.5,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 205, b = 0},
	groups = {liquid = 4, igniter=1, lava=1, mmetal=1, super_hot_metal = 1},
})

minetest.register_node("chemistry:mosmium_flowing", {
	description = S("Flowing Molten Osmium"),
	drawtype = "flowingliquid",
	tiles = {"molten_metal.png^[colorize:yellow:150^[colorize:white:75"},
	special_tiles = {
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150^[colorize:white:75",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "molten_metal_flowing.png^[colorize:yellow:150^[colorize:white:75",
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
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:mosmium_flowing",
	liquid_alternative_source = "chemistry:mosmium",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 22.5,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 205, b = 0},
	groups = {liquid = 4, not_in_creative_inventory = 1, igniter = 1, lava=1, mmetal=1, super_hot_metal = 1},
})

	bucket.register_liquid(
		"chemistry:mosmium",
		"chemistry:mosmium_flowing",
		"chemistry:mosmium_bucket",
		"mosmium_bucket.png",
		S("Molten Osmium Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:impurities_osmiumblock", {
	description = S("Osmium Block with Impurities"),
	tiles = {"impurities_osmiumblock.png"},
	drop = {
		max_items = 5,
		items = {
			{
				items = {"chemistry:osmium"},
			},
			{
				items = {"chemistry:osmium"},
				rarity = 2,
			},
			{
				items = {"chemistry:osmium"},
				rarity = 3,
			},
			{
				items = {"chemistry:osmium"},
				rarity = 4,
			},
			{
				items = {"chemistry:osmium"},
				rarity = 5,
			},
      }
   },
	is_ground_content = false,
	groups = {cracky = 1, level = 6},
	sounds = default.node_sound_metal_defaults(),
})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mosmium_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_water", "group:freezer"},
		interval = 2.0,
		chance = 6,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:impurities_osmiumblock"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 18, gain = 0.05}
          )
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:mosmium"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_water", "group:freezer"},
		interval = 2.0,
		chance = 6,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:osmium_block"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 18, gain = 0.05}
          )
		end,
	})

