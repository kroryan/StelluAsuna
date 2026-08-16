-- firefly/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("fireflies")

-- Legacy compatibility, when pointabilities don't exist, pointable is set to true.
local pointable_compat = not minetest.features.item_specific_pointabilities

minetest.register_node("fireflies:firefly", {
	description = S("Firefly"),
	drawtype = "plantlike",
	tiles = {{
		name = "fireflies_firefly_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.5
		},
	}},
	inventory_image = "fireflies_firefly.png",
	wield_image =  "fireflies_firefly.png",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	buildable_to = true,
	walkable = false,
	pointable = pointable_compat,
	groups = {catchable = 1},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	},
	light_source = 6,
	floodable = true,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(1)
	end,
	on_timer = function(pos, elapsed)
		if minetest.get_node_light(pos) > 11 then
			minetest.set_node(pos, {name = "fireflies:hidden_firefly"})
		end
		minetest.get_node_timer(pos):start(30)
	end
})

minetest.register_node("fireflies:hidden_firefly", {
	description = S("Hidden Firefly"),
	drawtype = "airlike",
	inventory_image = "fireflies_firefly.png^default_invisible_node_overlay.png",
	wield_image =  "fireflies_firefly.png^default_invisible_node_overlay.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	floodable = true,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(1)
	end,
	on_timer = function(pos, elapsed)
		if minetest.get_node_light(pos) <= 11 then
			minetest.set_node(pos, {name = "fireflies:firefly"})
		end
		minetest.get_node_timer(pos):start(30)
	end
})


-- bug net
minetest.register_tool("fireflies:bug_net", {
	description = S("Bug Net"),
	inventory_image = "fireflies_bugnet.png",
	pointabilities = {nodes = {["group:catchable"] = true}},
	tool_capabilities = {
		groupcaps = {
			catchable = { maxlevel = 1, uses = 256, times = { [1] = 0, [2] = 0, [3] = 0 } }
		},
	},
})

minetest.register_craft( {
	output = "fireflies:bug_net",
	recipe = {
		{"farming:string", "farming:string"},
		{"farming:string", "farming:string"},
		{"group:stick", ""}
	}
})


-- firefly in a bottle
minetest.register_node("fireflies:firefly_bottle", {
	description = S("Firefly in a Bottle"),
	inventory_image = "fireflies_bottle.png",
	wield_image = "fireflies_bottle.png",
	tiles = {{
		name = "fireflies_bottle_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.5
		},
	}},
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 9,
	walkable = false,
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local lower_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.is_protected(pos, player:get_player_name()) or
				minetest.get_node(lower_pos).name ~= "air" then
			return
		end

		local upper_pos = {x = pos.x, y = pos.y + 2, z = pos.z}
		local firefly_pos

		if not minetest.is_protected(upper_pos, player:get_player_name()) and
				minetest.get_node(upper_pos).name == "air" then
			firefly_pos = upper_pos
		elseif not minetest.is_protected(lower_pos, player:get_player_name()) then
			firefly_pos = lower_pos
		end

		if firefly_pos then
			minetest.set_node(pos, {name = "vessels:glass_bottle"})
			minetest.set_node(firefly_pos, {name = "fireflies:firefly"})
			minetest.get_node_timer(firefly_pos):start(1)
		end
	end
})

minetest.register_craft( {
	output = "fireflies:firefly_bottle",
	recipe = {
		{"fireflies:firefly"},
		{"vessels:glass_bottle"}
	}
})

-- restart firefly timers
minetest.register_lbm({
	name = "fireflies:firefly_timer",
	nodenames = {"fireflies:firefly", "fireflies:hidden_firefly"},
	run_at_every_load = true,

	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1,5))
	end,
})