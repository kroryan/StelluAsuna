
local S = chemistry.getter

local recipes = {
	{"chemistry:carbon_dioxide", { "chemistry:dry_ice" } }
}

for _, data in pairs(recipes) do
	technic.register_freezer_recipe({input = {data[1]}, output = data[2]})
end

