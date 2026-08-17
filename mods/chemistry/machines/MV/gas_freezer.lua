
technic.register_gas_freezer({tier = "MV", demand = {900, 650, 400}, speed = 2, upgrade = 1, tube = 1})

minetest.register_craft({
	output = 'chemistry:mv_gas_freezer',
	recipe = {
		{'chemistry:titanium_block', 'technic:motor', 'chemistry:titanium_block'},
		{'pipeworks:pipe_1_empty', 'technic:mv_transformer', 'pipeworks:pipe_1_empty'},
		{'chemistry:titanium_block', 'technic:mv_cable', 'chemistry:titanium_block'},
	}
})

