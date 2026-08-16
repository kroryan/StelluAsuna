minetest.register_node("dorwinion:dorwinion_brick", {
	description = "Dorwninion Brick",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dorwinion_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "dorwinion:dorwinion_brick 4",
	recipe = {
		{"dorwinion:dorwinion", "dorwinion:dorwinion"},
		{"dorwinion:dorwinion", "dorwinion:dorwinion"},
	}
})
minetest.register_node("dorwinion:dorwinion_brick_with_flowers", {
	description = "Dorwninion Brick With Flowers",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dorwinion_brick_with_flowers.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "dorwinion:dorwinion_brick_with_flowers 2",
	recipe = {
		{"dorwinion:dorwinion_brick", "flowers:rose"},
		{"dorwinion:dorwinion_brick", "flowers:rose"},
	}
})

minetest.register_node("dorwinion:dorwinion_brick_with_moss", {
	description = "Dorwninion Brick With Moss",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dorwinion_brick_with_moss.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "dorwinion:dorwinion_brick_with_moss 3",
	recipe = {
		{"dorwinion:dorwinion_brick", "bucket:bucket_water"},
		{"dorwinion:dorwinion_brick", "dorwinion:dorwinion_brick"},
	}
})

minetest.register_node("dorwinion:dorwinion_carved", {
	description = "Dorwninion Carved",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dorwinion_carved.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "dorwinion:dorwinion_carved 4",
	recipe = {
		{"dorwinion:dorwinion_brick", "dorwinion:dorwinion_brick_cracked"},
		{"dorwinion:dorwinion_brick_cracked", "dorwinion:dorwinion_brick"},
	}
})

minetest.register_node("dorwinion:dorwinion_brick_cracked", {
	description = "Dorwninion Brick Cracked",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dorwinion_brick_cracked.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "dorwinion:dorwinion_brick_cracked 4",
	recipe = {
		{"dorwinion:dorwinion_brick", "dorwinion:dorwinion_brick"},
		{"dorwinion:dorwinion_brick", "dorwinion:dorwinion_brick"},
	}
})

minetest.register_node("dorwinion:dorwinion", {
	description = "Dorwninion",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dorwinion.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("dorwinion:dorwinion_leaves", {
	description = "Dorwinion Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"dorwinion_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"dorwinion:dorwinion_sapling_1"}, rarity = 80},
			{items = {"dorwinion:dorwinion_sapling_2"}, rarity = 80},
			{items = {"dorwinion:dorwinion_sapling_3"}, rarity = 80},
			{items = {"dorwinion:dorwinion_sapling_4"}, rarity = 80},
			{items = {"dorwinion:dorwinion_leaves"}} -- ~95% chance for leaves
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})

minetest.register_node("dorwinion:dorwinion_glow_leaves", {
	description = "Dorwinion Glowing Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"dorwinion_glow_leaves.png"},
	paramtype = "light",
	light_source = 10,    
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"dorwinion:dorwinion_glow_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})

minetest.register_node("dorwinion:dorwinion_grass", {
	description = "Dorwinion Grass",
	tiles = {"dorwinion_grass.png", "dorwinion.png",
		{name = "dorwinion.png^dorwinion_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "dorwinion:dorwinion",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

local modpath = minetest.get_modpath("dorwinion")
local leaves = "dorwinion:dorwinion_leaves"
local stick = "default:stick"

local trees = {
	{
		name = "Short Aspen",
		recipe = {
			{leaves, leaves, leaves},
			{leaves, stick, leaves},
			{"", stick, ""},
		},
		grow_function = function(pos)
			minetest.remove_node(pos)
			minetest.place_schematic({x = pos.x-4, y = pos.y, z = pos.z-3}, modpath.."/schematics/tree_2.mts", "0", nil, false)
		end,
	},
	{
		name = "Tall Aspen",
		recipe = {
			{leaves, leaves, leaves},
			{stick, leaves, stick},
			{"", stick, ""},
		},
		grow_function = function(pos)
			minetest.remove_node(pos)
			minetest.place_schematic({x = pos.x-12, y = pos.y, z = pos.z-12}, modpath.."/schematics/tree_4.mts", "0", nil, false)
		end,
	},
	{
		name = "Short Oak",
		recipe = {
			{"", leaves, ""},
			{leaves, leaves, leaves},
			{"", stick, ""},
		},
		grow_function = function(pos)
			minetest.remove_node(pos)
			minetest.place_schematic({x = pos.x-5, y = pos.y, z = pos.z-5}, modpath.."/schematics/tree_3.mts", "0", nil, false)
		end,
	},
	{
		name = "Tall Oak",
		recipe = {
			{"", leaves, ""},
			{leaves, stick, leaves},
			{"", stick, ""},
		},
		grow_function = function(pos)
			minetest.remove_node(pos)
			minetest.place_schematic({x = pos.x-4, y = pos.y, z = pos.z-4}, modpath.."/schematics/tree_5.mts", "0", nil, false)
		end,
	},
}

local mod_bonemeal = minetest.get_modpath("bonemeal")

for index,def in ipairs(trees) do
	local sapling = "dorwinion:dorwinion_sapling_" .. index
	local image = "dorwinion_sapling_" .. index .. ".png"

	-- Register sapling
	minetest.register_node(sapling, {
		description = def.name .. " Dorwinion Sapling",
		drawtype = "plantlike",
		tiles = {image},
		inventory_image = image,
		wield_image = image,
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		on_timer = function(pos)
			if not default.can_grow(pos) then
				-- try a bit later again
				minetest.get_node_timer(pos):start(math.random(240, 600))
			else
				minetest.remove_node(pos)
				def.grow_function(pos)
			end
		end,
		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
		},
		groups = {snappy = 2, dig_immediate = 3, flammable = 2,
			attached_node = 1, sapling = 1},
		sounds = default.node_sound_leaves_defaults(),

		on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,

		on_place = function(itemstack, placer, pointed_thing)
			itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
				sapling,
				-- minp, maxp to be checked, relative to sapling pos
				{x = -1, y = 0, z = -1},
				{x = 1, y = 1, z = 1},
				-- maximum interval of interior volume check
				2)

			return itemstack
		end,
	})

	-- Register sapling crafting recipe
	minetest.register_craft({
		output = sapling,
		recipe = def.recipe,
	})

	-- Add bonemeal integration if supported
	if mod_bonemeal then
		bonemeal:add_sapling({
			{sapling, def.grow_function, "soil"},
		})
	end
end
