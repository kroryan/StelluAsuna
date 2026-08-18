--Sapling Grow Function

local function add_tree(pos, schem, replace)

	minetest.swap_node(pos, {name = "air"})

	minetest.place_schematic(pos, schem, "random", replace, false,
			"place_center_x, place_center_z")
end

function chemistry.grow_ionized_tree(pos)
	add_tree(pos, chemistry.ionized_tree)
end

function chemistry.grow_anthracite_tree(pos)
	add_tree(pos, chemistry.anthracite_tree)
end

function chemistry.grow_chestnut_tree(pos)
	add_tree(pos, chemistry.chestnut_tree)
end

local function register_sapling_growth(nodename, grow)
	default.register_sapling_growth("chemistry:" .. nodename, {grow = grow})
end

local function after_place_leaves(...)
	return default.after_place_leaves(...)
end

local function grow_sapling(...)
	return default.grow_sapling(...)
end

local function prepare_on_place(itemstack, placer, pointed_thing, name, w, h)

	if sapling_protection_check then

		-- check if grown tree area intersects any players protected area
		return default.sapling_on_place(itemstack, placer, pointed_thing,
				name, {x = -w, y = 1, z = -w}, {x = w, y = h, z = w}, 4)
	end

	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	-- Check if node clicked on has it's own on_rightclick function
	if pdef and pdef.on_rightclick
	and not (placer and placer:is_player() and placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	-- place normally
	return minetest.item_place_node(itemstack, placer, pointed_thing)
end

function chemistry.can_grow_on_stone(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	if minetest.get_item_group(node_under.name, "strong_stone") == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end

function chemistry.register_sapling_growth(name, def)
	default.sapling_growth_defs[name] = {
		can_grow = def.can_grow or chemistry.can_grow_on_stone,
		on_grow_failed = def.on_grow_failed or default.on_grow_failed,
		grow = assert(def.grow)
	}
end

local function register_sapling_growth_on_stone(nodename, grow)
	chemistry.register_sapling_growth("chemistry:" .. nodename, {grow = grow})
end

register_sapling_growth("ionized_sapling", chemistry.grow_ionized_tree)
register_sapling_growth("chestnut_sapling", chemistry.grow_chestnut_tree)
register_sapling_growth_on_stone("anthracite_sapling", chemistry.grow_anthracite_tree)

local S = chemistry.getter

-- Leafdecay Function

local function after_place_leaves(...)
	return default.after_place_leaves(...)
end

local sulfide_noise
local sulfur_buf = {}
--- Custom Mapgen Code for strong stone layers and normal stone layers
-- A function from caverealms

local H_LAG = 10
local H_LAC = 10

function chemistry.above_solid(x,y,z,area,data)
	local c_air = minetest.get_content_id("air")
	
	local c_vac
	if (minetest.get_modpath("moontest")) then
		c_vac = minetest.get_content_id("moontest:vacuum")
	else
		c_vac = minetest.get_content_id("air")
	end
	
	local ai = area:index(x,y+1,z-3)
	if data[ai] == c_air or data[ai] == c_vac then
		return false
	else
		return true
	end
end
function chemistry.below_solid(x,y,z,area,data)
	local c_air = minetest.get_content_id("air")
	
	local c_vac
	if (minetest.get_modpath("moontest")) then
		c_vac = minetest.get_content_id("moontest:vacuum")
	else
		c_vac = minetest.get_content_id("air")
	end
	
	local ai = area:index(x,y-1,z-3)
	if data[ai] == c_air or data[ai] == c_vac then
		return false
	else
		return true
	end
end

--stalagmite spawner
function chemistry.strong_stalagmite(x,y,z, area, data)

	if not chemistry.below_solid(x,y,z,area,data) then
		return
	end
	
	--contest ids
	local c_stone = minetest.get_content_id("chemistry:stone")

	local top = math.random(6,H_LAG) --grab a random height for the stalagmite
	for j = 0, top do --y
		for k = -3, 3 do
			for l = -3, 3 do
				if j == 0 then
					if k*k + l*l <= 9 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j <= top/5 then
					if k*k + l*l <= 4 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j <= top/5 * 3 then
					if k*k + l*l <= 1 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				else
					local vi = area:index(x, y+j, z-3)
					data[vi] = c_stone
				end
			end
		end
	end
end

--stalactite spawner
function chemistry.strong_stalactite(x,y,z, area, data)

	if not chemistry.above_solid(x,y,z,area,data) then
		return
	end

	--contest ids
	local c_stone = minetest.get_content_id("chemistry:stone")

	local bot = math.random(-H_LAC, -6) --grab a random height for the stalagmite
	for j = bot, 0 do --y
		for k = -3, 3 do
			for l = -3, 3 do
				if j >= -1 then
					if k*k + l*l <= 9 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j >= bot/5 then
					if k*k + l*l <= 4 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				elseif j >= bot/5 * 3 then
					if k*k + l*l <= 1 then
						local vi = area:index(x+k, y+j, z+l-3)
						data[vi] = c_stone
					end
				else
					local vi = area:index(x, y+j, z-3)
					data[vi] = c_stone
				end
			end
		end
	end
end

minetest.register_on_generated(function(minp, maxp)

	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local a = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
	local data = vm:get_data(sulfur_buf)
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local pr = PseudoRandom(17 * minp.x + 42 * minp.y + 101 * minp.z)
	sulfide_noise = sulfide_noise or minetest.get_perlin(9876, 3, 0.5, 100)

	local c_petroleum = minetest.get_content_id("chemistry:petroleum")
	local c_petroleum_flowing = minetest.get_content_id("chemistry:petroleum_flowing")
    local c_sulfideseep = minetest.get_content_id("chemistry:sulfide_seep")
	local c_st_stone = minetest.get_content_id("chemistry:stone")
	local c_stone = minetest.get_content_id("default:stone")
	local c_air = minetest.get_content_id("air")
   local c_alk_stone = minetest.get_content_id("chemistry:alkaline_stone")
   local c_alk_cobble = minetest.get_content_id("chemistry:alkaline_stone_cobble")

	local grid_size = 5
   --- Hydrogen Sulfide Seeps Spawning
	for x = minp.x + math.floor(grid_size / 2), maxp.x, grid_size do
	for y = minp.y + math.floor(grid_size / 2), maxp.y, grid_size do
	for z = minp.z + math.floor(grid_size / 2), maxp.z, grid_size do
		local c = data[a:index(x, y, z)]
		if (c == c_petroleum or c == c_petroleum_flowing)
		and sulfide_noise:get3d({x = x, y = z, z = z}) >= 0.4 then
			for i in a:iter(
				math.max(minp.x, x - grid_size),
				math.max(minp.y, y - grid_size),
				math.max(minp.z, z - grid_size),
				math.min(maxp.x, x + grid_size),
				math.min(maxp.y, y + grid_size),
				math.min(maxp.z, z + grid_size)
			) do
				if data[i] == c_stone and pr:next(1, 1) <= 1 then
					data[i] = c_sulfideseep
				end
			end
		end
	end
	end
	end

	for z = z0, z1 do
   	    for y = y0, y1 do
			local vi = area:index(x0, y, z)
			for x = x0, x1 do
				--ceiling
				local ai = area:index(x,y+1,z) --above index
				if data[ai] == c_st_stone and data[vi] == c_air then --ceiling
   	         if math.random() < 0.0003 then
            		chemistry.strong_stalactite(x,y,z, area, data)
               end
            end
				local bi = area:index(x,y-1,z) --below index
				if data[bi] == c_st_stone and data[vi] == c_air then --ground
					local ai = area:index(x,y+1,z)
         	   if math.random() < 0.0002 then
   	   	      chemistry.strong_stalagmite(x,y,z, area, data)
            	end
            end
         end
      end
   end

	vm:set_data(data)
	vm:write_to_map(data)
end)

-- Biomes and Decorations

local math_max, math_min, math_abs, math_floor = math.max, math.min, math.abs, math.floor

-- A function that helps avoid biome overlapping
chemistry.shift_existing_biomes = function(floor_y, ceiling_y)
	local registered_biomes_copy      = {}
	local registered_decorations_copy = {}
	local registered_ores_copy        = {}

	for old_biome_key, old_biome_def in pairs(minetest.registered_biomes) do
	   registered_biomes_copy[old_biome_key] = old_biome_def
	end
	for old_decoration_key, old_decoration_def in pairs(minetest.registered_decorations) do
	   registered_decorations_copy[old_decoration_key] = old_decoration_def
	end
	for old_ore_key, old_ore_def in pairs(minetest.registered_ores) do
		registered_ores_copy[old_ore_key] = old_ore_def
	end

	-- clear biomes, decorations, and ores
	minetest.clear_registered_decorations()
	minetest.clear_registered_ores()
	minetest.clear_registered_biomes()

	-- Restore biomes, adjusted to not overlap
	for biome_key, new_biome_def in pairs(registered_biomes_copy) do
		-- follow similar min_pos/max_pos processing logic as read_biome_def() in l_mapgen.cpp
		local biome_y_max, biome_y_min = 31000, -31000
		if type(new_biome_def.min_pos) == 'table' and type(new_biome_def.min_pos.y) == 'number' then biome_y_min = new_biome_def.min_pos.y end
		if type(new_biome_def.max_pos) == 'table' and type(new_biome_def.max_pos.y) == 'number' then biome_y_max = new_biome_def.max_pos.y end
		if type(new_biome_def.y_min) == 'number' then biome_y_min = new_biome_def.y_min end
		if type(new_biome_def.y_max) == 'number' then biome_y_max = new_biome_def.y_max end

		if biome_y_max > floor_y and biome_y_min < ceiling_y then
			local new_y_min, new_y_max
			local spaceOccupiedAbove = biome_y_max - ceiling_y
			local spaceOccupiedBelow = floor_y - biome_y_min
			if spaceOccupiedAbove >= spaceOccupiedBelow or biome_y_min <= -30000 then
				new_y_min = ceiling_y + 1
				new_y_max = math_max(biome_y_max, ceiling_y + 2)
			else
				new_y_max = floor_y - 1
				new_y_min = math_min(biome_y_min, floor_y - 2)
			end

			if type(new_biome_def.min_pos) == 'table' and type(new_biome_def.min_pos.y) == 'number' then new_biome_def.min_pos.y = new_y_min end
			if type(new_biome_def.max_pos) == 'table' and type(new_biome_def.max_pos.y) == 'number' then new_biome_def.max_pos.y = new_y_max end
			new_biome_def.y_min = new_y_min -- Ensure the new heights are saved, even if original biome never specified one
			new_biome_def.y_max = new_y_max
		end
		minetest.register_biome(new_biome_def)
	end

	-- Restore biome decorations
	for decoration_key, new_decoration_def in pairs(registered_decorations_copy) do
	   minetest.register_decoration(new_decoration_def)
	end
	-- Restore biome ores
	for ore_key, new_ore_def in pairs(registered_ores_copy) do
		minetest.register_ore(new_ore_def)
	 end
 end

-- Shift any overlapping biomes out of the way before we create the Nether biomes
chemistry.shift_existing_biomes(-31000, -11000)

local function register_flower(flower_name)
	minetest.register_decoration({
		name = "flowers:"..flower_name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_max = 30,
		y_min = 1,
      biomes = {"chestnut_forest"},
		decoration = "flowers:"..flower_name,
	})
end

	register_flower(436,     "rose")
	register_flower(19822,   "tulip")
	register_flower(1220999, "dandelion_yellow")
	register_flower(800081,  "chrysanthemum_green")
	register_flower(36662,   "geranium")
	register_flower(1133,    "viola")
	register_flower(73133,   "dandelion_white")
	register_flower(42,      "tulip_black")

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "default:grass_" .. length,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"chestnut_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = "default:grass_" .. length,
	})
end

	register_grass_decoration(-0.03,  0.09,  5)
	register_grass_decoration(-0.015, 0.075, 4)
	register_grass_decoration(0,      0.06,  3)
	register_grass_decoration(0.015,  0.045, 2)
	register_grass_decoration(0.03,   0.03,  1)

	minetest.register_biome({
		name = "alkaline_desert",
		node_top = "chemistry:alkaline_sand",
		depth_top = 4,
		node_filler = "chemistry:alkaline_sandstone",
		depth_filler = 7,
		node_riverbed = "default:sand",
		depth_riverbed = 2,
		node_stone = "chemistry:alkaline_stone",
		node_dungeon = "chemistry:alkaline_sandstone_brick",
		node_dungeon_alt = "chemistry:alkaline_sandstone_brick_cracked",
		node_dungeon_stair = "stairs:stair_alkaline_sandstone_brick",
		y_max = 31000,
		y_min = 3,
		heat_point = 75,
		humidity_point = 45,
	})

	minetest.register_biome({
		name = "ash_forest",
		node_dust = "chemistry:ash",
		node_top = "chemistry:dirt_with_ash",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 2,
		node_riverbed = "chemistry:ash_block",
		depth_riverbed = 2,
		node_dungeon = "chemistry:limestone_brick",
		node_dungeon_alt = "default:limestone",
		node_dungeon_stair = "stairs:stair_limestone_brick",
		node_cave_liquid = {"chemistry:hso_acid"},
		y_max = 120,
		y_min = 26,
		heat_point = 65,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "ash_plains",
		node_dust = "chemistry:ash",
		node_top = "chemistry:dirt_with_ash",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 2,
		node_riverbed = "chemistry:ash_block",
		depth_riverbed = 2,
		node_dungeon = "chemistry:limestone_brick",
		node_dungeon_alt = "default:limestone",
		node_dungeon_stair = "stairs:stair_limestone_brick",
		node_cave_liquid = {"chemistry:hso_acid"},
		y_max = 26,
		y_min = 3,
		heat_point = 65,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "ash_ocean",
		node_dust = "chemistry:ash",
		node_top = "default:silver_sand",
		depth_top = 3,
		node_filler = "default:silver_sand",
		depth_filler = 3,
		node_riverbed = "chemistry:ash_block",
		depth_riverbed = 2,
		node_dungeon = "chemistry:limestone_brick",
		node_dungeon_alt = "default:limestone",
		node_dungeon_stair = "stairs:stair_limestone_brick",
		node_water_top = "chemistry:hso_diluted_water",
		node_cave_liquid = {"chemistry:hso_acid"},
		depth_water_top = 5,
		y_max = 2,
		y_min = -50,
		heat_point = 65,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "acid_caves",
		node_filler = "chemistry:limestone",
		depth_filler = 3,
		node_dungeon = "chemistry:limestone_brick",
		node_dungeon_alt = "default:limestone",
		node_dungeon_stair = "stairs:stair_limestone_brick",
		node_cave_liquid = {"chemistry:petroleum", "chemistry:hso_acid", "default:lava_source"},
		y_max = -50,
		y_min = -5000,
		heat_point = 65,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "alkaline_desert_ocean",
		node_top = "default:sand",
		depth_top = 3,
		node_filler = "default:sand",
		depth_filler = 3,
		node_riverbed = "default:sand",
		depth_riverbed = 2,
		node_stone = "chemistry:alkaline_stone",
		node_dungeon = "chemistry:alkaline_sandstone_brick",
		node_dungeon_alt = "chemistry:alkaline_sandstone_brick_cracked",
		node_dungeon_stair = "stairs:stair_alkaline_sandstone_brick",
		node_water_top = "chemistry:alkaline_water",
		depth_water_top = 40,
		node_cave_liquid = {"chemistry:alkaline_water"},
		y_max = 3,
		y_min = -175,
		heat_point = 75,
		humidity_point = 45,
	})

	minetest.register_biome({
		name = "alkaline_caves",
		node_filler = "chemistry:alkaline_sand",
		depth_filler = 3,
		node_stone = "chemistry:alkaline_stone",
		node_dungeon = "chemistry:alkaline_sandstone_brick",
		node_dungeon_alt = "chemistry:alkaline_sandstone_brick_cracked",
		node_dungeon_stair = "stairs:stair_alkaline_sandstone_brick",
		node_cave_liquid = {"chemistry:cesium", "chemistry:msodium", "chemistry:mpotassium"},
		y_max = -175,
		y_min = -5000,
		heat_point = 75,
		humidity_point = 45,
	})

	minetest.register_biome({
		name = "ionized_forest",
		node_top = "chemistry:dirt_with_uranium",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 3,
		node_riverbed = "chemistry:uranium_dioxide",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 3,
		heat_point = 65,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "chestnut_forest",
		node_top = "default:dirt_with_grass",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 3,
		node_riverbed = "default:sand",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 150,
		y_min = 3,
		heat_point = 107,
		humidity_point = 83,
	})

	minetest.register_biome({
		name = "ionized_ocean",
		node_top = "chemistry:uranium_dioxide",
		depth_top = 1,
		node_filler = "chemistry:uranium_dioxide",
		depth_filler = 3,
		node_riverbed = "chemistry:uranium_dioxide",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		node_water_top = "chemistry:uranium_water",
		node_cave_liquid = {"chemistry:uranium_water"},
		depth_water_top = 40,		
		y_max = 3,
		y_min = -80,
		heat_point = 65,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "ionized_caves",
		node_filler = "chemistry:uranium_dioxide",
		depth_filler = 3,
		node_riverbed = "chemistry:uranium_dioxide",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		node_cave_liquid = {"chemistry:uranium_water"},
		y_max = 3,
		y_min = -80,
		heat_point = 65,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "chestnut_ocean",
		node_top = "default:silver_sand",
		depth_top = 1,
		node_filler = "default:silver_sand",
		depth_filler = 3,
		node_riverbed = "default:silver_sand",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		node_cave_liquid = {"default:water_source"},
		y_max = 3,
		y_min = -50,
		heat_point = 107,
		humidity_point = 83,
	})

	minetest.register_biome({
		name = "chestnut_under",
		node_filler = "default:sand",
		depth_filler = 3,
		node_riverbed = "default:sand",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		node_cave_liquid = {"chemistry:mineral_oil", "default:water_source", "default:lava_source"},
		y_max = -50,
		y_min = -5000,
		heat_point = 107,
		humidity_point = 83,
	})

	minetest.register_biome({
		name = "strong_stone_layer",
		node_filler = "chemistry:uranium_dioxide",
		node_stone = "chemistry:stone",
		node_dungeon = "chemistry:stone_brick",
		node_dungeon_alt = "chemistry:stone_brick_cracked",
		node_dungeon_stair = "stairs:stair_strong_stone_brick",
		y_max = -11000,
		y_min = -29000,
		node_cave_liquid = {"chemistry:msteel", "chemistry:mcopper", "chemistry:mtin", "chemistry:mtitanium", "default:water_source"},
		heat_point = 100,
		humidity_point = 25,
	})

	minetest.register_biome({
		name = "strong_stone_forest",
		node_filler = "chemistry:ash_block",
		node_stone = "chemistry:stone",
		node_dungeon = "chemistry:stone_brick",
		node_dungeon_alt = "chemistry:stone_brick_cracked",
		node_dungeon_stair = "stairs:stair_strong_stone_brick",
		y_max = -11000,
		y_min = -31000,
		node_cave_liquid = {"chemistry:msteel", "chemistry:mcopper", "chemistry:mtin", "chemistry:mtitanium", "default:water_source"},
		heat_point = 95,
		humidity_point = 30,
	})

	minetest.register_biome({
		name = "cold_strong_cave",
		node_filler = "chemistry:dry_ice",
		node_stone = "chemistry:stone",
		node_dungeon = "chemistry:stone_brick",
		node_dungeon_alt = "chemistry:stone_brick_cracked",
		node_dungeon_stair = "stairs:stair_strong_stone_brick",
		y_max = -11000,
		y_min = -31000,
		node_cave_liquid = {"chemistry:lbutane", "chemistry:lmethane", "chemistry:lnitrogen", "chemistry:loxygen"},
		heat_point = -25,
		humidity_point = 25,
	})

	minetest.register_biome({
		name = "hot_strong_cave",
		node_filler = "chemistry:uranium_dioxide",
		node_stone = "chemistry:stone",
		node_dungeon = "chemistry:stone_brick",
		node_dungeon_alt = "chemistry:stone_brick_cracked",
		node_dungeon_stair = "stairs:stair_strong_stone_brick",
		y_max = -11000,
		y_min = -31000,
		node_cave_liquid = {"chemistry:mtitanium", "chemistry:st_lava", "chemistry:mosmium"},
		heat_point = 120,
		humidity_point = 0,
	})

	minetest.register_decoration({
		name = "default:dry_shrub",
		deco_type = "simple",
		place_on = {"chemistry:dirt_with_uranium", "chemistry:dirt_with_ash"},
		sidelen = 16,
		flags = "force_placement",
	    fill_ratio = 0.01,
		y_max = 31000,
		y_min = 0,
		decoration = "default:dry_shrub",
	})

	minetest.register_decoration({
		name = "chemistry:crystal",
		deco_type = "simple",
		place_on = {"chemistry:stone"},
		sidelen = 16,
		flags = "all_floors", "force_placement",
	    fill_ratio = 0.005,
		y_max = -11000,
		y_min = -31000,
		decoration = "chemistry:crystal",
	})

	minetest.register_node("chemistry:growing_crystal_0", {
		description = S("Growing Strong Crystal"),
		drawtype = "plantlike",
		tiles = {"crystal_0.png"},
		inventory_image = "crystal_0.png",
		wield_image = "crystal_0.png",
		paramtype = "light",
		light_source = 1,
		sunlight_propagates = true,
		walkable = false,
		damage_per_second = 0,
		groups = {cracky = 1, attached_node=1, level=3, not_in_creative_inventory = 1, strong_crystal = 1},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		node_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		drop = "",
	})

	minetest.register_node("chemistry:growing_crystal_1", {
		description = S("Growing Strong Crystal"),
		drawtype = "plantlike",
		tiles = {"crystal_1.png"},
		inventory_image = "crystal_1.png",
		wield_image = "crystal_1.png",
		paramtype = "light",
		light_source = 4,
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		damage_per_second = 0,
		groups = {cracky = 1, attached_node=1, level=4, not_in_creative_inventory = 1, strong_crystal = 1},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		node_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		drop = "",
	})

	minetest.register_node("chemistry:growing_crystal_2", {
		description = S("Growing Strong Crystal"),
		drawtype = "plantlike",
		tiles = {"crystal_2.png"},
		inventory_image = "crystal_2.png",
		wield_image = "crystal_2.png",
		paramtype = "light",
		light_source = 7,
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		damage_per_second = 0,
		groups = {cracky = 1, attached_node=1, level=5, not_in_creative_inventory = 1, strong_crystal = 1},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		node_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		drop = "",
	})

	minetest.register_node("chemistry:growing_crystal_3", {
		description = S("Growing Strong Crystal"),
		drawtype = "plantlike",
		tiles = {"crystal_3.png"},
		inventory_image = "crystal_3.png",
		wield_image = "crystal_3.png",
		paramtype = "light",
		light_source = 11,
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		damage_per_second = 0,
		groups = {cracky = 1, attached_node=1, level=6, not_in_creative_inventory = 1, strong_crystal = 1},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		node_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		drop = "",
	})

	minetest.register_node("chemistry:crystal", {
		description = S("Strong Crystal"),
		drawtype = "plantlike",
		tiles = {"crystal.png"},
		inventory_image = "crystal.png",
		wield_image = "crystal.png",
		paramtype = "light",
		light_source = 14,
		sunlight_propagates = true,
		walkable = true,
		damage_per_second = 0,
		groups = {cracky = 1, falling_node=1, level=7, strong_crystal = 1},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		node_box = {
			type = "fixed", fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16}
		},
		drop = "chemistry:crystal_shard",
		on_blast = function() end,
	})

minetest.register_craftitem("chemistry:crystal_shard", {
	description = S("Strong Crystal Shard"),
	inventory_image = "crystal_shard.png",
})

	minetest.register_decoration({
		name = "chemistry:cesium_crystal",
		deco_type = "simple",
		place_on = {"chemistry:alkaline_sand"},
		sidelen = 16,
		flags = "all_floors",
	    fill_ratio = 0.005,
		y_max = 110,
		y_min = -0,
		decoration = "chemistry:cesium_crystal",
	})

-- Nodes and Ores Definitions

minetest.register_node("chemistry:sand_with_lithium", {
	description = S("Sand Lithium Ore"),
	tiles = {"alkaline_sand.png^lithium_mineral.png"},
	is_ground_content = true,
	groups = {crumbly = 3, falling_node = 1, alkaline_sand = 1, alkaline = 1},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:lithium 2'},
			},
			{
				items = {'chemistry:lithium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:sand_with_sodium", {
	description = S("Sand Sodium Ore"),
	tiles = {"alkaline_sand.png^sodium_mineral.png"},
	is_ground_content = true,
	groups = {crumbly = 3, falling_node = 1, alkaline_sand = 1, alkaline = 1},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:sodium 2'},
			},
			{
				items = {'chemistry:sodium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:sand_with_potassium", {
	description = S("Sand Potassium Ore"),
	tiles = {"alkaline_sand.png^potassium_mineral.png"},
	is_ground_content = true,
	groups = {crumbly = 3, falling_node = 1, alkaline_sand = 1, alkaline = 1},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:potassium 2'},
			},
			{
				items = {'chemistry:potassium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:sand_with_rubidium", {
	description = S("Sand Rubidium Ore"),
	tiles = {"alkaline_sand.png^rubidium_mineral.png"},
	is_ground_content = true,
	groups = {crumbly = 3, falling_node = 1, alkaline_sand = 1, alkaline = 1},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:rubidium 2'},
			},
			{
				items = {'chemistry:rubidium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:sand_with_cesium", {
	description = S("Sand Cesium Ore"),
	tiles = {"alkaline_sand.png^cesium_mineral.png"},
	is_ground_content = true,
	groups = {crumbly = 3, falling_node = 1, alkaline_sand = 1, alkaline = 1},
	drop = {
		max_items = 3,
		items = {
			{
				items = {'chemistry:cesium_shard 2'},
			},
			{
				items = {'chemistry:cesium_shard'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:sandstone_with_cesium", {
	description = S("Sandstone Cesium Ore"),
	tiles = {"alkaline_sandstone.png^cesium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_sandstone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:cesium_shard'},
			},
			{
				items = {'chemistry:cesium_shard'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:sandstone_with_lithium", {
	description = S("Sandstone Lithium Ore"),
	tiles = {"alkaline_sandstone.png^lithium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_sandstone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:lithium'},
			},
			{
				items = {'chemistry:lithium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:sandstone_with_sodium", {
	description = S("Sandstone Sodium Ore"),
	tiles = {"alkaline_sandstone.png^sodium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_sandstone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:sodium'},
			},
			{
				items = {'chemistry:sodium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:sandstone_with_potassium", {
	description = S("Sandstone Potassium Ore"),
	tiles = {"alkaline_sandstone.png^potassium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_sandstone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:potassium'},
			},
			{
				items = {'chemistry:potassium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:sandstone_with_rubidium", {
	description = S("Sandstone Rubidium Ore"),
	tiles = {"alkaline_sandstone.png^rubidium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_sandstone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:rubidium'},
			},
			{
				items = {'chemistry:rubidium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alk_stone_with_lithium", {
	description = S("Alkaline Stone Lithium Ore"),
	tiles = {"alkaline_stone.png^lithium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_stone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:lithium'},
			},
			{
				items = {'chemistry:lithium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alk_stone_with_sodium", {
	description = S("Alkaline Stone Sodium Ore"),
	tiles = {"alkaline_stone.png^sodium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_stone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:sodium'},
			},
			{
				items = {'chemistry:sodium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alk_stone_with_potassium", {
	description = S("Alkaline Stone Potassium Ore"),
	tiles = {"alkaline_stone.png^potassium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_stone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:potassium'},
			},
			{
				items = {'chemistry:potassium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alk_stone_with_rubidium", {
	description = S("Alkaline Stone Rubidium Ore"),
	tiles = {"alkaline_stone.png^rubidium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_stone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:rubidium'},
			},
			{
				items = {'chemistry:rubidium'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alk_stone_with_cesium", {
	description = S("Alkaline Stone Cesium Ore"),
	tiles = {"alkaline_stone.png^cesium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_stone = 1, alkaline = 1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'chemistry:cesium_shard'},
			},
			{
				items = {'chemistry:cesium_shard'},
				rarity = 2,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alk_stone_with_francium", {
	description = S("Alkaline Stone Francium Ore"),
	tiles = {"alkaline_stone.png^francium_mineral.png"},
	is_ground_content = true,
	groups = {cracky = 3, falling_node = 0, alkaline_stone = 1, alkaline = 1, radioactive = 1},
	drop = "chemistry:francium",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alkaline_sandstone", {
	description = S("Alkaline Sandstone"),
	tiles = {"alkaline_sandstone.png"},
	groups = {crumbly = 1, cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alkaline_stone", {
	description = S("Alkaline Stone"),
	tiles = {"alkaline_stone.png"},
   drop = "chemistry:alkaline_stone_cobble",
	groups = {cracky = 3, alkaline = 1, alkaline_stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alkaline_stone_cobble", {
	description = S("Alkaline Cobblestone"),
	tiles = {"alkaline_cobblestone.png"},
	groups = {cracky = 3, alkaline = 1, alkaline_stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alkaline_sandstone_brick", {
	description = S("Alkaline Sandstone Brick"),
	tiles = {"alkaline_sandstone_brick.png"},
	groups = {cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alkaline_sandstone_brick_cracked", {
	description = S("Cracked Alkaline Sandstone Brick"),
	tiles = {"alkaline_sandstone_brick_cracked.png"},
	groups = {cracky = 3, alkaline = 1, alkaline_sandstone = 1},
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:alkaline_sandstone_brick"})
   end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alkaline_sandstone_block", {
	description = S("Alkaline Sandstone Block"),
	tiles = {"alkaline_sandstone_block.png"},
	groups = {cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("chemistry:alkaline_sand", {
	description = S("Alkaline Sand"),
	tiles = {"alkaline_sand.png"},
	groups = {crumbly = 3, falling_node = 1, alkaline_sand = 1, alkaline = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "chemistry:alkaline_stone",
	recipe = "chemistry:alkaline_stone_cobble"
})

minetest.register_craft({
	output = 'chemistry:alkaline_sandstone_block 9',
	recipe = {
		{'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone'},
		{'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone'},
		{'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone'},
	}
})

minetest.register_craft({
	output = 'chemistry:alkaline_sandstone_brick 4',
	recipe = {
		{'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone', ''},
		{'chemistry:alkaline_sandstone', 'chemistry:alkaline_sandstone', ''},
		{'', '', ''},
	}
})

-- DungeonsPlus builds outer corners from the biome's stair node. Register the
-- complete stair family so Chemistry's alkaline dungeon material is valid in
-- mapgen as well as in crafting.
stairs.register_stair_and_slab(
	"alkaline_sandstone_brick",
	"chemistry:alkaline_sandstone_brick",
	{cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	{"alkaline_sandstone_brick.png"},
	S("Alkaline Sandstone Brick Stair"),
	S("Alkaline Sandstone Brick Slab"),
	default.node_sound_stone_defaults()
)

stairs.register_stair(
	"alkaline_sandstone",
	"chemistry:alkaline_sandstone",
	{cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	{"alkaline_sandstone.png"},
	S("Alkaline Sandstone Stair"),
	default.node_sound_stone_defaults()
)
stairs.register_slab(
	"alkaline_sandstone",
	"chemistry:alkaline_sandstone",
	{cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	{"alkaline_sandstone.png"},
	S("Alkaline Sandstone Slab"),
	default.node_sound_stone_defaults()
)

stairs.register_stair(
	"alkaline_sandstone_block",
	"chemistry:alkaline_sandstone_block",
	{cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	{"alkaline_sandstone_block.png"},
	S("Alkaline Sandstone Block Stair"),
	default.node_sound_stone_defaults()
)
stairs.register_slab(
	"alkaline_sandstone_block",
	"chemistry:alkaline_sandstone_block",
	{cracky = 3, alkaline = 1, alkaline_sandstone = 1},
	{"alkaline_sandstone_block.png"},
	S("Alkaline Sandstone Block Slab"),
	default.node_sound_stone_defaults()
)

stairs.register_stair(
	"alkaline_stone_cobble",
	"chemistry:alkaline_stone_cobble",
	{cracky = 3, alkaline = 1, alkaline_stone = 1},
	{"alkaline_cobblestone.png"},
	S("Alkaline Cobblestone Stair"),
	default.node_sound_stone_defaults()
)
stairs.register_slab(
	"alkaline_stone_cobble",
	"chemistry:alkaline_stone_cobble",
	{cracky = 3, alkaline = 1, alkaline_stone = 1},
	{"alkaline_cobblestone.png"},
	S("Alkaline Cobblestone Slab"),
	default.node_sound_stone_defaults()
)

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "chemistry:alkaline_sandstone_brick",
	recipe = "chemistry:alkaline_sandstone_brick_cracked"
})

minetest.register_node("chemistry:stone", {
	description = S("Strong Stone"),
	tiles = {"strong_stone.png"},
	groups = {cracky = 1, strong_stone = 1},
	drop = "chemistry:stone_cobble",
	_tnt_loss = 5000,
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:stone_cobble", {
	description = S("Strong Cobblestone"),
	tiles = {"strong_cobblestone.png"},
	groups = {cracky = 1, strong_stone = 1},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:stone_cobble_saturated", {
	description = S("Saturated Strong Cobblestone"),
	tiles = {"strong_cobblestone_saturated.png"},
	groups = {cracky = 1, strong_stone = 2},
	light_source = 4,
	drop = "chemistry:stone_cobble",
	sounds = chemistry.node_sound_strong(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 6,
	output = "chemistry:stone",
	recipe = "chemistry:stone_cobble"
})

minetest.register_node("chemistry:stone_brick", {
	description = S("Strong Stone Brick"),
	tiles = {"strong_stone_brick.png"},
	groups = {cracky = 1, strong_stone = 1, level = 1},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:stone_block", {
	description = S("Strong Stone Block"),
	tiles = {"strong_stone_block.png"},
	groups = {cracky = 1, strong_stone = 1, level = 1},
	sounds = chemistry.node_sound_strong(),
})

minetest.register_node("chemistry:stone_brick_cracked", {
	description = S("Cracked Strong Stone Brick"),
	tiles = {"strong_stone_brick_cracked.png"},
	groups = {cracky = 1, strong_stone = 1},
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:stone_brick"})
   end,
	sounds = chemistry.node_sound_strong(),
})

stairs.register_stair(
	"stone_cobble",
	"chemistry:stone_cobble",
	{cracky = 1, strong_stone = 1, level = 1},
	{"strong_cobblestone.png"},
	S("Strong Cobblestone Stair"),
	chemistry.node_sound_strong()
)
stairs.register_slab(
	"stone_cobble",
	"chemistry:stone_cobble",
	{cracky = 1, strong_stone = 1, level = 1},
	{"strong_cobblestone.png"},
	S("Strong Cobblestone Slab"),
	chemistry.node_sound_strong()
)
stairs.register_stair(
	"st_stone_brick",
	"chemistry:stone_brick",
	{cracky = 1, strong_stone = 1, level = 1},
	{"strong_stone_brick.png"},
	S("Strong Stone Brick Stair"),
	chemistry.node_sound_strong()
)
stairs.register_slab(
	"st_stone_brick",
	"chemistry:stone_brick",
	{cracky = 1, strong_stone = 1, level = 1},
	{"strong_stone_brick.png"},
	S("Strong Stone Brick Slab"),
	chemistry.node_sound_strong()
)
stairs.register_stair(
	"st_stone_block",
	"chemistry:stone_block",
	{cracky = 1, strong_stone = 1, level = 1},
	{"strong_stone_block.png"},
	S("Strong Stone Block Stair"),
	chemistry.node_sound_strong()
)
stairs.register_slab(
	"st_stone_block",
	"chemistry:stone_block",
	{cracky = 1, strong_stone = 1, level = 1},
	{"strong_stone_block.png"},
	S("Strong Stone Block Slab"),
	chemistry.node_sound_strong()
)
minetest.register_craft({
	output = 'chemistry:stone_brick 4',
	recipe = {
		{'chemistry:stone', 'chemistry:stone', ''},
		{'chemistry:stone', 'chemistry:stone', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:stone_block 9',
	recipe = {
		{'chemistry:stone', 'chemistry:stone', 'chemistry:stone'},
		{'chemistry:stone', 'chemistry:stone', 'chemistry:stone'},
		{'chemistry:stone', 'chemistry:stone', 'chemistry:stone'},
	}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "chemistry:stone_brick",
	recipe = "chemistry:stone_brick_cracked"
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:alkaline_stone_cobble",
	wherein        = {"chemistry:alkaline_stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 40,
	clust_size     = 8,
	y_min     = -10000,
	y_max     = 3100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "chemistry:stone",
	wherein        = {"default:stone"},
	clust_scarcity = 4 * 4 * 4,
	clust_num_ores = 20,
	clust_size     = 4,
	y_max     = -10995,
	y_min     = -11000,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 25,
	output = "chemistry:stone_ingot",
	recipe = "chemistry:stone_lump"
})

minetest.register_node("chemistry:stronger_stone_block", {
	description = S("Stronger Stone Block"),
	tiles = {"stronger_stone_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 8},
	on_blast = function() end,
	sounds = chemistry.node_sound_strong(),
})


minetest.register_craft({
	output = 'chemistry:stronger_stone_block',
	recipe = {
		{'chemistry:stone_ingot', 'chemistry:stone_ingot', 'chemistry:stone_ingot'},
		{'chemistry:stone_ingot', 'chemistry:stone_ingot', 'chemistry:stone_ingot'},
		{'chemistry:stone_ingot', 'chemistry:stone_ingot', 'chemistry:stone_ingot'},
	}
})

minetest.register_craft({
	output = 'chemistry:stone_ingot 9',
	recipe = {
		{'chemistry:stronger_stone_block'},
	}
})

minetest.register_craft({
	output = 'chemistry:stone_lump',
	recipe = {
		{'chemistry:crystal_shard', 'chemistry:crystal_shard', 'chemistry:crystal_shard'},
		{'chemistry:crystal_shard', 'chemistry:stone_cobble', 'chemistry:crystal_shard'},
		{'chemistry:crystal_shard', 'chemistry:crystal_shard', 'chemistry:crystal_shard'},
	}
})

minetest.register_node("chemistry:dirt_with_uranium", {
	description = S("Dirt with Uranium"),
	tiles = {{
	name = "uranium_dioxide.png",
	align_style = "world",
	scale       = 2,
        },
	 "default_dirt.png",
		{name = "default_dirt.png^uranium_field.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, radioactive = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "dead_grass_footstep", gain = 0.2},
	}),
})

minetest.register_node("chemistry:ionized_trunk", {
	description = S("Ionized Tree Trunk"),
	tiles = {"ionized_tree_top.png", "ionized_tree_top.png", "ionized_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, radioactive = 1, ionized_wood=1},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("chemistry:ionized_wood", {
	description = S("Ionized Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"ionized_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ionized_wood=1},
	sounds = default.node_sound_wood_defaults(),
})

default.register_fence("chemistry:ionized_wood_fence", {
	description = S("Ionized Wood Fence"),
	texture = "ionized_wood_fence.png",
	inventory_image = "default_fence_overlay.png^ionized_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^ionized_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "chemistry:ionized_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ionized_wood=1},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("chemistry:ionized_wood_fence_rail", {
	description = S("Ionized Wood Fence Rail"),
	texture = "ionized_wood_fence_rail.png",
	inventory_image = "default_fence_rail_overlay.png^ionized_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^ionized_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "chemistry:ionized_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ionized_wood=1},
	sounds = default.node_sound_wood_defaults()
})

stairs.register_stair(
	"ionized_wood",
	"chemistry:ionized_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ionized_wood=1},
	{"ionized_wood.png"},
	S("Ionized Wood Stair"),
	default.node_sound_wood_defaults()
)
stairs.register_slab(
	"ionized_wood",
	"chemistry:ionized_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ionized_wood=1},
	{"ionized_wood.png"},
	S("Ionized Wood Slab"),
	default.node_sound_wood_defaults()
)
minetest.register_node("chemistry:ionized_sapling", {
    description = S("Ionized Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"ionized_sapling.png"},
	inventory_image = "ionized_sapling.png",
	wield_image = "ionized_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1, radioactive = 1, ionized_wood=1},
	sounds = default.node_sound_leaves_defaults(),

	on_timer = grow_sapling,
	
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,
	
	on_place = function(itemstack, placer, pointed_thing)
		return prepare_on_place(itemstack, placer, pointed_thing,
				"chemistry:ionized_sapling", 2, 7)
	end,
})

minetest.register_node("chemistry:ionized_leaves", {
	description = S("Ionized Tree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"ionized_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, radioactive = 1, ionized_wood=1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"chemistry:ionized_sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"chemistry:ionized_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("chemistry:anthracite_trunk", {
	description = S("Anthracite Tree Trunk"),
	tiles = {"anthracite_tree_top.png", "anthracite_tree_top.png", "anthracite_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, anthracite_material = 1},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("chemistry:anthracite_wood", {
	description = S("Anthracite Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"anthracite_wood.png"},
	is_ground_content = false,
	groups = {choppy = 1, oddly_breakable_by_hand = 1, wood = 1, anthracite_material = 1},
	sounds = default.node_sound_wood_defaults(),
})

default.register_fence("chemistry:anthracite_wood_fence", {
	description = S("Anthracite Wood Fence"),
	texture = "anthracite_wood_fence.png",
	inventory_image = "default_fence_overlay.png^anthracite_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^anthracite_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "chemistry:anthracite_wood",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, wood = 1, anthracite_material = 1},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("chemistry:anthracite_wood_fence_rail", {
	description = S("Anthraite Wood Fence Rail"),
	texture = "anthracite_wood_fence_rail.png",
	inventory_image = "default_fence_rail_overlay.png^anthracite_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^anthracite_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "chemistry:anthracite_wood",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, wood = 1, anthracite_material = 1},
	sounds = default.node_sound_wood_defaults()
})

stairs.register_stair(
	"anthracite_wood",
	"chemistry:anthracite_wood",
	{choppy = 1, oddly_breakable_by_hand = 1, wood = 1, anthracite_material = 1},
	{"anthracite_wood.png"},
	S("Anthracite Wood Stair"),
	default.node_sound_wood_defaults()
)
stairs.register_slab(
	"anthracite_wood",
	"chemistry:anthracite_wood",
	{choppy = 1, oddly_breakable_by_hand = 1, wood = 1, anthracite_material = 1},
	{"anthracite_wood.png"},
	S("Anthracite Wood Slab"),
	default.node_sound_wood_defaults()
)

minetest.register_node("chemistry:anthracite_sapling", {
    description = S("Anthracite Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"anthracite_sapling.png"},
	inventory_image = "anthracite_sapling.png",
	wield_image = "anthracite_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3,
		attached_node = 1, sapling = 1, anthracite_material = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_timer = grow_sapling,
	
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,
	
	on_place = function(itemstack, placer, pointed_thing)
		return prepare_on_place(itemstack, placer, pointed_thing,
				"chemistry:anthracite_sapling", 2, 7)
	end,
})

minetest.register_node("chemistry:anthracite_leaves", {
	description = S("Anthracite Tree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"anthracite_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, anthracite_material = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"chemistry:anthracite_sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"chemistry:anthracite_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})


minetest.register_craft({
	output = "chemistry:ionized_wood 4",
	recipe = {
		{"chemistry:ionized_trunk"},
	}
})

minetest.register_craft({
	output = "chemistry:anthracite_wood 4",
	recipe = {
		{"chemistry:anthracite_trunk"},
	}
})

stairs.register_stair(
	"ionized_wood",
	"chemistry:ionized_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ionized_wood=1},
	{"ionized_wood.png"},
	S("Ionized Wood Stair"),
	default.node_sound_wood_defaults()
)
stairs.register_slab(
	"ionized_wood",
	"chemistry:ionized_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ionized_wood=1},
	{"ionized_wood.png"},
	S("Ionized Wood Slab"),
	default.node_sound_wood_defaults()
)

stairs.register_stair(
	"anthracite_wood",
	"chemistry:anthracite_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, anthracite_material = 1},
	{"anthracite_wood.png"},
	S("Anthracite Wood Stair"),
	default.node_sound_wood_defaults()
)
stairs.register_slab(
	"anthracite_wood",
	"chemistry:anthracite_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, anthracite_material = 1},
	{"anthracite_wood.png"},
	S("Anthracite Wood Slab"),
	default.node_sound_wood_defaults()
)


minetest.register_node("chemistry:stone_cobble_glow1", {
	description = S("Strong Cobblestone with Strong Lava"),
	tiles = {
		{
			name = "st_lava_flowing_anim.png^strong_cobblestone_template.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0
			}
		}
	},
	groups = {cracky = 1, strong_stone = 1, igniter = 1},
	drop = "chemistry:stone_cobble",
	sounds = chemistry.node_sound_strong(),
	light_source = default.LIGHT_MAX,
})


minetest.register_node("chemistry:stone_cobble_glow2", {
	description = S("Strong Cobblestone with Molten Metal"),
	tiles = {
		{
			name = "molten_metal_flowing.png^[colorize:yellow:125^strong_cobblestone_template.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.0
			}
		}
	},
	groups = {cracky = 1, strong_stone = 1},
	drop = "chemistry:stone_cobble",
	sounds = chemistry.node_sound_strong(),
	light_source = 14,
})

minetest.register_node("chemistry:stone_cobble_glow3", {
	description = S("Strong Cobblestone with Molten Metal"),
	tiles = {
		{
			name = "lmetal_flowing_anim.png^strong_cobblestone_template.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.0
			}
		}
	},
	groups = {cracky = 1, strong_stone = 1},
	drop = "chemistry:stone_cobble",
	sounds = chemistry.node_sound_strong(),
	light_source = 7,
})

minetest.register_abm({
	label = "chemistry:cobblestone",
	nodenames = {"chemistry:stone_cobble"}, -- checking for ignition sources because there will be fewer than there are gas nodes
	neighbors = {"group:strong_lava"},
	interval = 5.0,
	chance = 7,
	catch_up = true,
	action = function(pos, node)
		minetest.set_node(pos, {name="chemistry:stone_cobble_glow1"})
	end,
})

minetest.register_abm({
	label = "chemistry:cobblestone",
	nodenames = {"chemistry:stone_cobble"}, -- checking for ignition sources because there will be fewer than there are gas nodes
	neighbors = {"group:mmetal"},
	interval = 5.0,
	chance = 7,
	catch_up = true,
	action = function(pos, node)
		minetest.set_node(pos, {name="chemistry:stone_cobble_glow2"})
	end,
})

minetest.register_abm({
	label = "chemistry:cobblestone",
	nodenames = {"chemistry:stone_cobble"}, -- checking for ignition sources because there will be fewer than there are gas nodes
	neighbors = {"group:hot_metal"},
	interval = 5.0,
	chance = 7,
	catch_up = true,
	action = function(pos, node)
		minetest.set_node(pos, {name="chemistry:stone_cobble_glow3"})
	end,
})


minetest.register_node("chemistry:chestnut_trunk", {
	description = S("Chestnut Tree Trunk"),
	tiles = {"chestnut_tree_top.png", "chestnut_tree_top.png", "chestnut_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 1, flammable = 5, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("chemistry:chestnut_wood", {
	description = S("Chestnut Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"chestnut_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, wood = 1, flammable = 5},
	sounds = default.node_sound_wood_defaults(),
})

default.register_fence("chemistry:chestnut_wood_fence", {
	description = S("Chestnut Wood Fence"),
	texture = "chestnut_wood_fence.png",
	inventory_image = "default_fence_overlay.png^chestnut_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^chestnut_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "chemistry:chestnut_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, wood = 1, flammable = 5},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("chemistry:chestnut_wood_fence_rail", {
	description = S("Chestnut Wood Fence Rail"),
	texture = "chestnut_wood_fence_rail.png",
	inventory_image = "default_fence_rail_overlay.png^chestnut_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^chestnut_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "chemistry:chestnut_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, wood = 1, flammable = 5},
	sounds = default.node_sound_wood_defaults()
})

stairs.register_stair(
	"chestnut_wood",
	"chemistry:chestnut_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, wood = 1, flammable = 5},
	{"chestnut_wood.png"},
	S("Chestnut Wood Stair"),
	default.node_sound_wood_defaults()
)
stairs.register_slab(
	"chestnut_wood",
	"chemistry:chestnut_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, wood = 1, flammable = 5},
	{"chestnut_wood.png"},
	S("Chestnut Wood Slab"),
	default.node_sound_wood_defaults()
)

minetest.register_node("chemistry:chestnut_sapling", {
    description = S("Chestnut Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"chestnut_sapling.png"},
	inventory_image = "chestnut_sapling.png",
	wield_image = "chestnut_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3,
		attached_node = 1, sapling = 1, flammable = 5},
	sounds = default.node_sound_leaves_defaults(),

	on_timer = grow_sapling,
	
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,
	
	on_place = function(itemstack, placer, pointed_thing)
		return prepare_on_place(itemstack, placer, pointed_thing,
				"chemistry:chestnut_sapling", 2, 7)
	end,
})

minetest.register_node("chemistry:chestnut_leaves", {
	description = S("Chestnut Tree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"chestnut_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 5},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"chemistry:chestnut_sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"chemistry:chestnut_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})


minetest.register_craft({
	output = "chemistry:chestnut_wood 4",
	recipe = {
		{"chemistry:chestnut_trunk"},
	}
})

minetest.register_craft({
	output = "chemistry:chestnut_wood 4",
	recipe = {
		{"chemistry:chestnut_trunk"},
	}
})

stairs.register_stair(
	"chestnut_wood",
	"chemistry:chestnut_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 5, wood = 1},
	{"chestnut_wood.png"},
	S("Chestnut Wood Stair"),
	default.node_sound_wood_defaults()
)
stairs.register_slab(
	"chestnut_wood",
	"chemistry:chestnut_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 5, wood = 1},
	{"chestnut_wood.png"},
	S("Chestnut Wood Slab"),
	default.node_sound_wood_defaults()
)

minetest.register_node("chemistry:chestnut_fruit", {
	description = S("Chestnut Fruit"),
	drawtype = "plantlike",
	tiles = {"chestnut_fruit.png"},
	inventory_image = "chestnut_fruit.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	drop = {
		max_items = 2,
		items = {
			{
				-- player will get 5 in a 1/5 chance
				items = {"chemistry:chestnut"},
				rarity = 5,
			},
			{
				-- player will get 4 in a 1/4 chance
				items = {"chemistry:chestnut"},
				rarity = 4,
			},
			{
				-- player will get 3 in a 1/3 chance
				items = {"chemistry:chestnut"},
				rarity = 3,
			},
			{
				-- player will get 2 in a 1/2 chance
				items = {"chemistry:chestnut"},
				rarity = 2,
			},
			{
				-- player will only get 1
				items = {"chemistry:chestnut"},
			}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1, food = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "chemistry:chestnut_fruit", param2 = 1})
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if oldnode.param2 == 0 then
			minetest.set_node(pos, {name = "chemistry:chestnut_mark"})
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end
	end,
})


minetest.register_node("chemistry:chestnut_mark", {
	inventory_image = "chestnut_fruit.png^default_invisible_node_overlay.png",
	wield_image = "chestnut_fruit.png^default_invisible_node_overlay.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	on_timer = function(pos, elapsed)
		if not minetest.find_node_near(pos, 1, {"chemistry:chestnut_leaves", "chemistry:chestnut_trunk"})then
			minetest.remove_node(pos)
		elseif minetest.get_node_light(pos) < 11 then
			minetest.get_node_timer(pos):start(200)
		else
			minetest.set_node(pos, {name = "chemistry:chestnut_fruit"})
		end
	end
})

minetest.register_craftitem("chemistry:chestnut", {
	description = S("Chestnuts"),
	inventory_image = "chestnut.png",
	on_use = minetest.item_eat(2),
	groups = {food = 1, flammable = 5},
})

minetest.register_craftitem("chemistry:chestnut_cooked", {
	description = S("Cooked Chestnuts"),
	inventory_image = "chestnut.png^[colorize:black:100",
	on_use = minetest.item_eat(4),
	groups = {food = 1, flammable = 5},
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "chemistry:chestnut_cooked",
	recipe = "chemistry:chestnut"
})

	default.register_leafdecay({
		trunks = {"chemistry:ionized_trunk"},
		leaves = {"chemistry:ionized_leaves"},
		radius = 3,
	})
	default.register_leafdecay({
		trunks = {"chemistry:anthracite_trunk"},
		leaves = {"chemistry:anthracite_leaves"},
		radius = 3,
	})
	default.register_leafdecay({
		trunks = {"chemistry:chestnut_trunk"},
		leaves = {"chemistry:chestnut_fruit", "chemistry:chestnut_leaves"},
		radius = 2,
	})

minetest.register_node("chemistry:limestone", {
	description = S("Limestone"),
	tiles = {"limestone.png"},
	groups = {cracky = 3, limestone = 1},
	drop = "chemistry:limestone_cobbled",
	sounds = chemistry.node_sound_limestone(),
})

minetest.register_node("chemistry:limestone_cobbled", {
	description = S("Cobbled Limestone"),
	tiles = {"limestone_cobbled.png"},
	groups = {cracky = 3, limestone = 1},
	drop = "chemistry:limestone_lump 4",
	sounds = chemistry.node_sound_limestone(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 2,
	output = "chemistry:limestone",
	recipe = "chemistry:limestone_cobbled"
})

minetest.register_node("chemistry:limestone_brick", {
	description = S("Limestone Brick"),
	tiles = {"limestone_brick.png"},
	groups = {cracky = 3, limestone = 1},
	sounds = chemistry.node_sound_limestone(),
})

minetest.register_node("chemistry:limestone_block", {
	description = S("Limestone Block"),
	tiles = {"limestone_block.png"},
	groups = {cracky = 3, limestone = 1},
	sounds = chemistry.node_sound_limestone(),
})

stairs.register_stair(
	"limestone",
	"chemistry:limestone",
	{cracky = 1, limestone = 1},
	{"limestone.png"},
	S("Limestone Stair"),
	chemistry.node_sound_limestone()
)
stairs.register_slab(
	"limestone",
	"chemistry:limestone",
	{cracky = 1, limestone = 1},
	{"limestone.png"},
	S("Limestone Slab"),
	chemistry.node_sound_limestone()
)
stairs.register_stair(
	"limestone_cobbled",
	"chemistry:limestone_cobbled",
	{cracky = 1, limestone = 1},
	{"limestone_cobbled.png"},
	S("Cobbled Limestone Stair"),
	chemistry.node_sound_limestone()
)
stairs.register_slab(
	"limestone_cobbled",
	"chemistry:limestone_cobbled",
	{cracky = 1, limestone = 1},
	{"limestone_cobbled.png"},
	S("Cobbled Limestone Slab"),
	chemistry.node_sound_limestone()
)
stairs.register_stair(
	"limestone_brick",
	"chemistry:limestone_brick",
	{cracky = 1, limestone = 1},
	{"limestone_brick.png"},
	S("Limestone Brick Stair"),
	chemistry.node_sound_limestone()
)
stairs.register_slab(
	"limestone_brick",
	"chemistry:limestone_brick",
	{cracky = 1, limestone = 1},
	{"limestone_brick.png"},
	S("Limestone Brick Slab"),
	chemistry.node_sound_limestone()
)
stairs.register_stair(
	"limestone_block",
	"chemistry:limestone_block",
	{cracky = 1, limestone = 1},
	{"limestone_block.png"},
	S("Limestone Block Stair"),
	chemistry.node_sound_limestone()
)
stairs.register_slab(
	"limestone_block",
	"chemistry:limestone_block",
	{cracky = 1, limestone = 1},
	{"limestone_block.png"},
	S("Limestone Block Slab"),
	chemistry.node_sound_limestone()
)

minetest.register_craft({
	output = 'chemistry:limestone_brick 4',
	recipe = {
		{'chemistry:limestone', 'chemistry:limestone', ''},
		{'chemistry:limestone', 'chemistry:limestone', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:limestone_block 9',
	recipe = {
		{'chemistry:limestone', 'chemistry:limestone', 'chemistry:limestone'},
		{'chemistry:limestone', 'chemistry:limestone', 'chemistry:limestone'},
		{'chemistry:limestone', 'chemistry:limestone', 'chemistry:limestone'},
	}
})

	minetest.register_craftitem("chemistry:limestone_lump", {
		description = S("Limestone Lump"),
		inventory_image = "limestone_lump.png",
	})

minetest.register_craft({
	output = 'chemistry:limestone_cobbled',
	recipe = {
		{'chemistry:limestone_lump', 'chemistry:limestone_lump', ''},
		{'chemistry:limestone_lump', 'chemistry:limestone_lump', ''},
		{'', '', ''},
	}
})

minetest.register_node("chemistry:strong_gem_block", {
	description = S("Strong Gem Block"),
	tiles = {
		{
			name = "strong_gem_block_anim.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 4.0
			}
		}
	},
	groups = {cracky = 1, level = 10},
	sounds = chemistry.node_sound_strong(),
	light_source = 14,
   glow = 14,
})

minetest.register_craftitem("chemistry:strong_gem", {
	description = S("Strong Gem"),
	inventory_image = "strong_gem.png",
	light_source = 7,
})

minetest.register_craft({
	output = 'chemistry:strong_gem_block',
	recipe = {
		{'chemistry:strong_gem', 'chemistry:strong_gem', 'chemistry:strong_gem'},
		{'chemistry:strong_gem', 'chemistry:strong_gem', 'chemistry:strong_gem'},
		{'chemistry:strong_gem', 'chemistry:strong_gem', 'chemistry:strong_gem'},
	}
})

minetest.register_craft({
	output = 'chemistry:strong_gem 9',
	recipe = {
		{'chemistry:strong_gem_block'},
	}
})

minetest.register_node("chemistry:ash", {
	description = S("Ash Ball"),
	tiles = {"ash_block.png"},
	inventory_image = "ash_layer_inv.png",
	wield_image = "ash_layer_inv.png",
	groups = {oddly_breakable_by_hand = 3, falling_node = 1},
	drawtype = "nodebox",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	sunlight_propagates = true,
	node_box = {
		type = "fixed", fixed = {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
	},
	collision_box = {
		type = "fixed", fixed = {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
	},
	sounds = default.node_sound_snow_defaults({
		footstep = {name = "dead_grass_footstep", gain = 0.2},
	}),
	on_construct = function(pos, node)
		pos.y = pos.y - 1
		local node_under = minetest.get_node(pos).name
		if minetest.get_item_group(node_under, "soil") > 0 then
			minetest.set_node(pos, {name = "chemistry:dirt_with_ash"})
		end
	end,
    on_blast = function(pos, intensity)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "chemistry:dirt_with_ash" then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end,
    _tnt_loss = 1,
})

minetest.register_node("chemistry:ash_block", {
	description = S("Ash Block"),
	tiles = {"ash_block.png"},
	groups = {crumbly = 3, falling_node = 1},
	sounds = default.node_sound_snow_defaults(),
})

minetest.register_node("chemistry:dirt_with_ash", {
	description = S("Dirt with Ash"),
	tiles = {"ash_block.png","default_dirt.png","default_dirt.png^ash_field.png"},
	groups = {crumbly = 3, soil = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "dead_grass_footstep", gain = 0.2},
	}),
})

minetest.register_node("chemistry:cinnabar", {
	description = S("Cinnabar"),
	tiles = {"cinnabar.png"},
	groups = {cracky = 3, toxic_to_crops = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("chemistry:cinnabar_lump", {
	description = S("Cinnabar Lump"),
	inventory_image = "cinnabar_lump.png",
})

minetest.register_craft({
	output = 'chemistry:ash_block',
	recipe = {
		{'chemistry:ash', 'chemistry:ash', ''},
		{'chemistry:ash', 'chemistry:ash', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:ash 4',
	recipe = {
		{'chemistry:ash_block'},
	}
})

minetest.register_node("chemistry:dead_leaves", {
	description = S("Dead Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"chestnut_leaves.png^[colorize:#000:200"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 15},
   drop = "",
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

	default.register_leafdecay({
		trunks = {"default:tree"},
		leaves = {"chemistry:dead_leaves"},
		radius = 2,
	})

if minetest.get_modpath("ethereal") then
local leaftype = "plantlike"
local leafscale = 1.4

if ethereal.leaftype ~= 0 then
	leaftype = "allfaces_optional"
	leafscale = 1.0
end

minetest.override_item("chemistry:ionized_leaves", {
   walkable = ethereal.leafwalk,
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "ionized_leaves.png",
})

minetest.override_item("chemistry:chestnut_leaves", {
   walkable = ethereal.leafwalk,
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "chestnut_leaves.png",
})

minetest.override_item("chemistry:anthracite_leaves", {
   walkable = ethereal.leafwalk,
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "anthracite_leaves.png",
})

minetest.override_item("chemistry:dead_leaves", {
   walkable = ethereal.leafwalk,
	drawtype = leaftype,
	visual_scale = leafscale,
	inventory_image = "chestnut_leaves.png^[colorize:#000:200",
})
end

	minetest.register_abm({
		label = "chemistry:crystal spawning",
		nodenames = {"chemistry:stone_cobble", "chemistry:stone_cobble_saturated"},
		interval = 7,
		chance = 15,
		catch_up = true,
		action = function(pos, node)
		if minetest.find_node_near(pos, 3, "group:crystalic_acid") and node.name == "chemistry:stone_cobble" then
			minetest.set_node(pos, {name="chemistry:stone_cobble_saturated"})
		elseif not minetest.find_node_near(pos, 3, "group:crystalic_acid") and node.name == "chemistry:stone_cobble_saturated" then
			minetest.set_node(pos, {name="chemistry:stone_cobble"})
			end
		end,
	})

	minetest.register_abm({
		label = "chemistry:crystal spawning",
		nodenames = {"chemistry:stone_cobble_saturated"},
		interval = 45,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
		if minetest.find_node_near(pos, 3, "group:crystalic_acid") and minetest.get_node({x=pos.x, y=pos.y + 1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y + 1, z=pos.z}, {name="chemistry:growing_crystal_0"})
			end
		end,
	})

	minetest.register_abm({
		label = "chemistry:crystal spawning",
		nodenames = {"chemistry:growing_crystal_0", "chemistry:growing_crystal_1", "chemistry:growing_crystal_2", "chemistry:growing_crystal_3"},
		interval = 60,
		chance = 10,
		catch_up = true,
		action = function(pos, node)
		local node_under = minetest.get_node({x=pos.x, y=pos.y - 1, z=pos.z}).name
		if node_under == "chemistry:stone_cobble_saturated" and node.name == "chemistry:growing_crystal_0" then
			minetest.set_node(pos, {name="chemistry:growing_crystal_1"})
		elseif node_under == "chemistry:stone_cobble_saturated" and node.name == "chemistry:growing_crystal_1" then
			minetest.set_node(pos, {name="chemistry:growing_crystal_2"})
		elseif node_under == "chemistry:stone_cobble_saturated" and node.name == "chemistry:growing_crystal_2" then
			minetest.set_node(pos, {name="chemistry:growing_crystal_3"})
		elseif node_under == "chemistry:stone_cobble_saturated" and node.name == "chemistry:growing_crystal_3" then
			minetest.set_node(pos, {name="chemistry:crystal"})
			end
		end,
	})
