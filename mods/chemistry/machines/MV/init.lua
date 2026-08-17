local path = minetest.get_modpath(minetest.get_current_modname()) .. "/machines/MV"

-- Machines
dofile(path.."/ionizer.lua")
dofile(path.."/electrolyser.lua")
dofile(path.."/gas_freezer.lua")