
local S = chemistry.getter


minetest.register_node("chemistry:mineral_oil", {
	description = S("Mineral Oil"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "oil_source_animated.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "oil_source_animated.png^[opacity:180",
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:mineral_oil_flowing",
	liquid_alternative_source = "chemistry:mineral_oil",
	liquid_viscosity = 1,
	post_effect_color = {a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, cools_lava = 1},
	sounds = chemistry.node_sound_oil(),
})

minetest.register_node("chemistry:mineral_oil_flowing", {
	description = S("Flowing Mineral Oil"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"oil.png"},
	special_tiles = {
		{
			name = "oil_flowing_animated.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "oil_flowing_animated.png^[opacity:180",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:mineral_oil_flowing",
	liquid_alternative_source = "chemistry:mineral_oil",
	liquid_viscosity = 1,
	liquid_range = 5,
	post_effect_color = {a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = chemistry.node_sound_oil(),
})

	bucket.register_liquid(
		"chemistry:mineral_oil",
		"chemistry:mineral_oil_flowing",
		"chemistry:mineral_oil_bucket",
		"oil_bucket.png",
		S("Mineral Oil Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:mineral_oil",
		"chemistry:mineral_oil_flowing",
		"chemistry:mineral_oil_bucket_plastic",
		"oil_bucket_plastic.png",
		S("Mineral Oil Bucket"),
		{tool = 1}
	)

minetest.register_node("chemistry:kerosene", {
	description = S("Kerosene"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "oil_source_animated.png^[opacity:170",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "oil_source_animated.png^[opacity:170",
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:kerosene_flowing",
	liquid_alternative_source = "chemistry:kerosene",
	liquid_viscosity = 1,
	post_effect_color = {a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, cools_lava = 1, fuel = 1, air_pollutioner = 1},
	sounds = chemistry.node_sound_oil(),
})

minetest.register_node("chemistry:kerosene_flowing", {
	description = S("Flowing Kerosene"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"oil.png"},
	special_tiles = {
		{
			name = "oil_flowing_animated.png^[opacity:170",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "oil_flowing_animated.png^[opacity:170",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:kerosene_flowing",
	liquid_alternative_source = "chemistry:kerosene",
	liquid_viscosity = 1,
	liquid_range = 5,
	post_effect_color = {a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, fuel = 1, air_pollutioner = 1},
	sounds = chemistry.node_sound_oil(),
})

	bucket.register_liquid(
		"chemistry:kerosene",
		"chemistry:kerosene_flowing",
		"chemistry:kerosene_bucket",
		"oil_bucket.png",
		S("Kerosene Bucket"),
		{tool = 1, fuel_bucket = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:kerosene",
		"chemistry:kerosene_flowing",
		"chemistry:kerosene_bucket_plastic",
		"oil_bucket_plastic.png",
		S("Kerosene Bucket"),
		{tool = 1, plastic_fuel_bucket = 1}
	)

minetest.register_node("chemistry:petroleum", {
	description = S("Petroleum"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "petrol_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "petrol_source_animated.png",
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:petroleum_flowing",
	liquid_alternative_source = "chemistry:petroleum",
	liquid_viscosity = 1,
	post_effect_color = {a = 230, r = 0, g = 0, b = 0},
	groups = {liquid = 3, cools_lava = 1, air_pollutioner = 1},
	sounds = chemistry.node_sound_oil(),
})

minetest.register_node("chemistry:petroleum_flowing", {
	description = S("Flowing Petroleum"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"petrol.png"},
	special_tiles = {
		{
			name = "petrol_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "petrol_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:petroleum_flowing",
	liquid_alternative_source = "chemistry:petroleum",
	liquid_viscosity = 1,
	liquid_range = 5,
	post_effect_color = {a = 230, r = 0, g = 0, b = 0},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, air_pollutioner = 1},
	sounds = chemistry.node_sound_oil(),
})

	bucket.register_liquid(
		"chemistry:petroleum",
		"chemistry:petroleum_flowing",
		"chemistry:petroleum_bucket",
		"petrol_bucket.png",
		S("Petroleum Bucket"),
		{tool = 1, fuel_bucket = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:petroleum",
		"chemistry:petroleum_flowing",
		"chemistry:petroleum_bucket_plastic",
		"petrol_bucket_plastic.png",
		S("Petroleum Bucket"),
		{tool = 1, plastic_fuel_bucket = 1}
	)

minetest.register_node("chemistry:gasoline", {
	description = S("Gasoline"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:170^[colorize:white:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:170^[colorize:white:100",
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:gasoline_flowing",
	liquid_alternative_source = "chemistry:gasoline",
	liquid_viscosity = 1,
	post_effect_color = {a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, cools_lava = 1, fuel = 1, air_pollutioner = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:gasoline_flowing", {
	description = S("Flowing Gasoline"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:170^[colorize:white:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:170^[colorize:white:100",
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
	liquid_renewable = false,
	liquid_alternative_flowing = "chemistry:gasoline_flowing",
	liquid_alternative_source = "chemistry:gasoline",
	liquid_viscosity = 1,
	liquid_range = 5,
	post_effect_color = {a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, fuel = 1, air_pollutioner = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:gasoline",
		"chemistry:gasoline_flowing",
		"chemistry:gasoline_bucket",
		"liquid_bucket.png",
		S("Gasoline Bucket"),
		{tool = 1, fuel_bucket = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:gasoline",
		"chemistry:gasoline_flowing",
		"chemistry:gasoline_bucket_plastic",
		"liquid_bucket_plastic.png",
		S("Gasoline Bucket"),
		{tool = 1, plastic_fuel_bucket = 1}
	)


minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "chemistry:kerosene_bucket",
	recipe = "chemistry:petroleum_bucket"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "chemistry:gasoline_bucket",
	recipe = "chemistry:kerosene_bucket"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "chemistry:bucket_with_plastic",
	recipe = "chemistry:gasoline_bucket"
})

minetest.register_craftitem("chemistry:bucket_with_plastic", {
	description = S("Bucket With Plastic"),
	inventory_image = "bucket_with_plastic.png",
})

minetest.register_craft({
   output = 'basic_materials:plastic_sheet 6',
   recipe = {
      {'chemistry:bucket_with_plastic'},
	},
   replacements = {{'chemistry:bucket_with_plastic', 'bucket:bucket_empty'}}
})

minetest.register_craft({
   output = 'chemistry:plastic_block',
   recipe = {
      {'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet'},
      {'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet'},
      {'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet'},
	}
})

minetest.register_craft({
   output = 'basic_materials:plastic_sheet 9',
   recipe = {
       {'chemistry:plastic_block'},
	}
})

minetest.register_node("chemistry:plastic_block", {
	description = S("Plastic Block"),
	tiles = {"plastic_block.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 2, flammable = 5, air_pollutioner = 1},
	sounds = default.node_sound_snow_defaults(),
})

	minetest.override_item("default:dirt", {
		drop = {
			max_items = 2,
			items = {
				{
					items = {"chemistry:baking_soda"},
					rarity = 20
				},
				{
					items = {"default:dirt"}
				}
			}
		}
	})

minetest.register_craft({
	type = "fuel",
	recipe = "group:fuel_bucket",
	burntime = 120,
	replacements = {{"group:fuel_bucket", "bucket:bucket_empty"}},
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:anthracite_trunk",
	burntime = 75,
})


minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:acetylene",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:anthracite_leaves",
	burntime = 50,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:anthracite_wood",
	burntime = 19,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:ionized_trunk",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:ionized_wood",
	burntime = 10,
})


minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:chestnut_trunk",
	burntime = 35,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:chestnut_wood",
	burntime = 9,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:ionized_leaves",
	burntime = 13,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:anthracite",
	burntime = 100,
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:anthracite_block",
	burntime = 900,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 75,
	output = "chemistry:anthracite",
	recipe = "chemistry:anthracite_trunk"
})

minetest.register_craftitem("chemistry:anthracite", {
	description = S("Anthracite Coal Lump"),
	inventory_image = "anthracite.png",
})

local function flood_flame(pos, _, newnode)
	-- Play flame extinguish sound if liquid is not an 'igniter'
	if minetest.get_item_group(newnode.name, "igniter") == 0 then
		minetest.sound_play("fire_extinguish_flame",
			{pos = pos, max_hear_distance = 16, gain = 0.15}, true)
	end
	-- Remove the flame
	return false
end

minetest.register_node("chemistry:anthracite_block", {
	description = S("Anthracite Block"),
	tiles = {"anthracite_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 1},
	on_heat = function(pos)
		local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(flame_pos).name == "air" then
			minetest.set_node(flame_pos, {name = "chemistry:permanent_anthracite_fire"})
		end
	end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'chemistry:anthracite 9',
	recipe = {
		{'chemistry:anthracite_block'}
	}
})

minetest.register_craft({
	output = 'chemistry:anthracite_block',
	recipe = {
		{'chemistry:anthracite', 'chemistry:anthracite', 'chemistry:anthracite'},
		{'chemistry:anthracite', 'chemistry:anthracite', 'chemistry:anthracite'},
		{'chemistry:anthracite', 'chemistry:anthracite', 'chemistry:anthracite'},
	}
})

minetest.register_node("chemistry:magnesium_anthracite_block", {
	description = S("Magnesium Anthracite Block"),
	tiles = {"anthracite_block.png^magnesium_anthracite_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("chemistry:magnesium_anthracite_block", {
	on_heat = function(pos)
		local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(flame_pos).name == "air" then
			minetest.set_node(flame_pos, {name = "chemistry:permanent_magnesium_fire"})
		end
	end
})

minetest.register_craft({
	output = 'chemistry:magnesium_anthracite_block 2',
	recipe = {
		{'chemistry:magnesium_block', 'chemistry:anthracite_block'}
	}
})


minetest.register_node("chemistry:anthracite_fire", {
	description = S("Anthracite Fire"),
	drawtype = "firelike",
	tiles = {{
		name = "anthracite_fire_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "anthracite_fire.png",
	paramtype = "light",
	light_source = 20,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	damage_per_second = 5,
	groups = {igniter = 2, fire = 1, anthracite_fire = 1, dig_immediate=3},
	drop = "",
   on_timer = function(pos)
	if not minetest.find_node_near(pos, 1, {"group:anthracite_material"}) then
		minetest.remove_node(pos)
		return
	end
	return true
end,
   on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(10, 20))
end,
   floodable = true,
   on_flood = flood_flame
})

minetest.register_node("chemistry:permanent_anthracite_fire", {
	description = S("Permanent Anthracite Fire"),
	drawtype = "firelike",
	tiles = {{
		name = "anthracite_fire_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "anthracite_fire.png",
	paramtype = "light",
	light_source = 20,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = false,
	damage_per_second = 5,
	groups = {igniter = 2, fire = 1, anthracite_fire = 1, dig_immediate=3},
	drop = "",
   floodable = true,
   on_flood = flood_flame
})

	minetest.register_abm({
		label = "Remove anthracite nodes",
		nodenames = {"chemistry:anthracite_fire"},
		neighbors = "group:anthracite_material",
		interval = 7,
		chance = 18,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"group:anthracite_material"})
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
		nodenames = {"group:anthracite_material"},
		neighbors = {"group:igniter"},
		interval = 5,
		chance = 12,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"air"})
			if p then
				minetest.set_node(p, {name = "chemistry:anthracite_fire"})
			end
		end
	})

	local flame_sound = minetest.settings:get_bool("flame_sound", true)

	if flame_sound then
		local handles = {}
		local timer = 0
	
		-- Parameters
		local radius = 8 -- Flame node search radius around player
		local cycle = 3 -- Cycle time for sound updates
	
		-- Update sound for player
		function chemistry.update_player_sound(player)
			local player_name = player:get_player_name()
			-- Search for flame nodes in radius around player
			local ppos = player:get_pos()
			local areamin = vector.subtract(ppos, radius)
			local areamax = vector.add(ppos, radius)
			local fpos, num = minetest.find_nodes_in_area(
				areamin,
				areamax,
				{"chemistry:anthracite_fire", "chemistry:permanent_anthracite_fire"}
			)
			-- Total number of flames in radius
			local flames = (num["chemistry:anthracite_fire"] or 0) +
				(num["chemistry:permanent_anthracite_fire"] or 0)
			-- Stop previous sound
			if handles[player_name] then
				minetest.sound_stop(handles[player_name])
				handles[player_name] = nil
			end
			-- If flames
			if flames > 0 then
				-- Find centre of flame positions
				local fposmid = fpos[1]
				-- If more than 1 flame
				if #fpos > 1 then
					local fposmin = areamax
					local fposmax = areamin
					for i = 1, #fpos do
						local fposi = fpos[i]
						if fposi.x > fposmax.x then
							fposmax.x = fposi.x
						end
						if fposi.y > fposmax.y then
							fposmax.y = fposi.y
						end
						if fposi.z > fposmax.z then
							fposmax.z = fposi.z
						end
						if fposi.x < fposmin.x then
							fposmin.x = fposi.x
						end
						if fposi.y < fposmin.y then
							fposmin.y = fposi.y
						end
						if fposi.z < fposmin.z then
							fposmin.z = fposi.z
						end
					end
					fposmid = vector.divide(vector.add(fposmin, fposmax), 2)
				end
				-- Play sound
				local handle = minetest.sound_play("fire_fire", {
					pos = fposmid,
					to_player = player_name,
					gain = math.min(0.06 * (1 + flames * 0.125), 0.18),
					max_hear_distance = 32,
					loop = true -- In case of lag
				})
				-- Store sound handle for this player
				if handle then
					handles[player_name] = handle
				end
			end
		end
	
		-- Cycle for updating players sounds
		minetest.register_globalstep(function(dtime)
			timer = timer + dtime
			if timer < cycle then
				return
			end
	
			timer = 0
			local players = minetest.get_connected_players()
			for n = 1, #players do
				chemistry.update_player_sound(players[n])
			end
		end)
	
		-- Stop sound and clear handle on player leave
		minetest.register_on_leaveplayer(function(player)
			local player_name = player:get_player_name()
			if handles[player_name] then
				minetest.sound_stop(handles[player_name])
				handles[player_name] = nil
			end
		end)
	end
	
	
	-- Deprecated function kept temporarily to avoid crashes if mod fire nodes call it
	function chemistry.update_sounds_around() end
	