sgjourney = rawget(_G, "sgjourney") or {}
sgjourney.modpath = core.get_modpath(core.get_current_modname())
sgjourney.storage = core.get_mod_storage()

local files = {
	"util.lua", "materials.lua", "stargates.lua", "dhd.lua", "devices.lua", "machines.lua", "mapgen.lua", "crafts.lua",
}
for _, file in ipairs(files) do
	dofile(sgjourney.modpath .. "/" .. file)
end

core.log("action", "[sgjourney] Native Stargate Journey port loaded")
