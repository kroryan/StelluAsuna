-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local S = core.get_translator("potions_brewing")

local api = s_potions
local brewing = s_brewing

function s_brewing.alchemy_node_timer(pos, elapsed)
	
	local meta = core.get_meta(pos)
	local timer = core.get_node_timer(pos)
	
	local brew_time_left = meta:get_int("brew_time_left")
	
	local hash = core.hash_node_position(pos)
	
	-- Brewing sound
	if not brewing.sound_timers[hash] then brewing.sound_timers[hash] = 0 end
	
	if brewing.sound_timers[hash] == 0 then
		
		local sound_handle = core.sound_play("s_brewing_brew", { pos=pos, max_hear_distance=32, pitch=api.random_sound_pitch() })
		
		brewing.sound_handles[hash] = sound_handle
		brewing.sound_timers[hash] = 7
	end
	
	brewing.sound_timers[hash] = brewing.sound_timers[hash] - 1
	
	local brewing_sound_done = false
	
	local boost_count = math.min(meta:get_int("boost_count"), 4)
	local boost_value = 1 + boost_count*brewing.boost_value
	
	if pos.y < brewing.boost_min_y then
		boost_value = 0.5
	end
	
	::continue::
	
	local continue_brewing = false
	
	local brew_value = elapsed*boost_value
	
	-- Accounting for timer catching up
	if brew_time_left < brew_value then elapsed = elapsed - brew_time_left/boost_value
	else elapsed = 0 end
	
	brew_time_left = brew_time_left - brew_value
	meta:set_int("brew_time_left", brew_time_left)
	
	if brew_time_left > 0 then
		
		-- Continue brewing
		brewing.alchemy_stand_update_particles(pos, meta, hash, false)
		
		brewing.update_alchemy_formspec_for(pos, meta)
		
		return true
		
	else
		
		local recipe_index = meta:get_int("recipe_index")
		local result_name = recipe_index > 0 and s_potions.recipes[recipe_index].result
		
		if result_name ~= nil then
			
			-- Potion done
			local inv = meta:get_inventory()
				
			local src = inv:get_list("src")[1]
			local vial = inv:get_list("vial")[1]
			
			inv:remove_item("src", src:get_name())
			inv:remove_item("vial", vial:get_name())
			
			if inv:room_for_item("dst", result_name) then
				
				inv:add_item("dst", result_name)
				
			else
				
				local below = vector.new(pos.x, pos.y-1, pos.z)
				
				brewing.try_store_potion(below, result_name)
				
			end
			
			-- Sound effects
			if brewing_sound_done == false then
				
				core.sound_play("s_brewing_done", { pos=pos, max_hear_distance=32, pitch=api.random_sound_pitch() })
				
				brewing_sound_done = true
			end
			
			-- Check whether more potions can be done
			timer:stop()
			
			continue_brewing = brewing.alchemy_stand_update(pos)
			
		end
	end
	
	if elapsed > 0 and continue_brewing then
		
		brew_time_left = meta:get_int("brew_time_left")
		
		goto continue
	end
	
	return false
	
end
