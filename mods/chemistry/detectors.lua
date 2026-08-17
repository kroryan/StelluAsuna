
local S = chemistry.getter

minetest.register_abm({
	nodenames = {"chemistry:detector_smoke"},
	interval = 2,
	chance = 1,
	catch_up = true,

	action = function(pos, node)

		if #minetest.find_nodes_in_area_under_air(
				{x = pos.x - 10, y = pos.y - 10, z = pos.z - 10},
				{x = pos.x + 10, y = pos.y + 10, z = pos.z + 10}, "group:fire", "chemistry:carbon_dioxide") > 0 then

				minetest.sound_play(
					"alarm",
					{pos = pos, max_hear_distance = 10, gain = 0.05}
             )
		end
	end
})

minetest.register_tool("chemistry:detector_rad", {
description = S("Radiation Detector"),
inventory_image = "detector_item.png",
range = 0,
groups = {not_in_creative_inventory = 1},
on_secondary_use = function(itemstack, user)
	local radius = 5
	local pos1 = vector.subtract(user:get_pos(), radius)
	local pos2 = vector.add(user:get_pos(), radius)

	if minetest.find_node_near(user:get_pos(), radius, "group:radioactive") then
		for _, p in ipairs(minetest.find_nodes_in_area(pos1, pos2, {
			"group:radioactive"
		})) do

		   	local nodedef = minetest.get_node(p).name
		    local node_desc = ItemStack(nodedef):get_short_description()
	
		    if minetest.get_item_group(nodedef, "gaseous") > 0 then
		    	minetest.chat_send_player(user:get_player_name(), S("Found radioactive @1 at @2", node_desc, core.pos_to_string(p)))
			end
		    if minetest.get_item_group(nodedef, "liquid") > 0 then
	 		   	minetest.chat_send_player(user:get_player_name(), S("Found radioactive Liquid @1 at @2", node_desc, core.pos_to_string(p)))
			end
			if minetest.get_item_group(nodedef, "liquid") == 0 and minetest.get_item_group(nodedef, "gaseous") == 0 then
		        minetest.chat_send_player(user:get_player_name(), S("Found radioactive node @1 at @2", node_desc, core.pos_to_string(p)))
			end
		end
	else
		minetest.chat_send_player(user:get_player_name(), S("No Radiactive Node has been found"))
		return
	end

		if not minetest.is_creative_enabled(user:get_player_name()) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear_by_uses(100)
	    if itemstack:get_count() == 0 then
	        minetest.chat_send_player(user:get_player_name(), S("Warning! Energy ran out, replace batteries now!"))
	        itemstack = "chemistry:detector_gas_off"
	    end
	    return itemstack
    end
end,
})


minetest.register_tool("chemistry:detector_gas", {
description = S("Gas Detector"),
inventory_image = "detector_item.png",
range = 0,
groups = {not_in_creative_inventory = 1},
on_secondary_use = function(itemstack, user)
	local radius = 5
	local pos1 = vector.subtract(user:get_pos(), radius)
	local pos2 = vector.add(user:get_pos(), radius)

	if minetest.find_node_near(user:get_pos(), radius, {"group:gaseous", "group:conc_gas"}) then
		for _, p in ipairs(minetest.find_nodes_in_area(pos1, pos2, {
			"group:gaseous", "group:conc_gas"
		})) do

		   	local nodedef = minetest.get_node(p).name
		    local node_desc = ItemStack(nodedef):get_short_description()

	    	if minetest.get_item_group(nodedef, "flammable_gas") > 0 then
	    	    minetest.chat_send_player(user:get_player_name(), S("Found flammable @1 at @2", node_desc, core.pos_to_string(p)))
			end
			if minetest.get_item_group(nodedef, "conc_gas") > 0 then
				minetest.chat_send_player(user:get_player_name(), S("Found high concentrations of gas at @1", core.pos_to_string(p)))
			end
			if minetest.get_item_group(nodedef, "flammable_gas") == 0 and minetest.get_item_group(nodedef, "gaseous") > 0 then
	    	    minetest.chat_send_player(user:get_player_name(), S("Found @1 at @2", node_desc, core.pos_to_string(p)))
			end
		end
	else
		minetest.chat_send_player(user:get_player_name(), S("No Gas has been found"))
		return
	end
	if not minetest.is_creative_enabled(user:get_player_name()) then
			-- Wear tool
		local wdef = itemstack:get_definition()
		itemstack:add_wear_by_uses(100)
	    if itemstack:get_count() == 0 then
	        minetest.chat_send_player(user:get_player_name(), S("Warning! Energy ran out, replace batteries now!"))
	        itemstack = "chemistry:detector_gas_off"
	    end
	    return itemstack
    end
end,
})

minetest.register_tool("chemistry:detector_rad_unpowered", {
description = S("Unpowered Radiation detector\nCraft using 2 batteries and this item to power it"),
inventory_image = "detector_item_off.png",

on_secondary_use = function(itemstack, user, pointed_thing)
	minetest.chat_send_player(user:get_player_name(), S("No Energy"))
end,
})

minetest.register_tool("chemistry:detector_gas_unpowered", {
description = S("Unpowered Gas detector\nCraft using 2 batteries and this item to power it"),
inventory_image = "detector_item_off.png",

on_secondary_use = function(itemstack, user, pointed_thing)
	minetest.chat_send_player(user:get_player_name(), S("No Energy"))
end,
})

minetest.register_craftitem("chemistry:lithium_battery", {
	description = S("Lithium Ion Battery"),
	inventory_image = "lithium_battery.png",
})

minetest.register_tool("chemistry:detector_module", {
	description = S("Node Detection Module"),
	inventory_image = "detector_module.png",
})

minetest.register_craft({
	output = 'chemistry:lithium_battery 4',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'chemistry:aluminium', 'chemistry:iodine', 'chemistry:aluminium'},
		{'chemistry:aluminium', 'chemistry:lithium', 'chemistry:aluminium'},
	}
})

minetest.register_craft({
	output = 'chemistry:detector_module',
	recipe = {
		{'', '', ''},
		{'chemistry:lithium', 'basic_materials:copper_wire', 'basic_materials:ic'},
		{'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet'},
	},
	replacements = {{'basic_materials:copper_wire','basic_materials:copper_wire'}}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:detector_gas',
	recipe = {
		'chemistry:detector_gas_unpowered',
      'chemistry:lithium_battery',
		'chemistry:lithium_battery'
	}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:detector_rad',
	recipe = {
		'chemistry:detector_rad_unpowered',
      'chemistry:lithium_battery',
		'chemistry:lithium_battery'
	}
})

minetest.register_craft({
	output = 'chemistry:detector_rad_unpowered',
	recipe = {
		{'basic_materials:plastic_sheet', 'basic_materials:ic', 'basic_materials:plastic_sheet'},
		{'basic_materials:plastic_sheet', 'chemistry:detector_module', 'basic_materials:plastic_sheet'},
		{'basic_materials:plastic_sheet', 'chemistry:americium', 'basic_materials:plastic_sheet'},
	}
})

minetest.register_craft({
	output = 'chemistry:detector_gas_unpowered',
	recipe = {
		{'basic_materials:plastic_sheet', 'basic_materials:ic', 'basic_materials:plastic_sheet'},
		{'basic_materials:plastic_sheet', 'chemistry:detector_module', 'basic_materials:plastic_sheet'},
		{'basic_materials:plastic_sheet', 'chemistry:technetium', 'basic_materials:plastic_sheet'},
	}
})
