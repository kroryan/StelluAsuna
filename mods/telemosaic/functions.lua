local S = minetest.get_translator("telemosaic")

-- Keeps a track of players to prevent teleport spamming
local recent_teleports = {}


-- Not the same as `minetest.hash_node_position` and `minetest.get_position_from_hash`
local function hash_pos(pos)
	return math.floor(pos.x + 0.5)..':'..
		math.floor(pos.y + 0.5)..':'..
		math.floor(pos.z + 0.5)
end

local function unhash_pos(hash)
	local list = string.split(hash, ':')
	local p = {
		x = tonumber(list[1]),
		y = tonumber(list[2]),
		z = tonumber(list[3])
	}
	if p.x and p.y and p.z then
		return p
	end
end


-- Wrap this function to incorporate travel checks from another mod
function telemosaic.travel_allowed(player, src, dest)
	return true
end


function telemosaic.is_protected_beacon(pos, player_name)
	local node_name = minetest.get_node(pos).name
	if node_name:match("^telemosaic:beacon_.*protected$") then
		if minetest.is_protected(pos, player_name) then
			return true
		end
	end
	return false
end

function telemosaic.get_state(pos)
	local node = minetest.get_node(pos)
	local def = minetest.registered_nodes[node.name]

	if not def or not def.groups then return "invalid" end

	if def.groups.telemosaic_off then return "off" end
	if def.groups.telemosaic_active then return "active" end
	if def.groups.telemosaic_disabled then return "disabled" end
	if def.groups.telemosaic_error then return "error" end

	return "invalid"
end

function telemosaic.set_state(pos, state)
	local node = minetest.get_node(pos)

	if not string.match(node.name, "^telemosaic:beacon") then
		return  -- Not a telemosaic!
	end

	local new_name = "telemosaic:beacon"

	if state == "off" then
		new_name = new_name.."_off"
	elseif state == "error" then
		new_name = new_name.."_err"
	elseif state == "disabled" then
		new_name = new_name.."_disabled"
	elseif state ~= "active" then
		return  -- Can't set a state that doesn't exist
	end

	if string.match(node.name, "protected$") then
		new_name = new_name.."_protected"
	end

	-- Swap node instead of set node to keep the metadata
	minetest.swap_node(pos, {name = new_name})
end

function telemosaic.is_valid_destination(pos)
	local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local pos_top = {x = pos.x, y = pos.y + 2, z = pos.z}

	local node = minetest.get_node_or_nil(pos)
	local node_above = minetest.get_node_or_nil(pos_above)
	local node_top = minetest.get_node_or_nil(pos_top)

	if not node or not node_above or not node_top then
		-- Need to load the map
		minetest.get_voxel_manip():read_from_map(pos, pos_top)
		node = node or minetest.get_node(pos)
		node_above = node_above or minetest.get_node(pos_above)
		node_top = node_top or minetest.get_node(pos_top)
	end

	local valid = true

	-- Check if there is a telemosaic at the destination
	if not string.match(node.name, "^telemosaic:beacon") then
		valid = false
	end

	-- Check if the nodes above are not walkable (yes, confusing naming)
	if node_above.name ~= "air" and node_above.name ~= "vacuum:vacuum" then
		local def = minetest.registered_nodes[node_above.name]
		if def and def.walkable then
			return valid, false
		end
	end
	if node_top.name ~= "air" and node_top.name ~= "vacuum:vacuum" then
		local def = minetest.registered_nodes[node_top.name]
		if def and def.walkable then
			return valid, false
		end
	end

	return valid, true
end

function telemosaic.check_beacon(pos, player_name, all_checks)
	local meta = minetest.get_meta(pos)

	local dest = unhash_pos(meta:get_string("telemosaic:dest"))
	local state = telemosaic.get_state(pos)
	if not dest or state == "invalid" then
		return false
	end

	local dist = vector.distance(pos, dest)
	local range = telemosaic.beacon_range

	local pos1 = {x = pos.x - 3, y = pos.y - 1, z = pos.z - 3}
	local pos2 = {x = pos.x + 3, y = pos.y, z = pos.z + 3}
	local _, nodes = minetest.find_nodes_in_area(pos1, pos2, "group:telemosaic_extender")

	for node_name, num in pairs(nodes) do
		range = range + (minetest.get_item_group(node_name, "telemosaic_extender") * num)
	end

	if dist > range then
		-- Destination out of range, set beacon to error state
		telemosaic.set_state(pos, "error")
		if player_name then
			local needed = math.ceil(dist - range)
			minetest.chat_send_player(player_name,
				S("You need to add extenders for @1 node(s).", needed)
			)
		end
		return false
	elseif state == "error" or state == "off" then
		-- Not out of range anymore, set to active
		telemosaic.set_state(pos, "active")
	end

	if not all_checks then
		return true  -- Skip the destination check
	end

	if player_name then
		if telemosaic.is_protected_beacon(dest, player_name) then
			minetest.chat_send_player(player_name,
				S("Destination is protected.")
			)
			return false
		end
	end

	local valid, open = telemosaic.is_valid_destination(dest)
	if not valid then
		if player_name then
			minetest.chat_send_player(player_name,
				S("No telemosaic at destination.")
			)
		end
		return false
	elseif not open then
		if player_name then
			minetest.chat_send_player(player_name,
				S("Destination is blocked.")
			)
		end
		return false
	end

	return true
end

function telemosaic.get_destination(pos)
	local dest_hash = minetest.get_meta(pos):get_string("telemosaic:dest")
	return unhash_pos(dest_hash)
end

function telemosaic.set_destination(pos, dest)
	local dest_hash = hash_pos(dest)
	local src_hash = hash_pos(pos)
	if src_hash == dest_hash or not telemosaic.is_valid_destination(dest) then
		return  -- Don't allow setting invalid destination
	end
	minetest.get_meta(pos):set_string("telemosaic:dest", dest_hash)
	telemosaic.check_beacon(pos)
end

function telemosaic.teleport(player, src, dest)
	local player_name = player:get_player_name()

	-- Prevent teleport spamming
	recent_teleports[player_name] = true
	minetest.after(telemosaic.teleport_delay,
		function(name)
			recent_teleports[name] = nil
		end,
		player_name
	)

	if telemosaic.digilines then
		-- Send a digiline message about the teleport
		local channel = minetest.get_meta(src):get("channel") or telemosaic.default_channel
		digilines.receptor_send(src, digilines.rules.default, channel, {
			player = player_name,
			origin = src,
			target = dest,
			pos = src,
			destination = dest,
		})
	end

	dest.y = dest.y + 0.5  -- Teleport the player to above the telemosaic
	player:set_pos(dest)

	minetest.sound_play({name = "telemosaic_departure", gain = 1}, {pos = src, max_hear_distance = 30})
	minetest.sound_play({name = "telemosaic_arrival", gain = 1}, {pos = dest, max_hear_distance = 30})

	minetest.add_particlespawner({
		amount = 100,
		time = 0.25,
		minpos = {x = src.x, y = src.y + 0.3, z = src.z},
		maxpos = {x = src.x, y = src.y + 2, z = src.z},
		minvel = {x = 1, y = -6, z = 1},
		maxvel = {x = -1, y = -1, z = -1},
		minacc = {x = 0, y = -2, z = 0},
		maxacc = {x = 0, y = -6, z = 0},
		minexptime = 0.1,
		minsize = 0.5,
		maxsize = 1.5,
		texture = "telemosaic_particle_departure.png",
		glow = 15,
	})
	minetest.add_particlespawner({
		amount = 100,
		time = 0.25,
		minpos = {x = dest.x, y = dest.y + 0.3, z = dest.z},
		maxpos = {x = dest.x, y = dest.y + 2, z = dest.z},
		minvel = {x = -1, y = 1, z = -1},
		maxvel = {x = 1, y = 6, z = 1},
		minacc = {x = 0, y = -2, z = 0},
		maxacc = {x = 0, y = -6, z = 0},
		minexptime = 0.1,
		minsize = 0.5,
		maxsize = 1.5,
		texture = "telemosaic_particle_arrival.png",
		glow = 15,
	})
end

function telemosaic.rightclick(pos, node, player, itemstack, pointed_thing)
	if not itemstack or player.is_fake_player or not minetest.is_player(player) then
		return itemstack  -- No fake players!
	end

	local item = itemstack:get_name()
	local player_name = player:get_player_name()
	local state = telemosaic.get_state(pos)

	if item == "default:mese_crystal_fragment" then
		-- Try to create a telemosaic key
		if itemstack:get_count() ~= 1 then
			minetest.chat_send_player(player_name,
				S("You can only use a singular mese crystal fragment to create a telemosaic key.")
			)
		else
			minetest.log("action", "[telemosaic] " .. player_name ..
				" created a key for the telemosaic at "
				.. minetest.pos_to_string(pos))
			return ItemStack({name = "telemosaic:key", metadata = hash_pos(pos)})
		end

	elseif item == "telemosaic:key" then
		-- Try to set a new destination
		local dest_hash = itemstack:get_meta():get_string("")
		local src_hash = hash_pos(pos)
		if dest_hash ~= src_hash and not minetest.is_protected(pos, player_name) then
			local dest = unhash_pos(dest_hash)
			if not dest then
				-- This should never happen, but tell the player if it does
				minetest.chat_send_player(player_name,
					S("Telemosaic key is invalid.")
				)
			elseif not telemosaic.is_valid_destination(dest) then
				-- No point setting a destination that doesn't exist
				minetest.chat_send_player(player_name,
					S("No telemosaic at new destination.")
				)
			else
				-- Everything is good, set the destination and update the telemosaic
				minetest.get_meta(pos):set_string("telemosaic:dest", dest_hash)
				telemosaic.check_beacon(pos, player_name)
				minetest.log("action", "[telemosaic] " .. player_name .. " set the destination pos of the telemosaic at "
					.. minetest.pos_to_string(pos)  .. " to " .. minetest.pos_to_string(dest))
			end
			if player:get_player_control().sneak then
				return itemstack  -- Don't destroy key
			end
			return ItemStack("default:mese_crystal_fragment")
		end

	elseif state == "off" or player:get_player_control().sneak then
		-- Allow player to build on telemosaic
		local def = minetest.registered_nodes[item]
		if def and def.on_place and pointed_thing and not vector.equals(pos, pointed_thing.above) then
			-- Need to create a fake pointed_thing to prevent recursion
			local new_pointed_thing = {
				type = "node",
				under = vector.new(pointed_thing.above),
				above = vector.new(pointed_thing.above)
			}
			return def.on_place(itemstack, player, new_pointed_thing)
		end

	elseif state == "active" and not telemosaic.is_protected_beacon(pos, player_name) then
		if recent_teleports[player_name] then
			return itemstack  -- Prevent teleport spamming, fail silently
		end
		local meta = minetest.get_meta(pos)
		local dest = unhash_pos(meta:get_string("telemosaic:dest"))
		if telemosaic.check_beacon(pos, player_name, true) then
			if telemosaic.travel_allowed(player, pos, dest) then
				-- Teleport the player!
				minetest.log("action", "[telemosaic] teleporting " .. player_name .. " from "
					.. minetest.pos_to_string(pos) .. " to " .. minetest.pos_to_string(dest))
				telemosaic.teleport(player, pos, dest)
			else
				minetest.chat_send_player(player_name,
					S("Travel to destination is not allowed.")
				)
			end
		end

	elseif state == "disabled" then
		-- Tell the player why they can't use this telemosaic
		minetest.chat_send_player(player_name,
			S("Telemosaic is disabled.")
		)

	elseif state == "error" then
		-- Check why the beacon is in error state, and tell the player
		telemosaic.check_beacon(pos, player_name)
	end
	return itemstack
end

function telemosaic.extender_place(pos, player, itemstack, pointed_thing)
	local pos1 = {x = pos.x - 3, y = pos.y, z = pos.z - 3}
	local pos2 = {x = pos.x + 3, y = pos.y + 1, z = pos.z + 3}
	local nodes = minetest.find_nodes_in_area(pos1, pos2, "group:telemosaic_error")

	for _, node_pos in pairs(nodes) do
		-- Update telemosaic, and tell them if they need more extenders
		telemosaic.check_beacon(node_pos, player:get_player_name())
	end
end

function telemosaic.extender_dig(pos, oldnode, oldmetadata, player)
	local pos1 = {x = pos.x - 3, y = pos.y, z = pos.z - 3}
	local pos2 = {x = pos.x + 3, y = pos.y + 1, z = pos.z + 3}
	local nodes = minetest.find_nodes_in_area(pos1, pos2, {"group:telemosaic_active", "group:telemosaic_disabled"})

	for _, node_pos in pairs(nodes) do
		-- Update the telemosaic, but don't tell the player anything, they are probably removing it anyway
		telemosaic.check_beacon(node_pos)
	end
end
