local SPACE_MIN = stellua.hybrid_space_min or 6368
local ASUNA_SURFACE_MIN = -128
local ASUNA_SURFACE_MAX = 256
local ARRIVAL_FOOTPRINT_RADIUS = 2
local ARRIVAL_SEARCH_RADIUS = 48
local ARRIVAL_ECOLOGY_RADIUS = 24
local ARRIVAL_CONTINENT_RADIUS = 48
local ARRIVAL_CONTINENT_STEP = 16
local ARRIVAL_MIN_LAND_RATIO = 0.70
-- get_mod_storage() depends on the current mod context, which is available
-- while this file is loaded but not later inside on_mods_loaded callbacks.
local storage = minetest.get_mod_storage()
local arrival_tokens = {}

local function set_arrival_physics(player, attribute, value)
	playerphysics.add_physics_factor(player, attribute, "stl_asuna_bridge:arrival", value)
end

local function clear_arrival_physics(player)
	for _, attribute in ipairs({"speed", "jump", "gravity"}) do
		playerphysics.remove_physics_factor(player, attribute, "stl_asuna_bridge:arrival")
	end
end

local function is_arrival_surface(node)
	if not node or node.name == "air" or node.name == "ignore" then return false end
	local def = minetest.registered_nodes[node.name]
	if not def or not def.walkable then return false end
	if minetest.get_item_group(node.name, "tree") > 0
		or minetest.get_item_group(node.name, "leaves") > 0 then return false end
	return minetest.get_item_group(node.name, "water") == 0
		and minetest.get_item_group(node.name, "lava") == 0
end

local function find_surface_y(x, z)
	for y = ASUNA_SURFACE_MAX, ASUNA_SURFACE_MIN, -1 do
		local node = minetest.get_node_or_nil({x=x, y=y, z=z})
		if node and (minetest.get_item_group(node.name, "water") > 0
			or minetest.get_item_group(node.name, "lava") > 0) then
			return nil
		end
		if is_arrival_surface(node) then return y end
	end
	return nil
end

-- Find a dry, solid landing area in Asuna. The ship footprint is checked as a
-- whole so it cannot be placed through a hill, tree or body of liquid.
local function find_asuna_arrival_base(x, z)
	local highest_surface
	for dx = -ARRIVAL_FOOTPRINT_RADIUS, ARRIVAL_FOOTPRINT_RADIUS do
		for dz = -ARRIVAL_FOOTPRINT_RADIUS, ARRIVAL_FOOTPRINT_RADIUS do
			local surface_y = find_surface_y(x + dx, z + dz)
			if not surface_y then return nil end
			highest_surface = math.max(highest_surface or surface_y, surface_y)
		end
	end
	return {x=x, y=highest_surface + 1, z=z}
end

local function is_unwanted_arrival_biome(name)
	name = string.lower(name or "")
	return name:find("desert", 1, true) ~= nil
		or name:find("outback", 1, true) ~= nil
		or name:find("badland", 1, true) ~= nil
		or name:find("quicksand", 1, true) ~= nil
		or name:find("fiery", 1, true) ~= nil
		or name:find("alpine", 1, true) ~= nil
end

local function score_asuna_arrival_site(base)
	local biome_data = minetest.get_biome_data({x=base.x, y=base.y - 1, z=base.z})
	if not biome_data then return nil end
	local biome_name = minetest.get_biome_name(biome_data.biome)
	if not biome_name or is_unwanted_arrival_biome(biome_name) then return nil end

	local biome = asuna and asuna.biomes and asuna.biomes[biome_name]
	if not biome or not biome.animals or #biome.animals == 0 then return nil end

	local eco_min = {
		x = base.x - ARRIVAL_ECOLOGY_RADIUS,
		y = math.max(ASUNA_SURFACE_MIN, base.y - 2),
		z = base.z - ARRIVAL_ECOLOGY_RADIUS,
	}
	local eco_max = {
		x = base.x + ARRIVAL_ECOLOGY_RADIUS,
		y = math.min(ASUNA_SURFACE_MAX, base.y + 24),
		z = base.z + ARRIVAL_ECOLOGY_RADIUS,
	}
	local trees = minetest.find_nodes_in_area(eco_min, eco_max, {"group:tree"})
	local leaves = minetest.find_nodes_in_area(eco_min, eco_max, {"group:leaves"})
	local flora = minetest.find_nodes_in_area(eco_min, eco_max, {"group:flora", "group:flower"})
	if #trees == 0 then return nil end

	local score = (#trees * 10) + math.min(#leaves, 40) + math.min(#flora, 20)
	score = score + (#biome.animals * 5)
	if biome_name == "grassland" or biome_name == "prairie"
		or biome_name == "dorwinion" then
		score = score + 25
	end
	return score, biome_name, #trees, #flora, #biome.animals
end

-- Reject small islands. Sampling the surface in a broad ring keeps the ship
-- on a substantial landmass without requiring a full terrain scan.
local function score_continent(base)
	local total = 0
	local dry = 0
	for dx = -ARRIVAL_CONTINENT_RADIUS, ARRIVAL_CONTINENT_RADIUS, ARRIVAL_CONTINENT_STEP do
		for dz = -ARRIVAL_CONTINENT_RADIUS, ARRIVAL_CONTINENT_RADIUS, ARRIVAL_CONTINENT_STEP do
			total = total + 1
			if find_surface_y(base.x + dx, base.z + dz) then
				dry = dry + 1
			end
		end
	end
	local ratio = dry / total
	if ratio < ARRIVAL_MIN_LAND_RATIO then return nil end
	return ratio
end

-- Select the best ecological site in the emerged area instead of accepting
-- the first dry column, which could be a desert or empty plateau.
local function find_asuna_arrival_site(center_x, center_z)
	local best
	for x = center_x - ARRIVAL_SEARCH_RADIUS, center_x + ARRIVAL_SEARCH_RADIUS, 8 do
		for z = center_z - ARRIVAL_SEARCH_RADIUS, center_z + ARRIVAL_SEARCH_RADIUS, 8 do
			local base = find_asuna_arrival_base(x, z)
			if base then
				local score, biome_name, tree_count, flora_count, animal_count = score_asuna_arrival_site(base)
				local land_ratio = score and score_continent(base)
				if score and land_ratio and (not best or score > best.score) then
					best = {
						base = base,
						score = score,
						biome_name = biome_name,
						tree_count = tree_count,
						flora_count = flora_count,
						animal_count = animal_count,
						land_ratio = land_ratio,
					}
				end
			end
		end
	end
	return best
end

-- StelluAsuna starts on the Asuna homeworld, but keeps Stellua's original
-- arrival fantasy: new players wake up inside a landed starter spacecraft.
local function arrival_ship_ready(base)
	local seat = minetest.get_node_or_nil(vector.add(base, {x=0, y=1, z=0}))
	local floor = minetest.get_node_or_nil(base)
	local feet = minetest.get_node_or_nil(vector.add(base, {x=0, y=2, z=0}))
	local head = minetest.get_node_or_nil(vector.add(base, {x=0, y=3, z=0}))
	if not seat or not floor or not feet or not head then return false end
	if seat.name ~= "stl_vehicles:seat" or floor.name == "air" then return false end
	return feet.name == "air" and head.name == "air"
end

local function put_player_in_arrival_ship(player, base, token)
	if not player or not player:is_player() then return end
	-- The schematic seat occupies y=1. A player position at y=2.0 stands on
	-- it; y=1.5 intersects the seat and caused falling/teleport corrections.
	local inside = vector.add(base, {x=0, y=2.05, z=0})
	player:set_pos(inside)
	stellua.set_respawn(player, inside)
	player:get_meta():set_int("stelluasuna_arrived", 1)
	
	-- Do not restore gravity immediately! The client needs time to download the ship's chunks.
	-- If we restore gravity now, the client will fall through the floor before seeing it.
	minetest.after(3.5, function()
			if player and player:is_player()
			and arrival_tokens[player:get_player_name()] == token then
				-- Snap them back to the exact position inside the ship just in case they sank a bit
				player:set_pos(inside)
				clear_arrival_physics(player)
				minetest.chat_send_player(player:get_player_name(), "Arrival sequence complete. Welcome to StelluAsuna!")
			end
		end)
end

local function spawn_player_ship(player, force)
	if not player or not player:is_player() then return end
	
	local name = player:get_player_name()
	if not force and player:get_meta():get_int("stelluasuna_arrived") == 1 then return end
	arrival_tokens[name] = (arrival_tokens[name] or 0) + 1
	local token = arrival_tokens[name]
	
	-- Suspend the player above the Asuna surface while the arrival area loads.
	set_arrival_physics(player, "speed", 0)
	set_arrival_physics(player, "jump", 0)
	set_arrival_physics(player, "gravity", 0)
	player:set_pos({x=0, y=ASUNA_SURFACE_MAX + 32, z=0})
	
	minetest.show_formspec(name, "stl_asuna_bridge:loading", 
		"size[10,10,true]" ..
		"bgcolor[#000000;true]" ..
		"label[3.5,4.5;< Welcome to StelluAsuna >]" ..
		"label[3,5.5;Preparing your arrival craft...]"
	)
	
	local function try_arrival_area(retries)
		if arrival_tokens[name] ~= token then return end
		local offset_x = math.random(-150, 150)
		local offset_z = math.random(-150, 150)
		local pmin = {x = offset_x - ARRIVAL_SEARCH_RADIUS - 8, y = ASUNA_SURFACE_MIN, z = offset_z - ARRIVAL_SEARCH_RADIUS - 8}
		local pmax = {x = offset_x + ARRIVAL_SEARCH_RADIUS + 8, y = ASUNA_SURFACE_MAX, z = offset_z + ARRIVAL_SEARCH_RADIUS + 8}
		minetest.emerge_area(pmin, pmax,
			function(_, _, remaining)
				if remaining ~= 0 or arrival_tokens[name] ~= token then return end
				minetest.after(2, function()
					if arrival_tokens[name] ~= token then return end
					local p = minetest.get_player_by_name(name)
					if not p then return end
					local site = find_asuna_arrival_site(offset_x, offset_z)
					if not site then
						if retries < 20 then
							try_arrival_area(retries + 1)
						else
							minetest.log("error", "[stl_asuna_bridge] Could not find a dry Asuna arrival site for " .. name)
						end
						return
					end
					local base = site.base

					minetest.place_schematic(base,
						minetest.get_modpath("stl_core").."/schems/starter_rocket.mts",
						"0", {}, true, "place_center_x, place_center_z")
					local tank = minetest.registered_nodes["stl_vehicles:tank"]
					if tank and tank.on_construct then
						tank.on_construct(vector.add(base, {x=0, y=4, z=0}))
					end

					local function finish_when_ready(ready_retries)
						if arrival_tokens[name] ~= token then return end
						local current = minetest.get_player_by_name(name)
						if not current then return end
						if not arrival_ship_ready(base) then
							if ready_retries < 20 then
								minetest.after(0.25, function()
									finish_when_ready(ready_retries + 1)
								end)
							else
								minetest.log("error", "[stl_asuna_bridge] Arrival ship failed readiness check for " .. name)
							end
							return
						end
						put_player_in_arrival_ship(current, base, token)
						minetest.close_formspec(name, "stl_asuna_bridge:loading")
						minetest.log("action", "[stl_asuna_bridge] Asuna continental arrival site for " .. name .. ": biome=" .. site.biome_name .. ", land_ratio=" .. string.format("%.2f", site.land_ratio) .. ", trees=" .. site.tree_count .. ", flora=" .. site.flora_count .. ", eligible_animals=" .. site.animal_count .. ", position=" .. minetest.pos_to_string(base))
					end
					finish_when_ready(0)
				end)
			end
		)
	end
	try_arrival_area(0)
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
		spawn_player_ship(target, true)
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

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	arrival_tokens[name] = (arrival_tokens[name] or 0) + 1
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
