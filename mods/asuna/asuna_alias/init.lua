-- The better_farming mod was removed in favor of Farming Redo and X Farming,
-- and to avoid unknown nodes in existing worlds, the better_farming nodes are
-- aliased here.

for old,new in pairs({
  adzuki = "x_farming:soybean",
  agave = "air",
  aloe = "air",
  asparagus = "air",
  beetroot = "x_farming:beetroot",
  bokchoy = "x_farming:soybean",
  cabbage = "farming:cabbage",
  carrot = "x_farming:carrot",
  cassava = "x_farming:coffee",
  chilie = "farming:chili",
  corn = "x_farming:corn",
  cucumber = "farming:cucumber",
  eggplants = "farming:eggplant",
  ginger = "farming:ginger",
  jute = "air",
  kale = "farming:cabbage",
  medicinal_plant = "air",
  millet = "air",
  mint = "farming:mint",
  onion = "farming:onion",
  pepper = "farming:pepper",
  potato = "x_farming:potato",
  rice = "farming:rice",
  sisal = "air",
  spiceleaf = "stevia",
  spinach = "farming:spinach",
  strawberry = "x_farming:strawberry",
  tomatoes = "farming:tomato",
  yucca = "air",
}) do
  for i = 1, 8 do
    minetest.register_alias_force("better_farming:" .. old .. "_" .. i,new == "air" and new or (new .. "_" .. i))
  end
end

-- Alias Plantlife sunflowers to Farming Redo sunflowers
minetest.register_alias_force("flowers:sunflower","farming:sunflower_8")
minetest.register_alias_force("sunflower:sunflower","farming:sunflower_8")

-- Alias Plantlife bushes to default bushes
minetest.register_alias_force("bushes:bushbranches1","default:bush_stem")
minetest.register_alias_force("bushes:bushbranches2","default:bush_stem")
minetest.register_alias_force("bushes:bushbranches3","default:bush_stem")
minetest.register_alias_force("bushes:bushbranches4","default:bush_stem")
minetest.register_alias_force("bushes:BushLeaves1","default:bush_leaves")
minetest.register_alias_force("bushes:BushLeaves2","default:bush_leaves")
minetest.register_alias_force("bushes:youngtree2_bottom","air")

-- Alias Plantlife young trees to air
minetest.register_alias_force("youngtrees:bamboo","air")
minetest.register_alias_force("youngtrees:youngtree_top","air")
minetest.register_alias_force("youngtrees:youngtree_middle","air")
minetest.register_alias_force("youngtrees:youngtree_bottom","air")

-- Aliases for removed biomes/bambooforest nodes
minetest.register_alias_force("bambooforest:bamboo","everness:bamboo_1")
minetest.register_alias_force("bambooforest:bamboo_wood","everness:bamboo_wood")
minetest.register_alias_force("bambooforest:bamboo_block","everness:bamboo_block")
minetest.register_alias_force("bambooforest:dirt_with_bamboo","default:dirt_with_rainforest_litter")
minetest.register_alias_force("bambooforest:granite","too_many_stones:granite_gray")
minetest.register_alias_force("bambooforest:granite_block","too_many_stones:granite_gray_block")
minetest.register_alias_force("bambooforest:granite_brick","too_many_stones:granite_gray_brick")
minetest.register_alias_force("walls:granite_brick","too_many_stones:granite_gray_wall")
minetest.register_alias_force("bambooforest:melon","x_farming:melon_fruit")
minetest.register_alias_force("bambooforest:bamboo_trapdoor","everness:trapdoor_bamboo")
minetest.register_alias_force("bambooforest:fence_bamboo_wood","everness:fence_bamboo_wood")
minetest.register_alias_force("bambooforest:fence_rail_bamboo_wood","everness:fence_rail_bamboo_wood")

-- Aliases for Japanese Forest sashimi that has been removed
minetest.register_alias_force("japaneseforest:sashimi","ethereal:sashimi")
minetest.register_alias_force("japaneseforest:sashimi_cooked","ethereal:sashimi")
minetest.register_alias_force("japaneseforest:sashimi_brick","default:brick")
minetest.register_alias_force("japaneseforest:sashimi_seed","farming:seed_wheat")
minetest.register_alias_force("japaneseforest:sashimi_1","air")
minetest.register_alias_force("japaneseforest:sashimi_2","air")
minetest.register_alias_force("japaneseforest:sashimi_3","air")
minetest.register_alias_force("japaneseforest:sashimi_4","air")
minetest.register_alias_force("japaneseforest:sashimi_5","air")
minetest.register_alias_force("japaneseforest:sashimi_6","air")
minetest.register_alias_force("japaneseforest:sashimi_7","air")
minetest.register_alias_force("japaneseforest:sashimi_8","air")

-- Aliases for Ethereal bamboo
minetest.register_alias_force("ethereal:bamboo_leaves","air")
minetest.register_alias_force("ethereal:bamboo","everness:bamboo_3")
minetest.register_alias_force("ethereal:bamboo_block","everness:bamboo_block")
minetest.register_alias_force("ethereal:bamboo_floor","stairs:slab_bamboo_wood")

-- Alias for palm trees and coconuts to the Everness versions of these nodes
minetest.register_alias_force("ethereal:palmleaves","everness:palm_leaves")
minetest.register_alias_force("ethereal:palm_trunk","everness:palm_tree")
minetest.register_alias_force("ethereal:palm_sapling","everness:palm_tree_sapling")
minetest.register_alias_force("ethereal:coconut","everness:coconut")
minetest.register_alias_force("ethereal:coconut_slice","everness:coconut_fruit")
minetest.register_alias_force("ethereal:palm_wood","everness:palm_tree_wood")

minetest.register_alias_force("ethereal:fence_palm","everness:fence_palm_wood")
minetest.register_alias_force("ethereal:fence_rail_palm","everness:fence_rail_palm_wood")
minetest.register_alias_force("ethereal:fencegate_palm_closed","everness:gate_palm_wood_closed")
minetest.register_alias_force("ethereal:fencegate_palm_open","everness:gate_palm_wood_open")
minetest.register_alias_force("ethereal:mese_post_palm","everness:mese_post_light_palm_wood")
minetest.register_alias_force("stairs:slab_palm_wood","stairs:slab_palm_tree_wood")
minetest.register_alias_force("stairs:stair_palm_wood","stairs:stair_palm_tree_wood")
minetest.register_alias_force("stairs:stair_outer_palm_wood","stairs:stair_outer_palm_tree_wood")
minetest.register_alias_force("stairs:stair_inner_palm_wood","stairs:stair_inner_palm_tree_wood")

-- Aliases for unused Natural Biomes nodes that are not registered
minetest.register_alias_force("naturalbiomes:bambooforest_litter","default:dirt_with_rainforest_litter")
minetest.register_alias_force("naturalbiomes:bamboo_trunk","everness:bamboo_3")
minetest.register_alias_force("naturalbiomes:bamboo_wood","everness:bamboo_block")
minetest.register_alias_force("naturalbiomes:bamboo_leaves","air")
minetest.register_alias_force("naturalbiomes:bamboo_sapling","everness:bamboo_2")
minetest.register_alias_force("stairs:slab_naturalbiomes_bambooforest_bamboo_wood2","stairs:slab_bamboo_wood")
minetest.register_alias_force("naturalbiomes:stair_naturalbiomes_bambooforest_bamboo_wood2","stairs:stair_bamboo_wood")
minetest.register_alias_force("naturalbiomes:stair_outer_naturalbiomes_bambooforest_bamboo_wood2","stairs:stair_outer_bamboo_wood")
minetest.register_alias_force("naturalbiomes:stair_inner_naturalbiomes_bambooforest_bamboo_wood2","stairs:stair_inner_bamboo_wood")
minetest.register_alias_force("stairs:slab_naturalbiomes_bambooforest_bamboo_trunk","stairs:slab_bamboo_wood")
minetest.register_alias_force("naturalbiomes:stair_naturalbiomes_bambooforest_bamboo_trunk","stairs:stair_bamboo_wood")
minetest.register_alias_force("naturalbiomes:stair_outer_naturalbiomes_bambooforest_bamboo_trunk","stairs:stair_outer_bamboo_wood")
minetest.register_alias_force("naturalbiomes:stair_inner_naturalbiomes_bambooforest_bamboo_trunk","stairs:stair_inner_bamboo_wood")
minetest.register_alias_force("naturalbiomes:smallbamboo","everness:bamboo_2")
minetest.register_alias_force("naturalbiomes:bambooforest_rock","default:cobble")
minetest.register_alias_force("naturalbiomes:bambooforest_groundgrass","default:grass_4")
minetest.register_alias_force("naturalbiomes:bambooforest_groundgrass2","default:grass_5")
minetest.register_alias_force("naturalbiomes:banana_trunk","ethereal:banana_trunk")
minetest.register_alias_force("naturalbiomes:banana_wood","ethereal:banana_wood")
minetest.register_alias_force("naturalbiomes:banana_leaves","ethereal:bananaleaves")
minetest.register_alias_force("naturalbiomes:banana_sapling","ethereal:banana_tree_sapling")

minetest.register_alias_force("naturalbiomes:palmbeach_sand","default:sand")
minetest.register_alias_force("naturalbiomes:palmbeach_rock","default:cobble")
minetest.register_alias_force("naturalbiomes:palm_trunk","everness:palm_tree")
minetest.register_alias_force("naturalbiomes:palm_wood","everness:palm_tree_wood")
minetest.register_alias_force("naturalbiomes:palm_leaves","everness:palm_leaves")
minetest.register_alias_force("naturalbiomes:palm_sapling","everness:palm_tree_sapling")
minetest.register_alias_force("naturalbiomes:beach_bush_stem","default:bush_stem")
minetest.register_alias_force("naturalbiomes:beach_bush_leaves","default:bush_leaves")
minetest.register_alias_force("naturalbiomes:beach_bush_sapling","default:bush_sapling")
minetest.register_alias_force("naturalbiomes:palmbeach_grass1","default:marram_grass_1")
minetest.register_alias_force("naturalbiomes:palmbeach_grass2","default:marram_grass_2")
minetest.register_alias_force("naturalbiomes:palmbeach_grass3","default:marram_grass_3")
minetest.register_alias_force("naturalbiomes:banana_bunch","ethereal:banana")
minetest.register_alias_force("naturalbiomes:banana","ethereal:banana")
minetest.register_alias_force("naturalbiomes:coconut_slice","everness:coconut_fruit")
minetest.register_alias_force("naturalbiomes:coconut","everness:coconut")
minetest.register_alias_force("naturalbiomes:coconut_trapdoor","everness:trapdoor_bamboo")
minetest.register_alias_force("naturalbiomes_coconut_door","everness:door_bamboo")