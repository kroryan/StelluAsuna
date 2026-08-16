--[[
List of nodes that can be cut in the workbench.
In previous version, this used to be automatically
generated at runtime but it has been decided to turn
this to a hardcoded list for higher predictability
and to prevent future game/mod updates to accidentally
add more unintentional node cuts.

Many of the "weird" cuts in the list (like the barrel)
are needed for compatibility reasons with older versions.

This list was originally generated with this code:
```

-- Nodes allowed to be cut:
-- Only the regular, solid blocks without metas or explosivity
-- from the xdecor or default mods.

for nodename, def in pairs(minetest.registered_nodes) do
	local nodenamesplit = string.split(nodename, ":")
	local modname = nodenamesplit[1]
	if (modname == "xdecor" or modname == "default") and xdecor.stairs_valid_def(def) then
		cuttable_nodes[#cuttable_nodes + 1] = nodename
	end
end

table.sort(cuttable_nodes)
for i = 1, #cuttable_nodes do
	print("	\""..cuttable_nodes[i].."\",")
end
```
]]

local cuttable_nodes = {
-- xdecor
	"xdecor:barrel",
	"xdecor:cactusbrick",
	"xdecor:coalstone_tile",
	"xdecor:desertstone_tile",
	"xdecor:hard_clay",
	"xdecor:moonbrick",
	"xdecor:packed_ice",
	"xdecor:stone_rune",
	"xdecor:stone_tile_x",
	"xdecor:wood_tile_x",
	"xdecor:woodframed_glass",

-- 'default' from Minetest Game (as of Minetest Game commit ac2bc0f52118230eb4dd50567c30a47e9bd3a31e)
	"default:acacia_tree",
	"default:acacia_wood",
	"default:aspen_tree",
	"default:aspen_wood",
	"default:brick",
	"default:bronzeblock",
	"default:cactus",
	"default:coalblock",
	"default:cobble",
	"default:copperblock",
	"default:coral_brown",
	"default:coral_orange",
	"default:coral_skeleton",
	"default:desert_cobble",
	"default:desert_sandstone",
	"default:desert_sandstone_block",
	"default:desert_sandstone_brick",
	"default:desert_stone",
	"default:desert_stone_block",
	"default:desert_stonebrick",
	"default:diamondblock",
	"default:glass",
	"default:goldblock",
	"default:ice",
	"default:jungletree",
	"default:junglewood",
	"default:mossycobble",
	"default:obsidian",
	"default:obsidian_block",
	"default:obsidian_glass",
	"default:obsidianbrick",
	"default:permafrost",
	"default:permafrost_with_moss",
	"default:permafrost_with_stones",
	"default:pine_tree",
	"default:pine_wood",
	"default:sandstone",
	"default:sandstone_block",
	"default:sandstonebrick",
	"default:silver_sandstone",
	"default:silver_sandstone_block",
	"default:silver_sandstone_brick",
	"default:steelblock",
	"default:stone",
	"default:stone_block",
	"default:stonebrick",
	"default:tinblock",
	"default:tree",
	"default:wood",
}

-- 'farming' from Minetest Game (as of Minetest Game commit ac2bc0f52118230eb4dd50567c30a47e9bd3a31e)
if minetest.get_modpath("farming") ~= nil then
	table.insert(cuttable_nodes, "farming:straw")
end

if minetest.get_modpath("wool") ~= nil then
-- 'wool' from Minetest Game (as of Minetest Game commit ac2bc0f52118230eb4dd50567c30a47e9bd3a31e)
	table.insert(cuttable_nodes, "wool:black")
	table.insert(cuttable_nodes, "wool:blue")
	table.insert(cuttable_nodes, "wool:brown")
	table.insert(cuttable_nodes, "wool:cyan")
	table.insert(cuttable_nodes, "wool:dark_green")
	table.insert(cuttable_nodes, "wool:dark_grey")
	table.insert(cuttable_nodes, "wool:green")
	table.insert(cuttable_nodes, "wool:grey")
	table.insert(cuttable_nodes, "wool:magenta")
	table.insert(cuttable_nodes, "wool:orange")
	table.insert(cuttable_nodes, "wool:pink")
	table.insert(cuttable_nodes, "wool:red")
	table.insert(cuttable_nodes, "wool:violet")
	table.insert(cuttable_nodes, "wool:white")
	table.insert(cuttable_nodes, "wool:yellow")
end

return cuttable_nodes
