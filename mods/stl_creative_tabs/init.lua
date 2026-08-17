-- Group the creative inventory by item namespace after every game mod has
-- registered its items. The built-in All/Nodes/Tools/Items tabs remain intact.
local core = minetest

local function title_for(namespace)
	local known = {
		default = "Minecraft-style Basics",
		stl_core = "StelluAsuna Core",
		stl_decor = "StelluAsuna Decor",
		stl_precursor = "StelluAsuna Precursor",
		stl_vehicles = "StelluAsuna Vehicles",
		sgjourney = "Stargate Journey",
		esvanetor = "Rainbow Tools",
		logistica = "Logistica",
		mg_villages = "MG Villages",
		working_villages = "Working Villages",
		mobs = "Mobs",
		mobs_monster = "Monster Mobs",
	}
	if known[namespace] then return known[namespace] end
	return namespace:gsub("_", " "):gsub("(%a)([%w]*)", function(a, b)
		return a:upper() .. b
	end)
end

core.register_on_mods_loaded(function()
	local by_mod = {}
	for name, def in pairs(core.registered_items) do
		local groups = def.groups or {}
		if def.description and def.description ~= "" and groups.not_in_creative_inventory ~= 1 then
			local namespace = name:match("^([^:]+):")
			if namespace and namespace ~= "creative" and namespace ~= "sfinv" then
				by_mod[namespace] = by_mod[namespace] or {}
				by_mod[namespace][name] = def
			end
		end
	end

	local namespaces = {}
	for namespace, items in pairs(by_mod) do
		if namespace ~= "unknown" and next(items) then namespaces[#namespaces + 1] = namespace end
	end
	table.sort(namespaces)
	for _, namespace in ipairs(namespaces) do
		-- Prefix the page name to avoid collisions with built-in categories.
		creative.register_tab("mod_" .. namespace, title_for(namespace), by_mod[namespace])
	end
end)
