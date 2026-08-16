-- Soup items
minetest.register_alias("soup:tomato_soup","farming:tomato_soup")

minetest.register_alias("soup:mushroom_soup","ethereal:mushroom_soup")

minetest.register_craftitem("soup:chicken_noodle_soup", {
    description = "Chicken Noodle Soup",
    inventory_image = "chicken_noodle_soup.png",
    on_use = minetest.item_eat(8,"ethereal:bowl"),
})

-- Soup recipes
minetest.register_craft({
	output = "soup:chicken_noodle_soup",
	recipe = {
		{"","animalia:poultry_cooked", ""},
		{"","bottles:bottle_of_water", ""},
		{"","group:food_bowl", ""}
	}
})