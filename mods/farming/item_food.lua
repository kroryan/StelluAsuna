
local S = core.get_translator("farming")
local a = farming.recipe_items

local function register_craftitem(condition,eatable,name,def)
	if condition then
		core.register_craftitem(name,def)
		if eatable then
			farming.add_eatable(eatable)
		end
	end
end

local function register_node(condition,eatable,name,def)
	if condition then
		core.register_node(name,def)
		if eatable then
			farming.add_eatable(eatable)
		end
	end
end

-- Flour

register_craftitem(true,nil,"farming:flour", {
	description = S("Flour"),
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1}
})

-- Garlic bulb

register_craftitem(farming.garlic,1,"farming:garlic", {
	description = S("Garlic"),
	inventory_image = "crops_garlic.png",
	on_use = core.item_eat(1),
	groups = {food_garlic = 1, compostability = 55}
})

-- Garlic braid

register_node(farming.garlic,nil,"farming:garlic_braid", {
	description = S("Garlic Braid"),
	inventory_image = "crops_garlic_braid.png",
	wield_image = "crops_garlic_braid.png",
	drawtype = "nodebox",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"crops_garlic_braid_top.png",
		"crops_garlic_braid.png",
		"crops_garlic_braid_side.png^[transformFx",
		"crops_garlic_braid_side.png",
		"crops_garlic_braid.png",
		"crops_garlic_braid.png"
	},
	groups = {vessel = 1, dig_immediate = 3, flammable = 3, compostability = 65, handy = 1},
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed", fixed = {{-0.1875, -0.5, 0.5, 0.1875, 0.5, 0.125}}
	}
})

-- Corn on the cob (texture by TenPlus1)

register_craftitem(farming.corn,5,"farming:corn_cob", {
	description = S("Corn on the Cob"),
	inventory_image = "farming_corn_cob.png",
	groups = {compostability = 65, food_corn_cooked = 1},
	on_use = core.item_eat(5)
})

-- Popcorn

register_craftitem(farming.corn,4,"farming:popcorn", {
	description = S("Popcorn"),
	inventory_image = "farming_popcorn.png",
	groups = {compostability = 55, food_popcorn = 1},
	on_use = core.item_eat(4)
})

-- Cornstarch

register_craftitem(farming.corn,nil,"farming:cornstarch", {
	description = S("Cornstarch"),
	inventory_image = "farming_cornstarch.png",
	groups = {food_cornstarch = 1, food_gelatin = 1, flammable = 2, compostability = 65}
})

-- Cup of coffee

register_node(farming.coffee,2,"farming:coffee_cup", {
	description = S("Cup of Coffee"),
	drawtype = "torchlike",
	tiles = {"farming_coffee_cup.png"},
	inventory_image = "farming_coffee_cup.png",
	wield_image = "farming_coffee_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, drink = 1, handy = 1},
	is_ground_content = false,
	on_use = core.item_eat(2, "vessels:drinking_glass"),
	sounds = farming.node_sound_glass_defaults()
})

minetest.register_alias("farming:coffee_cup_hot", "farming:coffee_cup")
minetest.register_alias("farming:drinking_cup", "vessels:drinking_glass")

-- Bar of of dark chocolate (thx to Ice Pandora for her deviantart.com chocolate tutorial)

register_craftitem(farming.cocoa,3,"farming:chocolate_dark", {
	description = S("Bar of Dark Chocolate"),
	inventory_image = "farming_chocolate_dark.png",
	on_use = core.item_eat(3)
})

-- Chocolate block (not edible)

register_node(farming.cocoa,nil,"farming:chocolate_block", {
	description = S("Chocolate Block"),
	tiles = {"farming_chocolate_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, oddly_breakable_by_hand = 2, handy = 1},
	sounds = farming.node_sound_stone_defaults()
})

-- Bowl of chili

register_craftitem(farming.chili,8,"farming:chili_bowl", {
	description = S("Bowl of Chili"),
	inventory_image = "farming_chili_bowl.png",
	on_use = core.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

-- Chili powder

register_craftitem(farming.chili,nil,"farming:chili_powder", {
	description = S("Chili Powder"),
	on_use = core.item_eat(-1),
	inventory_image = "farming_chili_powder.png",
	groups = {compostability = 45}
})

-- Carrot juice

register_craftitem(farming.carrot,4,"farming:carrot_juice", {
	description = S("Carrot Juice"),
	inventory_image = "farming_carrot_juice.png",
	on_use = core.item_eat(4, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})

-- Blueberry Pie

register_craftitem(farming.blueberry or core.registered_items["default:blueberries"],6,"farming:blueberry_pie", {
	description = S("Blueberry Pie"),
	inventory_image = "farming_blueberry_pie.png",
	on_use = core.item_eat(6),
	groups = {compostability = 75}
})

-- Blueberry muffin (thanks to sosogirl123 @ deviantart.com for muffin image)

register_craftitem(farming.blueberry or core.registered_items["default:blueberries"],2,"farming:muffin_blueberry", {
	description = S("Blueberry Muffin"),
	inventory_image = "farming_blueberry_muffin.png",
	on_use = core.item_eat(2),
	groups = {compostability = 65}
})

-- Tomato soup

register_craftitem(farming.tomato,8,"farming:tomato_soup", {
	description = S("Tomato Soup"),
	inventory_image = "farming_tomato_soup.png",
	groups = {compostability = 65, drink = 1},
	on_use = core.item_eat(8, "farming:bowl")
})

-- sliced bread

register_craftitem(true,1,"farming:bread_slice", {
	description = S("Sliced Bread"),
	inventory_image = "farming_bread_slice.png",
	on_use = core.item_eat(1),
	groups = {food_bread_slice = 1, compostability = 65}
})

-- toast

register_craftitem(true,1,"farming:toast", {
	description = S("Toast"),
	inventory_image = "farming_toast.png",
	on_use = core.item_eat(1),
	groups = {food_toast = 1, compostability = 65}
})

-- toast sandwich

register_craftitem(true,4,"farming:toast_sandwich", {
	description = S("Toast Sandwich"),
	inventory_image = "farming_toast_sandwich.png",
	on_use = core.item_eat(4),
	groups = {compostability = 85}
})

-- glass of water

register_craftitem(true,nil,"farming:glass_water", {
	description = S("Glass of Water"),
	inventory_image = "farming_water_glass.png",
	groups = {food_glass_water = 1, flammable = 3, vessel = 1}
})

-- Sugar cube

register_node(true,nil,"farming:sugar_cube", {
	description = S("Sugar Cube"),
	tiles = {"farming_sugar_cube.png"},
	groups = {shovely = 1, handy = 1, crumbly = 2},
	is_ground_content = false,
	floodable = true,
	sounds = farming.node_sound_gravel_defaults(),
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- Sugar caramel

register_craftitem(true,nil,"farming:caramel", {
	description = S("Caramel"),
	inventory_image = "farming_caramel.png",
	groups = {compostability = 40}
})

-- Salt

register_node(true,nil,"farming:salt", {
	description = S("Salt"),
	inventory_image = "farming_salt.png",
	wield_image = "farming_salt.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"farming_salt.png"},
	groups = {food_salt = 1, vessel = 1, dig_immediate = 3, attached_node = 1, handy = 1},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	-- special function to make salt crystals form inside water
	dropped_step = function(self, pos, dtime)

		self.ctimer = (self.ctimer or 0) + dtime
		if self.ctimer < 15.0 then return end
		self.ctimer = 0

		local needed

		if self.node_inside and self.node_inside.name == a.water_source then
			needed = 8

		elseif self.node_inside and self.node_inside.name == a.river_water_source then
			needed = 9
		end

		if not needed then return end

		local objs = core.get_objects_inside_radius(pos, 0.5)

		if not objs or #objs ~= 1 then return end

		local salt, ent = nil, nil

		for k, obj in pairs(objs) do

			ent = obj:get_luaentity()

			if ent and ent.name == "__builtin:item"
			and ent.itemstring == "farming:salt " .. needed then

				obj:remove()

				core.add_item(pos, "farming:salt_crystal")

				return false -- return with no further action
			end
		end
	end
})

-- Salt Crystal

register_node(true,nil,"farming:salt_crystal", {
	description = S("Salt crystal"),
	inventory_image = "farming_salt_crystal.png",
	wield_image = "farming_salt_crystal.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	light_source = 1,
	tiles = {"farming_salt_crystal.png"},
	groups = {dig_immediate = 3, attached_node = 1, handy = 1},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- Mayonnaise

register_node(true,3,"farming:mayonnaise", {
	description = S("Mayonnaise"),
	drawtype = "plantlike",
	tiles = {"farming_mayo.png"},
	inventory_image = "farming_mayo.png",
	wield_image = "farming_mayo.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = core.item_eat(3),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.45, 0.25}
	},
	groups = {
		compostability = 65, food_mayonnaise = 1, vessel = 1, dig_immediate = 3,
		attached_node = 1, handy = 1
	},
	sounds = farming.node_sound_glass_defaults()
})

-- Rose Water

register_node(true,nil,"farming:rose_water", {
	description = S("Rose Water"),
	inventory_image = "farming_rose_water.png",
	wield_image = "farming_rose_water.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"farming_rose_water.png"},
	groups = {
		food_rose_water = 1, vessel = 1, dig_immediate = 3, attached_node = 1, handy = 1
	},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

-- Turkish Delight

register_craftitem(true,2,"farming:turkish_delight", {
	description = S("Turkish Delight"),
	inventory_image = "farming_turkish_delight.png",
	groups = {compostability = 85},
	on_use = core.item_eat(2)
})

-- Garlic Bread

register_craftitem(farming.garlic,2,"farming:garlic_bread", {
	description = S("Garlic Bread"),
	inventory_image = "farming_garlic_bread.png",
	groups = {compostability = 65},
	on_use = core.item_eat(2)
})

-- Donuts (thanks to Bockwurst for making the donut images)

register_craftitem(true,4,"farming:donut", {
	description = S("Donut"),
	inventory_image = "farming_donut.png",
	on_use = core.item_eat(4),
	groups = {compostability = 65}
})

register_craftitem(farming.cocoa,6,"farming:donut_chocolate", {
	description = S("Chocolate Donut"),
	inventory_image = "farming_donut_chocolate.png",
	on_use = core.item_eat(6),
	groups = {compostability = 65}
})

register_craftitem(true,6,"farming:donut_apple", {
	description = S("Apple Donut"),
	inventory_image = "farming_donut_apple.png",
	on_use = core.item_eat(6),
	groups = {compostability = 65}
})

-- Porridge Oats

register_craftitem(farming.grains and farming.soy,6,"farming:porridge", {
	description = S("Porridge"),
	inventory_image = "farming_porridge.png",
	on_use = core.item_eat(6, a.bowl),
	groups = {compostability = 65}
})

-- Jaffa Cake

register_craftitem(farming.soy,6,"farming:jaffa_cake", {
	description = S("Jaffa Cake"),
	inventory_image = "farming_jaffa_cake.png",
	on_use = core.item_eat(6),
	groups = {compostability = 65}
})

-- Apple Pie

register_craftitem(true,6,"farming:apple_pie", {
	description = S("Apple Pie"),
	inventory_image = "farming_apple_pie.png",
	on_use = core.item_eat(6),
	groups = {compostability = 75}
})

-- Cactus Juice

register_craftitem(true,1,"farming:cactus_juice", {
	description = S("Cactus Juice"),
	inventory_image = "farming_cactus_juice.png",
	groups = {vessel = 1, drink = 1, compostability = 55},

	on_use = function(itemstack, user, pointed_thing)

		if user then

			local num = math.random(5) == 1 and -1 or 2

			return core.do_item_eat(num, "vessels:drinking_glass",
					itemstack, user, pointed_thing)
		end
	end
})

-- Pasta

register_craftitem(true,nil,"farming:pasta", {
	description = S("Pasta"),
	inventory_image = "farming_pasta.png",
	groups = {compostability = 65, food_pasta = 1}
})

-- Mac & Cheese

register_craftitem(true,6,"farming:mac_and_cheese", {
	description = S("Mac & Cheese"),
	inventory_image = "farming_mac_and_cheese.png",
	on_use = core.item_eat(6, a.bowl),
	groups = {compostability = 65}
})

-- Spaghetti

register_craftitem(farming.garlic and farming.tomato,8,"farming:spaghetti", {
	description = S("Spaghetti"),
	inventory_image = "farming_spaghetti.png",
	on_use = core.item_eat(8),
	groups = {compostability = 65}
})

-- Korean Bibimbap

register_craftitem(farming.chili and farming.rice and farming.chili and farming.cabbage,8,"farming:bibimbap", {
	description = S("Bibimbap"),
	inventory_image = "farming_bibimbap.png",
	on_use = core.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

-- Burger

register_craftitem(farming.lettuce and farming.tomato,16,"farming:burger", {
	description = S("Burger"),
	inventory_image = "farming_burger.png",
	on_use = core.item_eat(16),
	groups = {compostability = 95}
})

-- Salad

register_craftitem(farming.lettuce and farming.tomato,8,"farming:salad", {
	description = S("Salad"),
	inventory_image = "farming_salad.png",
	on_use = core.item_eat(8, a.bowl),
	groups = {compostability = 45}
})

-- Triple Berry Smoothie

register_craftitem(farming.raspberry and farming.blackberry and farming.strawberry,6,"farming:smoothie_berry", {
	description = S("Triple Berry Smoothie"),
	inventory_image = "farming_berry_smoothie.png",
	on_use = core.item_eat(6, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1, compostability = 65}
})

-- Patatas a la importancia

register_craftitem(farming.garlic and farming.parsley and farming.potato and farming.onion,8,"farming:spanish_potatoes", {
	description = S("Spanish Potatoes"),
	inventory_image = "farming_spanish_potatoes.png",
	on_use = core.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

-- Potato omelette

register_craftitem(farming.onion and farming.potato,6,"farming:potato_omelet", {
	description = S("Potato omelette"),
	inventory_image = "farming_potato_omelet.png",
	on_use = core.item_eat(6, a.bowl),
	groups = {compostability = 65}
})

-- Paella

register_craftitem(farming.peas and farming.pepper and farming.rice,8,"farming:paella", {
	description = S("Paella"),
	inventory_image = "farming_paella.png",
	on_use = core.item_eat(8, a.bowl),
	groups = {compostability = 65}
})

-- Vanilla Flan

register_craftitem(farming.vanilla and farming.soy,6,"farming:flan", {
	description = S("Vanilla Flan"),
	inventory_image = "farming_vanilla_flan.png",
	on_use = core.item_eat(6),
	groups = {compostability = 65}
})

-- Vegan Cheese

register_craftitem(farming.corn and farming.pepper and farming.soy,2,"farming:cheese_vegan", {
	description = S("Vegan Cheese"),
	inventory_image = "farming_cheese_vegan.png",
	on_use = core.item_eat(2),
	groups = {compostability = 65, food_cheese = 1}
})

-- Vegan Butter

register_craftitem(farming.soy and farming.sunflower,nil,"farming:butter_vegan", {
	description = S("Vegan Butter"),
	inventory_image = "farming_vegan_butter.png",
	groups = {food_butter = 1}
})

-- Onigiri

register_craftitem(farming.rice,2,"farming:onigiri", {
	description = S("Onigiri"),
	inventory_image = "farming_onigiri.png",
	on_use = core.item_eat(2),
	groups = {compostability = 65}
})

-- Gyoza

register_craftitem(farming.cabbage and farming.garlic and farming.onion,4,"farming:gyoza", {
	description = S("Gyoza"),
	inventory_image = "farming_gyoza.png",
	on_use = core.item_eat(4),
	groups = {compostability = 65}
})

-- Mochi

register_craftitem(farming.rice,3,"farming:mochi", {
	description = S("Mochi"),
	inventory_image = "farming_mochi.png",
	on_use = core.item_eat(3),
	groups = {compostability = 65}
})

-- Gingerbread Man

register_craftitem(farming.ginger,2,"farming:gingerbread_man", {
	description = S("Gingerbread Man"),
	inventory_image = "farming_gingerbread_man.png",
	on_use = core.item_eat(2),
	groups = {compostability = 85}
})

-- Mint tea
register_craftitem(farming.mint,2,"farming:mint_tea", {
	description = S("Mint Tea"),
	inventory_image = "farming_mint_tea.png",
	on_use = core.item_eat(2, a.drinking_glass),
	groups = {drink = 1}
})

-- Onion soup
register_craftitem(farming.onion,6,"farming:onion_soup", {
	description = S("Onion Soup"),
	inventory_image = "farming_onion_soup.png",
	groups = {compostability = 65, drink = 1},
	on_use = core.item_eat(6, a.bowl)
})

-- Pea soup

register_craftitem(farming.peas,4,"farming:pea_soup", {
	description = S("Pea Soup"),
	inventory_image = "farming_pea_soup.png",
	groups = {compostability = 65, drink = 1},
	on_use = core.item_eat(4, a.bowl)
})

-- Ground pepper

register_node(farming.pepper,nil,"farming:pepper_ground", {
	description = S("Ground Pepper"),
	inventory_image = "crops_pepper_ground.png",
	wield_image = "crops_pepper_ground.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"crops_pepper_ground.png"},
	groups = {
		vessel = 1, food_pepper_ground = 1, handy = 1,
		dig_immediate = 3, attached_node = 1, compostability = 30
	},
	is_ground_content = false,
	sounds = farming.node_sound_defaults(),
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

-- pineapple ring

register_craftitem(farming.pineapple,1,"farming:pineapple_ring", {
	description = S("Pineapple Ring"),
	inventory_image = "farming_pineapple_ring.png",
	groups = {food_pineapple_ring = 1, compostability = 45},
	on_use = core.item_eat(1)
})

-- Pineapple juice

register_craftitem(farming.pineapple,4,"farming:pineapple_juice", {
	description = S("Pineapple Juice"),
	inventory_image = "farming_pineapple_juice.png",
	on_use = core.item_eat(4, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1, compostability = 35}
})

-- Potato & cucumber Salad

register_craftitem(farming.potato,10,"farming:potato_salad", {
	description = S("Cucumber and Potato Salad"),
	inventory_image = "farming_potato_salad.png",
	on_use = core.item_eat(10, "farming:bowl")
})

-- Pumpkin dough

register_craftitem(farming.pumpkin,nil,"farming:pumpkin_dough", {
	description = S("Pumpkin Dough"),
	inventory_image = "farming_pumpkin_dough.png"
})

-- Pumpkin bread

register_craftitem(farming.pumpkin,8,"farming:pumpkin_bread", {
	description = S("Pumpkin Bread"),
	inventory_image = "farming_pumpkin_bread.png",
	on_use = core.item_eat(8),
	groups = {food_bread = 1}
})

-- Raspberry smoothie

register_craftitem(farming.raspberry,2,"farming:smoothie_raspberry", {
	description = S("Raspberry Smoothie"),
	inventory_image = "farming_raspberry_smoothie.png",
	on_use = core.item_eat(2, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1, compostability = 65}
})

-- Rhubarb pie

register_craftitem(farming.rhubarb,6,"farming:rhubarb_pie", {
	description = S("Rhubarb Pie"),
	inventory_image = "farming_rhubarb_pie.png",
	on_use = core.item_eat(6),
	groups = {compostability = 65}
})

-- Rice flour

register_craftitem(farming.rice,nil,"farming:rice_flour", {
	description = S("Rice Flour"),
	inventory_image = "farming_rice_flour.png",
	groups = {food_rice_flour = 1, flammable = 1, compostability = 65}
})

-- Rice bread

register_craftitem(farming.rice,5,"farming:rice_bread", {
	description = S("Rice Bread"),
	inventory_image = "farming_rice_bread.png",
	on_use = core.item_eat(5),
	groups = {food_rice_bread = 1, compostability = 65}
})

-- Multigrain flour

register_craftitem(farming.grains,nil,"farming:flour_multigrain", {
	description = S("Multigrain Flour"),
	inventory_image = "farming_flour_multigrain.png",
	groups = {food_flour = 1, flammable = 1},
})


-- Multigrain bread

register_craftitem(farming.grains,7,"farming:bread_multigrain", {
	description = S("Multigrain Bread"),
	inventory_image = "farming_bread_multigrain.png",
	on_use = core.item_eat(7),
	groups = {food_bread = 1, compostability = 65}
})

-- Soy sauce

register_node(farming.soy,nil,"farming:soy_sauce", {
	description = S("Soy Sauce"),
	drawtype = "plantlike",
	tiles = {"farming_soy_sauce.png"},
	inventory_image = "farming_soy_sauce.png",
	wield_image = "farming_soy_sauce.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {
		vessel = 1, food_soy_sauce = 1, dig_immediate = 3, attached_node = 1,
		compostability = 65, handy = 1
	},
	is_ground_content = false,
	sounds = farming.node_sound_glass_defaults()
})

-- Soy milk

register_node(farming.soy,2,"farming:soy_milk", {
	description = S("Soy Milk"),
	drawtype = "plantlike",
	tiles = {"farming_soy_milk_glass.png"},
	inventory_image = "farming_soy_milk_glass.png",
	wield_image = "farming_soy_milk_glass.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	on_use = core.item_eat(2, "vessels:drinking_glass"),
	groups = {
		vessel = 1, food_milk_glass = 1, dig_immediate = 3, handy = 1,
		attached_node = 1, drink = 1, compostability = 65
	},
	is_ground_content = false,
	sounds = farming.node_sound_glass_defaults()
})

-- Tofu

register_craftitem(farming.soy,3,"farming:tofu", {
	description = S("Tofu"),
	inventory_image = "farming_tofu.png",
	groups = {
		food_tofu = 1, food_meat_raw = 1, compostability = 65,
	},
	on_use = core.item_eat(3)
})

-- Cooked tofu

register_craftitem(farming.soy,6,"farming:tofu_cooked", {
	description = S("Cooked Tofu"),
	inventory_image = "farming_tofu_cooked.png",
	groups = {food_meat = 1, compostability = 65},
	on_use = core.item_eat(6)
})

-- Toasted sunflower seeds

register_craftitem(farming.sunflower,1,"farming:sunflower_seeds_toasted", {
	description = S("Toasted Sunflower Seeds"),
	inventory_image = "farming_sunflower_seeds_toasted.png",
	groups = {food_sunflower_seeds_toasted = 1, compostability = 65},
	on_use = core.item_eat(1)
})

-- Sunflower oil

register_node(farming.sunflower,nil,"farming:sunflower_oil", {
	description = S("Bottle of Sunflower Oil"),
	drawtype = "plantlike",
	tiles = {"farming_sunflower_oil.png"},
	inventory_image = "farming_sunflower_oil.png",
	wield_image = "farming_sunflower_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {
		food_oil = 1, vessel = 1, dig_immediate = 3, attached_node = 1,
		flammable = 2, compostability = 65, handy = 1
	},
	sounds = farming.node_sound_glass_defaults()
})

-- Sunflower seed bread

register_craftitem(farming.sunflower,8,"farming:sunflower_bread", {
	description = S("Sunflower Seed Bread"),
	inventory_image = "farming_sunflower_bread.png",
	on_use = core.item_eat(8),
	groups = {food_bread = 1}
})

-- Vanilla extract

register_node(farming.vanilla and farming.corn,nil,"farming:vanilla_extract", {
	description = S("Vanilla Extract"),
	drawtype = "plantlike",
	tiles = {"farming_vanilla_extract.png"},
	inventory_image = "farming_vanilla_extract.png",
	wield_image = "farming_vanilla_extract.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, handy = 1},
	sounds = farming.node_sound_glass_defaults(),
})

-- Jerusalem Artichokes with miso butter

register_craftitem(farming.artichoke and farming.soy and farming.garlic,11,"farming:jerusalem_artichokes", {
	description = S("Jerusalem Artichokes"),
	inventory_image = "farming_jerusalem_artichokes.png",
	on_use = core.item_eat(11, a.bowl)
})

--= Foods we shouldn't add when using Mineclonia/VoxeLibre

if not farming.mcl then

	-- Bread

	register_craftitem(true,5,"farming:bread", {
		description = S("Bread"),
		inventory_image = "farming_bread.png",
		on_use = core.item_eat(5),
		groups = {food_bread = 1}
	})

	-- Cocoa beans

	register_craftitem(farming.cocoa,nil,"farming:cocoa_beans", {
		description = S("Cocoa Beans"),
		inventory_image = "farming_cocoa_beans.png",
		groups = {compostability = 65, food_cocoa = 1, flammable = 2}
	})

	-- Chocolate cookie

	register_craftitem(farming.cocoa,2,"farming:cookie", {
		description = S("Cookie"),
		inventory_image = "farming_cookie.png",
		on_use = core.item_eat(2)
	})

	-- Golden carrot

	register_craftitem(farming.carrot,10,"farming:carrot_gold", {
		description = S("Golden Carrot"),
		inventory_image = "farming_carrot_gold.png",
		on_use = core.item_eat(10)
	})

	-- Beetroot soup

	register_craftitem(farming.beetroot,6,"farming:beetroot_soup", {
		description = S("Beetroot Soup"),
		inventory_image = "farming_beetroot_soup.png",
		on_use = core.item_eat(6, "farming:bowl"),
		groups = {drink = 1}
	})

	-- Sugar

	register_craftitem(true,nil,"farming:sugar", {
		description = S("Sugar"),
		inventory_image = "farming_sugar.png",
		groups = {food_sugar = 1, flammable = 3}
	})

	-- Baked potato

	register_craftitem(farming.potato,6,"farming:baked_potato", {
		description = S("Baked Potato"),
		inventory_image = "farming_baked_potato.png",
		on_use = core.item_eat(6)
	})
end
