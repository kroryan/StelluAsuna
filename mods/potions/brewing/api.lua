-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local brewing = s_brewing

function s_brewing.get_available_storage(pos)
		
	local node = core.get_node(pos)
	
	if brewing.storage_nodes[node.name] then
		
		local vessels_inv = core.get_meta(pos):get_inventory()
		
		if vessels_inv:room_for_item(brewing.storage_nodes[node.name].inventory_list, "vessels:glass_bottle") then
			
			return vessels_inv
		end
	end
	
	return nil
	
end

function s_brewing.try_store_potion(pos, potion)
	
	local node = core.get_node(pos)
	
	local vessels_inv = brewing.get_available_storage(pos)
	
	if vessels_inv then
		
		vessels_inv:add_item(brewing.storage_nodes[node.name].inventory_list, potion)
		
		brewing.storage_nodes[node.name].update(pos)
	end
	
end

function s_brewing.add_to_value_in_nearby_stands(pos, value_name, value_add)
	
	local pos1 = vector.add(pos, brewing.boost_search_radius)
	local pos2 = vector.subtract(pos, brewing.boost_search_radius)
	local list = core.find_nodes_in_area(pos1, pos2, {"potions_brewing:stand"})
	
	for index, pos3 in next, list do
	
		local meta = core.get_meta(pos3)
		local value = meta:get_int(value_name)
		
		value = value + value_add
		
		meta:set_int(value_name, value)
		
		s_brewing.alchemy_stand_update(pos3)
		
	end
	
end

function s_brewing.alchemy_stand_update_particles(pos, meta, hash, reset)
	
	if not meta then meta = core.get_meta(pos) end
	if not hash then hash = core.hash_node_position(pos) end
	
	local particle_spawner = brewing.particle_handles[hash]
	
	if particle_spawner then
		
		if reset then
			
			core.delete_particlespawner(particle_spawner)
			
			brewing.particle_handles[hash] = nil
		else
			return
		end
	end
	
	local recipe_index = meta:get_int("recipe_index")
	
	if recipe_index > 0 then
		
		local brew_result = s_potions.recipes[recipe_index] and s_potions.recipes[recipe_index].result
		local texture = brew_result and s_potions.potion_backgrounds[brew_result] or "default_tin_block.png"
		
		brewing.particle_handles[hash] = s_potions.add_particle_spawner(texture, brewing.brew_time, nil, pos)
	end
	
end

function s_brewing.alchemy_stand_get_recipe_index(pos)
	
	local meta = core.get_meta(pos)
	
	if meta:get_int("table_count") > 1 then
		
		return 0
	end
	
	local inv = meta:get_inventory()
	
	local src = inv:get_list("src")[1]
	local vial = inv:get_list("vial")[1]
	
	local can_brew = false
	
	if (src:is_empty() == false and vial:is_empty() == false) then
		
		local src_name = src:get_name()
		local vial_name = vial:get_name()
		
		if (s_potions.item_is_ingredient[src_name] and s_potions.item_is_vial[vial_name]) then
			
			for i, recipe in next, s_potions.recipes do
				
				if (recipe.ingredient == src_name and recipe.vial == vial_name) then
					
					local below = vector.new(pos.x, pos.y-1, pos.z)
					
					if inv:room_for_item("dst", recipe.result) or brewing.get_available_storage(below) then
						
						return i
						
					end
				end
			end
		end
		
	end
	
	return 0
	
end

function s_brewing.alchemy_stand_update(pos)
	
	local meta = core.get_meta(pos)
	local timer = core.get_node_timer(pos)
	local boost_count = math.min(meta:get_int("boost_count"), 4)
	
	local recipe_index = brewing.alchemy_stand_get_recipe_index(pos)
	
	if recipe_index > 0 then
		
		if timer:is_started() == false or meta:get_int("recipe_index") ~= recipe_index then
			
			-- Start brewing
			timer:start(1.0)
			
			meta:set_int("recipe_index", recipe_index)
			meta:set_int("brew_time_left", s_potions.recipes[recipe_index].brew_time or brewing.brew_time)
			
			local hash = core.hash_node_position(pos)
			
			brewing.update_alchemy_formspec_for(pos, meta, hash)
			
			brewing.sound_timers[hash] = 0
			
			-- Reset particle spawner
			brewing.alchemy_stand_update_particles(pos, meta, nil, true)
			
			return true
			
		end
		
	else
		timer:stop()
	end
	
	if recipe_index == 0 and meta:get_int("recipe_index") > 0 then
		
		-- Stop brewing
		meta:set_int("recipe_index", 0)
		meta:set_int("brew_time_left", brewing.brew_time)
		
		local hash = core.hash_node_position(pos)
		
		brewing.update_alchemy_formspec_for(pos, meta, hash)
		
		-- Sound effects
		if (brewing.sound_handles[hash]) then
			
			core.sound_fade(brewing.sound_handles[hash], 1, 0)
			
			brewing.sound_handles[hash] = nil
			brewing.sound_timers[hash] = nil
		end
		
		-- Remove particle spawner
		brewing.alchemy_stand_update_particles(pos, meta, hash, true)
		
	end
	
	return false
	
end
