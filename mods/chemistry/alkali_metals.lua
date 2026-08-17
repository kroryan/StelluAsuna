
local S = chemistry.getter

local chemical_boom = {
	name = "chemical_boom",
	--description = "explosion caused by chemical reactions",
	radius = 1,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}

local chemical_boom2 = {
	name = "chemical_boom2",
	--description = "explosion caused by chemical reactions",
	radius = 2,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}

local chemical_boom3 = {
	name = "chemical_boom3",
	--description = "explosion caused by chemical reactions",
	radius = 3,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}

local chemical_boom4 = {
	name = "chemical_boom4",
	--description = "explosion caused by chemical reactions",
	radius = 4,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}

tnt.register_tnt(chemical_boom)

tnt.register_tnt(chemical_boom2)

tnt.register_tnt(chemical_boom3)

tnt.register_tnt(chemical_boom4)


minetest.register_craftitem("chemistry:lithium", {
	description = S("Lithium Shard"),
	inventory_image = "lithium.png",
})

minetest.register_node("chemistry:lithium_block", {
	description = S("Lithium Block"),
	tiles = {"lithium_block.png"},
	is_ground_content = true,
	groups = {cracky = 3, alkaline = 1},
	sounds = chemistry.node_sound_soft(),
})

minetest.register_craft({
	output = 'chemistry:lithium_block',
	recipe = {
		{'chemistry:lithium', 'chemistry:lithium', 'chemistry:lithium'},
		{'chemistry:lithium', 'chemistry:lithium', 'chemistry:lithium'},
		{'chemistry:lithium', 'chemistry:lithium', 'chemistry:lithium'},
	}
})


minetest.register_craft({
	output = 'chemistry:lithium 9',
	recipe = {
		{'chemistry:lithium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_craftitem("chemistry:sodium", {
	description = S("Sodium Lump"),
	inventory_image = "sodium.png",
})

minetest.register_node("chemistry:sodium_block", {
	description = S("Sodium Block"),
	tiles = {"sodium_block.png"},
	is_ground_content = true,
	groups = {cracky = 3, alkaline = 1},
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:msodium"})
   end,
	sounds = chemistry.node_sound_soft(),
})

minetest.register_craft({
	output = 'chemistry:sodium_block',
	recipe = {
		{'chemistry:sodium', 'chemistry:sodium', 'chemistry:sodium'},
		{'chemistry:sodium', 'chemistry:sodium', 'chemistry:sodium'},
		{'chemistry:sodium', 'chemistry:sodium', 'chemistry:sodium'},
	}
})


minetest.register_craft({
	output = 'chemistry:sodium 9',
	recipe = {
		{'chemistry:sodium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_craftitem("chemistry:potassium", {
	description = S("Potassium Lump"),
	inventory_image = "potassium.png",
})

minetest.register_node("chemistry:potassium_block", {
	description = S("Potassium Block"),
	tiles = {"potassium_block.png"},
	is_ground_content = true,
	groups = {cracky = 3, oddly_breakable_by_hand = 1, alkaline = 1},
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:mpotassium"})
   end,
	sounds = chemistry.node_sound_soft(),
})

minetest.register_craft({
	output = 'chemistry:potassium_block',
	recipe = {
		{'chemistry:potassium', 'chemistry:potassium', 'chemistry:potassium'},
		{'chemistry:potassium', 'chemistry:potassium', 'chemistry:potassium'},
		{'chemistry:potassium', 'chemistry:potassium', 'chemistry:potassium'},
	}
})

minetest.register_craft({
	output = 'chemistry:potassium 9',
	recipe = {
		{'chemistry:potassium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_craftitem("chemistry:rubidium", {
	description = S("Rubidium Ingot"),
	inventory_image = "rubidium.png",
})

minetest.register_node("chemistry:rubidium_block", {
	description = S("Rubidium Block"),
	tiles = {"rubidium_block.png"},
	is_ground_content = true,
	groups = {cracky = 3, oddly_breakable_by_hand = 2, alkaline = 1},
	sounds = chemistry.node_sound_soft(),
})

minetest.register_craft({
	output = 'chemistry:rubidium_block',
	recipe = {
		{'chemistry:rubidium', 'chemistry:rubidium', 'chemistry:rubidium'},
		{'chemistry:rubidium', 'chemistry:rubidium', 'chemistry:rubidium'},
		{'chemistry:rubidium', 'chemistry:rubidium', 'chemistry:rubidium'},
	}
})

minetest.register_craft({
	output = 'chemistry:rubidium 9',
	recipe = {
		{'chemistry:rubidium_block'},
	}
})

-- Ore generation
-- -128 <-> -255
minetest.register_node("chemistry:cesium", {
	description = S("Cesium"),
	drawtype = "liquid",
	tiles = {
		{
			name = "cesium_source_animated.png",
			backface_culling = false,
			align_style      = "world",
			scale            = 2,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 2.0,
			},
		},
		{
			name = "cesium_source_animated.png",
			backface_culling = true,
			align_style      = "world",
			scale            = 2,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
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
	liquid_alternative_flowing = "chemistry:cesium_flowing",
	liquid_alternative_source = "chemistry:cesium",
	liquid_viscosity = 1,
	liquid_range = 3,
	liquid_renewable = false,
	damage_per_second = 0,
	post_effect_color = {a = 240, r = 58, g = 34, b = 7},
	groups = {liquid = 1, alkaline = 1, light_liquid = 1},
})

minetest.register_node("chemistry:cesium_flowing", {
	description = S("Flowing Cesium"),
	drawtype = "flowingliquid",
	tiles = {"cesium.png"},
	special_tiles = {
		{
			name = "cesium_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "cesium_flowing_animated.png",
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
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:cesium_flowing",
	liquid_alternative_source = "chemistry:cesium",
	liquid_viscosity = 1,
	liquid_range = 3,
	liquid_renewable = false,
	damage_per_second = 0,
	post_effect_color = {a = 240, r = 58, g = 34, b = 7},
	groups = {liquid = 1, not_in_creative_inventory = 1, alkaline = 1, light_liquid = 1},
})

	bucket.register_liquid(
		"chemistry:cesium",
		"chemistry:cesium_flowing",
		"chemistry:cesium_bucket",
		"cesium_bucket.png",
		S("Cesium Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:cesium",
		"chemistry:cesium_flowing",
		"chemistry:cesium_bucket_plastic",
		"cesium_bucket_plastic.png",
		S("Cesium Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:cesium_block", {
	description = S("Cesium Block"),
	tiles = {"cesium_block.png"},
	is_ground_content = true,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, alkaline = 1},
	sounds = chemistry.node_sound_soft(),
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:cesium"})
   end,
})

minetest.register_craftitem("chemistry:cesium_shard", {
	description = S("Cesium Shard"),
	inventory_image = "cesium_shard.png",
})

minetest.register_node("chemistry:cesium_crystal", {
	description = S("Cesium Crystal"),
	drawtype = "plantlike",
	tiles = {"cesium_crystal.png"},
	inventory_image = "cesium_crystal.png",
	wield_image = "cesium_crystal.png",
	paramtype = "light",
	light_source = 0,
	sunlight_propagates = true,
	walkable = true,
	damage_per_second = 0,
	groups = {cracky = 3, attached_node = 1, oddly_breakable_by_hand = 3},
	sounds = chemistry.node_sound_soft(),
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
				items = {'chemistry:cesium_shard'},  --The first and second drops ever
			},
      }
   },
})

minetest.register_craft({
	output = 'chemistry:cesium_block',
	recipe = {
		{'chemistry:cesium_shard', 'chemistry:cesium_shard', 'chemistry:cesium_shard'},
		{'chemistry:cesium_shard', 'chemistry:cesium_shard', 'chemistry:cesium_shard'},
		{'chemistry:cesium_shard', 'chemistry:cesium_shard', 'chemistry:cesium_shard'},
	}
})

-- Ore generation
-- -128 <-> -255

minetest.register_craftitem("chemistry:francium", {
	description = S("Francium Rock"),
	inventory_image = "francium.png",
})

minetest.register_node("chemistry:francium_block", {
	description = S("Francium Block"),
	tiles = {"francium_block.png"},
	is_ground_content = true,
	groups = {cracky = 2, radioactive = 9, alkaline = 1},
	sounds = default.node_sound_stone_defaults(),
   on_timer = function(pos)
   	minetest.get_node_timer(pos):start(math.random(1320, 1320))
   	minetest.set_node(pos, {name="chemistry:radium_block"})
   end,
})

minetest.register_craft({
	output = 'chemistry:francium_block',
	recipe = {
		{'chemistry:francium', 'chemistry:francium', 'chemistry:francium'},
		{'chemistry:francium', 'chemistry:francium', 'chemistry:francium'},
		{'chemistry:francium', 'chemistry:francium', 'chemistry:francium'},
	}
})

minetest.register_craft({
	output = 'chemistry:francium 9',
	recipe = {
		{'chemistry:francium_block'},
	}
})

minetest.register_node("chemistry:alkaline_water", {
	description = S("Alkaline Water"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "default_river_water_source_animated.png^[colorize:white:50",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "default_river_water_source_animated.png^[colorize:white:50",
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
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:alkaline_water_flowing",
	liquid_alternative_source = "chemistry:alkaline_water",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 7,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {liquid = 3, not_in_creative_inventory = 1, cools_lava = 1, alkaline_water = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:alkaline_water_flowing", {
	description = S("Flowing Alkaline Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"default_river_water.png^[colorize:white:50"},
	special_tiles = {
		{
			name = "default_river_water_flowing_animated.png^[colorize:white:50",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "default_river_water_flowing_animated.png^[colorize:white:50",
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
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:alkaline_water_flowing",
	liquid_alternative_source = "chemistry:alkaline_water",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 7,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, alkaline_water = 1},
	sounds = default.node_sound_water_defaults(),
})

	plastic_bucket.register_liquid(
		"chemistry:alkaline_water",
		"chemistry:alkaline_water_flowing",
		"chemistry:alkaline_water_bucket",
		"liquid_bucket_plastic.png",
		S("Alkaline Water Bucket"),
		{tool = 1, alkaline = 1}
	)

-- Ore generation
-- -128 <-> -255

if chemistry.config.allow_alkali_reaction then
local remove = {name="air"}
	minetest.register_abm({
		label = "chemistry: lithium ignition",
		nodenames = {"chemistry:lithium_block"}, 
		neighbors = {"group:water", "group:acid"},
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
		nodenames = {"group:water", "group:acid"}, 
		neighbors = {"chemistry:lithium_block", "group:alkaline_sand", "group:alkaline_sandstone"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, input_node)
			if math.random() < 0.01 then
				minetest.set_node(pos, {name="air"})
			end
		end,
	})

local sand = {name="default:sand"}
	minetest.register_abm({
		label = "chemistry: lithium ignition",
		nodenames = {"group:alkaline_sand"}, 
		neighbors = {"group:water", "group:acid", "group:alkaline_water"},
		interval = 3.0,
		chance = 5,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, sand)
			end	
		end,
	})

local sandstone = {name="default:sandstone"}
	minetest.register_abm({
		label = "chemistry: lithium ignition",
		nodenames = {"group:alkaline_sandstone"}, 
		neighbors = {"group:water", "group:acid", "group:alkaline_water"},
		interval = 3.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, sandstone)
			end	
		end,
	})

local stone = {name="default:stone"}
	minetest.register_abm({
		label = "chemistry: lithium ignition",
		nodenames = {"group:alkaline_stone"}, 
		neighbors = {"group:water", "group:acid"},
		interval = 6.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, stone)
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry: alkaline ignition",
		nodenames = {"group:water", "group:acid"}, 
		neighbors = {"chemistry:sodium_block", "chemistry:potassium_block", "chemistry:msodium", "chemistry:msodium_flowing", "chemistry:mpotassium", "chemistry:mpotassium_flowing", "chemistry:stone_with_cesium", "chemistry:stone_with_rubidium", "chemistry:sandstone_with_cesium", "chemistry:sandstone_with_rubidium", "chemistry:sand_with_rubidium"},
		interval = 1.0,
		chance = 3,
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

	minetest.register_abm({
		label = "chemistry: alkaline ignition",
		nodenames = {"chemistry:hydrogen"}, 
		neighbors = {"chemistry:sodium_block", "chemistry:potassium_block", "chemistry:msodium", "chemistry:msodium_flowing", "chemistry:mpotassium", "chemistry:mpotassium_flowing", "chemistry:stone_with_cesium", "chemistry:stone_with_rubidium", "chemistry:sandstone_with_cesium", "chemistry:sandstone_with_rubidium", "chemistry:sand_with_rubidium"},
		interval = 1.0,
		chance = 3,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water", "chemistry:oxygen") then
				minetest.set_node(pos, {name="fire:basic_flame"})
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

	minetest.register_abm({
		label = "alkali metals ignition",
		nodenames = {"chemistry:sodium_block", "chemistry:potassium_block"}, 
		neighbors = {"group:water", "group:acid"},
		interval = 1.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
         -- This reaction is exothermic which generates heat enough to melt sodium or potassium
	      if node.name == "chemistry:sodium_block" then
		      minetest.set_node(pos, {name = "chemistry:msodium"})
	      elseif node.name == "chemistry:potassium_block" then
		      minetest.set_node(pos, {name = "chemistry:mpotassium"})
			end	
		end,
	})

if chemical_boom then
	minetest.register_abm({
		label = "alkali metals ignition",
		nodenames = {"chemistry:msodium", "chemistry:msodium_flowing", "chemistry:mpotassium", "chemistry:mpotassium_flowing", "chemistry:stone_with_cesium", "chemistry:stone_with_rubidium", "chemistry:sandstone_with_cesium", "chemistry:sandstone_with_rubidium", "chemistry:sand_with_rubidium", "chemistry:stone_with_francium", "chemistry:alk_stone_with_rubidium", "chemistry:alk_stone_with_cesium", "chemistry:alk_stone_with_francium"}, 
		neighbors = {"group:water", "group:acid"},
		interval = 1.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
			tnt.boom(pos, chemical_boom)
			if math.random() < 0.5 then
				minetest.set_node(pos, {name="fire:basic_flame"})
			end	
		end,
	})
end

if chemical_boom2 then
	minetest.register_abm({
		label = "alkali metals ignition",
		nodenames = {"chemistry:cesium", "chemistry:cesium_crystal", "chemistry:rubidium_block", "chemistry:cesium_block", "chemistry:cesium_flowing", "chemistry:francium_block"},
		neighbors = {"group:water", "chemistry:oxygen", "group:acid"},
		interval = 1.0,
		chance = 3,
		catch_up = true,
		action = function(pos, node)
			tnt.boom(pos, chemical_boom2)
			if math.random() < 0.5 then
				minetest.set_node(pos, {name="fire:basic_flame"})
			end
		end,
	})
end

if chemical_boom3 then
	minetest.register_abm({
		label = "alkali metals ignition",
		nodenames = {"chemistry:sodium_block", "chemistry:potassium_block"},
		neighbors = {"chemistry:loxygen", "chemistry:loxygen_flowing"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			tnt.boom(pos, chemical_boom3)
			if math.random() < 0.5 then
				minetest.set_node(pos, {name="fire:basic_flame"})
			end
		end,
	})
end

if chemical_boom4 then
	minetest.register_abm({
		label = "alkali metals ignition",
		nodenames = {"chemistry:cesium", "chemistry:cesium_flowing", "chemistry:cesium_crystal", "chemistry:rubidium_block", "chemistry:cesium_block"},
		neighbors = {"chemistry:loxygen", "chemistry:loxygen_flowing"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			tnt.boom(pos, chemical_boom4)
			if math.random() < 0.5 then
				minetest.set_node(pos, {name="fire:basic_flame"})
			end
		end,
	})
end
end

if chemistry.config.allow_node_melt then
    local output_node = {name="chemistry:msodium"}
    minetest.register_abm({
		label = "chemistry: sodium melting",
		nodenames = {"chemistry:sodium_block"},
		neighbors = {"group:lava", "group:fire"},
	    interval = 1.0,
	    chance = 15,
	    catch_up = true,
	    action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, output_node)
			end	
		end,
    })

    local output_node = {name="chemistry:mpotassium"}
    minetest.register_abm({
    	label = "chemistry: potassium melting",
	    nodenames = {"chemistry:potassium_block"},
	    neighbors = {"group:lava", "group:fire"},
    	interval = 1.0,
    	chance = 15,
    	catch_up = true,
    	action = function(pos, node)
	    	if minetest.find_node_near(pos, 1, "group:igniter") then
			minetest.set_node(pos, output_node)
	    	end	
	    end,
    })

    local output_node = {name="chemistry:cesium"}
    minetest.register_abm({
    	label = "chemistry: cesium melting",
    	nodenames = {"chemistry:cesium_block"},
    	neighbors = {"group:lava", "group:fire"},
    	interval = 1.0,
    	chance = 15,
	    catch_up = true,
    	action = function(pos, node)
    		if minetest.find_node_near(pos, 1, "group:igniter") then
    		minetest.set_node(pos, output_node)
    		end	
    	end,
   })
end

local output_node = {name="chemistry:sodium_block"}
	minetest.register_abm({
		label = "sodium cooling",
		nodenames = {"chemistry:msodium"},
		interval = 1.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			if not minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, output_node)
			end	
		end,
	})

local output_node = {name="chemistry:potassium_block"}
	minetest.register_abm({
		label = "potassium cooling",
		nodenames = {"chemistry:mpotassium"},
		interval = 1.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			if not minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, output_node)
			end	
		end,
	})

local night_node = {name="chemistry:cesium_block"}
local day_node = {name="chemistry:cesium"}
	minetest.register_abm({
		label = "cesium cooling",
		nodenames = {"chemistry:cesium", "chemistry:cesium_block"},
		interval = 2.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)

			local above = minetest.find_node_near(pos, 1, {"air", "group:gaseous", "chemistry:cesium"})
			local tod = (core.get_timeofday() or 0) * 24000

			if not above then
				return
			end

			if tod < 5500 or tod > 18500 or (minetest.get_node_light(above) or 0) <= 7 then
				if not minetest.find_node_near(pos, 1, "group:igniter") and node.name == "chemistry:cesium" then
					minetest.set_node(pos, night_node)
				end
			elseif tod > 5500 or tod < 18500 then
				if node.name == "chemistry:cesium_block" and (minetest.get_node_light(above) or 0) > 7 then
					minetest.set_node(pos, day_node)
				end
			end
		end,
	})
