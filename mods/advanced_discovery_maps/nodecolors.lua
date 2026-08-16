-- Node Color Mapping System for Luanti
-- Dynamically generates colors based on node properties, keywords, and groups

local nodecolors = {}

-- ============================================================================
-- COLOR PALETTE - 16 base colors for all terrain types
-- ============================================================================
local PALETTE = {
	GRASS_GREEN = {95, 159, 53},
	DIRT_BROWN = {134, 96, 67},
	STONE_GRAY = {128, 128, 128},
	SAND_TAN = {194, 178, 128},
	DESERT_SAND = {210, 180, 140},
	WATER_BLUE = {38, 92, 255},
	SNOW_WHITE = {240, 240, 240},
	ICE_BLUE = {175, 210, 255},
	TREE_BROWN = {101, 84, 50},
	LEAVES_GREEN = {60, 100, 30},
	LAVA_ORANGE = {255, 100, 0},
	COAL_BLACK = {64, 64, 64},
	IRON_GRAY = {140, 120, 110},
	GOLD_YELLOW = {220, 180, 50},
	GRAVEL_GRAY = {136, 126, 126},
	DEFAULT_GRAY = {100, 100, 100}
}

-- ============================================================================
-- MANUAL OVERRIDES - Highest priority, exact node name matches
-- ============================================================================
local manual_overrides = {
	-- Special cases that don't fit auto-detection well
	["default:apple"] = PALETTE.GOLD_YELLOW,
	["mcl_core:obsidian"] = {20, 10, 30},
	["mcl_core:bedrock"] = {40, 40, 40},
	["mcl_nether:netherrack"] = {100, 50, 50},
	["mcl_nether:soul_sand"] = {80, 70, 60},
	["mcl_end:end_stone"] = {220, 220, 180},
	["nc_fire:ash"] = {80, 80, 80},
	["nc_concrete:concrete"] = {160, 160, 160},
}

-- ============================================================================
-- KEYWORD DETECTION - Pattern matching in node names
-- ============================================================================
local keyword_colors = {
	-- Grass and vegetation
	{pattern = "grass", color = PALETTE.GRASS_GREEN},
	{pattern = "turf", color = PALETTE.GRASS_GREEN},
	{pattern = "tallgrass", color = PALETTE.GRASS_GREEN},
	{pattern = "sedge", color = PALETTE.GRASS_GREEN},
	-- Dirt and soil
	{pattern = "dirt", color = PALETTE.DIRT_BROWN},
	{pattern = "soil", color = PALETTE.DIRT_BROWN},
	{pattern = "podzol", color = {90, 70, 50}},
	{pattern = "coarse_dirt", color = {120, 85, 60}},
	{pattern = "mycelium", color = {110, 90, 110}},
	{pattern = "clay", color = {160, 160, 180}},
	
	-- Stone types
	{pattern = "stone", color = PALETTE.STONE_GRAY},
	{pattern = "cobble", color = PALETTE.DEFAULT_GRAY},
	{pattern = "mossycobble", color = {80, 120, 80}},
	{pattern = "granite", color = {150, 100, 80}},
	{pattern = "andesite", color = {130, 130, 130}},
	{pattern = "diorite", color = {180, 180, 180}},
	{pattern = "annealed", color = {150, 150, 150}},
	{pattern = "pumice", color = {200, 190, 180}},
	{pattern = "lode", color = {110, 110, 110}},
	
	-- Sand and desert
	{pattern = "sand", color = PALETTE.SAND_TAN},
	{pattern = "redsand", color = PALETTE.DESERT_SAND},
	{pattern = "desert", color = PALETTE.DESERT_SAND},
	
	-- Water
	{pattern = "water", color = PALETTE.WATER_BLUE},
	{pattern = "river_water", color = {20, 100, 200}},
	
	-- Snow and ice
	{pattern = "snow", color = PALETTE.SNOW_WHITE},
	{pattern = "ice", color = PALETTE.ICE_BLUE},
	{pattern = "packed_ice", color = {160, 200, 255}},
	
	-- Trees and wood
	{pattern = "tree", color = PALETTE.TREE_BROWN},
	{pattern = "trunk", color = PALETTE.TREE_BROWN},
	{pattern = "bark", color = {90, 70, 45}},
	{pattern = "root", color = {80, 60, 40}},
	{pattern = "log", color = PALETTE.TREE_BROWN},
	{pattern = "wood", color = PALETTE.TREE_BROWN},
	
	-- Specific tree types
	{pattern = "pine", color = {85, 70, 45}},
	{pattern = "spruce", color = {85, 70, 45}},
	{pattern = "jungle", color = {120, 90, 50}},
	{pattern = "birch", color = {220, 220, 180}},
	{pattern = "acacia", color = {160, 100, 60}},
	{pattern = "dark", color = {60, 40, 20}},
	
	-- Leaves
	{pattern = "leaves", color = PALETTE.LEAVES_GREEN},
	{pattern = "needles", color = {45, 80, 25}},
	{pattern = "jungleleaves", color = {50, 90, 30}},
	{pattern = "birchleaves", color = {80, 120, 50}},
	{pattern = "acacialeaves", color = {90, 110, 40}},
	{pattern = "darkleaves", color = {40, 70, 20}},
	
	-- Ores
	{pattern = "coal", color = PALETTE.COAL_BLACK},
	{pattern = "iron", color = PALETTE.IRON_GRAY},
	{pattern = "copper", color = {180, 120, 80}},
	{pattern = "gold", color = PALETTE.GOLD_YELLOW},
	{pattern = "diamond", color = {100, 200, 255}},
	{pattern = "emerald", color = {50, 200, 100}},
	{pattern = "lapis", color = {50, 100, 200}},
	{pattern = "redstone", color = {200, 50, 50}},
	
	-- Lava and gravel
	{pattern = "lava", color = PALETTE.LAVA_ORANGE},
	{pattern = "gravel", color = PALETTE.GRAVEL_GRAY},
	
	-- Flora
	{pattern = "flower", color = {200, 100, 150}},
	{pattern = "junglegrass", color = {40, 80, 20}},
	
	-- Farmland
	{pattern = "farmland", color = {120, 80, 50}},
	{pattern = "grass_path", color = {140, 120, 80}},
}

-- ============================================================================
-- GROUP-BASED DETECTION - Fallback based on node groups
-- ============================================================================
local group_colors = {
	soil = PALETTE.DIRT_BROWN,
	sand = PALETTE.SAND_TAN,
	stone = PALETTE.STONE_GRAY,
	tree = PALETTE.TREE_BROWN,
	leaves = PALETTE.LEAVES_GREEN,
	water = PALETTE.WATER_BLUE,
	lava = PALETTE.LAVA_ORANGE,
	ice = PALETTE.ICE_BLUE,
	snow = PALETTE.SNOW_WHITE,
}

-- ============================================================================
-- COLOR CACHE - Store computed colors to avoid recalculation
-- ============================================================================
local color_cache = {}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Check if a string contains a pattern (case-insensitive)
local function contains_pattern(str, pattern)
	return str:lower():find(pattern:lower(), 1, true) ~= nil
end

-- Detect color based on keywords in node name
local function detect_color_from_keywords(nodename)
	for _, entry in ipairs(keyword_colors) do
		if contains_pattern(nodename, entry.pattern) then
			return entry.color
		end
	end
	return nil
end

-- Detect color based on node groups
local function detect_color_from_groups(nodename)
	local node_def = minetest.registered_nodes[nodename]
	if not node_def or not node_def.groups then
		return nil
	end
	
	-- Check each group that has a color mapping
	for group, color in pairs(group_colors) do
		if node_def.groups[group] and node_def.groups[group] > 0 then
			return color
		end
	end
	
	return nil
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

-- Get color for a node (main function)
function nodecolors.get_color(nodename)
    if color_cache[nodename] then
        return color_cache[nodename]
    end

    local color = nil
    local def = minetest.registered_nodes[nodename]

    -- Prioridad 0: Leer el 'mapcolor' estándar oficial
    if def and def.mapcolor then
        if type(def.mapcolor) == "table" and def.mapcolor.r then
            color = {def.mapcolor.r, def.mapcolor.g, def.mapcolor.b}
        end
    end

    if not color and manual_overrides[nodename] then
        color = manual_overrides[nodename]
    end

    if not color then color = detect_color_from_keywords(nodename) end
    if not color then color = detect_color_from_groups(nodename) end
    if not color then color = PALETTE.DEFAULT_GRAY end

    color_cache[nodename] = color
    return color
end

-- Set a manual override color for a specific node
function nodecolors.set_color(nodename, color)
	manual_overrides[nodename] = color
	color_cache[nodename] = color
end

-- Check if a node has a defined color (not default)
function nodecolors.has_color(nodename)
	local color = nodecolors.get_color(nodename)
	return color ~= PALETTE.DEFAULT_GRAY
end

-- Add a new keyword pattern and color
function nodecolors.add_keyword(pattern, color)
	table.insert(keyword_colors, {pattern = pattern, color = color})
end

-- Add a new group color mapping
function nodecolors.add_group_color(group, color)
	group_colors[group] = color
end

-- Get the color palette (for external customization)
function nodecolors.get_palette()
	return PALETTE
end

-- Clear the color cache (useful after bulk changes)
function nodecolors.clear_cache()
	color_cache = {}
end

-- Get statistics about color detection
function nodecolors.get_stats()
	local stats = {
		manual_overrides = 0,
		keyword_patterns = 0,
		group_mappings = 0,
		cached_colors = 0
	}
	
	for _ in pairs(manual_overrides) do
		stats.manual_overrides = stats.manual_overrides + 1
	end
	
	stats.keyword_patterns = #keyword_colors
	
	for _ in pairs(group_colors) do
		stats.group_mappings = stats.group_mappings + 1
	end
	
	for _ in pairs(color_cache) do
		stats.cached_colors = stats.cached_colors + 1
	end
	
	return stats
end

-- Debug function: show how a color was determined
function nodecolors.debug_color(nodename)
	local info = {
		nodename = nodename,
		color = nil,
		method = "none",
		details = ""
	}
	
	-- Check manual override
	if manual_overrides[nodename] then
		info.color = manual_overrides[nodename]
		info.method = "manual_override"
		return info
	end
	
	-- Check keywords
	local keyword_color = detect_color_from_keywords(nodename)
	if keyword_color then
		info.color = keyword_color
		info.method = "keyword"
		for _, entry in ipairs(keyword_colors) do
			if contains_pattern(nodename, entry.pattern) then
				info.details = "matched pattern: " .. entry.pattern
				break
			end
		end
		return info
	end
	
	-- Check groups
	local group_color = detect_color_from_groups(nodename)
	if group_color then
		info.color = group_color
		info.method = "group"
		local node_def = minetest.registered_nodes[nodename]
		if node_def and node_def.groups then
			for group, color in pairs(group_colors) do
				if node_def.groups[group] and node_def.groups[group] > 0 then
					info.details = "matched group: " .. group
					break
				end
			end
		end
		return info
	end
	
	-- Default
	info.color = PALETTE.DEFAULT_GRAY
	info.method = "default"
	return info
end

return nodecolors
