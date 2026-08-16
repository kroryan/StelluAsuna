-- Copyright (C) 2024 Stakbox
-- Copyright (C) 2025 X-DE
-- This file is licensed under the GNU General Public License, version 3.0 or later
-- It is distributed WITHOUT ANY WARRANTY
-- See LICENSE.md for more details

local S = core.get_translator("potions_brewing")

local S_vessels = core.get_translator("vessels")

-- Update nearby alchemy tables
local function vessels_shelf_update_alchemy_stands(pos)
	
	local above = vector.new(pos.x, pos.y+1, pos.z)
	local node = core.get_node(above)
	
	if node.name == "potions_brewing:stand" then
		s_brewing.alchemy_stand_update(above)
	end
end

local vessels_shelf_def = core.registered_nodes["vessels:shelf"]

local vessels_shelf_on_construct = vessels_shelf_def.on_construct
local vessels_shelf_after_destruct = vessels_shelf_def.after_destruct
local vessels_shelf_on_metadata_inventory_move = vessels_shelf_def.on_metadata_inventory_move
local vessels_shelf_on_metadata_inventory_put = vessels_shelf_def.on_metadata_inventory_put
local vessels_shelf_on_metadata_inventory_take = vessels_shelf_def.on_metadata_inventory_take

core.override_item("vessels:shelf", {
	description = S_vessels("Vessels Shelf") .. "\n" .. S("Place below alchemy stand for extra storage"),
	short_description = S_vessels("Vessels Shelf"),
	on_construct = function(pos)
		vessels_shelf_on_construct(pos)
		vessels_shelf_update_alchemy_stands(pos)
	end,
	after_destruct = function(pos, oldnode)
		if vessels_shelf_after_destruct then vessels_shelf_after_destruct(pos, oldnode) end
		vessels_shelf_update_alchemy_stands(pos)
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		vessels_shelf_on_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
		vessels_shelf_update_alchemy_stands(pos)
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		vessels_shelf_on_metadata_inventory_put(pos, listname, index, stack, player)
		vessels_shelf_update_alchemy_stands(pos)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		vessels_shelf_on_metadata_inventory_take(pos, listname, index, stack, player)
		vessels_shelf_update_alchemy_stands(pos)
	end
})

-- Update infotext when potion is stored
local function update_vessels_shelf_infotext(pos)
	
	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()
	local list = inv:get_list("vessels")
	
	local item_count = 0
	
	for i, stack in next, list do
		item_count = item_count + stack:get_count()
	end
	
	if item_count == 0 then
		meta:set_string("infotext", S_vessels("Empty Vessels Shelf"))
	else
		meta:set_string("infotext", S_vessels("Vessels Shelf (@1 items)", item_count))
	end
end

-- Register vessels shelf as a storage node
s_brewing.storage_nodes["vessels:shelf"] = {
	
	inventory_list = "vessels",
	update = update_vessels_shelf_infotext
}
