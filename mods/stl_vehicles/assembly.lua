--Remember the next inventory id
local inv_count = 1

-- Node metadata may contain ItemStack userdata, which cannot be serialized by
-- the engine when an LVAE is saved. Convert it to plain strings first.
local function serializable_node_meta(meta)
	local raw = meta:to_table() or {}
	local out = {fields = {}, inventory = {}}
	for k, v in pairs(raw.fields or {}) do out.fields[k] = tostring(v) end
	for listname, list in pairs(raw.inventory or {}) do
		out.inventory[listname] = {}
		for i, stack in ipairs(list) do out.inventory[listname][i] = ItemStack(stack):to_string() end
	end
	return out
end

local function sanitize_meta_table(raw)
	if type(raw) ~= "table" then return nil end
	local out = {fields = {}, inventory = {}}
	for k, v in pairs(raw.fields or {}) do out.fields[k] = tostring(v) end
	for listname, list in pairs(raw.inventory or {}) do
		out.inventory[listname] = {}
		for i, stack in ipairs(list) do out.inventory[listname][i] = ItemStack(stack):to_string() end
	end
	return out
end

local function restore_node_meta(pos, data)
	if type(data) ~= "table" then return end
	local meta = minetest.get_meta(pos)
	for k, v in pairs(data.fields or {}) do meta:set_string(k, tostring(v)) end
	local inv = meta:get_inventory()
	for listname, list in pairs(data.inventory or {}) do
		inv:set_size(listname, #list)
		for i, value in ipairs(list) do inv:set_stack(listname, i, ItemStack(value)) end
	end
end

--Override static saving functions for LVAE to allow saving more arbitrary data
local lvae_defs = minetest.registered_entities["lvae:lvae"]

local old_get_staticdata = lvae_defs.get_staticdata
local old_on_activate = lvae_defs.on_activate
--local old_on_step = lvae_defs.on_step
local old_set_node = lvae_defs.set_node

function lvae_defs.get_staticdata(self)
	-- Migrate entities created by older builds whose node metadata still held
	-- ItemStack userdata. Without this pass a normal shutdown can crash while
	-- serializing the vehicle and make it disappear.
	for _, node in pairs(self.data or {}) do
		if node.meta then node.meta = sanitize_meta_table(node.meta) end
	end
	local tanks = table.copy(self.tanks or {})
    for _, t in ipairs(tanks or {}) do
        local detached = t[2] and minetest.get_inventory({type="detached", name=t[2]})
        if detached then t[2] = detached:get_lists() else t[2] = {} end
        for _, l in pairs(t[2]) do
            for i, item in ipairs(l) do
                l[i] = item:to_string()
            end
        end
    end
	return minetest.serialize({old_get_staticdata(self), self.player, self.power, tanks, self.collisionbox, self.ship_owner, self.ship_invited, self.seat_offset})
end

function lvae_defs.on_activate(self, staticdata, dtime)
    if staticdata and staticdata ~= "" and not tonumber(staticdata) then
        local decoded = minetest.deserialize(staticdata)
        if type(decoded) == "table" then
			staticdata, self.player, self.power, self.tanks, self.collisionbox, self.ship_owner, self.ship_invited, self.seat_offset = unpack(decoded)
        end
        self.collisionbox = self.collisionbox or {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
        self.object:set_properties({physical=true, collisionbox=self.collisionbox})
        self.tanks = self.tanks or {}
        for _, t in ipairs(self.tanks) do
            if type(t) ~= "table" then break end
            if type(t[2]) == "table" then
                minetest.create_detached_inventory("spaceship_inv"..inv_count, {}):set_lists(t[2])
                t[2] = "spaceship_inv"..inv_count
            else
                minetest.create_detached_inventory(t[2], {})
            end
        end
    end
    return old_on_activate(self, staticdata, dtime)
end

-- LVAE entities are positioned at the point used to detach the ship, which
-- is not necessarily the seat.  Keep a player aligned to the actual seat
-- node and add half a node of height so their feet rest on its top surface.
local function find_seat_attach_offset(vehicle)
	if not vehicle.camera_distance then
		local box = vehicle.collisionbox or {-1,-1,-1,1,1,1}
		vehicle.camera_distance = math.max(24, math.min(96, math.max(box[4]-box[1], box[5]-box[2], box[6]-box[3]) * 2.5))
	end
	if vehicle.seat_offset then return vehicle.seat_offset end
	for _, node in pairs(vehicle.data or {}) do
		if node.entity and minetest.get_item_group(node.name, "seat") > 0 then
			local p = node.entity.pos or {x = 0, y = 0, z = 0}
			-- Player attachment positions are centred on the player body.  The
			-- seat's top is one node above its origin, not half a node.
			-- The seat collision top is only about 0.25 nodes above its origin;
			-- +1.0 put the player's head into the roof block.
			vehicle.seat_offset = vector.multiply({x = p.x, y = p.y + 0.3, z = p.z}, 10)
			return vehicle.seat_offset
		end
	end
	return {x = 0, y = 5, z = 0}
end

local function attach_player_to_vehicle(player, vehicle)
	if not player or not vehicle or not vehicle.object or not vehicle.object:is_valid() then return false end
	local pname = player:get_player_name()
	if not vehicle._stellua_camera_saved then
		vehicle._stellua_camera_saved = {}
		local old = player.get_eye_offset and player:get_eye_offset() or nil
		vehicle._stellua_camera_saved[pname] = old
	end
	player:set_attach(vehicle.object, "", find_seat_attach_offset(vehicle), {x = 0, y = 0, z = 0}, true)
	-- Keep the pilot's view outside the vehicle in third person.  The previous
	-- offset is restored when the pilot exits or lands, so other mounts and
	-- normal walking are unaffected.
	if player.set_eye_offset then
		local distance = math.min(15, vehicle.camera_distance or 15)
		-- Luanti clamps third-person offsets to roughly 15 nodes.  Use the full
		-- legal distance behind the ship and scale the vertical offset with the
		-- hull so the structure, rather than the player's head, is visible.
		player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = math.min(15, distance * 0.5), z = -distance})
	end
	return true
end

local function restore_vehicle_camera(player, vehicle)
	if not player or not player.set_eye_offset then return end
	local saved = vehicle and vehicle._stellua_camera_saved
	local old = saved and saved[player:get_player_name()]
	if old and old.offset_first and old.offset_third then
		player:set_eye_offset(old.offset_first, old.offset_third)
	else
		player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
	end
	if saved then saved[player:get_player_name()] = nil end
end

local function force_player_exit(player, vehicle)
	if not player then return end
	player:set_detach()
	restore_vehicle_camera(player, vehicle)
	player:set_velocity({x = 0, y = 0, z = 0})
	player:set_properties({physical = true})
	if player.set_physics_override then
		player:set_physics_override({speed = 1, jump = 1, gravity = 1, sneak = true})
	end
end

function lvae_defs.on_step(self, dtime)
	local player = self.player and minetest.get_player_by_name(self.player)
	if player and player:is_player() and self.object:is_valid() and not player:get_attach() then
		attach_player_to_vehicle(player, self)
	end
    --return old_on_step(self, dtime)
end

function lvae_defs.set_node(self, pos, node)
    old_set_node(self, pos, node)
    local new = self.data[self.area:indexp(pos)]
    if not new or not new.entity then return end
    new.entity.object:set_properties({infotext=""})
end

--Override placing and digging functions, we don't want that
local lvae_node_defs = minetest.registered_entities["lvae:node"]
lvae_node_defs.on_rightclick = nil
lvae_node_defs.on_punch = nil

local UP = vector.new(0, 1, 0)
local NORTH = vector.new(0, 0, -1)

-- Re-entry after a reconnect: the visible LVAE child nodes are the part of
-- the ship the player can actually point at. Route their right-click to the
-- owning LVAE instead of treating them as inert display entities.
lvae_node_defs.on_rightclick = function(self, clicker)
	if not clicker or not clicker:is_player() or clicker:get_attach() then return end
	local vehicle = self.parent
	if not vehicle or not vehicle.object or not vehicle.object:is_valid() then return end
	local name = clicker:get_player_name()
	local invited_ok = false
	for _, invited_name in ipairs(vehicle.ship_invited or {}) do
		if invited_name == name then invited_ok = true break end
	end
	if vehicle.ship_owner ~= name and not invited_ok
		and not minetest.check_player_privs(name, {protection_bypass = true}) then
		minetest.chat_send_player(name, "Only the ship owner or an invited crew member can enter this ship.")
		return
	end
	vehicle.player = name
	attach_player_to_vehicle(clicker, vehicle)
	minetest.chat_send_player(name, "Ship control restored. Press E to exit safely.")
end

-- The converter can opt ordinary connected blocks into a ship without
-- changing their visual node type.  Keep this marker deliberately local to
-- stl_vehicles so unrelated metadata cannot make terrain assemble as a ship.
local function is_ship_node(pos, name)
	name = name or minetest.get_node(pos).name
	return minetest.get_item_group(name, "spaceship") > 0
		or minetest.get_meta(pos):get_int("stl_vehicles:converted") == 1
end

--Assemble a vehicle from any node
function stellua.assemble_vehicle(pos, find_interior)
    --go down until we find the floor
    local orig_pos = vector.copy(pos)
    if find_interior then
        local attempts = 0
        while not is_ship_node(pos) and attempts < 64 do
            pos = pos-UP
            attempts = attempts+1
        end
        if attempts >= 64 then return end
    end

    --setup
    local checking = {pos}
    local checked = {minetest.hash_node_position(pos)}
    local out = {}
    local out_hash = {}
    local seat
    local engines = {}
    local tanks = {}
    local power = 0
    local minp, maxp = vector.copy(pos), vector.copy(pos)

    --first pass: find the walls
    while #checking > 0 and #out < 10000 do
        local p = table.remove(checking, 1)
        local nodename = minetest.get_node(p).name
		local s = minetest.get_item_group(nodename, "spaceship")
		if s > 0 or minetest.get_meta(p):get_int("stl_vehicles:converted") == 1 then
			-- Converted blocks behave as structural (propagating) blocks.  Native
			-- rocket nodes retain their special non-propagating group value.
			if s == 0 then s = 1 end
            table.insert(out, p)
            table.insert(out_hash, minetest.hash_node_position(p))
            if find_interior then
                for _, c in ipairs({"x", "y", "z"}) do
                    if p[c] < minp[c] then minp[c] = p[c] end
                    if p[c] > maxp[c] then maxp[c] = p[c] end
                end
            end
            if s == 1 then
                for i = 0, 5 do
                    local newp = p+minetest.wallmounted_to_dir(i)
                    local hash = minetest.hash_node_position(newp)
                    if table.indexof(checked, hash) <= 0 then
                        table.insert(checking, newp)
                        table.insert(checked, hash)
                    end
                end
            end
            if minetest.get_item_group(nodename, "seat") > 0 then
                if seat and seat ~= p then return else seat = p end
            end
            if minetest.get_item_group(nodename, "tank") > 0 then
                table.insert(tanks, p)
            end
            local engine_power = minetest.get_item_group(nodename, "engine")
            if engine_power > 0 then
                table.insert(engines, p)
                power = power+engine_power
            end
        end
    end

    if #out >= 10000 or not seat then return end

    --second pass: find all interiors
    if find_interior then
        local wall_hash = table.copy(out_hash)
        for x = minp.x+1, maxp.x-1 do
            for y = minp.y+1, maxp.y-1 do
                for z = minp.z+1, maxp.z-1 do
                    local p = vector.new(x, y, z)
                    if table.indexof(out_hash, minetest.hash_node_position(p)) <= 0 then
                        local checking2 = {p}
                        local checked2 = {minetest.hash_node_position(p)}
                        local interior = {}
                        local interior_hash = {}
                        while #checking2 > 0 and #interior < 100 do
                            local q = table.remove(checking2, 1)
                            local q_hash = minetest.hash_node_position(q)
                            if table.indexof(wall_hash, q_hash) <= 0 then
                                table.insert(interior, q)
                                table.insert(interior_hash, q_hash)
                                for i = 0, 5 do
                                    local newp = q+minetest.wallmounted_to_dir(i)
                                    local hash = minetest.hash_node_position(newp)
                                    if table.indexof(checked2, hash) <= 0 then
                                        table.insert(checking2, newp)
                                        table.insert(checked2, hash)
                                    end
                                end
                            end
                        end
                        if #interior < 100 then table.insert_all(out, interior) end
                        table.insert_all(out_hash, interior_hash)
                    end
                end
            end
        end
    end

    if table.indexof(out_hash, minetest.hash_node_position(orig_pos)) <= 0 then return end

    return out, seat, engines, power, tanks
end

local function access_list(meta)
    local list = minetest.deserialize(meta:get_string("stl_vehicles:ship_invited"))
    return type(list) == "table" and list or {}
end

local function list_has(list, name)
    for _, value in ipairs(list) do
        if value == name then return true end
    end
    return false
end

-- Ownership is stored on the seat node, which is stable while the ship is
-- built, and copied to the LVAE while it is flying.
function stellua.get_ship_access(pos)
    local _, seat = stellua.assemble_vehicle(vector.round(pos), true)
    if not seat then return nil end
    local meta = minetest.get_meta(seat)
    return seat, meta:get_string("stl_vehicles:ship_owner"), access_list(meta)
end

function stellua.set_ship_owner(pos, owner)
    local seat = select(2, stellua.assemble_vehicle(vector.round(pos), true))
    if not seat then return false end
    minetest.get_meta(seat):set_string("stl_vehicles:ship_owner", owner or "")
    return true
end

-- A ship is a single player-owned structure, not a collection of ordinary
-- blocks. Protect every connected spaceship node from being dug by anyone
-- except the owner. Invitations grant entry/piloting only, never demolition.
minetest.register_on_mods_loaded(function()
    local base_is_protected = minetest.is_protected
	local function node_owner(pos)
		local direct = minetest.get_meta(pos):get_string("stl_vehicles:ship_owner")
		if direct ~= "" then return direct end
		local ship, seat = stellua.assemble_vehicle(pos, true)
		if ship and seat then
			return minetest.get_meta(seat):get_string("stl_vehicles:ship_owner")
		end
		return ""
	end
	local function adjacent_ship_owner(pos)
		for _, dir in ipairs({
			{x=1,y=0,z=0}, {x=-1,y=0,z=0}, {x=0,y=1,z=0},
			{x=0,y=-1,z=0}, {x=0,y=0,z=1}, {x=0,y=0,z=-1},
		}) do
			local p = vector.add(pos, dir)
			local n = minetest.get_node(p)
			if minetest.get_item_group(n.name, "spaceship") > 0
				or minetest.get_meta(p):get_int("stl_vehicles:converted") == 1 then
				local owner = node_owner(p)
				if owner ~= "" then return owner end
			end
		end
		return ""
	end

    -- Protection is checked by the engine before node-specific can_dig hooks,
    -- and several area tools use this path directly. Keep this wrapper here,
    -- before Claimer's wrapper is installed, so Claimer can still remain the
    -- authoritative outer protection layer for claimed areas.
    minetest.is_protected = function(pos, player_name)
        local node = minetest.get_node(pos)
        if minetest.get_item_group(node.name, "spaceship") > 0
            or minetest.get_meta(pos):get_int("stl_vehicles:converted") == 1 then
            local owner = node_owner(pos)
            if owner == "" or owner ~= (player_name or "") then
                return true
            end
		elseif adjacent_ship_owner(pos) ~= ""
			and adjacent_ship_owner(pos) == (player_name or "") then
			-- The owner may extend and repair their ship into adjacent space.
			return false
        end
        return base_is_protected(pos, player_name)
    end

    for name, def in pairs(minetest.registered_nodes) do
        if minetest.get_item_group(name, "spaceship") > 0
            and name ~= "stl_vehicles:air" then
            local old_can_dig = def.can_dig
            def.can_dig = function(pos, digger)
                local node = minetest.get_node(pos)
                if minetest.get_item_group(node.name, "spaceship") > 0
                    or minetest.get_meta(pos):get_int("stl_vehicles:converted") == 1 then
                    local owner = node_owner(pos)
                    local player_name = digger and digger:is_player()
                        and digger:get_player_name() or ""
                    if owner == "" or player_name ~= owner then
                        if player_name ~= "" then
                            minetest.chat_send_player(player_name,
                                "You cannot break another player's ship. Only its owner can dismantle it.")
                        end
                        return false
                    end
                end
                return old_can_dig and old_can_dig(pos, digger) or true
            end
        end
    end
end)

--Fake air for vehicles so they preserve position of air
minetest.register_node("stl_vehicles:air", {
    description = "Vehicle Air",
    drawtype = "airlike",
    walkable = false,
    pointable = false,
    buildable_to = true,
    paramtype = "light",
    sunlight_propagates = true,
    groups = {not_in_creative_inventory=1}
})

--Detach a vehicle and return the LVAE
function stellua.detach_vehicle(pos)
    local minp, maxp
    local ship, seat, engines, power, tanks = stellua.assemble_vehicle(vector.round(pos), true)
    if not ship or not seat then return nil end
    local lvae = LVAE(pos)
    lvae.power = power
	lvae.seat_offset = vector.multiply({
		x = seat.x - pos.x,
		y = seat.y - pos.y + 1.0,
		z = seat.z - pos.z,
	}, 10)
    local owner, invited
    local seat_meta = minetest.get_meta(seat)
    owner = seat_meta:get_string("stl_vehicles:ship_owner")
    invited = access_list(seat_meta)
    lvae.ship_owner = owner ~= "" and owner or nil
    lvae.ship_invited = invited
    lvae.tanks = {}
    for _, p in ipairs(tanks or {}) do
        local inv = minetest.create_detached_inventory("spaceship_inv"..inv_count, {})
        local meta = minetest.get_meta(p)
        inv:set_lists(meta:get_inventory():get_lists())
        table.insert(lvae.tanks, {p-pos, "spaceship_inv"..inv_count, meta:get_float("fuel"), meta:get_string("fuel_group")})
        inv_count = inv_count+1
    end
	for _, p in ipairs(ship or {}) do
		local node = minetest.get_node(p)
		-- Preserve node metadata (including auto-conversion markers, Ship Home
		-- ownership and inventories) while the ship is represented by an LVAE.
		node.meta = serializable_node_meta(minetest.get_meta(p))
		if node.name == "air" then
            lvae:set_node(p-pos, {name="stl_vehicles:air"})
        else
            lvae:set_node(p-pos, node)
            minetest.remove_node(p)
        end
        if not minp then minp = table.copy(p) else
            for _, d in ipairs({"x", "y", "z"}) do
                if p[d] < minp[d] then minp[d] = p[d] end
            end
        end
        if not maxp then maxp = table.copy(p) else
            for _, d in ipairs({"x", "y", "z"}) do
                if p[d] > maxp[d] then maxp[d] = p[d] end
            end
        end
    end
    minp, maxp = minp-pos, maxp-pos
    lvae.collisionbox = {minp.x-0.5, minp.y-0.5, minp.z-0.5, maxp.x+0.5, maxp.y+0.5, maxp.z+0.5}
    lvae.object:set_properties({physical=true, collisionbox=lvae.collisionbox})
    return lvae
end

--Reattach a vehicle to the node grid and destroy the LVAE
function stellua.land_vehicle(vehicle, pos)
    if not vehicle then return false end
    pos = pos or vehicle:get_pos()
    if vehicle.get_luaentity then vehicle = vehicle:get_luaentity() end
    if not vehicle or type(vehicle.data) ~= "table" then return false end
    local owner = vehicle.ship_owner
    local invited = vehicle.ship_invited or {}
    local landed_seat
    for _, node in pairs(vehicle.data) do
        if node.entity then
            if node.name == "stl_vehicles:air" then
                minetest.remove_node(node.entity.pos)
			else
				minetest.set_node(node.entity.pos+pos, node)
				if node.meta then restore_node_meta(node.entity.pos+pos, node.meta) end
                if minetest.get_item_group(node.name, "seat") > 0 then
                    landed_seat = node.entity.pos + pos
                end
            end
        end
    end
    if landed_seat then
        local meta = minetest.get_meta(landed_seat)
        meta:set_string("stl_vehicles:ship_owner", owner or "")
        meta:set_string("stl_vehicles:ship_invited", minetest.serialize(invited))
    end
    for _, val in ipairs(vehicle.tanks) do
        local p, invname, fuel = unpack(val)
        local meta = minetest.get_meta(pos+p)
        meta:set_float("fuel", fuel)
        meta:set_string("infotext", "Fuel: "..math.ceil(fuel))
        local inv = minetest.get_inventory({type="detached", name=invname})
        if inv then
            meta:get_inventory():set_lists(inv:get_lists())
            minetest.remove_detached_inventory(invname)
        end
    end
    if vehicle.sound then minetest.sound_fade(vehicle.sound, 5, 0) end
    vehicle:remove()
end

--Try to get fuel from the stored data on vehicle fuel tanks
function stellua.get_fuel(tanks, amount, group)
    if type(tanks) ~= "table" or type(amount) ~= "number" or amount < 0 then return false, false end
    if amount == 0 then return true end
    group = group or "fuel"
    local ignite = false
    for _, val in ipairs(tanks) do
        local p, invname, fuel, fuel_group = unpack(val)
        if fuel_group == group then
            if fuel >= amount then val[3] = fuel-amount return true, ignite end
            local inv = minetest.get_inventory({type="detached", name=invname})
            if inv and not inv:is_empty("main") then
                for i, itemstack in ipairs(inv:get_list("main")) do
                    local new_fuel = minetest.get_item_group(itemstack:get_name(), group)
                    local replacement = itemstack:get_definition().fuel_replacement
                    while not itemstack:is_empty() and new_fuel > 0 do
                        ignite = true
                        fuel = fuel+new_fuel
                        itemstack:take_item()
                        inv:set_stack("main", i, itemstack)
                        if replacement then inv:add_item("main", ItemStack(replacement)) end
                        if fuel >= amount then val[3] = fuel-amount return true, ignite end
                    end
                end
            end
        end
    end
    return false, ignite
end

--Make the player enter vehicles on rightclick
local ship_panels = {}
local ship_panel_entities = {}
local right_clicks = {}

local function can_use_ship(user, pos, entity)
    local name = user:get_player_name()
    local owner = entity and entity.ship_owner or nil
    local invited = entity and entity.ship_invited or nil
    local seat
    if not entity then
        seat, owner, invited = stellua.get_ship_access(pos)
        if not seat then return false, "This ship has no usable seat." end
        invited = invited or {}
    end
    owner = owner or ""
    if owner == "" then
        return false, "This ship has no registered owner and cannot be entered."
    end
    if owner ~= name and not list_has(invited or {}, name) then
        return false, "This ship belongs to "..owner..". Ask them to use /invite_ship "..name.."."
    end
    return true
end

local function is_exact_ship_owner(player_name, entity)
    return type(player_name) == "string" and player_name ~= ""
        and entity and type(entity.ship_owner) == "string"
        and entity.ship_owner ~= "" and entity.ship_owner == player_name
end

local function enter_ship(user, pos)
    if not user or not user:is_player() or user:get_attach() then return false end
    local allowed, reason = can_use_ship(user, pos)
    if not allowed then
        minetest.chat_send_player(user:get_player_name(), reason)
        return false
    end
    -- Ground entry must remain node-based.  Stellua's original implementation
    -- places the player directly on the connected seat and only detaches the
    -- vehicle when jump is pressed.  Detaching on right-click makes the LVAE
    -- origin become the player's position, which can put them inside the hull.
    local seat = select(1, stellua.get_ship_access(pos))
    if not seat then
        minetest.chat_send_player(user:get_player_name(), "Ship entry failed: no connected seat found.")
        return false
    end
	-- Put the player's feet just above the seat node, not at its origin. This
	-- avoids spawning the head inside the roof block and keeps the seat usable.
	user:set_pos(vector.add(seat, {x = 0, y = 0.3, z = 0}))
    minetest.sound_play({name="doors_steel_door_close", gain=0.2}, {pos=seat}, true)
    minetest.chat_send_player(user:get_player_name(), "You are on the ship seat. Press Space to take control and launch.")
    return true
end

-- Re-enter a detached/flying ship.  If a player presses E while the vehicle
-- is moving, the LVAE no longer has blocks on the map, so the normal node
-- right-click path cannot find a seat.  The owner can safely reclaim the
-- nearest live LVAE without breaking or duplicating the ship.
minetest.register_chatcommand("ship_reenter", {
    description = "Re-enter your nearby flying ship",
    func = function(name)
        local user = minetest.get_player_by_name(name)
        if not user then return false, "Player not found" end
        if user:get_attach() then return false, "You are already attached to a vehicle." end
        local best, best_distance
        for _, object in ipairs(minetest.get_objects_inside_radius(user:get_pos(), 128)) do
            local ent = object:get_luaentity()
			if ent and ent.name == "lvae:lvae" and ent.object:is_valid()
				and is_exact_ship_owner(name, ent)
				and (not ent.player or ent.player == name) then
                local distance = vector.distance(user:get_pos(), object:get_pos())
                if not best_distance or distance < best_distance then
                    best, best_distance = ent, distance
                end
            end
        end
        if not best then
            return false, "No reclaimable ship found within 128 blocks."
        end
        best.player = name
		attach_player_to_vehicle(user, best)
        minetest.chat_send_player(name, "Ship control restored. Press E to exit safely.")
        return true, "Re-entered ship."
    end,
})

minetest.register_chatcommand("invite_ship", {
    params = "<player>",
    description = "Invite a player to enter your ship",
    func = function(name, param)
        local target = (param or ""):match("^%s*(%S+)%s*$")
        if not target then return false, "Usage: /invite_ship <player>" end
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Player not found" end
        local attached = player:get_attach()
        local entity = attached and attached:is_valid() and attached:get_luaentity()
        local seat, owner, invited
        if entity and entity.name == "lvae:lvae" then
            owner, invited = entity.ship_owner or "", entity.ship_invited or {}
        else
            local _, nearby = stellua.assemble_vehicle(vector.round(player:get_pos()), true)
            if not nearby then return false, "Pilot your ship or stand beside it first." end
            seat, owner, invited = stellua.get_ship_access(nearby)
        end
        if owner == "" then return false, "This ship has no registered owner." end
        if owner ~= name then return false, "Only the ship owner can invite players." end
        if not list_has(invited or {}, target) then table.insert(invited, target) end
        if entity and entity.name == "lvae:lvae" then
            entity.ship_owner, entity.ship_invited = owner, invited
        else
            minetest.get_meta(seat):set_string("stl_vehicles:ship_owner", owner)
            minetest.get_meta(seat):set_string("stl_vehicles:ship_invited", minetest.serialize(invited))
        end
        return true, "Invited "..target.." to your ship."
end,
})

minetest.register_chatcommand("revoke_ship", {
    params = "<player>",
    description = "Revoke a player's invitation to your ship",
    func = function(name, param)
        local target = (param or ""):match("^%s*(%S+)%s*$")
        if not target then return false, "Usage: /revoke_ship <player>" end
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Player not found" end
        local attached = player:get_attach()
        local entity = attached and attached:is_valid() and attached:get_luaentity()
        local seat, owner, invited
        if entity and entity.name == "lvae:lvae" then
            owner, invited = entity.ship_owner or "", entity.ship_invited or {}
        else
            local _, nearby = stellua.assemble_vehicle(vector.round(player:get_pos()), true)
            if not nearby then return false, "Pilot your ship or stand beside it first." end
            seat, owner, invited = stellua.get_ship_access(nearby)
        end
        if owner ~= name then return false, "Only the ship owner can revoke invitations." end
        invited = invited or {}
        for index, value in ipairs(invited) do
            if value == target then
                table.remove(invited, index)
                if entity and entity.name == "lvae:lvae" then
                    entity.ship_invited = invited
                elseif seat then
                    minetest.get_meta(seat):set_string("stl_vehicles:ship_invited", minetest.serialize(invited))
                end
                return true, "Revoked " .. target .. " from your ship."
            end
        end
        return false, target .. " is not invited to your ship."
    end,
})

local function ship_panel_formspec(player, ship_pos)
    local ship, seat, engines, power, tanks = stellua.assemble_vehicle(ship_pos, true)
    if not ship or not seat then return nil end
    local fuel_count = #(tanks or {})
    local pname = player:get_player_name()
    local meta = player:get_meta()
    local assigned = minetest.deserialize(meta:get_string("stl_core:current_ship_pos"))
    local is_current = assigned and type(assigned) == "table"
        and type(assigned.x) == "number" and type(assigned.y) == "number"
        and type(assigned.z) == "number" and vector.distance(assigned, ship_pos) < 2
    local pos_text = minetest.formspec_escape(minetest.pos_to_string(vector.round(ship_pos)))
    return "formspec_version[4]size[8,6]" ..
        "label[0.4,0.35;Ship control panel]" ..
        "label[0.4,0.9;Position: "..pos_text.."]" ..
        "label[0.4,1.35;Engine power: "..tostring(power or 0).."]" ..
        "label[0.4,1.8;Fuel tanks: "..tostring(fuel_count).."]" ..
        "label[0.4,2.25;Seat: "..(seat and "installed" or "missing").."]" ..
        "button[0.5,3.0;3.2,0.9;ship_assign;Assign as current ship]" ..
        "button[4.1,3.0;3.2,0.9;ship_marker;Show ship waypoint]" ..
        "button_exit[2.7,4.5;2.6,0.9;close;Close]" ..
        "label[0.5,5.5;Current assignment: "..(is_current and "this ship" or "another ship").."]"
end

-- Piloted vehicles are LVAE entities, so their blocks are no longer available
-- to assemble_vehicle().  The pilot can open this equivalent panel directly.
local function ship_panel_entity_formspec(player, object)
    if not object or not object:is_valid() then return nil end
    local ent = object:get_luaentity()
    if not ent or ent.name ~= "lvae:lvae" then return nil end
    local ship_pos = object:get_pos()
    if not ship_pos then return nil end
    local tanks = type(ent.tanks) == "table" and #ent.tanks or 0
    local assigned = minetest.deserialize(player:get_meta():get_string("stl_core:current_ship_pos"))
    local current = assigned and type(assigned) == "table"
        and type(assigned.x) == "number" and vector.distance(assigned, ship_pos) < 2
    return "formspec_version[4]size[8,6]" ..
        "label[0.4,0.35;Ship control panel (piloted)]" ..
        "label[0.4,0.9;Position: "..minetest.formspec_escape(minetest.pos_to_string(vector.round(ship_pos))).."]" ..
        "label[0.4,1.35;Engine power: "..tostring(tonumber(ent.power) or 0).."]" ..
        "label[0.4,1.8;Fuel tanks: "..tostring(tanks).."]" ..
        "label[0.4,2.25;Seat: installed]" ..
        "button[0.5,3.0;3.2,0.9;ship_assign;Assign as current ship]" ..
        "button[4.1,3.0;3.2,0.9;ship_marker;Show ship waypoint]" ..
        "button_exit[2.7,4.5;2.6,0.9;close;Close]" ..
        "label[0.5,5.5;Current assignment: "..(current and "this ship" or "another ship").."]"
end

local function show_piloted_ship_panel(user)
    local attached = user and user:get_attach()
    if not attached or not attached:is_valid() then return false end
    local form = ship_panel_entity_formspec(user, attached)
    if not form then return false end
    local name = user:get_player_name()
    ship_panel_entities[name] = attached
    ship_panels[name] = nil
    minetest.show_formspec(name, "stl_vehicles:ship_panel", form)
    return true
end

minetest.register_on_mods_loaded(function()
    for name, defs in pairs(minetest.registered_nodes) do
        if minetest.get_item_group(name, "spaceship") > 0 then
            local on_rightclick = defs.on_rightclick
            minetest.override_item(name, {on_rightclick = function (pos, node, user, itemstack, pointed)
                if user and user:is_player() then
                    local pname = user:get_player_name()
                    local now = minetest.get_us_time() * 0.000001
                    local previous = right_clicks[pname]
                    if previous and now - previous.time <= 0.55
                    and vector.distance(previous.pos, pos) <= 2 then
                        right_clicks[pname] = nil
                        if enter_ship(user, pos) then return itemstack end
                    else
                        right_clicks[pname] = {time=now, pos=vector.round(pos)}
                    end
                end
                if on_rightclick then on_rightclick(pos, node, user, itemstack, pointed) end
            end})
        end
    end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "stl_vehicles:ship_panel" or not player or not player:is_player() then return end
    local name = player:get_player_name()
    if fields.quit then
        ship_panels[name] = nil
        ship_panel_entities[name] = nil
        return
    end
    local live_entity = ship_panel_entities[name]
    if live_entity and live_entity:is_valid() then
        if fields.ship_assign or fields.ship_marker then
            local pos = live_entity:get_pos()
            if not pos then
                minetest.chat_send_player(name, "The piloted ship is no longer available.")
                return
            end
            local meta = player:get_meta()
            meta:set_string("stl_core:current_ship_pos", minetest.serialize(vector.round(pos)))
            meta:set_string("stl_core:ship_marker_mode", "current")
            minetest.chat_send_player(name, fields.ship_assign and "Current ship assigned." or "Ship waypoint enabled.")
            minetest.close_formspec(name, formname)
        end
        return
    end
    local ship_pos = ship_panels[name]
    if not ship_pos then return end
    if fields.ship_assign or fields.ship_marker then
        local ship, seat = stellua.assemble_vehicle(ship_pos, true)
        if not ship or not seat then
            minetest.chat_send_player(name, "This ship is no longer complete.")
            return
        end
        local meta = player:get_meta()
        meta:set_string("stl_core:current_ship_pos", minetest.serialize(vector.round(ship_pos)))
        meta:set_string("stl_core:ship_marker_mode", "current")
        if fields.ship_assign then
            minetest.chat_send_player(name, "Current ship assigned.")
        else
            minetest.chat_send_player(name, "Ship waypoint enabled.")
        end
        minetest.close_formspec(name, formname)
    end
end)

minetest.register_chatcommand("ship_panel", {
    description = "Open the panel for the nearby or piloted ship",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Player not found" end
        local pos
        local attached = player:get_attach()
        if attached and attached:is_valid() then
            local live_form = ship_panel_entity_formspec(player, attached)
            if live_form then
                ship_panel_entities[name] = attached
                ship_panels[name] = nil
                minetest.show_formspec(name, "stl_vehicles:ship_panel", live_form)
                return true, "Ship panel opened"
            end
            pos = attached:get_pos()
        else
            local _, seat = stellua.assemble_vehicle(vector.round(player:get_pos()), true)
            pos = seat
        end
        if not pos then return false, "No complete ship found nearby" end
        local form = ship_panel_formspec(player, pos)
        if not form then return false, "The ship panel could not be created" end
        ship_panels[name] = vector.round(pos)
        minetest.show_formspec(name, "stl_vehicles:ship_panel", form)
        return true, "Ship panel opened"
    end,
})

minetest.register_on_leaveplayer(function(player)
    ship_panels[player:get_player_name()] = nil
    ship_panel_entities[player:get_player_name()] = nil
    right_clicks[player:get_player_name()] = nil
end)

--Detect if vehicle is on ground
local function on_ground(self, pos)
    pos = pos or vector.round(self.object:get_pos())
    local y = pos.y+math.round(self.collisionbox[2]-0.5)
    for x = pos.x+math.round(self.collisionbox[1]-0.5), pos.x+math.round(self.collisionbox[4]+0.5) do
        for z = pos.z+math.round(self.collisionbox[3]-0.5), pos.z+math.round(self.collisionbox[6]+0.5) do
			local def = minetest.registered_nodes[minetest.get_node(vector.new(x, y, z)).name]
			if def and def.walkable then return true end
        end
    end
    return false
end

local ACCEL = 0.5
local FRICT = 0.2

local aux1s = {}
local orbit_slots = {}

local function save_current_ship_position(player, pos)
	if not player or not pos then return end
	local meta = player:get_meta()
	meta:set_string("stl_core:current_ship_pos", minetest.serialize(vector.round(pos)))
	if meta:get_string("stl_core:ship_marker_mode") ~= "starter" then
		meta:set_string("stl_core:ship_marker_mode", "current")
	end
end

minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		local pos = vector.round(player:get_pos())
		local index = stellua.get_planet_index(pos.y)
		local control = player:get_player_control()
		local playername = player:get_player_name()
		local attached_vehicle = player:get_attach()

        local aux1 = control.aux1 and not aux1s[playername]
        aux1s[playername] = control.aux1

		-- Once detached, never scan the whole node-built ship again while the
		-- player is driving it. That scan is only needed to enter/launch/exit.
		if not attached_vehicle and (aux1 or control.jump) and stellua.assemble_vehicle(pos, true) then

            --make player exit on aux1
            if aux1 then
                --move forward until out of the vehicle
                local dir = player:get_look_dir()
                while stellua.assemble_vehicle(pos, true) do
                    pos = vector.round(pos+dir)
                end

                local attempts = 0

                --go up until there's space
                while (minetest.registered_nodes[minetest.get_node(pos).name].walkable
                or minetest.registered_nodes[minetest.get_node(pos+UP).name].walkable) and attempts < 8 do
                    pos = pos+UP
                    attempts = attempts+1
                end

                --if in outer space, skip placement
                if index then
                    --go down until there's something to stand on
                    while not minetest.registered_nodes[minetest.get_node(pos).name].walkable and attempts < 8 do
                        pos = pos-UP
                        attempts = attempts+1
                    end
                else pos = pos-UP end

                --if we could find a valid position then do it
                if attempts < 8 then
                    player:set_pos(pos+0.5*UP)
                    minetest.sound_play({name="doors_steel_door_close", gain=0.2}, {pos=pos}, true)
                end

			--make vehicle launch on jump
			elseif control.jump and (index or (pos.y > -1000 and pos.y < 1000)) and minetest.get_item_group(minetest.get_node(pos).name, "seat") > 0 then
				local allowed, reason = can_use_ship(player, pos)
				if not allowed then
					minetest.chat_send_player(playername, reason)
				else
					local ent = stellua.detach_vehicle(pos)
					if ent and ent.object and ent.object:is_valid() then
						attach_player_to_vehicle(player, ent)
						ent.player = playername
					else
						minetest.chat_send_player(playername, "Ship launch failed: the vehicle is incomplete or busy.")
					end
					minetest.sound_play({name="doors_door_close", gain=0.3}, {pos=pos}, true)
				end
            end
        end

        --allow player to control vehicle
		local vehicle = attached_vehicle or player:get_attach()
		if vehicle then
			local ent = vehicle:get_luaentity()
			if not ent or ent.name ~= "lvae:lvae" then
				vehicle = nil
			end
			local transferring = false
		if vehicle then
			local y = vehicle:get_pos().y
			local rel_y = (y-500)%1000
			local vehicle_entity = vehicle:get_luaentity()
			if vehicle_entity and vehicle_entity.ship_owner == playername then
				save_current_ship_position(player, vehicle:get_pos())
			end

            --land vehicle with aux1
            if aux1 and on_ground(ent, pos) then
				force_player_exit(player, ent)
                player:set_pos(vector.round(pos))
                minetest.sound_play({name="doors_door_close", gain=0.3}, {pos=vehicle:get_pos()}, true)
                stellua.land_vehicle(vehicle)
                save_current_ship_position(player, pos)
                stellua.set_respawn(player, pos)

            else
                -- E/aux1 is also the explicit exit action while airborne or
                -- in orbit. Never leave the player attached to a removed
                -- vehicle entity.
                if aux1 then
					force_player_exit(player, ent)
                    ent.player = nil
                    local exit_pos = vector.round(pos + player:get_look_dir() * 2)
                    local tries = 0
                    while tries < 8 and stellua.assemble_vehicle(exit_pos, true) do
                        exit_pos = exit_pos + UP
                        tries = tries + 1
                    end
                    player:set_pos(exit_pos + 0.5 * UP)
                    minetest.chat_send_player(playername, "Exited ship. Re-enter it and use /ship_panel while piloting to open the panel.")
                    transferring = true
                end
                -- Asuna is the hybrid homeworld. A rocket launched from its
                -- surface enters the same orbital slot system as a planet.
				if not index and y >= 240 and y < stellua.hybrid_space_min then
					local slot = stellua.alloc_slot(playername, 1, vector.zero(), vector.zero())
					local slotpos = stellua.get_slot_pos(slot)
					if orbit_slots[playername] ~= slot then
						orbit_slots[playername] = slot
						minetest.emerge_area(slotpos, slotpos)
					end
						player:set_pos(slotpos)
						force_player_exit(player, ent)
						stellua.land_vehicle(ent, slotpos)
						save_current_ship_position(player, slotpos)
					stellua.set_respawn(player, slotpos)
					transferring = true
				end

                --load up slot if above y=200
				if not transferring and index and rel_y >= 700 then
					local planet = stellua.planets[index]
					local rot = (minetest.get_timeofday()+0.5)*2*math.pi
					local slot = stellua.alloc_slot(playername, planet.star, planet.pos+0.15*planet.scale*vector.rotate_around_axis(UP, NORTH, -rot), vector.dir_to_rotation(vector.rotate_around_axis(UP, NORTH, rot)))
					local slotpos = stellua.get_slot_pos(slot)
					if orbit_slots[playername] ~= slot then
						orbit_slots[playername] = slot
						minetest.emerge_area(slotpos, slotpos)
					end

                    --move to slot if above y=250
                    if rel_y >= 750 then
						player:set_pos(slotpos)
						force_player_exit(player, ent)
						stellua.land_vehicle(ent, slotpos)
						save_current_ship_position(player, slotpos)
						stellua.set_respawn(player, slotpos)
						transferring = true
					end
				end

				if not transferring and rel_y < 750 then
                    local vel = vehicle:get_velocity()
                    local power = vehicle:get_luaentity().power

                    --handle launching
                    local launch = control.jump and control.sneak
                    if launch then
                        local fuel, ignite = stellua.get_fuel(vehicle:get_luaentity().tanks, dtime*power)
                        if ignite then minetest.sound_play({name="fire_flint_and_steel", gain=0.2}, {object=vehicle}, true) end
                        if fuel or minetest.is_creative_enabled(playername) then vel.y = vel.y+ACCEL+power*0.1 else launch = false end
                    end
                    if not launch then
                        if control.jump and rel_y < 650 then vel.y = vel.y+ACCEL
                        elseif control.sneak then vel.y = vel.y-ACCEL end
                    end

                    --handle other controls
                    local rot = vector.new(0, player:get_look_horizontal(), 0)
                    if control.up then vel = vel+vector.rotate(vector.new(0, 0, ACCEL), rot) end
                    if control.down then vel = vel-vector.rotate(vector.new(0, 0, ACCEL), rot) end
                    if control.left then vel = vel-vector.rotate(vector.new(ACCEL, 0, 0), rot) end
                    if control.right then vel = vel+vector.rotate(vector.new(ACCEL, 0, 0), rot) end

                    --calculate velocity and apply
                    local xvel = vector.normalize(vector.new(vel.x, 0, vel.z))*math.min(math.max(math.hypot(vel.x, vel.z)-FRICT, 0), 8)
                    local yvel = vector.new(0, math.min(math.max(math.max(math.abs(vel.y)-FRICT, 0)*math.sign(vel.y), -8), 4+(launch and power or 0)), 0)
                    vehicle:set_velocity(xvel+yvel)
                    vehicle:set_rotation(rot)

                    --deal with sounds
                    if launch and ent.launch ~= true then
                        ent.launch = true
                        if ent.sound then minetest.sound_fade(ent.sound, 5, 0) end
                        ent.sound = minetest.sound_play({name="534856__m_cel__jet-engine", gain=0.5}, {loop=true, object=vehicle, fade=5})
                    elseif ent.launch ~= false and not launch then
                        ent.launch = false
                        if ent.sound then minetest.sound_fade(ent.sound, 5, 0) end
                        ent.sound = minetest.sound_play({name="242740__marlonhj__engine", gain=0.1}, {loop=true, object=vehicle, fade=5})
                    end
				end
			end
		end
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	aux1s[name] = nil
	orbit_slots[name] = nil
end)
