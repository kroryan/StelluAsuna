local cauldron, sounds = {}, {}
local S = minetest.get_translator("xdecor")

-- Set to true to print soup ingredients, heater nodes and bowls to console
local DEBUG_RECOGNIZED_ITEMS = false

--~ cauldron hint
local hint_fire = S("Light a fire below to heat it up")
--~ cauldron hint
local hint_eat = S("Use a bowl to eat the soup")
--~ cauldron hint
local hint_recipe = S("Drop foods inside to make a soup")

local infotexts = {
	["xdecor:cauldron_empty"] = S("Cauldron (empty)"),
	["xdecor:cauldron_idle"] = S("Cauldron (cold water)").."\n"..hint_fire,
	["xdecor:cauldron_idle_river_water"] = S("Cauldron (cold river water)").."\n"..hint_fire,
	["xdecor:cauldron_idle_soup"] = S("Cauldron (cold soup)").."\n"..hint_eat,
	["xdecor:cauldron_boiling"] = S("Cauldron (boiling water)").."\n"..hint_recipe,
	["xdecor:cauldron_boiling_river_water"] = S("Cauldron (boiling river water)").."\n"..hint_recipe,
	["xdecor:cauldron_soup"] = S("Cauldron (boiling soup)").."\n"..hint_eat,
}

local function set_infotext(meta, node)
	if infotexts[node.name] then
		meta:set_string("infotext", infotexts[node.name])
	end
end

-- HACKY list of soup ingredients.
-- For items without a valid 'xdecor_soup_ingredient' group present, the cauldron
-- will check part of the itemname after the ':' contains any of those words.
-- If it does, the item counts as an ingredient, UNLESS the item is in the
-- non_ingredients blacklist below.
local ingredients_list = {
	"apple", "mushroom", "honey", "pumpkin", "egg", "bread", "meat",
	"chicken", "carrot", "potato", "melon", "rhubarb", "cucumber",
	"corn", "beans", "berries", "grapes", "tomato", "wheat"
}

-- Blacklist of items that cannot be soup ingredients, in case they
-- would otherwise match the ingredients_list above.
-- Note the group 'xdecor_soup_ingredient' still takes precedence.
local non_ingredients = {
	-- Minetest Game: default
	"default:apple_mark", "default:blueberry_bush_leaves_with_berries",
	-- Minetest Game: farming
	"farming:seed_wheat",
	"farming:wheat_1", "farming:wheat_2", "farming:wheat_3", "farming:wheat_4",
	"farming:wheat_5", "farming:wheat_6", "farming:wheat_7", "farming:wheat_8",
}
local non_ingredients_keyed = table.key_value_swap(non_ingredients)

cauldron.cbox = {
	{0,  0, 0,  16, 16, 0},
	{0,  0, 16, 16, 16, 0},
	{0,  0, 0,  0,  16, 16},
	{16, 0, 0,  0,  16, 16},
	{0,  0, 0,  16, 8,  16}
}

-- Returns true is given item is a node that can heat fire and can heat up the cauldron
local function is_heater(itemstring)
	-- Dedicated group to add custom cauldron-heating nodes
	return minetest.get_item_group(itemstring, "xdecor_cauldron_heater") == 1 or
		-- Also, all fire nodes count as heaters
		minetest.get_item_group(itemstring, "fire") ~= 0
end

-- Returns true if given item is a bowl that is compatible with taking soup from
-- the cauldron
local function is_bowl(itemstring)
	-- Recommended: The item has this group
	return minetest.get_item_group(itemstring, "xdecor_soup_bowl") == 1
		-- Two items are hardcoded
		or itemstring == "farming:bowl" or itemstring == "x_farming:bowl"
end

-- Returns true if the node at pos is above heater
local function is_heated(pos)
	local below_node = {x = pos.x, y = pos.y - 1, z = pos.z}
	local nn = minetest.get_node(below_node).name
	-- Check heater status
	if is_heater(nn) then
		return true
	else
		return false
	end
end

function cauldron.stop_sound(pos)
	local spos = minetest.hash_node_position(pos)
	if sounds[spos] then
		minetest.sound_stop(sounds[spos])
		sounds[spos] = nil
	end
end

function cauldron.start_sound(pos)
	local spos = minetest.hash_node_position(pos)
	-- Stop sound if one already exists.
	-- Only 1 sound per position at maximum allowed.
	if sounds[spos] then
		cauldron.stop_sound(pos)
	end
	sounds[spos] = minetest.sound_play("xdecor_boiling_water", {
		pos = pos,
		max_hear_distance = 5,
		gain = 0.8,
		loop = true
	})
end

function cauldron.idle_construct(pos)
	local timer = minetest.get_node_timer(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	set_infotext(meta, node)
	timer:start(10.0)
	cauldron.stop_sound(pos)
end

function cauldron.boiling_construct(pos)
	cauldron.start_sound(pos)

	local meta = minetest.get_meta(pos)
	local node = minetest.get_node(pos)
	set_infotext(meta, node)

	local timer = minetest.get_node_timer(pos)
	timer:start(5.0)
end


function cauldron.filling(pos, node, clicker, itemstack)
	local inv = clicker:get_inventory()
	local wield_item = clicker:get_wielded_item():get_name()

	do
		if wield_item == "bucket:bucket_empty" and node.name:sub(-6) ~= "_empty" then
			local bucket_item
			if node.name:sub(-11) == "river_water" then
				bucket_item = "bucket:bucket_river_water 1"
			else
				bucket_item = "bucket:bucket_water 1"
			end
			if itemstack:get_count() > 1 then
				if inv:room_for_item("main", bucket_item) then
					itemstack:take_item()
					inv:add_item("main", bucket_item)
				else
					-- No space: Drop bucket on ground
					itemstack:take_item()
					minetest.add_item(clicker:get_pos(), bucket_item)
				end
			else
				itemstack:replace(bucket_item)
			end
			minetest.set_node(pos, {name = "xdecor:cauldron_empty", param2 = node.param2})

		elseif minetest.get_item_group(wield_item, "water_bucket") == 1 and node.name:sub(-6) == "_empty" then
			local newnode
			if wield_item == "bucket:bucket_river_water" then
				newnode = "xdecor:cauldron_idle_river_water"
			else
				newnode = "xdecor:cauldron_idle"
			end
			minetest.set_node(pos, {name = newnode, param2 = node.param2})
			itemstack:replace("bucket:bucket_empty")
		end

		return itemstack
	end
end

function cauldron.idle_timer(pos)
	if not is_heated(pos) then
		return true
	end

	local node = minetest.get_node(pos)
	if node.name:sub(-4) == "soup" then
		node.name = "xdecor:cauldron_soup"
	elseif node.name:sub(-11) == "river_water" then
		node.name = "xdecor:cauldron_boiling_river_water"
	else
		node.name = "xdecor:cauldron_boiling"
	end
	minetest.set_node(pos, node)
	return true
end

-- Ugly hack to determine if an item has the function `minetest.item_eat` in its definition.
local function eatable(itemstring)
	local item = itemstring:match("[%w_:]+")
	local on_use_def = minetest.registered_items[item].on_use
	if not on_use_def then return end

	return string.format("%q", string.dump(on_use_def)):find("item_eat")
end

-- Checks if the given item can be used as ingredient for the soup
local function is_ingredient(itemstring)
	-- This group takes precedence over everything else, allowing
	-- mods to explicitly mark items as soup ingredient or not.
	local gval = minetest.get_item_group(itemstring, "xdecor_soup_ingredient")
	-- 1: This item is a soup ingredient
	if gval == 1 then
		return true
	-- -1: This item is NOT a soup ingredient
	-- This should be used in case the heuristic below fails.
	elseif gval == -1 then
		return false
	end

	-- Otherwise, we determine on whether this item is a soup ingredient
	-- based on its itemstring (admittedly kinda hacky ...)

	-- But first check if our item is in the blacklist
	if non_ingredients_keyed[itemstring] then
		return false
	end

	-- Eatable items count as ingredient by default
	if eatable(itemstring) then
		return true
	end
	-- We check if the part of the itemstring after the colon
	-- contains one of the words in ingredients_list.
	-- If yes, this is an ingredient. Otherwise it isn't.
	local basename = itemstring:match(":([%w_]+)")
	if not basename then
		return false
	end
	for _, ingredient in ipairs(ingredients_list) do
		if basename:find(ingredient) then
			return true
		end
	end
	return false
end

function cauldron.boiling_timer(pos)
	-- Cool down cauldron if there is no fire
	local node = minetest.get_node(pos)
	if not is_heated(pos) then
		local newnode
		if node.name:sub(-4) == "soup" then
			newnode = "xdecor:cauldron_idle_soup"
		elseif node.name:sub(-11) == "river_water" then
			newnode = "xdecor:cauldron_idle_river_water"
		else
			newnode = "xdecor:cauldron_idle"
		end
		minetest.set_node(pos, {name = newnode, param2 = node.param2})
		return true
	end

	if node.name:sub(-4) == "soup" then
		return true
	end

	-- Cooking:

	-- Count the ingredients in the cauldron
	local objs = minetest.get_objects_inside_radius(pos, 0.5)

	if not next(objs) then
		return true
	end

	local ingredients = {}
	for _, obj in pairs(objs) do
		if obj and not obj:is_player() and obj:get_luaentity().itemstring then
			local itemstring = obj:get_luaentity().itemstring
			local item = ItemStack(itemstring)
			local itemname = item:get_name()

			if is_ingredient(itemname) then
				local basename = itemstring:match(":([%w_]+)")
				table.insert(ingredients, basename)
			end
		end
	end

	-- Remove ingredients and turn liquid into soup
	if #ingredients >= 2 then
		for _, obj in pairs(objs) do
			obj:remove()
		end

		minetest.set_node(pos, {name = "xdecor:cauldron_soup", param2 = node.param2})
	end


	return true
end

function cauldron.take_soup(pos, node, clicker, itemstack)
	local inv = clicker:get_inventory()
	local wield_item = clicker:get_wielded_item()
	local item_name = wield_item:get_name()

	if is_bowl(item_name) then
		local soup_bowl = ItemStack("xdecor:bowl_soup 1")
		-- For bowls from other mods, remember the original bowl name
		-- to restore it after eating the soup.
		if item_name ~= "xdecor:bowl" then
			local imeta = soup_bowl:get_meta()
			imeta:set_string("original_bowl", item_name)
		end
		-- Add item to inventory, if possible
		if wield_item:get_count() > 1 then
			if inv:room_for_item("main", soup_bowl) then
				itemstack:take_item()
				inv:add_item("main", soup_bowl)
			else
				-- No space: Drop soup bowl on ground
				itemstack:take_item()
				minetest.add_item(clicker:get_pos(), soup_bowl)
			end
		else
			itemstack:replace(soup_bowl)
		end

		minetest.set_node(pos, {name = "xdecor:cauldron_empty", param2 = node.param2})

		minetest.log("action", "[xdecor] "..clicker:get_player_name().." fills their bowl ("..item_name..") with soup from the cauldron at "..minetest.pos_to_string(pos))
	end

	return itemstack
end

xdecor.register("cauldron_empty", {
	description = S("Cauldron"),
	--~ Cauldron tooltip
	_tt_help = S("For storing water and cooking soup"),
	groups = {cracky=2, oddly_breakable_by_hand=1,cauldron=1},
	is_ground_content = false,
	on_rotate = screwdriver.rotate_simple,
	tiles = {"xdecor_cauldron_top_empty.png", "xdecor_cauldron_bottom.png", "xdecor_cauldron_sides.png"},
	sounds = default.node_sound_metal_defaults(),
	collision_box = xdecor.pixelbox(16, cauldron.cbox),
	on_rightclick = cauldron.filling,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local node = minetest.get_node(pos)
		set_infotext(meta, node)
		cauldron.stop_sound(pos)
	end,
})

xdecor.register("cauldron_idle", {
	description = S("Cauldron with Water (cold)"),
	groups = {cracky=2, oddly_breakable_by_hand=1, not_in_creative_inventory=1,cauldron=2},
	is_ground_content = false,
	on_rotate = screwdriver.rotate_simple,
	tiles = {"xdecor_cauldron_top_idle.png", "xdecor_cauldron_bottom.png", "xdecor_cauldron_sides.png"},
	sounds = default.node_sound_metal_defaults(),
	drop = "xdecor:cauldron_empty",
	collision_box = xdecor.pixelbox(16, cauldron.cbox),
	on_rightclick = cauldron.filling,
	on_construct = cauldron.idle_construct,
	on_timer = cauldron.idle_timer,
})

xdecor.register("cauldron_idle_river_water", {
	description = S("Cauldron with River Water (cold)"),
	groups = {cracky=2, oddly_breakable_by_hand=1, not_in_creative_inventory=1,cauldron=2},
	is_ground_content = false,
	on_rotate = screwdriver.rotate_simple,
	tiles = {"xdecor_cauldron_top_idle_river_water.png", "xdecor_cauldron_bottom.png", "xdecor_cauldron_sides.png"},
	sounds = default.node_sound_metal_defaults(),
	drop = "xdecor:cauldron_empty",
	collision_box = xdecor.pixelbox(16, cauldron.cbox),
	on_rightclick = cauldron.filling,
	on_construct = cauldron.idle_construct,
	on_timer = cauldron.idle_timer,
})

xdecor.register("cauldron_idle_soup", {
	description = S("Cauldron with Soup (cold)"),
	groups = {cracky = 2, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1,cauldron=2},
	is_ground_content = false,
	on_rotate = screwdriver.rotate_simple,
	drop = "xdecor:cauldron_empty",
	tiles = {"xdecor_cauldron_top_idle_soup.png", "xdecor_cauldron_bottom.png", "xdecor_cauldron_sides.png"},
	sounds = default.node_sound_metal_defaults(),
	collision_box = xdecor.pixelbox(16, cauldron.cbox),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local node = minetest.get_node(pos)
		set_infotext(meta, node)
		local timer = minetest.get_node_timer(pos)
		timer:start(10.0)
		cauldron.stop_sound(pos)
	end,
	on_timer = cauldron.idle_timer,
	on_rightclick = cauldron.take_soup,
})

xdecor.register("cauldron_boiling", {
	description = S("Cauldron with Water (boiling)"),
	groups = {cracky=2, oddly_breakable_by_hand=1, not_in_creative_inventory=1,cauldron=3},
	is_ground_content = false,
	on_rotate = screwdriver.rotate_simple,
	drop = "xdecor:cauldron_empty",
	damage_per_second = 2,
	tiles = {
		{
			name = "xdecor_cauldron_top_anim_boiling_water.png",
			animation = {type = "vertical_frames", length = 3.0}
		},
		"xdecor_cauldron_bottom.png",
		"xdecor_cauldron_sides.png"
	},
	sounds = default.node_sound_metal_defaults(),
	collision_box = xdecor.pixelbox(16, cauldron.cbox),
	on_rightclick = cauldron.filling,
	on_construct = cauldron.boiling_construct,
	on_timer = cauldron.boiling_timer,
	on_destruct = function(pos)
		cauldron.stop_sound(pos)
	end,
})

xdecor.register("cauldron_boiling_river_water", {
	description = S("Cauldron with River Water (boiling)"),
	groups = {cracky=2, oddly_breakable_by_hand=1, not_in_creative_inventory=1,cauldron=3},
	is_ground_content = false,
	on_rotate = screwdriver.rotate_simple,
	drop = "xdecor:cauldron_empty",
	damage_per_second = 2,
	tiles = {
		{
			name = "xdecor_cauldron_top_anim_boiling_river_water.png",
			animation = {type = "vertical_frames", length = 3.0}
		},
		"xdecor_cauldron_bottom.png",
		"xdecor_cauldron_sides.png"
	},
	sounds = default.node_sound_metal_defaults(),
	collision_box = xdecor.pixelbox(16, cauldron.cbox),
	on_rightclick = cauldron.filling,
	on_construct = cauldron.boiling_construct,
	on_timer = cauldron.boiling_timer,
	on_destruct = function(pos)
		cauldron.stop_sound(pos)
	end,
})



xdecor.register("cauldron_soup", {
	description = S("Cauldron with Soup (boiling)"),
	groups = {cracky = 2, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1,cauldron=3},
	is_ground_content = false,
	on_rotate = screwdriver.rotate_simple,
	drop = "xdecor:cauldron_empty",
	damage_per_second = 2,
	tiles = {
		{
			name = "xdecor_cauldron_top_anim_soup.png",
			animation = {type = "vertical_frames", length = 3.0}
		},
		"xdecor_cauldron_bottom.png",
		"xdecor_cauldron_sides.png"
	},
	sounds = default.node_sound_metal_defaults(),
	collision_box = xdecor.pixelbox(16, cauldron.cbox),
	on_construct = function(pos)
		cauldron.start_sound(pos)
		local meta = minetest.get_meta(pos)
		local node = minetest.get_node(pos)
		set_infotext(meta, node)

		local timer = minetest.get_node_timer(pos)
		timer:start(5.0)
	end,
	on_timer = cauldron.boiling_timer,
	on_rightclick = cauldron.take_soup,
	on_destruct = function(pos)
		cauldron.stop_sound(pos)
	end,
})

-- Craft items

minetest.register_craftitem("xdecor:bowl", {
	--~ Item that can hold soup
	description = S("Bowl"),
	inventory_image = "xdecor_bowl.png",
	wield_image = "xdecor_bowl.png",
	groups = {food_bowl = 1, xdecor_soup_bowl = 1, flammable = 2},
})

minetest.register_craftitem("xdecor:bowl_soup", {
	description = S("Bowl of soup"),
	inventory_image = "xdecor_bowl_soup.png",
	wield_image = "xdecor_bowl_soup.png",
	groups = {
		-- The soup itself is NOT an ingredient for the soup
		xdecor_soup_ingredient = -1,
	},
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		-- Eat the soup and replace item with the original bowl item
		-- (`xdecor:bowl` by default)
		local imeta = itemstack:get_meta()
		local empty_bowl = imeta:get_string("original_bowl")
		if empty_bowl == "" then
			empty_bowl = "xdecor:bowl"
		end
		if not minetest.registered_items[empty_bowl] then
			minetest.log("warning", "[xdecor] original_bowl of xdecor:bowl_soup was '"..empty_bowl.."', an unknown item. Falling back to xdecor:bowl")
			empty_bowl = "xdecor:bowl"
		end
		return minetest.do_item_eat(30, empty_bowl, itemstack, user, pointed_thing)
	end,
})

-- Recipes

minetest.register_craft({
	output = "xdecor:bowl 3",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""}
	}
})

minetest.register_craft({
	output = "xdecor:cauldron_empty",
	recipe = {
		{"default:iron_lump", "", "default:iron_lump"},
		{"default:iron_lump", "", "default:iron_lump"},
		{"default:iron_lump", "default:iron_lump", "default:iron_lump"}
	}
})

minetest.register_lbm({
	label = "Restart boiling cauldron sounds",
	name = "xdecor:restart_boiling_cauldron_sounds",
	nodenames = {"xdecor:cauldron_boiling", "xdecor:cauldron_boiling_river_water", "xdecor:cauldron_soup"},
	run_at_every_load = true,
	action = function(pos, node)
		cauldron.start_sound(pos)
	end,
})

minetest.register_lbm({
	label = "Update cauldron infotexts",
	name = "xdecor:update_cauldron_infotexts",
	nodenames = {"group:cauldron"},
	run_at_every_load = false,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		set_infotext(meta, node)
	end,
})

if DEBUG_RECOGNIZED_ITEMS then
	-- Print all soup ingredients, heater nodes and bowls
	-- in console
	minetest.register_on_mods_loaded(function()
		local ingredients = {}
		local heaters = {}
		local bowls = {}
		for k,v in pairs(minetest.registered_items) do
			if is_ingredient(k) then
				table.insert(ingredients, k)
			end
			if is_heater(k) then
				table.insert(heaters, k)
			end
			if is_bowl(k) then
				table.insert(bowls, k)
			end
		end
		table.sort(ingredients)
		table.sort(heaters)
		table.sort(bowls)
		local str_i = table.concat(ingredients, ", ")
		local str_h = table.concat(heaters, ", ")
		local str_b = table.concat(bowls, ", ")
		minetest.log("action", "[xdecor] List of ingredients for soup: "..str_i)
		minetest.log("action", "[xdecor] List of nodes that can heat cauldron: "..str_h)
		minetest.log("action", "[xdecor] List of bowls able to take soup from cauldron: "..str_b)
	end)
end
