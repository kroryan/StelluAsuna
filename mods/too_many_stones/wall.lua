-- support for MT game translation.
local S = minetest.get_translator("too_many_stones")

if minetest.get_modpath("walls") ~= nil then
-- Blue Agate
walls.register("too_many_stones:agate_blue_wall", S("Blue Agate Wall"), "tms_agate_blue.png",
		"too_many_stones:agate_blue", too_many_stones.node_sound_glass_defaults())
-- Gray Agate
walls.register("too_many_stones:agate_gray_wall", S("Gray Agate Wall"), "tms_agate_gray.png",
		"too_many_stones:agate_gray", too_many_stones.node_sound_glass_defaults())
-- Green Agate
walls.register("too_many_stones:agate_green_wall", S("Green Agate Wall"), "tms_agate_green.png",
		"too_many_stones:agate_green", too_many_stones.node_sound_glass_defaults())
-- Moss Agate
walls.register("too_many_stones:agate_moss_wall", S("Moss Agate Wall"), "tms_agate_moss.png",
		"too_many_stones:agate_moss", too_many_stones.node_sound_glass_defaults())
-- Orange Agate
walls.register("too_many_stones:agate_orange_wall", S("Orange Agate Wall"), "tms_agate_orange.png",
		"too_many_stones:agate_orange", too_many_stones.node_sound_glass_defaults())
-- Purple Agate
walls.register("too_many_stones:agate_purple_wall", S("Purple Agate Wall"), "tms_agate_purple.png",
		"too_many_stones:agate_purple", too_many_stones.node_sound_glass_defaults())
-- Red Agate
walls.register("too_many_stones:agate_red_wall", S("Red Agate Wall"), "tms_agate_red.png",
		"too_many_stones:agate_red", too_many_stones.node_sound_glass_defaults())
-- Amazonite
walls.register("too_many_stones:amazonite_wall", S("Amazonite Wall"), "tms_amazonite.png",
		"too_many_stones:amazonite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:amazonite_brick_wall", S("Amazonite Brick Wall"), "tms_amazonite_brick.png",
		"too_many_stones:amazonite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:amazonite_cracked_brick_wall", S("Cracked Amazonite Brick Wall"), "tms_amazonite_cracked_brick.png",
		"too_many_stones:amazonite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:amazonite_block_wall", S("Amazonite Block Wall"), "tms_amazonite_block.png",
		"too_many_stones:amazonite_block", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:amazonite_cobble_wall", S("Cobbled Amazonite Wall"), "tms_amazonite_cobble.png",
		"too_many_stones:amazonite_cobble", too_many_stones.node_sound_glass_defaults())
-- Amber
walls.register("too_many_stones:amber_wall", S("Amber Wall"), "tms_amber.png",
		"too_many_stones:amber", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:amber_brick_wall", S("Amber Brick Wall"), "tms_amber_brick.png",
		"too_many_stones:amber_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:amber_cracked_brick_wall", S("Cracked Amber Brick Wall"), "tms_amber_cracked_brick.png",
		"too_many_stones:amber_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:amber_block_wall", S("Amber Block Wall"), "tms_amber_block.png",
		"too_many_stones:amber_block", too_many_stones.node_sound_glass_defaults())
-- Amethyst
walls.register("too_many_stones:amethyst_wall", S("Amethyst Wall"), "tms_amethyst.png",
		"too_many_stones:amethyst", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:amethyst_brick_wall", S("Amethyst Brick Wall"), "tms_amethyst_brick.png",
		"too_many_stones:amethyst_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:amethyst_cracked_brick_wall", S("Cracked Amethyst Brick Wall"), "tms_amethyst_cracked_brick.png",
		"too_many_stones:amethyst_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:amethyst_block_wall", S("Amethyst Block Wall"), "tms_amethyst_block.png",
		"too_many_stones:amethyst_block", too_many_stones.node_sound_glass_defaults())
-- Andesite
walls.register("too_many_stones:andesite_wall", S("Andesite Wall"), "tms_andesite.png",
		"too_many_stones:andesite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:andesite_brick_wall", S("Andesite Brick Wall"), "tms_andesite_brick.png",
		"too_many_stones:andesite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:andesite_cracked_brick_wall", S("Cracked Andesite Brick Wall"), "tms_andesite_cracked_brick.png",
		"too_many_stones:andesite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:andesite_block_wall", S("Andesite Block Wall"), "tms_andesite_block.png",
		"too_many_stones:andesite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:andesite_cobble_wall", S("Cobbled Andesite Wall"), "tms_andesite_cobble.png",
		"too_many_stones:andesite_cobble", too_many_stones.node_sound_stone_defaults())
-- Basalt
walls.register("too_many_stones:basalt_wall", S("Basalt Wall"), "tms_basalt.png",
		"too_many_stones:basalt", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:basalt_brick_wall", S("Basalt Brick Wall"), "tms_basalt_brick.png",
		"too_many_stones:basalt_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:basalt_cracked_brick_wall", S("Cracked Basalt Brick Wall"), "tms_basalt_cracked_brick.png",
		"too_many_stones:basalt_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:basalt_block_wall", S("Basalt Block Wall"), "tms_basalt_block.png",
		"too_many_stones:basalt_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:basalt_cobble_wall", S("Cobbled Basalt Wall"), "tms_basalt_cobble.png",
		"too_many_stones:basalt_cobble", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:basalt_tile_wall", S("Basalt Tile Wall"), "tms_basalt_tile.png",
		"too_many_stones:basalt_tile", too_many_stones.node_sound_stone_defaults())
-- Black Moonstone
walls.register("too_many_stones:black_moonstone_wall", S("Black Moonstone Wall"), "tms_black_moonstone.png",
		"too_many_stones:black_moonstone", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:black_moonstone_brick_wall", S("Black Moonstone Brick Wall"), "tms_black_moonstone_brick.png",
		"too_many_stones:black_moonstone_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:black_moonstone_cracked_brick_wall", S("Cracked Black Moonstone Brick Wall"), "tms_black_moonstone_cracked_brick.png",
		"too_many_stones:black_moonstone_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:black_moonstone_block_wall", S("Black Moonstone Block Wall"), "tms_black_moonstone_block.png",
		"too_many_stones:black_moonstone_block", too_many_stones.node_sound_glass_defaults())
-- Grey Calcite
walls.register("too_many_stones:calcite_grey_wall", S("Grey Calcite Wall"), "tms_calcite_grey.png",
		"too_many_stones:calcite_grey", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:calcite_grey_brick_wall", S("Grey Calcite Brick Wall"), "tms_calcite_grey_brick.png",
		"too_many_stones:calcite_grey_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:calcite_grey_cracked_brick_wall", S("Cracked Grey Calcite Brick Wall"), "tms_calcite_grey_cracked_brick.png",
		"too_many_stones:calcite_grey_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:calcite_grey_block_wall", S("Grey Calcite Block Wall"), "tms_calcite_grey_block.png",
		"too_many_stones:calcite_grey_block", too_many_stones.node_sound_glass_defaults())
-- Calcite
walls.register("too_many_stones:calcite_wall", S("Calcite Wall"), "tms_calcite.png",
		"too_many_stones:calcite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:calcite_brick_wall", S("Calcite Brick Wall"), "tms_calcite_brick.png",
		"too_many_stones:calcite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:calcite_cracked_brick_wall", S("Cracked Calcite Brick Wall"), "tms_calcite_cracked_brick.png",
		"too_many_stones:calcite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:calcite_block_wall", S("Calcite Block Wall"), "tms_calcite_block.png",
		"too_many_stones:calcite_block", too_many_stones.node_sound_glass_defaults())
-- Orange Calcite
walls.register("too_many_stones:calcite_orange_wall", S("Orange Calcite Wall"), "tms_calcite_orange.png",
		"too_many_stones:calcite_orange", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:calcite_orange_brick_wall", S("Orange Calcite Brick Wall"), "tms_calcite_orange_brick.png",
		"too_many_stones:calcite_orange_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:calcite_orange_cracked_brick_wall", S("Cracked Orange Calcite Brick Wall"), "tms_calcite_orange_cracked_brick.png",
		"too_many_stones:calcite_orange_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:calcite_orange_block_wall", S("Orange Calcite Block Wall"), "tms_calcite_orange_block.png",
		"too_many_stones:calcite_orange_block", too_many_stones.node_sound_glass_defaults())
-- Carnotite
walls.register("too_many_stones:carnotite_wall", S("Carnotite Wall"), "tms_carnotite.png",
		"too_many_stones:carnotite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:carnotite_brick_wall", S("Carnotite Brick Wall"), "tms_carnotite_brick.png",
		"too_many_stones:carnotite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:carnotite_cracked_brick_wall", S("Cracked Carnotite Brick Wall"), "tms_carnotite_cracked_brick.png",
		"too_many_stones:carnotite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:carnotite_block_wall", S("Carnotite Block Wall"), "tms_carnotite_block.png",
		"too_many_stones:carnotite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:carnotite_cobble_wall", S("Cobbled Carnotite Wall"), "tms_carnotite_cobble.png",
		"too_many_stones:carnotite_cobble", too_many_stones.node_sound_stone_defaults())
-- Celestine
walls.register("too_many_stones:celestine_wall", S("Celestine Wall"), "tms_celestine.png",
		"too_many_stones:celestine", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:celestine_brick_wall", S("Celestine Brick Wall"), "tms_celestine_brick.png",
		"too_many_stones:celestine_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:celestine_cracked_brick_wall", S("Cracked Celestine Brick Wall"), "tms_celestine_cracked_brick.png",
		"too_many_stones:celestine_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:celestine_block_wall", S("Celestine Block Wall"), "tms_celestine_block.png",
		"too_many_stones:celestine_block", too_many_stones.node_sound_glass_defaults())
-- Chalcanthite
walls.register("too_many_stones:chalcanthite_wall", S("Chalcanthite Wall"), "tms_chalcanthite.png",
		"too_many_stones:chalcanthite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:chalcanthite_brick_wall", S("Chalcanthite Brick Wall"), "tms_chalcanthite_brick.png",
		"too_many_stones:chalcanthite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:chalcanthite_cracked_brick_wall", S("Cracked Chalcanthite Brick Wall"), "tms_chalcanthite_cracked_brick.png",
		"too_many_stones:chalcanthite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:chalcanthite_block_wall", S("Chalcanthite Block Wall"), "tms_chalcanthite_block.png",
		"too_many_stones:chalcanthite_block", too_many_stones.node_sound_glass_defaults())
-- Chrysoprase
walls.register("too_many_stones:chrysoprase_wall", S("Chrysoprase Wall"), "tms_chrysoprase.png",
		"too_many_stones:chrysoprase", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:chrysoprase_brick_wall", S("Chrysoprase Brick Wall"), "tms_chrysoprase_brick.png",
		"too_many_stones:chrysoprase_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:chrysoprase_cracked_brick_wall", S("Cracked Chrysoprase Brick Wall"), "tms_chrysoprase_cracked_brick.png",
		"too_many_stones:chrysoprase_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:chrysoprase_block_wall", S("Chrysoprase Block Wall"), "tms_chrysoprase_block.png",
		"too_many_stones:chrysoprase_block", too_many_stones.node_sound_glass_defaults())
-- Citrine
walls.register("too_many_stones:citrine_wall", S("Citrine Wall"), "tms_citrine.png",
		"too_many_stones:citrine", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:citrine_brick_wall", S("Citrine Brick Wall"), "tms_citrine_brick.png",
		"too_many_stones:citrine_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:citrine_cracked_brick_wall", S("Cracked Citrine Brick Wall"), "tms_citrine_cracked_brick.png",
		"too_many_stones:citrine_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:citrine_block_wall", S("Citrine Block Wall"), "tms_citrine_block.png",
		"too_many_stones:citrine_block", too_many_stones.node_sound_glass_defaults())
-- Covellite
walls.register("too_many_stones:covellite_wall", S("Covellite Wall"), "tms_covellite.png",
		"too_many_stones:covellite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:covellite_brick_wall", S("Covellite Brick Wall"), "tms_covellite_brick.png",
		"too_many_stones:covellite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:covellite_cracked_brick_wall", S("Cracked Covellite Brick Wall"), "tms_covellite_cracked_brick.png",
		"too_many_stones:covellite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:covellite_block_wall", S("Covellite Block Wall"), "tms_covellite_block.png",
		"too_many_stones:covellite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:covellite_cobble_wall", S("Cobbled Covellite Wall"), "tms_covellite_cobble.png",
		"too_many_stones:covellite_cobble", too_many_stones.node_sound_stone_defaults())
-- Crocoite
walls.register("too_many_stones:crocoite_wall", S("Crocoite Wall"), "tms_crocoite.png",
		"too_many_stones:crocoite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:crocoite_brick_wall", S("Crocoite Brick Wall"), "tms_crocoite_brick.png",
		"too_many_stones:crocoite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:crocoite_cracked_brick_wall", S("Cracked Crocoite Brick Wall"), "tms_crocoite_cracked_brick.png",
		"too_many_stones:crocoite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:crocoite_block_wall", S("Crocoite Block Wall"), "tms_crocoite_block.png",
		"too_many_stones:crocoite_block", too_many_stones.node_sound_glass_defaults())
-- Diorite
walls.register("too_many_stones:diorite_wall", S("Diorite Wall"), "tms_diorite.png",
		"too_many_stones:diorite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:diorite_brick_wall", S("Diorite Brick Wall"), "tms_diorite_brick.png",
		"too_many_stones:diorite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:diorite_cracked_brick_wall", S("Cracked Diorite Brick Wall"), "tms_diorite_cracked_brick.png",
		"too_many_stones:diorite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:diorite_block_wall", S("Diorite Block Wall"), "tms_diorite_block.png",
		"too_many_stones:diorite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:diorite_cobble_wall", S("Cobbled Diorite Wall"), "tms_diorite_cobble.png",
		"too_many_stones:diorite_cobble", too_many_stones.node_sound_stone_defaults())
-- Erythrite
walls.register("too_many_stones:erythrite_wall", S("Erythrite Wall"), "tms_erythrite.png",
		"too_many_stones:erythrite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:erythrite_brick_wall", S("Erythrite Brick Wall"), "tms_erythrite_brick.png",
		"too_many_stones:erythrite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:erythrite_cracked_brick_wall", S("Cracked Erythrite Brick Wall"), "tms_erythrite_cracked_brick.png",
		"too_many_stones:erythrite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:erythrite_block_wall", S("Erythrite Block Wall"), "tms_erythrite_block.png",
		"too_many_stones:erythrite_block", too_many_stones.node_sound_glass_defaults())
-- Eudialite
walls.register("too_many_stones:eudialite_wall", S("Eudialite Wall"), "tms_eudialite.png",
		"too_many_stones:eudialite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:eudialite_brick_wall", S("Eudialite Brick Wall"), "tms_eudialite_brick.png",
		"too_many_stones:eudialite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:eudialite_cracked_brick_wall", S("Cracked Eudialite Brick Wall"), "tms_eudialite_cracked_brick.png",
		"too_many_stones:eudialite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:eudialite_block_wall", S("Eudialite Block Wall"), "tms_eudialite_block.png",
		"too_many_stones:eudialite_block", too_many_stones.node_sound_glass_defaults())
-- Fluorite
walls.register("too_many_stones:fluorite_wall", S("Fluorite Wall"), "tms_fluorite.png",
		"too_many_stones:fluorite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:fluorite_brick_wall", S("Fluorite Brick Wall"), "tms_fluorite_brick.png",
		"too_many_stones:fluorite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:fluorite_cracked_brick_wall", S("Cracked Fluorite Brick Wall"), "tms_fluorite_cracked_brick.png",
		"too_many_stones:fluorite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:fluorite_block_wall", S("Fluorite Block Wall"), "tms_fluorite_block.png",
		"too_many_stones:fluorite_block", too_many_stones.node_sound_glass_defaults())
-- Gabbro
walls.register("too_many_stones:gabbro_wall", S("Gabbro Wall"), "tms_gabbro.png",
		"too_many_stones:gabbro", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:gabbro_brick_wall", S("Gabbro Brick Wall"), "tms_gabbro_brick.png",
		"too_many_stones:gabbro_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:gabbro_cracked_brick_wall", S("Cracked Gabbro Brick Wall"), "tms_gabbro_cracked_brick.png",
		"too_many_stones:gabbro_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:gabbro_block_wall", S("Gabbro Block Wall"), "tms_gabbro_block.png",
		"too_many_stones:gabbro_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:gabbro_cobble_wall", S("Cobbled Gabbro Wall"), "tms_gabbro_cobble.png",
		"too_many_stones:gabbro_cobble", too_many_stones.node_sound_stone_defaults())
-- Galena
walls.register("too_many_stones:galena_wall", S("Galena Wall"), "tms_galena.png",
		"too_many_stones:galena", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:galena_brick_wall", S("Galena Brick Wall"), "tms_galena_brick.png",
		"too_many_stones:galena_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:galena_cracked_brick_wall", S("Cracked Galena Brick Wall"), "tms_galena_cracked_brick.png",
		"too_many_stones:galena_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:galena_block_wall", S("Galena Block Wall"), "tms_galena_block.png",
		"too_many_stones:galena_block", too_many_stones.node_sound_stone_defaults())
-- Black Granite
walls.register("too_many_stones:granite_black_wall", S("Black Granite Wall"), "tms_granite_black.png",
		"too_many_stones:granite_black", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_black_brick_wall", S("Black Granite Brick Wall"), "tms_granite_black_brick.png",
		"too_many_stones:granite_black_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_black_cracked_brick_wall", S("Cracked Black Granite Brick Wall"), "tms_granite_black_cracked_brick.png",
		"too_many_stones:granite_black_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_black_block_wall", S("Black Granite Block Wall"), "tms_granite_black_block.png",
		"too_many_stones:granite_black_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_black_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_black_cobble.png",
		"too_many_stones:granite_black_cobble", too_many_stones.node_sound_stone_defaults())
-- Blue Granite
walls.register("too_many_stones:granite_blue_wall", S("Blue Granite Wall"), "tms_granite_blue.png",
		"too_many_stones:granite_blue", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_blue_brick_wall", S("Blue Granite Brick Wall"), "tms_granite_blue_brick.png",
		"too_many_stones:granite_blue_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_blue_cracked_brick_wall", S("Cracked Blue Granite Brick Wall"), "tms_granite_blue_cracked_brick.png",
		"too_many_stones:granite_blue_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_blue_block_wall", S("Blue Granite Block Wall"), "tms_granite_blue_block.png",
		"too_many_stones:granite_blue_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_blue_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_blue_cobble.png",
		"too_many_stones:granite_blue_cobble", too_many_stones.node_sound_stone_defaults())
-- Gray Granite
walls.register("too_many_stones:granite_gray_wall", S("Gray Granite Wall"), "tms_granite_gray.png",
		"too_many_stones:granite_gray", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_gray_brick_wall", S("Gray Granite Brick Wall"), "tms_granite_gray_brick.png",
		"too_many_stones:granite_gray_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_gray_cracked_brick_wall", S("Cracked Gray Granite Brick Wall"), "tms_granite_gray_cracked_brick.png",
		"too_many_stones:granite_gray_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_gray_block_wall", S("Gray Granite Block Wall"), "tms_granite_gray_block.png",
		"too_many_stones:granite_gray_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_gray_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_gray_cobble.png",
		"too_many_stones:granite_gray_cobble", too_many_stones.node_sound_stone_defaults())
-- Green Granite
walls.register("too_many_stones:granite_green_wall", S("Green Granite Wall"), "tms_granite_green.png",
		"too_many_stones:granite_green", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_green_brick_wall", S("Green Granite Brick Wall"), "tms_granite_green_brick.png",
		"too_many_stones:granite_green_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_green_cracked_brick_wall", S("Cracked Green Granite Brick Wall"), "tms_granite_green_cracked_brick.png",
		"too_many_stones:granite_green_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_green_block_wall", S("Green Granite Block Wall"), "tms_granite_green_block.png",
		"too_many_stones:granite_green_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_green_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_green_cobble.png",
		"too_many_stones:granite_green_cobble", too_many_stones.node_sound_stone_defaults())
-- Pink Granite
walls.register("too_many_stones:granite_pink_wall", S("Pink Granite Wall"), "tms_granite_pink.png",
		"too_many_stones:granite_pink", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_pink_brick_wall", S("Pink Granite Brick Wall"), "tms_granite_pink_brick.png",
		"too_many_stones:granite_pink_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_pink_cracked_brick_wall", S("Cracked Pink Granite Brick Wall"), "tms_granite_pink_cracked_brick.png",
		"too_many_stones:granite_pink_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_pink_block_wall", S("Pink Granite Block Wall"), "tms_granite_pink_block.png",
		"too_many_stones:granite_pink_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_pink_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_pink_cobble.png",
		"too_many_stones:granite_pink_cobble", too_many_stones.node_sound_stone_defaults())
-- Red Granite
walls.register("too_many_stones:granite_red_wall", S("Red Granite Wall"), "tms_granite_red.png",
		"too_many_stones:granite_red", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_red_brick_wall", S("Red Granite Brick Wall"), "tms_granite_red_brick.png",
		"too_many_stones:granite_red_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_red_cracked_brick_wall", S("Cracked Red Granite Brick Wall"), "tms_granite_red_cracked_brick.png",
		"too_many_stones:granite_red_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_red_block_wall", S("Red Granite Block Wall"), "tms_granite_red_block.png",
		"too_many_stones:granite_red_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_red_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_red_cobble.png",
		"too_many_stones:granite_red_cobble", too_many_stones.node_sound_stone_defaults())
-- White Granite
walls.register("too_many_stones:granite_white_wall", S("White Granite Wall"), "tms_granite_white.png",
		"too_many_stones:granite_white", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_white_brick_wall", S("White Granite Brick Wall"), "tms_granite_white_brick.png",
		"too_many_stones:granite_white_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_white_cracked_brick_wall", S("Cracked White Granite Brick Wall"), "tms_granite_white_cracked_brick.png",
		"too_many_stones:granite_white_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_white_block_wall", S("White Granite Block Wall"), "tms_granite_white_block.png",
		"too_many_stones:granite_white_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_white_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_white_cobble.png",
		"too_many_stones:granite_white_cobble", too_many_stones.node_sound_stone_defaults())
-- Yellow Granite
walls.register("too_many_stones:granite_yellow_wall", S("Yellow Granite Wall"), "tms_granite_yellow.png",
		"too_many_stones:granite_yellow", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:granite_yellow_brick_wall", S("Yellow Granite Brick Wall"), "tms_granite_yellow_brick.png",
		"too_many_stones:granite_yellow_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_yellow_cracked_brick_wall", S("Cracked Yellow Granite Brick Wall"), "tms_granite_yellow_cracked_brick.png",
		"too_many_stones:granite_yellow_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_yellow_block_wall", S("Yellow Granite Block Wall"), "tms_granite_yellow_block.png",
		"too_many_stones:granite_yellow_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:granite_yellow_cobble_wall", S("Cobbled Black Granite Wall"), "tms_granite_yellow_cobble.png",
		"too_many_stones:granite_yellow_cobble", too_many_stones.node_sound_stone_defaults())
-- Heliodor
walls.register("too_many_stones:heliodor_wall", S("Heliodor Wall"), "tms_heliodor.png",
		"too_many_stones:heliodor", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:heliodor_brick_wall", S("Heliodor Brick Wall"), "tms_heliodor_brick.png",
		"too_many_stones:heliodor_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:heliodor_cracked_brick_wall", S("Cracked Heliodor Brick Wall"), "tms_heliodor_cracked_brick.png",
		"too_many_stones:heliodor_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:heliodor_block_wall", S("Heliodor Block Wall"), "tms_heliodor_block.png",
		"too_many_stones:heliodor_block", too_many_stones.node_sound_glass_defaults())
-- Howlite
walls.register("too_many_stones:howlite_wall", S("Howlite Wall"), "tms_howlite.png",
		"too_many_stones:howlite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:howlite_brick_wall", S("Howlite Brick Wall"), "tms_howlite_brick.png",
		"too_many_stones:howlite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:howlite_cracked_brick_wall", S("Cracked Howlite Brick Wall"), "tms_howlite_cracked_brick.png",
		"too_many_stones:howlite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:howlite_block_wall", S("Howlite Block Wall"), "tms_howlite_block.png",
		"too_many_stones:howlite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:howlite_cobble_wall", S("Cobbled Howlite Wall"), "tms_howlite_cobble.png",
		"too_many_stones:howlite_cobble", too_many_stones.node_sound_stone_defaults())
-- Ilvaite
walls.register("too_many_stones:ilvaite_wall", S("Ilvaite Wall"), "tms_ilvaite.png",
		"too_many_stones:ilvaite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:ilvaite_brick_wall", S("Ilvaite Brick Wall"), "tms_ilvaite_brick.png",
		"too_many_stones:ilvaite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:ilvaite_cracked_brick_wall", S("Cracked Ilvaite Brick Wall"), "tms_ilvaite_cracked_brick.png",
		"too_many_stones:ilvaite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:ilvaite_block_wall", S("Ilvaite Block Wall"), "tms_ilvaite_block.png",
		"too_many_stones:ilvaite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:ilvaite_cobble_wall", S("Cobbled Ilvaite Wall"), "tms_ilvaite_cobble.png",
		"too_many_stones:ilvaite_cobble", too_many_stones.node_sound_stone_defaults())
-- Red Jasper
walls.register("too_many_stones:jasper_red_wall", S("Red Jasper Wall"), "tms_jasper_red.png",
		"too_many_stones:jasper_red", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:jasper_red_brick_wall", S("Red Jasper Brick Wall"), "tms_jasper_red_brick.png",
		"too_many_stones:jasper_red_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:jasper_red_cracked_brick_wall", S("Cracked Red Jasper Brick Wall"), "tms_jasper_red_cracked_brick.png",
		"too_many_stones:jasper_red_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:jasper_red_block_wall", S("Red Jasper Block Wall"), "tms_jasper_red_block.png",
		"too_many_stones:jasper_red_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:jasper_red_cobble_wall", S("Cobbled Red Jasper Wall"), "tms_jasper_red_cobble.png",
		"too_many_stones:jasper_red_cobble", too_many_stones.node_sound_stone_defaults())
-- Jade
walls.register("too_many_stones:jade_wall", S("Jade Wall"), "tms_jade.png",
		"too_many_stones:jade", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:jade_brick_wall", S("Jade Brick Wall"), "tms_jade_brick.png",
		"too_many_stones:jade_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:jade_cracked_brick_wall", S("Cracked Jade Brick Wall"), "tms_jade_cracked_brick.png",
		"too_many_stones:jade_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:jade_block_wall", S("Jade Block Wall"), "tms_jade_block.png",
		"too_many_stones:jade_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:jade_cobble_wall", S("Cobbled Jade Wall"), "tms_jade_cobble.png",
		"too_many_stones:jade_cobble", too_many_stones.node_sound_stone_defaults())
-- Kyanite
walls.register("too_many_stones:kyanite_wall", S("Kyanite Wall"), "tms_kyanite.png",
		"too_many_stones:kyanite", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:kyanite_brick_wall", S("Kyanite Brick Wall"), "tms_kyanite_brick.png",
		"too_many_stones:kyanite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:kyanite_cracked_brick_wall", S("Cracked Kyanite Brick Wall"), "tms_kyanite_cracked_brick.png",
		"too_many_stones:kyanite_cracked_brick", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:kyanite_block_wall", S("Kyanite Block Wall"), "tms_kyanite_block.png",
		"too_many_stones:kyanite_block", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:kyanite_cobble_wall", S("Cobbled Kyanite Wall"), "tms_kyanite_cobble.png",
		"too_many_stones:kyanite_cobble", too_many_stones.node_sound_glass_defaults())
-- Lapis Lazuli
walls.register("too_many_stones:lapis_lazuli_wall", S("Lapis Lazuli Wall"), "tms_lapis_lazuli.png",
		"too_many_stones:lapis_lazuli", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:lapis_lazuli_brick_wall", S("Lapis Lazuli Brick Wall"), "tms_lapis_lazuli_brick.png",
		"too_many_stones:lapis_lazuli_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:lapis_lazuli_cracked_brick_wall", S("Cracked Lapis Lazuli Brick Wall"), "tms_lapis_lazuli_cracked_brick.png",
		"too_many_stones:lapis_lazuli_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:lapis_lazuli_block_wall", S("Lapis Lazuli Block Wall"), "tms_lapis_lazuli_block.png",
		"too_many_stones:lapis_lazuli_block", too_many_stones.node_sound_stone_defaults())
-- Lepidolite
walls.register("too_many_stones:lepidolite_wall", S("Lepidolite Wall"), "tms_lepidolite.png",
		"too_many_stones:lepidolite", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:lepidolite_cobble_wall", S("Cobbled Lepidolite Wall"), "tms_lepidolite_cobble.png",
		"too_many_stones:lepidolite_cobble", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:lepidolite_brick_wall", S("Lepidolite Brick Wall"), "tms_lepidolite_brick.png",
		"too_many_stones:lepidolite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:lepidolite_cracked_brick_wall", S("Cracked Lepidolite Brick Wall"), "tms_lepidolite_cracked_brick.png",
		"too_many_stones:lepidolite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:lepidolite_block_wall", S("Lepidolite Block Wall"), "tms_lepidolite_block.png",
		"too_many_stones:lepidolite_block", too_many_stones.node_sound_stone_defaults())
-- Blue Limestone
walls.register("too_many_stones:limestone_blue_wall", S("Blue Limestone Wall"), "tms_limestone_blue.png",
		"too_many_stones:limestone_blue", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:limestone_blue_brick_wall", S("Blue Limestone Brick Wall"), "tms_limestone_blue_brick.png",
		"too_many_stones:limestone_blue_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:limestone_blue_cracked_brick_wall", S("Cracked Blue Limestone Brick Wall"), "tms_limestone_blue_cracked_brick.png",
		"too_many_stones:limestone_blue_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:limestone_blue_block_wall", S("Blue Limestone Block Wall"), "tms_limestone_blue_block.png",
		"too_many_stones:limestone_blue_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:limestone_blue_cobble_wall", S("Cobbled Blue Limestone Wall"), "tms_limestone_blue_cobble.png",
		"too_many_stones:limestone_blue_cobble", too_many_stones.node_sound_stone_defaults())
-- White Limestone
walls.register("too_many_stones:limestone_white_wall", S("White Limestone Wall"), "tms_limestone_white.png",
		"too_many_stones:limestone_white", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:limestone_white_brick_wall", S("White Limestone Brick Wall"), "tms_limestone_white_brick.png",
		"too_many_stones:limestone_white_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:limestone_white_cracked_brick_wall", S("Cracked White Limestone Brick Wall"), "tms_limestone_white_cracked_brick.png",
		"too_many_stones:limestone_white_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:limestone_white_block_wall", S("White Limestone Block Wall"), "tms_limestone_white_block.png",
		"too_many_stones:limestone_white_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:limestone_white_cobble_wall", S("Cobbled White Limestone Wall"), "tms_limestone_white_cobble.png",
		"too_many_stones:limestone_white_cobble", too_many_stones.node_sound_stone_defaults())
-- Marble
walls.register("too_many_stones:marble_wall", S("Marble Wall"), "tms_marble.png",
		"too_many_stones:marble", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:marble_brick_wall", S("Marble Brick Wall"), "tms_marble_brick.png",
		"too_many_stones:marble_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:marble_cracked_brick_wall", S("Cracked Marble Brick Wall"), "tms_marble_cracked_brick.png",
		"too_many_stones:marble_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:marble_block_wall", S("Marble Block Wall"), "tms_marble_block.png",
		"too_many_stones:marble_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:marble_cobble_wall", S("Cobbled Marble Wall"), "tms_marble_cobble.png",
		"too_many_stones:marble_cobble", too_many_stones.node_sound_stone_defaults())
-- Moonstone
walls.register("too_many_stones:moonstone_wall", S("Moonstone Wall"), "tms_moonstone.png",
		"too_many_stones:moonstone", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:moonstone_brick_wall", S("Moonstone Brick Wall"), "tms_moonstone_brick.png",
		"too_many_stones:moonstone_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:moonstone_cracked_brick_wall", S("Cracked Moonstone Brick Wall"), "tms_moonstone_cracked_brick.png",
		"too_many_stones:moonstone_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:moonstone_block_wall", S("Moonstone Block Wall"), "tms_moonstone_block.png",
		"too_many_stones:moonstone_block", too_many_stones.node_sound_glass_defaults())
-- Morion Quartz
walls.register("too_many_stones:morion_quartz_wall", S("Morion Quartz Wall"), "tms_morion_quartz.png",
		"too_many_stones:morion_quartz", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:morion_quartz_brick_wall", S("Morion Quartz Brick Wall"), "tms_morion_quartz_brick.png",
		"too_many_stones:morion_quartz_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:morion_quartz_cracked_brick_wall", S("Cracked Morion Quartz Brick Wall"), "tms_morion_quartz_cracked_brick.png",
		"too_many_stones:morion_quartz_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:morion_quartz_block_wall", S("Morion Quartz Block Wall"), "tms_morion_quartz_block.png",
		"too_many_stones:morion_quartz_block", too_many_stones.node_sound_glass_defaults())
-- Mudstone
walls.register("too_many_stones:mudstone_wall", S("Mudstone Wall"), "tms_mudstone.png",
		"too_many_stones:mudstone", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:mudstone_brick_wall", S("Mudstone Brick Wall"), "tms_mudstone_brick.png",
		"too_many_stones:mudstone_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:mudstone_cracked_brick_wall", S("Cracked Mudstone Brick Wall"), "tms_mudstone_cracked_brick.png",
		"too_many_stones:mudstone_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:mudstone_block_wall", S("Mudstone Block Wall"), "tms_mudstone_block.png",
		"too_many_stones:mudstone_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:mudstone_cobble_wall", S("Cobbled Mudstone Wall"), "tms_mudstone_cobble.png",
		"too_many_stones:mudstone_cobble", too_many_stones.node_sound_stone_defaults())
-- Prasiolite
walls.register("too_many_stones:prasiolite_wall", S("Prasiolite Wall"), "tms_prasiolite.png",
		"too_many_stones:prasiolite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:prasiolite_brick_wall", S("Prasiolite Brick Wall"), "tms_prasiolite_brick.png",
		"too_many_stones:prasiolite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:prasiolite_cracked_brick_wall", S("Cracked Prasiolite Brick Wall"), "tms_prasiolite_cracked_brick.png",
		"too_many_stones:prasiolite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:prasiolite_block_wall", S("Prasiolite Block Wall"), "tms_prasiolite_block.png",
		"too_many_stones:prasiolite_block", too_many_stones.node_sound_glass_defaults())
-- Pumice
walls.register("too_many_stones:pumice_wall", S("Pumice Wall"), "tms_pumice.png",
		"too_many_stones:pumice", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:pumice_brick_wall", S("Pumice Brick Wall"), "tms_pumice_brick.png",
		"too_many_stones:pumice_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:pumice_cracked_brick_wall", S("Cracked Pumice Brick Wall"), "tms_pumice_cracked_brick.png",
		"too_many_stones:pumice_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:pumice_block_wall", S("Pumice Block Wall"), "tms_pumice_block.png",
		"too_many_stones:pumice_block", too_many_stones.node_sound_stone_defaults())
-- Pyrite
walls.register("too_many_stones:pyrite_wall", S("Pyrite Wall"), "tms_pyrite.png",
		"too_many_stones:pyrite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:pyrite_brick_wall", S("Pyrite Brick Wall"), "tms_pyrite_brick.png",
		"too_many_stones:pyrite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:pyrite_cracked_brick_wall", S("Cracked Pyrite Brick Wall"), "tms_pyrite_cracked_brick.png",
		"too_many_stones:pyrite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:pyrite_block_wall", S("Pyrite Block Wall"), "tms_pyrite_block.png",
		"too_many_stones:pyrite_block", too_many_stones.node_sound_stone_defaults())
-- Quartz
walls.register("too_many_stones:quartz_wall", S("Quartz Wall"), "tms_quartz.png",
		"too_many_stones:quartz", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:quartz_brick_wall", S("Quartz Brick Wall"), "tms_quartz_brick.png",
		"too_many_stones:quartz_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:quartz_cracked_brick_wall", S("Cracked Quartz Brick Wall"), "tms_quartz_cracked_brick.png",
		"too_many_stones:quartz_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:quartz_block_wall", S("Quartz Block Wall"), "tms_quartz_block.png",
		"too_many_stones:quartz_block", too_many_stones.node_sound_glass_defaults())
-- Rhodonite
walls.register("too_many_stones:rhodonite_wall", S("Rhodonite Wall"), "tms_rhodonite.png",
		"too_many_stones:rhodonite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:rhodonite_brick_wall", S("Rhodonite Brick Wall"), "tms_rhodonite_brick.png",
		"too_many_stones:rhodonite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:rhodonite_cracked_brick_wall", S("Cracked Rhodonite Brick Wall"), "tms_rhodonite_cracked_brick.png",
		"too_many_stones:rhodonite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:rhodonite_block_wall", S("Rhodonite Block Wall"), "tms_rhodonite_block.png",
		"too_many_stones:rhodonite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:rhodonite_cobble_wall", S("Cobbled Rhodonite Wall"), "tms_rhodonite_cobble.png",
		"too_many_stones:rhodonite_cobble", too_many_stones.node_sound_stone_defaults())
-- Rose Quartz
walls.register("too_many_stones:rose_quartz_wall", S("Rose Quartz Wall"), "tms_rose_quartz.png",
		"too_many_stones:rose_quartz", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:rose_quartz_brick_wall", S("Rose Quartz Brick Wall"), "tms_rose_quartz_brick.png",
		"too_many_stones:rose_quartz_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:rose_quartz_cracked_brick_wall", S("Cracked Rose Quartz Brick Wall"), "tms_rose_quartz_cracked_brick.png",
		"too_many_stones:rose_quartz_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:rose_quartz_block_wall", S("Rose Quartz Block Wall"), "tms_rose_quartz_block.png",
		"too_many_stones:rose_quartz_block", too_many_stones.node_sound_glass_defaults())
-- Scoria
walls.register("too_many_stones:scoria_wall", S("Scoria Wall"), "tms_scoria.png",
		"too_many_stones:scoria", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:scoria_brick_wall", S("Scoria Brick Wall"), "tms_scoria_brick.png",
		"too_many_stones:scoria_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:scoria_cracked_brick_wall", S("Cracked Scoria Brick Wall"), "tms_scoria_cracked_brick.png",
		"too_many_stones:scoria_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:scoria_block_wall", S("Scoria Block Wall"), "tms_scoria_block.png",
		"too_many_stones:scoria_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:scoria_cobble_wall", S("Cobbled Scoria Wall"), "tms_scoria_cobble.png",
		"too_many_stones:scoria_cobble", too_many_stones.node_sound_stone_defaults())
-- Serpentine
walls.register("too_many_stones:serpentine_wall", S("Serpentine Wall"), "tms_serpentine.png",
		"too_many_stones:serpentine", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:serpentine_brick_wall", S("Serpentine Brick Wall"), "tms_serpentine_brick.png",
		"too_many_stones:serpentine_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:serpentine_cracked_brick_wall", S("Cracked Serpentine Brick Wall"), "tms_serpentine_cracked_brick.png",
		"too_many_stones:serpentine_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:serpentine_block_wall", S("Serpentine Block Wall"), "tms_serpentine_block.png",
		"too_many_stones:serpentine_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:serpentine_cobble_wall", S("Cobbled Serpentine Wall"), "tms_serpentine_cobble.png",
		"too_many_stones:serpentine_cobble", too_many_stones.node_sound_stone_defaults())
-- Shale
walls.register("too_many_stones:shale_wall", S("Shale Wall"), "tms_shale.png",
		"too_many_stones:shale", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:shale_brick_wall", S("Shale Brick Wall"), "tms_shale_brick.png",
		"too_many_stones:shale_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:shale_cracked_brick_wall", S("Cracked Shale Brick Wall"), "tms_shale_cracked_brick.png",
		"too_many_stones:shale_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:shale_block_wall", S("Shale Block Wall"), "tms_shale_block.png",
		"too_many_stones:shale_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:shale_cobble_wall", S("Cobbled Shale Wall"), "tms_shale_cobble.png",
		"too_many_stones:shale_cobble", too_many_stones.node_sound_stone_defaults())
-- Slate
walls.register("too_many_stones:slate_wall", S("Slate Wall"), "tms_slate.png",
		"too_many_stones:slate", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:slate_brick_wall", S("Slate Brick Wall"), "tms_slate_brick.png",
		"too_many_stones:slate_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:slate_cracked_brick_wall", S("Cracked Slate Brick Wall"), "tms_slate_cracked_brick.png",
		"too_many_stones:slate_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:slate_block_wall", S("Slate Block Wall"), "tms_slate_block.png",
		"too_many_stones:slate_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:slate_cobble_wall", S("Cobbled Slate Wall"), "tms_slate_cobble.png",
		"too_many_stones:slate_cobble", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:slate_tile_wall", S("Slate Tile Wall"), "tms_slate_tile.png",
		"too_many_stones:slate_tile", too_many_stones.node_sound_stone_defaults())
-- Smokey Quartz
walls.register("too_many_stones:smokey_quartz_wall", S("Smokey Quartz Wall"), "tms_smokey_quartz.png",
		"too_many_stones:smokey_quartz", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:smokey_quartz_brick_wall", S("Smokey Quartz Brick Wall"), "tms_smokey_quartz_brick.png",
		"too_many_stones:smokey_quartz_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:smokey_quartz_cracked_brick_wall", S("Cracked Smokey Quartz Brick Wall"), "tms_smokey_quartz_cracked_brick.png",
		"too_many_stones:smokey_quartz_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:smokey_quartz_block_wall", S("Smokey Quartz Block Wall"), "tms_smokey_quartz_block.png",
		"too_many_stones:smokey_quartz_block", too_many_stones.node_sound_glass_defaults())
-- Soapstone
walls.register("too_many_stones:soapstone_wall", S("Soapstone Wall"), "tms_soapstone.png",
		"too_many_stones:soapstone", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:soapstone_brick_wall", S("Soapstone Brick Wall"), "tms_soapstone_brick.png",
		"too_many_stones:soapstone_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:soapstone_cracked_brick_wall", S("Cracked Soapstone Brick Wall"), "tms_soapstone_cracked_brick.png",
		"too_many_stones:soapstone_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:soapstone_block_wall", S("Soapstone Block Wall"), "tms_soapstone_block.png",
		"too_many_stones:soapstone_block", too_many_stones.node_sound_stone_defaults())
-- Sodalite
walls.register("too_many_stones:sodalite_wall", S("Sodalite Wall"), "tms_sodalite.png",
		"too_many_stones:sodalite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:sodalite_brick_wall", S("Sodalite Brick Wall"), "tms_sodalite_brick.png",
		"too_many_stones:sodalite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:sodalite_cracked_brick_wall", S("Cracked Sodalite Brick Wall"), "tms_sodalite_cracked_brick.png",
		"too_many_stones:sodalite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:sodalite_block_wall", S("Sodalite Block Wall"), "tms_sodalite_block.png",
		"too_many_stones:sodalite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:sodalite_cobble_wall", S("Cobbled Sodalite Wall"), "tms_sodalite_cobble.png",
		"too_many_stones:sodalite_cobble", too_many_stones.node_sound_stone_defaults())
-- Sugilite
walls.register("too_many_stones:sugilite_wall", S("Sugilite Wall"), "tms_sugilite.png",
		"too_many_stones:sugilite", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:sugilite_brick_wall", S("Sugilite Brick Wall"), "tms_sugilite_brick.png",
		"too_many_stones:sugilite_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:sugilite_cracked_brick_wall", S("Cracked Sugilite Brick Wall"), "tms_sugilite_cracked_brick.png",
		"too_many_stones:sugilite_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:sugilite_block_wall", S("Sugilite Block Wall"), "tms_sugilite_block.png",
		"too_many_stones:sugilite_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:sugilite_cobble_wall", S("Cobbled Sugilite Wall"), "tms_sugilite_cobble.png",
		"too_many_stones:sugilite_cobble", too_many_stones.node_sound_stone_defaults())
-- Green Tourmaline
walls.register("too_many_stones:tourmaline_green_wall", S("Green Tourmaline Wall"), "tms_tourmaline_green.png",
		"too_many_stones:tourmaline_green", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:tourmaline_green_brick_wall", S("Green Tourmaline Brick Wall"), "tms_tourmaline_green_brick.png",
		"too_many_stones:tourmaline_green_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:tourmaline_green_cracked_brick_wall", S("Cracked Green Tourmaline Brick Wall"), "tms_tourmaline_green_cracked_brick.png",
		"too_many_stones:tourmaline_green_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:tourmaline_green_block_wall", S("Green Tourmaline Block Wall"), "tms_tourmaline_green_block.png",
		"too_many_stones:tourmaline_green_block", too_many_stones.node_sound_glass_defaults())
-- Paraiba Tourmaline
walls.register("too_many_stones:tourmaline_paraiba_wall", S("Paraiba Tourmaline Wall"), "tms_tourmaline_paraiba.png",
		"too_many_stones:tourmaline_paraiba", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:tourmaline_paraiba_brick_wall", S("Paraiba Tourmaline Brick Wall"), "tms_tourmaline_paraiba_brick.png",
		"too_many_stones:tourmaline_paraiba_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:tourmaline_paraiba_cracked_brick_wall", S("Cracked Paraiba Tourmaline Brick Wall"), "tms_tourmaline_paraiba_cracked_brick.png",
		"too_many_stones:tourmaline_paraiba_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:tourmaline_paraiba_block_wall", S("Paraiba Tourmaline Block Wall"), "tms_tourmaline_paraiba_block.png",
		"too_many_stones:tourmaline_paraiba_block", too_many_stones.node_sound_glass_defaults())
-- Pink Tourmaline
walls.register("too_many_stones:tourmaline_pink_wall", S("Pink Tourmaline Wall"), "tms_tourmaline_pink.png",
		"too_many_stones:tourmaline_pink", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:tourmaline_pink_brick_wall", S("Pink Tourmaline Brick Wall"), "tms_tourmaline_pink_brick.png",
		"too_many_stones:tourmaline_pink_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:tourmaline_pink_cracked_brick_wall", S("Cracked Pink Tourmaline Brick Wall"), "tms_tourmaline_pink_cracked_brick.png",
		"too_many_stones:tourmaline_pink_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:tourmaline_pink_block_wall", S("Pink Tourmaline Block Wall"), "tms_tourmaline_pink_block.png",
		"too_many_stones:tourmaline_pink_block", too_many_stones.node_sound_glass_defaults())
-- Travertine
walls.register("too_many_stones:travertine_wall", S("Travertine Wall"), "tms_travertine.png",
		"too_many_stones:travertine", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:travertine_brick_wall", S("Travertine Brick Wall"), "tms_travertine_brick.png",
		"too_many_stones:travertine_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:travertine_cracked_brick_wall", S("Cracked Travertine Brick Wall"), "tms_travertine_cracked_brick.png",
		"too_many_stones:travertine_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:travertine_block_wall", S("Travertine Block Wall"), "tms_travertine_block.png",
		"too_many_stones:travertine_block", too_many_stones.node_sound_stone_defaults())
-- Yellow Travertine
walls.register("too_many_stones:travertine_yellow_wall", S("Yellow Travertine Wall"), "tms_travertine_yellow.png",
		"too_many_stones:travertine_yellow", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:travertine_yellow_brick_wall", S("Yellow Travertine Brick Wall"), "tms_travertine_yellow_brick.png",
		"too_many_stones:travertine_yellow_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:travertine_yellow_cracked_brick_wall", S("Cracked Yellow Travertine Brick Wall"), "tms_travertine_yellow_cracked_brick.png",
		"too_many_stones:travertine_yellow_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:travertine_yellow_block_wall", S("Yellow Travertine Block Wall"), "tms_travertine_yellow_block.png",
		"too_many_stones:travertine_yellow_block", too_many_stones.node_sound_stone_defaults())
-- Beige Tuff
walls.register("too_many_stones:tuff_beige_wall", S("Beige Tuff Wall"), "tms_tuff_beige.png",
		"too_many_stones:tuff_beige", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:tuff_beige_brick_wall", S("Beige Tuff Brick Wall"), "tms_tuff_beige_brick.png",
		"too_many_stones:tuff_beige_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_beige_cracked_brick_wall", S("Cracked Beige Tuff Brick Wall"), "tms_tuff_beige_cracked_brick.png",
		"too_many_stones:tuff_beige_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_beige_block_wall", S("Beige Tuff Block Wall"), "tms_tuff_beige_block.png",
		"too_many_stones:tuff_beige_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_beige_cobble_wall", S("Cobbled Beige Tuff Wall"), "tms_tuff_beige_cobble.png",
		"too_many_stones:tuff_beige_cobble", too_many_stones.node_sound_stone_defaults())
-- Grey Tuff
walls.register("too_many_stones:tuff_grey_wall", S("Grey Tuff Wall"), "tms_tuff_grey.png",
		"too_many_stones:tuff_grey", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:tuff_grey_brick_wall", S("Grey Tuff Brick Wall"), "tms_tuff_grey_brick.png",
		"too_many_stones:tuff_grey_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_grey_cracked_brick_wall", S("Cracked Grey Tuff Brick Wall"), "tms_tuff_grey_cracked_brick.png",
		"too_many_stones:tuff_grey_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_grey_block_wall", S("Grey Tuff Block Wall"), "tms_tuff_grey_block.png",
		"too_many_stones:tuff_grey_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_grey_cobble_wall", S("Cobbled Grey Tuff Wall"), "tms_tuff_grey_cobble.png",
		"too_many_stones:tuff_grey_cobble", too_many_stones.node_sound_stone_defaults())
-- Red Tuff
walls.register("too_many_stones:tuff_red_wall", S("Red Tuff Wall"), "tms_tuff_red.png",
		"too_many_stones:tuff_red", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:tuff_red_brick_wall", S("Red Tuff Brick Wall"), "tms_tuff_red_brick.png",
		"too_many_stones:tuff_red_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_red_cracked_brick_wall", S("Cracked Red Tuff Brick Wall"), "tms_tuff_red_cracked_brick.png",
		"too_many_stones:tuff_red_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_red_block_wall", S("Red Tuff Block Wall"), "tms_tuff_red_block.png",
		"too_many_stones:tuff_red_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:tuff_red_cobble_wall", S("Cobbled Red Tuff Wall"), "tms_tuff_red_cobble.png",
		"too_many_stones:tuff_red_cobble", too_many_stones.node_sound_stone_defaults())
-- Turquoise
walls.register("too_many_stones:turquoise_wall", S("Turquoise Wall"), "tms_turquoise.png",
		"too_many_stones:turquoise", too_many_stones.node_sound_stone_defaults())
		
walls.register("too_many_stones:turquoise_brick_wall", S("Turquoise Brick Wall"), "tms_turquoise_brick.png",
		"too_many_stones:turquoise_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:turquoise_cracked_brick_wall", S("Cracked Turquoise Brick Wall"), "tms_turquoise_cracked_brick.png",
		"too_many_stones:turquoise_cracked_brick", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:turquoise_block_wall", S("Turquoise Block Wall"), "tms_turquoise_block.png",
		"too_many_stones:turquoise_block", too_many_stones.node_sound_stone_defaults())

walls.register("too_many_stones:turquoise_cobble_wall", S("Cobbled Turquoise Wall"), "tms_turquoise_cobble.png",
		"too_many_stones:turquoise_cobble", too_many_stones.node_sound_stone_defaults())
-- Vivianite
walls.register("too_many_stones:vivianite_wall", S("Vivianite Wall"), "tms_vivianite.png",
		"too_many_stones:vivianite", too_many_stones.node_sound_glass_defaults())
		
walls.register("too_many_stones:vivianite_brick_wall", S("Vivianite Brick Wall"), "tms_vivianite_brick.png",
		"too_many_stones:vivianite_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:vivianite_cracked_brick_wall", S("Cracked Vivianite Brick Wall"), "tms_vivianite_cracked_brick.png",
		"too_many_stones:vivianite_cracked_brick", too_many_stones.node_sound_glass_defaults())

walls.register("too_many_stones:vivianite_block_wall", S("Vivianite Block Wall"), "tms_vivianite_block.png",
		"too_many_stones:vivianite_block", too_many_stones.node_sound_glass_defaults())
end
