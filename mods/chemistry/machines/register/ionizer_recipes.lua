
local S = chemistry.getter

technic.register_recipe_type("ionizing", {
   description = S("Ionizing"),
	input_size = 1,
	icon = "chemistry_mv_ionizer_front.png"
})

function technic.register_ionizer_recipe(data)
	data.time = 20
	technic.register_recipe("ionizing", data)
end

local recipes = {
	{"technic:uranium_dust", "chemistry:plutonium15_dust"},
	{"technic:uranium_ingot", "chemistry:plutonium15_ingot"},
	{"chemistry:plutonium15_dust", "chemistry:plutonium19_dust"},
	{"chemistry:plutonium15_ingot", "chemistry:plutonium19_ingot"},
	{"chemistry:plutonium19_dust", "chemistry:plutonium22_dust"},
	{"chemistry:plutonium19_ingot", "chemistry:plutonium22_ingot"},
    {"chemistry:radium", "chemistry:francium"},
    {"chemistry:polonium", "chemistry:radon"},
    {"technic:uranium10_dust", "technic:uranium20_dust"},
    {"technic:uranium10_ingot", "technic:uranium20_ingot"},
    {"chemistry:plutonium22_ingot", "chemistry:americium"},
    {"chemistry:thorium", "technic:uranium_ingot"},
    {"chemistry:molybdenum", "chemistry:technetium"}
}

for _, data in pairs(recipes) do
	technic.register_ionizer_recipe({input = {data[1]}, output = data[2]})
end
