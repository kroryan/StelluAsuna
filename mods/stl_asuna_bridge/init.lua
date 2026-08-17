local SPACE_MIN = stellua.hybrid_space_min or 6368
local was_in_space = {}
local timer = 0
-- get_mod_storage() depends on the current mod context, which is available
-- while this file is loaded but not later inside on_mods_loaded callbacks.
local storage = minetest.get_mod_storage()
local arrival_in_progress = false

-- StelluAsuna starts on the Asuna homeworld, but keeps Stellua's original
-- arrival fantasy: new players wake up inside a landed starter spacecraft.
local function put_player_in_arrival_ship(player, base)
	if not player or not player:is_player() then return end
	local inside = vector.add(base, {x=0, y=1.5, z=0})
	player:set_pos(inside)
	stellua.set_respawn(player, vector.add(base, {x=0, y=1, z=0}))
	player:get_meta():set_int("stelluasuna_arrived", 1)
	
	-- Do not restore gravity immediately! The client needs time to download the ship's chunks.
	-- If we restore gravity now, the client will fall through the floor before seeing it.
	minetest.after(3.5, function()
		if player and player:is_player() then
			-- Snap them back to the exact position inside the ship just in case they sank a bit
			player:set_pos(inside)
			player:set_physics_override({speed=1, jump=1, gravity=1})
			minetest.chat_send_player(player:get_player_name(), "Arrival sequence complete. Welcome to StelluAsuna!")
		end
	end)
end

local function spawn_player_ship(player)
	if not player or not player:is_player() then return end
	if player:get_meta():get_int("stelluasuna_arrived") == 1 then return end
	
	local name = player:get_player_name()
	local offset_x = math.random(-150, 150)
	local offset_z = math.random(-150, 150)
	
	-- Suspend player in the sky so they don't fall or die while we load
	player:set_physics_override({speed=0, jump=0, gravity=0})
	player:set_pos({x=0, y=1000, z=0})
	
	minetest.show_formspec(name, "stl_asuna_bridge:loading", 
		"size[10,10,true]" ..
		"bgcolor[#000000;true]" ..
		"label[3.5,4.5;< Welcome to StelluAsuna >]" ..
		"label[3,5.5;Preparing your arrival craft...]"
	)
	
	local pmin = {x = offset_x - 16, y = 6480, z = offset_z - 16}
	local pmax = {x = offset_x + 16, y = 6520, z = offset_z + 16}
	
	minetest.emerge_area(pmin, pmax,
		function(_, _, remaining)
			if remaining ~= 0 then return end
			minetest.after(2, function()
				local p = minetest.get_player_by_name(name)
				if not p then return end
				
				-- Put the ship floating in space (orbit) as requested
				local base = {x=offset_x, y=6500, z=offset_z}
				
				minetest.place_schematic(base,
					minetest.get_modpath("stl_core").."/schems/starter_rocket.mts",
					"0", {}, true, "place_center_x, place_center_z")
				local tank = minetest.registered_nodes["stl_vehicles:tank"]
				if tank and tank.on_construct then
					tank.on_construct(vector.add(base, {x=0, y=4, z=0}))
				end
				
				put_player_in_arrival_ship(p, base)
				minetest.close_formspec(name, "stl_asuna_bridge:loading")
				minetest.log("action", "[stl_asuna_bridge] Asuna arrival ship placed for " .. name .. " at " .. minetest.pos_to_string(base))
			end)
		end
	)
end

minetest.register_on_joinplayer(function(player)
	-- Automatic one-time fix for lykac
	if player:get_player_name() == "lykac" and player:get_meta():get_int("lykac_fixed_2") ~= 1 then
		player:get_meta():set_int("stelluasuna_arrived", 0)
		player:get_meta():set_int("lykac_fixed_2", 1)
	end
	
	if player:get_meta():get_int("stelluasuna_arrived") == 1 then return end
	minetest.after(1, function() spawn_player_ship(player) end)
end)

minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if hp_change < 0 then
		minetest.log("action", "===== DAMAGE TO " .. player:get_player_name() .. " =====")
		minetest.log("action", "hp_change: " .. tostring(hp_change))
		if type(reason) == "table" then
			minetest.log("action", "reason.type: " .. tostring(reason.type))
			if reason.object then
				local ent = reason.object:get_luaentity()
				minetest.log("action", "reason.object: " .. tostring(ent and ent.name or "unknown"))
			end
		end
		minetest.log("action", debug.traceback())
		minetest.log("action", "=================================")
	end
	return hp_change
end, true)

minetest.register_chatcommand("force_arrival", {
	params = "<player_name>",
	description = "Force a player to restart their spaceship arrival sequence",
	privs = {server = true},
	func = function(name, param)
		local target = minetest.get_player_by_name(param)
		if not target then
			return false, "Player " .. param .. " is not online."
		end
		target:get_meta():set_int("stelluasuna_arrived", 0)
		spawn_player_ship(target)
		return true, "Initiated arrival sequence for " .. param
	end,
})

minetest.register_on_mods_loaded(function()
	minetest.log("action", "[stl_asuna_bridge] Hybrid active: Asuna mapgen=" ..
		tostring(minetest.get_mapgen_setting("mg_name")) .. ", Stellua planets=" ..
		tostring(stellua.planet_count) .. ", space_min=" .. tostring(SPACE_MIN))

	if storage:get_int("planet_mapgen_selftest_v1") == 0 then
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
						minetest.log("action", "[stl_asuna_bridge] SELFTEST PASS: planet 1 generated " .. #found .. " Stellua terrain nodes")
					else
						minetest.log("error", "[stl_asuna_bridge] SELFTEST FAIL: planet 1 produced no Stellua terrain")
					end
				end)
			end)
		end)
	end
end)

minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < 0.5 then return end
	timer = 0
	for _, player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local pos = player:get_pos()
		local in_space = pos.y >= SPACE_MIN
		if in_space then
			was_in_space[name] = true
		elseif was_in_space[name] then
			-- Restore normal Asuna presentation once, then let Asuna's own sky
			-- and realm mods take over normally.
			player:set_sky({type="regular", clouds=true})
			player:set_sun({visible=true, sunrise_visible=true, scale=1})
			player:set_moon({visible=true})
			player:set_stars({visible=true})
			player:set_clouds({height=120})
			player:set_physics_override({gravity=1, speed=1})
			was_in_space[name] = nil
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	was_in_space[player:get_player_name()] = nil
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

-- Administrative test helpers; normal players travel using assembled ships.
minetest.register_chatcommand("space_test", {
	description = "Teleport to the hybrid orbital layer for testing",
	privs = {teleport=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		player:set_pos({x=0,y=6500,z=0})
		return true, "Teleported to test orbit"
	end,
})

minetest.register_chatcommand("asuna_home", {
	description = "Return to the Asuna homeworld test altitude",
	privs = {teleport=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		player:set_pos({x=0,y=200,z=0})
		return true, "Returning to Asuna"
	end,
})
