
local S = chemistry.getter

--- Blowtorches (can put fire nodes on everything and melt metals)

minetest.register_tool("chemistry:blowtorch", {
	description = S("Blowtorch"),
	inventory_image = "blowtorch.png",
	liquids_pointable = true,

	on_place = function(itemstack, user, pointed_thing)
		local sound_pos = pointed_thing.above or user:get_pos()
		minetest.sound_play("blowtorch",
			{pos = sound_pos, gain = 0.2, max_hear_distance = 8}, true)
		local player_name = user:get_player_name()
		if pointed_thing.type == "node" then
			local node_under = minetest.get_node(pointed_thing.under).name
			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.record_protection_violation(pointed_thing.under, player_name)
				return
			end
         if minetest.get_item_group(node_under, "fire") >= 1 then
					return
			elseif nodedef.on_ignite then
				nodedef.on_ignite(pointed_thing.under, user)
			elseif nodedef.on_heat then
               nodedef.on_heat(pointed_thing.under, user)
			elseif minetest.get_item_group(node_under, "anthracite_material") >= 1
			    and minetest.get_node(pointed_thing.above).name == "air" then
					if minetest.is_protected(pointed_thing.above, player_name) then
						minetest.record_protection_violation(pointed_thing.above, player_name)
						return
					end
	
					minetest.set_node(pointed_thing.above, {name = "chemistry:anthracite_fire"})
			elseif minetest.get_node(node_under, pointed_thing.above)
					and minetest.get_node(pointed_thing.above).name == "air" then
				if minetest.is_protected(pointed_thing.above, player_name) then
					minetest.record_protection_violation(pointed_thing.above, player_name)
					return
				end

				minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
			end
		end
		if not minetest.is_creative_enabled(player_name) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear_by_uses(150)

			-- Tool Runs Out
			if itemstack:get_count() == 0 then
		        itemstack = "chemistry:blowtorch_empty"
			end
			return itemstack
		end
	end
})

minetest.register_tool("chemistry:blowtorch_empty", {
	description = S("Empty Blowtorch"),
	inventory_image = "blowtorch.png",

	on_place = function(itemstack, user, pointed_thing)
		local sound_pos = pointed_thing.above or user:get_pos()
		minetest.sound_play("empty_blowtorch",
			{pos = sound_pos, gain = 0.2, max_hear_distance = 8}, true)
	end,
	groups = {not_in_creative_inventory = 1}
})

minetest.register_craft({
	output = 'chemistry:blowtorch',
	recipe = {
		{'chemistry:tungsten', 'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet'},
		{'', 'chemistry:steel_ingot', 'chemistry:blowtorch_bottle'},
		{'', 'basic_materials:plastic_sheet', 'basic_materials:plastic_sheet'},
	}
})


minetest.register_craft({
	output = 'chemistry:blowtorch_bottle 4',
	recipe = {
		{'chemistry:aluminium', 'basic_materials:plastic_sheet', 'chemistry:aluminium'},
		{'chemistry:aluminium', 'chemistry:lbutane_bucket', 'chemistry:aluminium'},
		{'chemistry:aluminium', 'chemistry:aluminium', 'chemistry:aluminium'},
	},
	replacements = {{'chemistry:lbutane_bucket', 'bucket:bucket_empty'}}
})


minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:blowtorch',
	recipe = {
		'chemistry:blowtorch_empty', 'chemistry:blowtorch_bottle',
	},
	replacements = {{'chemistry:lbutane_bucket', 'bucket:bucket_empty'}}
})

minetest.register_craftitem("chemistry:blowtorch_bottle", {
	description = S("Blowtorch Gas Bottle"),
	inventory_image = "blowtorch_bottle.png",
})

--- Matches (don't spawn fire but activates on_ignite action)

minetest.register_craftitem("chemistry:match_dust_comp", {
	description = S("Match Dust"),
	inventory_image = "iron_iii_oxide.png^[colorize:black:150",
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:match_dust_comp 4',
	recipe = {
		'chemistry:antimony_trisulfide', 'chemistry:sulfur',
      'chemistry:powdered_glass', 'chemistry:potassium_chlorate',
	}
})


minetest.register_craft({
	output = 'chemistry:matchbox', --- Crafting recipe offers 60 Matches as 60 Uses
	recipe = {
		{'default:paper', 'chemistry:match_dust_comp', 'default:paper'},
      {'default:paper', 'group:stick', 'default:paper'},
      {'default:paper', 'chemistry:red_phosphorus', 'default:paper'},
	}
})


minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:matchbox', --Alternate Craft for saving resources
	recipe = {
		'chemistry:match_dust_comp', 'chemistry:matchbox_empty',
      'group:stick',
	}
})

minetest.register_tool("chemistry:matchbox", {
	description = S("Match Box"),
	inventory_image = "matchbox.png",

	on_use = function(itemstack, user, pointed_thing)
		local sound_pos = pointed_thing.above or user:get_pos()
		local player_name = user:get_player_name()
		if pointed_thing.type == "node" then
			local node_under = minetest.get_node(pointed_thing.under).name
			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.record_protection_violation(pointed_thing.under, player_name)
				return
			end
			if nodedef.on_ignite then -- Matches can only ignite blocks like tnt but not lit them on fire unless it is grass or hay bales
		   minetest.sound_play("fire_flint_and_steel",
	   		{pos = sound_pos, gain = 0.2, max_hear_distance = 4}, true) -- Matches don't produce much noise, that is an advantage against players
	   			nodedef.on_ignite(pointed_thing.under, user)
						minetest.record_protection_violation(pointed_thing.above, player_name)
						return
			elseif minetest.get_item_group(node_under, "snappy") >= 1 and minetest.get_item_group(node_under, "flammable") >= 1
			    and minetest.get_node(pointed_thing.above).name == "air" then
					if minetest.is_protected(pointed_thing.above, player_name) then
						minetest.record_protection_violation(pointed_thing.above, player_name)
						return
					end
		    minetest.sound_play("fire_flint_and_steel",
	   		{pos = sound_pos, gain = 0.2, max_hear_distance = 4}, true) -- Matches don't produce much noise, that is an advantage against players
					minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
				end
			end
		if not minetest.is_creative_enabled(player_name) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear_by_uses(60) -- The box only has 30 Matches before running out

			-- Matches Run Out
			if itemstack:get_count() == 0 then
		        itemstack = "chemistry:matchbox_empty"
			end
			return itemstack
		end
	end
})


minetest.register_tool("chemistry:matchbox_empty", {
	description = S("Empty Match Box"),
	inventory_image = "matchbox_empty.png",
	groups = {not_in_creative_inventory = 1}
})

