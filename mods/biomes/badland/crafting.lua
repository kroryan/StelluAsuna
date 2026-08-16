------------Crafting
minetest.register_craft({
	output = "badland:badland_wood 4",
	recipe = {
		{"badland:badland_tree"},
	}
})

minetest.register_craft({
	output = "badland:badland_trapdoor 2",
	recipe = {
		{"badland:badland_wood", "badland:badland_wood", "badland:badland_wood"},
		{"badland:badland_wood", "badland:badland_wood", "badland:badland_wood"},
	}
})