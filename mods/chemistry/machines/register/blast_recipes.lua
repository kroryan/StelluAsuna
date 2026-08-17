
local S = chemistry.getter

technic.register_recipe_type("blasting", {
   description = S("Blasting"),
	input_size = 2,
   icon = "invisible.png^[combine:16x128:0,-48=blast_furnace_front_active.png"
})

function technic.register_blasting_recipe(data)
	data.time = data.time or 6
	technic.register_recipe("blasting", data)
end

local recipes = {
   {"bucket:bucket_empty", "chemistry:titanium 9", "chemistry:mtitanium_bucket", 15},
   {"bucket:bucket_empty", "chemistry:osmium 9", "chemistry:mosmium_bucket", 45},
   {"bucket:bucket_empty", "chemistry:tungsten 9", "chemistry:mtungsten_bucket", 50},
   {"bucket:bucket_empty", "chemistry:stone_cobble", "chemistry:st_lava_bucket", 45},
   {"bucket:bucket_empty", "default:cobble", "bucket:bucket_lava", 10},
   {"bucket:bucket_empty", "group:sand", "chemistry:mglass_bucket", 10},
   {"bucket:bucket_empty", "default:steel_ingot 9", "chemistry:msteel_bucket", 10},
   {"bucket:bucket_empty", "default:copper_ingot 9", "chemistry:mcopper_bucket", 8},
   {"bucket:bucket_empty", "default:tin_ingot 9", "chemistry:mtin_bucket", 7},
   {"bucket:bucket_empty", "chemistry:cinnabar_lump 90", "chemistry:mercury_bucket", 25},
}

for _, data in pairs(recipes) do
	technic.register_blasting_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
end

