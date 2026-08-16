--[[

Telemosaic [telemosaic]
=======================

A mod which provides player-placed teleport pads

Copyright (C) 2015 Ben Deutsch <ben@bendeutsch.de>

]]

telemosaic = {
	teleport_delay = tonumber(minetest.settings:get("telemosaic_teleport_delay")) or 1.0,
	beacon_range = tonumber(minetest.settings:get("telemosaic_beacon_range")) or 20.0,
	default_channel = minetest.settings:get("telemosaic_default_channel") or "telemosaic",
	extender_ranges = {
		tonumber(minetest.settings:get("telemosaic_extender_one_range")) or 5.0,
		tonumber(minetest.settings:get("telemosaic_extender_two_range")) or 20.0,
		tonumber(minetest.settings:get("telemosaic_extender_three_range")) or 80.0,
	},
	extender_colors = {
		white = "#ffffffa0",
		dark_grey = "#00000090",
		black = "#000000e0",
		violet = "#400080b0",
		blue = "#0000ffb0",
		cyan = "#00ffffb0",
		dark_green = "#007000b0",
		green = "#00ff00b0",
		yellow = "#ffff00b0",
		brown = "#402000c0",
		orange = "#ff8000b0",
		red = "#ff0000b0",
		magenta = "#ff00ffb0",
		pink = "#ff8080b0",
	},
}

local MP = minetest.get_modpath("telemosaic")

if minetest.get_modpath("digilines") then
	dofile(MP.."/digilines.lua")
end

dofile(MP.."/functions.lua")
dofile(MP.."/beacon.lua")
dofile(MP.."/extender.lua")
dofile(MP.."/key.lua")
dofile(MP.."/abm.lua")
