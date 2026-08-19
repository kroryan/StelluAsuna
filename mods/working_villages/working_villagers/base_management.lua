-- StelluAsuna Working Villagers base management.
-- License: GPL-3.0-or-later (project integration).

local storage = minetest.get_mod_storage()
local homes = minetest.deserialize(storage:get_string("villager_homes")) or {}
local home_seq = storage:get_int("home_seq")
local HOME_RADIUS = 500
local HOME_SCAN = {x=HOME_RADIUS, y=HOME_RADIUS, z=HOME_RADIUS}

local function save_homes()
	storage:set_string("villager_homes", minetest.serialize(homes))
	storage:set_int("home_seq", home_seq)
end

local function esc(value)
	return minetest.formspec_escape(tostring(value or ""))
end

local function pos_string(pos)
	return minetest.pos_to_string(vector.round(pos), 0)
end

local function owner_can_use(home, name)
	return home and (home.owner == name or minetest.check_player_privs(name, {protection_bypass=true}))
end

local function home_for(id)
	return id and id ~= "" and homes[id] or nil
end

local function villager_objects(radius, center)
	local result = {}
	for _, object in ipairs(minetest.get_objects_inside_radius(center, radius)) do
		local entity = object:get_luaentity()
		if entity and entity.object == object and working_villages.is_villager(entity.name) then
			result[#result + 1] = {object=object, entity=entity}
		end
	end
	return result
end

local function find_bed(home, villager_pos)
	local beds = minetest.find_nodes_in_area(
		vector.subtract(home.pos, HOME_SCAN), vector.add(home.pos, HOME_SCAN), {"group:bed"})
	local best, distance
	for _, bed in ipairs(beds) do
		local d = vector.distance(villager_pos, bed)
		if not distance or d < distance then best, distance = bed, d end
	end
	return best
end

local function associate(entity, home)
	entity.village_home_id = home.id
	entity.village_home_pos = vector.new(home.pos)
	entity.pos_data = entity.pos_data or {}
	local bed = find_bed(home, entity.object:get_pos())
	if bed then entity.pos_data.bed_pos = bed end
	entity:set_state_info("Assigned to base " .. home.id .. ".")
	entity:update_infotext()
end

local function mode_label(mode)
	return ({npcs="defend against monsters", players="defend against players", all="defend against monsters and players", passive="work only"})[mode] or "defend against monsters"
end

local function home_formspec(home)
	local assigned = {}
	for _, item in ipairs(villager_objects(HOME_RADIUS, home.pos)) do
		local e = item.entity
		if e.village_home_id == home.id then
			assigned[#assigned + 1] = (e.villager_id or "unknown") .. " — " .. mode_label(e.village_defense_mode)
		end
	end
	return "formspec_version[4]size[11,8]" ..
		"label[0.5,0.4;Villahome " .. esc(home.id) .. "]" ..
		"label[0.5,0.9;Owner: " .. esc(home.owner) .. "  Area: 1001 x 1001 blocks]" ..
		"label[0.5,1.4;Assigned villagers: " .. esc(#assigned) .. "]" ..
		"textlist[0.5,1.8;10,2.1;assigned;" .. esc(table.concat(assigned, ",")) .. "]" ..
		"field[0.6,4.55;4,0.8;villager_id;Villager ID;]" ..
		"button[4.8,4.35;2.2,0.9;assign;Assign]" ..
		"button[7.2,4.35;2.8,0.9;unassign;Unassign]" ..
		"label[0.6,5.35;Defence mode for selected ID]" ..
		"button[0.6,5.75;2.3,0.8;mode_npcs;Monsters]" ..
		"button[3.1,5.75;2.3,0.8;mode_players;Players]" ..
		"button[5.6,5.75;2.3,0.8;mode_all;Both]" ..
		"button[8.1,5.75;2.3,0.8;mode_passive;Work only]" ..
		"button_exit[4,7;3,0.8;close;Close]"
end

local function show_home(name, home)
	minetest.show_formspec(name, "working_villages:villahome_" .. home.id, home_formspec(home))
end

local function find_owned_villager(name, id)
	for _, item in ipairs(villager_objects(HOME_RADIUS, minetest.get_player_by_name(name):get_pos())) do
		local e = item.entity
		if e.villager_id == id and (e.owner_name == name or e.owner_name == "working_villages:self_employed" or minetest.check_player_privs(name, {protection_bypass=true})) then
			return e
		end
	end
end

local function set_mode(entity, mode)
	entity.village_defense_mode = mode
	entity:set_state_info("Base order: " .. mode_label(mode) .. ".")
	entity:update_infotext()
end

local function handle_home_fields(player, home, fields)
	local name = player:get_player_name()
	if not owner_can_use(home, name) then return end
	local id = (fields.villager_id or ""):match("^%s*(V%-%d+)%s*$")
	local entity = id and find_owned_villager(name, id)
	if fields.assign and entity then associate(entity, home) end
	if fields.unassign and entity and entity.village_home_id == home.id then
		entity.village_home_id, entity.village_home_pos = "", nil
		entity:set_state_info("I am no longer assigned to a player base.")
		entity:update_infotext()
	end
	local modes = {mode_npcs="npcs", mode_players="players", mode_all="all", mode_passive="passive"}
	for button, mode in pairs(modes) do if fields[button] and entity then set_mode(entity, mode) end end
	if fields.close then return end
	show_home(name, home)
end

minetest.register_node("working_villages:villahome", {
	description = "Villahome Base Beacon",
	tiles = {"working_villages_villahome.png"},
	inventory_image = "working_villages_villahome.png",
	groups = {cracky=2, choppy=2},
	paramtype = "light",
	light_source = 3,
	can_dig = function(pos, digger)
		local id = minetest.get_meta(pos):get_string("home_id")
		return owner_can_use(home_for(id), digger:get_player_name())
	end,
	on_construct = function(pos)
		home_seq = home_seq + 1
		local id = "H-" .. string.format("%05d", home_seq)
		homes[id] = {id=id, pos=vector.round(pos), owner="", created=minetest.get_gametime()}
		minetest.get_meta(pos):set_string("home_id", id)
		save_homes()
	end,
	after_place_node = function(pos, placer)
		local id = minetest.get_meta(pos):get_string("home_id")
		if homes[id] then
			homes[id].owner = placer:get_player_name()
			minetest.get_meta(pos):set_string("owner", homes[id].owner)
			save_homes()
		end
	end,
	after_dig_node = function(pos, oldnode, oldmeta, digger)
		local id = oldmeta.fields and oldmeta.fields.home_id
		if id and homes[id] and owner_can_use(homes[id], digger:get_player_name()) then
			homes[id] = nil
			save_homes()
			for _, item in ipairs(villager_objects(HOME_RADIUS, pos)) do
				if item.entity.village_home_id == id then item.entity.village_home_id = "" end
			end
		end
	end,
	on_rightclick = function(pos, node, clicker)
		local id = minetest.get_meta(pos):get_string("home_id")
		local home = home_for(id)
		if home and owner_can_use(home, clicker:get_player_name()) then show_home(clicker:get_player_name(), home) end
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local id = formname:match("^working_villages:villahome_(H%-%d+)$")
	if id then
		local home = home_for(id)
		if home then handle_home_fields(player, home, fields) end
	end
	if formname ~= "working_villages:menuvilla" then return end
	local id = (fields.villager_id or ""):match("^%s*(V%-%d+)%s*$")
	local home_id = (fields.home_id or ""):match("^%s*(H%-%d+)%s*$")
	local entity = id and find_owned_villager(player:get_player_name(), id)
	local home = home_for(home_id)
	if fields.assign and entity and home and owner_can_use(home, player:get_player_name()) then associate(entity, home) end
	local modes = {mode_npcs="npcs", mode_players="players", mode_all="all", mode_passive="passive"}
	for button, mode in pairs(modes) do if fields[button] and entity then set_mode(entity, mode) end end
	if fields.close then return end
	minetest.show_formspec(player:get_player_name(), "working_villages:menuvilla", "formspec_version[4]size[11,8]" ..
		"label[0.5,0.4;Villager base control]" ..
		"label[0.5,0.9;IDs and current orders are shown in the list.]" ..
		"field[0.6,4.2;3.8,0.8;villager_id;Villager ID;]" ..
		"field[4.6,4.2;3.8,0.8;home_id;Villahome ID;]" ..
		"button[8.7,4;1.7,0.9;assign;Assign]" ..
		"button[0.6,5.3;2.2,0.8;mode_npcs;Monsters]" ..
		"button[3,5.3;2.2,0.8;mode_players;Players]" ..
		"button[5.4,5.3;2.2,0.8;mode_all;Both]" ..
		"button[7.8,5.3;2.2,0.8;mode_passive;Work only]" ..
		"button_exit[4,7;3,0.8;close;Close]")
end)

minetest.register_chatcommand("menuvilla", {
	description = "Open the player base villager manager",
	privs = {interact=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false, "Player not found" end
		minetest.show_formspec(name, "working_villages:menuvilla", "formspec_version[4]size[11,8]" ..
			"label[0.5,0.4;Villager base control]" ..
			"label[0.5,0.9;Use Villager ID (V-xxxxxx) and Villahome ID (H-xxxxx).]" ..
			"field[0.6,4.2;3.8,0.8;villager_id;Villager ID;]field[4.6,4.2;3.8,0.8;home_id;Villahome ID;]" ..
			"button[8.7,4;1.7,0.9;assign;Assign]" ..
			"button[0.6,5.3;2.2,0.8;mode_npcs;Monsters]button[3,5.3;2.2,0.8;mode_players;Players]" ..
			"button[5.4,5.3;2.2,0.8;mode_all;Both]button[7.8,5.3;2.2,0.8;mode_passive;Work only]" ..
			"button_exit[4,7;3,0.8;close;Close]")
		return true
	end,
})

local cleanup_timer = 0
local id_scan_timer = 10
minetest.register_globalstep(function(dtime)
	cleanup_timer = cleanup_timer + dtime
	id_scan_timer = id_scan_timer + dtime
	if cleanup_timer < 2 then return end
	cleanup_timer = 0
	for _, player in ipairs(minetest.get_connected_players()) do
		local center = player:get_pos()
		-- Assign IDs to every loaded villager in the player's base radius. The
		-- expensive web scan below remains limited to the immediate area.
		if id_scan_timer >= 10 then
			for _, item in ipairs(villager_objects(HOME_RADIUS, center)) do
				working_villages.ensure_villager_id(item.entity)
			end
		end
		for _, item in ipairs(villager_objects(40, center)) do
			local entity = item.entity
			working_villages.ensure_villager_id(entity)
			if entity.village_home_id then
				local home = home_for(entity.village_home_id)
				if home and vector.distance(entity.object:get_pos(), home.pos) <= HOME_RADIUS then
					entity.village_home_pos = vector.new(home.pos)
				end
			end
			-- Keep base interiors free of spider webs. Only remove nodes the
			-- villager is allowed to edit; claims/protection still win.
			local pos = entity.object:get_pos()
			local webs = minetest.find_nodes_in_area(vector.subtract(pos, {x=16,y=16,z=16}), vector.add(pos, {x=16,y=16,z=16}), {
				"group:spiderweb", "default:spiderweb", "horror:spiderweb", "horror:spiderweb_decaying",
				"livingcaves:spiderweb", "livingcaves:spiderweb2", "livingcaves:spiderweb3", "livingcaves:spiderweb4",
				"livingcaves:spiderweb5", "livingcaves:spiderweb6", "livingcaves:spiderweb7", "livingcaves:spiderweb8", "livingcaves:spiderweb9",
			})
			for _, web in ipairs(webs) do
				local owner = entity.owner_name or ""
				local protection_actor = (owner ~= "" and owner ~= "working_villages:self_employed") and owner or "working_villages"
				if not minetest.is_protected(web, protection_actor) then
					minetest.remove_node(web)
					entity:set_state_info("I cleared a spiderweb from the base.")
					break
				end
			end
		end
	end
	if id_scan_timer >= 10 then id_scan_timer = 0 end
end)

minetest.log("action", "[working_villages] villahome base management enabled")
