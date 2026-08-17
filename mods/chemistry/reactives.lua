
local S = chemistry.getter

local chemical_boom = {
	name = "chemical_boom",
	--description = "explosion caused by chemical reactions",
	radius = 2,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}

local c4_boom = {
	name = "c4_boom",
	--description = "explosion caused by chemical reactions",
	radius = 3,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}

local orthogonal = {
	{x=0,y=0,z=1},
	{x=0,y=1,z=0},
	{x=1,y=0,z=0},
	{x=0,y=0,z=-1},
	{x=0,y=-1,z=0},
	{x=-1,y=0,z=0},
}

tnt.register_tnt(chemical_boom)

tnt.register_tnt(c4_boom)


minetest.register_node("chemistry:phosphorus_white", {
	description = S("White Phosphorus"),
	tiles = {"white_phosphorus.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

if chemistry.config.allow_explosive_nodes then

minetest.register_abm({
		label = "chemistry: phosphorus ignition",
		nodenames = {"chemistry:phosphorus_white"},
		interval = 1,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
			if minetest.get_node(target_pos).name == "air" or minetest.get_item_group(minetest.get_node(target_pos).name, "glycerin") > 0 then
				minetest.set_node(target_pos, {name="fire:basic_flame"})
			end	
		end,
	})

minetest.register_abm({
		label = "chemistry: phosphorus ignition2",
		nodenames = {"chemistry:phosphorus_white"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:fire"},
		interval = 1.0,
		chance = 12,
		catch_up = true,
		action = function(pos, node)
			tnt.boom(pos, chemical_boom)
			if math.random() < 0.5 then
				minetest.set_node(pos, {name="fire:basic_flame"})
			end
		end,
	})

	minetest.register_abm({
		label = "thermal ignition",
		nodenames = {"group:hot_thermite"},
		neighbors = {"default:ice", "default:cave_ice", "chemistry:dry_ice", "group:glow_ice"},
		interval = 1.0,
		chance = 3,
		catch_up = true,
		action = function(pos, node)
			tnt.boom(pos, chemical_boom)
			if math.random() < 0.5 then
				minetest.set_node(pos, {name="fire:basic_flame"})
			end
		end,
	})

local red_trans = {name ="chemistry:phosphorus_white"}
minetest.register_abm({
		label = "chemistry: phosphorus transform",
		nodenames = {"chemistry:phosphorus_red"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:igniter"},
		interval = 5.0,
		chance = 6,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:igniter") then
				minetest.set_node(pos, red_trans)
			end	
		end,
	})

minetest.register_node("chemistry:will_explode", {
	description = S("WILL EXPLODE!!!!"),
	inventory_image = "no_texture_airlike.png",
	wield_image = "no_texture_airlike.png",
	drawtype = "airlike",
	paramtype = "none",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = false,
	air_equivalent = true,
	drop = "",
	groups = {not_in_creative_inventory=1},
	node_placement_prediction = "",
   on_timer = function(pos)
		tnt.boom(pos, chemical_boom)
   end,
   on_construct = function(pos)
	   minetest.get_node_timer(pos):start(0.1)
   end,
	on_blast = function() end,
})

minetest.register_node("chemistry:c4_explode", {
	inventory_image = "no_texture_airlike.png",
	wield_image = "no_texture_airlike.png",
	drawtype = "airlike",
	paramtype = "none",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = false,
	air_equivalent = true,
	drop = "",
	groups = {not_in_creative_inventory=1},
	node_placement_prediction = "",
   on_timer = function(pos)
		tnt.boom(pos, c4_boom)
   end,
   on_construct = function(pos)
	   minetest.get_node_timer(pos):start(math.random(0.1, 0.1))
   end,
	on_blast = function() end,
})

minetest.register_node("chemistry:phosphorus_red", {
	description = S("Red Phosphorus"),
	tiles = {"red_phosphorus.png"},
	groups = {crumbly = 3, falling_node = 1},
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="chemistry:will_explode"})
		   minetest.registered_nodes["chemistry:will_explode"].on_construct(pos)
      end)
	end,
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:phosphorus_purple", {
	description = S("Purple Phosphorus"),
	tiles = {"purple_phosphorus.png"},
	groups = {crumbly = 3, falling_node = 1},
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="chemistry:will_explode"})
		   minetest.registered_nodes["chemistry:will_explode"].on_construct(pos)
      end)
	end,
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:nitroglycerin", {
	description = S("Nitroglycerin"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "oil_source_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "oil_source_animated.png^[opacity:200",
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
	on_blast = function(pos, intensity)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="chemistry:will_explode"})
		   minetest.registered_nodes["chemistry:will_explode"].on_construct(pos)
      end)
	end,
	on_burn = function(pos)
		tnt.boom(pos, chemical_boom)
	end,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:nitroglycerin_flowing",
	liquid_alternative_source = "chemistry:nitroglycerin",
	liquid_viscosity = 1,
	post_effect_color ={a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, cools_lava = 1, flammable = 10},
	sounds = chemistry.node_sound_oil(),
})

minetest.register_node("chemistry:nitroglycerin_flowing", {
	description = S("Flowing Nitroglycerin"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"oil.png"},
	special_tiles = {
		{
			name = "oil_flowing_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "oil_flowing_animated.png^[opacity:200",
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
	on_blast = function(pos, intensity)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="chemistry:will_explode"})
		   minetest.registered_nodes["chemistry:will_explode"].on_construct(pos)
      end)
	end,
	on_burn = function(pos)
		tnt.boom(pos, chemical_boom)
	end,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:nitroglycerin_flowing",
	liquid_alternative_source = "chemistry:nitroglycerin",
	liquid_viscosity = 1,
	liquid_range = 5,
	post_effect_color = {a = 100, r = 250, g = 250, b = 250},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, flammable = 10},
	sounds = chemistry.node_sound_oil(),
})

	bucket.register_liquid(
		"chemistry:nitroglycerin",
		"chemistry:nitroglycerin_flowing",
		"chemistry:nitroglycerin_bucket",
		"oil_bucket.png",
		S("Nitroglycerin Bucket"),
		{tool = 1, explosive = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:nitroglycerin",
		"chemistry:nitroglycerin_flowing",
		"chemistry:nitroglycerin_bucket_plastic",
		"oil_bucket_plastic.png",
		S("Nitroglycerin Bucket"),
		{tool = 1, explosive = 1}
	)

    if minetest.get_modpath("mesecons") then
		minetest.register_node("chemistry:c4", {
			description = S("C4 Bomb"),
			tiles = {"c4_base.png", "c4_base.png", "c4_side.png"},
			is_ground_content = false,
			groups = {dig_immediate = 2, mesecon = 2, flammable = 5},
			sounds = default.node_sound_wood_defaults(),
			after_place_node = function(pos, placer)
				if placer and placer:is_player() then
					local meta = minetest.get_meta(pos)
					meta:set_string("owner", placer:get_player_name())
				end
			end,
			on_blast = function(pos)
		      minetest.after(0.1, function()
      	      minetest.set_node(pos, {name="chemistry:c4_explode"})
		         minetest.registered_nodes["chemistry:c4_explode"].on_construct(pos)
            end)
			end,
			mesecons = {effector =
				{action_on =
					function(pos)
      	          minetest.set_node(pos, {name="chemistry:c4_lit"})
		             minetest.registered_nodes["chemistry:c4_lit"].on_construct(pos)
					end
				}
			},
			on_burn = function(pos)
				minetest.after(0.5, function()
					tnt.boom(pos, c4_boom)
				end)
			end,
		})

		minetest.register_node("chemistry:c4_lit", {
			tiles = {"c4_base.png", "c4_base.png", "c4_side.png"},
			is_ground_content = false,
		   groups = {not_in_creative_inventory = 1},
			sounds = default.node_sound_wood_defaults(),
         on_timer = function(pos)
	      	tnt.boom(pos, c4_boom)
         end,
         on_construct = function(pos)
	         minetest.get_node_timer(pos):start(5)
				      minetest.sound_play(
					      "c4_beep",
					      {pos = pos, max_hear_distance = 18, gain = 0.5}
                   )
         end,
	      on_blast = function() end,
       })

    minetest.register_craft({
    	output = 'chemistry:c4 5',
    	recipe = {
	    	{'chemistry:plastic_block', 'default:mese_crystal', 'chemistry:plastic_block'},
	    	{'default:mese_crystal', 'chemistry:nitroglycerin_bucket', 'default:mese_crystal'},
		    {'chemistry:plastic_block', 'default:mese_crystal', 'chemistry:plastic_block'},
	    },
        replacements = {{'chemistry:nitroglycerin_bucket', 'bucket:bucket_empty'}}
    })
    end

    minetest.register_craft({
  	 	type = "shapeless",
    	output = 'chemistry:nitroglycerin_bucket',
    	recipe = {
    		'chemistry:hno_acid_bucket', 'chemistry:glycerin_bucket',
    	},
        replacements = {{'chemistry:hno_acid_bucket', 'plastic_bucket:bucket_empty'}}
    })

    minetest.register_craft({
   		type = "shapeless",
    	output = 'chemistry:nitroglycerin_bucket_plastic',
    	recipe = {
    		'chemistry:hno_acid_bucket', 'chemistry:glycerin_bucket_plastic',
    	},
        replacements = {{'chemistry:hno_acid_bucket', 'plastic_bucket:bucket_empty'}}
    })
	
	minetest.register_node("chemistry:mn2o7", {
		description = S("Manganese Heptoxide"),
		drawtype = "liquid",
		tiles = {"black.png^[colorize:green:75^[opacity:210"},
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
		liquid_alternative_flowing = "chemistry:mn2o7_flowing",
		liquid_alternative_source = "chemistry:mn2o7",
		liquid_viscosity = 1,
		liquid_range = 3,
		liquid_renewable = false,
		damage_per_second = 5,
		corrosive = true,
		corrosion_level = 2,
		post_effect_color = {a = 255, r = 1, g = 1, b = 1},
		groups = {liquid = 4, igniter = 1, corrosive = 1, toxic_to_crops = 1, 
			acid = 1},
	})

	minetest.register_node("chemistry:mn2o7_flowing", {
		description = S("Flowing Manganese Heptoxide"),
		drawtype = "flowingliquid",
		tiles = {"black.png^[colorize:green:75^[opacity:210"},
  		special_tiles = {"black.png^[colorize:green:75^[opacity:210", "black.png^[colorize:green:75^[opacity:210"},
		paramtype = "light",
		use_texture_alpha = "blend",
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
		liquid_alternative_flowing = "chemistry:mn2o7_flowing",
		liquid_alternative_source = "chemistry:mn2o7",
		liquid_viscosity = 1,
		liquid_range = 3,
		liquid_renewable = false,
		damage_per_second = 5,
		corrosive = true,
		corrosion_level = 2,
		post_effect_color = {a = 255, r = 1, g = 1, b = 1},
		groups = {liquid = 4, igniter = 1, corrosive = 1,
			not_in_creative_inventory = 1, toxic_to_crops = 1, acid = 1},
	})

	plastic_bucket.register_liquid(
		"chemistry:mn2o7",
		"chemistry:mn2o7_flowing",
		"chemistry:mn2o7_bucket",
		"black_plastic_bucket.png",
	   S("Manganese Heptoxide Bucket"),
		{tool = 1, oxidizer = 1, volatile = 1}
	)

    minetest.register_craft({
   		type = "shapeless",
    	output = 'chemistry:mn2o7_bucket',
    	recipe = {
    		'chemistry:hso_acid_bucket', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate',
    	},
        replacements = {{'chemistry:hso_acid_bucket', 'plastic_bucket:bucket_empty'}}
    })

	minetest.register_on_player_hpchange(function(player, hp_change, reason)

		local dmg_nodes = {
			{"chemistry:mn2o7"},
			{"chemistry:mn2o7_flowing"}
		}

		if reason.type == "node_damage" and reason.node then
			for _, heptoxide in pairs(dmg_nodes) do
				if reason.node == heptoxide[1] then
					hp_change = hp_change * 2
					local p_pos = player:get_pos()
					local f_pos = minetest.find_node_near(p_pos, 1, {"air", "group:liquid"})
					if minetest.get_node(p_pos).name == "air" or minetest.get_item_group(p_pos, "liquid") > 0 then
						minetest.set_node(p_pos, {name="chemistry:will_explode"})
					elseif f_pos then
						minetest.set_node(f_pos, {name="chemistry:will_explode"})
					else
						minetest.set_node(p_pos, {name="chemistry:will_explode"})
					end
				end
			end
		end
		return hp_change
	end, true)

	local organic_nodes = {"group:flora", "group:flammable", "group:choppy", "group:snappy", "group:plant", "group:anthracite_material"}
	local organic_liquids = {"group:fuel", "group:very_flammable"}

	minetest.register_abm({
		label = "chemistry:manganese_heptoxide",
		nodenames = {"chemistry:mn2o7", "chemistry:mn2o7_flowing"},
		interval = 10.0,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
			local n = minetest.find_node_near(pos, 1, organic_nodes)
			local l = minetest.find_node_near(pos, 1, organic_liquids)
			if n then
				minetest.set_node(n, {name="chemistry:will_explode"})
			elseif l then
				minetest.set_node(l, {name="chemistry:will_explode"})
			end
		end,
	})

elseif not chemistry.config.allow_explosive_nodes then

    minetest.register_node("chemistry:phosphorus_red", {
	    description = S("Red Phosphorus"),
    	tiles = {"red_phosphorus.png"},
    	groups = {crumbly = 3, falling_node = 1},
    	sounds = default.node_sound_sand_defaults(),
    })

    minetest.register_node("chemistry:phosphorus_purple", {
    	description = S("Purple Phosphorus"),
    	tiles = {"purple_phosphorus.png"},
    	groups = {crumbly = 3, falling_node = 1},
    	sounds = default.node_sound_sand_defaults(),
    })

end


minetest.register_node("chemistry:glycerin", {
	description = S("Glycerin"),
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
	liquid_alternative_flowing = "chemistry:glycerin_flowing",
	liquid_alternative_source = "chemistry:glycerin",
	liquid_viscosity = 2,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, cools_lava = 1, glycerin = 1},
	sounds = chemistry.node_sound_oil(),
})

minetest.register_node("chemistry:glycerin_flowing", {
	description = S("Flowing Glycerin"),
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
				length = 2,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:190",
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
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:glycerin_flowing",
	liquid_alternative_source = "chemistry:glycerin",
	liquid_viscosity = 2,
	liquid_range = 5,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, glycerin = 1},
	sounds = chemistry.node_sound_oil(),
})

	bucket.register_liquid(
		"chemistry:glycerin",
		"chemistry:glycerin_flowing",
		"chemistry:glycerin_bucket",
		"liquid_bucket.png",
		S("Glycerin Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:glycerin",
		"chemistry:glycerin_flowing",
		"chemistry:glycerin_bucket_plastic",
		"liquid_bucket_plastic.png",
		S("Glycerin Bucket"),
		{tool = 1}
	)

minetest.register_craftitem("chemistry:potassium_permanganate", {
	description = S("Potassium Permanganate Powder"),
	inventory_image = "potassium_permanganate.png",
})


minetest.register_craftitem("chemistry:kmno4_powder_with_glycerin", {
	description = S("Potassium Permanganate Powder with Glycerin"),
	inventory_image = "potassium_permanganate_burning.png",
	liquids_pointable = true,
	on_place = function(itemstack, user, pointed_thing)
		local sound_pos = pointed_thing.above or user:get_pos()
		minetest.sound_play("thermite_ignite",
			{pos = sound_pos, gain = 0.2, max_hear_distance = 5}, true)
		local player_name = user:get_player_name()
		if pointed_thing.type == "node" then
			local node_under = minetest.get_node(pointed_thing.under).name
			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.record_protection_violation(pointed_thing.under, player_name)
				return
			end
        if minetest.get_item_group(node_under, "fire") >= 1 then
					return
			elseif nodedef.on_ignite then
				nodedef.on_ignite(pointed_thing.under, user)
			elseif nodedef.on_heat then
               nodedef.on_heat(pointed_thing.under, user)
			elseif minetest.get_item_group(node_under, "anthracite_material") >= 1
			    and minetest.get_node(pointed_thing.above).name == "air" then
					if minetest.is_protected(pointed_thing.above, player_name) then
						minetest.record_protection_violation(pointed_thing.above, player_name)
						return
					end
	
					minetest.set_node(pointed_thing.above, {name = "chemistry:anthracite_fire"})
			elseif minetest.get_node(node_under, pointed_thing.above)
					and minetest.get_node(pointed_thing.above).name == "air" then
				if minetest.is_protected(pointed_thing.above, player_name) then
					minetest.record_protection_violation(pointed_thing.above, player_name)
					return
				end

				minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
			end
		end
		if not minetest.is_creative_enabled(player_name) then
			itemstack:take_item(1)
			return itemstack
		end
	end,
})

minetest.register_node("chemistry:potassium_permanganate_block", {
	description = S("Potassium Permanganate Block"),
	tiles = {"potassium_permanganate_block.png"},
	is_ground_content = true,
	groups = {crumbly = 2, falling_node = 1},
   on_timer = function(pos)
	if minetest.find_node_near(pos, 1, {"group:glycerin"}) then
		minetest.set_node(pos, {name="chemistry:kmno4_with_glycerin"})
		minetest.registered_nodes["chemistry:kmno4_with_glycerin"].on_construct(pos)
	end
end,
   on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(20, 30))
end,
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_abm({
	label = "permanganate ignition",
	nodenames = {"chemistry:potassium_permanganate_block"},
	interval = 5.0,
	chance = 10,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, {"group:glycerin"}) then
			minetest.set_node(pos, {name="chemistry:kmno4_with_glycerin"})
		end
	end,
})

minetest.register_node("chemistry:kmno4_with_glycerin", {
	description = S("Potassium Permanganate with glycerin"),
	tiles = {"potassium_permanganate_block.png^[colorize:black:100"},
	is_ground_content = true,
	groups = {crumbly = 2, falling_node = 1, not_in_creative_inventory = 1},
  	on_timer = function(pos)
		minetest.set_node(pos, {name="chemistry:hot_kmno4"})
		minetest.registered_nodes["chemistry:hot_kmno4"].on_construct(pos)
	end,
   	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(10, 30))
	end,
	collision_box = {
		type = "fixed", fixed = {{-8 / 16, -8 / 16, -8 / 16, 8 / 16, 6 / 16, 8 / 16}}
	},
	drop = {
		max_items = 5,
		items = {
			{
				items = {'chemistry:kmno4_powder_with_glycerin', 3},
			},
			{
				items = {'chemistry:kmno4_powder_with_glycerin', 3},
				rarity = 3,
			},
			{
				items = {'chemistry:kmno4_powder_with_glycerin', 3},
				rarity = 5,
			},
      }
   },
	sounds = default.node_sound_sand_defaults({
		footstep = {name = "default_dirt_footstep", gain = 0.2},
	}),
})

minetest.register_node("chemistry:hot_kmno4", {
	description = S("Hot Potassium Permanganate"),
	tiles = {"potassium_permanganate_block.png^[colorize:red:50"},
	is_ground_content = true,
	groups = {crumbly = 2, falling_node = 1, not_in_creative_inventory = 1},
  	on_timer = function(pos)
		minetest.set_node(pos, {name="air"})
	end,
   	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(10, 20))
	end,
	collision_box = {
		type = "fixed", fixed = {{-8 / 16, -8 / 16, -8 / 16, 8 / 16, 6 / 16, 8 / 16}}
	},
	drop = "",
	sounds = default.node_sound_sand_defaults({
		footstep = {name = "default_dirt_footstep", gain = 0.2},
	}),
})

minetest.register_craft({
	output = 'chemistry:potassium_permanganate_block',
	recipe = {
		{'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate'},
		{'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate'},
		{'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate'},
	}
})

-- KMnO4 Items from KMnO4 Block Crafting
minetest.register_craft({
	output = 'chemistry:potassium_permanganate 9',
	recipe = {
		{'chemistry:potassium_permanganate_block'},
	}
})

	minetest.register_abm({
		label = "chemistry: kmno4 ignition",
		nodenames = {"chemistry:hot_kmno4"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
			if minetest.get_node(target_pos).name == "air" or minetest.get_item_group(minetest.get_node(target_pos).name, "glycerin") > 0 then
				minetest.set_node(target_pos, {name="fire:basic_flame"})
			end	
		end,
	})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:potassium_permanganate',
	recipe = {
		'fire:flint_and_steel', 'chemistry:potassium_hydroxide', 'chemistry:manganese_oxide',
	},
   replacements = {{"fire:flint_and_steel", "fire:flint_and_steel"}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:kmno4_powder_with_glycerin',
	recipe = {
		'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate',
		'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate',
		'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:glycerin_bucket',
	},
   replacements = {{"chemistry:glycerin_bucket", "bucket:bucket_empty"}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:kmno4_powder_with_glycerin',
	recipe = {
		'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate',
		'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate',
		'chemistry:potassium_permanganate', 'chemistry:potassium_permanganate', 'chemistry:glycerin_bucket_plastic',
	},
   replacements = {{"chemistry:glycerin_bucket_plastic", "plastic_bucket:bucket_empty"}},
})

