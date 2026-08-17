
local S = chemistry.getter

local recipes = {}

local function plutonium_dust(p)
	return "chemistry:plutonium"..(p == 5 and "" or p).."_dust"
end
for p = 1, 23 do
	table.insert(recipes, { plutonium_dust(p).." 2", plutonium_dust(p-1), plutonium_dust(p+1) })
end

for _, data in pairs(recipes) do
	technic.register_separating_recipe({ input = { data[1] }, output = { data[2], data[3], data[4] } })
end

