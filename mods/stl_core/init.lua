stellua = {}

--Shut up VS code
table.insert_all = table.insert_all
table.indexof = table.indexof
math.round = math.round
table.copy = table.copy
math.hypot = math.hypot

--Got this from the old Luamap, it's very useful
function stellua.remap(val, min_val, max_val, min_map, max_map)
	return (val-min_val)/(max_val-min_val) * (max_map-min_map) + min_map
end

local modpath = minetest.get_modpath("stl_core").."/"
dofile(modpath.."sounds.lua")
dofile(modpath.."slots.lua")
dofile(modpath.."names.lua")
dofile(modpath.."trees.lua")
dofile(modpath.."nodes.lua")
dofile(modpath.."water.lua")
dofile(modpath.."liquids_compat.lua")
dofile(modpath.."mapgen.lua")
dofile(modpath.."sky.lua")
dofile(modpath.."crafts.lua")
dofile(modpath.."inventory.lua")
minetest.register_mapgen_script(modpath.."mapgen_env.lua")

local SPACE_ARMOR_GROUPS = {thumpy = 100, slicey = 100, zappy = 100}

-- Keep the space combat groups without replacing groups supplied by armor or
-- other gameplay mods. The original non-space values are restored on exit.
function stellua.set_space_armor(player, enabled)
	if not player or not player:is_player() then return end
	local meta = player:get_meta()
	local marker = meta:get_string("stl_core:space_armor")
	local groups = player:get_armor_groups()

	if enabled then
		if marker == "" then
			meta:set_string("stl_core:space_armor", minetest.serialize(groups))
		end
		for name, value in pairs(SPACE_ARMOR_GROUPS) do
			groups[name] = value
		end
		player:set_armor_groups(groups)
		return
	end

	if marker == "" then return end
	local saved = minetest.deserialize(marker) or {}
	for name in pairs(SPACE_ARMOR_GROUPS) do
		groups[name] = saved[name]
	end
	player:set_armor_groups(groups)
	meta:set_string("stl_core:space_armor", "")
end

--Store what minor version this was made in, so older worlds can be made incompatible
local VERSION = 4

local storage = minetest.get_mod_storage()
local world_version = storage:get_int("version")
assert(world_version == 0 or world_version == VERSION, "incompatible version (world 0."..world_version..", game 0."..VERSION..")")
storage:set_int("version", VERSION)

minetest.register_on_joinplayer(function(player)
	local in_space = player:get_pos().y >= (stellua.hybrid_space_min or 6368)
	stellua.set_space_armor(player, in_space)
	if not in_space then return end
	player:set_properties({use_texture_alpha=true})
end)

-- Keep respawn points created by assembled spacecraft, but do not override
-- Asuna's initial spawn selection.
function stellua.set_respawn(player, pos)
	player:get_meta():set_string("respawn", minetest.serialize(pos))
end

minetest.register_on_respawnplayer(function(player)
	local respawn = player:get_meta():get_string("respawn")
	if respawn == "" then return false end
	local pos = minetest.deserialize(respawn)
	if not pos then return false end
	player:set_pos(pos)
	return true
end)

-- Keep the engine/Asuna spawn untouched. A starter ship is only placed beside
-- the position selected by the engine after the player has joined.
local starter_ship_path = modpath .. "schems/starter_rocket.mts"
local starter_ship_key = "stl_core:starter_ship_placed"
local starter_ship_radius = 1
local starter_ship_height = 6

local function starter_ship_ground(node)
	if not node or node.name == "air" or node.name == "ignore" then return false end
	local def = minetest.registered_nodes[node.name]
	if not def or not def.walkable then return false end
	return minetest.get_item_group(node.name, "water") == 0
		and minetest.get_item_group(node.name, "lava") == 0
end

local function starter_ship_space(node)
	return node and node.name == "air"
end

local function starter_ship_base_is_clear(x, y, z)
	for dx = -starter_ship_radius, starter_ship_radius do
		for dz = -starter_ship_radius, starter_ship_radius do
			local ground = minetest.get_node_or_nil({x=x + dx, y=y, z=z + dz})
			if not starter_ship_ground(ground) then return false end
			for dy = 1, starter_ship_height - 1 do
				local node = minetest.get_node_or_nil({x=x + dx, y=y + dy, z=z + dz})
				if not starter_ship_space(node) then return false end
			end
		end
	end
	return true
end

local function find_starter_ship_base(player)
	local pos = player:get_pos()
	local px = math.floor(pos.x)
	local pz = math.floor(pos.z)
	local ground_y = math.floor(pos.y) - 1
	local offsets = {
		{x=6, z=0}, {x=-6, z=0}, {x=0, z=6}, {x=0, z=-6},
		{x=8, z=0}, {x=-8, z=0}, {x=0, z=8}, {x=0, z=-8},
	}

	for _, offset in ipairs(offsets) do
		local x = px + offset.x
		local z = pz + offset.z
		for dy = -6, 6 do
			local y = ground_y + dy
			if starter_ship_base_is_clear(x, y, z) then
				return {x=x, y=y, z=z}
			end
		end
	end
	return nil
end

local function place_starter_ship(player, attempt)
	if not player or not player:is_player() then return end
	local meta = player:get_meta()
	if meta:get_int(starter_ship_key) == 1 then return end
	if player:get_pos().y >= (stellua.hybrid_space_min or 6368) then return end

	local base = find_starter_ship_base(player)
	if not base then
		if attempt < 20 then
			minetest.after(0.5, function()
				place_starter_ship(player, attempt + 1)
			end)
		else
			minetest.log("error", "[stl_core] No clear ground for starter ship beside " .. player:get_player_name())
		end
		return
	end

	minetest.place_schematic(base, starter_ship_path, "0", {}, true, "place_center_x, place_center_z")
	local tank = minetest.registered_nodes["stl_vehicles:tank"]
	if tank and tank.on_construct then
		tank.on_construct(vector.add(base, {x=0, y=4, z=0}))
	end
	meta:set_string("stl_core:starter_ship_pos", minetest.serialize(base))
	meta:set_int(starter_ship_key, 1)
	if meta:get_int("stl_core:starter_ship_found") == 0 then
		meta:set_string("stl_core:ship_marker_mode", "starter")
	end
	minetest.log("action", "[stl_core] Placed starter ship beside " .. player:get_player_name() .. " at " .. minetest.pos_to_string(base))
end

minetest.register_on_joinplayer(function(player)
	minetest.after(1.5, function()
		place_starter_ship(player, 0)
	end)
end)

-- Safe, persistent first-ship waypoint. It is stored on the player, not as a
-- free-floating entity, so it cannot multiply or remain stuck after discovery.
local ship_waypoints = {}
local ship_waypoint_timer = 0

local function read_player_pos(meta, key)
	local raw = meta:get_string(key)
	if raw == "" then return nil end
	local pos = minetest.deserialize(raw)
	if type(pos) ~= "table" or type(pos.x) ~= "number"
	or type(pos.y) ~= "number" or type(pos.z) ~= "number" then
		return nil
	end
	return vector.new(pos)
end

local function remove_ship_waypoint(player)
	local name = player:get_player_name()
	local state = ship_waypoints[name]
	if state and state.hud then player:hud_remove(state.hud) end
	ship_waypoints[name] = nil
end

local function set_ship_waypoint(player, pos, label)
	if not pos then remove_ship_waypoint(player); return false end
	local name = player:get_player_name()
	local state = ship_waypoints[name]
	local key = minetest.pos_to_string(vector.round(pos))
	if state and state.key == key then return true end
	remove_ship_waypoint(player)
	local hud = player:hud_add({
		hud_elem_type = "waypoint", world_pos = vector.round(pos),
		name = label or "Ship", text = label or "Ship", number = 0xFF9A24,
		precision = 1,
	})
	if not hud then return false end
	ship_waypoints[name] = {hud = hud, key = key}
	return true
end

local function ship_marker_target(player)
	local meta = player:get_meta()
	local mode = meta:get_string("stl_core:ship_marker_mode")
	if mode == "current" then
		return read_player_pos(meta, "stl_core:current_ship_pos"), "Current ship"
	elseif mode == "starter" and meta:get_int("stl_core:starter_ship_found") == 0 then
		return read_player_pos(meta, "stl_core:starter_ship_pos"), "Starter ship"
	end
	return nil
end

local function update_ship_waypoint(player)
	if not player or not player:is_player() then return end
	local meta = player:get_meta()
	-- Older worlds may already have the starter ship but predate the stored
	-- position. Recover a nearby ship once instead of creating a second one.
	if meta:get_int(starter_ship_key) == 1
	and not read_player_pos(meta, "stl_core:starter_ship_pos") then
		local p = player:get_pos()
		local found = minetest.find_nodes_in_area(
			vector.subtract(p, 12), vector.add(p, 12), {"group:spaceship"})
		if found and found[1] then
			meta:set_string("stl_core:starter_ship_pos", minetest.serialize(vector.round(found[1])))
			if meta:get_int("stl_core:starter_ship_found") == 0 then
				meta:set_string("stl_core:ship_marker_mode", "starter")
			end
		end
	end
	local starter = read_player_pos(meta, "stl_core:starter_ship_pos")
	if starter and meta:get_int("stl_core:starter_ship_found") == 0
	and vector.distance(player:get_pos(), starter) <= 9 then
		meta:set_int("stl_core:starter_ship_found", 1)
		if meta:get_string("stl_core:ship_marker_mode") == "starter" then
			meta:set_string("stl_core:ship_marker_mode", "off")
			remove_ship_waypoint(player)
			minetest.chat_send_player(player:get_player_name(), "Starter ship found. Use Shift + right-click on a ship to inspect and assign it.")
		end
	end
	local pos, label = ship_marker_target(player)
	if pos then
		if meta:get_string("stl_core:ship_marker_mode") == "starter"
		and meta:get_int("stl_core:ship_tutorial_notice") == 0 then
			meta:set_int("stl_core:ship_tutorial_notice", 1)
			minetest.chat_send_player(player:get_player_name(),
				"Tutorial 1/5: Find your orange starter ship. Follow the waypoint; Shift + right-click opens its control panel. Use /ship_tutorial skip to skip this step.")
		end
		set_ship_waypoint(player, pos, label)
	else
		remove_ship_waypoint(player)
	end
end

minetest.register_globalstep(function(dtime)
	ship_waypoint_timer = ship_waypoint_timer + dtime
	if ship_waypoint_timer < 0.5 then return end
	ship_waypoint_timer = 0
	for _, player in ipairs(minetest.get_connected_players()) do update_ship_waypoint(player) end
end)

minetest.register_on_joinplayer(function(player)
	minetest.after(2.5, function()
		if player and player:is_player() then update_ship_waypoint(player) end
	end)
end)

minetest.register_on_leaveplayer(function(player)
	remove_ship_waypoint(player)
end)

minetest.register_chatcommand("ship_set_current", {
	description = "Assign the nearby or currently piloted ship as your current ship",
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		local target
		local attached = player:get_attach()
		if attached and attached:is_valid() then
			target = attached:get_pos()
		else
			local _, seat = stellua.assemble_vehicle(vector.round(player:get_pos()), true)
			target = seat
		end
		if not target then return false, "No complete ship found nearby" end
		local meta = player:get_meta()
		meta:set_string("stl_core:current_ship_pos", minetest.serialize(vector.round(target)))
		meta:set_string("stl_core:ship_marker_mode", "current")
		update_ship_waypoint(player)
		return true, "Current ship assigned. Use /ship_marker to show its waypoint."
	end,
})

minetest.register_chatcommand("ship_marker", {
	params = "[on|off|starter]",
	description = "Show or hide the waypoint for your current ship",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		local meta = player:get_meta()
		param = (param or "on"):lower():gsub("^%s+", ""):gsub("%s+$", "")
		if param == "off" then
			meta:set_string("stl_core:ship_marker_mode", "off")
			remove_ship_waypoint(player)
			return true, "Ship waypoint disabled."
		end
		if param == "starter" then
			if not read_player_pos(meta, "stl_core:starter_ship_pos") then return false, "Starter ship position is unknown" end
			meta:set_int("stl_core:starter_ship_found", 0)
			meta:set_string("stl_core:ship_marker_mode", "starter")
		else
			if not read_player_pos(meta, "stl_core:current_ship_pos") then return false, "No current ship assigned; use /ship_set_current first" end
			meta:set_string("stl_core:ship_marker_mode", "current")
		end
		update_ship_waypoint(player)
		return true, "Ship waypoint enabled."
	end,
})

minetest.register_chatcommand("ship_tutorial", {
	params = "skip",
	description = "Skip or reset the starter-ship tutorial",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		local meta = player:get_meta()
		param = (param or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
		if param == "skip" then
			meta:set_int("stl_core:starter_ship_found", 1)
			meta:set_int("stl_core:ship_tutorial_notice", 1)
			if meta:get_string("stl_core:ship_marker_mode") == "starter" then
				meta:set_string("stl_core:ship_marker_mode", "off")
			end
			update_ship_waypoint(player)
			return true, "Starter-ship tutorial skipped. You can use /ship_set_current and /ship_marker later."
		end
		return false, "Usage: /ship_tutorial skip"
	end,
})

minetest.register_on_mods_loaded(function()
	minetest.log("action", "[stl_core] Hybrid active: Asuna mapgen=" ..
		tostring(minetest.get_mapgen_setting("mg_name")) .. ", Stellua planets=" ..
		tostring(stellua.planet_count) .. ", space_min=" ..
		tostring(stellua.hybrid_space_min or 6368))

	if storage:get_int("planet_mapgen_selftest_v1") ~= 0 then return end
	local level = stellua.get_planet_level(1)
	local minp = {x=-8, y=level-160, z=-8}
	local maxp = {x=8, y=level+220, z=8}
	minetest.after(0, function()
		minetest.emerge_area(minp, maxp, function(_, _, remaining)
			if remaining ~= 0 then return end
			minetest.after(1, function()
				local names = {
					"stl_core:stone1", "stl_core:stone2", "stl_core:stone3", "stl_core:stone4",
					"stl_core:stone5", "stl_core:stone6", "stl_core:stone7", "stl_core:stone8",
					"stl_core:filler1", "stl_core:filler2", "stl_core:filler3", "stl_core:filler4",
					"stl_core:filler5", "stl_core:filler6", "stl_core:filler7", "stl_core:filler8",
				}
				local found = minetest.find_nodes_in_area(minp, maxp, names)
				if #found > 0 then
					storage:set_int("planet_mapgen_selftest_v1", 1)
					minetest.log("action", "[stl_core] SELFTEST PASS: planet 1 generated " .. #found .. " Stellua terrain nodes")
				else
					minetest.log("error", "[stl_core] SELFTEST FAIL: planet 1 produced no Stellua terrain")
				end
			end)
		end)
	end)
end)

minetest.register_chatcommand("space_status", {
	description = "Show the current hybrid realm, planet and orbital state",
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		local pos = player:get_pos()
		local planet = stellua.get_planet_index(pos.y)
		local slot = stellua.get_slot_index(pos)
		if planet then return true, "Stellua planet " .. planet .. ": " .. stellua.planets[planet].name end
		if slot then return true, "Stellua orbit slot " .. slot end
		return true, "Asuna homeworld"
	end,
})

minetest.register_chatcommand("space_test", {
	description = "Teleport to the hybrid orbital layer for testing",
	privs = {teleport=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		player:set_pos({x=0, y=6500, z=0})
		return true, "Teleported to test orbit"
	end,
})

minetest.register_chatcommand("asuna_home", {
	description = "Return to the Asuna homeworld test altitude",
	privs = {teleport=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		player:set_pos({x=0, y=200, z=0})
		return true, "Returning to Asuna"
	end,
})

--A few useful commands
minetest.register_chatcommand("planet", {
    params = "",
    description = "Get info about the current planet",
    privs = {debug=true},
    func = function (playername)
        local index = stellua.get_planet_index(minetest.get_player_by_name(playername):get_pos().y)
        if not index then return false, "Not currently in a planet" end
        local planet = stellua.planets[index]
        return true, "Name: "..planet.name.."\nSeed: "..planet.seed.."   Scale: "..planet.scale.."\nHeat: "..planet.heat_stat.."K\nAtmosphere: "..planet.atmo_stat.."atm\n"..(planet.water_level and planet.water_name.." Level: "..(planet.water_level-planet.level) or "No surface liquid").."\nLife: "..planet.life_stat.."   Dist: "..(math.round(planet.dist*1000)*0.001).."AU"
    end
})

minetest.register_chatcommand("star", {
    params = "",
    description = "Get info about the current star system",
    privs = {debug=true},
    func = function (playername)
        local index = stellua.get_planet_index(minetest.get_player_by_name(playername):get_pos().y)
        if not index then return false, "Not currently in a planet" end
        local star = stellua.stars[stellua.planets[index].star]
        return true, "Name: "..star.name.."\nSeed: "..star.seed.."\nScale: "..star.scale.."\nPlanets: "..#star.planets.."\nPosition: ("..star.pos.x..", "..star.pos.y..", "..star.pos.z..")"
    end
})
