local default_settings = {
	enable_mapgen = false,
	always_generate = false,
	smooth_biome_transitions = true,
	log_to_chat = false,
	log_level = 2,
	default_apple_3d = true,
	giant_restrict_area = false,
}

for name,dv in pairs(default_settings) do
	local setting
	local setting_name = "riesenpilz."..name
	if type(dv) == "boolean" then
		setting = minetest.settings:get_bool(setting_name)
	elseif type(dv) == "number" then
		setting = tonumber(minetest.settings:get(setting_name))
	else
		error"[riesenpilz] Only boolean and number settings are available"
	end
	if setting == nil then
		riesenpilz[name] = dv
	else
		riesenpilz[name] = setting
	end
end
