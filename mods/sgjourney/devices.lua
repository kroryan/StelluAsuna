local S = sgjourney

core.register_tool("sgjourney:pda", {
	description = "PDA\nRight-click a Stargate or DHD to inspect it",
	inventory_image = "sgjourney_item_pda.png",
	on_use = function(itemstack, user, pointed)
		if pointed.type ~= "node" then return itemstack end
		local pos = pointed.under
		local gate = core.get_item_group(core.get_node(pos).name, "sgjourney_gate") > 0 and pos or S.find_gate(pos, 16)
		if not gate then core.chat_send_player(user:get_player_name(), "[PDA] No Stargate detected") return itemstack end
		local meta = core.get_meta(gate)
		local state = S.links[S.pos_key(gate)] and "CONNECTED" or "INACTIVE"
		local iris = meta:get_int("iris_closed") == 1 and "CLOSED" or "OPEN"
		core.chat_send_player(user:get_player_name(), "[PDA] Address: " .. meta:get_string("address") .. " | " .. state .. " | Iris: " .. iris .. " | Position: " .. core.pos_to_string(gate))
		return itemstack
	end,
})

core.register_tool("sgjourney:gdo", {
	description = "GDO\nRight-click near a connected Stargate to request iris opening",
	inventory_image = "sgjourney_item_gdo.png",
	on_use = function(itemstack, user)
		local gate = S.find_gate(user:get_pos(), 16)
		if not gate then core.chat_send_player(user:get_player_name(), "[GDO] No nearby Stargate") return itemstack end
		local target = S.links[S.pos_key(gate)]
		if not target then core.chat_send_player(user:get_player_name(), "[GDO] Stargate is not connected") return itemstack end
		S.set_iris(target, false)
		core.chat_send_player(user:get_player_name(), "[GDO] IDC accepted; destination iris open")
		return itemstack
	end,
})

core.register_tool("sgjourney:personal_shield_emitter", {
	description = "Personal Shield Emitter\nHold to reduce incoming damage",
	inventory_image = "sgjourney_item_personal_shield_emitter.png",
})

core.register_on_player_hpchange(function(player, hp_change)
	if hp_change >= 0 then return hp_change end
	if player:get_wielded_item():get_name() == "sgjourney:personal_shield_emitter" then return math.ceil(hp_change * 0.25) end
	return hp_change
end, true)

for _, def in ipairs({
	{"copper_iris", "Copper Iris"}, {"iron_iris", "Iron Iris"}, {"golden_iris", "Golden Iris"},
	{"diamond_iris", "Diamond Iris"}, {"naquadah_iris", "Naquadah Iris"}, {"trinium_iris", "Trinium Iris"},
	{"stargate_shielding_ring", "Stargate Shielding Ring"}, {"pocket_crystal_computer", "Pocket Crystal Computer"},
}) do
	core.register_craftitem("sgjourney:" .. def[1], {description = def[2], inventory_image = "sgjourney_item_" .. def[1] .. ".png"})
end
