
--[[
   Bonemeal

   Bonemeal file is only to add a compatibility between this 2 mods
   and to allow bonemealing saplings to grow to trees from this mod
   which only takes a few codes to allow this.
--]]

	bonemeal:add_sapling({
		{"chemistry:chestnut_sapling", chemistry.grow_chestnut_tree, "soil"},
		{"chemistry:ionized_sapling", chemistry.grow_ionized_tree, "soil"},
		{"chemistry:anthracite_sapling", chemistry.grow_anthracite_tree, "group:strong_stone"}
   })

