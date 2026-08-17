
technic.register_electrolyser({tier = "MV", demand = {800, 600, 400}, speed = 1, upgrade = 1, tube = 1})

minetest.register_craft({
	output = 'chemistry:mv_electrolyser',
	recipe = {
		{'basic_materials:steel_bar', 'chemistry:plastic_block',          'basic_materials:steel_bar'},
		{'pipeworks:pipe_1_empty',        'technic:mv_transformer', 'pipeworks:pipe_1_empty'},
		{'chemistry:plastic_block', 'technic:mv_cable',       'chemistry:plastic_block'},
	}
})

