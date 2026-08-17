

local S = chemistry.getter

minetest.register_node("chemistry:st_lava", {
	description = S("Strong Lava"),
	drawtype = "liquid",
	tiles = {
		{
			name = "st_lava_source_anim.png",
			backface_culling = false,
			align_style      = "world",
			scale            = 2,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0,
			},
		},
		{
			name = "st_lava_source_anim.png",
			backface_culling = true,
			align_style      = "world",
			scale            = 2,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0,
			},
		},
	},
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:st_lava_flowing",
	liquid_alternative_source = "chemistry:st_lava",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 20,
	post_effect_color = {a = 240, r = 0, g = 173, b = 98},
	groups = {lava = 3, strong_lava = 1, liquid = 2, igniter = 1,
		not_in_creative_inventory = 0},
})

minetest.register_node("chemistry:st_lava_flowing", {
	description = S("Flowing Strong Lava"),
	drawtype = "flowingliquid",
	tiles = {"st_lava.png"},
	special_tiles = {
		{
			name = "st_lava_flowing_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
		{
			name = "st_lava_flowing_anim.png",
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
	paramtype2 = "flowingliquid",
	light_source = default.LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:st_lava_flowing",
	liquid_alternative_source = "chemistry:st_lava",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 20,
	post_effect_color = {a = 240, r = 0, g = 173, b = 98},
	groups = {lava = 3, strong_lava = 1, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})


minetest.register_node("chemistry:st_lava_temp", {
	description = S("Temporal Strong Lava"),
	drawtype = "liquid",
	tiles = {
		{
			name = "st_lava_source_anim.png^[colorize:black:100",
			backface_culling = false,
			align_style      = "world",
			scale            = 2,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0,
			},
		},
		{
			name = "st_lava_source_anim.png^[colorize:black:100",
			backface_culling = true,
			align_style      = "world",
			scale            = 2,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0,
			},
		},
	},
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:st_lava_temp_flowing",
	liquid_alternative_source = "chemistry:st_lava_temp",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 20,
	post_effect_color = {a = 240, r = 0, g = 173, b = 98},
   liquid_range = 3,
	groups = {lava = 3, strong_lava = 1, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

minetest.register_node("chemistry:st_lava_temp_flowing", {
	description = S("Flowing Temporal Strong Lava"),
	drawtype = "flowingliquid",
	tiles = {"st_lava.png^[colorize:black:100"},
	special_tiles = {
		{
			name = "st_lava_flowing_anim.png^[colorize:black:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
		{
			name = "st_lava_flowing_anim.png^[colorize:black:100",
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
	paramtype2 = "flowingliquid",
	light_source = default.LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:st_lava_temp_flowing",
	liquid_alternative_source = "chemistry:st_lava_temp",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 20,
	post_effect_color = {a = 240, r = 0, g = 173, b = 98},
   liquid_range = 3,
	groups = {lava = 3, strong_lava = 1, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"group:cools_lava"},
		neighbors = {"group:strong_lava", "group:hot_thermite", "group:super_hot_metal"},
		interval = 2.0,
		chance = 3,
		catch_up = true,
		action = function(pos, node)
		local next_pos = {x=pos.x, y=pos.y, z=pos.z}
		local next_node = minetest.get_node(next_pos)
		   if minetest.get_item_group(next_node.name, "liquid") > 0 then
				minetest.set_node(pos, {name="air"})
				if chemistry.config.node_particles == "All" then
                	minetest.add_particlespawner({
	    	            amount = 20,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
				elseif chemistry.config.node_particles == "Decreased" then
					minetest.add_particlespawner({
	    	            amount = 10,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
				end
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
	      elseif node.name == "default:snowblock" then
		      minetest.set_node(pos, {name = "default:water_source"})
			    if chemistry.config.node_particles == "All" then
					minetest.add_particlespawner({
	    	            amount = 20,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
				elseif chemistry.config.node_particles == "Decreased" then
					minetest.add_particlespawner({
	    	            amount = 10,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
				end
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
	      elseif node.name == "default:ice" then
		        minetest.set_node(pos, {name = "default:water_source"})
			    if chemistry.config.node_particles == "All" then
					minetest.add_particlespawner({
	    	            amount = 20,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
			    elseif chemistry.config.node_particles == "Decreased" then
					minetest.add_particlespawner({
	    	            amount = 10,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
			    end
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
	      elseif node.name == "default:cave_ice" then
		        minetest.set_node(pos, {name = "default:water_source"})
			    if chemistry.config.node_particles == "All" then
					minetest.add_particlespawner({
	    	            amount = 20,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
			    elseif chemistry.config.node_particles == "Decreased" then
					minetest.add_particlespawner({
	    	            amount = 10,
	                	time = 0.15,
         	        	minpos = {x=pos.x - 0.4, y=pos.y - 0,   z=pos.z - 0.4},
         	        	maxpos = {x=pos.x + 0.4, y=pos.y + 0.5, z=pos.z + 0.4},
	                 	minvel = {x = -0.5, y = 0.5, z = -0.5},
	                 	maxvel = {x =  0.5, y = 1.5, z =  0.5},
         		        minacc = {x = 0, y = 0.1, z = 0},
	         	        maxacc = {x = 0, y = 0.2, z = 0},
		                minexptime = 0.5,
	         	        maxexptime = 1.3,
	         	        minsize = 3.5,
	                 	maxsize = 5.5,
	                 	texture = "tnt_smoke.png",
         	        })
				end
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:st_lava_flowing", "chemistry:st_lava_temp_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_water", "group:freezer"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:stone"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 18, gain = 0.05}
          )
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:st_lava", "chemistry:st_lava_temp"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_water", "group:freezer"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:obsidian"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 18, gain = 0.05}
          )
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:dry_ice"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:strong_lava", "group:hot_thermite", "group:super_hot_metal"},
		interval = 2.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:carbon_dioxide"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 18, gain = 0.05}
          )
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:st_lava_temp"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 20,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="chemistry:stone"})
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:st_lava_temp_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 2.0,
		chance = 20,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.set_node(pos, {name="chemistry:stone"})
			end	
		end,
	})

minetest.register_node("chemistry:obsidian", {
	description = S("Strong Obsidian"),
	tiles = {"st_obsidian.png"},
	on_blast = function() end,
	groups = {cracky = 1, strong_obsidian = 1, level = 6},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:obsidian_brick", {
	description = S("Strong Obsidian Brick"),
	tiles = {"st_obsidian_brick.png"},
	on_blast = function() end,
	groups = {cracky = 1, strong_obsidian = 1, level = 7},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:obsidian_block", {
	description = S("Strong Obsidian Block"),
	tiles = {"st_obsidian_block.png"},
	on_blast = function() end,
	groups = {cracky = 1, strong_obsidian = 1, level = 7},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_craftitem("chemistry:obsidian_shard", {
	description = S("Strong Obsidian Shard"),
	inventory_image = "st_obsidian_shard.png",
})

stairs.register_stair(
	"st_obsidian_brick",
	"chemistry:obsidian_brick",
	{cracky = 1, strong_obsidian = 1, level = 7},
	{"st_obsidian_brick.png"},
	S("Strong Obsidian Brick Stair"),
	chemistry.node_sound_strong()
)
stairs.register_slab(
	"st_obsidian_brick",
	"chemistry:obsidian_brick",
	{cracky = 1, strong_obsidian = 1, level = 7},
	{"st_obsidian_brick.png"},
	S("Strong Obsidian Brick Slab"),
	chemistry.node_sound_strong()
)
stairs.register_stair(
	"st_obsidian_block",
	"chemistry:obsidian_block",
	{cracky = 1, strong_obsidian = 1, level = 7},
	{"st_obsidian_block.png"},
	S("Strong Obsidian Block Stair"),
	chemistry.node_sound_strong()
)
stairs.register_slab(
	"st_obsidian_block",
	"chemistry:obsidian_block",
	{cracky = 1, strong_obsidian = 1, level = 7},
	{"st_obsidian_block.png"},
	S("Strong Obsidian Block Slab"),
	chemistry.node_sound_strong()
)
minetest.register_craft({
	output = 'chemistry:obsidian_brick 4',
	recipe = {
		{'chemistry:obsidian', 'chemistry:obsidian', ''},
		{'chemistry:obsidian', 'chemistry:obsidian', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_block 9',
	recipe = {
		{'chemistry:obsidian', 'chemistry:obsidian', 'chemistry:obsidian'},
		{'chemistry:obsidian', 'chemistry:obsidian', 'chemistry:obsidian'},
		{'chemistry:obsidian', 'chemistry:obsidian', 'chemistry:obsidian'},
	}
})


minetest.register_craft({
	output = 'chemistry:obsidian',
	recipe = {
		{'chemistry:obsidian_shard', 'chemistry:obsidian_shard', 'chemistry:obsidian_shard'},
		{'chemistry:obsidian_shard', 'chemistry:obsidian_shard', 'chemistry:obsidian_shard'},
		{'chemistry:obsidian_shard', 'chemistry:obsidian_shard', 'chemistry:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_shard 9',
	recipe = {
		{'chemistry:obsidian'},
	}
})

	bucket.register_liquid(
		"chemistry:st_lava",
		"chemistry:st_lava_flowing",
		"chemistry:st_lava_bucket",
		"st_lava_bucket.png",
		S("Strong Lava Bucket"),
		{tool = 1}
	)

if chemistry.config.allow_node_melt then
	minetest.register_abm({
		label = "chemistry: bismuth melting",
		nodenames = {"group:cracky", "group:level", "group:crumbly", "group:choppy"},
		neighbors = {"group:strong_lava", "group:super_hot_metal"},
		interval = 5.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
	      if minetest.get_item_group(node.name, "stone") > 0 then
		      minetest.swap_node(pos, {name = "default:lava_source"})
	      elseif node.name == "default:obsidian" then
		      minetest.swap_node(pos, {name = "default:lava_source"})
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


minetest.register_craftitem("chemistry:obsidian_ingot", {
	description = S("Stronger Obsidian Ingot"),
	inventory_image = "stronger_obsidian_ingot.png",
})

minetest.register_craftitem("chemistry:obsidian_lump", {
	description = S("Stronger Obsidian Lump"),
	inventory_image = "stronger_obsidian_lump.png",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 40,
	output = "chemistry:obsidian_ingot",
	recipe = "chemistry:obsidian_lump"
})

minetest.register_node("chemistry:stronger_obsidian_block", {
	description = S("Stronger Obsidian Block"),
	tiles = {"stronger_obsidian_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 9},
	on_blast = function() end,
	sounds = chemistry.node_sound_strong(),
})

minetest.register_craft({
	output = 'chemistry:stronger_obsidian_block',
	recipe = {
		{'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot'},
		{'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot'},
		{'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot'},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_ingot 9',
	recipe = {
		{'chemistry:stronger_obsidian_block'},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_lump',
	recipe = {
		{'chemistry:crystal_shard', 'chemistry:crystal_shard', 'chemistry:crystal_shard'},
		{'chemistry:crystal_shard', 'chemistry:obsidian', 'chemistry:crystal_shard'},
		{'chemistry:crystal_shard', 'chemistry:crystal_shard', 'chemistry:crystal_shard'},
	}
})

minetest.register_node("chemistry:obsidian_glass", {
	description = S("Strong Obsidian Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"st_obsidian_glass.png", "invisible.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 1, level = 5},
	on_blast = function() end,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "chemistry:obsidian_glass",
	recipe = "chemistry:obsidian_shard"
})

