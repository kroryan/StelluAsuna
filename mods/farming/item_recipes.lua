
local a = farming.recipe_items

local function register_craft(condition,def)
	if condition then
		core.register_craft(def)
	end
end

-- flour recipes

register_craft(farming.grains,{
	output = "farming:flour",
	recipe = {
		{"farming:rye", "farming:rye", "farming:rye"},
		{"farming:rye", a.mortar_pestle, ""}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

register_craft(farming.barley,{
	output = "farming:flour",
	recipe = {
		{"farming:barley", "farming:barley", "farming:barley"},
		{"farming:barley", a.mortar_pestle, ""}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

register_craft(farming.grains,{
	output = "farming:flour",
	recipe = {
		{"farming:oat", "farming:oat", "farming:oat"},
		{"farming:oat", a.mortar_pestle, ""}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

-- multigrain flour

register_craft(farming.barley and farming.grains,{
	type = "shapeless",
	output = "farming:flour_multigrain",
	recipe = {
		"group:food_wheat", "group:food_barley", "group:food_oats",
		"group:food_rye", a.mortar_pestle
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

-- multigrain bread

register_craft(farming.grains,{
	type = "cooking",
	cooktime = 15,
	output = "farming:bread_multigrain",
	recipe = "farming:flour_multigrain"
})

-- sliced bread

register_craft(true,{
	output = "farming:bread_slice 5",
	recipe = {{"group:food_bread", a.cutting_board}},
	replacements = {{"group:food_cutting_board", "farming:cutting_board"}}
})

-- toast

register_craft(true,{
	type = "cooking",
	cooktime = 3,
	output = "farming:toast",
	recipe = "farming:bread_slice"
})

-- toast sandwich

register_craft(true,{
	output = "farming:toast_sandwich",
	recipe = {
		{"farming:bread_slice"},
		{"farming:toast"},
		{"farming:bread_slice"}
	}
})

-- garlic bulb

register_craft(farming.garlic,{
	output = "farming:garlic_clove 8",
	recipe = {{"farming:garlic"}}
})

register_craft(farming.garlic,{
	output = "farming:garlic",
	recipe = {
		{"farming:garlic_clove", "farming:garlic_clove", "farming:garlic_clove"},
		{"farming:garlic_clove", "", "farming:garlic_clove"},
		{"farming:garlic_clove", "farming:garlic_clove", "farming:garlic_clove"}
	}
})

-- garlic braid

register_craft(farming.garlic,{
	output = "farming:garlic_braid",
	recipe = {
		{"farming:garlic", "farming:garlic", "farming:garlic"},
		{"farming:garlic", "farming:garlic", "farming:garlic"},
		{"farming:garlic", "farming:garlic", "farming:garlic"}
	}
})

register_craft(farming.garlic,{
	type = "shapeless",
	output = "farming:garlic 9",
	recipe = {"farming:garlic_braid"}
})

-- corn on the cob

register_craft(farming.corn,{
	type = "cooking",
	cooktime = 10,
	output = "farming:corn_cob",
	recipe = "group:food_corn"
})

-- popcorn

register_craft(farming.corn,{
	output = "farming:popcorn",
	recipe = {
		{"group:food_oil", "group:food_corn", a.pot}
	},
	replacements = {
		{"group:food_pot", "farming:pot"},
		{"group:food_oil", "vessels:glass_bottle"}
	}
})

-- cornstarch

register_craft(farming.corn,{
	output = "farming:cornstarch",
	recipe = {
		{a.mortar_pestle, "group:food_corn_cooked", a.baking_tray},
		{"", "group:food_bowl", ""},
	},
	replacements = {
		{"group:food_mortar_pestle", "farming:mortar_pestle"},
		{"group:food_baking_tray", "farming:baking_tray"}
	}
})

-- ethanol

register_craft(farming.corn, {
	output = "farming:bottle_ethanol",
	recipe = {
		{"group:food_corn", "group:food_corn", "group:food_corn"},
		{"group:food_corn", a.glass_bottle, "group:food_corn"},
		{"group:food_corn", "group:food_corn", "group:food_corn"}
	}
})

-- cup of coffee

register_craft(farming.coffee, {
	output = "farming:coffee_cup",
	recipe = {
		{"group:food_coffee", "group:food_glass_water", a.saucepan}
	},
	replacements = {
		{"group:food_saucepan", "farming:saucepan"}
	}
})

-- bar of dark chocolate

register_craft(farming.cocoa, {
	output = "farming:chocolate_dark",
	recipe = {
		{"group:food_cocoa", "group:food_cocoa", "group:food_cocoa"}
	}
})

-- chocolate block

register_craft(farming.cocoa,{
	output = "farming:chocolate_block",
	recipe = {
		{"farming:chocolate_dark", "farming:chocolate_dark", "farming:chocolate_dark"},
		{"farming:chocolate_dark", "farming:chocolate_dark", "farming:chocolate_dark"},
		{"farming:chocolate_dark", "farming:chocolate_dark", "farming:chocolate_dark"}
	}
})

register_craft(farming.cocoa,{
	output = "farming:chocolate_dark 9",
	recipe = {{"farming:chocolate_block"}}
})

-- chili powder

register_craft(farming.chili,{
	output = "farming:chili_powder",
	recipe = {
		{"farming:chili_pepper", a.mortar_pestle}
	},
	replacements = {{"farming:mortar_pestle", "farming:mortar_pestle"}}
})

-- bowl of chili

register_craft(farming.chili and farming.rice and farming.tomato and farming.chili and farming.beans,{
	output = "farming:chili_bowl",
	recipe = {
		{"group:food_chili_pepper", "group:food_rice", "group:food_tomato"},
		{"group:food_beans", "group:food_bowl", ""}
	}
})

-- carrot juice

register_craft(farming.carrot,{
	output = "farming:carrot_juice",
	recipe = {
		{a.juicer},
		{"group:food_carrot"},
		{"vessels:drinking_glass"}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})

-- blueberry pie

register_craft(farming.blueberry or core.registered_items["default:blueberries"],{
	output = "farming:blueberry_pie",
	recipe = {
		{"group:food_flour", "group:food_sugar", "group:food_blueberries"},
		{"", a.baking_tray, ""}
	},
	replacements = {{"group:food_baking_tray", "farming:baking_tray"}}
})

-- blueberry muffin

register_craft(farming.blueberry or core.registered_items["default:blueberries"],{
	output = "farming:muffin_blueberry 2",
	recipe = {
		{"group:food_blueberries", "group:food_bread", "group:food_blueberries"}
	}
})

-- tomato soup

register_craft(farming.tomato,{
	output = "farming:tomato_soup",
	recipe = {
		{"group:food_tomato"},
		{"group:food_tomato"},
		{"group:food_bowl"}
	}
})

-- filter sea water into river water

register_craft(farming.hemp,{
	output = a.bucket_river_water,
	recipe = {
		{"farming:hemp_fibre"},
		{"farming:hemp_fibre"},
		{a.bucket_water}
	}
})

if farming.mcl then

	register_craft(farming.hemp,{
		output = "mcl_potions:river_water",
		recipe = {
			{"farming:hemp_fibre"},
			{"mcl_potions:water"}
		}
	})
end

-- glass of water

register_craft(true,{
	output = "farming:glass_water 4",
	recipe = {
		{a.drinking_glass, a.drinking_glass},
		{a.drinking_glass, a.drinking_glass},
		{a.bucket_river_water, ""}
	},
	replacements = {{a.bucket_river_water, a.bucket_empty}}
})

register_craft(true,{
	output = "farming:glass_water 4",
	recipe = {
		{a.drinking_glass, a.drinking_glass},
		{a.drinking_glass, a.drinking_glass},
		{a.bucket_water, "farming:hemp_fibre"}
	},
	replacements = {{a.bucket_water, a.bucket_empty}}
})

if minetest.get_modpath("bucket_wooden") then

	register_craft(farming.hemp,{
		output = "farming:glass_water 4",
		recipe = {
			{a.drinking_glass, a.drinking_glass},
			{a.drinking_glass, a.drinking_glass},
			{"group:water_bucket_wooden", "farming:hemp_fibre"}
		},
		replacements = {{"group:water_bucket_wooden", "bucket_wooden:bucket_empty"}}
	})
end

-- sugar cube

register_craft(true,{
	output = "farming:sugar_cube",
	recipe = {
		{a.sugar, a.sugar, a.sugar},
		{a.sugar, a.sugar, a.sugar},
		{a.sugar, a.sugar, a.sugar}
	}
})

register_craft(true,{
	output = a.sugar .. " 9",
	recipe = {{"farming:sugar_cube"}}
})

-- caramel

register_craft(true,{
	type = "cooking",
	cooktime = 6,
	output = "farming:caramel",
	recipe = "group:food_sugar"
})

-- salt

register_craft(true,{
	type = "cooking",
	cooktime = 15,
	output = "farming:salt",
	recipe = a.bucket_water,
	replacements = {{a.bucket_water, a.bucket_empty}}
})

-- salt crystal

register_craft(true,{
	output = "farming:salt 9",
	recipe = {
		{"farming:salt_crystal", a.mortar_pestle}
	},
	replacements = {{"farming:mortar_pestle", "farming:mortar_pestle"}}
})

register_craft(true,{
	output = "farming:salt_crystal",
	recipe = {
		{"farming:salt", "farming:salt", "farming:salt"},
		{"farming:salt", "farming:salt", "farming:salt"},
		{"farming:salt", "farming:salt", "farming:salt"}
	}
})

-- mayonnaise

register_craft(true,{
	output = "farming:mayonnaise",
	recipe = {
		{"group:food_olive_oil", "group:food_lemon"},
		{"group:food_egg", "farming:salt"}
	},
	replacements = {{"farming:olive_oil", a.glass_bottle}}
})

-- rose water

register_craft(true,{
	output = "farming:rose_water",
	recipe = {
		{a.rose, a.rose, a.rose},
		{a.rose, a.rose, a.rose},
		{"group:food_glass_water", a.pot, a.glass_bottle}
	},
	replacements = {
		{"group:food_glass_water", a.drinking_glass},
		{"group:food_pot", "farming:pot"}
	}
})

-- turkish delight

register_craft(true,{
	output = "farming:turkish_delight 4",
	recipe = {
		{"group:food_gelatin", "group:food_sugar", "group:food_gelatin"},
		{"group:food_sugar", "group:food_rose_water", "group:food_sugar"},
		{"group:food_sugar", a.dye_pink, "group:food_sugar"}
	},
	replacements = {
		{"group:food_cornstarch", a.bowl},
		{"group:food_cornstarch", a.bowl},
		{"group:food_rose_water", a.glass_bottle}
	}
})

-- garlic bread

register_craft(farming.garlic,{
	output = "farming:garlic_bread",
	recipe = {
		{"group:food_toast", "group:food_garlic_clove", "group:food_garlic_clove"}
	}
})

-- donuts

register_craft(true,{
	output = "farming:donut 3",
	recipe = {
		{"", "group:food_wheat", ""},
		{"group:food_wheat", "group:food_sugar", "group:food_wheat"},
		{"", "group:food_wheat", ""}
	}
})

register_craft(farming.cocoa,{
	output = "farming:donut_chocolate",
	recipe = {
		{"group:food_cocoa"},
		{"farming:donut"}
	}
})

register_craft(true,{
	output = "farming:donut_apple",
	recipe = {
		{"group:food_apple"},
		{"farming:donut"}
	}
})

-- porridge oats

register_craft(farming.grains and farming.soy,{
	output = "farming:porridge",
	recipe = {
		{"group:food_oats", "group:food_oats", "group:food_oats"},
		{"group:food_oats", "group:food_bowl", "group:food_milk_glass"}
	},
	replacements = {
		{"mobs:glass_milk", a.drinking_glass},
		{"farming:soy_milk", a.drinking_glass}
	}
})

-- jaffa cake

register_craft(farming.soy,{
	output = "farming:jaffa_cake 3",
	recipe = {
		{a.baking_tray, "group:food_egg", "group:food_sugar"},
		{a.flour, "group:food_cocoa", "group:food_orange"},
		{"group:food_milk", "", ""}
	},
	replacements = {
		{"farming:baking_tray", "farming:baking_tray"},
		{"mobs:bucket_milk", a.bucket_empty},
		{"mobs:wooden_bucket_milk", "wooden_bucket:bucket_wood_empty"},
		{"farming:soy_milk", a.drinking_glass}
	}
})

-- apple pie

register_craft(true,{
	output = "farming:apple_pie",
	recipe = {
		{a.flour, "group:food_sugar", "group:food_apple"},
		{"", a.baking_tray, ""}
	},
	replacements = {{"group:food_baking_tray", "farming:baking_tray"}}
})

-- cactus juice

register_craft(true,{
	output = "farming:cactus_juice",
	recipe = {
		{a.juicer},
		{a.cactus},
		{a.drinking_glass}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})

-- pasta

register_craft(true,{
	output = "farming:pasta",
	recipe = {
		{a.flour, "group:food_butter", a.mixing_bowl}
	},
	replacements = {{"group:food_mixing_bowl", "farming:mixing_bowl"}}
})

register_craft(true,{
	output = "farming:pasta",
	recipe = {
		{a.flour, "group:food_oil", a.mixing_bowl}
	},
	replacements = {
		{"group:food_mixing_bowl", "farming:mixing_bowl"},
		{"group:food_oil", a.glass_bottle}
	}
})

-- mac & cheese

register_craft(true,{
	output = "farming:mac_and_cheese",
	recipe = {
		{"group:food_pasta", "group:food_cheese", "group:food_bowl"}
	}
})

-- spaghetti

register_craft(farming.garlic and farming.tomato,{
	output = "farming:spaghetti",
	recipe = {
		{"group:food_pasta", "group:food_tomato", a.saucepan},
		{"group:food_garlic_clove", "group:food_garlic_clove", ""}
	},
	replacements = {{"group:food_saucepan", "farming:saucepan"}}
})

-- korean bibimbap

register_craft(farming.chili and farming.rice and farming.chili and farming.cabbage,{
	output = "farming:bibimbap",
	recipe = {
		{a.skillet, "group:food_bowl", "group:food_egg"},
		{"group:food_rice", "group:food_chicken_raw", "group:food_cabbage"},
		{"group:food_carrot", "group:food_chili_pepper", ""}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

register_craft(farming.chili and farming.cabbage and farming.carrot and farming.chili,{
	output = "farming:bibimbap",
	type = "shapeless",
	recipe = {
		a.skillet, "group:food_bowl", "group:food_mushroom",
		"group:food_rice", "group:food_cabbage", "group:food_carrot",
		"group:food_mushroom", "group:food_chili_pepper"
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- burger

register_craft(farming.lettuce and farming.tomato,{
	output = "farming:burger",
	recipe = {
		{a.bread, "group:food_meat", "group:food_cheese"},
		{"group:food_tomato", "group:food_cucumber", "group:food_onion"},
		{"group:food_lettuce", "", ""}
	}
})

-- salad

register_craft(farming.lettuce and farming.tomato,{
	output = "farming:salad",
	type = "shapeless",
	recipe = {
		"group:food_bowl", "group:food_tomato", "group:food_cucumber",
		"group:food_lettuce", "group:food_oil"
	}
})

-- triple berry smoothie

register_craft(farming.raspberry and farming.blackberry and farming.strawberry,{
	output = "farming:smoothie_berry",
	type = "shapeless",
	recipe = {
		"group:food_raspberries", "group:food_blackberries",
		"group:food_strawberry", "group:food_banana",
		a.drinking_glass
	}
})

-- patatas a la importancia

register_craft(farming.garlic and farming.parsley and farming.potato and farming.onion,{
	output = "farming:spanish_potatoes",
	recipe = {
		{"group:food_potato", "group:food_parsley", "group:food_potato"},
		{"group:food_egg", a.flour, "group:food_onion"},
		{"farming:garlic_clove", "group:food_bowl", a.skillet}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- potato omelette

register_craft(farming.onion and farming.potato,{
	output = "farming:potato_omelet",
	recipe = {
		{"group:food_egg", "group:food_potato", "group:food_onion"},
		{a.skillet, "group:food_bowl", ""}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- paella

register_craft(farming.peas and farming.pepper and farming.rice,{
	output = "farming:paella",
	recipe = {
		{"group:food_rice", a.dye_orange, "farming:pepper_red"},
		{"group:food_peas", "group:food_chicken", "group:food_bowl"},
		{"", a.skillet, ""}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- vanilla flan

register_craft(farming.vanilla and farming.soy,{
	output = "farming:flan",
	recipe = {
		{"group:food_sugar", "group:food_milk", "farming:caramel"},
		{"group:food_egg", "group:food_egg", "farming:vanilla_extract"}
	},
	replacements = {
		{"cucina_vegana:soy_milk", a.drinking_glass},
		{"mobs:bucket_milk", "bucket:bucket_empty"},
		{"mobs:wooden_bucket_milk", "wooden_bucket:bucket_wood_empty"},
		{"farming:vanilla_extract", a.glass_bottle}
	}
})

-- vegan cheese

register_craft(farming.corn and farming.pepper and farming.soy,{
	output = "farming:cheese_vegan",
	recipe = {
		{"farming:soy_milk", "farming:soy_milk", "farming:soy_milk"},
		{"group:food_salt", "group:food_peppercorn", "farming:bottle_ethanol"},
		{"group:food_gelatin", a.pot, ""}
	},
	replacements = {
		{"farming:soy_milk", a.drinking_glass .. " 3"},
		{"farming:pot", "farming:pot"},
		{"farming:bottle_ethanol", a.glass_bottle}
	}
})

register_craft(farming.pepper and farming.soy,{
	output = "farming:cheese_vegan",
	recipe = {
		{"farming:soy_milk", "farming:soy_milk", "farming:soy_milk"},
		{"group:food_salt", "group:food_peppercorn", "group:food_lemon"},
		{"group:food_gelatin", a.pot, ""}
	},
	replacements = {
		{"farming:soy_milk", a.drinking_glass .. " 3"},
		{"farming:pot", "farming:pot"}
	}
})

-- vegan butter

register_craft(farming.soy and farming.sunflower,{
	output = "farming:butter_vegan",
	recipe = {
		{"farming:soy_milk", "farming:sunflower_oil", "farming:soy_milk"},
		{"group:food_salt", a.dye_yellow, "farming:mixing_bowl"}
	},
	replacements = {
		{"farming:soy_milk", a.drinking_glass .. " 2"},
		{"farming:sunflower_oil", a.glass_bottle},
		{"farming:mixing_bowl", "farming:mixing_bowl"}
	}
})

-- onigiri

register_craft(farming.rice,{
	output = "farming:onigiri",
	recipe = {
		{"group:food_rice", "group:food_salt", "group:food_rice"},
		{"", "group:food_seaweed", ""}
	}
})

-- gyoza

register_craft(farming.cabbage and farming.garlic and farming.onion,{
	output = "farming:gyoza 4",
	recipe = {
		{"group:food_cabbage", "group:food_garlic_clove", "group:food_onion"},
		{"group:food_meat_raw", "group:food_salt", a.flour},
		{"", a.skillet, ""}

	},
	replacements = {
		{"group:food_skillet", "farming:skillet"}
	}
})

-- mochi

register_craft(farming.rice,{
	output = "farming:mochi",
	recipe = {
		{"", a.mortar_pestle, ""},
		{"group:food_rice", "group:food_sugar", "group:food_rice"},
		{"", "group:food_glass_water", ""}
	},
	replacements = {
		{"group:food_mortar_pestle", "farming:mortar_pestle"},
		{"group:food_glass_water", a.drinking_glass}
	}
})

-- gingerbread man

register_craft(farming.ginger,{
	output = "farming:gingerbread_man 3",
	recipe = {
		{"", "group:food_egg", ""},
		{"group:food_wheat", "group:food_ginger", "group:food_wheat"},
		{"group:food_sugar", "", "group:food_sugar"}
	}
})

-- mint tea

register_craft(farming.mint,{
	output = "farming:mint_tea",
	recipe = {
		{"group:food_mint", "group:food_mint", "group:food_mint"},
		{"group:food_glass_water", a.juicer, ""}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})

-- onion soup

register_craft(farming.onion,{
	output = "farming:onion_soup",
	recipe = {
		{"group:food_onion", "group:food_onion", "group:food_onion"},
		{"group:food_onion", "group:food_bowl", "group:food_onion"},
		{"", a.pot, ""}
	},
	replacements = {{"farming:pot", "farming:pot"}}
})

-- pea soup

register_craft(farming.peas,{
	output = "farming:pea_soup",
	recipe = {
		{"group:food_peas"},
		{"group:food_peas"},
		{"group:food_bowl"}
	}
})

-- ground pepper

register_craft(farming.pepper, {
	output = "farming:pepper_ground",
	recipe = {
		{"group:food_peppercorn"},
		{a.glass_bottle},
		{a.mortar_pestle}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

-- pineapple ring

register_craft(farming.pineapple, {
	output = "farming:pineapple_ring 5",
	recipe = {{"group:food_pineapple"}},
	replacements = {{"farming:pineapple", "farming:pineapple_top"}}
})

-- pineapple juice

register_craft(farming.pineapple,{
	output = "farming:pineapple_juice",
	recipe = {
		{"group:food_pineapple_ring", "group:food_pineapple_ring",
				"group:food_pineapple_ring"},
		{"", a.drinking_glass, ""},
		{"", a.juicer, ""}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})

register_craft(farming.pineapple,{
	output = "farming:pineapple_juice 2",
	recipe = {
		{a.drinking_glass, "group:food_pineapple", a.drinking_glass},
		{"", a.juicer, ""}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})

-- potato & cucumber salad

register_craft(farming.cucumber and farming.potato,{
	output = "farming:potato_salad",
	recipe = {
		{"group:food_cucumber"},
		{"farming:baked_potato"},
		{"group:food_bowl"}
	}
})

-- melon slice / block

register_craft(farming.melon,{
	output = "farming:melon_8",
	recipe = {
		{"farming:melon_slice", "farming:melon_slice"},
		{"farming:melon_slice", "farming:melon_slice"}
	}
})

register_craft(farming.melon,{
	output = "farming:melon_slice 4",
	recipe = {{"farming:melon_8", a.cutting_board}},
	replacements = {{"farming:cutting_board", "farming:cutting_board"}}
})

-- pumpkin slice / block

register_craft(farming.pumpkin,{
	output = "farming:pumpkin",
	recipe = {
		{"farming:pumpkin_slice", "farming:pumpkin_slice"},
		{"farming:pumpkin_slice", "farming:pumpkin_slice"}
	}
})

register_craft(farming.pumpkin,{
	output = "farming:pumpkin_slice 4",
	recipe = {{"farming:pumpkin", a.cutting_board}},
	replacements = {{"farming:cutting_board", "farming:cutting_board"}}
})

-- pumpkin dough

register_craft(farming.pumpkin,{
	output = "farming:pumpkin_dough",
	recipe = {
		{"group:food_pumpkin_slice", "group:food_flour", "group:food_pumpkin_slice"}
	}
})

-- pumpkin bread

register_craft(farming.pumpkin,{
	type = "cooking",
	output = "farming:pumpkin_bread",
	recipe = "farming:pumpkin_dough",
	cooktime = 10
})

-- raspberry smoothie

register_craft(farming.raspberry,{
	output = "farming:smoothie_raspberry",
	recipe = {
		{a.snow},
		{"group:food_raspberries"},
		{a.drinking_glass}
	}
})

-- rhubarb pie

register_craft(farming.rhubarb,{
	output = "farming:rhubarb_pie",
	recipe = {
		{a.baking_tray, "group:food_sugar", ""},
		{"group:food_rhubarb", "group:food_rhubarb", "group:food_rhubarb"},
		{"group:food_wheat", "group:food_wheat", "group:food_wheat"}
	},
	replacements = {{"group:food_baking_tray", "farming:baking_tray"}}
})

-- rice flour

register_craft(farming.rice,{
	output = "farming:rice_flour",
	recipe = {
		{"farming:rice", "farming:rice", "farming:rice"},
		{"farming:rice", a.mortar_pestle, ""}
	},
	replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
})

-- rice bread

register_craft(farming.rice,{
	type = "cooking",
	cooktime = 15,
	output = "farming:rice_bread",
	recipe = "farming:rice_flour"
})

-- soy sauce

register_craft(farming.soy, {
	output = "farming:soy_sauce",
	recipe = {
		{"group:food_soy", "group:food_salt", "group:food_soy"},
		{a.juicer, a.bucket_water, a.glass_bottle}
	},
	replacements = {
		{a.bucket_water, a.bucket_empty},
		{"group:food_juicer", "farming:juicer"}
	}
})

-- soy milk

register_craft(farming.soy and farming.vanilla and farming.corn, {
	output = "farming:soy_milk",
	recipe = {
		{"group:food_soy", "group:food_soy", "group:food_soy"},
		{"farming:vanilla_extract", "bucket:bucket_water", a.drinking_glass}
	},
	replacements = {
		{a.bucket_water, a.bucket_empty},
		{"farming:vanilla_extract", a.glass_bottle}
	}
})

-- tofu

register_craft(farming.soy,{
	output = "farming:tofu",
	recipe = {
		{"group:food_soy", "group:food_soy", "group:food_soy"},
		{"group:food_soy", "group:food_soy", a.baking_tray}
	},
	replacements = {{"farming:baking_tray", "farming:baking_tray"}}
})

-- cooked tofu

register_craft(true,{
	type = "cooking",
	output = "farming:tofu_cooked",
	recipe = "farming:tofu",
	cooktime = 5
})

-- vanilla extract

register_craft(farming.corn and farming.vanilla, {
	output = "farming:vanilla_extract",
	recipe = {
		{"group:food_vanilla", "group:food_vanilla", "group:food_vanilla"},
		{"group:food_vanilla", "farming:bottle_ethanol", "group:food_glass_water"},
	},
	replacements = {
		{"group:food_glass_water", a.drinking_glass}
	}
})

-- jerusalem artichokes

register_craft(farming.artichoke and farming.soy and farming.garlic,{
	output = "farming:jerusalem_artichokes",
	recipe = {
		{"group:food_artichoke", "group:food_garlic_clove", "group:food_artichoke"},
		{"group:food_soy", "group:food_salt", "group:food_soy"},
		{"group:food_butter", "group:food_skillet", "group:food_bowl"}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- wooden scarecrow base

register_craft(farming.pumpkin,{
	output = "farming:scarecrow_bottom",
	recipe = {
		{"", "group:stick", ""},
		{"group:stick", "group:stick", "group:stick"},
		{"", "group:stick", ""}
	}
})

-- beanpole

register_craft(farming.beans,{
	output = "farming:beanpole",
	recipe = {
		{"", "", ""},
		{"group:stick", "", "group:stick"},
		{"group:stick", "", "group:stick"}
	}
})

-- trellis

register_craft(farming.grapes,{
	output = "farming:trellis",
	recipe = {
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "group:stick", "group:stick"}
	}
})

-- cotton to wool

register_craft(true,{
	output = a.wool,
	recipe = {
		{"farming:cotton", "farming:cotton"},
		{"farming:cotton", "farming:cotton"}
	}
})

-- string

register_craft(true,{
	output = a.string .. " 2",
	recipe = {
		{"farming:cotton"},
		{"farming:cotton"}
	}
})

-- saucepan

register_craft(true,{
	output = "farming:saucepan",
	recipe = {
		{a.steel_ingot, "", ""},
		{"", "group:stick", ""}
	}
})

-- cooking pot

register_craft(true,{
	output = "farming:pot",
	recipe = {
		{"group:stick", a.steel_ingot, a.steel_ingot},
		{"", a.steel_ingot, a.steel_ingot}
	}
})

-- baking tray

register_craft(true,{
	output = "farming:baking_tray",
	recipe = {
		{a.clay_brick, a.clay_brick, a.clay_brick},
		{a.clay_brick, "", a.clay_brick},
		{a.clay_brick, a.clay_brick, a.clay_brick}
	}
})

-- skillet

register_craft(true,{
	output = "farming:skillet",
	recipe = {
		{a.steel_ingot, "", ""},
		{"", a.steel_ingot, ""},
		{"", "", "group:stick"}
	}
})

-- mortar & pestle

register_craft(true,{
	output = "farming:mortar_pestle",
	recipe = {
		{"group:stone", "group:stick", "group:stone"},
		{"", "group:stone", ""}
	}
})

-- cutting board

register_craft(true,{
	output = "farming:cutting_board",
	recipe = {
		{a.steel_ingot, "", ""},
		{"", "group:stick", ""},
		{"", "", "group:wood"}
	}
})

-- juicer

register_craft(true,{
	output = "farming:juicer",
	recipe = {
		{"", "group:stone", ""},
		{"group:stone", "", "group:stone"}
	}
})

-- glass mixing bowl

register_craft(true,{
	output = "farming:mixing_bowl",
	recipe = {
		{a.glass, "group:stick", a.glass},
		{"", a.glass, ""}
	}
})

register_craft(true, {
	output = "vessels:glass_fragments",
	recipe = {{"farming:mixing_bowl"}}
})

-- hemp oil

register_craft(farming.hemp, {
	output = "farming:hemp_oil",
	recipe = {
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"", a.glass_bottle, ""}
	}
})

register_craft(farming.hemp, {
	output = "farming:hemp_oil",
	recipe = {
		{"farming:seed_hemp", "farming:seed_hemp", "farming:seed_hemp"},
		{"farming:seed_hemp", "farming:seed_hemp", "farming:seed_hemp"},
		{"farming:seed_hemp", a.glass_bottle, "farming:seed_hemp"}
	}
})

-- hemp fibre

register_craft(farming.hemp, {
	output = "farming:hemp_fibre 8",
	recipe = {
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"farming:hemp_leaf", "group:water_bucket", "farming:hemp_leaf"},
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"}
	},
	replacements = {{"group:water_bucket", a.bucket_empty}}
})

if minetest.get_modpath("bucket_wooden") then

	register_craft(farming.hemp, {
		output = "farming:hemp_fibre 8",
		recipe = {
			{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
			{"farming:hemp_leaf", "group:water_bucket_wooden", "farming:hemp_leaf"},
			{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"}
		},
		replacements = {{"group:water_bucket_wooden", "bucket_wooden:bucket_empty"}}
	})
end

-- hemp block

register_craft(farming.hemp, {
	output = "farming:hemp_block",
	recipe = {
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"},
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"},
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"}
	}
})

-- hemp rope

register_craft(farming.hemp, {
	output = "farming:hemp_rope 6",
	recipe = {
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"},
		{"farming:cotton", "farming:cotton", "farming:cotton"},
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"}
	}
})

-- paper

register_craft(farming.hemp, {
	output = a.paper .. " 3",
	recipe = {
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"}
	}
})

-- straw

local tmp = farming.mcl and "farming:rye" or "farming:wheat"

register_craft(true,{
	output = "farming:straw 3",
	recipe = {
		{tmp, tmp, tmp},
		{tmp, tmp, tmp},
		{tmp, tmp, tmp}
	}
})

register_craft(true,{
	output = tmp .. " 3",
	recipe = {{"farming:straw"}}
})

--= Recipes we shouldn't add when using Mineclonia/VoxeLibre

if not farming.mcl then

	-- Wheat flour

	register_craft(true,{
		output = "farming:flour",
		recipe = {
			{"farming:wheat", "farming:wheat", "farming:wheat"},
			{"farming:wheat", a.mortar_pestle, ""}
		},
		replacements = {{"group:food_mortar_pestle", "farming:mortar_pestle"}}
	})

	-- Bread

	register_craft(true,{
		type = "cooking",
		cooktime = 15,
		output = "farming:bread",
		recipe = "farming:flour"
	})

	-- Cocoa beans

	register_craft(farming.cocoa,{
		type = "cooking",
		cooktime = 5,
		output = "farming:cocoa_beans",
		recipe = "farming:cocoa_beans_raw"
	})

	-- Chocolate cookie

	register_craft(farming.cocoa, {
		output = "farming:cookie 8",
		recipe = {
			{"group:food_wheat", "group:food_cocoa", "group:food_wheat" }
		}
	})

	-- Golden carrot

	register_craft(farming.carrot,{
		output = "farming:carrot_gold",
		recipe = {{"group:food_carrot", "default:gold_lump"}}
	})

	-- Beetroot soup

	register_craft(farming.beetroot,{
		output = "farming:beetroot_soup",
		recipe = {
			{"group:food_beetroot", "group:food_beetroot", "group:food_beetroot"},
			{"group:food_beetroot", "group:food_bowl", "group:food_beetroot"}
		}
	})

	-- Sugar

	register_craft(true,{
		type = "cooking",
		cooktime = 3,
		output = "farming:sugar 2",
		recipe = "default:papyrus"
	})

	-- Baked potato

	register_craft(farming.potato,{
		type = "cooking",
		cooktime = 10,
		output = "farming:baked_potato",
		recipe = "group:food_potato"
	})

	-- Toasted sunflower seeds

	register_craft(farming.sunflower,{
		type = "cooking",
		cooktime = 10,
		output = "farming:sunflower_seeds_toasted",
		recipe = "farming:seed_sunflower"
	})

	-- Sunflower oil

	local tmp = "group:food_sunflower_seeds"

	register_craft(farming.sunflower, {
		output = "farming:sunflower_oil",
		recipe = {
			{tmp, tmp, tmp},
			{tmp, tmp, tmp},
			{tmp, a.glass_bottle, tmp}
		}
	})

	-- Sunflower seed bread

	register_craft(farming.sunflower,{
		output = "farming:sunflower_bread",
		recipe = {
			{
				"group:food_sunflower_seeds_toasted",
				"group:food_bread",
				"group:food_sunflower_seeds_toasted"
			}
		}
	})

	-- Jack 'o lantern

	register_craft(farming.pumpkin,{
		output = "farming:jackolantern",
		recipe = {
			{"default:torch"},
			{"group:food_pumpkin"}
		}
	})

	-- Wooden bowl

	register_craft(true,{
		output = "farming:bowl 4",
		recipe = {
			{"group:wood", "", "group:wood"},
			{"", "group:wood", ""}
		}
	})
end

-- dye recipes

register_craft(farming.beans,{output = a.dye_green, recipe = {{"farming:beans"}}})
register_craft(farming.beetroot,{output = a.dye_red, recipe = {{"group:food_beetroot"}}})
register_craft(farming.blueberry,{output = a.dye_blue, recipe = {{"farming:blueberries"}}})
register_craft(farming.chili,{output = a.dye_red, recipe = {{"farming:chili_pepper"}}})
register_craft(farming.cocoa,{output = a.dye_brown, recipe = {{"farming:cocoa_beans"}}})
register_craft(farming.grapes,{output = a.dye_violet, recipe = {{"farming:grapes"}}})
register_craft(farming.onion,{output = a.dye_yellow, recipe = {{"group:food_onion"}}})

-- fuel items

register_craft(true,{type = "fuel", recipe = "farming:straw", burntime = 3})
register_craft(true,{type = "fuel", recipe = "farming:wheat", burntime = 1})
register_craft(true,{type = "fuel", recipe = "farming:bowl",burntime = 10})
register_craft(true,{type = "fuel", recipe = "farming:string", burntime = 1})
register_craft(true,{type = "fuel", recipe = "farming:cotton", burntime = 1})
register_craft(farming.barley,{type = "fuel", recipe = "farming:barley", burntime = 1})
register_craft(farming.beans,{type = "fuel", recipe = "farming:beanpole", burntime = 10})
register_craft(farming.grapes,{type = "fuel", recipe = "farming:trellis", burntime = 15})
register_craft(farming.rice,{type = "fuel", recipe = "farming:rice", burntime = 1})
register_craft(farming.rice,{type = "fuel", recipe = "farming:rice_bread", burntime = 1})
register_craft(farming.grains,{type = "fuel", recipe = "farming:bread_multigrain", burntime = 1})
register_craft(farming.grains,{type = "fuel", recipe = "farming:rye", burntime = 1})
register_craft(farming.grains,{type = "fuel", recipe = "farming:oat", burntime = 1})
register_craft(farming.hemp,{type = "fuel", recipe = "farming:hemp_oil",
		burntime = 20, replacements = {{"farming:hemp_oil", a.glass_bottle}}})
register_craft(farming.corn,{type = "fuel", recipe = "farming:bottle_ethanol",
		burntime = 80, replacements = {{"farming:bottle_ethanol", a.glass_bottle}}})
register_craft(farming.sunflower,{type = "fuel", recipe = "farming:sunflower_oil",
		burntime = 30, replacements = {{"farming:sunflower_oil", a.glass_bottle}}})
register_craft(farming.vanilla and farming.corn,{type = "fuel", recipe = "farming:vanilla_extract",
		burntime = 25, replacements = {{"farming:vanilla_extract", a.glass_bottle}}})
