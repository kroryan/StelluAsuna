local SPACE_MIN = stellua.hybrid_space_min or 6368
local was_in_space = {}
local timer = 0
-- get_mod_storage() depends on the current mod context, which is available
-- while this file is loaded but not later inside on_mods_loaded callbacks.
local storage = minetest.get_mod_storage()
local arrival_in_progress = false

-- StelluAsuna starts on the Asuna homeworld, but keeps Stellua's original
-- arrival fantasy: new players wake up inside a landed starter spacecraft.
-- One shared craft is generated per world so the public spawn stays tidy.
local function put_player_in_arrival_ship(player, base)
	if not player or not player:is_player() then return end
	local inside = vector.add(base, {x=0, y=1.5, z=0})
	player:set_pos(inside)
	stellua.set_respawn(player, vector.add(base, {x=0, y=1, z=0}))
	player:get_meta():set_int("stelluasuna_arrived", 1)
	player:set_physics_override({speed=1, jump=1, gravity=1})
end

-- Players whose first connection happened while the shared ship was still
-- emerging get their arrival completed on the next join. Hold movement for
-- the short hand-off so they never see themselves spawn on the bare ground.
minetest.register_on_joinplayer(function(player)
	if player:get_meta():get_int("stelluasuna_arrived") == 1 then return end
	player:set_physics_override({speed=0, jump=0, gravity=0})
	minetest.chat_send_player(player:get_player_name(), "Preparing Asuna arrival craft...")
	local attempts = 0
	local function finish_arrival()
		if not player or not player:is_player() then return end
		local saved = minetest.deserialize(storage:get_string("asuna_arrival_ship"))
		if saved then
			put_player_in_arrival_ship(player, saved)
		elseif attempts < 60 then
			attempts = attempts + 1
			minetest.after(0.5, finish_arrival)
		else
			player:set_physics_override({speed=1, jump=1, gravity=1})
		end
	end
	minetest.after(0.5, finish_arrival)
end)

minetest.register_on_newplayer(function(player)
	minetest.after(1, function()
		if not player or not player:is_player() then return end
		local saved = minetest.deserialize(storage:get_string("asuna_arrival_ship"))
		if saved then
			put_player_in_arrival_ship(player, saved)
			return
		end
		if arrival_in_progress then
			minetest.after(2, function()
				local retry = minetest.deserialize(storage:get_string("asuna_arrival_ship"))
				if retry then put_player_in_arrival_ship(player, retry) end
			end)
			return
		end

		arrival_in_progress = true
		local spawn_pos = vector.round(player:get_pos())
		local base = {x=spawn_pos.x, y=spawn_pos.y-1, z=spawn_pos.z}
		minetest.emerge_area(vector.subtract(base, 12), vector.add(base, 12),
			function(_, _, remaining)
				if remaining ~= 0 then return end
				minetest.after(0, function()
					minetest.place_schematic(base,
						minetest.get_modpath("stl_core").."/schems/starter_rocket.mts",
						"0", {}, true, "place_center_x, place_center_z")
					local tank = minetest.registered_nodes["stl_vehicles:tank"]
					if tank and tank.on_construct then
						tank.on_construct(vector.add(base, {x=0, y=4, z=0}))
					end
					storage:set_string("asuna_arrival_ship", minetest.serialize(base))
					arrival_in_progress = false
					put_player_in_arrival_ship(player, base)
					minetest.log("action", "[stl_asuna_bridge] Asuna arrival ship placed at " .. minetest.pos_to_string(base))
				end)
			end)
	end)
end)

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
