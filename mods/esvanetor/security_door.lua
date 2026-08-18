-- StelluAsuna Security Door
-- Independent persistent ownership system for security doors.
-- Original code, GPL-3.0-or-later (see LICENSE).

if not doors or not doors.register then
	minetest.log("error", "[esvanetor] Security Door requires the Luanti doors API")
	return
end

local storage = minetest.get_mod_storage()
local security_doors = minetest.deserialize(storage:get_string("security_doors")) or {}
local next_door_id = tonumber(storage:get_string("security_next_id")) or 1

local function save()
	storage:set_string("security_doors", minetest.serialize(security_doors))
	storage:set_string("security_next_id", tostring(next_door_id))
end

local function find_door(id)
	return security_doors[tostring(tonumber(id) or -1)]
end

local function has_access(door, player_name)
	if not door or not player_name or player_name == "" then
		return false
	end
	if door.owner == player_name then
		return true
	end
	for _, invited in ipairs(door.invited or {}) do
		if invited == player_name then
			return true
		end
	end
	return false
end

local function door_id_at(pos)
	local meta = minetest.get_meta(pos)
	local id = meta:get_string("esvanetor:security_door_id")
	if id == "" then
		return nil
	end
	return id, find_door(id)
end

local function assign_door(pos, placer)
	local player_name = placer and placer:get_player_name() or ""
	if player_name == "" then
		return
	end
	local id = tostring(next_door_id)
	next_door_id = next_door_id + 1
	security_doors[id] = {id = id, owner = player_name, invited = {}}
	local meta = minetest.get_meta(pos)
	meta:set_string("esvanetor:security_door_id", id)
	meta:set_string("esvanetor:security_door_owner", player_name)
	meta:set_string("infotext", ("Security Door #%s — %s"):format(id, player_name))
	save()
	minetest.chat_send_player(player_name,
		("Security Door #%s created. Invite with /invite_door %s <player>"):format(id, id))
end

local function remove_door(pos)
	local id = minetest.get_meta(pos):get_string("esvanetor:security_door_id")
	if id ~= "" and security_doors[id] then
		security_doors[id] = nil
		save()
	end
end

local function describe_door(player_name, door)
	local invited = #door.invited > 0 and table.concat(door.invited, ", ") or "none"
	minetest.chat_send_player(player_name,
		("Security Door #%s\nOwner: %s\nInvited: %s"):format(door.id, door.owner, invited))
end

local function security_rightclick(pos, node, clicker, itemstack)
	local player_name = clicker and clicker:get_player_name() or ""
	local id, door = door_id_at(pos)
	if not door then
		minetest.chat_send_player(player_name, "This security door has no valid owner record.")
		return itemstack
	end
	if not has_access(door, player_name) then
		minetest.record_protection_violation(pos, player_name)
		minetest.chat_send_player(player_name,
			("Security Door #%s belongs to %s. Ask the owner to use /invite_door %s %s."):
			format(door.id, door.owner, door.id, player_name))
		return itemstack
	end
	if clicker:get_player_control().sneak then
		describe_door(player_name, door)
		return itemstack
	end
	-- doors.door_toggle handles the four hinged states, hidden upper node,
	-- sounds and collision. The ownership check above is deliberately separate.
	doors.door_toggle(pos, node, clicker)
	return itemstack
end

doors.register("esvanetor:security_door", {
	description = "Security Door (owner controlled)",
	tiles = {{name = "esvanetor_security_door.png", backface_culling = true}},
	inventory_image = "esvanetor_security_door.png",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	gain_open = 0.2,
	gain_close = 0.2,
	on_rightclick = security_rightclick,
	can_dig = function(pos, digger)
		local _, door = door_id_at(pos)
	return door and digger and door.owner == digger:get_player_name()
	end,
	recipe = {
		{"default:steel_ingot", "default:copper_ingot"},
		{"default:steel_ingot", "default:mese_crystal_fragment"},
		{"default:steel_ingot", "default:steel_ingot"},
	},
})

-- doors.register places the lower segment and then emits the normal place hook.
-- Only that segment receives metadata; the upper hidden segment follows it.
minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "esvanetor:security_door_a"
		or newnode.name == "esvanetor:security_door_b" then
		assign_door(pos, placer)
	end
end)

-- Remove the independent record when the owner digs the lower segment. IDs are
-- never reused, so old chat references cannot accidentally target a new door.
minetest.register_on_dignode(function(pos, node, digger)
	if node.name == "esvanetor:security_door_a"
		or node.name == "esvanetor:security_door_b"
		or node.name == "esvanetor:security_door_c"
		or node.name == "esvanetor:security_door_d" then
		remove_door(pos)
	end
end)

local function invite_command(name, param, revoke)
	local id, target = (param or ""):match("^%s*(%d+)%s+(%S+)%s*$")
	local door = id and find_door(id)
	if not door then
		return false, "Security door not found."
	end
	if door.owner ~= name then
		return false, "Only the security door owner can manage invitations."
	end
	if revoke then
		for index, invited in ipairs(door.invited) do
			if invited == target then
				table.remove(door.invited, index)
				save()
				return true, ("Revoked %s from security door #%s."):format(target, id)
			end
		end
		return false, ("%s is not invited to security door #%s."):format(target, id)
	end
	for _, invited in ipairs(door.invited) do
		if invited == target then
			return true, ("%s is already invited to security door #%s."):format(target, id)
		end
	end
	table.insert(door.invited, target)
	save()
	return true, ("Invited %s to security door #%s."):format(target, id)
end

minetest.register_chatcommand("invite_door", {
	params = "<id> <player>",
	description = "Invite a player to use your security door",
	func = function(name, param) return invite_command(name, param, false) end,
})

minetest.register_chatcommand("revoke_door", {
	params = "<id> <player>",
	description = "Revoke a player's access to your security door",
	func = function(name, param) return invite_command(name, param, true) end,
})

