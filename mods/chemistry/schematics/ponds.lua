
local _ = {name = "air", param1 = 0}
local a = {name = "air", param1 = 255, force_place = true}
local w = {name = "chemistry:cesium_block", param1 = 255, force_place = true}
local C = {name = "chemistry:alkaline_sand", param1 = 255, force_place = true}
local D = {name = "chemistry:alkaline_sand", param1 = 255, force_place = true}
local M = {name = "chemistry:alkaline_sandstone", param1 = 127, force_place = true}
local i = {name = "chemistry:cesium_crystal", param1 = 127, force_place = true}

chemistry.cesium_pond = {

	size = {x = 12, y = 4, z = 15},

	data = {

		_,_,_,_,_,_,_,_,_,_,_,_,	_,_,_,_,D,D,D,D,_,_,_,_,	_,_,_,a,a,a,i,a,a,_,_,_,
				_,_,_,_,a,a,a,a,_,_,_,_,
		_,_,_,_,_,C,C,_,_,_,_,_,	_,_,D,D,M,w,w,D,M,_,_,_,	_,_,a,a,a,a,a,a,a,a,a,_,
				_,_,a,a,a,a,a,a,a,_,_,_,
		_,_,_,C,C,C,C,C,_,_,_,_,	_,M,D,w,w,w,w,w,D,D,_,_,	_,a,a,a,a,a,a,a,a,i,a,a,
				_,a,a,a,a,a,a,a,a,a,_,_,
		_,_,_,C,C,C,C,C,C,C,_,_,	_,D,D,w,w,w,w,w,w,w,M,_,	a,i,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,_,C,C,C,C,C,C,C,_,_,	M,D,M,w,w,w,w,w,w,w,D,_,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,C,C,_,_,	D,D,w,w,w,w,w,w,w,w,D,D,	a,i,a,a,a,a,a,a,a,a,a,i,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,M,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	a,a,a,a,a,a,a,a,a,a,a,i,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,_,C,C,C,C,C,C,C,C,_,_,	_,D,w,w,w,w,w,w,w,w,D,M,	i,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,_,C,C,C,C,C,C,C,C,_,_,	_,D,w,w,w,w,w,w,w,w,D,_,	a,i,a,a,a,a,a,a,a,a,a,a,
				_,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,C,_,_,_,	D,D,w,w,w,w,w,w,w,D,D,_,	a,a,a,a,a,a,a,a,a,a,a,i,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,_,_,_,_,	D,D,w,w,w,w,w,w,D,D,_,_,	_,a,a,a,a,a,a,a,a,a,a,_,
				a,a,a,a,a,a,a,a,a,a,_,_,
		_,_,_,C,C,C,C,_,_,_,_,_,	_,M,D,w,w,w,w,D,M,_,_,_,	_,_,i,a,a,a,a,a,a,a,_,_,
				_,a,a,a,a,a,a,a,a,_,_,_,
		_,_,_,_,_,_,_,_,_,_,_,_,	_,_,D,D,D,D,D,D,D,_,_,_,	_,_,_,a,i,a,a,i,a,_,_,_,
				_,_,a,a,a,a,a,a,a,_,_,_,
	
		}
}

minetest.register_node("chemistry:pond1", {
    tiles = {"alkaline_sand.png"},
	is_ground_content = true,
	drops = "chemistry:alkaline_sand",
	groups = {crumbly = 3, falling_node = 1, alkaline_sand = 1, alkaline = 1, not_in_creative_inventory = 1, chemistryschem = 1},
	on_blast = function() end,
	sounds = default.node_sound_sand_defaults(),
})


local _ = {name = "air", param1 = 0}
local a = {name = "air", param1 = 255, force_place = true}
local w = {name = "chemistry:st_lava", param1 = 255, force_place = true}
local C = {name = "chemistry:stone_cobble_glow1", param1 = 255, force_place = true}
local D = {name = "chemistry:stone_cobble_glow1", param1 = 255, force_place = true}
local M = {name = "chemistry:obsidian", param1 = 255, force_place = true}
local MR = {name = "chemistry:st_obsidian_with_gem", param1 = 255, force_place = true}
local i = {name = "chemistry:crystal", param1 = 127, force_place = true}

chemistry.st_lava_pond = {

	size = {x = 12, y = 4, z = 15},

	data = {

		_,_,_,_,_,_,_,_,_,_,_,_,	_,_,_,_,D,D,D,D,_,_,_,_,	_,_,_,_,a,a,i,a,_,_,_,_,
				_,_,_,_,a,a,a,a,_,_,_,_,
		_,_,_,_,_,C,C,_,_,_,_,_,	_,_,D,D,M,w,w,D,M,_,_,_,	_,_,a,a,a,a,a,a,a,_,_,_,
				_,_,a,a,a,a,a,a,a,_,_,_,
		_,_,_,C,C,C,C,C,_,_,_,_,	_,MR,D,w,w,w,w,w,D,D,_,_,	_,a,a,a,a,a,a,a,a,i,_,_,
				_,a,a,a,a,a,a,a,a,a,_,_,
		_,_,_,C,C,C,C,C,C,C,_,_,	_,D,D,w,w,w,w,w,w,w,M,_,	a,i,a,a,a,a,a,a,a,a,a,_,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,_,C,C,C,C,C,C,C,_,_,	M,D,M,w,w,w,w,w,w,w,D,_,	a,a,a,a,a,a,a,a,a,a,a,_,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,C,C,_,_,	D,D,w,w,w,w,w,w,w,w,D,D,	a,a,a,a,a,a,a,a,a,a,a,i,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,M,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	a,a,a,a,a,a,a,a,a,a,a,i,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,_,C,C,C,C,C,C,C,C,_,_,	D,D,w,w,w,w,w,w,w,w,D,M,	i,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,_,C,C,C,C,C,C,C,C,_,_,	D,D,w,w,w,w,w,w,w,w,D,_,	a,a,a,a,a,a,a,a,a,a,a,_,
				_,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,C,_,_,_,	D,D,w,w,w,w,w,w,w,D,D,_,	a,a,a,a,a,a,a,a,a,a,i,_,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,_,_,_,_,	D,D,w,w,w,w,w,w,D,D,_,_,	a,a,a,a,a,a,a,a,a,a,_,_,
				a,a,a,a,a,a,a,a,a,a,_,_,
		_,_,_,C,C,C,C,_,_,_,_,_,	_,M,D,w,w,w,w,D,M,_,_,_,	_,a,a,a,a,a,a,a,a,_,_,_,
				_,a,a,a,a,a,a,a,a,_,_,_,
		_,_,_,_,_,_,_,_,_,_,_,_,	_,_,D,D,D,D,D,D,D,_,_,_,	_,_,a,a,i,a,a,a,a,_,_,_,
				_,_,a,a,a,a,a,a,a,_,_,_,
	
		}
}

minetest.register_node("chemistry:pond2", {
    tiles = {"st_obsidian.png"},
	is_ground_content = true,
	drops = "chemistry:st_obsidian",
	groups = {cracky = 1, strong_obsidian = 1, level = 6, not_in_creative_inventory = 1, chemistryschem = 1},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

local _ = {name = "air", param1 = 0}
local a = {name = "air", param1 = 255, force_place = true}
local w = {name = "chemistry:hso_diluted_water", param1 = 255, force_place = true}
local C = {name = "chemistry:sulfur_block", param1 = 255, force_place = true}
local D = {name = "chemistry:cinnabar", param1 = 255, force_place = true}

chemistry.acid_pond = {

	size = {x = 12, y = 4, z = 15},

	data = {

		_,_,_,_,_,_,_,_,_,_,_,_,	_,_,_,_,D,D,D,D,_,_,_,_,	_,_,_,a,a,a,a,a,a,_,_,_,
				_,_,_,_,a,a,a,a,_,_,_,_,
		_,_,_,_,_,C,C,_,_,_,_,_,	_,_,D,D,D,w,w,D,D,_,_,_,	_,_,a,a,a,a,a,a,a,a,a,_,
				_,_,a,a,a,a,a,a,a,_,_,_,
		_,_,_,C,C,C,C,C,_,_,_,_,	_,D,D,w,w,w,w,w,D,D,_,_,	_,a,a,a,a,a,a,a,a,a,a,a,
				_,a,a,a,a,a,a,a,a,a,_,_,
		_,_,_,C,C,C,C,C,C,C,_,_,	_,D,D,w,w,w,w,w,w,w,D,_,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,_,C,C,C,C,C,C,C,_,_,	D,D,D,w,w,w,w,w,w,w,D,_,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,C,C,_,_,	D,D,w,w,w,w,w,w,w,w,D,D,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,C,C,C,C,C,C,C,C,C,C,_,	D,w,w,w,w,w,w,w,w,w,w,D,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,_,C,C,C,C,C,C,C,C,_,_,	_,D,w,w,w,w,w,w,w,w,D,D,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,a,
		_,_,C,C,C,C,C,C,C,C,_,_,	_,D,w,w,w,w,w,w,w,w,D,_,	a,a,a,a,a,a,a,a,a,a,a,a,
				_,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,C,_,_,_,	D,D,w,w,w,w,w,w,w,D,D,_,	a,a,a,a,a,a,a,a,a,a,a,a,
				a,a,a,a,a,a,a,a,a,a,a,_,
		_,_,C,C,C,C,C,C,_,_,_,_,	D,D,w,w,w,w,w,w,D,D,_,_,	_,a,a,a,a,a,a,a,a,a,a,_,
				a,a,a,a,a,a,a,a,a,a,_,_,
		_,_,_,C,C,C,C,_,_,_,_,_,	_,D,D,w,w,w,w,D,D,_,_,_,	_,_,a,a,a,a,a,a,a,a,_,_,
				_,a,a,a,a,a,a,a,a,_,_,_,
		_,_,_,_,_,_,_,_,_,_,_,_,	_,_,D,D,D,D,D,D,D,_,_,_,	_,_,_,a,a,a,a,a,a,_,_,_,
				_,_,a,a,a,a,a,a,a,_,_,_,
	
		}
}

minetest.register_node("chemistry:pond3", {
    tiles = {"ash_block.png"},
	is_ground_content = true,
	drops = "chemistry:ash_block",
	groups = {oddly_breakable_by_hand = 3, falling_node = 1, not_in_creative_inventory = 1, chemistryschem = 1},
	on_blast = function() end,
	sounds = default.node_sound_sand_defaults(),
})

local math_random = math.random
local replace_with = {}

minetest.register_abm({
	label = "Pond Spawning",
	nodenames = {"group:chemistryschem"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
     local remove = {name="air"}
        if node.name == "chemistry:pond1" then
		    minetest.swap_node(pos, remove)

		        local radius = 7

		        pos.y = pos.y - 1

		        local num = #minetest.find_nodes_in_area(
				    {x = pos.x - radius, y = pos.y, z = pos.z - radius},
				    {x = pos.x + radius, y = pos.y, z = pos.z + radius}, "group:alkaline_sand")

		    if num > 150 then

			    pos.y = pos.y - 1

			    minetest.place_schematic(pos, chemistry.cesium_pond, "random", nil, false,
			    "place_center_x, place_center_z")

				local pos_string = pos and core.pos_to_string(pos) or ""

				core.log("action", "[chemistry] Spawned in a Cesium Pond at " .. pos_string) -- If you have access to the debug.txt archive then this should help find ponds
            end
        elseif node.name == "chemistry:pond2" then
		    minetest.swap_node(pos, remove)

		        local radius = 7

		        pos.y = pos.y - 1

		        local num = #minetest.find_nodes_in_area(
				    {x = pos.x - radius, y = pos.y, z = pos.z - radius},
				    {x = pos.x + radius, y = pos.y, z = pos.z + radius}, "group:strong_stone")

		    if num > 150 then

			    pos.y = pos.y - 1

			    minetest.place_schematic(pos, chemistry.st_lava_pond, "random", nil, false,
			    "place_center_x, place_center_z")

				local pos_string = pos and core.pos_to_string(pos) or ""

				core.log("action", "[chemistry] Spawned in a Strong Lava Pond at " .. pos_string) -- If you have access to the debug.txt archive then this should help find ponds
            end
        elseif node.name == "chemistry:pond3" then
		    minetest.swap_node(pos, remove)

		        local radius = 7

		        pos.y = pos.y - 1

		        local num = #minetest.find_nodes_in_area(
				    {x = pos.x - radius, y = pos.y, z = pos.z - radius},
				    {x = pos.x + radius, y = pos.y, z = pos.z + radius}, "chemistry:dirt_with_ash")

		    if num > 120 then

			    pos.y = pos.y - 1

			    minetest.place_schematic(pos, chemistry.acid_pond, "random", nil, false,
			    "place_center_x, place_center_z")

				local pos_string = pos and core.pos_to_string(pos) or ""

				core.log("action", "[chemistry] Spawned in an Acid Pond at " .. pos_string) -- If you have access to the debug.txt archive then this should help find ponds
            end
		end
	end
})

