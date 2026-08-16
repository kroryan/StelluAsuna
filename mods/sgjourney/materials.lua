local S = sgjourney

local items = {
	{"raw_naquadah", "Raw Naquadah"}, {"raw_naquadria", "Raw Naquadria"}, {"raw_trinium", "Raw Trinium"},
	{"naquadah_ingot", "Naquadah Ingot"}, {"pure_naquadah", "Pure Naquadah"}, {"naquadria", "Naquadria"},
	{"trinium_ingot", "Trinium Ingot"}, {"naquadah_alloy", "Naquadah Alloy"}, {"control_crystal", "Control Crystal"},
	{"energy_crystal", "Energy Crystal"}, {"memory_crystal", "Memory Crystal"}, {"large_energy_crystal", "Large Energy Crystal"},
	{"zpm", "Zero Point Module"}, {"gdo", "GDO"}, {"iris_blade", "Iris Blade"},
}
for _, def in ipairs(items) do
	core.register_craftitem("sgjourney:" .. def[1], {
		description = def[2], inventory_image = "sgjourney_item_" .. def[1] .. ".png",
	})
end

local nodes = {
	{"naquadah_ore", "Naquadah Ore", "sgjourney_block_naquadah_ore.png", "raw_naquadah", 2},
	{"naquadria_ore", "Naquadria Ore", "sgjourney_block_naquadria_ore.png", "raw_naquadria", 3},
	{"trinium_ore", "Trinium Ore", "sgjourney_block_trinium_ore.png", "raw_trinium", 2},
	{"naquadah_block", "Block of Naquadah", "sgjourney_block_naquadah_block.png", nil, 1},
	{"pure_naquadah_block", "Block of Pure Naquadah", "sgjourney_block_pure_naquadah_block.png", nil, 1},
	{"trinium_block", "Block of Trinium", "sgjourney_block_trinium_block.png", nil, 1},
	{"raw_naquadah_block", "Block of Raw Naquadah", "sgjourney_block_raw_naquadah_block.png", nil, 1},
	{"raw_naquadria_block", "Block of Raw Naquadria", "sgjourney_block_raw_naquadria_block.png", nil, 1},
	{"raw_trinium_block", "Block of Raw Trinium", "sgjourney_block_raw_trinium_block.png", nil, 1},
	{"sulfur_sand", "Sulfur Sand", "sgjourney_block_sulfur_sand.png", nil, 1},
}
for _, def in ipairs(nodes) do
	core.register_node("sgjourney:" .. def[1], {
		description = def[2], tiles = {def[3]}, groups = {cracky = def[5], stone = 1},
		drop = def[4] and ("sgjourney:" .. def[4]) or nil,
		sounds = default and default.node_sound_stone_defaults() or nil,
	})
end

local decorative = {
	"cut_naquadah_block", "polished_naquadah_block", "chiseled_naquadah_block", "smooth_naquadah_block",
	"naquadah_copper_block", "cut_naquadah_copper_block", "polished_naquadah_copper_block", "chiseled_naquadah_copper_block", "smooth_naquadah_copper_block",
	"naquadah_iron_block", "cut_naquadah_iron_block", "polished_naquadah_iron_block", "chiseled_naquadah_iron_block", "smooth_naquadah_iron_block",
	"cut_trinium_block", "polished_trinium_block", "chiseled_trinium_block", "smooth_trinium_block",
	"sandstone_hieroglyphs", "sandstone_with_lapis", "sandstone_with_gold", "red_sandstone_glyphs", "stone_symbol",
}
for _, name in ipairs(decorative) do
	local title = name:gsub("_", " "):gsub("^%l", string.upper)
	core.register_node("sgjourney:" .. name, {
		description = title, tiles = {"sgjourney_block_" .. name .. ".png"}, groups = {cracky = 1, stone = 1},
		sounds = default and default.node_sound_stone_defaults() or nil,
	})
end

