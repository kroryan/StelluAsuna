-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local S = core.get_translator("potions_brewing")

local api = s_potions
local brewing = s_brewing

local function apply_alchemy_furniture_node_template(def, image)
	
	def.groups = { cracky = 3, oddly_breakable_by_hand = 1, alchemy_furniture = 1 }
	def.drawtype = "plantlike"
	def.tiles = {image}
	def.inventory_image = image
	def.wield_image = image
	def.is_ground_content = false
	def.paramtype = "light"
	def.paramtype2 = "meshoptions"
	def.place_param2 = 1
	def.sounds = default.node_sound_metal_defaults()
	
	def.node_box = {type="fixed", fixed={ {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5} }}
	
end

local alchemy_stand_def = {
	
	description = S("Alchemy Stand"),
	
	on_timer = brewing.alchemy_node_timer,
	
	on_construct = function(pos)
		
		local meta = core.get_meta(pos)
		local inv = meta:get_inventory()
		
		inv:set_size('src', 1)
		inv:set_size('vial', 1)
		inv:set_size('dst', 1)
		
		local pos1 = vector.add(pos, brewing.boost_search_radius)
		local pos2 = vector.subtract(pos, brewing.boost_search_radius)
		
		local boost_count = #core.find_nodes_in_area(pos1, pos2, {"potions_brewing:boost"})
		local table_count = #core.find_nodes_in_area(pos1, pos2, {"potions_brewing:stand"})
		
		meta:set_int("brew_time_left", brewing.brew_time)
		meta:set_int("boost_count", boost_count)
		meta:set_int("table_count", table_count-1)
		
		brewing.add_to_value_in_nearby_stands(pos, "table_count", 1)
		
		brewing.update_alchemy_formspec_for(pos, meta, nil, true)
		brewing.alchemy_stand_update(pos)
		
	end,
	
	on_destruct = function(pos)
		
		brewing.add_to_value_in_nearby_stands(pos, "table_count", -1)
		
		local meta = core.get_meta(pos)
		
		-- Explode if currently brewing
		if tnt and core.get_node_timer(pos):is_started() and math.random() < brewing.explosion_chance then
			
			tnt.boom(pos, {
				radius = 3,
				damage_radius = 3,
				explode_center = true,
				tiles = "tnt_smoke.png"
			})
			
			core.item_drop(ItemStack(("default:gold_ingot %i"):format(12+math.random(0, 12))), nil, pos)
			core.item_drop(ItemStack(("vessels:glass_fragments %i"):format(8+math.random(0, 8))), nil, pos)
		else
			
			local player_name = meta:get_string("digger")
			
			if player_name then
				
				local player = core.get_player_by_name(player_name)
				
				player:get_inventory():add_item("main", "potions_brewing:stand")
			end
		end
		
		-- Remove sound and particles
		local hash = core.hash_node_position(pos)
		
		if (brewing.sound_handles[hash]) then core.sound_stop(brewing.sound_handles[hash]) end
		brewing.sound_handles[hash] = nil
		
		meta:set_int("recipe_index", 0)
		
		brewing.alchemy_stand_update_particles(pos, meta, hash, true)
		
		-- Drop items
		local inv = meta:get_inventory()
		
		for index, name in next, {"src", "vial", "dst"} do
			
			local stack = inv:get_list(name)[1]
			core.item_drop(stack, nil, pos)
		end
		
	end,
	
	drop = {},
	
	on_dig = function(pos, node, digger)
		
		local meta = core.get_meta(pos)
		
		meta:set_string("digger", digger:get_player_name())
		
		return core.node_dig(pos, node, digger)
	end,
	
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		
		if (listname == "vial" or listname == "dst") and core.get_item_group(stack:get_name(), "vessel") == 0 then return 0 end
		
		return stack:get_count()
		
	end,
	
	on_rightclick = function(pos, node, clicker)
		
		-- Register player as viewing the formspec (so it doesn't have to be updated otherwise)
		local player_name = clicker and clicker:get_player_name()
		
		if player_name then
			
			local hash = core.hash_node_position(pos)
			
			if not brewing.formspec_viewers[hash] then brewing.formspec_viewers[hash] = {} end
			
			table.insert(brewing.formspec_viewers[hash], player_name)
			
			brewing.update_alchemy_formspec_for(pos, nil, hash)
		end
	end,
	
	on_receive_fields = function(pos, formname, fields, sender)
		
		if fields.recipe_button then
			
			core.show_formspec(sender:get_player_name(), "", brewing.get_recipe_list_formspec())
		end
		
		if fields.recipe_button or fields.quit then
			
			-- Remove player from list of formspec viewers for the node
			local hash = core.hash_node_position(pos)
			
			local player_name = sender and sender:get_player_name()
			local formspec_viewers = brewing.formspec_viewers[hash]
			
			if player_name and formspec_viewers then
				
				for i, name in next, formspec_viewers do
					
					if formspec_viewers[i] == player_name then
						
						table.remove(formspec_viewers, i)
						
						break
					end
				end
				
				if #formspec_viewers == 0 then
					
					brewing.formspec_viewers[hash] = nil
				end
			end
		end
		
		return true
	end,
	
	on_metadata_inventory_move = brewing.alchemy_stand_update,
	on_metadata_inventory_put = brewing.alchemy_stand_update,
	on_metadata_inventory_take = brewing.alchemy_stand_update
	
}

local alchemy_boost_def = {
	
	description = S("Alchemy Supplies"),
	
	on_construct = function(pos)
		brewing.add_to_value_in_nearby_stands(pos, "boost_count", 1)
	end,
	
	on_destruct = function(pos)
		brewing.add_to_value_in_nearby_stands(pos, "boost_count", -1)
	end
	
}

apply_alchemy_furniture_node_template(alchemy_stand_def, "s_brewing_stand.png")
apply_alchemy_furniture_node_template(alchemy_boost_def, "s_brewing_boost.png")

core.register_node("potions_brewing:stand", alchemy_stand_def)
core.register_node("potions_brewing:boost", alchemy_boost_def)

if core.get_modpath("mobs_monster") then
	
	local oerkki_def = core.registered_entities["mobs_monster:oerkki"]
	
	table.insert(oerkki_def.replace_what, "potions_brewing:stand")
	
end

if core.get_modpath("s_mobs_default") then
	
	local oerkki_def = core.registered_entities["s_mobs_default:oerkki"]
	
	table.insert(oerkki_def.replace_what, "potions_brewing:stand")
	
end
