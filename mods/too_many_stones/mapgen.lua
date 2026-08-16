-- Queue up ores for later registration after all mods are loaded
-- Kindly provided by EmptyStar
local oreq = {}
local function register_ore_by_climate(ore)
	-- Queue up ore for processing after all mods are loaded
	table.insert(oreq,ore)
end

-- Do actual ore registration based on provided climate data after all mods are loaded
minetest.register_on_mods_loaded(function()
	for _,ore in ipairs(oreq) do
		-- Initialize any missing biome or climate values
		ore.biomes = ore.biomes or {}

		local checksum = 0
		if not ore.heat_min then
			ore.heat_min = -100
			checksum = checksum + 1
		end

		if not ore.heat_max then
			ore.heat_max = 200
			checksum = checksum + 1
		end

		if not ore.humidity_min then
			ore.humidity_min = -100
			checksum = checksum + 1
		end

		if not ore.humidity_max then
			ore.humidity_max = 200
			checksum = checksum + 1
		end

		-- Add matching biomes to ore biome list if any climate data was specified
		if checksum ~= 4 then
			checksum = #ore.biomes
			for name,biome in pairs(minetest.registered_biomes) do
				-- Increment biome checksum
				checksum = checksum + 1

				-- Ensure climate values
				local heat = biome.heat_point or 50
				local humidity = biome.humidity_point or 50

				-- Add biome if climate values match
				if (
					heat >= ore.heat_min and
					heat <= ore.heat_max and
					humidity >= ore.humidity_min and
					humidity <= ore.humidity_max
				) then
					table.insert(ore.biomes,name)
				end
			end
		else
			checksum = #ore.biomes + 1
		end

		-- Don't use an empty biome list or a biome list that contains all biomes
		ore.biomes = #ore.biomes > 0 and #ore.biomes < checksum and ore.biomes or nil

		-- Register ore with Minetest one source node at a time due to an engine timing bug
		local sources = ore.wherein
		for i = 1, #sources do
			ore.wherein = sources[i]
			minetest.register_ore(ore)
		end
	end
end)

-- Generate unique seeds for each stone
local _seed = 12345
local function seed()
	_seed = _seed + 97
	return _seed
end

-- Replace some naturally generated lapis lazuli with pyrite
minetest.register_lbm({
	label = "Replace a fraction of lapis lazuli with pyrite",
	name = "too_many_stones:lapis2pyrite",
	nodenames = {"too_many_stones:lapis_lazuli"},
	run_at_every_load = true,
	action = function(pos,node)
		local coordinate_sum = pos.x ^ 2 + pos.y * 2 + pos.z
		local newnode = "too_many_stones:lapis_lazuli"
		if coordinate_sum % 17 == 4 and node.param2 == 1 then
			newnode = "too_many_stones:pyrite"
		end
		minetest.set_node(pos,{ name = newnode , param2 = 0 })
	end,
})

-- Lists of source stones for different environments
local src = {
	-- Source stone groups
	stone = {"mapgen_stone"},
	sand = {},
	desert_sand = {},
	silver_sand = {},
	desert_stone = {},
	sandstone = {},
	desert_sandstone = {},
	silver_sandstone = {},

	-- Select function for selecting multiple source stones/groups
	select = function(self,...)
		local nodes = {}
		for _,group in ipairs({...}) do
			local stones = self[group]
			if stones then
				for _,node in ipairs(self[group]) do
					table.insert(nodes,node)
				end
			else
				table.insert(nodes,stones)
			end
		end
		return nodes
	end,
}

-- ------------- --
--  Mod Support  --
-- ------------- --

-- Minetest Game
if too_many_stones.mods.default then
	table.insert(src.desert_stone,"default:desert_stone")
	table.insert(src.sand,"default:sand")
	table.insert(src.desert_sand,"default:desert_sand")
	table.insert(src.silver_sand,"default:silver_sand")
	table.insert(src.sandstone,"default:sandstone")
	table.insert(src.desert_sandstone,"default:desert_sandstone")
	table.insert(src.silver_sandstone,"default:silver_sandstone")
end

-- Everness
if too_many_stones.mods.everness then
	for _,stone in ipairs({
		"everness:coral_desert_stone",
		"everness:crystal_stone",
		"everness:cursed_stone_carved",
		"everness:forsaken_tundra_stone",
		"everness:mineral_stone",
		"everness:mineral_cave_stone",
	}) do
		table.insert(src.stone,stone)
	end
	table.insert(src.desert_stone,"everness:forsaken_desert_stone")
end

-- Natural Biomes
if too_many_stones.mods.naturalbiomes then
	for _,stone in ipairs({
		"naturalbiomes:bambooforest_rock",
		"naturalbiomes:mediterran_rock",
		"naturalbiomes:alpine_rock",
		"naturalbiomes:outback_ground",
	}) do
		table.insert(src.stone,stone)
	end
	table.insert(src.sand,"naturalbiomes:palmbeach_sand")
end

-- Dorwinion (Biomes modpack, Variety)
if too_many_stones.mods.dorwinion then
	table.insert(src.stone,"dorwinion:dorwinion")
end

-- Minetest Game, Mesecraft, and Others

if too_many_stones.mods.default then

-- Blue Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_blue",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gray Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_gray",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_green",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Moss Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_moss",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Orange Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_orange",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Purple Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_purple",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_red",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amazonite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amazonite",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amber

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amber",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amber",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amethyst

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amethyst",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amethyst",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Ammolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:ammolite",
		wherein         = src:select("stone","sand"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 50,
		heat_max		= 100,
		humidity_min	= 50,
		humidity_max	= 100,
		y_max           = -5,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Andesite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:andesite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Basalt

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:basalt",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Columnar Basalt

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:basalt_columnar",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Moonstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_moonstone",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_moonstone",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Grey Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite_grey",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 30,
		humidity_min	= 50,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = src:select("sand","silver_sand"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 0,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Orange Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite_orange",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 70,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 50,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Carnotite

		register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:carnotite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = -300,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Celestine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:celestine",
		wherein         = too_many_stones.mods.asuna_core and src:select("stone") or src:select("silver_sandstone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= too_many_stones.mods.asuna_core and 60 or 0,
		heat_max		= 100,
		humidity_min	= too_many_stones.mods.asuna_core and 60 or 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Citrine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:citrine",
		wherein         = src:select("desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Chalcanthite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chalcanthite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 80,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = -10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chalcanthite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 80,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = 100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Chrysoprase

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chrysoprase",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chrysoprase",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Covellite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:covellite",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Crocoite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:crocoite",
		wherein         = src:select("stone","desert_stone","sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Diorite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:diorite",
		wherein         = src:select("stone","desert_stone","sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 20,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Erythrite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:erythrite",
		wherein         = src:select("stone","desert_stone","sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Eudialite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:eudialite",
		wherein         = src:select("stone","desert_stone","sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Fluorite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:fluorite",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gabbro

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:gabbro",
		wherein         = src:select("stone","desert_stone","sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 20,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Galena

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:galena",
		ore_param2 = 1,
		wherein         = src:select("stone","desert_stone","sandstone_desert","desert_sandstone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:galena",
		wherein         = src:select("stone","desert_stone","sandstone_desert","desert_sandstone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_black",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Blue Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_blue",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 30,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gray Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_gray",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_gray",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_green",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 56,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pink Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_pink",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_red",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 55,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- White Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_white",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_white",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Yellow Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_yellow",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Heliodor

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:heliodor",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -30,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:heliodor",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = -30,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Howlite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:howlite",
		wherein         = src:select("stone","silver_sandstone","desert_sandstone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Ilvaite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:ilvaite",
		wherein         = src:select("stone","desert_stone","default:permafrost"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Jade

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jade",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jade",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Jasper

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jasper_red",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 20,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Kyanite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:kyanite",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:kyanite",
		wherein         = src:select("silver_sand"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Lapis Lazuli

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:lapis_lazuli",
		wherein         = src:select("desert_stone","sandstone_desert","silver_sandstone"),
		clust_scarcity  = 80 * 48 * 80,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		ore_param2 = 1,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Lepidolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:lepidolite",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 30,
		humidity_min	= 40,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Blue Limestone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:limestone_blue",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- White Limestone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:limestone_white",
		wherein         = src:select("stone","silver_sand"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Marble

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:marble",
		wherein         = src:select("stone","sandstone_desert","silver_sandstone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Moonstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:moonstone",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Morion Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:morion_quartz",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:morion_quartz",
		wherein         = src:select("sand","desert_sand","silver_sand"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Mudstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:mudstone",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_opal",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Fire Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:fire_opal",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:opal",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Prasiolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:prasiolite",
		wherein         = src:select("stone","desert_stone","silver_sandstone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 50,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:prasiolite",
		wherein         = src:select("sand","desert_sand","silver_sand"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pumice

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pumice",
		wherein         = src:select("stone","desert_stone","default:gravel"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pumice",
		wherein         = {"mapgen_water_source"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		y_max           = 31000,
		y_min           = -1,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pyrite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pyrite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 48 * 48 * 48,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -40,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pyrite",
		wherein         = src:select("desert_stone","sandstone_desert","silver_sandstone"),
		clust_scarcity  = 80 * 48 * 80,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = src:select("sand","desert_sand","silver_sand"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Rhodonite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rhodonite",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Rose Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rose_quartz",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rose_quartz",
		wherein         = src:select("sand","desert_sand","silver_sand"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Scoria

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:scoria",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Serpentine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:serpentine",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Shale

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:shale",
		wherein         = src:select("stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 40,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:shale",
		wherein         = src:select("stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Slate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:slate",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:slate",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Smokey Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:smokey_quartz",
		wherein         = src:select("desert_stone","sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Soapstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:soapstone",
		wherein         = src:select("sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:soapstone",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 0,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Sodalite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sodalite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Sugilite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sugilite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 30,
		y_min           = -2000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sugilite",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 30,
		y_min           = -2000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_green",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Paraiba Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_paraiba",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pink Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_pink",
		wherein         = src:select("stone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Travertine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = src:select("sandstone_desert"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 30,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Yellow Travertine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine_yellow",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Beige Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_beige",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Grey Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_grey",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_red",
		wherein         = src:select("stone","desert_stone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Turquoise

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sandstone_with_turquoise",
		wherein         = src:select("sandstone_desert"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 15,
--		heat_min		= 20,
--		heat_max		= 60,
--		humidity_min	= 20,
--		humidity_max	= 60,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 61,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:desert_sandstone_with_turquoise",
		wherein         = src:select("desert_sandstone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 15,
--		heat_min		= 20,
--		heat_max		= 60,
--		humidity_min	= 20,
--		humidity_max	= 60,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 61,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:silver_sandstone_with_turquoise",
		wherein         = src:select("silver_sandstone"),
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 15,
--		heat_min		= 20,
--		heat_max		= 60,
--		humidity_min	= 20,
--		humidity_max	= 60,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 61,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Vivianite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:vivianite",
		wherein         = src:select("stone","silver_sandstone"),
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Minebase Version

elseif too_many_stones.mods.base_earth then

-- Blue Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_blue",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gray Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_gray",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_green",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Moss Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_moss",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Orange Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_orange",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Purple Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_purple",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_red",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amazonite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amazonite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amber

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amber",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amber",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amethyst

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amethyst",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amethyst",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Ammolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:ammolite",
		wherein         = {"mapgen_stone", "base_earth:sand"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 50,
		heat_max		= 100,
		humidity_min	= 50,
		humidity_max	= 100,
		y_max           = -5,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Andesite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:andesite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Basalt

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:basalt",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Columnar Basalt

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:basalt_columnar",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Moonstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_moonstone",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_moonstone",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Grey Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite_grey",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 30,
		humidity_min	= 50,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = {"base_earth:sand", "base_earth:silver_sand"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 0,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Orange Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite_orange",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 70,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 50,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Carnotite

		register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:carnotite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = -300,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Celestine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:celestine",
		wherein         = {"base_earth:silver_sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Citrine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:citrine",
		wherein         = {"base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Chalcanthite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chalcanthite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 80,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = -10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chalcanthite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 80,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = 100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Chrysoprase

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chrysoprase",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chrysoprase",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Covellite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:covellite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Crocoite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:crocoite",
		wherein         = {"mapgen_stone","base_earth:desert_stone","base_earth:sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Diorite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:diorite",
		wherein         = {"mapgen_stone","base_earth:desert_stone","base_earth:sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 20,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Erythrite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:erythrite",
		wherein         = {"mapgen_stone","base_earth:desert_stone","base_earth:sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Eudialite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:eudialite",
		wherein         = {"mapgen_stone","base_earth:desert_stone","base_earth:sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Fluorite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:fluorite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gabbro

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:gabbro",
		wherein         = {"mapgen_stone","base_earth:desert_stone","base_earth:sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 20,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Galena

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:galena",
		ore_param2 = 1,
		wherein         = {"mapgen_stone", "base_earth:sandstone", "base_earth:desert_sandstone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:galena",
		wherein         = {"mapgen_stone", "base_earth:sandstone", "base_earth:desert_sandstone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_black",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Blue Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_blue",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 30,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gray Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_gray",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_gray",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_green",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 56,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pink Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_pink",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_red",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 55,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- White Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_white",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_white",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Yellow Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_yellow",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Heliodor

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:heliodor",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -30,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:heliodor",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = -30,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Howlite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:howlite",
		wherein         = {"mapgen_stone", "base_earth:silver_sandstone", "base_earth:desert_sandstone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Ilvaite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:ilvaite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone", "base_earth:permafrost"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Jade

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jade",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jade",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Jasper

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jasper_red",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 20,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Kyanite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:kyanite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:kyanite",
		wherein         = {"base_earth:silver_sand"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Lapis Lazuli

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:lapis_lazuli",
		wherein         = {"base_earth:sandstone", "base_earth:desert_stone", "base_earth:silver_sandstone"},
		clust_scarcity  = 80 * 48 * 80,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		ore_param2 = 1,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Lepidolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:lepidolite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 30,
		humidity_min	= 40,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Blue Limestone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:limestone_blue",
		wherein         = {"mapgen_stone", "base_earth:sand", "base_earth:desert_sand"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- White Limestone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:limestone_white",
		wherein         = {"mapgen_stone", "base_earth:silver_sand"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Marble

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:marble",
		wherein         = {"mapgen_stone", "base_earth:sandstone", "base_earth:silver_sandstone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Moonstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:moonstone",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Morion Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:morion_quartz",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:morion_quartz",
		wherein         = {"base_earth:sand", "base_earth:silver_sand", "base_earth:desert_sand"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Mudstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:mudstone",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_opal",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Fire Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:fire_opal",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:opal",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Picture Jasper

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:picture_jasper",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Prasiolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:prasiolite",
		wherein         = {"mapgen_stone", "base_earth:silver_sandstone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 50,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:prasiolite",
		wherein         = {"base_earth:sand", "base_earth:silver_sand", "base_earth:desert_sand"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pumice

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pumice",
		wherein         = {"mapgen_stone", "base_earth:gravel", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pumice",
		wherein         = {"mapgen_water_source"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		y_max           = 31000,
		y_min           = -1,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pyrite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pyrite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 48 * 48 * 48,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -40,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pyrite",
		wherein         = {"base_earth:sandstone", "base_earth:desert_stone", "base_earth:silver_sandstone"},
		clust_scarcity  = 80 * 48 * 80,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = {"base_earth:sand", "base_earth:silver_sand", "base_earth:desert_sand"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Rhodonite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rhodonite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Rose Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rose_quartz",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rose_quartz",
		wherein         = {"base_earth:sand", "base_earth:silver_sand", "base_earth:desert_sand"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		y_max           = -2,
		y_min           = -50,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Scoria

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:scoria",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Serpentine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:serpentine",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Slate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:slate",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:slate",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Smokey Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:smokey_quartz",
		wherein         = {"base_earth:sandstone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Soapstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:soapstone",
		wherein         = {"base_earth:sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:soapstone",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 0,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Sodalite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sodalite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Sugilite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sugilite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 30,
		y_min           = -2000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sugilite",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 30,
		y_min           = -2000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_green",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Paraiba Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_paraiba",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pink Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_pink",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Travertine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = {"base_earth:sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 30,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Yellow Travertine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine_yellow",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Beige Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_beige",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Grey Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_grey",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_red",
		wherein         = {"mapgen_stone", "base_earth:desert_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Turquoise

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sandstone_with_turquoise",
		wherein         = {"base_earth:sandstone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 15,
--		heat_min		= 20,
--		heat_max		= 60,
--		humidity_min	= 20,
--		humidity_max	= 60,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 61,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:desert_sandstone_with_turquoise",
		wherein         = {"base_earth:desert_sandstone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 15,
--		heat_min		= 20,
--		heat_max		= 60,
--		humidity_min	= 20,
--		humidity_max	= 60,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 61,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:silver_sandstone_with_turquoise",
		wherein         = {"base_earth:silver_sandstone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 15,
--		heat_min		= 20,
--		heat_max		= 60,
--		humidity_min	= 20,
--		humidity_max	= 60,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 61,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Vivianite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:vivianite",
		wherein         = {"mapgen_stone", "base_earth:silver_sandstone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Universal

else

-- Blue Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_blue",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gray Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_gray",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_green",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Moss Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_moss",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Orange Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_orange",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Purple Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_purple",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Agate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:agate_red",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amazonite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amazonite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amber

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amber",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amber",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Amethyst

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amethyst",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:amethyst",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Ammolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:ammolite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 50,
		heat_max		= 100,
		humidity_min	= 50,
		humidity_max	= 100,
		y_max           = -5,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Andesite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:andesite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Basalt

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:basalt",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Columnar Basalt

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:basalt_columnar",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Moonstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_moonstone",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_moonstone",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Grey Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite_grey",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 30,
		humidity_min	= 50,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Orange Calcite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:calcite_orange",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 70,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 50,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Carnotite

		register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:carnotite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = -300,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Celestine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:celestine",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Citrine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:citrine",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Chalcanthite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chalcanthite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 80,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = -10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chalcanthite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 80,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = 100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Chrysoprase

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chrysoprase",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:chrysoprase",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Covellite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:covellite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Crocoite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:crocoite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Diorite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:diorite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 20,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Erythrite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:erythrite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Eudialite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:eudialite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Fluorite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:fluorite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gabbro

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:gabbro",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 20,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Galena

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:galena",
		ore_param2 = 1,
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:galena",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_black",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Blue Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_blue",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 30,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Gray Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_gray",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_gray",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_green",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 56,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pink Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_pink",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_red",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 55,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- White Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_white",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_white",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Yellow Granite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:granite_yellow",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 10,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Heliodor

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:heliodor",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -30,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:heliodor",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = -30,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Howlite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:howlite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Ilvaite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:ilvaite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Jade

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jade",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jade",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Jasper

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:jasper_red",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 20,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Kyanite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:kyanite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Lapis Lazuli

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:lapis_lazuli",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 80 * 48 * 80,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		ore_param2 = 1,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Lepidolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:lepidolite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 30,
		humidity_min	= 40,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Blue Limestone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:limestone_blue",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- White Limestone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:limestone_white",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -300,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Marble

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:marble",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Moonstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:moonstone",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Morion Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:morion_quartz",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Mudstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:mudstone",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -100,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Black Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:black_opal",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Fire Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:fire_opal",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Opal

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:opal",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Picture Jasper

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:picture_jasper",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 4,
		y_max           = -1000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Prasiolite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:prasiolite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 50,
		y_min           = -1000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pumice

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pumice",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pumice",
		wherein         = {"mapgen_water_source"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 10,
		y_max           = 31000,
		y_min           = -1,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pyrite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:pyrite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 48 * 48 * 48,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -40,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0
		},
	})

-- Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:quartz",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Rhodonite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rhodonite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Rose Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:rose_quartz",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = -300,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Scoria

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:scoria",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Serpentine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:serpentine",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Shale

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:shale",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 40,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:shale",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Slate

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:slate",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:slate",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Smokey Quartz

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:smokey_quartz",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 40,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Soapstone

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:soapstone",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 0,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Sodalite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sodalite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 40,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Sugilite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sugilite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 30,
		y_min           = -2000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:sugilite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 68 * 68 * 68,
		clust_size      = 7,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 30,
		y_min           = -2000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Green Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_green",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Paraiba Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_paraiba",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Pink Tourmaline

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tourmaline_pink",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 10,
		heat_min		= 0,
		heat_max		= 20,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 50,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Travertine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 70 * 70 * 70,
		clust_size      = 14,
		heat_min		= 41,
		heat_max		= 59,
		humidity_min	= 41,
		humidity_max	= 59,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Yellow Travertine

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:travertine_yellow",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Beige Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_beige",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Grey Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_grey",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Red Tuff

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:tuff_red",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 14,
		heat_min		= 60,
		heat_max		= 100,
		humidity_min	= 0,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Turquoise

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:turquoise",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 56 * 56 * 56,
		clust_size      = 15,
		heat_min		= 20,
		heat_max		= 60,
		humidity_min	= 20,
		humidity_max	= 60,
		y_max           = 300,
		y_min           = -60,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 61,
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

-- Vivianite

	register_ore_by_climate({
		ore_type        = "blob",
		ore             = "too_many_stones:vivianite",
		wherein         = {"mapgen_stone"},
		clust_scarcity  = 72 * 72 * 72,
		clust_size      = 7,
		heat_min		= 0,
		heat_max		= 100,
		humidity_min	= 60,
		humidity_max	= 100,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			octaves = 1,
			persist = 0.0,
			seed = seed(),
		},
	})

end
