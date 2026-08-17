
local S = chemistry.getter

minetest.register_abm({
	label = "chemistry:crop withering",
	nodenames = {"group:plant"},
	interval = 5,
	chance = 10,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 3, "group:toxic_to_crops") then
			minetest.set_node(pos, {name="chemistry:withered_crops"})
        end
    end,
})

minetest.register_node("chemistry:withered_crops",{
	description = S("Withered Crops"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"withered_crops.png"},
	inventory_image = "withered_crops.png",
	wield_image = "withered_crops.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3,attached_node = 1,flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},
    drop = "",
})