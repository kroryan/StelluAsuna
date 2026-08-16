-- Minetest 5.3 mod: too many stones
-- See README.txt for licensing and other information.

-- Definitions made by this mod that other mods can use too
too_many_stones = {}

local S = minetest.get_translator("too_many_stones")

-- Mod support
too_many_stones.mods = (function()
	local mods = {}
	for _,mod in ipairs({
		"default",
		"everness",
		"naturalbiomes",
		"dorwinion",
		"asuna_core",
		"base_earth",
	}) do
		mods[mod] = minetest.get_modpath(mod) ~= nil
	end
	return mods
end)()

-- Load files
local tms_path = minetest.get_modpath("too_many_stones")

dofile(tms_path .. "/sounds.lua")
dofile(tms_path .. "/nodes.lua")
dofile(tms_path .. "/crafting.lua")
dofile(tms_path .. "/mapgen.lua")
dofile(tms_path .. "/wall.lua")
dofile(tms_path .. "/stairs.lua")
dofile(tms_path .. "/geodes.lua")
dofile(tms_path .. "/geodes_lib.lua")
dofile(tms_path .. "/nodes_glowing.lua")
dofile(tms_path .. "/nodes_crystal.lua")
--dofile(tms_path .. "/flowstones.lua")
