local S = minetest.get_translator("telemosaic")

local has_dye = minetest.get_modpath("dye")

local function pretty_str(s)
	s = string.upper(string.sub(s, 1, 1))..string.sub(s, 2)
	local i = string.find(s, "_")
	if i then
		local c = string.upper(string.sub(s, i + 1, i + 1))
		s = string.gsub(s, "_.", " "..c)
	end
	return s
end

local tiers = {"one", "two", "three"}

for i, range in pairs(telemosaic.extender_ranges) do
	local tier = tiers[i]

	local common_desc, basic_desc
	if has_dye then
		common_desc = "Telemosaic Extender, Tier @1 (@2)"
		basic_desc = S(common_desc, i, S("Grey"))
	else
		common_desc = "Telemosaic Extender, Tier @1"
		basic_desc = S(common_desc, i)
	end

	minetest.register_node("telemosaic:extender_"..tier, {
		description = basic_desc,
		tiles = {
			"telemosaic_extender_"..tier..".png"
		},
		paramtype = "light",
		groups = {cracky = 2, telemosaic_extender = range, ["telemosaic_extender_"..tier] = 1},
		is_ground_content = false,
		after_place_node = telemosaic.extender_place,
		after_dig_node = telemosaic.extender_dig,
		sounds = default.node_sound_metal_defaults(),
	})

	if has_dye then
		minetest.register_craft({
			type = "shapeless",
			output = "telemosaic:extender_"..tier,
			recipe = {"group:telemosaic_extender_"..tier, "dye:grey"},
		})

		for name, color in pairs(telemosaic.extender_colors) do
			minetest.register_node("telemosaic:extender_"..tier.."_"..name, {
				description = S(common_desc, i, S(pretty_str(name))),
				tiles = {
					"telemosaic_extender_"..tier..".png^[colorize:"..color
				},
				paramtype = "light",
				groups = {
					cracky = 2, not_in_creative_inventory = 1,
					telemosaic_extender = range, ["telemosaic_extender_"..tier] = 1
				},
				is_ground_content = false,
				after_place_node = telemosaic.extender_place,
				after_dig_node = telemosaic.extender_dig,
				sounds = default.node_sound_metal_defaults(),
			})

			minetest.register_craft({
				type = "shapeless",
				output = "telemosaic:extender_"..tier.."_"..name,
				recipe = {"group:telemosaic_extender_"..tier, "dye:"..name},
			})
		end
	end
end

minetest.register_craft({
	output = "telemosaic:extender_one",
	recipe = {
		{"default:obsidian", "doors:door_wood", "default:obsidian"}
	}
})

minetest.register_craft({
	output = "telemosaic:extender_two",
	recipe = {
		{"", "group:telemosaic_extender_one", ""},
		{"group:telemosaic_extender_one", "default:obsidian", "group:telemosaic_extender_one"},
		{"", "group:telemosaic_extender_one", ""}
	}
})

minetest.register_craft({
	output = "telemosaic:extender_three",
	recipe = {
		{"", "group:telemosaic_extender_two", ""},
		{"group:telemosaic_extender_two", "default:obsidian", "group:telemosaic_extender_two"},
		{"", "group:telemosaic_extender_two", ""}
	}
})
