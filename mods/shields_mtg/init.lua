-- init.lua
local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

-- Cargar la definición del escudo
dofile(modpath .. "/shield.lua")
