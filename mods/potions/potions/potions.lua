-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local S = core.get_translator("potions_default")

local api = s_potions

api.register_potion({
	
	name = "potions_default:stock",
	desc = S("Potion Stock"),
	background = "default_tin_block.png",
	ingredient = "default:tin_ingot",
	vial = "vessels:glass_bottle",
	duration = 0.0,
	
})

local function register_potion(def)
	
	def.name = "potions_default:" .. def.name
	
	if def.vial then def.vial = "potions_default:" .. def.vial
	else def.vial = "potions_default:stock" end
	
	api.register_potion(def)
	
end

register_potion({
	
	name = "water_breathing",
	desc = S("Water-Breathing Potion"),
	effect_desc = S("Water-Breathing"),
	background = "default_copper_block.png",
	ingredient = "default:copper_ingot",
	effect_start = function(user)
		
		user:set_flags({
			breathing = false,
			drowning = false,
		})
	end,
	effect = function(user)
		
		user:set_breath(9)
		user:set_breath(10)
	end,
	effect_end = function(effect, user)
		
		user:set_flags({
			breathing = true,
			drowning = true,
		})
	end,
	repeat_interval = 0.2
	
})

local swim_speed = 3

register_potion({
	
	mese_enhanced = true,
	name = "swim",
	desc = S("Swimming Potion"),
	effect_desc = S("Fish"),
	background = "default_copper_block.png",
	vial = "water_breathing",
	duration = 90.0,
	effect_start = function(user)
		
		user:set_flags({
			breathing = false,
			drowning = false,
		})
	end,
	effect = function(user)
		
		user:set_breath(9)
		user:set_breath(10)
		
		api.speed_effect(user, "swim", 1, swim_speed, nil, false, false, false, true)
		
		api.set_physics_factors(user, "swim", {liquid_fluidity=math.huge, liquid_sink=0})
		
	end,
	effect_end = function(effect, user)
		
		user:set_flags({
			breathing = true,
			drowning = true,
		})
		
		api.speed_effect_end(user, "swim")
		
		api.reset_physics_factors(user, "swim", {"speed", "liquid_fluidity", "liquid_sink"})
	end,
	repeat_interval = 0.1
	
})

register_potion({
	
	name = "invulnerability",
	desc = S("Invulnerability Potion"),
	effect_desc = S("Invulnerable"),
	background = "default_snow.png",
	ingredient = "default:steel_ingot",
	duration = 0.5,
	effect = function(user) api.change_armor_group(user, "immortal", 1) end,
	effect_end = function(effect, user) api.change_armor_group(user, "immortal", 0) end
	
})

register_potion({
	
	mese_enhanced = true,
	name = "immortality",
	desc = S("Immortality Potion"),
	effect_desc = S("Immortal"),
	background = "default_snow.png",
	vial = "invulnerability",
	duration = 5.0,
	effect = function(user) api.change_armor_group(user, "immortal", 1) end,
	effect_end = function(effect, user) api.change_armor_group(user, "immortal", 0) end
	
})

register_potion({
	
	name = "jump",
	desc = S("Leap Potion"),
	effect_desc = S("Leap"),
	background = "default_gold_block.png",
	ingredient = "default:gold_ingot",
	effect = function(user) api.set_physics_factors(user, "jump", {jump=2}) end,
	effect_end = function(effect, user) api.reset_physics_factors(user, "jump", {"jump"}) end,
	repeat_interval = 0.2
	
})

local agility_speed = 2

register_potion({
	
	mese_enhanced = true,
	name = "agility",
	desc = S("Agility Potion"),
	effect_desc = S("Agility"),
	background = "default_gold_block.png",
	vial = "jump",
	effect = function(user)
		
		api.speed_effect(user, "agility", agility_speed, 1, agility_speed, true, true, true)
		
		api.set_physics_factors(user, "agility", {jump=2})
		api.change_armor_group(user, "fall_damage_add_percent", -30)
	end,
	effect_end = function(effect, user)
		
		api.speed_effect_end(user, "agility")
		
		api.reset_physics_factors(user, "agility", {"jump"})
		api.change_armor_group(user, "fall_damage_add_percent", 0)
	end,
	repeat_interval = 0.2
	
})

register_potion({
	
	name = "gravity",
	desc = S("Weightlessness Potion"),
	effect_desc = S("Weightless"),
	background = "default_obsidian_block.png",
	ingredient = "default:obsidian_glass",
	effect = function(user)
		
		api.set_physics_factors(user, "gravity", {gravity=0, jump=0.5})
		api.change_armor_group(user, "fall_damage_add_percent", -100)
	end,
	effect_end = function(effect, user)
		
		api.reset_physics_factors(user, "gravity", {"gravity", "jump"})
		api.change_armor_group(user, "fall_damage_add_percent", 0)
	end
	
})

register_potion({
	
	mese_enhanced = true,
	name = "flight",
	desc = S("Flight Potion").."\n"..S("Use with 'Toggle fly' key"),
	effect_desc = S("Flight"),
	background = "default_obsidian_block.png",
	vial = "gravity",
	effect = function(user)
		
		local name = user:get_player_name()
		local privs = core.get_player_privs(name)
		privs.fly = true
		
		core.set_player_privs(name, privs)
	end,
	effect_end = function(effect, user)
		
		local name = user:get_player_name()
		local privs = core.get_player_privs(name)
		privs.fly = nil
		
		core.set_player_privs(name, privs)
	end
	
})

local haste_speed = 4

register_potion({
	
	name = "speed",
	desc = S("Haste Potion"),
	effect_desc = S("Haste"),
	background = "default_diamond_block.png",
	ingredient = "default:diamond",
	effect = function(user)
		
		api.speed_effect(user, "haste", haste_speed)
	end,
	effect_end = function(effect, user)
		
		api.speed_effect_end(user, "haste")
	end,
	repeat_interval = 0.1
	
})

local supersonic_speed = 16

register_potion({
	
	mese_enhanced = true,
	name = "extreme_speed",
	desc = S("Supersonic Potion"),
	effect_desc = S("Supersonic"),
	background = "default_diamond_block.png",
	vial = "speed",
	effect = function(user)
		
		api.speed_effect(user, "extreme_speed", supersonic_speed)
	end,
	effect_end = function(effect, user)
		
		api.speed_effect_end(user, "extreme_speed")
	end,
	repeat_interval = 0.1
	
})
