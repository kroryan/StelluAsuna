local path = minetest.get_modpath(minetest.get_current_modname()) .. "/machines/register"

-- Recipes
dofile(path.."/alloy_recipes.lua")
dofile(path.."/grinder_recipes.lua")
dofile(path.."/centrifuge_recipes.lua")
dofile(path.."/freezer_recipes.lua")
dofile(path.."/electrolyser_recipes.lua")
dofile(path.."/ionizer_recipes.lua")
dofile(path.."/gas_freezer_recipes.lua")
dofile(path.."/compressor_recipes.lua")
dofile(path.."/blast_recipes.lua")

-- Machines
dofile(path.."/blast_furnace.lua")
dofile(path.."/ionizer.lua")
dofile(path.."/electrolyser.lua")
dofile(path.."/gas_freezer.lua")
