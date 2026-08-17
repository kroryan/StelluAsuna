local TOOL = "esvanetor:esvanetor"
local RADIUS = 4
local MAX_WEAR = 5000
local SWORD = "esvanetor:prismatic_edge"
local CONSTRUCTOR_TEXTURE = "constructor.png"

-- A broad set of capabilities lets the hammer use the normal Luanti dig/drop
-- pipeline for every ordinary node while still respecting protection and
-- node callbacks. Protected areas remain untouched; unbreakable nodes outside
-- player protection are removed by the fallback below.
local groupcaps = {
	cracky = {times = {[1] = 0.08, [2] = 0.08, [3] = 0.08}, uses = MAX_WEAR, maxlevel = 100},
	crumbly = {times = {[1] = 0.08, [2] = 0.08, [3] = 0.08}, uses = MAX_WEAR, maxlevel = 100},
	choppy = {times = {[1] = 0.08, [2] = 0.08, [3] = 0.08}, uses = MAX_WEAR, maxlevel = 100},
	snappy = {times = {[1] = 0.08, [2] = 0.08, [3] = 0.08}, uses = MAX_WEAR, maxlevel = 100},
	oddly_breakable_by_hand = {times = {[1] = 0.08, [2] = 0.08, [3] = 0.08}, uses = MAX_WEAR, maxlevel = 100},
	melty = {times = {[1] = 0.08, [2] = 0.08, [3] = 0.08}, uses = MAX_WEAR, maxlevel = 100},
}

local function plane_positions(center, normal)
	local positions = {}
	for a = -RADIUS, RADIUS do
		for b = -RADIUS, RADIUS do
			local p
			if normal.x ~= 0 then
				p = {x = center.x, y = center.y + a, z = center.z + b}
			elseif normal.y ~= 0 then
				p = {x = center.x + a, y = center.y, z = center.z + b}
			else
				p = {x = center.x + a, y = center.y + b, z = center.z}
			end
			table.insert(positions, p)
		end
	end
	return positions
end

local function excavate(itemstack, user, pointed_thing)
	if not user or not user:is_player() or pointed_thing.type ~= "node" then
		return itemstack
	end
	local center = pointed_thing.under
	local normal = vector.subtract(pointed_thing.above, pointed_thing.under)
	if math.abs(normal.x) + math.abs(normal.y) + math.abs(normal.z) ~= 1 then
		return itemstack
	end

	local dug = 0
	for _, pos in ipairs(plane_positions(center, normal)) do
		local node = minetest.get_node(pos)
		local def = minetest.registered_nodes[node.name]
		if def and node.name ~= "air" and node.name ~= "ignore"
			and not minetest.is_protected(pos, user:get_player_name()) then
			local before = minetest.get_node(pos).name
			minetest.node_dig(pos, node, user, {type = "node", under = pos,
				above = vector.add(pos, normal)})
			-- Some map/content nodes deliberately have no dig groups. Outside a
			-- protected player area, Esvanetor is explicitly allowed to break
			-- those nodes too; preserve their normal drops when doing so.
			if minetest.get_node(pos).name == before
				and not minetest.is_protected(pos, user:get_player_name()) then
				local old_meta = minetest.get_meta(pos):to_table()
				local drops = minetest.get_node_drops(node.name, itemstack)
				minetest.remove_node(pos)
				for _, drop in ipairs(drops or {}) do
					minetest.add_item(pos, ItemStack(drop))
				end
				if def.after_dig_node then
					def.after_dig_node(pos, node, old_meta, user)
				end
			end
			if minetest.get_node(pos).name ~= before then
				dug = dug + 1
			end
		end
	end

	if dug > 0 then
		itemstack:add_wear(math.max(1, math.floor(65535 * dug / MAX_WEAR)))
		minetest.sound_play("default_dig_cracky", {pos = center, gain = 0.35}, true)
		minetest.chat_send_player(user:get_player_name(),
				("Esvanetor excavated %d node%s (9x9). Protected nodes were skipped."):format(dug, dug == 1 and "" or "s"))
	end
	return itemstack
end

minetest.register_tool(TOOL, {
	description = "Esvanetor 9x9 Excavation Hammer\nBreaks a 9x9 plane with one swing",
	inventory_image = "esvanetor.png",
	wield_image = "esvanetor.png",
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level = 100,
		groupcaps = groupcaps,
		damage_groups = {fleshy = 12},
	},
	sound = {breaks = "default_tool_breaks"},
	on_use = excavate,
})

minetest.register_craft({
	output = TOOL,
	recipe = {
		{"sgjourney:naquadah_alloy", "stl_core:titanium_block", "sgjourney:naquadah_alloy"},
		{"stl_core:titanium_block", "sgjourney:energy_crystal", "stl_core:titanium_block"},
		{"", "stl_core:titanium", ""},
	},
})

-- Escarbator hammers remove a straight horizontal line. The direction follows
-- the player's look axis, matching the constructors, while normal digging
-- callbacks, drops and protection checks are retained.
local function escarbator_line(itemstack, user, pointed_thing, length)
	if not user or not user:is_player() or pointed_thing.type ~= "node" then return itemstack end
	local look = user:get_look_dir()
	local axis = math.abs(look.x) >= math.abs(look.z) and "x" or "z"
	local step = (axis == "x" and look.x or look.z) < 0 and -1 or 1
	local player_name = user:get_player_name()
	local dug = 0
	for i = 0, length - 1 do
		local pos = vector.copy(pointed_thing.under)
		pos[axis] = pos[axis] + step * i
		if not minetest.is_protected(pos, player_name) then
			local node = minetest.get_node(pos)
			if node.name ~= "air" and node.name ~= "ignore" and minetest.registered_nodes[node.name] then
				local before = node.name
				minetest.node_dig(pos, node, user, {type = "node", under = pos, above = pointed_thing.above})
				if minetest.get_node(pos).name == before then
					local drops = minetest.get_node_drops(node.name, itemstack)
					minetest.remove_node(pos)
					for _, drop in ipairs(drops or {}) do minetest.add_item(pos, ItemStack(drop)) end
				end
				if minetest.get_node(pos).name ~= before then dug = dug + 1 end
			end
		end
	end
	if dug > 0 then
		itemstack:add_wear(math.max(1, math.floor(65535 * dug / 2500)))
		minetest.sound_play("default_dig_cracky", {pos = pointed_thing.under, gain = 0.3}, true)
	end
	return itemstack
end

local escarbators = {
	{length = 9, texture = "escarbator_9.png", name = "Escarbator 9", recipe = {
		{"sgjourney:naquadah_alloy", "sgjourney:naquadah_alloy", "sgjourney:naquadah_alloy"},
		{"stl_core:titanium_block", "sgjourney:energy_crystal", "stl_core:titanium_block"},
		{"", "stl_core:titanium", ""},
	}},
	{length = 7, texture = "escarbator_7.png", name = "Escarbator 7", recipe = {
		{"sgjourney:naquadah_alloy", "sgjourney:energy_crystal", "sgjourney:naquadah_alloy"},
		{"stl_core:titanium_block", "stl_core:titanium_block", "stl_core:titanium_block"},
		{"", "stl_core:titanium", ""},
	}},
	{length = 5, texture = "escarbator_5.png", name = "Escarbator 5", recipe = {
		{"sgjourney:energy_crystal", "sgjourney:energy_crystal", "sgjourney:energy_crystal"},
		{"stl_core:titanium_block", "sgjourney:naquadah_alloy", "stl_core:titanium_block"},
		{"", "stl_core:titanium", ""},
	}},
	{length = 3, texture = "escarbator_3.png", name = "Escarbator 3", recipe = {
		{"sgjourney:energy_crystal", "stl_core:titanium_block", "sgjourney:energy_crystal"},
		{"", "sgjourney:naquadah_alloy", ""},
		{"", "stl_core:titanium", ""},
	}},
}

for _, def in ipairs(escarbators) do
	local item = "esvanetor:escarbator_" .. def.length
	minetest.register_tool(item, {
		description = def.name .. "\nRainbow straight-line excavation hammer (" .. def.length .. "x1)",
		inventory_image = def.texture, wield_image = def.texture,
		tool_capabilities = {full_punch_interval = 0.1, max_drop_level = 100,
			groupcaps = groupcaps, damage_groups = {fleshy = 12}},
		sound = {breaks = "default_tool_breaks"},
		on_use = function(stack, user, pointed) return escarbator_line(stack, user, pointed, def.length) end,
	})
	minetest.register_craft({output = item, recipe = def.recipe})
end

-- Prismatic Edge: an intentionally end-game, unbreakable rainbow sword.
minetest.register_tool(SWORD, {
	description = "Prismatic Edge (Filo Prismático)\nInfinite damage",
	inventory_image = "prismatic_edge.png",
	wield_image = "prismatic_edge.png",
	tool_capabilities = {
		full_punch_interval = 0.05,
		max_drop_level = 100,
		punch_attack_uses = 0,
		damage_groups = {fleshy = 1000000},
	},
})

minetest.register_craft({
	output = SWORD,
	recipe = {
		{"sgjourney:naquadah_alloy", "sgjourney:energy_crystal", "sgjourney:naquadah_alloy"},
		{"", "sgjourney:naquadria", ""},
		{"", "stl_core:titanium_block", ""},
	},
})

-- Construction tools place a nine-node line without replacing existing blocks.
-- The target list is resolved after every mod has registered its nodes, so
-- missing optional material packs simply do not create a broken recipe.
local constructor_materials = {
	{"default:wood", "Wood"}, {"default:stone", "Stone"},
	{"default:cobble", "Cobblestone"}, {"default:brick", "Brick"},
	{"default:glass", "Glass"}, {"default:steelblock", "Steel"},
	{"wool:dark_grey", "Dark Grey Wool"},
	{"bakedclay:terracotta_dark_grey", "Dark Grey Glazed"},
	{"bakedclay:terracotta_red", "Red Glazed"},
	{"bakedclay:terracotta_orange", "Orange Glazed"},
	{"bakedclay:terracotta_yellow", "Yellow Glazed"},
	{"bakedclay:terracotta_green", "Green Glazed"},
	{"bakedclay:terracotta_cyan", "Cyan Glazed"},
	{"bakedclay:terracotta_blue", "Blue Glazed"},
	{"bakedclay:terracotta_violet", "Violet Glazed"},
	{"bakedclay:terracotta_magenta", "Magenta Glazed"},
	{"bakedclay:terracotta_brown", "Brown Glazed"},
	{"bakedclay:terracotta_pink", "Pink Glazed"},
	{"bakedclay:terracotta_black", "Black Glazed"},
}

local function constructor_line(itemstack, user, pointed_thing, target)
	if not user or not user:is_player() or pointed_thing.type ~= "node" then
		return itemstack
	end
	if not minetest.registered_nodes[target] then
		minetest.chat_send_player(user:get_player_name(), "This constructor material is not available in the current game pack.")
		return itemstack
	end
	local look = user:get_look_dir()
	local dx, dz = 0, 0
	if math.abs(look.x) >= math.abs(look.z) then
		dx = look.x < 0 and -1 or 1
	else
		dz = look.z < 0 and -1 or 1
	end
	local base = pointed_thing.above
	local placed = 0
	for i = 0, 8 do
		local pos = {x = base.x + dx * i, y = base.y, z = base.z + dz * i}
		local existing = minetest.get_node(pos)
		local def = minetest.registered_nodes[existing.name]
		if not minetest.is_protected(pos, user:get_player_name())
			and (existing.name == "air" or (def and def.buildable_to)) then
			minetest.set_node(pos, {name = target})
			placed = placed + 1
		end
	end
	if placed > 0 then
		itemstack:add_wear(1)
		minetest.sound_play("default_place_node", {pos = base, gain = 0.4}, true)
	end
	return itemstack
end

for index, entry in ipairs(constructor_materials) do
	local target, label = entry[1], entry[2]
	if minetest.registered_nodes[target] then
		local name = "esvanetor:constructor_" .. index
		minetest.register_tool(name, {
			description = "Rainbow Constructor: " .. label .. " (9x1)",
			inventory_image = CONSTRUCTOR_TEXTURE,
			wield_image = CONSTRUCTOR_TEXTURE,
			tool_capabilities = {full_punch_interval = 0.15, max_drop_level = 1},
			on_use = function(stack, user, pointed) return constructor_line(stack, user, pointed, target) end,
		})
		minetest.register_craft({
			output = name,
			recipe = {{target, "stl_core:titanium", target}, {"", "sgjourney:energy_crystal", ""}, {"", "stl_core:stick", ""}},
		})
	end
end

dofile(minetest.get_modpath("esvanetor") .. "/holefixer.lua")
