
technic.register_ionizer({tier = "MV", demand = {900, 650, 400}, speed = 1, upgrade = 1, tube = 1})

minetest.register_craft({
	output = 'chemistry:mv_ionizer',
	recipe = {
		{'chemistry:plastic_block', 'chemistry:radium_block',          'chemistry:plastic_block'},
		{'pipeworks:pipe_1_empty',        'technic:mv_transformer', 'pipeworks:pipe_1_empty'},
		{'chemistry:plastic_block', 'technic:mv_cable',       'chemistry:plastic_block'},
	}
})

