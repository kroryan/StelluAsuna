-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local S = core.get_translator("potions_brewing")

local brewing = s_brewing

function s_brewing.update_alchemy_formspec_for(pos, meta, hash, force_update)
	
	if not meta then meta = core.get_meta(pos) end
	if not hash then hash = core.hash_node_position(pos) end
	
	-- Update infotext
	local recipe_index = meta:get_int("recipe_index")
	local recipe = recipe_index ~= 0 and s_potions.recipes[recipe_index]
	local brew_time = (recipe and recipe.brew_time) or brewing.brew_time
	
	local brew_time_left = meta:get_int("brew_time_left")
	local brew_percentage = 100 * (1 - brew_time_left/brew_time)
	
	local infotext, brewing_line, potions_line
	local dst = meta:get_inventory():get_list("dst")[1]
	
	if brew_time_left ~= brew_time then brewing_line = S("Brewing in progress") .. string.format(" (%.0f", brew_percentage) .. "%)" end
	if dst:is_empty() == false then potions_line = S("Potions ready!") end
	
	if brewing_line and potions_line then brewing_line = brewing_line .. "\n" end
	
	infotext = (brewing_line or "") .. (potions_line or "")
	
	meta:set_string("infotext", infotext)
	
	-- Update formspec (only if it's being viewed)
	if brewing.formspec_viewers[hash] == nil and not force_update then return end
	
	local boost_count = math.min(meta:get_int("boost_count"), 4)
	local table_count = meta:get_int("table_count")
	
	local boost_efficiency = (100 * (1 + boost_count*brewing.boost_value))
	local other_stands_present = table_count > 1
	
	local boost_line = ""
	local efficiency_line = ""
	
	if other_stands_present then
		boost_line = S("Too close to other alchemy stands!")
		efficiency_line = "0% "..S("efficiency")
	elseif pos.y < brewing.boost_min_y then
		boost_line = S("Fresh surface air needed!")
		efficiency_line = "50% "..S("efficiency")
	else
		boost_line = ("%i/%i "):format(boost_count, brewing.boost_max_count)..S("alchemy supplies present")
		efficiency_line = boost_efficiency.."% "..S("efficiency")
	end
	
	local formspec = "size[8,8.25]"..
		"list[context;src;1,0.25;1,1;]"..
		"image[1,1.25;1,1;gui_furnace_arrow_bg.png^[lowpart:"..(brew_percentage)..":gui_furnace_arrow_fg.png^[transformR180]"..
		"list[context;vial;1,2.25;1,1;]"..
		"image[1,2.25;1,1;vessels_shelf_slot.png]"..
		"image[2,2.25;1,1;gui_furnace_arrow_bg.png^[lowpart:"..(brew_percentage)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"list[context;dst;3,2.25;1,1;]"..
		"image[3,2.25;1,1;vessels_shelf_slot.png]"..
		"button[4,0.25;3,1;recipe_button;"..S("Show Recipes").."]"..
		"label[4.25,2.25;"..boost_line.."\n"..efficiency_line.."]"..
		"list[current_player;main;0,4;8,1;]"..
		"list[current_player;main;0,5.25;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;vial]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4)
	
	meta:set_string("formspec", formspec)
	
end

function s_brewing.get_recipe_list_formspec()
	
	local recipe_list = {}
	local regular_potions = {}
	local enhanced_potions = {}
	
	local item_x_values = {0, 1, 3}
	
	local function get_potion_line(recipe, item_y)
		
		local line = {}
		
		for i, item in next, {recipe.ingredient, recipe.vial, recipe.result} do
			
			local button = ("item_image_button[%s,%s;1,1;%s;%s;%s]"):format(item_x_values[i]*1.25+0.125, item_y*1.25+0.125, item, item, "")
			
			table.insert(line, button)
		end
		
		table.insert(line, ("image[%s,%s;1,1;gui_furnace_arrow_bg.png^[transformR270]"):format(2*1.25+0.125, item_y*1.25+0.125))
		
		return table.concat(line)
	end
	
	for i, recipe in next, s_potions.recipes do
		
		local vial_item = core.registered_items[recipe.vial]
		
		if vial_item.groups.potion and recipe.vial ~= "s_potions_default:stock" then
			table.insert(enhanced_potions, recipe)
		else
			table.insert(regular_potions, recipe)
		end
	end
	
	table.insert(recipe_list, ("label[%s,%s;"..S("Basic potions").."]"):format(0.25+0.125, #recipe_list*1.25+0.5+0.125))
	for i, recipe in next, regular_potions do table.insert(recipe_list, get_potion_line(recipe, #recipe_list)) end
	
	table.insert(recipe_list, ("label[%s,%s;"..S("Enhanced potions").."]"):format(0.25+0.125, #recipe_list*1.25+0.5+0.125))
	for i, recipe in next, enhanced_potions do table.insert(recipe_list, get_potion_line(recipe, #recipe_list)) end
	
	local formspec = "formspec_version[3]size[7,5.5]"..
		"label[3,0.5;"..S("Recipe list").."]"..
		"box[0.75,1;5.5,3.75;#1f1f1f]"..
		"scroll_container[0.75,1;5.5,3.75;recipe_scrollbar;vertical;0.01]"..
		table.concat(recipe_list)..
		"scroll_container_end[]"..
		("scrollbaroptions[min=0;max=%s;smallstep=125;largestep=375]"):format(100*(#recipe_list*1.25-3.75))..
		"scrollbar[5.75,1;0.5,3.75;vertical;recipe_scrollbar;]"
	
	return formspec
end
