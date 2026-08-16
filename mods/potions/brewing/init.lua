-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details
 
local path = core.get_modpath("potions_brewing")

s_brewing = {
	
	brew_time = 180.0,
	
	boost_search_radius = {x=2,y=1,z=2},
	boost_value = 0.5,
	boost_max_count = 4,
	boost_min_y = -10,
	
	explosion_chance = 0.25,
	
	storage_nodes = {},
	
	sound_handles = {},
	sound_timers = {},
	particle_handles = {},
	formspec_viewers = {},
	
}

dofile(path .. "/formspec.lua")
dofile(path .. "/api.lua")
dofile(path .. "/timers.lua")
dofile(path .. "/nodes.lua")
dofile(path .. "/crafting.lua")
dofile(path .. "/vessels_shelf.lua")
