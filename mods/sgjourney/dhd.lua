local S = sgjourney
for _, variant in ipairs({"milky_way", "pegasus", "classic"}) do
	local name = variant .. "_dhd"
	core.register_node("sgjourney:" .. name, {
		description = variant:gsub("_", " "):gsub("^%l", string.upper) .. " DHD",
		tiles = {"sgjourney_block_" .. name .. ".png"}, paramtype2 = "facedir", groups = {cracky = 1},
		sounds = default and default.node_sound_metal_defaults() or nil,
		on_rightclick = function(pos, _, player)
			if not S.can_use(pos, player) then return end
			local gate = S.find_gate(pos, 16)
			if not gate then core.chat_send_player(player:get_player_name(), "[Stargate] No gate within 16 nodes") return end
			local own = core.get_meta(gate):get_string("address")
			local fs = "formspec_version[4]size[9,5]label[0.5,0.5;DHD — local address " .. core.formspec_escape(own) .. "]" ..
				"field[0.5,1.5;8,1;dhd_address;Destination address;]button[0.5,3;3.5,1;dhd_dial;Dial]button[5,3;3.5,1;dhd_close;Close]" ..
				"field_close_on_enter[dhd_address;false]"
			core.show_formspec(player:get_player_name(), "sgjourney:dhd_" .. S.pos_key(gate), fs)
		end,
	})
end

core.register_on_player_receive_fields(function(player, formname, fields)
	local encoded = formname:match("^sgjourney:dhd_(.+)$")
	if not encoded or not fields.dhd_dial then return end
	local gate = core.string_to_pos(encoded)
	if not gate or not S.can_use(gate, player) then return end
	local ok, msg = S.dial(gate, fields.dhd_address or "", player)
	core.chat_send_player(player:get_player_name(), (ok and "[Stargate] " or "[Stargate error] ") .. msg)
end)

