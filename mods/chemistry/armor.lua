
local S = chemistry.getter

local disable_sounds = minetest.settings:get_bool("shields_disable_sounds")
local function play_sound_effect(player, name)
	if not disable_sounds and player then
		local pos = player:get_pos()
		if pos then
			minetest.sound_play(name, {
				pos = pos,
				max_hear_distance = 10,
				gain = 0.5,
			})
		end
	end
end

	local ti = "chemistry:titanium"
	local w = "chemistry:tungsten"
	local wc = "chemistry:tungsten_carbide"
    local mnfe = "chemistry:steel_ingot"
    local co = "chemistry:cobalt"
    local os = "chemistry:osmium"
    local ra = "chemistry:radium"
    local th = "chemistry:thorium"
    local am = "chemistry:americium"
    local ss = "chemistry:stone_ingot"
    local so = "chemistry:obsidian_ingot"
    local sg = "chemistry:strong_gem"

armor.fire_nodes = {
		{"nether:lava_source",      5, 8},
		{"default:lava_source",     5, 8},
		{"default:lava_flowing",    5, 8},
		{"chemistry:lava",     5, 8},
		{"chemistry:lava_flowing",    5, 8},
		{"fire:basic_flame",        3, 4},
		{"fire:permanent_flame",    3, 4},
		{"ethereal:crystal_spike",  2, 1},
		{"ethereal:fire_flower",    2, 1},
		{"nether:lava_crust",       2, 1},
		{"default:torch",           1, 1},
		{"default:torch_ceiling",   1, 1},
		{"default:torch_wall",      1, 1},
		{"chemistry:magnesium_torch",         5, 2},
		{"chemistry:magnesium_torch_ceiling", 5, 2},
		{"chemistry:magnesium_torch_wall",    5, 2},
		{"chemistry:anthracite_torch",         5, 2},
		{"chemistry:anthracite_torch_ceiling", 5, 2},
		{"chemistry:anthracite_torch_wall",    5, 2},
        {"chemistry:mglass", 5, 8},
        {"chemistry:msteel",          5, 8},
        {"chemistry:mcopper",         5, 7},
        {"chemistry:mtin",            2, 4},
        {"chemistry:lbismuth",        2, 5},
        {"chemistry:msteel_flowing",  5, 8},
        {"chemistry:mcopper_flowing", 5, 7},
        {"chemistry:mtin_flowing", 2, 4},
        {"chemistry:mglass_flowing", 5, 8},
        {"chemistry:lbismuth_flowing", 2, 5},
        {"chemistry:loxygen",       16, 10},
		{"chemistry:lnitrogen",       16, 10},
		{"chemistry:lbutane",       16, 10},
		{"chemistry:lmethane",       16, 10},
		{"chemistry:lchlorine",       16, 10},
		{"chemistry:lpropane", 16, 10},
		{"chemistry:lchlorine_flowing",       16, 10},
		{"chemistry:loxygen_flowing",       16, 10},
		{"chemistry:lnitrogen_flowing",       16, 10},
		{"chemistry:lbutane_flowing",       16, 10},
		{"chemistry:lmethane_flowing",       16, 10},
		{"chemistry:lpropane_flowing", 16, 10},
        {"chemistry:magnesium_fire", 8, 6},
		{"chemistry:permanent_magnesium_fire", 8, 6},
		{"chemistry:anthracite_fire", 6, 5},
		{"chemistry:permanent_anthracite_fire", 6, 5},
        {"chemistry:st_lava", 30, 20},
        {"chemistry:st_lava_flowing", 30, 20},
        {"chemistry:st_lava_temp", 30, 20},
        {"chemistry:st_lava_temp_flowing", 30, 20},
        {"chemistry:thermite_burning", 30, 20},
        {"chemistry:thermite_burning_flowing", 30, 20},
        {"chemistry:mtitanium", 6, 10},
        {"chemistry:mtitanium_flowing", 6, 10},
        {"chemistry:mosmium", 35, 22.5},
        {"chemistry:mosmium_flowing", 35, 22.5},
        {"chemistry:mtungsten", 40, 20},
        {"chemistry:mtungsten_flowing", 40, 20}
	},

	armor:register_armor("chemistry:titanium_helmet", {
	description = S("Titanium Helmet"),
		inventory_image = "inv_titanium_helmet.png",
		groups = {armor_head=1, armor_heal=10, armor_use=90, armor_fire=1, armor_radiation = 5},
		armor_groups = {fleshy=15, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor("chemistry:titanium_chestplate", {
	description = S("Titanium Chestplate"),
		inventory_image = "inv_titanium_chestplate.png",
		groups = {armor_torso=1, armor_heal=10, armor_use=90, armor_fire=1, armor_radiation = 5},
		armor_groups = {fleshy=20, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor("chemistry:titanium_leggings", {
	description = S("Titanium Leggings"),
		inventory_image = "inv_titanium_leggings.png",
		groups = {armor_legs=1, armor_heal=10, armor_use=90, armor_fire=1, armor_radiation = 5},
		armor_groups = {fleshy=20, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor("chemistry:titanium_boots", {
	description = S("Titanium Boots"),
		inventory_image = "inv_titanium_boots.png",
		groups = {armor_feet=1, armor_heal=10, armor_use=90, armor_fire=1, armor_radiation = 5},
		armor_groups = {fleshy=15, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor("chemistry:titanium_shield", {
	description = S("Titanium Shield"),
		inventory_image = "inv_titanium_shield.png",
		groups = {armor_shield=1, armor_heal=10, armor_use=90, armor_fire=1, armor_radiation = 5},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=4},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "chemistry:titanium_helmet",
		recipe = {
			{ti, ti, ti},
			{ti, "", ti},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "chemistry:titanium_chestplate",
		recipe = {
			{ti, "", ti},
			{ti, ti, ti},
			{ti, ti, ti},
		},
	})
	minetest.register_craft({
		output = "chemistry:titanium_leggings",
		recipe = {
			{ti, ti, ti},
			{ti, "", ti},
			{ti, "", ti},
		},
	})
	minetest.register_craft({
		output = "chemistry:titanium_boots",
		recipe = {
			{ti, "", ti},
			{ti, "", ti},
		},
	})
	minetest.register_craft({
		output = "chemistry:titanium_shield",
		recipe = {
			{ti, ti, ti},
			{ti, ti, ti},
			{"", ti, ""},
		},
	})

	armor:register_armor("chemistry:cobalt_helmet", {
	description = S("Cobalt Helmet"),
		inventory_image = "inv_cobalt_helmet.png",
		groups = {armor_head=1, armor_heal=12, armor_use=75, armor_fire=1, armor_radiation = 7},
		armor_groups = {fleshy=16, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=1, level=5},
	})

	armor:register_armor("chemistry:cobalt_chestplate", {
	description = S("Cobalt Chestplate"),
		inventory_image = "inv_cobalt_chestplate.png",
		groups = {armor_torso=1, armor_heal=12, armor_use=75, armor_fire=1, armor_radiation = 7},
		armor_groups = {fleshy=25, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=5},
	})

	armor:register_armor("chemistry:cobalt_leggings", {
	description = S("Cobalt Leggings"),
		inventory_image = "inv_cobalt_leggings.png",
		groups = {armor_legs=1, armor_heal=12, armor_use=90, armor_fire=1, armor_radiation = 7},
		armor_groups = {fleshy=25, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=5},
	})

	armor:register_armor("chemistry:cobalt_boots", {
	description = S("Cobalt Boots"),
		inventory_image = "inv_cobalt_boots.png",
		groups = {armor_feet=1, armor_heal=12, armor_use=75, armor_fire=1, armor_radiation = 7},
		armor_groups = {fleshy=16, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=1, level=5},
	})

	armor:register_armor("chemistry:cobalt_shield", {
	description = S("Cobalt Shield"),
		inventory_image = "inv_cobalt_shield.png",
		groups = {armor_shield=1, armor_heal=12, armor_use=75, armor_fire=1, armor_radiation = 7},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=5},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "chemistry:cobalt_helmet",
		recipe = {
			{co, co, co},
			{co, "", co},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "chemistry:cobalt_chestplate",
		recipe = {
			{co, "", co},
			{co, co, co},
			{co, co, co},
		},
	})
	minetest.register_craft({
		output = "chemistry:cobalt_leggings",
		recipe = {
			{co, co, co},
			{co, "", co},
			{co, "", co},
		},
	})
	minetest.register_craft({
		output = "chemistry:cobalt_boots",
		recipe = {
			{co, "", co},
			{co, "", co},
		},
	})
	minetest.register_craft({
		output = "chemistry:cobalt_shield",
		recipe = {
			{co, co, co},
			{co, co, co},
			{"", co, ""},
		},
	})

	armor:register_armor("chemistry:osmium_helmet", {
	description = S("Osmium Helmet"),
		inventory_image = "inv_osmium_helmet.png",
		groups = {armor_head=1, armor_heal=15, armor_use=60, armor_fire=2, armor_radiation = 8.5},
		armor_groups = {fleshy=18, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=6},
	})

	armor:register_armor("chemistry:osmium_chestplate", {
	description = S("Osmium Chestplate"),
		inventory_image = "inv_osmium_chestplate.png",
		groups = {armor_torso=1, armor_heal=18, armor_use=60, armor_fire=3, armor_radiation = 8.5},
		armor_groups = {fleshy=21, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=6},
	})

	armor:register_armor("chemistry:osmium_leggings", {
	description = S("Osmium Leggings"),
		inventory_image = "inv_osmium_leggings.png",
		groups = {armor_legs=1, armor_heal=18, armor_use=60, armor_fire=3, armor_radiation = 8.5},
		armor_groups = {fleshy=20, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=6},
	})

	armor:register_armor("chemistry:osmium_boots", {
	description = S("Osmium Boots"),
		inventory_image = "inv_osmium_boots.png",
		groups = {armor_feet=1, armor_heal=15, armor_use=60, armor_fire=2, armor_radiation = 8.5},
		armor_groups = {fleshy=17, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=6},
	})

	armor:register_armor("chemistry:osmium_shield", {
	description = S("Osmium Shield"),
		inventory_image = "inv_osmium_shield.png",
		groups = {armor_shield=1, armor_heal=15, armor_use=60, armor_fire=1, armor_radiation = 8.5},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=6},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "chemistry:osmium_helmet",
		recipe = {
			{os, os, os},
			{os, "", os},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "chemistry:osmium_chestplate",
		recipe = {
			{os, "", os},
			{os, os, os},
			{os, os, os},
		},
	})
	minetest.register_craft({
		output = "chemistry:osmium_leggings",
		recipe = {
			{os, os, os},
			{os, "", os},
			{os, "", os},
		},
	})
	minetest.register_craft({
		output = "chemistry:osmium_boots",
		recipe = {
			{os, "", os},
			{os, "", os},
		},
	})
	minetest.register_craft({
		output = "chemistry:osmium_shield",
		recipe = {
			{os, os, os},
			{os, os, os},
			{"", os, ""},
		},
	})

	armor:register_armor("chemistry:tungsten_helmet", {
	description = S("Tungsten Helmet"),
		inventory_image = "inv_tungsten_helmet.png",
		groups = {armor_head=1, armor_heal=15, armor_use=45, armor_fire=2, armor_radiation = 9.5},
		armor_groups = {fleshy=19, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:tungsten_chestplate", {
	description = S("Tungsten Chestplate"),
		inventory_image = "inv_tungsten_chesplate.png",
		groups = {armor_torso=1, armor_heal=18, armor_use=45, armor_fire=3, armor_radiation = 9.5},
		armor_groups = {fleshy=22, corrosion_resistance = 3},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:tungsten_leggings", {
	description = S("Tungsten Leggings"),
		inventory_image = "inv_tungsten_leggings.png",
		groups = {armor_legs=1, armor_heal=18, armor_use=45, armor_fire=3, armor_radiation = 9.5},
		armor_groups = {fleshy=21, corrosion_resistance = 3},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:tungsten_boots", {
	description = S("Tungsten Boots"),
		inventory_image = "inv_tungsten_boots.png",
		groups = {armor_feet=1, armor_heal=15, armor_use=45, armor_fire=2, armor_radiation = 9.5},
		armor_groups = {fleshy=18, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:tungsten_shield", {
	description = S("Tungsten Shield"),
		inventory_image = "inv_tungsten_shield.png",
		groups = {armor_shield=1, armor_heal=15, armor_use=45, armor_fire=1, armor_radiation = 9.5},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=7},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "chemistry:tungsten_helmet",
		recipe = {
			{w, w, w},
			{w, "", w},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "chemistry:tungsten_chestplate",
		recipe = {
			{w, "", w},
			{w, w, w},
			{w, w, w},
		},
	})
	minetest.register_craft({
		output = "chemistry:tungsten_leggings",
		recipe = {
			{w, w, w},
			{w, "", w},
			{w, "", w},
		},
	})
	minetest.register_craft({
		output = "chemistry:tungsten_boots",
		recipe = {
			{w, "", w},
			{w, "", w},
		},
	})
	minetest.register_craft({
		output = "chemistry:tungsten_shield",
		recipe = {
			{w, w, w},
			{w, w, w},
			{"", w, ""},
		},
	})

	armor:register_armor("chemistry:wc_helmet", {
	description = S("Tungsten Carbide Helmet"),
		inventory_image = "inv_wc_helmet.png",
		groups = {armor_head=1, armor_heal=15, armor_use=40, armor_fire=2, armor_radiation = 9.5},
		armor_groups = {fleshy=19, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:wc_chestplate", {
	description = S("Tungsten Carbide Chestplate"),
		inventory_image = "inv_wc_chesplate.png",
		groups = {armor_torso=1, armor_heal=18, armor_use=40, armor_fire=3, armor_radiation = 9.5},
		armor_groups = {fleshy=22, corrosion_resistance = 3},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:wc_leggings", {
	description = S("Tungsten Carbide Leggings"),
		inventory_image = "inv_wc_leggings.png",
		groups = {armor_legs=1, armor_heal=18, armor_use=40, armor_fire=3, armor_radiation = 9.5},
		armor_groups = {fleshy=21, corrosion_resistance = 3},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:wc_boots", {
	description = S("Tungsten Carbide Boots"),
		inventory_image = "inv_wc_boots.png",
		groups = {armor_feet=1, armor_heal=15, armor_use=40, armor_fire=2, armor_radiation = 9.5},
		armor_groups = {fleshy=18, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=7},
	})

	armor:register_armor("chemistry:wc_shield", {
	description = S("Tungsten Carbide Shield"),
		inventory_image = "inv_wc_shield.png",
		groups = {armor_shield=1, armor_heal=15, armor_use=40, armor_fire=1, armor_radiation = 9.5},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=7},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "chemistry:wc_helmet",
		recipe = {
			{wc, wc, wc},
			{wc, "", wc},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "chemistry:wc_chestplate",
		recipe = {
			{wc, "", wc},
			{wc, wc, wc},
			{wc, wc, wc},
		},
	})
	minetest.register_craft({
		output = "chemistry:wc_leggings",
		recipe = {
			{wc, wc, wc},
			{wc, "", wc},
			{wc, "", wc},
		},
	})
	minetest.register_craft({
		output = "chemistry:wc_boots",
		recipe = {
			{wc, "", wc},
			{wc, "", wc},
		},
	})
	minetest.register_craft({
		output = "chemistry:wc_shield",
		recipe = {
			{wc, wc, wc},
			{wc, wc, wc},
			{"", wc, ""},
		},
	})

	armor:register_armor("chemistry:steel_helmet", {
		description = S("Steel-Manganese Alloy Helmet"),
		inventory_image = "3d_armor_inv_helmet_steel.png^[colorize:red:50",
		groups = {armor_head=1, armor_heal=0, armor_use=700,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=12, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor("chemistry:steel_chestplate", {
		description = S("Steel-Manganese Alloy Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_steel.png^[colorize:red:50",
		groups = {armor_torso=1, armor_heal=0, armor_use=700,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=17, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor("chemistry:steel_leggings", {
		description = S("Steel-Manganese Alloy Leggings"),
		inventory_image = "3d_armor_inv_leggings_steel.png^[colorize:red:50",
		groups = {armor_legs=1, armor_heal=0, armor_use=700,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=17, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor("chemistry:steel_boots", {
		description = S("Steel-Manganese Alloy Boots"),
		inventory_image = "3d_armor_inv_boots_steel.png^[colorize:red:50",
		groups = {armor_feet=1, armor_heal=0, armor_use=700,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=12, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor("chemistry:steel_shield", {
		description = S("Steel-Manganese Alloy Shield"),
		inventory_image = "shields_inv_shield_steel.png^[colorize:red:50",
		groups = {armor_shield=1, armor_heal=0, armor_use=700,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=12},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "chemistry:steel_helmet",
		recipe = {
			{mnfe, mnfe, mnfe},
			{mnfe, "", mnfe},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "chemistry:steel_chestplate",
		recipe = {
			{mnfe, "", mnfe},
			{mnfe, mnfe, mnfe},
			{mnfe, mnfe, mnfe},
		},
	})
	minetest.register_craft({
		output = "chemistry:steel_leggings",
		recipe = {
			{mnfe, mnfe, mnfe},
			{mnfe, "", mnfe},
			{mnfe, "", mnfe},
		},
	})
	minetest.register_craft({
		output = "chemistry:steel_boots",
		recipe = {
			{mnfe, "", mnfe},
			{mnfe, "", mnfe},
		},
	})
	minetest.register_craft({
		output = "chemistry:steel_shield",
		recipe = {
			{mnfe, mnfe, mnfe},
			{mnfe, mnfe, mnfe},
			{"", mnfe, ""},
		},
	})

	armor:register_armor("chemistry:stone_helmet", {
		description = S("Strong Stone Helmet"),
			inventory_image = "inv_stone_helmet.png",
			groups = {armor_head=1, armor_heal=17, armor_use=30, armor_fire=3, armor_radiation=9.9},
			armor_groups = {fleshy=19, corrosion_resistance = 4},
			damage_groups = {cracky=2, snappy=1, level=8},
		})
	
		armor:register_armor("chemistry:stone_chestplate", {
		description = S("Strong Stone Chestplate"),
			inventory_image = "inv_stone_chestplate.png",
			groups = {armor_torso=1, armor_heal=17, armor_use=30, armor_fire=4, armor_radiation=9.9},
			armor_groups = {fleshy=22, corrosion_resistance = 5},
			damage_groups = {cracky=2, snappy=1, level=8},
		})
	
		armor:register_armor("chemistry:stone_leggings", {
		description = S("Strong Stone Leggings"),
			inventory_image = "inv_stone_leggings.png",
			groups = {armor_legs=1, armor_heal=17, armor_use=30, armor_fire=4, physics_speed=2,
            armor_radiation=9.9},
			armor_groups = {fleshy=22, corrosion_resistance = 5},
			damage_groups = {cracky=2, snappy=1, level=8},
		})
	
		armor:register_armor("chemistry:stone_boots", {
		description = S("Strong Stone Boots"),
			inventory_image = "inv_stone_boots.png",
			groups = {armor_feet=1, armor_heal=17, armor_use=30, armor_fire=3,
			physics_jump=0.25, armor_radiation=9.9},
			armor_groups = {fleshy=18, corrosion_resistance = 4},
			damage_groups = {cracky=2, snappy=1, level=8},
		})
	
		armor:register_armor("chemistry:stone_shield", {
		description = S("Strong Stone Shield"),
			inventory_image = "inv_stone_shield.png",
			groups = {armor_shield=1, armor_heal=17, armor_use=30, armor_fire=2, armor_radiation=9.9},
			armor_groups = {fleshy=16},
			damage_groups = {cracky=2, snappy=1, level=8},
			reciprocate_damage = true,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_cracky")
		end,
		})
	
		minetest.register_craft({
			output = "chemistry:stone_helmet",
			recipe = {
				{ss, ss, ss},
				{ss, "", ss},
				{"", "", ""},
			},
		})
		minetest.register_craft({
			output = "chemistry:stone_chestplate",
			recipe = {
				{ss, "", ss},
				{ss, ss, ss},
				{ss, ss, ss},
			},
		})
		minetest.register_craft({
			output = "chemistry:stone_leggings",
			recipe = {
				{ss, ss, ss},
				{ss, "", ss},
				{ss, "", ss},
			},
		})
		minetest.register_craft({
			output = "chemistry:stone_boots",
			recipe = {
				{ss, "", ss},
				{ss, "", ss},
			},
		})
		minetest.register_craft({
			output = "chemistry:stone_shield",
			recipe = {
				{ss, ss, ss},
				{ss, ss, ss},
				{"", ss, ""},
			},
		})
	

	armor:register_armor("chemistry:obsidian_helmet", {
		description = S("Strong Obsidian Helmet"),
			inventory_image = "inv_obsidian_helmet.png",
			groups = {armor_head=1, armor_heal=17, armor_use=10, armor_fire=6},
			armor_groups = {fleshy=19, radiation=20, corrosion_resistance = 6},
			damage_groups = {cracky=2, snappy=1, level=9},
		})
	
		armor:register_armor("chemistry:obsidian_chestplate", {
		description = S("Strong Obsidian Chestplate"),
			inventory_image = "inv_obsidian_chestplate.png",
			groups = {armor_torso=1, armor_heal=17, armor_use=10, armor_fire=9},
			armor_groups = {fleshy=23, radiation=20, corrosion_resistance = 7},
			damage_groups = {cracky=2, snappy=1, level=9},
		})
	
		armor:register_armor("chemistry:obsidian_leggings", {
		description = S("Strong Obsidian Leggings"),
			inventory_image = "inv_obsidian_leggings.png",
			groups = {armor_legs=1, armor_heal=17, armor_use=10, armor_fire=9, physics_speed=2},
			armor_groups = {fleshy=22, radiation=20, corrosion_resistance = 7},
			damage_groups = {cracky=2, snappy=1, level=9},
		})
	
		armor:register_armor("chemistry:obsidian_boots", {
		description = S("Strong Obsidian Boots"),
			inventory_image = "inv_obsidian_boots.png",
			groups = {armor_feet=1, armor_heal=17, armor_use=10, armor_fire=6,
			physics_jump=0.50, armor_feather = 5},
			armor_groups = {fleshy=19, radiation=20, corrosion_resistance = 6},
			damage_groups = {cracky=2, snappy=1, level=9},
		})
	
		armor:register_armor("chemistry:obsidian_shield", {
		description = S("Strong Obsidian Shield"),
			inventory_image = "inv_obsidian_shield.png",
			groups = {armor_shield=1, armor_heal=17, armor_use=10, armor_fire=5},
			armor_groups = {fleshy=16, radiation=20},
			damage_groups = {cracky=2, snappy=1, level=9},
			reciprocate_damage = true,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_cracky")
		end,
		})
	
		minetest.register_craft({
			output = "chemistry:obsidian_helmet",
			recipe = {
				{so, so, so},
				{so, "", so},
				{"", "", ""},
			},
		})
		minetest.register_craft({
			output = "chemistry:obsidian_chestplate",
			recipe = {
				{so, "", so},
				{so, so, so},
				{so, so, so},
			},
		})
		minetest.register_craft({
			output = "chemistry:obsidian_leggings",
			recipe = {
				{so, so, so},
				{so, "", so},
				{so, "", so},
			},
		})
		minetest.register_craft({
			output = "chemistry:obsidian_boots",
			recipe = {
				{so, "", so},
				{so, "", so},
			},
		})
		minetest.register_craft({
			output = "chemistry:obsidian_shield",
			recipe = {
				{so, so, so},
				{so, so, so},
				{"", so, ""},
			},
		})
	

	armor:register_armor("chemistry:strong_gem_helmet", {
		description = S("Strong Gem Helmet"),
			inventory_image = "inv_strong_gem_helmet.png",
			groups = {armor_head=1, armor_heal=19, armor_use=5, armor_fire=8},
			armor_groups = {fleshy=19, radiation=20, corrosion_resistance = 10},
			damage_groups = {cracky=2, snappy=1, level=10},
        light_source = 7,
		})
	
		armor:register_armor("chemistry:strong_gem_chestplate", {
		description = S("Strong Gem Chestplate"),
			inventory_image = "inv_strong_gem_chestplate.png",
			groups = {armor_torso=1, armor_heal=19, armor_use=5, armor_fire=9},
			armor_groups = {fleshy=24, radiation=20, corrosion_resistance = 10},
			damage_groups = {cracky=2, snappy=1, level=10},
        	light_source = 7,
		})
	
		armor:register_armor("chemistry:strong_gem_leggings", {
		description = S("Strong Gem Leggings"),
			inventory_image = "inv_strong_gem_leggings.png",
			groups = {armor_legs=1, armor_heal=19, armor_use=5, armor_fire=9, physics_speed=2,
			physics_jump=0.25},
			armor_groups = {fleshy=22, radiation=20, corrosion_resistance = 10},
			damage_groups = {cracky=2, snappy=1, level=10},
        light_source = 7,
		})
	
		armor:register_armor("chemistry:strong_gem_boots", {
		description = S("Strong Gem Boots"),
			inventory_image = "inv_strong_gem_boots.png",
			groups = {armor_feet=1, armor_heal=19, armor_use=5, armor_fire=7,
			physics_jump=0.75, armor_feather = 10},
			armor_groups = {fleshy=18, radiation=20, corrosion_resistance = 10},
			damage_groups = {cracky=2, snappy=1, level=10},
        light_source = 7,
		})
	
		armor:register_armor("chemistry:strong_gem_shield", {
		description = S("Strong Gem Shield"),
			inventory_image = "inv_strong_gem_shield.png",
			groups = {armor_shield=1, armor_heal=19, armor_use=5, armor_fire=7},
			armor_groups = {fleshy=16, radiation=20},
			damage_groups = {cracky=2, snappy=1, level=10},
			reciprocate_damage = true,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_cracky")
		end,
        light_source = 7,
		})
	
		minetest.register_craft({
			output = "chemistry:strong_gem_helmet",
			recipe = {
				{sg, sg, sg},
				{sg, "", sg},
				{"", "", ""},
			},
		})
		minetest.register_craft({
			output = "chemistry:strong_gem_chestplate",
			recipe = {
				{sg, "", sg},
				{sg, sg, sg},
				{sg, sg, sg},
			},
		})
		minetest.register_craft({
			output = "chemistry:strong_gem_leggings",
			recipe = {
				{sg, sg, sg},
				{sg, "", sg},
				{sg, "", sg},
			},
		})
		minetest.register_craft({
			output = "chemistry:strong_gem_boots",
			recipe = {
				{sg, "", sg},
				{sg, "", sg},
			},
		})
		minetest.register_craft({
			output = "chemistry:strong_gem_shield",
			recipe = {
				{sg, sg, sg},
				{sg, sg, sg},
				{"", sg, ""},
			},
		})
	

if minetest.get_modpath("uraniumstuff") then

	armor:register_armor(":cchemistry:thorium_helmet", {
		description = S("Thorium Helmet"),
		inventory_image = "inv_thorium_helmet.png",
		groups = {armor_head=1, armor_heal=0, armor_use=700,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10, radiation=10, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:thorium_chestplate", {
		description = S("Thorium Chestplate"),
		inventory_image = "inv_thorium_chestplate.png",
		groups = {armor_torso=1, armor_heal=0, armor_use=700,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=15, radiation = 10, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:thorium_leggings", {
		description = S("Thorium Leggings"),
		inventory_image = "inv_thorium_leggings.png",
		groups = {armor_legs=1, armor_heal=0, armor_use=700,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=15, radiation = 10, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:thorium_boots", {
		description = S("Thorium Boots"),
		inventory_image = "inv_thorium_boots.png",
		groups = {armor_feet=1, armor_heal=0, armor_use=700,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10, radiation = 10, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:thorium_shield", {
		description = S("Thorium Shield"),
		inventory_image = "inv_thorium_shield.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=700,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=10, radiation = 10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "cchemistry:thorium_helmet",
		recipe = {
			{th, th, th},
			{th, "", th},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "cchemistry:thorium_chestplate",
		recipe = {
			{th, "", th},
			{th, th, th},
			{th, th, th},
		},
	})
	minetest.register_craft({
		output = "cchemistry:thorium_leggings",
		recipe = {
			{th, th, th},
			{th, "", th},
			{th, "", th},
		},
	})
	minetest.register_craft({
		output = "cchemistry:thorium_boots",
		recipe = {
			{th, "", th},
			{th, "", th},
		},
	})
	minetest.register_craft({
		output = "cchemistry:thorium_shield",
		recipe = {
			{th, th, th},
			{th, th, th},
			{"", th, ""},
		},
	})

	armor:register_armor(":cchemistry:radium_helmet", {
		description = S("Radium Helmet"),
		inventory_image = "inv_radium_helmet.png",
		groups = {armor_head=1, armor_heal=0, armor_use=650,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=12, radiation=20, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:radium_chestplate", {
		description = S("Radium Chestplate"),
		inventory_image = "inv_radium_chestplate.png",
		groups = {armor_torso=1, armor_heal=0, armor_use=650,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=17, radiation = 10, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:radium_leggings", {
		description = S("Radium Leggings"),
		inventory_image = "inv_radium_leggings.png",
		groups = {armor_legs=1, armor_heal=0, armor_use=650,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=17, radiation = 10, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:radium_boots", {
		description = S("Radium Boots"),
		inventory_image = "inv_radium_boots.png",
		groups = {armor_feet=1, armor_heal=0, armor_use=650,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=12, radiation = 10, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
	})

	armor:register_armor(":cchemistry:radium_shield", {
		description = S("Radium Shield"),
		inventory_image = "inv_radium_shield.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=650,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=12, radiation = 10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "cchemistry:radium_helmet",
		recipe = {
			{ra, ra, ra},
			{ra, "", ra},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "cchemistry:radium_chestplate",
		recipe = {
			{ra, "", ra},
			{ra, ra, ra},
			{ra, ra, ra},
		},
	})
	minetest.register_craft({
		output = "cchemistry:radium_leggings",
		recipe = {
			{ra, ra, ra},
			{ra, "", ra},
			{ra, "", ra},
		},
	})
	minetest.register_craft({
		output = "cchemistry:radium_boots",
		recipe = {
			{ra, "", ra},
			{ra, "", ra},
		},
	})
	minetest.register_craft({
		output = "cchemistry:radium_shield",
		recipe = {
			{ra, ra, ra},
			{ra, ra, ra},
			{"", ra, ""},
		},
	})

	armor:register_armor(":cchemistry:americium_helmet", {
	description = S("Americium Helmet"),
		inventory_image = "inv_americium_helmet.png",
		groups = {armor_head=1, armor_heal=12, armor_use=100, armor_fire=1,
			physics_speed=-0.05},
		armor_groups = {fleshy=15, radiation=10, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor(":cchemistry:americium_chestplate", {
	description = S("Americium Chestplate"),
		inventory_image = "inv_americium_chestplate.png",
		groups = {armor_torso=1, armor_heal=12, armor_use=100, armor_fire=1,
			physics_speed=-0.05},
		armor_groups = {fleshy=20, radiation=10, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor(":cchemistry:americium_leggings", {
	description = S("Americium Leggings"),
		inventory_image = "inv_americium_leggings.png",
		groups = {armor_legs=1, armor_heal=12, armor_use=100, armor_fire=1,
			physics_speed=-0.05},
		armor_groups = {fleshy=20, radiation=10, corrosion_resistance = 2},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor(":cchemistry:americium_boots", {
	description = S("Americium Boots"),
		inventory_image = "inv_americium_boots.png",
		groups = {armor_feet=1, armor_heal=12, armor_use=100, armor_fire=1,
			physics_speed=-0.05},
		armor_groups = {fleshy=15, radiation=10, corrosion_resistance = 1},
		damage_groups = {cracky=2, snappy=1, level=4},
	})

	armor:register_armor(":cchemistry:americium_shield", {
	description = S("Americium Shield"),
		inventory_image = "inv_americium_shield.png",
		groups = {armor_shield=1, armor_heal=12, armor_use=100, armor_fire=1,
			physics_speed=-0.05},
		armor_groups = {fleshy=15, radiation=10},
		damage_groups = {cracky=2, snappy=1, level=4},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_metal")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_metal")
		end,
	})

	minetest.register_craft({
		output = "cchemistry:americium_helmet",
		recipe = {
			{am, am, am},
			{am, "", am},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "cchemistry:americium_chestplate",
		recipe = {
			{am, "", am},
			{am, am, am},
			{am, am, am},
		},
	})
	minetest.register_craft({
		output = "cchemistry:americium_leggings",
		recipe = {
			{am, am, am},
			{am, "", am},
			{am, "", am},
		},
	})
	minetest.register_craft({
		output = "cchemistry:americium_boots",
		recipe = {
			{am, "", am},
			{am, "", am},
		},
	})
	minetest.register_craft({
		output = "cchemistry:americium_shield",
		recipe = {
			{am, am, am},
			{am, am, am},
			{"", am, ""},
		},
	})

end
