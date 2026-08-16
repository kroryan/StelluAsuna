-- Mod global namespace
spyglass = {}

-- Load support for MT game translation.
local S = minetest.get_translator("spyglass")

-- Keep track of players who are scoping in, and their wielded item
local zoomed = {}

-- Timer for scope-check globalstep
local timer = 0.2

-- List of IDs for players zoomed, for use in hide_overlay(). NOTE: for HUD overlay
local zoomed_hud_id = {}

--- Overlay

local function show_overlay(name, item_name)
	local player = minetest.get_player_by_name(name)
	if not player then
		return
	end

	zoomed[name] = item_name
	zoomed_hud_id[name] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.5, y = 0.5},
		offset = {x = (-122*14)/2, y = (-77*14)/2},
		text = "spyglass_overlay.png",
		scale = {x = 65, y = 65},
		alignment = {x = 1, y = 1},
	})
	player:set_fov(10, false, 0.2)
	player:hud_set_flags({ wielditem = false })
	-- play the sound effect
	minetest.sound_play("spyglass_zoom", {to_player = name, gain = 0.9} )
end

local function hide_overlay(name)
	local player = minetest.get_player_by_name(name)
	if not player then
		return
	end

	zoomed[name] = nil
	player:hud_remove(zoomed_hud_id[name])
	zoomed_hud_id[name] = nil
	player:set_fov(0)
	player:hud_set_flags({ wielditem = true })
	-- play the sound effect
	minetest.sound_play("spyglass_zoom_out", {to_player = name, gain = 0.8} )
end

-- Be absolutely certain crosshair HUD gets removed on death
minetest.register_on_dieplayer(function(player)
	if zoomed_hud_id[player:get_player_name()] then
		hide_overlay(player:get_player_name())
	end
end)

local function on_use(stack, user, pointed)
	if zoomed[user:get_player_name()] then
		-- shooter checks for the return value of def.on_use, and executes
		-- the rest of the code only if this function returns non-nil
		return stack
	end
end

local function on_rclick(item, placer, pointed_thing)
	local name = placer:get_player_name()
	
	-- Prioritize on "un-scoping", if player is using the scope
	if not zoomed[name] and pointed_thing.type == "node" then
		return minetest.item_place(item, placer, pointed_thing)
	end

	if zoomed[name] then
		hide_overlay(name)
	else
		-- Remove _loaded suffix added to item name by shooter
		local item_name = item:get_name():gsub("_loaded", "")
		show_overlay(name, item_name)
	end
end

--- Check if zoomed
local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time < timer then
		return
	end

	time = 0
	for name, original_item in pairs(zoomed) do
		local player = minetest.get_player_by_name(name)
		if not player then
			zoomed[name] = nil
		else
			local wielded_item = player:get_wielded_item():get_name():gsub("_loaded", "")
			if wielded_item ~= original_item then
				hide_overlay(name)
			end
		end
	end
end)


-- Spyglass item

minetest.register_tool("spyglass:spyglass", {
	description = S("Spyglass"),
	inventory_image = "spyglass_spyglass.png",
	stack_max = 1,
	on_secondary_use = on_rclick		
})


-- Crafting

local glass = "default:glass"
local copper = "default:copper_ingot"

if minetest.get_modpath("hades_core") then
	glass = "hades_core:glass"
	copper = "hades_core:copper_ingot"
elseif minetest.get_modpath("fl_ores") then
	glass = "fl_glass:framed_glass"
	copper = "fl_ores:copper_ingot"
end

minetest.register_craft({
	output = "spyglass:spyglass",
	recipe = {
		{glass},
		{copper},
		{copper},
	}
})

