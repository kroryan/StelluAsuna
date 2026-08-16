-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details
 
local path = core.get_modpath("potions_api")

s_potions = {
	
	item_is_ingredient = {},
	item_is_vial = {},
	recipes = {},
	
	potion_backgrounds = {},
	
	potion_default_duration = 30.0,
	
	random_sound_pitch = function() return 1+math.random(-1,1)*0.05 end
	
}

dofile(path .. "/helper.lua")
dofile(path .. "/api.lua")
