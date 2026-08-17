
local S = chemistry.getter

technic.register_recipe_type("electrolysis", {
   description = S("Electrolysis"),
	input_size = 1,
   icon = "chemistry_mv_electrolyser_front.png"
})

function technic.register_electrolyser_recipe(data)
	data.time = 10
	technic.register_recipe("electrolysis", data)
end

local recipes = {
	{"bucket:bucket_water", "chemistry:oxygen 3", "chemistry:hydrogen 7", "bucket:bucket_empty"},
	{"bucket:bucket_river_water", "chemistry:oxygen 3", "chemistry:hydrogen 7", "bucket:bucket_empty"},
   {"chemistry:sodium_hydroxide", "chemistry:sodium 4", "chemistry:hydrogen 3", "chemistry:oxygen 3"},
   {"farming:salt", "chemistry:sodium 2", "chemistry:chlorine 2", ""},
   {"farming:salt_crystal", "chemistry:sodium 5", "chemistry:chlorine 5", ""},
   {"chemistry:h2o2_bottle", "chemistry:hydrogen 2", "chemistry:oxygen 2", "vessels:glass_bottle"},
   {"chemistry:hydrogen_peroxide_bucket", "chemistry:hydrogen 5", "chemistry:oxygen 5", "bucket:bucket_empty"}
}

for _, data in pairs(recipes) do
	technic.register_electrolyser_recipe({input = {data[1]}, output = {data[2], data[3], data[4]}})
end
