
local recipes = {
	{"chemistry:plutonium24_ingot 5",  "chemistry:plutonium_fuel"},
   {"chemistry:dry_ice 4", "chemistry:dry_ice_compact"},
   {"chemistry:alkaline_sand", "chemistry:alkaline_sandstone"},
   {"chemistry:alkaline_sandstone", "chemistry:alkaline_sandstone_block"},
   {"chemistry:stone", "chemistry:stone_block"}
}

for _, data in pairs(recipes) do
	technic.register_compressor_recipe({input = {data[1]}, output = data[2]})
end
