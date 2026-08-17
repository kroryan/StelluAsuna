
local S = chemistry.getter

local recipes = {
	{"chemistry:manganese", "default:steel_ingot 7", "chemistry:steel_ingot 8", 15},
	{"chemistry:calcium_oxide_lump 4", "chemistry:anthracite_dust 2", "chemistry:calcium_carbide", 15},
	{"chemistry:tungsten_dust",  "chemistry:anthracite_dust", "chemistry:tungsten_carbide", 25},
	{"chemistry:calcium_oxide_lump", "chemistry:aluminium_dust", "chemistry:calcium", 15},
   {"chemistry:limestone_lump 2", "chemistry:limestone_lump 2", "chemistry:limestone", 3},
   {"technic:zinc_dust", "chemistry:sulfur", "chemistry:zinc_sulfide", 10},
   {"bucket:bucket_empty", "chemistry:bismuth 9", "chemistry:lbismuth_bucket", 5},
   {"bucket:bucket_empty", "chemistry:cesium_shard 9", "chemistry:cesium_bucket", 1},
   {"bucket:bucket_empty", "chemistry:gallium 9", "chemistry:lgallium_bucket", 3},
   {"bucket:bucket_empty", "chemistry:sodium 9", "chemistry:msodium_bucket", 3},
   {"bucket:bucket_empty", "chemistry:potassium 9", "chemistry:mpotassium_bucket", 3},
   {"chemistry:ch3cooh_acid_bucket", "chemistry:baking_soda 8", "chemistry:sodium_acetate_bucket", 35},
   {"chemistry:molybdenum 2", "chemistry:aluminium 6", "chemistry:mol_alu_ingot 8", 10}
}

for _, data in pairs(recipes) do
	technic.register_alloy_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
end

