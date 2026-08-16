local workbench = {}
local registered_cuttable_nodes = {}
local special_cuts = {}

screwdriver = screwdriver or {}
local min, ceil = math.min, math.ceil
local S = minetest.get_translator("xdecor")
local FS = function(...) return minetest.formspec_escape(S(...)) end
local NS = function(s) return s end

-- Set to true to print all the raw English strings
-- of registered cut nodes into console.
-- (Requires Luanti 5.14.0 or later to work.)
local GENERATE_TRANSLATABLE_STRING_LIST = false

if GENERATE_TRANSLATABLE_STRING_LIST and not minetest.strip_escapes then
	minetest.log("warning", "[xdecor] GENERATE_TRANSLATABLE_STRING_LIST is set to true but minetest.strip_escapes is missing! "..
		"This would malform the output, so GENERATE_TRANSLATABLE_STRING_LIST will be forced to false.")
	GENERATE_TRANSLATABLE_STRING_LIST = false
end

local DEFAULT_HAMMER_REPAIR = 500
local DEFAULT_HAMMER_REPAIR_COST = 700


-- Nodeboxes definitions
workbench.defs = {
	-- Name Yield Nodeboxes (X Y Z W H L)  Description  LegacyDescription
	{"nanoslab",    16, {{ 0, 0,  0, 8,  1, 8  }},
		--~ Part of a block name for a tiny slab with 1/16 height and 1/4 area. E.g. "Stone Nanoslab"
		NS("Nanoslab"),
		--~ Block name for a tiny slab with 1/16 height and 1/4 area. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
		NS("@1 Nanoslab")},
	{"micropanel",  16, {{ 0, 0,  0, 16, 1, 8  }},
		--~ Part of a block name for a tiny slab with 1/16 height and 1/2 area. E.g. "Stone Micropanel"
		NS("Micropanel"),
		--~ Block name for a tiny slab with 1/16 height and 1/2 area. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
		NS("@1 Micropanel")},
	{"microslab",   8,  {{ 0, 0,  0, 16, 1, 16 }},
		--~ Part of a block name for a tiny slab with 1/16 height and full area. E.g. "Stone Microslab"
		NS("Microslab"),
		--~ Block name for a tiny slab with 1/16 height and full area. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
		NS("@1 Microslab")},
	{"thinstair",   8,  {{ 0, 7,  0, 16, 1, 8  }, { 0, 15, 8, 16, 1, 8  }},
		--~ Part of a block name of a thin stair, a stair-like block where the "steps" are thinner. E.g. "Stone Thin Stair"
		NS("Thin Stair"),
		--~ Block name of a thin stair, a stair-like block where the "steps" are thinner. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
		NS("@1 Thin Stair")},
	{"cube",        4,  {{ 0, 0,  0, 8,  8, 8 }},
		--~ Part of a block name of a tiny cube-shaped block with 1/2 the side length of a full block. E.g. "Stone Cube"
		NS("Cube"),
		--~ Block name of a tiny cube-shaped block with 1/2 the side length of a full block. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
		NS("@1 Cube")},
	{"panel",       4,  {{ 0, 0,  0, 16, 8, 8 }},
		--~ Part of a block name of a block with 1/2 the height and 1/2 the length of a full block. It's like a slab that was cut in half. E.g. "Stone Panel"
		NS("Panel"),
		--~ Block name of a block with 1/2 the height and 1/2 the length of a full block. It's like a slab that was cut in half. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
		NS("@1 Panel")},
	{"slab",        2,  nil,
		--~ Part of block name of a block with 1/2 the height of a full block. E.g. "Stone Slab"
		NS("Slab"),
		--~ Block name of a block with 1/2 the height of a full block. (@1 = base block name, e.g. "Stone")
		NS("@1 Slab") },
	{"doublepanel", 2,  {{ 0, 0,  0, 16, 8, 8  }, { 0, 8,  8, 16, 8, 8  }},
		--~ Block name of a stair-like block variant with a lower piece cut away. E.g. "Stone Double Panel"
			NS("Double Panel"),
			--~ Block name of a stair-like block variant with a lower piece cut away. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
			NS("@1 Double Panel")},
	{"halfstair",   2,  {{ 0, 0,  0, 8,  8, 16 },
			{ 0, 8,  8, 8,  8, 8  }},
			--~ Part of a block name for a stair where 1/2 has been cut away sideways. Can be obtained by work bench. E.g. "Stone Half-Stair"
			NS("Half-Stair"),
			--~ Block name of a stair where 1/2 has been cut away sideways. Can be obtained by work bench. (@1 = base block name, e.g. "Stone")
			NS("@1 Half-Stair")},
	{"stair_outer", 1,  nil, nil},
	{"stair",       1,  nil,
			--~ Block name of a 'traditional' stair-shaped block. E.g. "Stone Stair"
			NS("Stair"),
			--~ Block name of a 'traditional' stair-shaped block. (@1 = base block name, e.g. "Stone")
			NS("@1 Stair")},
	{"stair_inner", 1,  nil, nil},
}

local custom_repairable = {}
function xdecor:register_repairable(item)
	custom_repairable[item] = true
end

-- Tools allowed to be repaired
function workbench:repairable(stack)
	-- Explicitly registered as repairable: Overrides everything else
	if custom_repairable[stack] then
		return true
	end
	-- no repair if non-tool
	if not minetest.registered_tools[stack] then
		return false
	end
	-- no repair if disable_repair group
	if minetest.get_item_group(stack, "disable_repair") == 1 then
		return false
	end
	return true
end

-- Returns true if item can be cut into basic stairs and slabs
function workbench:cuttable(itemname)
	local split = string.split(itemname, ":")
	if split and split[1] and split[2] then
		if minetest.registered_nodes["stairs:stair_"..split[2]] ~= nil or
		minetest.registered_nodes["stairs:slab_"..split[2]] ~= nil then
			return true
		end
	end
	if registered_cuttable_nodes[itemname] == true then
		return true
	end
	return false
end

-- Returns true if item can be cut into xdecor extended shapes (thinslab, panel, cube, etc.)
function workbench:cuttable_extended(itemname)
	return registered_cuttable_nodes[itemname] == true
end

-- method to allow other mods to check if an item is repairable
function xdecor:is_repairable(stack)
	return workbench:repairable(stack)
end

function workbench:get_output(inv, input, name)
	local output = {}
	local extended = workbench:cuttable_extended(input:get_name())
	for i = 1, #self.defs do
		local nbox = self.defs[i]
		local cuttype = nbox[1]
		local count = nbox[2] * input:get_count()
		local max_count = input:get_stack_max()
		if count > max_count then
			-- Limit count to maximum multiple to avoid waste
			count = nbox[2] * math.floor(max_count / nbox[2])
		end
		local was_cut = false
		if extended or nbox[3] == nil then
			local item = name .. "_" .. cuttype
			local name_after_colon = name:match(":(.*)")
			item = (nbox[3] and item)
			if not item and name_after_colon then
				item = "stairs:" .. cuttype .. "_" .. name_after_colon
			end
			if item and minetest.registered_items[item] then
				output[i] = item .. " " .. count
				was_cut = true
			end
		end
		if not was_cut and special_cuts[input:get_name()] ~= nil then
			local cut = special_cuts[input:get_name()][cuttype]
			if cut then
				output[i] = cut .. " " .. count
				was_cut = true
			end
		end
	end

	inv:set_list("forms", output)
end

local main_fs = ""..
	--~ Label shown in work bench menu where you can cut a block to create smaller versions of it
	"label[0.9,1.23;"..FS("Cut").."]"
	--~ Label shown in work bench menu where you can repair an item
	.."label[0.9,2.23;"..FS("Repair").."]"
	..[[ box[-0.05,1;2.05,0.9;#555555]
	box[-0.05,2;2.05,0.9;#555555] ]]
	--~ Button in work bench menu for the crafting grid
	.."button[0,0;2,1;craft;"..FS("Crafting").."]"
	--~ Button in work bench menu for its inventory
	.."button[2,0;2,1;storage;"..FS("Storage").."]"
	..[[ image[3,1;1,1;gui_arrow.png]
	image[0,1;1,1;worktable_saw.png]
	image[0,2;1,1;worktable_anvil.png]
	image[3,2;1,1;hammer_layout.png]
	list[context;input;2,1;1,1;]
	list[context;tool;2,2;1,1;]
	list[context;hammer;3,2;1,1;]
	list[context;forms;4,0;4,3;]
	listring[current_player;main]
	listring[context;tool]
	listring[current_player;main]
	listring[context;hammer]
	listring[current_player;main]
	listring[context;forms]
	listring[current_player;main]
	listring[context;input]
]]

local crafting_fs = "image[5,1;1,1;gui_furnace_arrow_bg.png^[transformR270]"
	--~ Button to return to main page in work bench menu
	.."button[0,0;1.5,1;back;< "..FS("Back").."]"
	..[[ list[current_player;craft;2,0;3,3;]
	list[current_player;craftpreview;6,1;1,1;]
	listring[current_player;main]
	listring[current_player;craft]
]]

local storage_fs = "list[context;storage;0,1;8,2;]"
	.."button[0,0;1.5,1;back;< "..FS("Back").."]"
	..[[listring[context;storage]
	listring[current_player;main]
]]

local formspecs = {
	-- Main formspec
	main_fs,

	-- Crafting formspec
	crafting_fs,

	-- Storage formspec
	storage_fs,
}

function workbench:set_formspec(meta, id)
	meta:set_string("formspec",
		"size[8,7;]list[current_player;main;0,3.25;8,4;]" ..
		formspecs[id] .. xdecor.xbg .. default.get_hotbar_bg(0,3.25))
end

function workbench.construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	inv:set_size("tool", 1)
	inv:set_size("input", 1)
	inv:set_size("hammer", 1)
	inv:set_size("forms", 4*3)
	inv:set_size("storage", 8*2)

	meta:set_string("infotext", S("Work Bench"))
	workbench:set_formspec(meta, 1)
end

function workbench.fields(pos, _, fields)
	if fields.quit then return end

	local meta = minetest.get_meta(pos)
	local id = fields.back and 1 or fields.craft and 2 or fields.storage and 3
	if not id then return end

	workbench:set_formspec(meta, id)
end

function workbench.dig(pos)
	local inv = minetest.get_meta(pos):get_inventory()
	return inv:is_empty("input") and inv:is_empty("hammer") and
	       inv:is_empty("tool") and inv:is_empty("storage")
end

function workbench.blast(pos)
	local drops = xdecor.get_inventory_drops(pos, {"input", "hammer", "tool", "storage"})
	minetest.remove_node(pos)
	return drops
end

function workbench.timer(pos)
	local timer = minetest.get_node_timer(pos)
	local inv = minetest.get_meta(pos):get_inventory()
	local tool = inv:get_stack("tool", 1)
	local hammer = inv:get_stack("hammer", 1)

	if tool:is_empty() or hammer:is_empty() or tool:get_wear() == 0 then
		timer:stop()
		return
	end

	local hammerdef = hammer:get_definition()

	-- Tool's wearing range: 0-65535; 0 = new condition
	tool:add_wear(-hammerdef._xdecor_hammer_repair or DEFAULT_HAMMER_REPAIR)
	hammer:add_wear(hammerdef._xdecor_hammer_repair_cost or DEFAULT_HAMMER_REPAIR_COST)

	inv:set_stack("tool", 1, tool)
	inv:set_stack("hammer", 1, hammer)

	return true
end

function workbench.allow_put(pos, listname, index, stack, player)
	local stackname = stack:get_name()
	if (listname == "tool" and workbench:repairable(stackname)) or
	   (listname == "input" and workbench:cuttable(stackname)) or
	   (listname == "hammer" and minetest.get_item_group(stackname, "repair_hammer") == 1) or
	    listname == "storage" then
		return stack:get_count()
	end

	return 0
end

function workbench.on_put(pos, listname, index, stack, player)
	local inv = minetest.get_meta(pos):get_inventory()
	if listname == "input" then
		local input = inv:get_stack("input", 1)
		workbench:get_output(inv, input, stack:get_name())
	elseif listname == "tool" or listname == "hammer" then
		local timer = minetest.get_node_timer(pos)
		timer:start(3.0)
	end
end

function workbench.allow_move(pos, from_list, from_index, to_list, to_index, count, player)
	if (to_list == "storage" and from_list ~= "forms") then
		return count
	elseif (to_list == "hammer" and (from_list == "tool" or from_list == "storage")) then
		local inv = minetest.get_inventory({type="node", pos=pos})
		local stack = inv:get_stack(from_list, from_index)
		if minetest.get_item_group(stack:get_name(), "repair_hammer") == 1 then
			return count
		end
	elseif (to_list == "tool") then
		local inv = minetest.get_inventory({type="node", pos=pos})
		local stack = inv:get_stack(from_list, from_index)
		if workbench:repairable(stack:get_name()) then
			return count
		end
	elseif (to_list == "input") then
		local inv = minetest.get_inventory({type="node", pos=pos})
		local stack = inv:get_stack(from_list, from_index)
		if workbench:cuttable(stack:get_name()) then
			return count
		end
	end
	return 0
end

function workbench.on_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local from_stack = inv:get_stack(from_list, from_index)
	local to_stack = inv:get_stack(to_list, to_index)

	workbench.on_take(pos, from_list, from_index, from_stack, player)
	workbench.on_put(pos, to_list, to_index, to_stack, player)
end

function workbench.allow_take(pos, listname, index, stack, player)
	return stack:get_count()
end

function workbench.on_take(pos, listname, index, stack, player)
	local inv = minetest.get_meta(pos):get_inventory()
	local input = inv:get_stack("input", 1)
	local inputname = input:get_name()
	local stackname = stack:get_name()

	if listname == "input" then
		if stackname == inputname and workbench:cuttable(inputname) then
			workbench:get_output(inv, input, stackname)
		else
			inv:set_list("forms", {})
		end
	elseif listname == "forms" then
		local fromstack = inv:get_stack(listname, index)
		if not fromstack:is_empty() and fromstack:get_name() ~= stackname then
			local player_inv = player:get_inventory()
			if player_inv:room_for_item("main", fromstack) then
				player_inv:add_item("main", fromstack)
			end
		end

		input:take_item(ceil(stack:get_count() / workbench.defs[index][2]))
		inv:set_stack("input", 1, input)
		workbench:get_output(inv, input, inputname)
	end
end

xdecor.register("workbench", {
	description = S("Work Bench"),
	--~ Work bench tooltip
	_tt_help = S("For cutting blocks, repairing tools with a hammer, crafting and storing items"),
	groups = {cracky = 2, choppy = 2, oddly_breakable_by_hand = 1},
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	tiles = {
		"xdecor_workbench_top.png","xdecor_workbench_bottom.png",
		"xdecor_workbench_sides.png", "xdecor_workbench_sides.png",
		"xdecor_workbench_front.png", "xdecor_workbench_front.png"
	},
	on_rotate = screwdriver.rotate_simple,
	can_dig = workbench.dig,
	on_blast = workbench.blast,
	on_timer = workbench.timer,
	on_construct = workbench.construct,
	on_receive_fields = workbench.fields,
	on_metadata_inventory_put = workbench.on_put,
	on_metadata_inventory_take = workbench.on_take,
	on_metadata_inventory_move = workbench.on_move,
	allow_metadata_inventory_put = workbench.allow_put,
	allow_metadata_inventory_take = workbench.allow_take,
	allow_metadata_inventory_move = workbench.allow_move
})

local function register_cut_raw(node, workbench_def, textdomain)
	local mod_name, item_name = node:match("^(.-):(.*)")
	local def = minetest.registered_nodes[node]

	-- Special translation symbol
	local T
	if textdomain then
		T = minetest.get_translator(textdomain)
	else
		T = function(s) return s end
	end

	if item_name and workbench_def[3] then
		local groups = {}
		local tiles

		for k, v in pairs(def.groups) do
			if k ~= "wood" and k ~= "stone" and k ~= "level" then
				groups[k] = v
			end
		end

		if def.tiles then
			if #def.tiles > 1 and (def.drawtype:sub(1,5) ~= "glass") then
				tiles = def.tiles
			else
				tiles = {def.tiles[1]}
			end
		else
			tiles = {def.tile_images[1]}
		end

		-- Erase `tileable_vertical=false` from tiles because it
		-- lead to buggy textures (e.g. with default:permafrost_with_moss)
		for t=1, #tiles do
			if type(tiles[t]) == "table" and tiles[t].tileable_vertical == false then
				tiles[t].tileable_vertical = nil
			end
		end

		local custom_tiles = xdecor.glasscuts[node]
		if custom_tiles then
			if not custom_tiles.nanoslab then
				custom_tiles.nanoslab = custom_tiles.cube
			end
			if not custom_tiles.micropanel then
				custom_tiles.micropanel = custom_tiles.micropanel
			end
			if not custom_tiles.doublepanel then
				custom_tiles.doublepanel = custom_tiles.panel
			end
		end

		local core_desc, modifier
		local desc_stair, desc_stair_inner, desc_stair_outer, desc_slab, desc_cut
		if minetest.strip_escapes then
			core_desc = minetest.strip_escapes(def.description)
			modifier = minetest.strip_escapes(workbench_def[4])

			desc_stair = T(core_desc .. " Stair")
			desc_stair_inner = T("Inner " .. core_desc .. " Stair")
			desc_stair_outer = T("Outer " .. core_desc .. " Stair")
			desc_slab = T(core_desc .. " Slab")
			-- Base node description (e.g. "Stone") concatenated with a space,
			-- then a modifier (e.g. "Nanoslab"), e.g. "Stone Nanoslab".
			desc_cut = T(core_desc .. " " .. modifier)
		else
			core_desc = def.description
			modifier = workbench_def[4]

			desc_stair = S("@1 Stair", core_desc)
			desc_stair_inner = S("Inner @1 Stair", core_desc)
			desc_stair_outer = S("Outer @1 Stair", core_desc)
			desc_slab = S("@1 Slab", core_desc)
			desc_cut = S(workbench_def[5], core_desc)
		end

		if not minetest.registered_nodes["stairs:slab_" .. item_name] then
			if custom_tiles and (custom_tiles.slab or custom_tiles.stair) then
				if custom_tiles.stair then
					stairs.register_stair(item_name, node,
						groups, custom_tiles.stair, desc_stair,
						def.sounds)
					stairs.register_stair_inner(item_name, node,
						groups, custom_tiles.stair_inner, "", def.sounds, nil, desc_stair_inner)
					stairs.register_stair_outer(item_name, node,
						groups, custom_tiles.stair_outer, "", def.sounds, nil, desc_stair_outer)

					if GENERATE_TRANSLATABLE_STRING_LIST then
						print(("S(%q)"):format(core_desc .. " Stair"))
						print(("S(%q)"):format("Inner " .. core_desc .. " Stair"))
						print(("S(%q)"):format("Outer " .. core_desc .. " Stair"))
					end
				end
				if custom_tiles.slab then
					stairs.register_slab(item_name, node,
						groups, custom_tiles.slab, desc_slab,
						def.sounds)

					if GENERATE_TRANSLATABLE_STRING_LIST then
						print(("S(%q)"):format(core_desc .. " Slab"))
					end
				end
			else
				stairs.register_stair_and_slab(item_name, node,
					groups, tiles,
					desc_stair,
					desc_slab,
					def.sounds, nil,
					desc_stair_inner,
					desc_stair_outer)

				if GENERATE_TRANSLATABLE_STRING_LIST then
					print(("S(%q)"):format(core_desc .. " Stair"))
					print(("S(%q)"):format(core_desc .. " Slab"))
					print(("S(%q)"):format("Inner " .. core_desc .. " Stair"))
					print(("S(%q)"):format("Outer " .. core_desc .. " Stair"))
				end
			end
		end

		local cutname = workbench_def[1]
		local tiles_special_cut
		if custom_tiles and custom_tiles[cutname] then
			tiles_special_cut = custom_tiles[cutname]
		else
			tiles_special_cut = tiles
		end

		local cutnodename = node .. "_" .. cutname
		if minetest.registered_nodes[cutnodename] then
			minetest.log("error", "[xdecor] register_cut_raw: Refusing to register node "..cutnodename.." becaut it was already registered!")
			return false
		end

		-- Add groups to identify node as a cut node
		local cutgroups = table.copy(groups)
		-- Marks it as a cut node
		cutgroups["xdecor_cut"] = 1
		-- Specifies the cut type (nanoslab, panel, etc.)
		cutgroups["xdecor_cut_"..workbench_def[1]] = 1

		-- Also hide cut nodes from creative inv
		cutgroups.not_in_creative_inventory = 1

		minetest.register_node(":" .. cutnodename, {
			description = desc_cut,
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			sounds = def.sounds,
			tiles = tiles_special_cut,
			use_texture_alpha = def.use_texture_alpha,
			groups = cutgroups,
			is_ground_content = def.is_ground_content,
			node_box = xdecor.pixelbox(16, workbench_def[3]),
			sunlight_propagates = true,
			on_place = minetest.rotate_node
		})

		if GENERATE_TRANSLATABLE_STRING_LIST then
			print(("S(%q)"):format(core_desc .. " " .. modifier))
		end

	elseif item_name and mod_name then
		minetest.register_alias_force(
			("%s:%s_innerstair"):format(mod_name, item_name),
			("stairs:stair_inner_%s"):format(item_name)
		)
		minetest.register_alias_force(
			("%s:%s_outerstair"):format(mod_name, item_name),
			("stairs:stair_outer_%s"):format(item_name)
		)
	end
	return true
end

function workbench:register_cut(nodename, textdomain)
	if registered_cuttable_nodes[nodename] then
		minetest.log("error", "[xdecor] Workbench: Tried to register cut for node "..nodename..", but it was already registered!")
		return false
	end
	local ok = true
	for _, d in ipairs(workbench.defs) do
		local ok = register_cut_raw(nodename, d, textdomain)
		if not ok then
			ok = false
		end
	end
	registered_cuttable_nodes[nodename] = true
	return ok
end

function workbench:register_special_cut(nodename, cutlist)
	if registered_cuttable_nodes[nodename] or special_cuts[nodename] then
		minetest.log("error", "[xdecor] Workbench: Tried to register special cut for node "..nodename..", but it was already registered!")
		return false
	end
	registered_cuttable_nodes[nodename] = true
	special_cuts[nodename] = cutlist
end

-- Workbench craft
minetest.register_craft({
	output = "xdecor:workbench",
	recipe = {
		{"group:wood", "group:wood"},
		{"group:wood", "group:wood"}
	}
})

--[[ API FUNCTIONS ]]

--[[ Register a custom hammer (for repairing).
A hammer repair items at the work bench. The workbench repeatedly
checks if a hammer and a repairable tool are in the slots. The hammer
will repair the tool in regular intervals. This is called a "step".
In each step, the hammer reduces the wear of the repairable
tool but increases its own wear, each by a fixed amount.

This function allows you to register a custom hammer with custom
name, item image and wear stats.

Arguments:
* name: Internal itemname
* def: Definition table:
    * description: Item `description`
    * image: Inventory image and wield image
    * groups: Item groups (MUST contain at least `repair_hammer = 1`)
    * repair: How much item wear the hammer repairs per step
    * repair_cost: How much item wear the hammer takes itself per step

Note: Mind the implication of repair_cost! If repair_cost is lower than
repair, this means practically infinite durability if you have two
hammers that repair each other. If repair_cost is higher than repair,
then hammers will break eventually.
]]
function xdecor.register_hammer(name, def)
	minetest.register_tool(name, {
		description = def.description,
		--~ Hammer tooltip
		_tt_help = S("Repairs tools at the work bench"),
		inventory_image = def.image,
		wield_image = def.image,
		on_use = function() do
			return end
		end,
		groups = def.groups,
		_xdecor_hammer_repair = def.repair or DEFAULT_HAMMER_REPAIR,
		_xdecor_hammer_repair_cost = def.repair_cost or DEFAULT_HAMMER_REPAIR_COST,
	})
end

--[[ API FUNCTIONS ]]

--[[
Registers various 'cut' node variants for the node with the given nodename,
which will be available in the workbench.
This must only be called once per node. Calling it again is an error.

The following nodes will be registered:

* <nodename>_nanoslab
* <nodename>_micropanel
* <nodename>_microslab
* <nodename>_thinstair
* <nodename>_cube
* <nodename>_panel
* <nodename>_doublepanel
* <nodename>_halfstair

You MUST make sure these names are not already taken before
calling this function. Call xdecor.can_cut to do this.
Failing to do so is an error.

Additionally, a slab, stair, inner stair and outer stair
will be registered by using the `stairs` mod if the slab
node does not exist yet. Refer to the `stairs` mod documentation
for details.

Parameters:
* nodename: Name of node to be cut
* textdomain: Translation textdomain for registered node
  descriptions (if not provided, node descriptions will
  be untranslatable)

Returns true if all nodes were registered successfully,
returns false (and writes to error log) if any error occurred.
]]
xdecor.register_cut = function(nodename, textdomain)
	return workbench:register_cut(nodename, textdomain)
end

-- Returns true if cut nodes have been registered for the given node
xdecor.is_cut_registered = function(nodename)
	return registered_cuttable_nodes[nodename] == true
end

--[[ Returns true if cut node variants can be registered
for the node AND this node doesn't already have
cut nodes registered. ]]
xdecor.can_cut = function(nodename)
	-- Node already has cut variants: Fail
	if xdecor.is_cut_registered(nodename) then
		return false
	end
	-- Check group
	if minetest.get_item_group(nodename, "not_cuttable") == 1 then
		return false
	end
	for w=1, #workbench.defs do
		local wdef = workbench.defs[w]
		local cut = wdef[1]
		if cut ~= "stair" and cut ~= "slab" and cut ~= "stair_inner" and cut ~= "stair_outer" then
			if minetest.registered_nodes[nodename .. "_" ..cut] then
				-- There already exists a node with one of the required names: Fail
				return false
			end
		end
	end
	-- All tests passed: Success!
	return true
end

--[[ END OF API FUNCTIONS ]]


-- Register xdecor's built-in hammer
xdecor.register_hammer("xdecor:hammer", {
	description = S("Hammer"),
	image = "xdecor_hammer.png",
	groups = { repair_hammer = 1 },
	repair = DEFAULT_HAMMER_REPAIR,
	repair_cost = DEFAULT_HAMMER_REPAIR_COST,
})

-- Hammer recipes
minetest.register_craft({
	output = "xdecor:hammer",
	recipe = {
		{"default:steel_ingot", "group:stick", "default:steel_ingot"},
		{"", "group:stick", ""}
	}
})

-- Register default cuttable blocks (loaded from a list
-- of hardcoded node names)
local cuttable_nodes = dofile(minetest.get_modpath("xdecor").."/src/cuttable_node_list.lua")

for i = 1, #cuttable_nodes do
	local nodename = cuttable_nodes[i]
	if xdecor.can_cut(nodename) then
		workbench:register_cut(nodename, "_xdecor_cut_nodes")
	else
		minetest.log("action", "[xdecor] Tried to register cut for default node '"..nodename.."' but it was not allowed")
	end
end

-- Special cuts for cushion block and cabinet
workbench:register_special_cut("xdecor:cushion_block", { slab = "xdecor:cushion" })
workbench:register_special_cut("xdecor:cabinet", { slab = "xdecor:cabinet_half" })

