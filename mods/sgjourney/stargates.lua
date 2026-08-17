local S = sgjourney
S.gates = S.load_table("gates")
S.links = S.load_table("links")
S.expiries = S.load_table("expiries")

local variants = {"milky_way", "pegasus", "universe", "tollan", "classic"}
local ring_box = {
	type = "fixed", fixed = {
		{-0.5, -0.5, -0.2, 0.5, 0.5, 0.2},
	}
}

-- Nine-node-wide closed stepped circle. Adjacent tiers overlap horizontally,
-- so every segment shares a full face rather than touching only at a corner.
-- The controller occupies {0, 0, 0}.
local ring_offsets = {
	{x=-2,y=0,z=0}, {x=-1,y=0,z=0}, {x=1,y=0,z=0}, {x=2,y=0,z=0},
	{x=-3,y=1,z=0}, {x=-2,y=1,z=0}, {x=2,y=1,z=0}, {x=3,y=1,z=0},
	{x=-4,y=2,z=0}, {x=-3,y=2,z=0}, {x=3,y=2,z=0}, {x=4,y=2,z=0},
	{x=-4,y=3,z=0}, {x=4,y=3,z=0},
	{x=-4,y=4,z=0}, {x=4,y=4,z=0},
	{x=-4,y=5,z=0}, {x=4,y=5,z=0},
	{x=-4,y=6,z=0}, {x=-3,y=6,z=0}, {x=3,y=6,z=0}, {x=4,y=6,z=0},
	{x=-3,y=7,z=0}, {x=-2,y=7,z=0}, {x=2,y=7,z=0}, {x=3,y=7,z=0},
	{x=-2,y=8,z=0}, {x=-1,y=8,z=0}, {x=0,y=8,z=0}, {x=1,y=8,z=0}, {x=2,y=8,z=0},
}

local function build_ring(pos, variant)
	for _, off in ipairs(ring_offsets) do
		local p = vector.add(pos, off)
		if core.get_node(p).name == "air" then
			core.set_node(p, {name = "sgjourney:" .. variant .. "_ring"})
			core.get_meta(p):set_string("controller", S.pos_key(pos))
		end
	end
end

local function clear_ring(pos, variant)
	for _, off in ipairs(ring_offsets) do
		local p = vector.add(pos, off)
		if core.get_node(p).name == "sgjourney:" .. variant .. "_ring" and core.get_meta(p):get_string("controller") == S.pos_key(pos) then
			core.remove_node(p)
		end
	end
end

local function gate_meta(pos)
	local meta = core.get_meta(pos)
	local address = meta:get_string("address")
	if address == "" then
		address = S.hash_address(pos)
		meta:set_string("address", address)
	end
	return meta, address
end

local function save_gate(pos, variant)
	local meta, address = gate_meta(pos)
	S.gates[address] = {pos = vector.round(pos), variant = variant}
	S.save_table("gates", S.gates)
	meta:set_string("infotext", "Stargate " .. address .. " (inactive)")
end

local function clear_portal(pos)
	-- The rounded ring leaves a seven-wide by seven-high opening.  Clear the
	-- complete opening so stale horizons cannot remain at the top or sides.
	for y = 1, 7 do for x = -3, 3 do
		local p = vector.add(pos, {x = x, y = y, z = 0})
		if core.get_node(p).name == "sgjourney:event_horizon" then core.remove_node(p) end
	end end
end

function S.disconnect(pos)
	local key = S.pos_key(pos)
	local other = S.links[key]
	clear_portal(pos)
	S.links[key] = nil
	S.expiries[key] = nil
	if other then
		clear_portal(other)
		S.links[S.pos_key(other)] = nil
		S.expiries[S.pos_key(other)] = nil
		local om = core.get_meta(other)
		om:set_string("infotext", "Stargate " .. om:get_string("address") .. " (inactive)")
	end
	S.save_table("links", S.links)
	S.save_table("expiries", S.expiries)
	local meta = core.get_meta(pos)
	meta:set_string("infotext", "Stargate " .. meta:get_string("address") .. " (inactive)")
	S.sound("stargate_close", pos)
end

function S.set_iris(pos, closed)
	local meta = core.get_meta(pos)
	meta:set_int("iris_closed", closed and 1 or 0)
	meta:set_string("iris_state", closed and "closed" or "open")
	S.sound(closed and "iris_close" or "iris_open", pos)
end

local function build_portal(pos)
	-- Fill every cell inside the stepped nine-node ring.  Ring segments at
	-- the rounded corners are left untouched, so the horizon occupies the
	-- actual seven-by-seven aperture rather than a narrow five-by-five strip.
	for y = 1, 7 do for x = -3, 3 do
		local p = vector.add(pos, {x = x, y = y, z = 0})
		local n = core.get_node(p).name
		if n == "air" or n == "sgjourney:event_horizon" then
			core.set_node(p, {name = "sgjourney:event_horizon"})
			core.get_meta(p):set_string("controller", S.pos_key(pos))
		end
	end end
end

function S.dial(pos, address, player)
	address = address:upper():gsub("[^A-Z]", "")
	local target = S.gates[address]
	if not target then return false, "Unknown address: " .. address end
	if vector.equals(vector.round(pos), vector.round(target.pos)) then return false, "Cannot dial this gate" end
	if S.links[S.pos_key(pos)] or S.links[S.pos_key(target.pos)] then return false, "A Stargate is already connected" end
	local meta = core.get_meta(pos)
	S.sound("stargate_dial_fail", pos, 0.1)
	core.after(1.0, function()
		if core.get_node(pos).name:find("_stargate$") then
			build_portal(pos); build_portal(target.pos)
			S.links[S.pos_key(pos)] = target.pos
			S.links[S.pos_key(target.pos)] = vector.round(pos)
			local expires = os.time() + 45
			S.expiries[S.pos_key(pos)] = expires
			S.expiries[S.pos_key(target.pos)] = expires
			S.save_table("links", S.links)
			S.save_table("expiries", S.expiries)
			meta:set_string("infotext", "Stargate " .. meta:get_string("address") .. " -> " .. address)
			core.get_meta(target.pos):set_string("infotext", "Incoming wormhole from " .. meta:get_string("address"))
			S.sound("stargate_open", pos); S.sound("stargate_open", target.pos)
			local origin = vector.round(pos)
			local destination = vector.round(target.pos)
			core.after(45, function()
				local linked = S.links[S.pos_key(origin)]
				if linked and vector.equals(vector.round(linked), destination) then
					S.disconnect(origin)
				end
			end)
		end
	end)
	return true, "Dialing " .. address
end

-- Restore connection deadlines after a restart. Legacy links created before
-- deadlines existed are unsafe/stale and are closed as soon as the mod loads.
core.after(1, function()
	local scheduled = {}
	for key, target in pairs(S.links) do
		if not scheduled[key] then
			local origin = core.string_to_pos(key)
			local target_key = target and S.pos_key(target)
			if origin then
				scheduled[key] = true
				if target_key then scheduled[target_key] = true end
				local delay = (S.expiries[key] or 0) - os.time()
				if delay <= 0 then
					S.disconnect(origin)
				else
					core.after(delay, function()
						local linked = S.links[key]
						if linked and target_key == S.pos_key(linked) then S.disconnect(origin) end
					end)
				end
			end
		end
	end
end)

core.register_node("sgjourney:event_horizon", {
	description = "Event Horizon", drawtype = "glasslike", tiles = {"sgjourney_block_event_horizon.png"},
	use_texture_alpha = "blend", paramtype = "light", sunlight_propagates = true, walkable = false, pointable = false,
	diggable = false, buildable_to = false, light_source = 8, groups = {not_in_creative_inventory = 1},
})

local function teleport_through_horizon(obj, horizon)
	local gate = core.string_to_pos(core.get_meta(horizon):get_string("controller"))
	if not gate or core.get_item_group(core.get_node(gate).name, "sgjourney_gate") == 0 then
		gate = S.find_gate(horizon, 10)
	end
	if not gate then return false end
	local target = S.links[S.pos_key(gate)]
	if not target then return false end
	local meta = obj:get_meta()
	local now = core.get_us_time()
	if now - meta:get_int("sgjourney_teleport") <= 2000000 then return true end
	meta:set_int("sgjourney_teleport", now)
	if core.get_meta(target):get_int("iris_closed") == 1 then
		S.sound("iris_thud", target)
		obj:punch(obj, 1.0, {damage_groups = {fleshy = 20}}, nil)
	else
		-- All native variants use the same horizontal gate plane. Place the
		-- traveller two nodes in front of the destination, safely outside its
		-- controller and horizon nodes.
		obj:set_pos(vector.add(vector.round(target), {x = 0, y = 2, z = 2}))
		S.sound("wormhole_travel", target)
	end
	return true
end

core.register_abm({
	label = "Stargate event horizon teleport", nodenames = {"sgjourney:event_horizon"}, interval = 0.2, chance = 1,
	action = function(pos)
		for _, obj in ipairs(core.get_objects_inside_radius(pos, 1.1)) do
			teleport_through_horizon(obj, pos)
		end
	end,
})

-- Player movement can cross from one mapblock to the next between ABM ticks.
-- Sample the whole aperture around each player so walking, sprinting and
-- falling through every Stargate variant reliably trigger wormhole travel.
local player_scan_timer = 0
core.register_globalstep(function(dtime)
	player_scan_timer = player_scan_timer + dtime
	if player_scan_timer < 0.1 then return end
	player_scan_timer = 0
	for _, player in ipairs(core.get_connected_players()) do
		local p = player:get_pos()
		local horizons = core.find_nodes_in_area(
			vector.subtract(p, {x = 1, y = 2, z = 1}),
			vector.add(p, {x = 1, y = 2, z = 1}),
			{"sgjourney:event_horizon"})
		for _, horizon in ipairs(horizons) do
			if teleport_through_horizon(player, horizon) then break end
		end
	end
end)

for _, variant in ipairs(variants) do
	local name = variant .. "_stargate"
	core.register_node("sgjourney:" .. variant .. "_ring", {
		description = variant:gsub("_", " "):gsub("^%l", string.upper) .. " Stargate Ring Segment",
		tiles = {"sgjourney_block_" .. name .. ".png"}, groups = {cracky = 1, not_in_creative_inventory = 1},
		drop = "", sounds = default and default.node_sound_metal_defaults() or nil,
		on_dig = function(pos, _, digger)
			local controller = core.string_to_pos(core.get_meta(pos):get_string("controller"))
			if controller and core.get_item_group(core.get_node(controller).name, "sgjourney_gate") > 0 then
				if S.can_use(controller, digger) then core.dig_node(controller) end
			elseif not core.is_protected(pos, digger:get_player_name()) then
				core.remove_node(pos)
			end
		end,
	})
	core.register_node("sgjourney:" .. name, {
		description = variant:gsub("_", " "):gsub("^%l", string.upper) .. " Stargate",
		drawtype = "nodebox", node_box = ring_box, tiles = {"sgjourney_block_" .. name .. ".png"}, paramtype = "light", paramtype2 = "facedir",
		groups = {cracky = 1, sgjourney_gate = 1}, sounds = default and default.node_sound_metal_defaults() or nil,
		on_construct = function(pos)
			local meta = core.get_meta(pos); meta:get_inventory():set_size("fuel", 0); save_gate(pos, variant); build_ring(pos, variant)
		end,
		on_destruct = function(pos)
			S.disconnect(pos); clear_ring(pos, variant)
			local _, address = gate_meta(pos); S.gates[address] = nil; S.save_table("gates", S.gates)
		end,
		on_rightclick = function(pos, _, player)
			if not S.can_use(pos, player) then return end
			local meta, address = gate_meta(pos)
			local state = S.links[S.pos_key(pos)] and "Connected" or "Inactive"
			local fs = "formspec_version[4]size[10,6]label[0.5,0.5;" .. core.formspec_escape("Stargate " .. address .. " — " .. state) .. "]" ..
				"field[0.5,1.4;9,0.9;address;Destination address;]label[0.5,2.8;No fuel or external power required]" ..
				"button[0.5,4.5;2.7,1;dial;Dial]button[3.65,4.5;2.7,1;disconnect;Disconnect]button[6.8,4.5;2.7,1;iris;Toggle iris]"
			core.show_formspec(player:get_player_name(), "sgjourney:gate_" .. S.pos_key(pos), fs)
		end,
		allow_metadata_inventory_put = function(pos, _, _, stack, player) return S.can_use(pos, player) and stack:get_count() or 0 end,
	})
end

core.register_lbm({
	label = "Remove orphaned Stargate ring segments",
	name = "sgjourney:remove_orphaned_ring_segments_v1",
	nodenames = {
		"sgjourney:milky_way_ring", "sgjourney:pegasus_ring", "sgjourney:universe_ring",
		"sgjourney:tollan_ring", "sgjourney:classic_ring",
	},
	run_at_every_load = false,
	action = function(pos)
		local controller = core.string_to_pos(core.get_meta(pos):get_string("controller"))
		if not controller or core.get_item_group(core.get_node(controller).name, "sgjourney_gate") == 0 then
			core.remove_node(pos)
		end
	end,
})

core.register_lbm({
	label = "Upgrade Stargates to rounded ring",
	name = "sgjourney:closed_ring_upgrade_v2",
	nodenames = {
		"sgjourney:milky_way_stargate", "sgjourney:pegasus_stargate", "sgjourney:universe_stargate",
		"sgjourney:tollan_stargate", "sgjourney:classic_stargate",
	},
	run_at_every_load = false,
	action = function(pos, node)
		local variant = node.name:match("^sgjourney:(.+)_stargate$")
		if not variant then return end
		local controller = S.pos_key(pos)
		for y = 0, 8 do for x = -4, 4 do
			local p = vector.add(pos, {x=x, y=y, z=0})
			if core.get_node(p).name == "sgjourney:" .. variant .. "_ring" and core.get_meta(p):get_string("controller") == controller then
				core.remove_node(p)
			end
		end end
		build_ring(pos, variant)
	end,
})

core.register_on_player_receive_fields(function(player, formname, fields)
	local encoded = formname:match("^sgjourney:gate_(.+)$")
	if not encoded then return end
	local gate = core.string_to_pos(encoded)
	if not gate or not S.can_use(gate, player) then return end
	if fields.dial then
		local ok, msg = S.dial(gate, fields.address or "", player)
		core.chat_send_player(player:get_player_name(), (ok and "[Stargate] " or "[Stargate error] ") .. msg)
	elseif fields.disconnect then S.disconnect(gate)
	elseif fields.iris then S.set_iris(gate, core.get_meta(gate):get_int("iris_closed") ~= 1) end
end)
