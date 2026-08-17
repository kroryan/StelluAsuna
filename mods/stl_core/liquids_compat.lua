-- Vanilla lava has its own cooling ABM. Cover custom liquids and village-safe
-- lava variants without registering a second handler for the vanilla nodes.
local cooling = {}
local nodenames = {}

local function is_lava(name, def)
	if def.groups and (def.groups.lava or def.groups.lava_tamed) then return true end
	return name:find("lava", 1, true) ~= nil and def.liquidtype and def.liquidtype ~= "none"
end

local function is_source(name, def)
	return def.liquidtype == "source" or name:find("_source", 1, true) ~= nil
end

local function register_compat_lava(name, def)
	-- Chemistry has dedicated cooling ABMs for strong lava, thermite and
	-- molten metals. Let those handlers preserve their material-specific
	-- outputs instead of racing a generic obsidian/stone conversion.
	if name:sub(1, 10) == "chemistry:" then return end
	if not is_lava(name, def) then return end
	if name == "default:lava_source" or name == "default:lava_flowing"
		or name == "everness:lava_source" or name == "everness:lava_flowing" then return end

	local frozen = def.liquid_alternative_frozen
	if not frozen or not minetest.registered_nodes[frozen] then
		frozen = is_source(name, def) and "default:obsidian" or "default:stone"
	end
	if frozen == name then return end
	cooling[name] = frozen
	table.insert(nodenames, name)
end

minetest.register_on_mods_loaded(function()
	for name, def in pairs(minetest.registered_nodes) do register_compat_lava(name, def) end
	if #nodenames == 0 then return end
	minetest.register_abm({
		label = "Stellua compatible lava cooling",
		nodenames = nodenames,
		neighbors = {"group:cools_lava", "group:water"},
		interval = 2,
		chance = 2,
		catch_up = false,
		action = function(pos, node)
			local target = cooling[node.name]
			if target then minetest.swap_node(pos, {name = target}) end
		end,
	})
	minetest.log("action", "[stl_core] compatible lava cooling enabled for " .. table.concat(nodenames, ", "))
end)
