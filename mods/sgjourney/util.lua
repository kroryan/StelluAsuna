local S = sgjourney

function S.pos_key(pos)
	return core.pos_to_string(vector.round(pos))
end

function S.hash_address(pos)
	local raw = math.abs(core.hash_node_position(vector.round(pos)))
	local symbols = {"A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
	local out = {}
	for _ = 1, 7 do
		out[#out + 1] = symbols[(raw % #symbols) + 1]
		raw = math.floor(raw / #symbols)
	end
	return table.concat(out)
end

function S.load_table(key)
	local value = S.storage:get_string(key)
	if value == "" then return {} end
	return core.deserialize(value) or {}
end

function S.save_table(key, value)
	S.storage:set_string(key, core.serialize(value))
end

function S.sound(name, pos, gain)
	core.sound_play("sgjourney_" .. name, {pos = pos, gain = gain or 1, max_hear_distance = 48}, true)
end

function S.can_use(pos, player)
	return player and not core.is_protected(pos, player:get_player_name())
end

function S.find_gate(pos, radius)
	local found = core.find_nodes_in_area(vector.subtract(pos, radius), vector.add(pos, radius), {"group:sgjourney_gate"})
	return found[1]
end

