
local S = chemistry.getter

technic.register_recipe_type("gas_freeze", {
   description = S("Gas Freezing"),
	input_size = 2,
	icon = "chemistry_mv_gas_freezer_front.png"
})

function technic.register_gas_freeze_recipe(data)
	data.time = 5
	technic.register_recipe("gas_freeze", data)
end

local recipes = {
	{"bucket:bucket_empty", "chemistry:nitrogen 4", "chemistry:lnitrogen_bucket"},
	{"bucket:bucket_empty", "chemistry:butane 4", "chemistry:lbutane_bucket"},
	{"bucket:bucket_empty", "chemistry:oxygen 4", "chemistry:loxygen_bucket"},
	{"bucket:bucket_empty", "chemistry:methane 4", "chemistry:lmethane_bucket"},
	{"plastic_bucket:bucket_empty", "chemistry:nitrogen 4", "chemistry:lnitrogen_bucket_plastic"},
	{"plastic_bucket:bucket_empty", "chemistry:butane 4", "chemistry:lbutane_bucket_plastic"},
	{"plastic_bucket:bucket_empty", "chemistry:oxygen 4", "chemistry:loxygen_bucket_plastic"},
	{"plastic_bucket:bucket_empty", "chemistry:methane 4", "chemistry:lmethane_bucket_plastic"},
   {"bucket:bucket_empty", "chemistry:chlorine 4", "chemistry:lchlorine_bucket"},
   {"chemistry:carbon_dioxide", "chemistry:carbon_dioxide", "chemistry:dry_ice 2"},
   {"chemistry:carbon_dioxide", "", "chemistry:dry_ice"}
}

for _, data in pairs(recipes) do
	technic.register_gas_freeze_recipe({input = {data[1], data[2]}, output = data[3]})
end
