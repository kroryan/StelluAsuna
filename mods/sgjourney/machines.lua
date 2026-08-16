local machines = {
	{"naquadah_reactor", "Naquadah Reactor", 12}, {"naquadah_generator_mark_i", "Naquadah Generator Mark I", 9},
	{"naquadah_generator_mark_ii", "Naquadah Generator Mark II", 12}, {"crystallizer", "Crystallizer", 5},
	{"advanced_crystallizer", "Advanced Crystallizer", 7}, {"naquadah_liquidizer", "Naquadah Liquidizer", 4},
	{"heavy_naquadah_liquidizer", "Heavy Naquadah Liquidizer", 6}, {"large_naquadah_battery", "Large Naquadah Battery", 3},
	{"basic_interface", "Basic Interface", 2}, {"crystal_interface", "Crystal Interface", 3}, {"advanced_crystal_interface", "Advanced Crystal Interface", 4},
	{"transceiver", "Transceiver", 2}, {"ancient_gene_detector", "Ancient Gene Detector", 2},
}
for _, def in ipairs(machines) do
	core.register_node("sgjourney:" .. def[1], {
		description = def[2], tiles = {"sgjourney_block_" .. def[1] .. ".png"}, paramtype2 = "facedir",
		groups = {cracky = 1}, light_source = def[3], sounds = default and default.node_sound_metal_defaults() or nil,
	})
end

core.register_node("sgjourney:ancient_transport_rings", {
	description = "Ancient Transport Rings", tiles = {"sgjourney_block_ancient_transport_rings.png"}, groups = {cracky = 1},
	on_rightclick = function(pos, _, player)
		local nodes = core.find_nodes_in_area(vector.subtract(pos, 64), vector.add(pos, 64), {"sgjourney:ancient_transport_rings", "sgjourney:goauld_transport_rings"})
		for _, target in ipairs(nodes) do if not vector.equals(pos, target) then player:set_pos(vector.add(target, {x=0,y=1,z=0})); sgjourney.sound("transport_rings", target); return end end
	end,
})
core.register_alias("sgjourney:goauld_transport_rings", "sgjourney:ancient_transport_rings")

