
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/machines/"

dofile(path.."register/init.lua")
dofile(path.."other/init.lua")
dofile(path.."MV/init.lua")
dofile(path.."HV/init.lua")
