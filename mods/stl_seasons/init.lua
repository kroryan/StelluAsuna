local SEASON_NAMES = {"spring", "summer", "autumn", "winter"}
local season_days = tonumber(minetest.settings:get("stl_season_days")) or 8
season_days = math.max(season_days, 1)

function stellua.get_season()
	local day = minetest.get_day_count()
	local index = math.floor(day / season_days) % #SEASON_NAMES + 1
	return SEASON_NAMES[index], index, (day % season_days) / season_days
end

function stellua.get_season_temperature_modifier()
	local _, index = stellua.get_season()
	return ({0, 10, -2, -18})[index]
end

minetest.register_chatcommand("season", {
	params = "",
	description = "Show the current season",
	func = function()
		local season, _, phase = stellua.get_season()
		return true, ("Season: %s (%d%%)"):format(season, math.floor(phase * 100))
	end,
})

local frozen_water = {
	["default:water_source"] = {river = false},
	["default:water_flowing"] = {river = false},
	["default:river_water_source"] = {river = true},
	["default:river_water_flowing"] = {river = true},
}

local function open_to_sky(pos)
	local node = minetest.get_node_or_nil(vector.offset(pos, 0, 1, 0))
	return node and node.name == "air"
end

minetest.register_abm({
	label = "Stellua winter water freeze",
	nodenames = {"group:water"},
	neighbors = {"air"},
	interval = 15,
	chance = 4,
	catch_up = false,
	action = function(pos, node)
		if pos.y >= (stellua.hybrid_space_min or 6368) then return end
		if stellua.get_season() ~= "winter" or not open_to_sky(pos) then return end
		local def = frozen_water[node.name]
		if not def then return end
		minetest.swap_node(pos, {name = "default:ice"})
		local meta = minetest.get_meta(pos)
		meta:set_int("stl_seasons:seasonal_ice", 1)
		meta:set_int("stl_seasons:river", def.river and 1 or 0)
	end,
})

minetest.register_abm({
	label = "Stellua seasonal ice melt",
	nodenames = {"default:ice"},
	interval = 15,
	chance = 4,
	catch_up = false,
	action = function(pos)
		if stellua.get_season() == "winter" then return end
		local meta = minetest.get_meta(pos)
		if meta:get_int("stl_seasons:seasonal_ice") ~= 1 then return end
		if (minetest.get_node_light(pos) or 0) < 11 then return end
		local water = meta:get_int("stl_seasons:river") == 1
		minetest.swap_node(pos, {name = water and "default:river_water_source" or "default:water_source"})
		meta:set_int("stl_seasons:seasonal_ice", 0)
		meta:set_int("stl_seasons:river", 0)
	end,
})
