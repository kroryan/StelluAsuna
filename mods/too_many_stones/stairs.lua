-- support for MT game translation.
local S = minetest.get_translator("too_many_stones")

if minetest.get_modpath("stairs") ~= nil then

-- Blue Agate
stairs.register_stair_and_slab(
	"agate_blue",
	"too_many_stones:agate_blue",
	{cracky = 3},
	{"tms_agate_blue.png"},
	S("Blue Agate Stair"),
	S("Blue Agate Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Blue Agate Stair"),
	S("Outer Blue Agate Stair")
)

-- Gray Agate
stairs.register_stair_and_slab(
	"agate_gray",
	"too_many_stones:agate_gray",
	{cracky = 3},
	{"tms_agate_gray.png"},
	S("Gray Agate Stair"),
	S("Gray Agate Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Gray Agate Stair"),
	S("Outer Gray Agate Stair")
)
-- Green Agate
stairs.register_stair_and_slab(
	"agate_green",
	"too_many_stones:agate_green",
	{cracky = 3},
	{"tms_agate_green.png"},
	S("Green Agate Stair"),
	S("Green Agate Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Green Agate Stair"),
	S("Outer Green Agate Stair")
)
-- Moss Agate
stairs.register_stair_and_slab(
	"agate_moss",
	"too_many_stones:agate_moss",
	{cracky = 3},
	{"tms_agate_moss.png"},
	S("Moss Agate Stair"),
	S("Moss Agate Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Moss Agate Stair"),
	S("Outer Moss Agate Stair")
)
-- Orange Agate
stairs.register_stair_and_slab(
	"agate_orange",
	"too_many_stones:agate_orange",
	{cracky = 3},
	{"tms_agate_orange.png"},
	S("Orange Agate Stair"),
	S("Orange Agate Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Orange Agate Stair"),
	S("Outer Orange Agate Stair")
)
-- Purple Agate
stairs.register_stair_and_slab(
	"agate_purple",
	"too_many_stones:agate_purple",
	{cracky = 3},
	{"tms_agate_purple.png"},
	S("Purple Agate Stair"),
	S("Purple Agate Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Purple Agate Stair"),
	S("Outer Purple Agate Stair")
)
-- Red Agate
stairs.register_stair_and_slab(
	"agate_red",
	"too_many_stones:agate_red",
	{cracky = 3},
	{"tms_agate_red.png"},
	S("Red Agate Stair"),
	S("Red Agate Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Red Agate Stair"),
	S("Outer Red Agate Stair")
)

-- Amazonite
stairs.register_stair_and_slab(
	"amazonite",
	"too_many_stones:amazonite",
	{cracky = 3},
	{"tms_amazonite.png"},
	S("Amazonite Stair"),
	S("Amazonite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Amazonite Stair"),
	S("Outer Amazonite Stair")
)

stairs.register_stair_and_slab(
	"amazonite_cobble",
	"too_many_stones:amazonite_cobble",
	{cracky = 3},
	{"tms_amazonite_cobble.png"},
	S("Cobbled Amazonite Stair"),
	S("Cobbled Amazonite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cobbled Amazonite Stair"),
	S("Outer Cobbled Amazonite Stair")
)

stairs.register_stair_and_slab(
	"amazonite_brick",
	"too_many_stones:amazonite_brick",
	{cracky = 2},
	{"tms_amazonite_brick.png"},
	S("Amazonite Brick Stair"),
	S("Amazonite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Amazonite Brick Stair"),
	S("Outer Amazonite Brick Stair")
)

stairs.register_stair_and_slab(
	"amazonite_cracked_brick",
	"too_many_stones:amazonite_cracked_brick",
	{cracky = 2},
	{"tms_amazonite_cracked_brick.png"},
	S("Cracked Amazonite Brick Stair"),
	S("Cracked Amazonite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Amazonite Brick Stair"),
	S("Outer Cracked Amazonite Brick Stair")
)

stairs.register_stair_and_slab(
	"amazonite_block",
	"too_many_stones:amazonite_block",
	{cracky = 2},
	{"tms_amazonite_block.png"},
	S("Amazonite Block Stair"),
	S("Amazonite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Amazonite Block Stair"),
	S("Outer Amazonite Block Stair")
)
-- Amber
stairs.register_stair_and_slab(
	"amber",
	"too_many_stones:amber",
	{cracky = 3},
	{"tms_amber.png"},
	S("Amber Stair"),
	S("Amber Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Amber Stair"),
	S("Outer Amber Stair")
)

stairs.register_stair_and_slab(
	"amber_brick",
	"too_many_stones:amber_brick",
	{cracky = 2},
	{"tms_amber_brick.png"},
	S("Amber Brick Stair"),
	S("Amber Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Amber Brick Stair"),
	S("Outer Amber Brick Stair")
)

stairs.register_stair_and_slab(
	"amber_cracked_brick",
	"too_many_stones:amber_cracked_brick",
	{cracky = 2},
	{"tms_amber_cracked_brick.png"},
	S("Cracked Amber Brick Stair"),
	S("Cracked Amber Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Amber Brick Stair"),
	S("Outer Cracked Amber Brick Stair")
)

stairs.register_stair_and_slab(
	"amber_block",
	"too_many_stones:amber_block",
	{cracky = 2},
	{"tms_amber_block.png"},
	S("Amber Block Stair"),
	S("Amber Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Amber Block Stair"),
	S("Outer Amber Block Stair")
)
-- Amethyst
stairs.register_stair_and_slab(
	"amethyst",
	"too_many_stones:amethyst",
	{cracky = 3},
	{"tms_amethyst.png"},
	S("Amethyst Stair"),
	S("Amethyst Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Amethyst Stair"),
	S("Outer Amethyst Stair")
)

stairs.register_stair_and_slab(
	"amethyst_brick",
	"too_many_stones:amethyst_brick",
	{cracky = 2},
	{"tms_amethyst_brick.png"},
	S("Amethyst Brick Stair"),
	S("Amethyst Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Amethyst Brick Stair"),
	S("Outer Amethyst Brick Stair")
)

stairs.register_stair_and_slab(
	"amethyst_cracked_brick",
	"too_many_stones:amethyst_cracked_brick",
	{cracky = 2},
	{"tms_amethyst_cracked_brick.png"},
	S("Cracked Amethyst Brick Stair"),
	S("Cracked Amethyst Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Amethyst Brick Stair"),
	S("Outer Cracked Amethyst Brick Stair")
)

stairs.register_stair_and_slab(
	"amethyst_block",
	"too_many_stones:amethyst_block",
	{cracky = 2},
	{"tms_amethyst_block.png"},
	S("Amethyst Block Stair"),
	S("Amethyst Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Amethyst Block Stair"),
	S("Outer Amethyst Block Stair")
)
-- Andesite
stairs.register_stair_and_slab(
	"andesite",
	"too_many_stones:andesite",
	{cracky = 3},
	{"tms_andesite.png"},
	S("Andesite Stair"),
	S("Andesite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Andesite Stair"),
	S("Outer Andesite Stair")
)

stairs.register_stair_and_slab(
	"andesite_cobble",
	"too_many_stones:andesite_cobble",
	{cracky = 3},
	{"tms_andesite_cobble.png"},
	S("Cobbled Andesite Stair"),
	S("Cobbled Andesite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Andesite Stair"),
	S("Outer Cobbled Andesite Stair")
)

stairs.register_stair_and_slab(
	"andesite_brick",
	"too_many_stones:andesite_brick",
	{cracky = 2},
	{"tms_andesite_brick.png"},
	S("Andesite Brick Stair"),
	S("Andesite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Andesite Brick Stair"),
	S("Outer Andesite Brick Stair")
)

stairs.register_stair_and_slab(
	"andesite_cracked_brick",
	"too_many_stones:andesite_cracked_brick",
	{cracky = 2},
	{"tms_andesite_cracked_brick.png"},
	S("Cracked Andesite Brick Stair"),
	S("Cracked Andesite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Andesite Brick Stair"),
	S("Outer Cracked Andesite Brick Stair")
)

stairs.register_stair_and_slab(
	"andesite_block",
	"too_many_stones:andesite_block",
	{cracky = 2},
	{"tms_andesite_block.png"},
	S("Andesite Block Stair"),
	S("Andesite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Andesite Block Stair"),
	S("Outer Andesite Block Stair")
)
-- Basalt
stairs.register_stair_and_slab(
	"basalt",
	"too_many_stones:basalt",
	{cracky = 3},
	{"tms_basalt.png"},
	S("Basalt Stair"),
	S("Basalt Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Basalt Stair"),
	S("Outer Basalt Stair")
)

stairs.register_stair_and_slab(
	"basalt_cobble",
	"too_many_stones:basalt_cobble",
	{cracky = 3},
	{"tms_basalt_cobble.png"},
	S("Cobbled Basalt Stair"),
	S("Cobbled Basalt Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Basalt Stair"),
	S("Outer Cobbled Basalt Stair")
)

stairs.register_stair_and_slab(
	"basalt_brick",
	"too_many_stones:basalt_brick",
	{cracky = 2},
	{"tms_basalt_brick.png"},
	S("Basalt Brick Stair"),
	S("Basalt Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Basalt Brick Stair"),
	S("Outer Basalt Brick Stair")
)

stairs.register_stair_and_slab(
	"basalt_cracked_brick",
	"too_many_stones:basalt_cracked_brick",
	{cracky = 2},
	{"tms_basalt_cracked_brick.png"},
	S("Cracked Basalt Brick Stair"),
	S("Cracked Basalt Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Basalt Brick Stair"),
	S("Outer Cracked Basalt Brick Stair")
)

stairs.register_stair_and_slab(
	"basalt_block",
	"too_many_stones:basalt_block",
	{cracky = 2},
	{"tms_basalt_block.png"},
	S("Basalt Block Stair"),
	S("Basalt Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Basalt Block Stair"),
	S("Outer Basalt Block Stair")
)

stairs.register_stair_and_slab(
	"basalt_tile",
	"too_many_stones:basalt_tile",
	{cracky = 2},
	{"tms_basalt_tile.png"},
	S("Basalt Tile Stair"),
	S("Basalt Tile Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Basalt Tile Stair"),
	S("Outer Basalt Tile Stair")
)
-- Black Moonstone
stairs.register_stair_and_slab(
	"black_moonstone",
	"too_many_stones:black_moonstone",
	{cracky = 3},
	{"tms_black_moonstone.png"},
	S("Black Moonstone Stair"),
	S("Black Moonstone Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Black Moonstone Stair"),
	S("Outer Black Moonstone Stair")
)

stairs.register_stair_and_slab(
	"black_moonstone_brick",
	"too_many_stones:black_moonstone_brick",
	{cracky = 2},
	{"tms_black_moonstone_brick.png"},
	S("Black Moonstone Brick Stair"),
	S("Black Moonstone Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Black Moonstone Brick Stair"),
	S("Outer Black Moonstone Brick Stair")
)

stairs.register_stair_and_slab(
	"black_moonstone_cracked_brick",
	"too_many_stones:black_moonstone_cracked_brick",
	{cracky = 2},
	{"tms_black_moonstone_cracked_brick.png"},
	S("Cracked Black Moonstone Brick Stair"),
	S("Cracked Black Moonstone Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Black Moonstone Brick Stair"),
	S("Outer Cracked Black Moonstone Brick Stair")
)

stairs.register_stair_and_slab(
	"black_moonstone_block",
	"too_many_stones:black_moonstone_block",
	{cracky = 2},
	{"tms_black_moonstone_block.png"},
	S("Black Moonstone Block Stair"),
	S("Black Moonstone Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Black Moonstone Block Stair"),
	S("Outer Black Moonstone Block Stair")
)
-- Grey Calcite
stairs.register_stair_and_slab(
	"calcite_grey",
	"too_many_stones:calcite_grey",
	{cracky = 3},
	{"tms_calcite_grey.png"},
	S("Grey Calcite Stair"),
	S("Grey Calcite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Grey Calcite Stair"),
	S("Outer Grey Calcite Stair")
)

stairs.register_stair_and_slab(
	"calcite_grey_brick",
	"too_many_stones:calcite_grey_brick",
	{cracky = 2},
	{"tms_calcite_grey_brick.png"},
	S("Grey Calcite Brick Stair"),
	S("Grey Calcite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Grey Calcite Brick Stair"),
	S("Outer Grey Calcite Brick Stair")
)

stairs.register_stair_and_slab(
	"calcite_grey_cracked_brick",
	"too_many_stones:calcite_grey_cracked_brick",
	{cracky = 2},
	{"tms_calcite_grey_cracked_brick.png"},
	S("Cracked Grey Calcite Brick Stair"),
	S("Cracked Grey Calcite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Grey Calcite Brick Stair"),
	S("Outer Cracked Grey Calcite Brick Stair")
)

stairs.register_stair_and_slab(
	"calcite_grey_block",
	"too_many_stones:calcite_grey_block",
	{cracky = 2},
	{"tms_calcite_grey_block.png"},
	S("Grey Calcite Block Stair"),
	S("Grey Calcite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Grey Calcite Block Stair"),
	S("Outer Grey Calcite Block Stair")
)
-- Calcite
stairs.register_stair_and_slab(
	"calcite",
	"too_many_stones:calcite",
	{cracky = 3},
	{"tms_calcite.png"},
	S("Calcite Stair"),
	S("Calcite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Calcite Stair"),
	S("Outer Calcite Stair")
)

stairs.register_stair_and_slab(
	"calcite_brick",
	"too_many_stones:calcite_brick",
	{cracky = 2},
	{"tms_calcite_brick.png"},
	S("Calcite Brick Stair"),
	S("Calcite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Calcite Brick Stair"),
	S("Outer Calcite Brick Stair")
)

stairs.register_stair_and_slab(
	"calcite_cracked_brick",
	"too_many_stones:calcite_cracked_brick",
	{cracky = 2},
	{"tms_calcite_cracked_brick.png"},
	S("Cracked Calcite Brick Stair"),
	S("Cracked Calcite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Calcite Brick Stair"),
	S("Outer Cracked Calcite Brick Stair")
)

stairs.register_stair_and_slab(
	"calcite_block",
	"too_many_stones:calcite_block",
	{cracky = 2},
	{"tms_calcite_block.png"},
	S("Calcite Block Stair"),
	S("Calcite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Calcite Block Stair"),
	S("Outer Calcite Block Stair")
)
-- Orange Calcite
stairs.register_stair_and_slab(
	"calcite_orange",
	"too_many_stones:calcite_orange",
	{cracky = 3},
	{"tms_calcite_orange.png"},
	S("Orange Calcite Stair"),
	S("Orange Calcite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Orange Calcite Stair"),
	S("Outer Orange Calcite Stair")
)

stairs.register_stair_and_slab(
	"calcite_orange_brick",
	"too_many_stones:calcite_orange_brick",
	{cracky = 2},
	{"tms_calcite_orange_brick.png"},
	S("Orange Calcite Brick Stair"),
	S("Orange Calcite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Orange Calcite Brick Stair"),
	S("Outer Orange Calcite Brick Stair")
)

stairs.register_stair_and_slab(
	"calcite_orange_cracked_brick",
	"too_many_stones:calcite_orange_cracked_brick",
	{cracky = 2},
	{"tms_calcite_orange_cracked_brick.png"},
	S("Cracked Orange Calcite Brick Stair"),
	S("Cracked Orange Calcite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Orange Calcite Brick Stair"),
	S("Outer Cracked Orange Calcite Brick Stair")
)

stairs.register_stair_and_slab(
	"calcite_orange_block",
	"too_many_stones:calcite_orange_block",
	{cracky = 2},
	{"tms_calcite_orange_block.png"},
	S("Orange Calcite Block Stair"),
	S("Orange Calcite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Orange Calcite Block Stair"),
	S("Outer Orange Calcite Block Stair")
)
-- Carnotite
stairs.register_stair_and_slab(
	"carnotite",
	"too_many_stones:carnotite",
	{cracky = 3},
	{"tms_carnotite.png"},
	S("Carnotite Stair"),
	S("Carnotite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Carnotite Stair"),
	S("Outer Carnotite Stair")
)

stairs.register_stair_and_slab(
	"carnotite_cobble",
	"too_many_stones:carnotite_cobble",
	{cracky = 3},
	{"tms_carnotite_cobble.png"},
	S("Cobbled Carnotite Stair"),
	S("Cobbled Carnotite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Carnotite Stair"),
	S("Outer Cobbled Carnotite Stair")
)

stairs.register_stair_and_slab(
	"carnotite_brick",
	"too_many_stones:carnotite_brick",
	{cracky = 2},
	{"tms_carnotite_brick.png"},
	S("Carnotite Brick Stair"),
	S("Carnotite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Carnotite Brick Stair"),
	S("Outer Carnotite Brick Stair")
)

stairs.register_stair_and_slab(
	"carnotite_cracked_brick",
	"too_many_stones:carnotite_cracked_brick",
	{cracky = 2},
	{"tms_carnotite_cracked_brick.png"},
	S("Cracked Carnotite Brick Stair"),
	S("Cracked Carnotite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Carnotite Brick Stair"),
	S("Outer Cracked Carnotite Brick Stair")
)

stairs.register_stair_and_slab(
	"carnotite_block",
	"too_many_stones:carnotite_block",
	{cracky = 2},
	{"tms_carnotite_block.png"},
	S("Carnotite Block Stair"),
	S("Carnotite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Carnotite Block Stair"),
	S("Outer Carnotite Block Stair")
)
-- Celestine
stairs.register_stair_and_slab(
	"celestine",
	"too_many_stones:celestine",
	{cracky = 3},
	{"tms_celestine.png"},
	S("Celestine Stair"),
	S("Celestine Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Celestine Stair"),
	S("Outer Celestine Stair")
)

stairs.register_stair_and_slab(
	"celestine_brick",
	"too_many_stones:celestine_brick",
	{cracky = 2},
	{"tms_celestine_brick.png"},
	S("Celestine Brick Stair"),
	S("Celestine Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Celestine Brick Stair"),
	S("Outer Celestine Brick Stair")
)

stairs.register_stair_and_slab(
	"celestine_cracked_brick",
	"too_many_stones:celestine_cracked_brick",
	{cracky = 2},
	{"tms_celestine_cracked_brick.png"},
	S("Cracked Celestine Brick Stair"),
	S("Cracked Celestine Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Celestine Brick Stair"),
	S("Outer Cracked Celestine Brick Stair")
)

stairs.register_stair_and_slab(
	"celestine_block",
	"too_many_stones:celestine_block",
	{cracky = 2},
	{"tms_celestine_block.png"},
	S("Celestine Block Stair"),
	S("Celestine Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Celestine Block Stair"),
	S("Outer Celestine Block Stair")
)
-- Chalcanthite
stairs.register_stair_and_slab(
	"chalcanthite",
	"too_many_stones:chalcanthite",
	{cracky = 3},
	{"tms_chalcanthite.png"},
	S("Chalcanthite Stair"),
	S("Chalcanthite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Chalcanthite Stair"),
	S("Outer Chalcanthite Stair")
)

stairs.register_stair_and_slab(
	"chalcanthite_brick",
	"too_many_stones:chalcanthite_brick",
	{cracky = 2},
	{"tms_chalcanthite_brick.png"},
	S("Chalcanthite Brick Stair"),
	S("Chalcanthite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Chalcanthite Brick Stair"),
	S("Outer Chalcanthite Brick Stair")
)

stairs.register_stair_and_slab(
	"chalcanthite_cracked_brick",
	"too_many_stones:chalcanthite_cracked_brick",
	{cracky = 2},
	{"tms_chalcanthite_cracked_brick.png"},
	S("Cracked Chalcanthite Brick Stair"),
	S("Cracked Chalcanthite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Chalcanthite Brick Stair"),
	S("Outer Cracked Chalcanthite Brick Stair")
)

stairs.register_stair_and_slab(
	"chalcanthite_block",
	"too_many_stones:chalcanthite_block",
	{cracky = 2},
	{"tms_chalcanthite_block.png"},
	S("Chalcanthite Block Stair"),
	S("Chalcanthite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Chalcanthite Block Stair"),
	S("Outer Chalcanthite Block Stair")
)

stairs.register_stair_and_slab(
	"chalcanthite_cobble",
	"too_many_stones:chalcanthite_cobble",
	{cracky = 2},
	{"tms_chalcanthite_cobble.png"},
	S("Cobbled Chalcanthite Stair"),
	S("Cobbled Chalcanthite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cobbled Chalcanthite Stair"),
	S("Outer Cobbled Chalcanthite Stair")
)
-- Chrysoprase
stairs.register_stair_and_slab(
	"chrysoprase",
	"too_many_stones:chrysoprase",
	{cracky = 3},
	{"tms_chrysoprase.png"},
	S("Chrysoprase Stair"),
	S("Chrysoprase Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Chrysoprase Stair"),
	S("Outer Chrysoprase Stair")
)

stairs.register_stair_and_slab(
	"chrysoprase_brick",
	"too_many_stones:chrysoprase_brick",
	{cracky = 2},
	{"tms_chrysoprase_brick.png"},
	S("Chrysoprase Brick Stair"),
	S("Chrysoprase Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Chrysoprase Brick Stair"),
	S("Outer Chrysoprase Brick Stair")
)

stairs.register_stair_and_slab(
	"chrysoprase_cracked_brick",
	"too_many_stones:chrysoprase_cracked_brick",
	{cracky = 2},
	{"tms_chrysoprase_cracked_brick.png"},
	S("Cracked Chrysoprase Brick Stair"),
	S("Cracked Chrysoprase Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Chrysoprase Brick Stair"),
	S("Outer Cracked Chrysoprase Brick Stair")
)

stairs.register_stair_and_slab(
	"chrysoprase_block",
	"too_many_stones:chrysoprase_block",
	{cracky = 2},
	{"tms_chrysoprase_block.png"},
	S("Chrysoprase Block Stair"),
	S("Chrysoprase Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Chrysoprase Block Stair"),
	S("Outer Chrysoprase Block Stair")
)
-- Citrine
stairs.register_stair_and_slab(
	"citrine",
	"too_many_stones:citrine",
	{cracky = 3},
	{"tms_citrine.png"},
	S("Citrine Stair"),
	S("Citrine Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Citrine Stair"),
	S("Outer Citrine Stair")
)

stairs.register_stair_and_slab(
	"citrine_brick",
	"too_many_stones:citrine_brick",
	{cracky = 2},
	{"tms_citrine_brick.png"},
	S("Citrine Brick Stair"),
	S("Citrine Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Citrine Brick Stair"),
	S("Outer Citrine Brick Stair")
)

stairs.register_stair_and_slab(
	"citrine_cracked_brick",
	"too_many_stones:citrine_cracked_brick",
	{cracky = 2},
	{"tms_citrine_cracked_brick.png"},
	S("Cracked Citrine Brick Stair"),
	S("Cracked Citrine Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Citrine Brick Stair"),
	S("Outer Cracked Citrine Brick Stair")
)

stairs.register_stair_and_slab(
	"citrine_block",
	"too_many_stones:citrine_block",
	{cracky = 2},
	{"tms_citrine_block.png"},
	S("Citrine Block Stair"),
	S("Citrine Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Citrine Block Stair"),
	S("Outer Citrine Block Stair")
)
-- Covellite
stairs.register_stair_and_slab(
	"covellite",
	"too_many_stones:covellite",
	{cracky = 3},
	{"tms_covellite.png"},
	S("Covellite Stair"),
	S("Covellite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Covellite Stair"),
	S("Outer Covellite Stair")
)

stairs.register_stair_and_slab(
	"covellite_brick",
	"too_many_stones:covellite_brick",
	{cracky = 2},
	{"tms_covellite_brick.png"},
	S("Covellite Brick Stair"),
	S("Covellite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Covellite Brick Stair"),
	S("Outer Covellite Brick Stair")
)

stairs.register_stair_and_slab(
	"covellite_cracked_brick",
	"too_many_stones:covellite_cracked_brick",
	{cracky = 2},
	{"tms_covellite_cracked_brick.png"},
	S("Cracked Covellite Brick Stair"),
	S("Cracked Covellite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Covellite Brick Stair"),
	S("Outer Cracked Covellite Brick Stair")
)

stairs.register_stair_and_slab(
	"covellite_block",
	"too_many_stones:covellite_block",
	{cracky = 2},
	{"tms_covellite_block.png"},
	S("Covellite Block Stair"),
	S("Covellite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Covellite Block Stair"),
	S("Outer Covellite Block Stair")
)

stairs.register_stair_and_slab(
	"covellite_cobble",
	"too_many_stones:covellite_cobble",
	{cracky = 2},
	{"tms_covellite_cobble.png"},
	S("Cobbled Covellite Stair"),
	S("Cobbled Covellite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Covellite Stair"),
	S("Outer Cobbled Covellite Stair")
)
-- Crocoite
stairs.register_stair_and_slab(
	"crocoite",
	"too_many_stones:crocoite",
	{cracky = 3},
	{"tms_crocoite.png"},
	S("Crocoite Stair"),
	S("Crocoite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Crocoite Stair"),
	S("Outer Crocoite Stair")
)

stairs.register_stair_and_slab(
	"crocoite_brick",
	"too_many_stones:crocoite_brick",
	{cracky = 2},
	{"tms_crocoite_brick.png"},
	S("Crocoite Brick Stair"),
	S("Crocoite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Crocoite Brick Stair"),
	S("Outer Crocoite Brick Stair")
)

stairs.register_stair_and_slab(
	"crocoite_cracked_brick",
	"too_many_stones:crocoite_cracked_brick",
	{cracky = 2},
	{"tms_crocoite_cracked_brick.png"},
	S("Cracked Crocoite Brick Stair"),
	S("Cracked Crocoite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Crocoite Brick Stair"),
	S("Outer Cracked Crocoite Brick Stair")
)

stairs.register_stair_and_slab(
	"crocoite_block",
	"too_many_stones:crocoite_block",
	{cracky = 2},
	{"tms_crocoite_block.png"},
	S("Crocoite Block Stair"),
	S("Crocoite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Crocoite Block Stair"),
	S("Outer Crocoite Block Stair")
)
-- Diorite
stairs.register_stair_and_slab(
	"diorite",
	"too_many_stones:diorite",
	{cracky = 3},
	{"tms_diorite.png"},
	S("Diorite Stair"),
	S("Diorite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Diorite Stair"),
	S("Outer Diorite Stair")
)

stairs.register_stair_and_slab(
	"diorite_brick",
	"too_many_stones:diorite_brick",
	{cracky = 2},
	{"tms_diorite_brick.png"},
	S("Diorite Brick Stair"),
	S("Diorite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Diorite Brick Stair"),
	S("Outer Diorite Brick Stair")
)

stairs.register_stair_and_slab(
	"diorite_cracked_brick",
	"too_many_stones:diorite_cracked_brick",
	{cracky = 2},
	{"tms_diorite_cracked_brick.png"},
	S("Cracked Diorite Brick Stair"),
	S("Cracked Diorite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Diorite Brick Stair"),
	S("Outer Cracked Diorite Brick Stair")
)

stairs.register_stair_and_slab(
	"diorite_block",
	"too_many_stones:diorite_block",
	{cracky = 2},
	{"tms_diorite_block.png"},
	S("Diorite Block Stair"),
	S("Diorite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Diorite Block Stair"),
	S("Outer Diorite Block Stair")
)

stairs.register_stair_and_slab(
	"diorite_cobble",
	"too_many_stones:diorite_cobble",
	{cracky = 2},
	{"tms_diorite_cobble.png"},
	S("Cobbled Diorite Stair"),
	S("Cobbled Diorite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Diorite Stair"),
	S("Outer Cobbled Diorite Stair")
)
-- Erythrite
stairs.register_stair_and_slab(
	"erythrite",
	"too_many_stones:erythrite",
	{cracky = 3},
	{"tms_erythrite.png"},
	S("Erythrite Stair"),
	S("Erythrite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Erythrite Stair"),
	S("Outer Erythrite Stair")
)

stairs.register_stair_and_slab(
	"erythrite_brick",
	"too_many_stones:erythrite_brick",
	{cracky = 2},
	{"tms_erythrite_brick.png"},
	S("Erythrite Brick Stair"),
	S("Erythrite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Erythrite Brick Stair"),
	S("Outer Erythrite Brick Stair")
)

stairs.register_stair_and_slab(
	"erythrite_cracked_brick",
	"too_many_stones:erythrite_cracked_brick",
	{cracky = 2},
	{"tms_erythrite_cracked_brick.png"},
	S("Cracked Erythrite Brick Stair"),
	S("Cracked Erythrite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Erythrite Brick Stair"),
	S("Outer Cracked Erythrite Brick Stair")
)

stairs.register_stair_and_slab(
	"erythrite_block",
	"too_many_stones:erythrite_block",
	{cracky = 2},
	{"tms_erythrite_block.png"},
	S("Erythrite Block Stair"),
	S("Erythrite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Erythrite Block Stair"),
	S("Outer Erythrite Block Stair")
)
-- Eudialite
stairs.register_stair_and_slab(
	"eudialite",
	"too_many_stones:eudialite",
	{cracky = 3},
	{"tms_eudialite.png"},
	S("Eudialite Stair"),
	S("Eudialite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Eudialite Stair"),
	S("Outer Eudialite Stair")
)

stairs.register_stair_and_slab(
	"eudialite_brick",
	"too_many_stones:eudialite_brick",
	{cracky = 2},
	{"tms_eudialite_brick.png"},
	S("Eudialite Brick Stair"),
	S("Eudialite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Eudialite Brick Stair"),
	S("Outer Eudialite Brick Stair")
)

stairs.register_stair_and_slab(
	"eudialite_cracked_brick",
	"too_many_stones:eudialite_cracked_brick",
	{cracky = 2},
	{"tms_eudialite_cracked_brick.png"},
	S("Cracked Eudialite Brick Stair"),
	S("Cracked Eudialite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Eudialite Brick Stair"),
	S("Outer Cracked Eudialite Brick Stair")
)

stairs.register_stair_and_slab(
	"eudialite_block",
	"too_many_stones:eudialite_block",
	{cracky = 2},
	{"tms_eudialite_block.png"},
	S("Eudialite Block Stair"),
	S("Eudialite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Eudialite Block Stair"),
	S("Outer Eudialite Block Stair")
)
-- Fluorite
stairs.register_stair_and_slab(
	"fluorite",
	"too_many_stones:fluorite",
	{cracky = 3},
	{"tms_fluorite.png"},
	S("Fluorite Stair"),
	S("Fluorite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Fluorite Stair"),
	S("Outer Fluorite Stair")
)

stairs.register_stair_and_slab(
	"fluorite_brick",
	"too_many_stones:fluorite_brick",
	{cracky = 2},
	{"tms_fluorite_brick.png"},
	S("Fluorite Brick Stair"),
	S("Fluorite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Fluorite Brick Stair"),
	S("Outer Fluorite Brick Stair")
)

stairs.register_stair_and_slab(
	"fluorite_cracked_brick",
	"too_many_stones:fluorite_cracked_brick",
	{cracky = 2},
	{"tms_fluorite_cracked_brick.png"},
	S("Cracked Fluorite Brick Stair"),
	S("Cracked Fluorite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Fluorite Brick Stair"),
	S("Outer Cracked Fluorite Brick Stair")
)

stairs.register_stair_and_slab(
	"fluorite_block",
	"too_many_stones:fluorite_block",
	{cracky = 2},
	{"tms_fluorite_block.png"},
	S("Fluorite Block Stair"),
	S("Fluorite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Fluorite Block Stair"),
	S("Outer Fluorite Block Stair")
)
-- Gabbro
stairs.register_stair_and_slab(
	"gabbro",
	"too_many_stones:gabbro",
	{cracky = 3},
	{"tms_gabbro.png"},
	S("Gabbro Stair"),
	S("Gabbro Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Gabbro Stair"),
	S("Outer Gabbro Stair")
)

stairs.register_stair_and_slab(
	"gabbro_cobble",
	"too_many_stones:gabbro_cobble",
	{cracky = 3},
	{"tms_gabbro_cobble.png"},
	S("Cobbled Gabbro Stair"),
	S("Cobbled Gabbro Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Gabbro Stair"),
	S("Outer Cobbled Gabbro Stair")
)

stairs.register_stair_and_slab(
	"gabbro_brick",
	"too_many_stones:gabbro_brick",
	{cracky = 2},
	{"tms_gabbro_brick.png"},
	S("Gabbro Brick Stair"),
	S("Gabbro Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Gabbro Brick Stair"),
	S("Outer Gabbro Brick Stair")
)

stairs.register_stair_and_slab(
	"gabbro_cracked_brick",
	"too_many_stones:gabbro_cracked_brick",
	{cracky = 2},
	{"tms_gabbro_cracked_brick.png"},
	S("Cracked Gabbro Brick Stair"),
	S("Cracked Gabbro Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Gabbro Brick Stair"),
	S("Outer Cracked Gabbro Brick Stair")
)

stairs.register_stair_and_slab(
	"gabbro_block",
	"too_many_stones:gabbro_block",
	{cracky = 2},
	{"tms_gabbro_block.png"},
	S("Gabbro Block Stair"),
	S("Gabbro Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Gabbro Block Stair"),
	S("Outer Gabbro Block Stair")
)
-- Galena
stairs.register_stair_and_slab(
	"galena",
	"too_many_stones:galena",
	{cracky = 3},
	{"tms_galena.png"},
	S("Galena Stair"),
	S("Galena Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Galena Stair"),
	S("Outer Galena Stair")
)

stairs.register_stair_and_slab(
	"galena_brick",
	"too_many_stones:galena_brick",
	{cracky = 2},
	{"tms_galena_brick.png"},
	S("Galena Brick Stair"),
	S("Galena Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Galena Brick Stair"),
	S("Outer Galena Brick Stair")
)

stairs.register_stair_and_slab(
	"galena_cracked_brick",
	"too_many_stones:galena_cracked_brick",
	{cracky = 2},
	{"tms_galena_cracked_brick.png"},
	S("Cracked Galena Brick Stair"),
	S("Cracked Galena Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Galena Brick Stair"),
	S("Outer Cracked Galena Brick Stair")
)

stairs.register_stair_and_slab(
	"galena_block",
	"too_many_stones:galena_block",
	{cracky = 2},
	{"tms_galena_block.png"},
	S("Galena Block Stair"),
	S("Galena Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Galena Block Stair"),
	S("Outer Galena Block Stair")
)
-- Black Granite
stairs.register_stair_and_slab(
	"granite_black",
	"too_many_stones:granite_black",
	{cracky = 3},
	{"tms_granite_black.png"},
	S("Black Granite Stair"),
	S("Black Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Black Granite Stair"),
	S("Outer Black Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_black_brick",
	"too_many_stones:granite_black_brick",
	{cracky = 2},
	{"tms_granite_black_brick.png"},
	S("Black Granite Brick Stair"),
	S("Black Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Black Granite Brick Stair"),
	S("Outer Black Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_black_cracked_brick",
	"too_many_stones:granite_black_cracked_brick",
	{cracky = 2},
	{"tms_granite_black_cracked_brick.png"},
	S("Cracked Black Granite Brick Stair"),
	S("Cracked Black Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Black Granite Brick Stair"),
	S("Outer Cracked Black Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_black_block",
	"too_many_stones:granite_black_block",
	{cracky = 2},
	{"tms_granite_black_block.png"},
	S("Black Granite Block Stair"),
	S("Black Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Black Granite Block Stair"),
	S("Outer Black Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_black_cobble",
	"too_many_stones:granite_black_cobble",
	{cracky = 2},
	{"tms_granite_black_cobble.png"},
	S("Cobbled Black Granite Stair"),
	S("Cobbled Black Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Black Granite Stair"),
	S("Outer Cobbled Black Granite Stair")
)
-- Blue Granite
stairs.register_stair_and_slab(
	"granite_blue",
	"too_many_stones:granite_blue",
	{cracky = 3},
	{"tms_granite_blue.png"},
	S("Blue Granite Stair"),
	S("Blue Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Blue Granite Stair"),
	S("Outer Blue Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_blue_brick",
	"too_many_stones:granite_blue_brick",
	{cracky = 2},
	{"tms_granite_blue_brick.png"},
	S("Blue Granite Brick Stair"),
	S("Blue Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Blue Granite Brick Stair"),
	S("Outer Blue Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_blue_cracked_brick",
	"too_many_stones:granite_blue_cracked_brick",
	{cracky = 2},
	{"tms_granite_blue_cracked_brick.png"},
	S("Cracked Blue Granite Brick Stair"),
	S("Cracked Blue Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Blue Granite Brick Stair"),
	S("Outer Cracked Blue Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_blue_block",
	"too_many_stones:granite_blue_block",
	{cracky = 2},
	{"tms_granite_blue_block.png"},
	S("Blue Granite Block Stair"),
	S("Blue Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Blue Granite Block Stair"),
	S("Outer Blue Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_blue_cobble",
	"too_many_stones:granite_blue_cobble",
	{cracky = 2},
	{"tms_granite_blue_cobble.png"},
	S("Cobbled Blue Granite Stair"),
	S("Cobbled Blue Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Blue Granite Stair"),
	S("Outer Cobbled Blue Granite Stair")
)
-- Gray Granite
stairs.register_stair_and_slab(
	"granite_gray",
	"too_many_stones:granite_gray",
	{cracky = 3},
	{"tms_granite_gray.png"},
	S("Gray Granite Stair"),
	S("Gray Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Gray Granite Stair"),
	S("Outer Gray Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_gray_brick",
	"too_many_stones:granite_gray_brick",
	{cracky = 2},
	{"tms_granite_gray_brick.png"},
	S("Gray Granite Brick Stair"),
	S("Gray Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Gray Granite Brick Stair"),
	S("Outer Gray Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_gray_cracked_brick",
	"too_many_stones:granite_gray_cracked_brick",
	{cracky = 2},
	{"tms_granite_gray_cracked_brick.png"},
	S("Cracked Gray Granite Brick Stair"),
	S("Cracked Gray Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Gray Granite Brick Stair"),
	S("Outer Cracked Gray Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_gray_block",
	"too_many_stones:granite_gray_block",
	{cracky = 2},
	{"tms_granite_gray_block.png"},
	S("Gray Granite Block Stair"),
	S("Gray Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Gray Granite Block Stair"),
	S("Outer Gray Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_gray_cobble",
	"too_many_stones:granite_gray_cobble",
	{cracky = 2},
	{"tms_granite_gray_cobble.png"},
	S("Cobbled Gray Granite Stair"),
	S("Cobbled Gray Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Gray Granite Stair"),
	S("Outer Cobbled Gray Granite Stair")
)
-- Green Granite
stairs.register_stair_and_slab(
	"granite_green",
	"too_many_stones:granite_green",
	{cracky = 3},
	{"tms_granite_green.png"},
	S("Green Granite Stair"),
	S("Green Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Green Granite Stair"),
	S("Outer Green Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_green_brick",
	"too_many_stones:granite_green_brick",
	{cracky = 2},
	{"tms_granite_green_brick.png"},
	S("Green Granite Brick Stair"),
	S("Green Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Green Granite Brick Stair"),
	S("Outer Green Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_green_cracked_brick",
	"too_many_stones:granite_green_cracked_brick",
	{cracky = 2},
	{"tms_granite_green_cracked_brick.png"},
	S("Cracked Green Granite Brick Stair"),
	S("Cracked Green Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Green Granite Brick Stair"),
	S("Outer Cracked Green Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_green_block",
	"too_many_stones:granite_green_block",
	{cracky = 2},
	{"tms_granite_green_block.png"},
	S("Green Granite Block Stair"),
	S("Green Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Green Granite Block Stair"),
	S("Outer Green Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_green_cobble",
	"too_many_stones:granite_green_cobble",
	{cracky = 2},
	{"tms_granite_green_cobble.png"},
	S("Cobbled Green Granite Stair"),
	S("Cobbled Green Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Green Granite Stair"),
	S("Outer Cobbled Green Granite Stair")
)
-- Pink Granite
stairs.register_stair_and_slab(
	"granite_pink",
	"too_many_stones:granite_pink",
	{cracky = 3},
	{"tms_granite_pink.png"},
	S("Pink Granite Stair"),
	S("Pink Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Pink Granite Stair"),
	S("Outer Pink Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_pink_brick",
	"too_many_stones:granite_pink_brick",
	{cracky = 2},
	{"tms_granite_pink_brick.png"},
	S("Pink Granite Brick Stair"),
	S("Pink Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Pink Granite Brick Stair"),
	S("Outer Pink Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_pink_cracked_brick",
	"too_many_stones:granite_pink_cracked_brick",
	{cracky = 2},
	{"tms_granite_pink_cracked_brick.png"},
	S("Cracked Pink Granite Brick Stair"),
	S("Cracked Pink Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Pink Granite Brick Stair"),
	S("Outer Cracked Pink Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_pink_block",
	"too_many_stones:granite_pink_block",
	{cracky = 2},
	{"tms_granite_pink_block.png"},
	S("Pink Granite Block Stair"),
	S("Pink Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Pink Granite Block Stair"),
	S("Outer Pink Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_pink_cobble",
	"too_many_stones:granite_pink_cobble",
	{cracky = 2},
	{"tms_granite_pink_cobble.png"},
	S("Cobbled Pink Granite Stair"),
	S("Cobbled Pink Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Pink Granite Stair"),
	S("Outer Cobbled Pink Granite Stair")
)
-- Red Granite
stairs.register_stair_and_slab(
	"granite_red",
	"too_many_stones:granite_red",
	{cracky = 3},
	{"tms_granite_red.png"},
	S("Red Granite Stair"),
	S("Red Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Red Granite Stair"),
	S("Outer Red Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_red_brick",
	"too_many_stones:granite_red_brick",
	{cracky = 2},
	{"tms_granite_red_brick.png"},
	S("Red Granite Brick Stair"),
	S("Red Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Red Granite Brick Stair"),
	S("Outer Red Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_red_cracked_brick",
	"too_many_stones:granite_red_cracked_brick",
	{cracky = 2},
	{"tms_granite_red_cracked_brick.png"},
	S("Cracked Red Granite Brick Stair"),
	S("Cracked Red Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Red Granite Brick Stair"),
	S("Outer Cracked Red Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_red_block",
	"too_many_stones:granite_red_block",
	{cracky = 2},
	{"tms_granite_red_block.png"},
	S("Red Granite Block Stair"),
	S("Red Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Red Granite Block Stair"),
	S("Outer Red Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_red_cobble",
	"too_many_stones:granite_red_cobble",
	{cracky = 2},
	{"tms_granite_red_cobble.png"},
	S("Cobbled Red Granite Stair"),
	S("Cobbled Red Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Red Granite Stair"),
	S("Outer Cobbled Red Granite Stair")
)
-- White Granite
stairs.register_stair_and_slab(
	"granite_white",
	"too_many_stones:granite_white",
	{cracky = 3},
	{"tms_granite_white.png"},
	S("White Granite Stair"),
	S("White Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner White Granite Stair"),
	S("Outer White Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_white_brick",
	"too_many_stones:granite_white_brick",
	{cracky = 2},
	{"tms_granite_white_brick.png"},
	S("White Granite Brick Stair"),
	S("White Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner White Granite Brick Stair"),
	S("Outer White Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_white_cracked_brick",
	"too_many_stones:granite_white_cracked_brick",
	{cracky = 2},
	{"tms_granite_white_cracked_brick.png"},
	S("Cracked White Granite Brick Stair"),
	S("Cracked White Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked White Granite Brick Stair"),
	S("Outer Cracked White Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_white_block",
	"too_many_stones:granite_white_block",
	{cracky = 2},
	{"tms_granite_white_block.png"},
	S("White Granite Block Stair"),
	S("White Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner White Granite Block Stair"),
	S("Outer White Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_white_cobble",
	"too_many_stones:granite_white_cobble",
	{cracky = 2},
	{"tms_granite_white_cobble.png"},
	S("Cobbled White Granite Stair"),
	S("Cobbled White Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled White Granite Stair"),
	S("Outer Cobbled White Granite Stair")
)
-- Yellow Granite
stairs.register_stair_and_slab(
	"granite_yellow",
	"too_many_stones:granite_yellow",
	{cracky = 3},
	{"tms_granite_yellow.png"},
	S("Yellow Granite Stair"),
	S("Yellow Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Yellow Granite Stair"),
	S("Outer Yellow Granite Stair")
)

stairs.register_stair_and_slab(
	"granite_yellow_brick",
	"too_many_stones:granite_yellow_brick",
	{cracky = 2},
	{"tms_granite_yellow_brick.png"},
	S("Yellow Granite Brick Stair"),
	S("Yellow Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Yellow Granite Brick Stair"),
	S("Outer Yellow Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_yellow_cracked_brick",
	"too_many_stones:granite_yellow_cracked_brick",
	{cracky = 2},
	{"tms_granite_yellow_cracked_brick.png"},
	S("Cracked Yellow Granite Brick Stair"),
	S("Cracked Yellow Granite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Yellow Granite Brick Stair"),
	S("Outer Cracked Yellow Granite Brick Stair")
)

stairs.register_stair_and_slab(
	"granite_yellow_block",
	"too_many_stones:granite_yellow_block",
	{cracky = 2},
	{"tms_granite_yellow_block.png"},
	S("Yellow Granite Block Stair"),
	S("Yellow Granite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Yellow Granite Block Stair"),
	S("Outer Yellow Granite Block Stair")
)

stairs.register_stair_and_slab(
	"granite_yellow_cobble",
	"too_many_stones:granite_yellow_cobble",
	{cracky = 2},
	{"tms_granite_yellow_cobble.png"},
	S("Cobbled Yellow Granite Stair"),
	S("Cobbled Yellow Granite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Yellow Granite Stair"),
	S("Outer Cobbled Yellow Granite Stair")
)
-- Heliodor
stairs.register_stair_and_slab(
	"heliodor",
	"too_many_stones:heliodor",
	{cracky = 3},
	{"tms_heliodor.png"},
	S("Heliodor Stair"),
	S("Heliodor Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Heliodor Stair"),
	S("Outer Heliodor Stair")
)

stairs.register_stair_and_slab(
	"heliodor_brick",
	"too_many_stones:heliodor_brick",
	{cracky = 2},
	{"tms_heliodor_brick.png"},
	S("Heliodor Brick Stair"),
	S("Heliodor Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Heliodor Brick Stair"),
	S("Outer Heliodor Brick Stair")
)

stairs.register_stair_and_slab(
	"heliodor_cracked_brick",
	"too_many_stones:heliodor_cracked_brick",
	{cracky = 2},
	{"tms_heliodor_cracked_brick.png"},
	S("Cracked Heliodor Brick Stair"),
	S("Cracked Heliodor Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Heliodor Brick Stair"),
	S("Outer Cracked Heliodor Brick Stair")
)

stairs.register_stair_and_slab(
	"heliodor_block",
	"too_many_stones:heliodor_block",
	{cracky = 2},
	{"tms_heliodor_block.png"},
	S("Heliodor Block Stair"),
	S("Heliodor Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Heliodor Block Stair"),
	S("Outer Heliodor Block Stair")
)
-- Howlite
stairs.register_stair_and_slab(
	"howlite",
	"too_many_stones:howlite",
	{cracky = 3},
	{"tms_howlite.png"},
	S("Howlite Stair"),
	S("Howlite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Howlite Stair"),
	S("Outer Howlite Stair")
)

stairs.register_stair_and_slab(
	"howlite_brick",
	"too_many_stones:howlite_brick",
	{cracky = 2},
	{"tms_howlite_brick.png"},
	S("Howlite Brick Stair"),
	S("Howlite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Howlite Brick Stair"),
	S("Outer Howlite Brick Stair")
)

stairs.register_stair_and_slab(
	"howlite_cracked_brick",
	"too_many_stones:howlite_cracked_brick",
	{cracky = 2},
	{"tms_howlite_cracked_brick.png"},
	S("Cracked Howlite Brick Stair"),
	S("Cracked Howlite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Howlite Brick Stair"),
	S("Outer Cracked Howlite Brick Stair")
)

stairs.register_stair_and_slab(
	"howlite_block",
	"too_many_stones:howlite_block",
	{cracky = 2},
	{"tms_howlite_block.png"},
	S("Howlite Block Stair"),
	S("Howlite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Howlite Block Stair"),
	S("Outer Howlite Block Stair")
)

stairs.register_stair_and_slab(
	"howlite_cobble",
	"too_many_stones:howlite_cobble",
	{cracky = 2},
	{"tms_howlite_cobble.png"},
	S("Cobbled Howlite Stair"),
	S("Cobbled Howlite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Howlite Stair"),
	S("Outer Cobbled Howlite Stair")
)
-- Ilvaite
stairs.register_stair_and_slab(
	"ilvaite",
	"too_many_stones:ilvaite",
	{cracky = 3},
	{"tms_ilvaite.png"},
	S("Ilvaite Stair"),
	S("Ilvaite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Ilvaite Stair"),
	S("Outer Ilvaite Stair")
)

stairs.register_stair_and_slab(
	"ilvaite_cobble",
	"too_many_stones:ilvaite_cobble",
	{cracky = 3},
	{"tms_ilvaite_cobble.png"},
	S("Cobbled Ilvaite Stair"),
	S("Cobbled Ilvaite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Ilvaite Stair"),
	S("Outer Cobbled Ilvaite Stair")
)

stairs.register_stair_and_slab(
	"ilvaite_brick",
	"too_many_stones:ilvaite_brick",
	{cracky = 2},
	{"tms_ilvaite_brick.png"},
	S("Ilvaite Brick Stair"),
	S("Ilvaite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Ilvaite Brick Stair"),
	S("Outer Ilvaite Brick Stair")
)

stairs.register_stair_and_slab(
	"ilvaite_cracked_brick",
	"too_many_stones:ilvaite_cracked_brick",
	{cracky = 2},
	{"tms_ilvaite_cracked_brick.png"},
	S("Cracked Ilvaite Brick Stair"),
	S("Cracked Ilvaite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Ilvaite Brick Stair"),
	S("Outer Cracked Ilvaite Brick Stair")
)

stairs.register_stair_and_slab(
	"ilvaite_block",
	"too_many_stones:ilvaite_block",
	{cracky = 2},
	{"tms_ilvaite_block.png"},
	S("Ilvaite Block Stair"),
	S("Ilvaite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Ilvaite Block Stair"),
	S("Outer Ilvaite Block Stair")
)
-- Jade
stairs.register_stair_and_slab(
	"jade",
	"too_many_stones:jade",
	{cracky = 3},
	{"tms_jade.png"},
	S("Jade Stair"),
	S("Jade Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Jade Stair"),
	S("Outer Jade Stair")
)

stairs.register_stair_and_slab(
	"jade_cobble",
	"too_many_stones:jade_cobble",
	{cracky = 3},
	{"tms_jade_cobble.png"},
	S("Cobbled Jade Stair"),
	S("Cobbled Jade Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Jade Stair"),
	S("Outer Cobbled Jade Stair")
)

stairs.register_stair_and_slab(
	"jade_brick",
	"too_many_stones:jade_brick",
	{cracky = 2},
	{"tms_jade_brick.png"},
	S("Jade Brick Stair"),
	S("Jade Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Jade Brick Stair"),
	S("Outer Jade Brick Stair")
)

stairs.register_stair_and_slab(
	"jade_cracked_brick",
	"too_many_stones:jade_cracked_brick",
	{cracky = 2},
	{"tms_jade_cracked_brick.png"},
	S("Cracked Jade Brick Stair"),
	S("Cracked Jade Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Jade Brick Stair"),
	S("Outer Cracked Jade Brick Stair")
)

stairs.register_stair_and_slab(
	"jade_block",
	"too_many_stones:jade_block",
	{cracky = 2},
	{"tms_jade_block.png"},
	S("Jade Block Stair"),
	S("Jade Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Jade Block Stair"),
	S("Outer Jade Block Stair")
)
-- Red Jasper
stairs.register_stair_and_slab(
	"jasper_red",
	"too_many_stones:jasper_red",
	{cracky = 3},
	{"tms_jasper_red.png"},
	S("Red Jasper Stair"),
	S("Red Jasper Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Red Jasper Stair"),
	S("Outer Red Jasper Stair")
)

stairs.register_stair_and_slab(
	"jasper_red_brick",
	"too_many_stones:jasper_red_brick",
	{cracky = 2},
	{"tms_jasper_red_brick.png"},
	S("Red Jasper Brick Stair"),
	S("Red Jasper Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Red Jasper Brick Stair"),
	S("Outer Red Jasper Brick Stair")
)

stairs.register_stair_and_slab(
	"jasper_red_cracked_brick",
	"too_many_stones:jasper_red_cracked_brick",
	{cracky = 2},
	{"tms_jasper_red_cracked_brick.png"},
	S("Cracked Red Jasper Brick Stair"),
	S("Cracked Red Jasper Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Red Jasper Brick Stair"),
	S("Outer Cracked Red Jasper Brick Stair")
)

stairs.register_stair_and_slab(
	"jasper_red_block",
	"too_many_stones:jasper_red_block",
	{cracky = 2},
	{"tms_jasper_red_block.png"},
	S("Red Jasper Block Stair"),
	S("Red Jasper Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Red Jasper Block Stair"),
	S("Outer Red Jasper Block Stair")
)

stairs.register_stair_and_slab(
	"jasper_red_cobble",
	"too_many_stones:jasper_red_cobble",
	{cracky = 2},
	{"tms_jasper_red_cobble.png"},
	S("Cobbled Red Jasper Stair"),
	S("Cobbled Red Jasper Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Red Jasper Stair"),
	S("Outer Cobbled Jasper Stair")
)
-- Kyanite
stairs.register_stair_and_slab(
	"kyanite",
	"too_many_stones:kyanite",
	{cracky = 3},
	{"tms_kyanite.png"},
	S("Kyanite Stair"),
	S("Kyanite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Kyanite Stair"),
	S("Outer Kyanite Stair")
)

stairs.register_stair_and_slab(
	"kyanite_cobble",
	"too_many_stones:kyanite_cobble",
	{cracky = 3},
	{"tms_kyanite_cobble.png"},
	S("Cobbled Kyanite Stair"),
	S("Cobbled Kyanite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cobbled Kyanite Stair"),
	S("Outer Cobbled Kyanite Stair")
)

stairs.register_stair_and_slab(
	"kyanite_brick",
	"too_many_stones:kyanite_brick",
	{cracky = 2},
	{"tms_kyanite_brick.png"},
	S("Kyanite Brick Stair"),
	S("Kyanite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Kyanite Brick Stair"),
	S("Outer Kyanite Brick Stair")
)

stairs.register_stair_and_slab(
	"kyanite_cracked_brick",
	"too_many_stones:kyanite_cracked_brick",
	{cracky = 2},
	{"tms_kyanite_cracked_brick.png"},
	S("Cracked Kyanite Brick Stair"),
	S("Cracked Kyanite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Kyanite Brick Stair"),
	S("Outer Cracked Kyanite Brick Stair")
)

stairs.register_stair_and_slab(
	"kyanite_block",
	"too_many_stones:kyanite_block",
	{cracky = 2},
	{"tms_kyanite_block.png"},
	S("Kyanite Block Stair"),
	S("Kyanite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Kyanite Block Stair"),
	S("Outer Kyanite Block Stair")
)
-- Lapis Lazuli
stairs.register_stair_and_slab(
	"lapis_lazuli",
	"too_many_stones:lapis_lazuli",
	{cracky = 3},
	{"tms_lapis_lazuli.png"},
	S("Lapis Lazuli Stair"),
	S("Lapis Lazuli Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Lapis Lazuli Stair"),
	S("Outer Lapis Lazuli Stair")
)

stairs.register_stair_and_slab(
	"lapis_lazuli_brick",
	"too_many_stones:lapis_lazuli_brick",
	{cracky = 2},
	{"tms_lapis_lazuli_brick.png"},
	S("Lapis Lazuli Brick Stair"),
	S("Lapis Lazuli Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Lapis Lazuli Brick Stair"),
	S("Outer Lapis Lazuli Brick Stair")
)

stairs.register_stair_and_slab(
	"lapis_lazuli_cracked_brick",
	"too_many_stones:lapis_lazuli_cracked_brick",
	{cracky = 2},
	{"tms_lapis_lazuli_cracked_brick.png"},
	S("Cracked Lapis Lazuli Brick Stair"),
	S("Cracked Lapis Lazuli Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Lapis Lazuli Brick Stair"),
	S("Outer Cracked Lapis Lazuli Brick Stair")
)

stairs.register_stair_and_slab(
	"lapis_lazuli_block",
	"too_many_stones:lapis_lazuli_block",
	{cracky = 2},
	{"tms_lapis_lazuli_block.png"},
	S("Lapis Lazuli Block Stair"),
	S("Lapis Lazuli Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Lapis Lazuli Block Stair"),
	S("Outer Lapis Lazuli Block Stair")
)
-- Lepidolite
stairs.register_stair_and_slab(
	"lepidolite",
	"too_many_stones:lepidolite",
	{cracky = 3},
	{"tms_lepidolite.png"},
	S("Lepidolite Stair"),
	S("Lepidolite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Lepidolite Stair"),
	S("Outer Lepidolite Stair")
)

stairs.register_stair_and_slab(
	"lepidolite_brick",
	"too_many_stones:lepidolite_brick",
	{cracky = 2},
	{"tms_lepidolite_brick.png"},
	S("Lepidolite Brick Stair"),
	S("Lepidolite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Lepidolite Brick Stair"),
	S("Outer Lepidolite Brick Stair")
)

stairs.register_stair_and_slab(
	"lepidolite_cracked_brick",
	"too_many_stones:lepidolite_cracked_brick",
	{cracky = 2},
	{"tms_lepidolite_cracked_brick.png"},
	S("Cracked Lepidolite Brick Stair"),
	S("Cracked Lepidolite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Lepidolite Brick Stair"),
	S("Outer Cracked Lepidolite Brick Stair")
)

stairs.register_stair_and_slab(
	"lepidolite_block",
	"too_many_stones:lepidolite_block",
	{cracky = 2},
	{"tms_lepidolite_block.png"},
	S("Lepidolite Block Stair"),
	S("Lepidolite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Lepidolite Block Stair"),
	S("Outer Lepidolite Block Stair")
)

stairs.register_stair_and_slab(
	"lepidolite_cobble",
	"too_many_stones:lepidolite_cobble",
	{cracky = 2},
	{"tms_lepidolite_cobble.png"},
	S("CobbledLepidolite Stair"),
	S("Cobbled Lepidolite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Lepidolite Stair"),
	S("Outer Cobbled Lepidolite Stair")
)
-- Blue Limestone
stairs.register_stair_and_slab(
	"limestone_blue",
	"too_many_stones:limestone_blue",
	{cracky = 3},
	{"tms_limestone_blue.png"},
	S("Blue Limestone Stair"),
	S("Blue Limestone Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Blue Limestone Stair"),
	S("Outer Blue Limestone Stair")
)

stairs.register_stair_and_slab(
	"limestone_blue_cobble",
	"too_many_stones:limestone_blue_cobble",
	{cracky = 3},
	{"tms_limestone_blue_cobble.png"},
	S("Cobbled Blue Limestone Stair"),
	S("Cobbled Blue Limestone Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Blue Limestone Stair"),
	S("Outer Cobbled Blue Limestone Stair")
)

stairs.register_stair_and_slab(
	"limestone_blue_brick",
	"too_many_stones:limestone_blue_brick",
	{cracky = 2},
	{"tms_limestone_blue_brick.png"},
	S("Blue Limestone Brick Stair"),
	S("Blue Limestone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Blue Limestone Brick Stair"),
	S("Outer Blue Limestone Brick Stair")
)

stairs.register_stair_and_slab(
	"limestone_blue_cracked_brick",
	"too_many_stones:limestone_blue_cracked_brick",
	{cracky = 2},
	{"tms_limestone_blue_cracked_brick.png"},
	S("Cracked Blue Limestone Brick Stair"),
	S("Cracked Blue Limestone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Blue Limestone Brick Stair"),
	S("Outer Cracked Blue Limestone Brick Stair")
)

stairs.register_stair_and_slab(
	"limestone_blue_block",
	"too_many_stones:limestone_blue_block",
	{cracky = 2},
	{"tms_limestone_blue_block.png"},
	S("Blue Limestone Block Stair"),
	S("Blue Limestone Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Blue Limestone Block Stair"),
	S("Outer Blue Limestone Block Stair")
)
-- White Limestone
stairs.register_stair_and_slab(
	"limestone_white",
	"too_many_stones:limestone_white",
	{cracky = 3},
	{"tms_limestone_white.png"},
	S("White Limestone Stair"),
	S("White Limestone Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner White Limestone Stair"),
	S("Outer White Limestone Stair")
)

stairs.register_stair_and_slab(
	"limestone_white_cobble",
	"too_many_stones:limestone_white_cobble",
	{cracky = 3},
	{"tms_limestone_white_cobble.png"},
	S("Cobbled White Limestone Stair"),
	S("Cobbled White Limestone Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled White Limestone Stair"),
	S("Outer Cobbled White Limestone Stair")
)

stairs.register_stair_and_slab(
	"limestone_white_brick",
	"too_many_stones:limestone_white_brick",
	{cracky = 2},
	{"tms_limestone_white_brick.png"},
	S("White Limestone Brick Stair"),
	S("White Limestone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner White Limestone Brick Stair"),
	S("Outer White Limestone Brick Stair")
)

stairs.register_stair_and_slab(
	"limestone_white_cracked_brick",
	"too_many_stones:limestone_white_cracked_brick",
	{cracky = 2},
	{"tms_limestone_white_cracked_brick.png"},
	S("Cracked White Limestone Brick Stair"),
	S("Cracked White Limestone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked White Limestone Brick Stair"),
	S("Outer Cracked White Limestone Brick Stair")
)

stairs.register_stair_and_slab(
	"limestone_white_block",
	"too_many_stones:limestone_white_block",
	{cracky = 2},
	{"tms_limestone_white_block.png"},
	S("White Limestone Block Stair"),
	S("White Limestone Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner White Limestone Block Stair"),
	S("Outer White Limestone Block Stair")
)
-- Marble
stairs.register_stair_and_slab(
	"marble",
	"too_many_stones:marble",
	{cracky = 3},
	{"tms_marble.png"},
	S("Marble Stair"),
	S("Marble Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Marble Stair"),
	S("Outer Marble Stair")
)

stairs.register_stair_and_slab(
	"marble_cobble",
	"too_many_stones:marble_cobble",
	{cracky = 3},
	{"tms_marble_cobble.png"},
	S("Cobbled Marble Stair"),
	S("Cobbled Marble Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Marble Stair"),
	S("Outer Cobbled Marble Stair")
)

stairs.register_stair_and_slab(
	"marble_brick",
	"too_many_stones:marble_brick",
	{cracky = 2},
	{"tms_marble_brick.png"},
	S("Marble Brick Stair"),
	S("Marble Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Marble Brick Stair"),
	S("Outer Marble Brick Stair")
)

stairs.register_stair_and_slab(
	"marble_cracked_brick",
	"too_many_stones:marble_cracked_brick",
	{cracky = 2},
	{"tms_marble_cracked_brick.png"},
	S("Cracked Marble Brick Stair"),
	S("Cracked Marble Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Marble Brick Stair"),
	S("Outer Cracked Marble Brick Stair")
)

stairs.register_stair_and_slab(
	"marble_block",
	"too_many_stones:marble_block",
	{cracky = 2},
	{"tms_marble_block.png"},
	S("Marble Block Stair"),
	S("Marble Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Marble Block Stair"),
	S("Outer Marble Block Stair")
)
-- Moonstone
stairs.register_stair_and_slab(
	"moonstone",
	"too_many_stones:moonstone",
	{cracky = 3},
	{"tms_moonstone.png"},
	S("Moonstone Stair"),
	S("Moonstone Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Moonstone Stair"),
	S("Outer Moonstone Stair")
)

stairs.register_stair_and_slab(
	"moonstone_brick",
	"too_many_stones:moonstone_brick",
	{cracky = 2},
	{"tms_moonstone_brick.png"},
	S("Moonstone Brick Stair"),
	S("Moonstone Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Moonstone Brick Stair"),
	S("Outer Moonstone Brick Stair")
)

stairs.register_stair_and_slab(
	"moonstone_cracked_brick",
	"too_many_stones:moonstone_cracked_brick",
	{cracky = 2},
	{"tms_moonstone_cracked_brick.png"},
	S("Cracked Moonstone Brick Stair"),
	S("Cracked Moonstone Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Moonstone Brick Stair"),
	S("Outer Cracked Moonstone Brick Stair")
)

stairs.register_stair_and_slab(
	"moonstone_block",
	"too_many_stones:moonstone_block",
	{cracky = 2},
	{"tms_moonstone_block.png"},
	S("Moonstone Block Stair"),
	S("Moonstone Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Moonstone Block Stair"),
	S("Outer Moonstone Block Stair")
)
-- Morion Quartz
stairs.register_stair_and_slab(
	"morion_quartz",
	"too_many_stones:morion_quartz",
	{cracky = 3},
	{"tms_morion_quartz.png"},
	S("Morion Quartz Stair"),
	S("Morion Quartz Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Morion Quartz Stair"),
	S("Outer Morion Quartz Stair")
)

stairs.register_stair_and_slab(
	"morion_quartz_brick",
	"too_many_stones:morion_quartz_brick",
	{cracky = 2},
	{"tms_morion_quartz_brick.png"},
	S("Morion Quartz Brick Stair"),
	S("Morion Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Morion Quartz Brick Stair"),
	S("Outer Morion Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"morion_quartz_cracked_brick",
	"too_many_stones:morion_quartz_cracked_brick",
	{cracky = 2},
	{"tms_morion_quartz_cracked_brick.png"},
	S("Cracked Morion Quartz Brick Stair"),
	S("Cracked Morion Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Morion Quartz Brick Stair"),
	S("Outer Cracked Morion Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"morion_quartz_block",
	"too_many_stones:morion_quartz_block",
	{cracky = 2},
	{"tms_morion_quartz_block.png"},
	S("Morion Quartz Block Stair"),
	S("Morion Quartz Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Morion Quartz Block Stair"),
	S("Outer Morion Quartz Block Stair")
)
-- Mudstone
stairs.register_stair_and_slab(
	"mudstone",
	"too_many_stones:mudstone",
	{cracky = 3},
	{"tms_mudstone.png"},
	S("Mudstone Stair"),
	S("Mudstone Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Mudstone Stair"),
	S("Outer Mudstone Stair")
)

stairs.register_stair_and_slab(
	"mudstone_cobble",
	"too_many_stones:mudstone_cobble",
	{cracky = 3},
	{"tms_mudstone_cobble.png"},
	S("Cobbled Mudstone Stair"),
	S("Cobbled Mudstone Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Mudstone Stair"),
	S("Outer Cobbled Mudstone Stair")
)

stairs.register_stair_and_slab(
	"mudstone_brick",
	"too_many_stones:mudstone_brick",
	{cracky = 2},
	{"tms_mudstone_brick.png"},
	S("Mudstone Brick Stair"),
	S("Mudstone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Mudstone Brick Stair"),
	S("Outer Mudstone Brick Stair")
)

stairs.register_stair_and_slab(
	"mudstone_cracked_brick",
	"too_many_stones:mudstone_cracked_brick",
	{cracky = 2},
	{"tms_mudstone_cracked_brick.png"},
	S("Cracked Mudstone Brick Stair"),
	S("Cracked Mudstone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Mudstone Brick Stair"),
	S("Outer Cracked Mudstone Brick Stair")
)

stairs.register_stair_and_slab(
	"mudstone_block",
	"too_many_stones:mudstone_block",
	{cracky = 2},
	{"tms_mudstone_block.png"},
	S("Mudstone Block Stair"),
	S("Mudstone Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Mudstone Block Stair"),
	S("Outer Mudstone Block Stair")
)
-- Prasiolite
stairs.register_stair_and_slab(
	"prasiolite",
	"too_many_stones:prasiolite",
	{cracky = 3},
	{"tms_prasiolite.png"},
	S("Prasiolite Stair"),
	S("Prasiolite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Prasiolite Stair"),
	S("Outer Prasiolite Stair")
)

stairs.register_stair_and_slab(
	"prasiolite_brick",
	"too_many_stones:prasiolite_brick",
	{cracky = 2},
	{"tms_prasiolite_brick.png"},
	S("Prasiolite Brick Stair"),
	S("Prasiolite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Prasiolite Brick Stair"),
	S("Outer Prasiolite Brick Stair")
)

stairs.register_stair_and_slab(
	"prasiolite_cracked_brick",
	"too_many_stones:prasiolite_cracked_brick",
	{cracky = 2},
	{"tms_prasiolite_cracked_brick.png"},
	S("Cracked Prasiolite Brick Stair"),
	S("Cracked Prasiolite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Prasiolite Brick Stair"),
	S("Outer Cracked Prasiolite Brick Stair")
)

stairs.register_stair_and_slab(
	"prasiolite_block",
	"too_many_stones:prasiolite_block",
	{cracky = 2},
	{"tms_prasiolite_block.png"},
	S("Prasiolite Block Stair"),
	S("Prasiolite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Prasiolite Block Stair"),
	S("Outer Prasiolite Block Stair")
)
-- Pumice
stairs.register_stair_and_slab(
	"pumice",
	"too_many_stones:pumice",
	{cracky = 3},
	{"tms_pumice.png"},
	S("Pumice Stair"),
	S("Pumice Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Pumice Stair"),
	S("Outer Pumice Stair")
)

stairs.register_stair_and_slab(
	"pumice_brick",
	"too_many_stones:pumice_brick",
	{cracky = 2},
	{"tms_pumice_brick.png"},
	S("Pumice Brick Stair"),
	S("Pumice Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Pumice Brick Stair"),
	S("Outer Pumice Brick Stair")
)

stairs.register_stair_and_slab(
	"pumice_cracked_brick",
	"too_many_stones:pumice_cracked_brick",
	{cracky = 2},
	{"tms_pumice_cracked_brick.png"},
	S("Cracked Pumice Brick Stair"),
	S("Cracked Pumice Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Pumice Brick Stair"),
	S("Outer Cracked Pumice Brick Stair")
)

stairs.register_stair_and_slab(
	"pumice_block",
	"too_many_stones:pumice_block",
	{cracky = 2},
	{"tms_pumice_block.png"},
	S("Pumice Block Stair"),
	S("Pumice Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Pumice Block Stair"),
	S("Outer Pumice Block Stair")
)
-- Pyrite
stairs.register_stair_and_slab(
	"pyrite",
	"too_many_stones:pyrite",
	{cracky = 3},
	{"tms_pyrite.png"},
	S("Pyrite Stair"),
	S("Pyrite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Pyrite Stair"),
	S("Outer Pyrite Stair")
)

stairs.register_stair_and_slab(
	"pyrite_brick",
	"too_many_stones:pyrite_brick",
	{cracky = 2},
	{"tms_pyrite_brick.png"},
	S("Pyrite Brick Stair"),
	S("Pyrite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Pyrite Brick Stair"),
	S("Outer Pyrite Brick Stair")
)

stairs.register_stair_and_slab(
	"pyrite_cracked_brick",
	"too_many_stones:pyrite_cracked_brick",
	{cracky = 2},
	{"tms_pyrite_cracked_brick.png"},
	S("Cracked Pyrite Brick Stair"),
	S("Cracked Pyrite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Pyrite Brick Stair"),
	S("Outer Cracked Pyrite Brick Stair")
)

stairs.register_stair_and_slab(
	"pyrite_block",
	"too_many_stones:pyrite_block",
	{cracky = 2},
	{"tms_pyrite_block.png"},
	S("Pyrite Block Stair"),
	S("Pyrite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Pyrite Block Stair"),
	S("Outer Pyrite Block Stair")
)
-- Quartz
stairs.register_stair_and_slab(
	"quartz",
	"too_many_stones:quartz",
	{cracky = 3},
	{"tms_quartz.png"},
	S("Quartz Stair"),
	S("Quartz Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Quartz Stair"),
	S("Outer Quartz Stair")
)

stairs.register_stair_and_slab(
	"quartz_brick",
	"too_many_stones:quartz_brick",
	{cracky = 2},
	{"tms_quartz_brick.png"},
	S("Quartz Brick Stair"),
	S("Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Quartz Brick Stair"),
	S("Outer Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"quartz_cracked_brick",
	"too_many_stones:quartz_cracked_brick",
	{cracky = 2},
	{"tms_quartz_cracked_brick.png"},
	S("Cracked Quartz Brick Stair"),
	S("Cracked Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Quartz Brick Stair"),
	S("Outer Cracked Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"quartz_block",
	"too_many_stones:quartz_block",
	{cracky = 2},
	{"tms_quartz_block.png"},
	S("Quartz Block Stair"),
	S("Quartz Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Quartz Block Stair"),
	S("Outer Quartz Block Stair")
)
-- Rhodonite
stairs.register_stair_and_slab(
	"rhodonite",
	"too_many_stones:rhodonite",
	{cracky = 3},
	{"tms_rhodonite.png"},
	S("Rhodonite Stair"),
	S("Rhodonite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Rhodonite Stair"),
	S("Outer Rhodonite Stair")
)

stairs.register_stair_and_slab(
	"rhodonite_brick",
	"too_many_stones:rhodonite_brick",
	{cracky = 2},
	{"tms_rhodonite_brick.png"},
	S("Rhodonite Brick Stair"),
	S("Rhodonite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Rhodonite Brick Stair"),
	S("Outer Rhodonite Brick Stair")
)

stairs.register_stair_and_slab(
	"rhodonite_cracked_brick",
	"too_many_stones:rhodonite_cracked_brick",
	{cracky = 2},
	{"tms_rhodonite_cracked_brick.png"},
	S("Cracked Rhodonite Brick Stair"),
	S("Cracked Rhodonite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Rhodonite Brick Stair"),
	S("Outer Cracked Rhodonite Brick Stair")
)

stairs.register_stair_and_slab(
	"rhodonite_block",
	"too_many_stones:rhodonite_block",
	{cracky = 2},
	{"tms_rhodonite_block.png"},
	S("Rhodonite Block Stair"),
	S("Rhodonite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Rhodonite Block Stair"),
	S("Outer Rhodonite Block Stair")
)

stairs.register_stair_and_slab(
	"rhodonite_cobble",
	"too_many_stones:rhodonite_cobble",
	{cracky = 2},
	{"tms_rhodonite_cobble.png"},
	S("Cobbled Rhodonite Stair"),
	S("Cobbled Rhodonite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Rhodonite Stair"),
	S("Outer Cobbled Rhodonite Stair")
)
-- Rose Quartz
stairs.register_stair_and_slab(
	"rose_quartz",
	"too_many_stones:rose_quartz",
	{cracky = 3},
	{"tms_rose_quartz.png"},
	S("Rose Quartz Stair"),
	S("Rose Quartz Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Rose Quartz Stair"),
	S("Outer Rose Quartz Stair")
)

stairs.register_stair_and_slab(
	"rose_quartz_brick",
	"too_many_stones:rose_quartz_brick",
	{cracky = 2},
	{"tms_rose_quartz_brick.png"},
	S("Rose Quartz Brick Stair"),
	S("Rose Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Rose Quartz Brick Stair"),
	S("Outer Rose Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"rose_quartz_cracked_brick",
	"too_many_stones:rose_quartz_cracked_brick",
	{cracky = 2},
	{"tms_rose_quartz_cracked_brick.png"},
	S("Cracked Rose Quartz Brick Stair"),
	S("Cracked Rose Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Rose Quartz Brick Stair"),
	S("Outer Cracked Rose Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"rose_quartz_block",
	"too_many_stones:rose_quartz_block",
	{cracky = 2},
	{"tms_rose_quartz_block.png"},
	S("Rose Quartz Block Stair"),
	S("Rose Quartz Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Rose Quartz Block Stair"),
	S("Outer Rose Quartz Block Stair")
)
-- Scoria
stairs.register_stair_and_slab(
	"scoria",
	"too_many_stones:scoria",
	{cracky = 3},
	{"tms_scoria.png"},
	S("Scoria Stair"),
	S("Scoria Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Scoria Stair"),
	S("Outer Scoria Stair")
)

stairs.register_stair_and_slab(
	"scoria_cobble",
	"too_many_stones:scoria_cobble",
	{cracky = 3},
	{"tms_scoria_cobble.png"},
	S("Cobbled Scoria Stair"),
	S("Cobbled Scoria Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Scoria Stair"),
	S("Outer Cobbled Scoria Stair")
)

stairs.register_stair_and_slab(
	"scoria_brick",
	"too_many_stones:scoria_brick",
	{cracky = 2},
	{"tms_scoria_brick.png"},
	S("Scoria Brick Stair"),
	S("Scoria Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Scoria Brick Stair"),
	S("Outer Scoria Brick Stair")
)

stairs.register_stair_and_slab(
	"scoria_cracked_brick",
	"too_many_stones:scoria_cracked_brick",
	{cracky = 2},
	{"tms_scoria_cracked_brick.png"},
	S("Cracked Scoria Brick Stair"),
	S("Cracked Scoria Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Scoria Brick Stair"),
	S("Outer Cracked Scoria Brick Stair")
)

stairs.register_stair_and_slab(
	"scoria_block",
	"too_many_stones:scoria_block",
	{cracky = 2},
	{"tms_scoria_block.png"},
	S("Scoria Block Stair"),
	S("Scoria Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Scoria Block Stair"),
	S("Outer Scoria Block Stair")
)
-- Serpentine
stairs.register_stair_and_slab(
	"serpentine",
	"too_many_stones:serpentine",
	{cracky = 3},
	{"tms_serpentine.png"},
	S("Serpentine Stair"),
	S("Serpentine Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Serpentine Stair"),
	S("Outer Serpentine Stair")
)

stairs.register_stair_and_slab(
	"serpentine_cobble",
	"too_many_stones:serpentine_cobble",
	{cracky = 3},
	{"tms_serpentine_cobble.png"},
	S("Cobbled Serpentine Stair"),
	S("Cobbled Serpentine Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Serpentine Stair"),
	S("Outer Cobbled Serpentine Stair")
)

stairs.register_stair_and_slab(
	"serpentine_brick",
	"too_many_stones:serpentine_brick",
	{cracky = 2},
	{"tms_serpentine_brick.png"},
	S("Serpentine Brick Stair"),
	S("Serpentine Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Serpentine Brick Stair"),
	S("Outer Serpentine Brick Stair")
)

stairs.register_stair_and_slab(
	"serpentine_cracked_brick",
	"too_many_stones:serpentine_cracked_brick",
	{cracky = 2},
	{"tms_serpentine_cracked_brick.png"},
	S("Cracked Serpentine Brick Stair"),
	S("Cracked Serpentine Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Serpentine Brick Stair"),
	S("Outer Cracked Serpentine Brick Stair")
)

stairs.register_stair_and_slab(
	"serpentine_block",
	"too_many_stones:serpentine_block",
	{cracky = 2},
	{"tms_serpentine_block.png"},
	S("Serpentine Block Stair"),
	S("Serpentine Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Serpentine Block Stair"),
	S("Outer Serpentine Block Stair")
)
-- Shale
stairs.register_stair_and_slab(
	"shale",
	"too_many_stones:shale",
	{cracky = 3},
	{"tms_shale.png"},
	S("Shale Stair"),
	S("Shale Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Shale Stair"),
	S("Outer Shale Stair")
)

stairs.register_stair_and_slab(
	"shale_cobble",
	"too_many_stones:shale_cobble",
	{cracky = 3},
	{"tms_shale_cobble.png"},
	S("Cobbled Shale Stair"),
	S("Cobbled Shale Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Shale Stair"),
	S("Outer Cobbled Shale Stair")
)

stairs.register_stair_and_slab(
	"shale_brick",
	"too_many_stones:shale_brick",
	{cracky = 2},
	{"tms_shale_brick.png"},
	S("Shale Brick Stair"),
	S("Shale Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Shale Brick Stair"),
	S("Outer Shale Brick Stair")
)

stairs.register_stair_and_slab(
	"shale_cracked_brick",
	"too_many_stones:shale_cracked_brick",
	{cracky = 2},
	{"tms_shale_cracked_brick.png"},
	S("Cracked Shale Brick Stair"),
	S("Cracked Shale Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Shale Brick Stair"),
	S("Outer Cracked Shale Brick Stair")
)

stairs.register_stair_and_slab(
	"shale_block",
	"too_many_stones:shale_block",
	{cracky = 2},
	{"tms_shale_block.png"},
	S("Shale Block Stair"),
	S("Shale Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Shale Block Stair"),
	S("Outer Shale Block Stair")
)
-- Slate
stairs.register_stair_and_slab(
	"slate",
	"too_many_stones:slate",
	{cracky = 3},
	{"tms_slate.png"},
	S("Slate Stair"),
	S("Slate Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Slate Stair"),
	S("Outer Slate Stair")
)

stairs.register_stair_and_slab(
	"slate_cobble",
	"too_many_stones:slate_cobble",
	{cracky = 3},
	{"tms_slate_cobble.png"},
	S("Cobbled Slate Stair"),
	S("Cobbled Slate Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Slate Stair"),
	S("Outer Cobbled Slate Stair")
)

stairs.register_stair_and_slab(
	"slate_brick",
	"too_many_stones:slate_brick",
	{cracky = 2},
	{"tms_slate_brick.png"},
	S("Slate Brick Stair"),
	S("Slate Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Slate Brick Stair"),
	S("Outer Slate Brick Stair")
)

stairs.register_stair_and_slab(
	"slate_cracked_brick",
	"too_many_stones:slate_cracked_brick",
	{cracky = 2},
	{"tms_slate_cracked_brick.png"},
	S("Cracked Slate Brick Stair"),
	S("Cracked Slate Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Slate Brick Stair"),
	S("Outer Cracked Slate Brick Stair")
)

stairs.register_stair_and_slab(
	"slate_block",
	"too_many_stones:slate_block",
	{cracky = 2},
	{"tms_slate_block.png"},
	S("Slate Block Stair"),
	S("Slate Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Slate Block Stair"),
	S("Outer Slate Block Stair")
)

stairs.register_stair_and_slab(
	"slate_tile",
	"too_many_stones:slate_tile",
	{cracky = 2},
	{"tms_slate_tile.png"},
	S("Slate Tile Stair"),
	S("Slate Tile Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Slate Tile Stair"),
	S("Outer Slate Tile Stair")
)
-- Smokey Quartz
stairs.register_stair_and_slab(
	"smokey_quartz",
	"too_many_stones:smokey_quartz",
	{cracky = 3},
	{"tms_smokey_quartz.png"},
	S("Smokey Quartz Stair"),
	S("Smokey Quartz Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Smokey Quartz Stair"),
	S("Outer Smokey Quartz Stair")
)

stairs.register_stair_and_slab(
	"smokey_quartz_brick",
	"too_many_stones:smokey_quartz_brick",
	{cracky = 2},
	{"tms_smokey_quartz_brick.png"},
	S("Smokey Quartz Brick Stair"),
	S("Smokey Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Smokey Quartz Brick Stair"),
	S("Outer Smokey Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"smokey_quartz_cracked_brick",
	"too_many_stones:smokey_quartz_cracked_brick",
	{cracky = 2},
	{"tms_smokey_quartz_cracked_brick.png"},
	S("Cracked Smokey Quartz Brick Stair"),
	S("Cracked Smokey Quartz Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Smokey Quartz Brick Stair"),
	S("Outer Cracked Smokey Quartz Brick Stair")
)

stairs.register_stair_and_slab(
	"smokey_quartz_block",
	"too_many_stones:smokey_quartz_block",
	{cracky = 2},
	{"tms_smokey_quartz_block.png"},
	S("Smokey Quartz Block Stair"),
	S("Smokey Quartz Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Smokey Quartz Block Stair"),
	S("Outer Smokey Quartz Block Stair")
)
-- Soapstone
stairs.register_stair_and_slab(
	"soapstone",
	"too_many_stones:soapstone",
	{cracky = 3},
	{"tms_soapstone.png"},
	S("Soapstone Stair"),
	S("Soapstone Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Soapstone Stair"),
	S("Outer Soapstone Stair")
)

stairs.register_stair_and_slab(
	"soapstone_brick",
	"too_many_stones:soapstone_brick",
	{cracky = 2},
	{"tms_soapstone_brick.png"},
	S("Soapstone Brick Stair"),
	S("Soapstone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Soapstone Brick Stair"),
	S("Outer Soapstone Brick Stair")
)

stairs.register_stair_and_slab(
	"soapstone_cracked_brick",
	"too_many_stones:soapstone_cracked_brick",
	{cracky = 2},
	{"tms_soapstone_cracked_brick.png"},
	S("Cracked Soapstone Brick Stair"),
	S("Cracked Soapstone Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Soapstone Brick Stair"),
	S("Outer Cracked Soapstone Brick Stair")
)

stairs.register_stair_and_slab(
	"soapstone_block",
	"too_many_stones:soapstone_block",
	{cracky = 2},
	{"tms_soapstone_block.png"},
	S("Soapstone Block Stair"),
	S("Soapstone Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Soapstone Block Stair"),
	S("Outer Soapstone Block Stair")
)
-- Sodalite
stairs.register_stair_and_slab(
	"sodalite",
	"too_many_stones:sodalite",
	{cracky = 3},
	{"tms_sodalite.png"},
	S("Sodalite Stair"),
	S("Sodalite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Sodalite Stair"),
	S("Outer Sodalite Stair")
)

stairs.register_stair_and_slab(
	"sodalite_cobble",
	"too_many_stones:sodalite_cobble",
	{cracky = 3},
	{"tms_sodalite_cobble.png"},
	S("Cobbled Sodalite Stair"),
	S("Cobbled Sodalite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Sodalite Stair"),
	S("Outer Cobbled Sodalite Stair")
)

stairs.register_stair_and_slab(
	"sodalite_brick",
	"too_many_stones:sodalite_brick",
	{cracky = 2},
	{"tms_sodalite_brick.png"},
	S("Sodalite Brick Stair"),
	S("Sodalite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Sodalite Brick Stair"),
	S("Outer Sodalite Brick Stair")
)

stairs.register_stair_and_slab(
	"sodalite_cracked_brick",
	"too_many_stones:sodalite_cracked_brick",
	{cracky = 2},
	{"tms_sodalite_cracked_brick.png"},
	S("Cracked Sodalite Brick Stair"),
	S("Cracked Sodalite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Sodalite Brick Stair"),
	S("Outer Cracked Sodalite Brick Stair")
)

stairs.register_stair_and_slab(
	"sodalite_block",
	"too_many_stones:sodalite_block",
	{cracky = 2},
	{"tms_sodalite_block.png"},
	S("Sodalite Block Stair"),
	S("Sodalite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Sodalite Block Stair"),
	S("Outer Sodalite Block Stair")
)
-- Sugilite
stairs.register_stair_and_slab(
	"sugilite",
	"too_many_stones:sugilite",
	{cracky = 3},
	{"tms_sugilite.png"},
	S("Sugilite Stair"),
	S("Sugilite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Sugilite Stair"),
	S("Outer Sugilite Stair")
)

stairs.register_stair_and_slab(
	"sugilite_cobble",
	"too_many_stones:sugilite_cobble",
	{cracky = 3},
	{"tms_sugilite_cobble.png"},
	S("Cobbled Sugilite Stair"),
	S("Cobbled Sugilite Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Sugilite Stair"),
	S("Outer Cobbled Sugilite Stair")
)

stairs.register_stair_and_slab(
	"sugilite_brick",
	"too_many_stones:sugilite_brick",
	{cracky = 2},
	{"tms_sugilite_brick.png"},
	S("Sugilite Brick Stair"),
	S("Sugilite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Sugilite Brick Stair"),
	S("Outer Sugilite Brick Stair")
)

stairs.register_stair_and_slab(
	"sugilite_cracked_brick",
	"too_many_stones:sugilite_cracked_brick",
	{cracky = 2},
	{"tms_sugilite_cracked_brick.png"},
	S("Cracked Sugilite Brick Stair"),
	S("Cracked Sugilite Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Sugilite Brick Stair"),
	S("Outer Cracked Sugilite Brick Stair")
)

stairs.register_stair_and_slab(
	"sugilite_block",
	"too_many_stones:sugilite_block",
	{cracky = 2},
	{"tms_sugilite_block.png"},
	S("Sugilite Block Stair"),
	S("Sugilite Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Sugilite Block Stair"),
	S("Outer Sugilite Block Stair")
)
-- Green Tourmaline
stairs.register_stair_and_slab(
	"tourmaline_green",
	"too_many_stones:tourmaline_green",
	{cracky = 3},
	{"tms_tourmaline_green.png"},
	S("Green Tourmaline Stair"),
	S("Green Tourmaline Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Green Tourmaline Stair"),
	S("Outer Green Tourmaline Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_green_brick",
	"too_many_stones:tourmaline_green_brick",
	{cracky = 2},
	{"tms_tourmaline_green_brick.png"},
	S("Green Tourmaline Brick Stair"),
	S("Green Tourmaline Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Green Tourmaline Brick Stair"),
	S("Outer Green Tourmaline Brick Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_green_cracked_brick",
	"too_many_stones:tourmaline_green_cracked_brick",
	{cracky = 2},
	{"tms_tourmaline_green_cracked_brick.png"},
	S("Cracked Green Tourmaline Brick Stair"),
	S("Cracked Green Tourmaline Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Green Tourmaline Brick Stair"),
	S("Outer Cracked Green Tourmaline Brick Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_green_block",
	"too_many_stones:tourmaline_green_block",
	{cracky = 2},
	{"tms_tourmaline_green_block.png"},
	S("Green Tourmaline Block Stair"),
	S("Green Tourmaline Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Green Tourmaline Block Stair"),
	S("Outer Green Tourmaline Block Stair")
)
-- Paraiba Tourmaline
stairs.register_stair_and_slab(
	"tourmaline_paraiba",
	"too_many_stones:tourmaline_paraiba",
	{cracky = 3},
	{"tms_tourmaline_paraiba.png"},
	S("Paraiba Tourmaline Stair"),
	S("Paraiba Tourmaline Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Paraiba Tourmaline Stair"),
	S("Outer Paraiba Tourmaline Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_paraiba_brick",
	"too_many_stones:tourmaline_paraiba_brick",
	{cracky = 2},
	{"tms_tourmaline_paraiba_brick.png"},
	S("Paraiba Tourmaline Brick Stair"),
	S("Paraiba Tourmaline Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Paraiba Tourmaline Brick Stair"),
	S("Outer Paraiba Tourmaline Brick Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_paraiba_cracked_brick",
	"too_many_stones:tourmaline_paraiba_cracked_brick",
	{cracky = 2},
	{"tms_tourmaline_paraiba_cracked_brick.png"},
	S("Cracked Paraiba Tourmaline Brick Stair"),
	S("Cracked Paraiba Tourmaline Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Paraiba Tourmaline Brick Stair"),
	S("Outer Cracked Paraiba Tourmaline Brick Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_paraiba_block",
	"too_many_stones:tourmaline_paraiba_block",
	{cracky = 2},
	{"tms_tourmaline_paraiba_block.png"},
	S("Paraiba Tourmaline Block Stair"),
	S("Paraiba Tourmaline Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Paraiba Tourmaline Block Stair"),
	S("Outer Paraiba Tourmaline Block Stair")
)
-- Pink Tourmaline
stairs.register_stair_and_slab(
	"tourmaline_pink",
	"too_many_stones:tourmaline_pink",
	{cracky = 3},
	{"tms_tourmaline_pink.png"},
	S("Pink Tourmaline Stair"),
	S("Pink Tourmaline Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Pink Tourmaline Stair"),
	S("Outer Pink Tourmaline Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_pink_brick",
	"too_many_stones:tourmaline_pink_brick",
	{cracky = 2},
	{"tms_tourmaline_pink_brick.png"},
	S("Pink Tourmaline Brick Stair"),
	S("Pink Tourmaline Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Pink Tourmaline Brick Stair"),
	S("Outer Pink Tourmaline Brick Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_pink_cracked_brick",
	"too_many_stones:tourmaline_pink_cracked_brick",
	{cracky = 2},
	{"tms_tourmaline_pink_cracked_brick.png"},
	S("Cracked Pink Tourmaline Brick Stair"),
	S("Cracked Pink Tourmaline Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Pink Tourmaline Brick Stair"),
	S("Outer Cracked Pink Tourmaline Brick Stair")
)

stairs.register_stair_and_slab(
	"tourmaline_pink_block",
	"too_many_stones:tourmaline_pink_block",
	{cracky = 2},
	{"tms_tourmaline_pink_block.png"},
	S("Pink Tourmaline Block Stair"),
	S("Pink Tourmaline Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Pink Tourmaline Block Stair"),
	S("Outer Pink Tourmaline Block Stair")
)
-- Travertine
stairs.register_stair_and_slab(
	"travertine",
	"too_many_stones:travertine",
	{cracky = 3},
	{"tms_travertine.png"},
	S("Travertine Stair"),
	S("Travertine Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Tarvertine Stair"),
	S("Outer Tarvertine Stair")
)

stairs.register_stair_and_slab(
	"travertine_cobble",
	"too_many_stones:travertine_cobble",
	{cracky = 3},
	{"tms_travertine_cobble.png"},
	S("Cobbled Travertine Stair"),
	S("Cobbled Travertine Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Tarvertine Stair"),
	S("Outer Cobbled Tarvertine Stair")
)

stairs.register_stair_and_slab(
	"travertine_brick",
	"too_many_stones:travertine_brick",
	{cracky = 2},
	{"tms_travertine_brick.png"},
	S("Travertine Brick Stair"),
	S("Travertine Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Tarvertine Brick Stair"),
	S("Outer Tarvertine Brick Stair")
)

stairs.register_stair_and_slab(
	"travertine_cracked_brick",
	"too_many_stones:travertine_cracked_brick",
	{cracky = 2},
	{"tms_travertine_cracked_brick.png"},
	S("Cracked Travertine Brick Stair"),
	S("Cracked Travertine Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Tarvertine Brick Stair"),
	S("Outer Cracked Tarvertine Brick Stair")
)

stairs.register_stair_and_slab(
	"travertine_block",
	"too_many_stones:travertine_block",
	{cracky = 2},
	{"tms_travertine_block.png"},
	S("Travertine Block Stair"),
	S("Travertine Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Tarvertine Block Stair"),
	S("Outer Tarvertine Block Stair")
)
-- Yellow Travertine
stairs.register_stair_and_slab(
	"travertine_yellow",
	"too_many_stones:travertine_yellow",
	{cracky = 3},
	{"tms_travertine_yellow.png"},
	S("Yellow Travertine Stair"),
	S("Yellow Travertine Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Yellow Tarvertine Stair"),
	S("Outer Yellow Tarvertine Stair")
)

stairs.register_stair_and_slab(
	"travertine_yellow_cobble",
	"too_many_stones:travertine_yellow_cobble",
	{cracky = 3},
	{"tms_travertine_yellow_cobble.png"},
	S("Cobbled Yellow Travertine Stair"),
	S("Cobbled Yellow Travertine Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Yellow Tarvertine Stair"),
	S("Outer Cobbled Yellow Tarvertine Stair")
)

stairs.register_stair_and_slab(
	"travertine_yellow_brick",
	"too_many_stones:travertine_yellow_brick",
	{cracky = 2},
	{"tms_travertine_yellow_brick.png"},
	S("Yellow Travertine Brick Stair"),
	S("Yellow Travertine Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Yellow Tarvertine Brick Stair"),
	S("Outer Yellow Tarvertine Brick Stair")
)

stairs.register_stair_and_slab(
	"travertine_yellow_cracked_brick",
	"too_many_stones:travertine_yellow_cracked_brick",
	{cracky = 2},
	{"tms_travertine_yellow_cracked_brick.png"},
	S("Cracked Yellow Travertine Brick Stair"),
	S("Cracked Yellow Travertine Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Yellow Tarvertine Brick Stair"),
	S("Outer Cracked Yellow Tarvertine Brick Stair")
)

stairs.register_stair_and_slab(
	"travertine_yellow_block",
	"too_many_stones:travertine_yellow_block",
	{cracky = 2},
	{"tms_travertine_yellow_block.png"},
	S("Yellow Travertine Block Stair"),
	S("Yellow Travertine Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Yellow Tarvertine Block Stair"),
	S("Outer Yellow Tarvertine Block Stair")
)
-- Beige Tuff
stairs.register_stair_and_slab(
	"tuff_beige",
	"too_many_stones:tuff_beige",
	{cracky = 3},
	{"tms_tuff_beige.png"},
	S("Beige Tuff Stair"),
	S("Beige Tuff Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Beige Tuff Stair"),
	S("Outer Beige Tuff Stair")
)

stairs.register_stair_and_slab(
	"tuff_beige_brick",
	"too_many_stones:tuff_beige_brick",
	{cracky = 2},
	{"tms_tuff_beige_brick.png"},
	S("Beige Tuff Brick Stair"),
	S("Beige Tuff Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Beige Tuff Brick Stair"),
	S("Outer Beige Tuff Brick Stair")
)

stairs.register_stair_and_slab(
	"tuff_beige_cracked_brick",
	"too_many_stones:tuff_beige_cracked_brick",
	{cracky = 2},
	{"tms_tuff_beige_cracked_brick.png"},
	S("Cracked Beige Tuff Brick Stair"),
	S("Cracked Beige Tuff Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Beige Tuff Brick Stair"),
	S("Outer Cracked Beige Tuff Brick Stair")
)

stairs.register_stair_and_slab(
	"tuff_beige_block",
	"too_many_stones:tuff_beige_block",
	{cracky = 2},
	{"tms_tuff_beige_block.png"},
	S("Beige Tuff Block Stair"),
	S("Beige Tuff Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Beige Tuff Block Stair"),
	S("Outer Beige Tuff Block Stair")
)

stairs.register_stair_and_slab(
	"tuff_beige_cobble",
	"too_many_stones:tuff_beige_cobble",
	{cracky = 2},
	{"tms_tuff_beige_cobble.png"},
	S("Cobbled Beige Tuff Stair"),
	S("Cobbled Beige Tuff Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Beige Tuff Stair"),
	S("Outer Cobbled Beige Tuff Stair")
)
-- Grey Tuff
stairs.register_stair_and_slab(
	"tuff_grey",
	"too_many_stones:tuff_grey",
	{cracky = 3},
	{"tms_tuff_grey.png"},
	S("Grey Tuff Stair"),
	S("Grey Tuff Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Grey Tuff Stair"),
	S("Outer Grey Tuff Stair")
)

stairs.register_stair_and_slab(
	"tuff_grey_brick",
	"too_many_stones:tuff_grey_brick",
	{cracky = 2},
	{"tms_tuff_grey_brick.png"},
	S("Grey Tuff Brick Stair"),
	S("Grey Tuff Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Grey Tuff Brick Stair"),
	S("Outer Grey Tuff Brick Stair")
)

stairs.register_stair_and_slab(
	"tuff_grey_cracked_brick",
	"too_many_stones:tuff_grey_cracked_brick",
	{cracky = 2},
	{"tms_tuff_grey_cracked_brick.png"},
	S("Cracked Grey Tuff Brick Stair"),
	S("Cracked Grey Tuff Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Grey Tuff Brick Stair"),
	S("Outer Cracked Grey Tuff Brick Stair")
)

stairs.register_stair_and_slab(
	"tuff_grey_block",
	"too_many_stones:tuff_grey_block",
	{cracky = 2},
	{"tms_tuff_grey_block.png"},
	S("Grey Tuff Block Stair"),
	S("Grey Tuff Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Grey Tuff Block Stair"),
	S("Outer Grey Tuff Block Stair")
)

stairs.register_stair_and_slab(
	"tuff_grey_cobble",
	"too_many_stones:tuff_grey_cobble",
	{cracky = 2},
	{"tms_tuff_grey_cobble.png"},
	S("Cobbled Grey Tuff Stair"),
	S("Cobbled Grey Tuff Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Grey Tuff Stair"),
	S("Outer Cobbled Grey Tuff Stair")
)
-- Red Tuff
stairs.register_stair_and_slab(
	"tuff_red",
	"too_many_stones:tuff_red",
	{cracky = 3},
	{"tms_tuff_red.png"},
	S("Red Tuff Stair"),
	S("Red Tuff Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Red Tuff Stair"),
	S("Outer Red Tuff Stair")
)

stairs.register_stair_and_slab(
	"tuff_red_brick",
	"too_many_stones:tuff_red_brick",
	{cracky = 2},
	{"tms_tuff_red_brick.png"},
	S("Red Tuff Brick Stair"),
	S("Red Tuff Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Red Tuff Brick Stair"),
	S("Outer Red Tuff Brick Stair")
)

stairs.register_stair_and_slab(
	"tuff_red_cracked_brick",
	"too_many_stones:tuff_red_cracked_brick",
	{cracky = 2},
	{"tms_tuff_red_cracked_brick.png"},
	S("Cracked Red Tuff Brick Stair"),
	S("Cracked Red Tuff Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Red Tuff Brick Stair"),
	S("Outer Cracked Red Tuff Brick Stair")
)

stairs.register_stair_and_slab(
	"tuff_red_block",
	"too_many_stones:tuff_red_block",
	{cracky = 2},
	{"tms_tuff_red_block.png"},
	S("Red Tuff Block Stair"),
	S("Red Tuff Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Red Tuff Block Stair"),
	S("Outer Red Tuff Block Stair")
)

stairs.register_stair_and_slab(
	"tuff_red_cobble",
	"too_many_stones:tuff_red_cobble",
	{cracky = 2},
	{"tms_tuff_red_cobble.png"},
	S("Cobbled Red Tuff Stair"),
	S("Cobbled Red Tuff Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Red Tuff Stair"),
	S("Outer Cobbled Red Tuff Stair")
)
-- Turquoise
stairs.register_stair_and_slab(
	"turquoise",
	"too_many_stones:turquoise",
	{cracky = 3},
	{"tms_turquoise.png"},
	S("Turquoise Stair"),
	S("Turquoise Slab"),
	too_many_stones.node_sound_stone_defaults(),
	true,
	S("Inner Turquoise Stair"),
	S("Outer Turquoise Stair")
)

stairs.register_stair_and_slab(
	"turquoise_cobble",
	"too_many_stones:turquoise_cobble",
	{cracky = 3},
	{"tms_turquoise_cobble.png"},
	S("Cobbled Turquoise Stair"),
	S("Cobbled Turquoise Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cobbled Turquoise Stair"),
	S("Outer Cobbled Turquoise Stair")
)

stairs.register_stair_and_slab(
	"turquoise_brick",
	"too_many_stones:turquoise_brick",
	{cracky = 2},
	{"tms_turquoise_brick.png"},
	S("Turquoise Brick Stair"),
	S("Turquoise Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Turquoise Brick Stair"),
	S("Outer Turquoise Brick Stair")
)

stairs.register_stair_and_slab(
	"turquoise_cracked_brick",
	"too_many_stones:turquoise_cracked_brick",
	{cracky = 2},
	{"tms_turquoise_cracked_brick.png"},
	S("Cracked Turquoise Brick Stair"),
	S("Cracked Turquoise Brick Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Cracked Turquoise Brick Stair"),
	S("Outer Cracked Turquoise Brick Stair")
)

stairs.register_stair_and_slab(
	"turquoise_block",
	"too_many_stones:turquoise_block",
	{cracky = 2},
	{"tms_turquoise_block.png"},
	S("Turquoise Block Stair"),
	S("Turquoise Block Slab"),
	too_many_stones.node_sound_stone_defaults(),
	false,
	S("Inner Turquoise Block Stair"),
	S("Outer Turquoise Block Stair")
)
-- Vivianite
stairs.register_stair_and_slab(
	"vivianite",
	"too_many_stones:vivianite",
	{cracky = 3},
	{"tms_vivianite.png"},
	S("Vivianite Stair"),
	S("Vivianite Slab"),
	too_many_stones.node_sound_glass_defaults(),
	true,
	S("Inner Vivianite Stair"),
	S("Outer Vivianite Stair")
)

stairs.register_stair_and_slab(
	"vivianite_brick",
	"too_many_stones:vivianite_brick",
	{cracky = 2},
	{"tms_vivianite_brick.png"},
	S("Vivianite Brick Stair"),
	S("Vivianite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Vivianite Brick Stair"),
	S("Outer Vivianite Brick Stair")
)

stairs.register_stair_and_slab(
	"vivianite_cracked_brick",
	"too_many_stones:vivianite_cracked_brick",
	{cracky = 2},
	{"tms_vivianite_cracked_brick.png"},
	S("Cracked Vivianite Brick Stair"),
	S("Cracked Vivianite Brick Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Cracked Vivianite Brick Stair"),
	S("Outer Cracked Vivianite Brick Stair")
)

stairs.register_stair_and_slab(
	"vivianite_block",
	"too_many_stones:vivianite_block",
	{cracky = 2},
	{"tms_vivianite_block.png"},
	S("Vivianite Block Stair"),
	S("Vivianite Block Slab"),
	too_many_stones.node_sound_glass_defaults(),
	false,
	S("Inner Vivianite Block Stair"),
	S("Outer Vivianite Block Stair")
)
end
