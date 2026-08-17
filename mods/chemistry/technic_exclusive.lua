
local S = chemistry.getter

minetest.register_craftitem("chemistry:tungsten_carbide", {
	description = S("Tungsten Carbide Plate"),
	inventory_image = "tungsten_carbide.png",
})

minetest.register_node("chemistry:tungsten_carbide_block", {
	description = S("Tungsten Carbide Block"),
	tiles = {"tungsten_carbide_block.png"},
	is_ground_content = true,
	on_blast = function() end,
	groups = {cracky = 1, level = 7},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	output = 'chemistry:tungsten_carbide_block',
	recipe = {
		{'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide'},
		{'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide'},
		{'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide'},
	}
})

minetest.register_craft({
	output = 'chemistry:tungsten_carbide 9',
	recipe = {
		{'chemistry:tungsten_carbide_block'},
	}
})

minetest.register_node("chemistry:calcium_carbide", {
	description = S("Calcium Carbide"),
	tiles = {"calcium_carbide.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	_tnt_loss = 3,
})

minetest.register_node("chemistry:acetylene", {
	description = S("Acetylene Gas"), -- Acetylene from Calcium Carbide
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"visible_gas.png^[opacity:105"},
	wield_image = "acetylene_wl.png",
	inventory_image = "acetylene_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, flammable_gas = 1, light_gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	on_blast = function(pos)
		minetest.after(0.1, function()
      	minetest.set_node(pos, {name="fire:basic_flame"})
		   minetest.registered_nodes["fire:basic_flame"].on_construct(pos)
      end)
   end,
})

local input_node = {name="chemistry:acetylene"}
	minetest.register_abm({
		label = "chemistry: aluminium ignition",
		nodenames = {"group:water"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"chemistry:calcium_carbide"},
		interval = 1.0,
		chance = 2,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "group:water") then
				minetest.set_node(pos, input_node)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

local remove = {name="air"}
	minetest.register_abm({
		label = "chemistry: aluminium ignition",
		nodenames = {"chemistry:calcium_carbide"}, -- checking for ignition sources because there will be fewer than there are gas nodes
		neighbors = {"group:water"},
		interval = 1.0,
		chance = 15,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				minetest.set_node(pos, remove)
				if math.random() < 0.01 then
					minetest.set_node(pos, {name="air"})
				end
			end	
		end,
	})

minetest.register_craft({
   type = "shapeless",
	output = "chemistry:acetylene 50",
	recipe = {
		"chemistry:calcium_carbide", "bucket:bucket_water"
	},
	replacements = {{'bucket:bucket_water', 'bucket:bucket_empty'}},
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "chemistry:calcium_oxide_lump",
	recipe = "chemistry:limestone_lump"
})

	minetest.register_craftitem("chemistry:calcium_oxide_lump", {
		description = S("Calcium Oxide Lump"),
		inventory_image = "limestone_lump.png^[colorize:white:100",
	})


minetest.register_craftitem("chemistry:molybdenum", {
	description = S("Molybdenum Lump"),
	inventory_image = "molybdenum.png",
})

minetest.register_node("chemistry:mol_alu_block", {
	description = S("Molybdenum-Aluminium alloy Block"),
	tiles = {"mol-alu_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craftitem("chemistry:mol_alu_ingot", {
	description = S("Molybdenum-Aluminium alloy Ingot"),
	inventory_image = "mol-alu_ingot.png"
})

minetest.register_craft({
	output = 'chemistry:mol_alu_block',
	recipe = {
		{'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot'},
		{'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot'},
		{'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot'},
	}
})

minetest.register_craft({
	output = 'chemistry:mol_alu_ingot 9',
	recipe = {
		{'chemistry:mol_alu_block'},
	}
})
