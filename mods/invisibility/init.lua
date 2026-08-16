
-- global

invisibility = {
	effect_time = tonumber(core.settings:get("invisibility.effect_time")) or 180 -- 3 mins
}

-- translation and player table

local S = core.get_translator("invisibility")
local players = {}

-- reset player invisibility if they go offline or die

core.register_on_leaveplayer(function(player)
	players[player:get_player_name()] = nil
end)

core.register_on_dieplayer(function(player)
	invisibility.invisible(player, nil)
end)

-- creative check

local creative_mode_cache = core.settings:get_bool("creative_mode")
local function is_creative(name)
	return creative_mode_cache or core.check_player_privs(name, {creative = true})
end

-- invisibility functions

function invisibility.is_visible(player_name)

	if players[player_name] then return false end

	return true
end

function invisibility.invisible(player, toggle)

	if not player then return false end

	players[player:get_player_name()] = toggle

	local size = 1 -- default player size
	local attr = player:get_nametag_attributes()

	attr.color.a = 255 -- default nametag is visible

	if toggle == true then -- hide player and nametag
		size = 0 ; attr.color.a = 0
	end

	player:set_nametag_attributes(attr)
	player:set_properties({
		visual_size = {x = size, y = size}, show_on_minimap = not toggle
	})
end

-- invisibility potion

core.register_node("invisibility:potion", {
	description = S("Invisibility Potion"),
	drawtype = "plantlike",
	tiles = {"invisibility_potion.png"},
	inventory_image = "invisibility_potion.png",
	wield_image = "invisibility_potion.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, flammable = 2},
	sounds = default.node_sound_glass_defaults(),

	on_use = function(itemstack, user)

		local pos = user:get_pos()
		local name = user:get_player_name()

		-- are we already invisible?
		if players[name] then

			core.chat_send_player(name, S(">>> You are already invisible!"))

			return itemstack
		end

		-- make player invisible
		invisibility.invisible(user, true)

		-- play sound
		core.sound_play("pop", {pos = pos, max_hear_distance = 5}, true)

		-- particle effect
		pos.y = pos.y + 1.4

		core.add_particlespawner({
			amount = 25,
			time = 0.25,
			minpos = pos, maxpos = pos,
			minvel = {x = -1, y = -1, z = -1}, maxvel = {x = 1, y = 1, z = 1},
			minacc = {x = 0, y = -10, z = 0}, maxacc = {x = 0, y = -10, z = 0},
			minexptime = 0.1, maxexptime = 1,
			minsize = 8, maxsize = 8,
			texture = "tnt_smoke.png"
		})

		-- display 10 second warning
		if invisibility.effect_time > 10 then

			core.after(invisibility.effect_time - 10, function()

				if players[name] and user:get_pos() then

					core.chat_send_player(name,
							S(">>> You have 10 seconds before invisibility wears off!"))
				end
			end)
		end

		-- make player visible 5 minutes later
		core.after(invisibility.effect_time, function()

			if players[name] and user:get_pos() then

				-- show hidden player
				invisibility.invisible(user, nil)

				-- play sound
				core.sound_play("pop",
						{pos = user:get_pos(), max_hear_distance = 5}, true)
			end
		end)

		if is_creative(name) then return itemstack end

		local item_count = itemstack:get_count()
		local giving_back = "vessels:glass_bottle"

		if item_count > 1 then

			local inv = user:get_inventory()

			if inv:room_for_item("main", giving_back) then
				inv:add_item("main", giving_back)
			else
				core.add_item(pos, giving_back)
			end

			giving_back = "invisibility:potion " .. tostring(item_count - 1)
		end

		return ItemStack(giving_back)
	end
})

-- mod check

local mod_eth = core.get_modpath("ethereal")

-- craft recipe

local alt_item = mod_eth and "ethereal:birch_leaves3" or "default:acacia_bush_sapling"

core.register_craft( {
	output = "invisibility:potion",
	recipe = {
		{"default:sapling", "default:junglesapling", "default:pine_sapling"},
		{"default:acacia_sapling", "default:aspen_sapling", "default:bush_sapling"},
		{alt_item, "vessels:glass_bottle", "flowers:mushroom_red"}
	}
})

-- vanish command (admin only)

core.register_chatcommand("vanish", {
	params = "<name>",
	description = S("Make player invisible"),
	privs = {server = true},

	func = function(name, param)

		if param ~= "" and core.get_player_by_name(param) then -- player online

			name = param

		elseif param ~= "" then -- player not online

			return false, S("Player @1 is offline!", param)
		end

		local player = core.get_player_by_name(name)
		local msg

		-- hide / show player
		if players[name] then

			invisibility.invisible(player, nil) ; msg = "visible"
		else
			invisibility.invisible(player, true) ; msg = "invisible"
		end

		return true, S("Player @1 is now @2!", name, S(msg))
	end
})
