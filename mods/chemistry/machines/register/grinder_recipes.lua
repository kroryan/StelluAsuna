
local S = chemistry.getter

local recipes = {
	-- Dusts
	{"chemistry:anthracite", "chemistry:anthracite_dust 2"},
}

for _, data in ipairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end

local function register_dust(name, ingot)
	local lname = string.lower(name)
	lname = string.gsub(lname, ' ', '_')
	minetest.register_craftitem("chemistry:"..lname.."_dust", {
		description = S("@1 Dust", S(name)),
		inventory_image = lname.."_dust.png",
	})
	technic.register_grinder_recipe({ input = {"chemistry:"..lname}, output = "chemistry:"..lname.."_dust 1" })
end
-- Sorted alphabetically
local dusts = {
	{"Aluminium", "chemistry:aluminium"},
	{"Osmium", "chemistry:osmium"},
   	{"Radium", "chemistry:radium"},
	{"Titanium", "chemistry:titanium"},
	{"Tungsten", "chemistry:tungsten"},
}

for _, data in ipairs(dusts) do
	register_dust(data[1], data[2])
end

minetest.register_craft({
	type = "cooking",
	recipe = "chemistry:aluminium_dust",
	output = "chemistry:aluminium",
   burntime = 3,
})

minetest.register_craft({
	type = "cooking",
	recipe = "chemistry:radium_dust",
	output = "chemistry:radium",
   burntime = 3,
})

minetest.register_craft({
	type = "cooking",
	recipe = "chemistry:titanium_dust",
	output = "chemistry:titanium",
   burntime = 5,
})

minetest.register_craft({
	type = "cooking",
	recipe = "chemistry:osmium_dust",
	output = "chemistry:osmium",
   burntime = 12,
})

minetest.register_craft({
	type = "cooking",
	recipe = "chemistry:tungsten_dust",
	output = "chemistry:tungsten",
   burntime = 17,
})

minetest.register_craftitem("chemistry:anthracite_dust", {
	description = S("Anthracite Coal Dust"),
	inventory_image = "anthracite_dust.png",
})

minetest.register_craft({
	type = "fuel",
	recipe = "chemistry:anthracite_dust",
	burntime = 100,
})

