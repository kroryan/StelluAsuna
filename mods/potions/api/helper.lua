-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local api = s_potions

function s_potions.get_player_effect(playername, effect_name)
	
	local effects = playereffects.get_player_effects(playername)
	
	for i=1, #effects do
		if effects[i].effect_type_id == effect_name then
			return effects[i]
		end
	end
	
	return nil
end

function s_potions.is_inside_node_group(obj, group)
	
	local collisionbox = obj:get_properties().collisionbox
	local dy_above = (collisionbox and collisionbox[5]) or 1
	local dy_below = (collisionbox and collisionbox[2]) or -1
	
	local pos = obj:get_pos()
	local pos_above = vector.add(pos, {x=0, y=dy_above-0.1, z=0})
	local pos_below = vector.add(pos, {x=0, y=dy_below+0.1, z=0})
	
	for index, p in next, { pos_above, pos_below } do
		
		local node = core.get_node(p)
		local def = core.registered_nodes[node.name]
		
		if def and def.groups[group] then return true end
	end
	
	return false
end

function s_potions.is_standing_on_walkable(obj)
	
	local collisionbox = obj:get_properties().collisionbox
	local dy = (collisionbox and collisionbox[2]) or -1
	
	local pos = vector.add(obj:get_pos(), {x=0, y=dy-0.1, z=0})
	local node = core.get_node(pos)
	local def = core.registered_nodes[node.name]
	
	if def and def.walkable then return true end
	
	return false
end

function s_potions.change_armor_group(obj, group, value)
	
	local armor_groups = obj:get_armor_groups()
	
	armor_groups[group] = value
	
	obj:set_armor_groups(armor_groups)
end

function s_potions.set_physics_factors(obj, name, physics)
	
	local id = "potions_api:" .. name
	
	for attribute, value in next, physics do
		playerphysics.add_physics_factor(obj, attribute, id, value)
	end
end

function s_potions.reset_physics_factors(obj, name, physics)
	
	local id = "potions_api:" .. name
	
	for index, attribute in next, physics do
		playerphysics.remove_physics_factor(obj, attribute, id)
	end
end

function s_potions.speed_effect(user, name, ground_speed, liquid_speed, air_speed, climb_ledges, allow_sneak, fast_climb, acceleration_fast_reset)
	
	ground_speed = ground_speed or 1
	liquid_speed = liquid_speed or 1
	
	local effect_name = "potions_api:" .. name
	
	local speed = playerphysics.get_physics_factor(user, "speed", effect_name) or math.min(ground_speed, liquid_speed)
	local acceleration = playerphysics.get_physics_factor(user, "acceleration_default", effect_name) or 1/speed
	
	if api.is_inside_node_group(user, "liquid") then
		
		speed = liquid_speed
		acceleration = 1
		
	elseif api.is_standing_on_walkable(user) then
		
		speed = ground_speed
		acceleration = 1
		
	elseif air_speed then
		
		speed = air_speed
		acceleration = 1
		
	elseif acceleration_fast_reset then
		
		acceleration = 1/speed
	else
		acceleration = math.max(acceleration - 0.1, 1/speed)
	end
	
	local speed_crouch = allow_sneak and 1 or speed
	local speed_climb = fast_climb and 1 or 1/speed
	
	local physics = {speed=speed, speed_crouch=speed_crouch, speed_climb=speed_climb, acceleration_default=acceleration, acceleration_air=acceleration}
	
	local meta = user:get_meta()
	
	if meta:get_string("s_potions_stepheight") == "" then
		
		meta:set_string("s_potions_stepheight", user:get_properties().stepheight)
	end
	
	api.set_physics_factors(user, name, physics)
	if allow_sneak ~= true then user:set_physics_override({sneak=false}) end
	if climb_ledges ~= false then user:set_properties({stepheight=1.5}) end
end

function s_potions.speed_effect_end(user, name)
	
	local meta = user:get_meta()
	local stepheight_string = meta:get_string("s_potions_stepheight")
	local stepheight = tonumber(stepheight_string ~= "" and stepheight_string or "0")
	
	api.reset_physics_factors(user, name, {"speed", "speed_crouch", "speed_climb", "acceleration_default", "acceleration_air"})
	user:set_physics_override({sneak=true})
	user:set_properties({stepheight=stepheight})
	
	meta:set_string("s_potions_stepheight", "")
	
end
