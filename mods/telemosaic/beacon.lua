local S = minetest.get_translator("telemosaic")

for _,protected in pairs({true, false}) do

	local node_name_suffix = protected and "_protected" or ""
	local texture_overlay = protected and "^telemosaic_beacon_protected_overlay.png" or ""
	local description = protected and "Protected Telemosaic Beacon"
		or "Telemosaic Beacon"
	local description_prefix = protected and "Protected " or ""

	minetest.register_node("telemosaic:beacon_off"..node_name_suffix, {
		description = S(description),
		tiles = {
			"telemosaic_beacon_off.png"..texture_overlay,
			"telemosaic_beacon_side.png",
		},
		paramtype = "light",
		groups = {cracky = 2, telemosaic = 1, telemosaic_off = 1},
		is_ground_content = false,
		on_rightclick = telemosaic.rightclick,
		digilines = telemosaic.digilines,
		sounds = default.node_sound_metal_defaults(),
	})

	minetest.register_node("telemosaic:beacon"..node_name_suffix, {
		description = S(description_prefix ..
			"Telemosaic Beacon Active (you hacker you!)"),
		tiles = {
			"telemosaic_beacon_top.png"..texture_overlay,
			"telemosaic_beacon_side.png",
		},
		paramtype = "light",
		groups = {cracky = 2, not_in_creative_inventory = 1, telemosaic = 1, telemosaic_active = 1},
		is_ground_content = false,
		drop = "telemosaic:beacon_off"..node_name_suffix,
		on_rightclick = telemosaic.rightclick,
		digilines = telemosaic.digilines,
		sounds = default.node_sound_metal_defaults(),
	})

	minetest.register_node("telemosaic:beacon_err"..node_name_suffix, {
		description = S(description_prefix ..
			"Telemosaic Beacon Error (you hacker you!)"),
		tiles = {
			"telemosaic_beacon_err.png"..texture_overlay,
			"telemosaic_beacon_side.png",
		},
		paramtype = "light",
		groups = {cracky = 2, not_in_creative_inventory = 1, telemosaic = 1, telemosaic_error = 1},
		is_ground_content = false,
		drop = "telemosaic:beacon_off"..node_name_suffix,
		on_rightclick = telemosaic.rightclick,
		digilines = telemosaic.digilines,
		sounds = default.node_sound_metal_defaults(),
	})

	minetest.register_node("telemosaic:beacon_disabled"..node_name_suffix, {
		description = S(description_prefix ..
			"Telemosaic Beacon Disabled (you hacker you!)"),
		tiles = {
			"telemosaic_beacon_disabled.png"..texture_overlay,
			"telemosaic_beacon_side.png",
		},
		paramtype = "light",
		groups = {cracky = 2, not_in_creative_inventory = 1, telemosaic = 1, telemosaic_disabled = 1},
		is_ground_content = false,
		drop = "telemosaic:beacon_off"..node_name_suffix,
		on_rightclick = telemosaic.rightclick,
		digilines = telemosaic.digilines,
		sounds = default.node_sound_metal_defaults(),
	})
end

minetest.register_craft({
	output = "telemosaic:beacon_off",
	recipe = {
		{"default:diamond", "doors:door_wood", "default:diamond"},
		{"default:obsidian","default:obsidian","default:obsidian"}
	}
})

minetest.register_craft({
	output = "telemosaic:beacon_off_protected",
	type = "shapeless",
	recipe = {"telemosaic:beacon_off", "default:steel_ingot"}
})

minetest.register_craft({
	output = "telemosaic:beacon_off",
	type = "shapeless",
	recipe = {"telemosaic:beacon_off_protected"}
})
