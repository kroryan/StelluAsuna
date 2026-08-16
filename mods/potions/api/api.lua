-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local vessels_enabled = (core.get_modpath("vessels") ~= nil)

local function remove_particle_spawner_from_player(player)
	
	local meta = player:get_meta()
	local particle_spawner = meta:get_int("potions_api:particle_spawner")
	if particle_spawner then core.delete_particlespawner(particle_spawner) end
end

function s_potions.add_particle_spawner(particle_background, duration, object, pos)
	
	if pos == nil then pos = vector.new(0, 0, 0) end
	
	local spawner_def = {
		
		amount = 8 * duration,
		time = duration,
		attached = object,
		texture = "(" .. particle_background .. ")^[mask:s_potions_bubble.png",
		glow = 4,
		
		minsize = 4,
		maxsize = 4,
		
		pos = pos,
		radius = 0.25,
		acc = vector.new(0, 0.5, 0),
		drag = vector.new(0.5, 0, 0.5),
		attract = {kind="point", die_on_contact=false, origin_attached=object, origin=pos, strength=-2.5}
		
	}
	
	if (duration <= 1.0) then
		
		spawner_def["amount"] = 64 * duration
		
	end
	
	if object == nil then
		
		spawner_def["pos"] = pos
		spawner_def["attract"]["origin"] = pos
		
	end
	
	local particle_spawner = core.add_particlespawner(spawner_def)
	
	if object and object:is_player() then
		
		remove_particle_spawner_from_player(object)
		
		local meta = object:get_meta()
		meta:set_int("potions_api:particle_spawner", particle_spawner)
		
	end
	
	return particle_spawner
	
end

function s_potions.register_potion(def)
	
	-- Default values
	if not def.vial and vessels_enabled then def.vial = "vessels:glass_bottle" end
	if not def.duration then def.duration = s_potions.potion_default_duration end
	
	-- Potion texture
	if not def.image then
	
		local background = def.background
		
		s_potions.potion_backgrounds[def.name] = background
		
		if def.mese_enhanced then
			def.overlay = "s_potions_mese_dust.png"
			def.ingredient = "default:mese_crystal"
		end
		
		if def.overlay then background = background .. "^" .. def.overlay end
		
		def.image = "(" .. background .. "^[mask:s_potions_background.png)^s_potions_overlay.png"
		
	end
	
	-- Potion recipe
	item_groups = { s_potions = 1, potion = 1, vessel = 1 }
	
	if def.ingredient then
		
		item_groups.not_in_craft_guide = 1
		
		s_potions.item_is_ingredient[def.ingredient] = true
		s_potions.item_is_vial[def.vial] = true
		
		table.insert(s_potions.recipes, {
			
			brew_time = def.brew_time or nil,
			ingredient = def.ingredient,
			vial = def.vial,
			result = def.name
			
		})
	end
	
	-- Registering item
	core.register_craftitem(def.name,
	{
		description = def.desc,
		inventory_image = def.image,
		stack_max = 8,
		groups = item_groups,
		on_use = function(itemstack, user, pointed_thing)
			
			itemstack:take_item()
			
			core.sound_play("s_potions_drink", { object=user, gain=0.45, max_hear_distance=10, pitch=s_potions.random_sound_pitch() })
			
			playereffects.cancel_effect_group("s_potions", user:get_player_name())
			
			if def.effect then
				
				playereffects.apply_effect_type(def.name, def.duration, user)
				
			end
			
			if def.duration > 0 then
				
				s_potions.add_particle_spawner(def.background, def.duration, user, vector.new(0, 1, 0))
				
			end
			
			return itemstack
			
		end
	})
	
	-- Registering playereffects effect
	if def.effect then
		
		local effect_name = def.name
		local effect_desc = def.effect_desc or def.desc
		local effect_texture = "" .. def.image .. "^[resize:48x48"
		local effect_groups = {"s_potions"}
		
		if not def.repeat_interval or def.use_regular_repeat_interval then
			
			-- Regular effect
			playereffects.register_effect_type(
				
				effect_name, effect_desc,
				effect_texture, effect_groups,
				function(user)
					
					def.effect(user)
					
				end,
				function(effect, user)
					
					if def.effect_end then def.effect_end(effect, user) end
					
					remove_particle_spawner_from_player(user)
					
				end,
				nil, nil,
				def.repeat_interval or nil
			)
			
		else
			
			-- Effect with custom repeat interval
			playereffects.register_effect_type(
				
				effect_name, effect_desc,
				effect_texture, effect_groups,
				function(user)
					
					if def.effect_start then def.effect_start(user) end
					
					def.effect(user)
					
					local playername = user:get_player_name()
					
					function repeat_effect()
						
						if playereffects.has_effect_type(playername, def.name) then
							
							def.effect(user)
							
							core.after(def.repeat_interval, repeat_effect)
						end
					end
					
					core.after(def.repeat_interval, repeat_effect)
					
				end,
				function(effect, user)
					
					if def.effect_end then def.effect_end(effect, user) end
					
					remove_particle_spawner_from_player(user)
					
				end
			)
			
		end
	end
	
end
