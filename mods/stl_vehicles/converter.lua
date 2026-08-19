-- Ship Converter: safely opts an arbitrary, floating structure into the
-- Stellua vehicle assembler.  It stores only a small metadata marker on each
-- node, so conversion is reversible without replacing or copying blocks.
local LIMIT = 999
local DIRECTIONS = {}
for i = 0, 5 do DIRECTIONS[#DIRECTIONS + 1] = minetest.wallmounted_to_dir(i) end

local function key(p) return minetest.hash_node_position(p) end
local function find_native_anchor(pos)
	local best, distance
	for x = -12, 12 do for y = -12, 12 do for z = -12, 12 do
		local p = vector.add(pos, {x=x,y=y,z=z})
		local n = minetest.get_node_or_nil(p)
		if n and (minetest.get_item_group(n.name, "spaceship") > 0
			or minetest.get_meta(p):get_int("stl_vehicles:converted") == 1) then
			local d = math.abs(x) + math.abs(y) + math.abs(z)
			if not distance or d < distance then best, distance = p, d end
		end
	end end end
	return best
end
local function formspec(meta)
	local count = meta:get_int("stl_vehicles:scan_count")
	local status = meta:get_string("stl_vehicles:scan_status")
	local owner = meta:get_string("stl_vehicles:converter_owner")
	return "formspec_version[4]size[9,6]" ..
		"label[0.5,0.35;Ship Converter]" ..
		"label[0.5,0.8;Owner: " .. minetest.formspec_escape(owner) .. "]" ..
		"label[0.5,1.25;Scanned blocks: " .. count .. " / " .. LIMIT .. "]" ..
		"textarea[0.5,1.65;8,1.35;status;Status;" .. minetest.formspec_escape(status) .. "]" ..
		"button[0.5,3.25;1.8,0.8;scan;Scan + Preview]" ..
		"button[2.5,3.25;1.8,0.8;convert;Convert]" ..
		"button[4.5,3.25;1.8,0.8;undo;Undo conversion]" ..
		"button_exit[6.5,3.25;1.8,0.8;close;Close]" ..
		"label[0.5,4.55;Rules: the complete structure must float and every outside face must touch air.]" ..
		"label[0.5,4.95;Maximum 999 blocks. Conversion keeps the original blocks and can be undone.]"
end

local function show(pos, player)
	local name = player:get_player_name()
	minetest.show_formspec(name, "stl_vehicles:converter:" .. key(pos), formspec(minetest.get_meta(pos)))
end

local function scan(pos, player)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("stl_vehicles:converter_owner")
	local name = player:get_player_name()
	if owner ~= name and not minetest.check_player_privs(name, {protection_bypass = true}) then
		return false, "Only the converter owner can use this block."
	end
	local queue, seen, blocks = {vector.round(pos)}, {}, {}
	-- If this is an existing Stellua ship, use its native hull as a strict
	-- bounding envelope.  This prevents a converter touching a launch pad or
	-- natural rock from counting the whole connected terrain as the ship.
	local anchor = find_native_anchor(pos)
	local minp, maxp
	if anchor then
		local native = select(1, stellua.assemble_vehicle(anchor, true))
		if native and #native > 0 then
			minp, maxp = vector.copy(native[1]), vector.copy(native[1])
			for _, p in ipairs(native) do
				for _, c in ipairs({"x", "y", "z"}) do minp[c] = math.min(minp[c], p[c]); maxp[c] = math.max(maxp[c], p[c]) end
			end
			-- One block of allowance permits ordinary hull panels and the converter
			-- itself without opening the scan to terrain beyond the ship envelope.
			minp = vector.subtract(minp, {x=1,y=1,z=1})
			maxp = vector.add(maxp, {x=1,y=1,z=1})
			queue = {vector.round(pos)}
		end
	end
	while #queue > 0 do
		local p = table.remove(queue, 1)
		local h = key(p)
		if not seen[h] then
			seen[h] = true
			local node = minetest.get_node_or_nil(p)
			if not node then return false, "The structure is not fully loaded; try again." end
			local inside = not minp or (p.x >= minp.x and p.x <= maxp.x and p.y >= minp.y and p.y <= maxp.y and p.z >= minp.z and p.z <= maxp.z)
			if node.name ~= "air" and node.name ~= "ignore" and inside then
				if #blocks >= LIMIT then return false, "Structure exceeds the strict 999-block limit." end
				if minetest.is_protected(p, name) then return false, "A protected block is part of this structure." end
				blocks[#blocks + 1] = vector.round(p)
				for _, d in ipairs(DIRECTIONS) do
					local n = p + d
					if not seen[key(n)] then
						if not minp or (n.x >= minp.x and n.x <= maxp.x and n.y >= minp.y and n.y <= maxp.y and n.z >= minp.z and n.z <= maxp.z) then queue[#queue + 1] = n end
					end
				end
			end
		end
	end
	local hashset = {}
	for _, p in ipairs(blocks) do hashset[key(p)] = true end
	local seats = 0
	for _, p in ipairs(blocks) do
		local node = minetest.get_node(p)
		if minetest.get_item_group(node.name, "seat") > 0 then seats = seats + 1 end
		for _, d in ipairs(DIRECTIONS) do
			local n = p + d
			if not hashset[key(n)] then
				local outside = minetest.get_node_or_nil(n)
				if not outside or outside.name ~= "air" then
					return false, "Rejected: every outside face must be surrounded by air; it is touching terrain or a wall."
				end
			end
		end
	end
	if seats ~= 1 then return false, "Rejected: the ship must contain exactly one Vehicle Seat." end
	return true, blocks
end

local function preview(blocks)
	for _, p in ipairs(blocks) do
		minetest.add_particle({pos = vector.add(p, {x=0.5,y=0.5,z=0.5}), velocity={x=0,y=0.2,z=0},
			expirationtime=5, size=3, glow=10, texture="default_mese_block.png"})
	end
end

minetest.register_node("stl_vehicles:ship_converter", {
	description = "Ship Converter",
	tiles = {"stl_vehicles_ship_converter.png"},
	groups = {cracky=2, ship_converter=1},
	sounds = stellua.node_sound_metal_defaults(),
	 on_construct = function(pos)
		minetest.get_meta(pos):set_string("stl_vehicles:scan_status", "Press Scan + Preview to inspect the connected structure.")
	end,
	after_place_node = function(pos, placer)
		if placer and placer:is_player() then minetest.get_meta(pos):set_string("stl_vehicles:converter_owner", placer:get_player_name()) end
	end,
	on_rightclick = function(pos, _, player) show(pos, player) end,
})

minetest.register_craft({
	output = "stl_vehicles:ship_converter",
	recipe = {{"stl_core:titanium", "stl_core:copper", "stl_core:titanium"}, {"stl_core:copper", "stl_vehicles:assembler", "stl_core:copper"}, {"", "stl_core:titanium", ""}}
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local hash = formname:match("^stl_vehicles:converter:(.+)$")
	if not hash or not player then return false end
	local pos = minetest.get_position_from_hash(tonumber(hash))
	if not pos then return false end
	local meta = minetest.get_meta(pos)
	if fields.close or fields.quit then return false end
	local ok, result
	if fields.scan then
		ok, result = scan(pos, player)
		if ok then
			meta:set_int("stl_vehicles:scan_count", #result)
			meta:set_string("stl_vehicles:scan_data", minetest.serialize(result))
			meta:set_string("stl_vehicles:scan_status", "Preview shown for 5 seconds. Press Convert to apply.")
			preview(result)
		else meta:set_string("stl_vehicles:scan_status", result) end
		show(pos, player)
	elseif fields.convert then
		ok, result = scan(pos, player)
		if ok then
			for _, p in ipairs(result) do minetest.get_meta(p):set_int("stl_vehicles:converted", 1) end
			meta:set_string("stl_vehicles:converted_data", minetest.serialize(result))
			meta:set_string("stl_vehicles:scan_status", "Converted. The ship assembler now recognizes all scanned blocks.")
		else meta:set_string("stl_vehicles:scan_status", result) end
		show(pos, player)
	elseif fields.undo then
		local owner = meta:get_string("stl_vehicles:converter_owner")
		if owner ~= player:get_player_name() and not minetest.check_player_privs(player:get_player_name(), {protection_bypass = true}) then
			meta:set_string("stl_vehicles:scan_status", "Only the converter owner can undo this conversion.")
			show(pos, player)
			return true
		end
		local data = minetest.deserialize(meta:get_string("stl_vehicles:converted_data"))
		if type(data) == "table" then
			for _, p in ipairs(data) do if vector.distance(pos, p) > 0 then minetest.get_meta(p):set_int("stl_vehicles:converted", 0) end end
			meta:set_string("stl_vehicles:converted_data", "")
			meta:set_string("stl_vehicles:scan_status", "Last conversion undone.")
		else meta:set_string("stl_vehicles:scan_status", "There is no conversion to undo.") end
		show(pos, player)
	end
	return true
end)
