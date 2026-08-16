local ores = {
	{"naquadah_ore", 7, 5, 10, -31000, -64}, {"naquadah_ore", 9, 4, 12, -63, -16},
	{"trinium_ore", 11, 3, 13, -31000, -128}, {"naquadria_ore", 13, 2, 14, -31000, -512},
}
for _, o in ipairs(ores) do
	core.register_ore({ore_type="scatter", ore="sgjourney:"..o[1], wherein="default:stone", clust_scarcity=o[2]^3, clust_num_ores=o[3], clust_size=o[4], y_min=o[5], y_max=o[6]})
end

