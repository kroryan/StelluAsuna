
local directions = {
	{x=1, y=0, z=0},
	{x=-1, y=0, z=0},
	{x=0, y=0, z=1},
	{x=0, y=0, z=-1},
}
local orthogonal = {
	{x=0,y=0,z=1},
	{x=0,y=1,z=0},
	{x=1,y=0,z=0},
	{x=0,y=0,z=-1},
	{x=0,y=-1,z=0},
	{x=-1,y=0,z=0},
}

minetest.register_abm({
    label = "chemistry:gases_movement",
    nodenames = {"group:heavy_gas"},
    neighbors = {"group:liquid", "air", "group:falling_node"},
    interval = 1,
    chance = 1,
    catch_up = true,
    action = function(pos, node)
      local inicial_pos = {x=pos.x, y=pos.y, z=pos.z}
		local nodedef = minetest.get_node(inicial_pos)
		local next_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		local next_node = minetest.get_node(next_pos)
		if minetest.get_item_group(next_node.name, "liquid") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		elseif minetest.get_item_group(next_node.name, "falling_node") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		else
			next_pos.y = pos.y-1
			next_node = minetest.get_node(next_pos)
			if next_node.name == "air" then
				minetest.swap_node(next_pos, nodedef)
				minetest.swap_node(pos, next_node)			
			else
				local dir = directions[math.random(1,4)]
				local next_pos = vector.add(pos, dir)
				local next_node = minetest.get_node(next_pos)
				if next_node.name == "air" or  minetest.get_item_group(next_node.name, "liquid") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            end
			end
		end
	end,
})

minetest.register_abm({
    label = "chemistry:gases_movement",
    nodenames = {"group:gas"},
    neighbors = {"group:liquid", "air", "group:falling_node", "group:heavy_gas"},
    interval = 1,
    chance = 1,
    catch_up = true,
    action = function(pos, node)
      local inicial_pos = {x=pos.x, y=pos.y, z=pos.z}
		local nodedef = minetest.get_node(inicial_pos)
		local next_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		local next_node = minetest.get_node(next_pos)
		if minetest.get_item_group(next_node.name, "liquid") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		elseif minetest.get_item_group(next_node.name, "falling_node") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
      elseif minetest.get_item_group(next_node.name, "heavy_gas") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		else
			next_pos.y = pos.y-1
			next_node = minetest.get_node(next_pos)
			if next_node.name == "air" then
				minetest.swap_node(next_pos, nodedef)
				minetest.swap_node(pos, next_node)			
			else
				local dir = directions[math.random(1,4)]
				local next_pos = vector.add(pos, dir)
				local next_node = minetest.get_node(next_pos)
				if next_node.name == "air" or  minetest.get_item_group(next_node.name, "liquid") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            elseif next_node.name == "air" or  minetest.get_item_group(next_node.name, "heavy_gas") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            end
			end
		end
	end,
})

minetest.register_abm({
    label = "chemistry:gases_movement",
    nodenames = {"group:light_gas"},
    neighbors = {"group:liquid", "air", "group:falling_node", "group:heavy_gas", "group:gas"},
    interval = 1,
    chance = 1,
    catch_up = true,
    action = function(pos, node)
      local inicial_pos = {x=pos.x, y=pos.y, z=pos.z}
		local nodedef = minetest.get_node(inicial_pos)
		local next_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		local next_node = minetest.get_node(next_pos)
		if minetest.get_item_group(next_node.name, "liquid") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		elseif minetest.get_item_group(next_node.name, "falling_node") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
      elseif minetest.get_item_group(next_node.name, "heavy_gas") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
      elseif minetest.get_item_group(next_node.name, "gas") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		else
			next_pos.y = pos.y-1
			next_node = minetest.get_node(next_pos)
			if next_node.name == "air" then
				minetest.swap_node(next_pos, nodedef)
				minetest.swap_node(pos, next_node)			
			else
				local dir = directions[math.random(1,4)]
				local next_pos = vector.add(pos, dir)
				local next_node = minetest.get_node(next_pos)
				if next_node.name == "air" or  minetest.get_item_group(next_node.name, "liquid") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            elseif next_node.name == "air" or  minetest.get_item_group(next_node.name, "heavy_gas") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            elseif next_node.name == "air" or  minetest.get_item_group(next_node.name, "gas") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            end
			end
		end
	end,
})

minetest.register_abm({
    label = "chemistry:gases_movement",
    nodenames = {"group:lighter_gas"},
    neighbors = {"group:liquid", "air", "group:falling_node", "group:heavy_gas", "group:gas", "group:light_gas"},
    interval = 1,
    chance = 1,
    catch_up = true,
    action = function(pos, node)
      local inicial_pos = {x=pos.x, y=pos.y, z=pos.z}
		local nodedef = minetest.get_node(inicial_pos)
		local next_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		local next_node = minetest.get_node(next_pos)
		if minetest.get_item_group(next_node.name, "liquid") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		elseif minetest.get_item_group(next_node.name, "falling_node") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
      elseif minetest.get_item_group(next_node.name, "heavy_gas") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
      elseif minetest.get_item_group(next_node.name, "gas") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
      elseif minetest.get_item_group(next_node.name, "light_gas") > 0 then
			minetest.swap_node(next_pos, nodedef)
			minetest.swap_node(pos, next_node)
		else
			next_pos.y = pos.y+1
			next_node = minetest.get_node(next_pos)
			if next_node.name == "air" then
				minetest.swap_node(next_pos, nodedef)
				minetest.swap_node(pos, next_node)			
			else
				local dir = directions[math.random(1,4)]
				local next_pos = vector.add(pos, dir)
				local next_node = minetest.get_node(next_pos)
				if next_node.name == "air" or  minetest.get_item_group(next_node.name, "liquid") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            elseif next_node.name == "air" or  minetest.get_item_group(next_node.name, "heavy_gas") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, nodedef)
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, nodedef)
							minetest.swap_node(pos, next_node)
						end
					end
            end
			end
		end
	end,
})

local S = chemistry.getter

minetest.register_node("chemistry:oxygen", {
	description = S("Oxygen Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 10,
   damage_per_second = -1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:15"},
	wield_image = "oxygen_wl.png",
	inventory_image = "oxygen_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, light_gas=1, oxygen=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_node("chemistry:helium", {
	description = S("Helium Gas (EXPERIMENTAL)"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:25"},
	wield_image = "helium_wl.png",
	inventory_image = "helium_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, lighter_gas=1, inert = 1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_node("chemistry:nitrogen", {
	description = S("Nitrogen Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:15"},
	wield_image = "nitrogen_wl.png",
	inventory_image = "nitrogen_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_node("chemistry:hydrogen", {
	description = S("Hydrogen Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:15"},
	wield_image = "hydrogen_wl.png",
	inventory_image = "hydrogen_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, flammable_gas = 1, light_gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
})

minetest.register_node("chemistry:hydrogen_sulfide", {
	description = S("Hydrogen Sulfide Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 20,
   damage_per_second = 5,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:20"},
	wield_image = "hydrogen_sulfide_wl.png",
	inventory_image = "hydrogen_sulfide_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, flammable_gas = 1, gas=1, gaseous = 1, toxic = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
})

minetest.register_node("chemistry:carbon_dioxide", {
	description = S("Carbon Dioxide Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 22, g = 22, b = 22},
	tiles = {"incolored_gas.png^[opacity:30"},
	wield_image = "carbon_dioxide_wl.png",
	inventory_image = "carbon_dioxide_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, heavy_gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_node("chemistry:carbon_monoxide", {
	description = S("Carbon Monoxide Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 20,
   damage_per_second = 5,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:20"},
	wield_image = "carbon_monoxide_wl.png",
	inventory_image = "carbon_monoxide_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, flammable_gas = 1, gas=1, gaseous = 1, toxic=1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
})

minetest.register_node("chemistry:nitrogen_dioxide", {
	description = S("Nitrogen Dioxide Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 10,
   damage_per_second = 5,
	post_effect_color = {a = 80, r = 122, g = 88, b = 0},
	tiles = {"nitrogen_dioxide.png^[opacity:125"},
	wield_image = "nitrogen_dioxide_wl.png",
	inventory_image = "nitrogen_dioxide_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, heavy_gas=1, gaseous = 1, toxic=1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_node("chemistry:nitrogen_oxide", {
	description = S("Nitrogen Oxide Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 5,
   damage_per_second = 2.5,
	post_effect_color = {a = 80, r = 122, g = 88, b = 0},
	tiles = {"nitrogen_dioxide.png^[opacity:63"},
	wield_image = "nitrogen_oxide_wl.png",
	inventory_image = "nitrogen_oxide_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, heavy_gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "chemistry:nitrogen_oxide",
	recipe = "chemistry:nitrogen_dioxide"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "chemistry:nitrogen",
	recipe = "chemistry:nitrogen_oxide"
})

	minetest.register_abm({
		label = "chemistry:fire extinguish",
		nodenames = {"fire:basic_flame"}, -- flame will extinguish if there is not air or oxygen
		interval = 1.0,
		chance = 5,
		catch_up = true,
		action = function(pos, node)
			if not minetest.find_node_near(pos, 1, {"air", "chemistry:oxygen"}) then
				minetest.set_node(pos, {name="air"})
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:fire extinguish",
		nodenames = {"chemistry:anthracite_fire"}, -- flame will extinguish if there is not air or oxygen
		interval = 5.0,
		chance = 5,
		catch_up = true,
		action = function(pos, node)
			if not minetest.find_node_near(pos, 1, {"air", "chemistry:oxygen"}) then
				minetest.set_node(pos, {name="air"})
			end	
		end,
	})

local input_node = {name="chemistry:nitrogen"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen vaporation",
		nodenames = {"chemistry:lnitrogen", "chemistry:lnitrogen_flowing"}, -- liquid gases turn back into gases
		neighbors = {"air"},
		interval = 1.0,
		chance = 19,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.set_node(pos, input_node)
			end	
		end,
	})

local input_node = {name="chemistry:oxygen"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen vaporation",
		nodenames = {"chemistry:loxygen", "chemistry:loxygen_flowing"}, -- liquid gases turn back into gases
		neighbors = {"air"},
		interval = 1.0,
		chance = 19,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.set_node(pos, input_node)
			end	
		end,
	})

local output_node = {name="default:ice"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen freezing",
		nodenames = {"default:water_source", "default:water_flowing", "default:river_water_source", "default:river_water_flowing"}, -- liquid that turn into solids
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, output_node)
				minetest.sound_play(
					"freezing",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local output_node4 = {name="chemistry:dry_ice"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen freezing",
		nodenames = {"chemistry:carbon_dioxide"}, -- gases that go under inverse sublimation
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, output_node4)
				minetest.sound_play(
					"freezing",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local output_node4 = {name="default:ice"}
	minetest.register_abm({
		label = "chemistry:dry ice freezing",
		nodenames = {"default:water_source", "default:water_flowing"}, -- liquid that turn into solids
		neighbors = {"group:cools_water"},
		interval = 2.0,
		chance = 5,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, output_node4)
				minetest.sound_play(
					"freezing",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local output_node2 = {name="chemistry:cesium_block"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen freezing2",
		nodenames = {"chemistry:cesium"}, -- reactive liquids dont react to nitrogen but can be solidified
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, output_node2)
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local output_node2 = {name="chemistry:cesium_crystal"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen freezing2",
		nodenames = {"chemistry:cesium_flowing"}, -- reactive liquids dont react to nitrogen but can be solidified
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, output_node2)
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local output_node3 = {name="chemistry:gallium_block"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen freezing2",
		nodenames = {"chemistry:lgallium", "chemistry:lgallium_flowing"}, -- this also affects low melting point nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, output_node3)
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local input_node2 = {name="chemistry:nitrogen"}
	minetest.register_abm({
		label = "chemistry:liquid gases vaporation2",
		nodenames = {"group:freezer"}, -- hot liquids or plasma can make liquid gases to evaporate
		neighbors = {"group:torch", "group:igniter", "group:fire"},
		interval = 1.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, input_node2)
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

local output_node5 = {name="fire:basic_flame"}
minetest.register_abm({
		label = "gas ignition",
		nodenames = {"group:flammable_gas"}, -- checking for ignition sources
		neighbors = {"group:torch", "group:igniter", "group:fire"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.set_node(pos, output_node5)
			end	
		end,
	})

local output_node6 = {name="default:water_source"}
minetest.register_abm({
		label = "chemistry: water generation",
		nodenames = {"chemistry:hydrogen"}, -- when hydrogen combusts near oxygen it has a chance that it turns into water
		neighbors = {"group:oxygen"},
		interval = 1.0,
		chance = 50,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:fire") then
				minetest.set_node(pos, output_node6)
				if math.random() < 0.0001 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_abm({
		label = "chemistry:oxygen combustion",
		nodenames = {"group:flammable", "group:fuel", "chemistry:petroleum", "chemistry:petroleum_flowing"}, -- oxygen will not extinguish fire but rather intensify it
		neighbors = {"chemistry:oxygen", "chemistry:loxygen", "chemistry:loxygen_flowing"},
		interval = 1.0,
		chance = 3,
		catch_up = true,
		action = function(pos, node)
         local def = minetest.registered_nodes[node.name]
			if minetest.find_node_near(pos, 1, "group:igniter") then
			   if def.on_burn then
		   		def.on_burn(pos)
            else
				minetest.set_node(pos, {name="fire:basic_flame"})
            end
				if math.random() < 0.1 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_abm({
		label = "chemistry:oxygen combustion",
		nodenames = {"group:anthracite_material"}, -- Anthracite materials will combust and generate anthracite fire
		neighbors = {"chemistry:oxygen", "chemistry:loxygen", "chemistry:loxygen_flowing"},
		interval = 1.0,
		chance = 3,
		catch_up = true,
		action = function(pos, node)
         local def = minetest.registered_nodes[node.name]
			if minetest.find_node_near(pos, 1, "group:igniter") then
			   if def.on_burn then
		   		def.on_burn(p)
            else
				minetest.set_node(pos, {name="chemistry:anthracite_fire"})
            end
				if math.random() < 0.1 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_node("chemistry:methane", {
	description = S("Methane Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:15"},
	wield_image = "methane_wl.png",
	inventory_image = "methane_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, flammable_gas = 1, gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
})

local input_node = {name="chemistry:methane"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen condensation",
		nodenames = {"chemistry:lmethane_flowing", "chemistry:lmethane"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"air"},
		interval = 1.0,
		chance = 19,
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

minetest.register_node("chemistry:butane", {
	description = S("Butane Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:15"},
	wield_image = "butane_wl.png",
	inventory_image = "butane_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, flammable_gas = 1, gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
})

local input_node = {name="chemistry:butane"}
	minetest.register_abm({
		label = "chemistry:liquid nitrogen condensation",
		nodenames = {"chemistry:lbutane_flowing", "chemistry:lbutane"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"air"},
		interval = 1.0,
		chance = 19,
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
	label = "natural gas seep",
	nodenames = {"chemistry:gas_seep"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 3,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:butane"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"gas_hiss",
					{pos = pos, max_hear_distance = 8, gain = 0.05}
				)
			end
		end	
	end,
})
minetest.register_abm({
	label = "natural gas seep",
	nodenames = {"chemistry:gas_seep"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 3,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:methane"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"gas_hiss",
					{pos = pos, max_hear_distance = 8, gain = 0.05}
				)
			end
		end	
	end,
})

minetest.register_abm({
	label = "natural gas seep",
	nodenames = {"chemistry:strong_gas_seep"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 2,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:methane"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"gas_hiss",
					{pos = pos, max_hear_distance = 10, gain = 0.05}
				)
			end
		end	
	end,
})

minetest.register_abm({
	label = "natural gas seep",
	nodenames = {"chemistry:strong_gas_seep"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 2,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:butane"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"gas_hiss",
					{pos = pos, max_hear_distance = 10, gain = 0.05}
				)
			end
		end	
	end,
})

minetest.register_abm({
	label = "natural gas seep",
	nodenames = {"chemistry:sulfide_seep"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:hydrogen_sulfide"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"gas_hiss",
					{pos = pos, max_hear_distance = 8, gain = 0.05}
				)
			end
		end	
	end,
})
if chemistry.config.allow_explosive_nodes then
local chemical_boom = {
	name = "chemical_boom",
	--description = "explosion caused by chemical reactions",
	radius = 4,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}


if chemical_boom then
	minetest.register_abm({
		label = "alkali metals ignition",
		nodenames = {"chemistry:gas_seep", "chemistry:strong_gas_seep", "chemistry:sulfide_seep"}, 
		neighbors = {"group:igniter"},
		interval = 1.0,
		chance = 2,
		catch_up = true,
		action = function(pos, node)
			tnt.boom(pos, chemical_boom)
			if math.random() < 0.5 then
				minetest.set_node(pos, {name="fire:basic_flame"})
			end
		end,
	})
end

tnt.register_tnt(chemical_boom)
end

minetest.register_node("chemistry:lava", {
	description = S("Temporary Lava"),
	drawtype = "liquid",
	tiles = {
		{
			name = "default_lava_source_animated.png^[colorize:black:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "default_lava_source_animated.png^[colorize:black:100",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	paramtype = "light",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:lava_flowing",
	liquid_alternative_source = "chemistry:lava",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

minetest.register_node("chemistry:lava_flowing", {
	description = S("Flowing Temporary Lava"),
	drawtype = "flowingliquid",
	tiles = {"default_lava.png^[colorize:black:100"},
	special_tiles = {
		{
			name = "default_lava_flowing_animated.png^[colorize:black:100",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "default_lava_flowing_animated.png^[colorize:black:100",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:lava_flowing",
	liquid_alternative_source = "chemistry:lava",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
   liquid_range = 3,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:lava"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"air"},
		interval = 1.0,
		chance = 25,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.swap_node(pos, {name="default:stone"})
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:lava_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"air"},
		interval = 1.0,
		chance = 50,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.swap_node(pos, {name="default:stone"})
			end	
		end,
	})


	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:lava"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.swap_node(pos, {name="default:obsidian"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:lava_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:cools_lava"},
		interval = 1.0,
		chance = 7,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:cools_lava") then
				minetest.swap_node(pos, {name="default:stone"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})


	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:lava"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.swap_node(pos, {name="default:obsidian"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"chemistry:lava_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.swap_node(pos, {name="default:obsidian"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})


	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"default:lava_source"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.swap_node(pos, {name="default:obsidian"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

	minetest.register_abm({
		label = "chemistry:stone",
		nodenames = {"default:lava_flowing"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.swap_node(pos, {name="default:obsidian"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})


	minetest.register_abm({
		label = "chemistry:fire",
		nodenames = {"group:fire"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:freezer") then
				minetest.set_node(pos, {name="air"})
				minetest.sound_play(
					"default_cool_lava",
					{pos = pos, max_hear_distance = 18, gain = 0.05}
             )
			end	
		end,
	})

