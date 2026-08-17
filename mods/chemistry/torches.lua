
local S = chemistry.getter

minetest.register_node("chemistry:magnesium_torch", {
	description = S("Magnesium Torch"),
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "magnesium_torch.png",
	wield_image = "magnesium_torch.png",
	tiles = {{
		    name = "magnesium_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 20,
	groups = {cracky=3, dig_immediate=3, attached_node=1, torch=1, igniter=1},
	drop = "chemistry:magnesium_torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = default.node_sound_metal_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("chemistry:magnesium_torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("chemistry:magnesium_torch")
		else
			fakestack:set_name("chemistry:magnesium_torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("chemistry:magnesium_torch")

		return itemstack
	end,
	floodable = false,
   damage_per_second = 2,
	on_rotate = false
})

minetest.register_node("chemistry:magnesium_torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {{
		    name = "magnesium_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 20,
	groups = {cracky=3, dig_immediate=3, attached_node=1, torch=1, igniter=1, not_in_creative_inventory=1},
	drop = "chemistry:magnesium_torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = default.node_sound_metal_defaults(),
	floodable = false,
   damage_per_second = 2,
	on_rotate = false
})

minetest.register_node("chemistry:magnesium_torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {{
		    name = "magnesium_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {cracky=3, dig_immediate=3, attached_node=1, torch=1, igniter=1, not_in_creative_inventory=1},
	drop = "chemistry:magnesium_torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = default.node_sound_metal_defaults(),
	floodable = false,
   damage_per_second = 2,
	on_rotate = false
})

minetest.register_lbm({
	name = "chemistry:3dmagnesium_torch",
	nodenames = {"chemistry:magnesium_torch", "torches:floor", "torches:wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "chemistry:magnesium_torch_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "chemistry:magnesium_torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "chemistry:magnesium_torch_wall",
				param2 = node.param2})
		end
	end
})

minetest.register_craft({
	output = "chemistry:magnesium_torch 4",
	recipe = {
		{"chemistry:magnesium"},
		{"basic_materials:steel_bar"},
	}
})


minetest.register_node("chemistry:anthracite_torch", {
	description = S("Anthracite Torch"),
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "anthracite_torch.png",
	wield_image = "anthracite_torch.png",
	tiles = {{
		    name = "anthracite_torch_on_floor_anim.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 20,
	groups = {cracky=3, dig_immediate=3, attached_node=1, torch=1},
	drop = "chemistry:anthracite_torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = default.node_sound_metal_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("chemistry:anthracite_torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("chemistry:anthracite_torch")
		else
			fakestack:set_name("chemistry:anthracite_torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("chemistry:anthracite_torch")

		return itemstack
	end,
	floodable = false,
   damage_per_second = 1,
	on_rotate = false
})

minetest.register_node("chemistry:anthracite_torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {{
		    name = "anthracite_torch_on_floor_anim.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 20,
	groups = {cracky=3, dig_immediate=3, attached_node=1, torch=1, not_in_creative_inventory=1},
	drop = "chemistry:anthracite_torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = default.node_sound_metal_defaults(),
	floodable = false,
   damage_per_second = 1,
	on_rotate = false
})

minetest.register_node("chemistry:anthracite_torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {{
		    name = "anthracite_torch_on_floor_anim.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {cracky=3, dig_immediate=3, attached_node=1, torch=1, not_in_creative_inventory=1},
	drop = "chemistry:anthracite_torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = default.node_sound_metal_defaults(),
	floodable = false,
   damage_per_second = 1,
	on_rotate = false
})

minetest.register_lbm({
	name = "chemistry:3dtorch",
	nodenames = {"chemistry:anthracite_torch", "torches:floor", "torches:wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "chemistry:anthracite_torch_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "chemistry:anthracite_torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "chemistry:anthracite_torch_wall",
				param2 = node.param2})
		end
	end
})

minetest.register_craft({
	output = "chemistry:anthracite_torch 4",
	recipe = {
		{"chemistry:anthracite"},
		{"basic_materials:steel_strip"},
		{"group:stick"}
	}
})
