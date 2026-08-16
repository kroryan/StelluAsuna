--[[
  Biome API noise settings
]]

-- Set heat noise params
minetest.set_mapgen_setting_noiseparams("mg_biome_np_heat",{
  flags = "default",
  lacunarity = 1,
  persistence = 0.925,
  seed = 5349,
  spread = {
    x = 2000,
    y = 2000,
    z = 2000,
  },
  scale = 42,
  octaves = 2,
  offset = 50,
},true)

-- Set humidity noise params
minetest.set_mapgen_setting_noiseparams("mg_biome_np_humidity",{
  flags = "default",
  lacunarity = 1,
  persistence = 0.925,
  seed = 842,
  spread = {
    x = 2000,
    y = 2000,
    z = 2000,
  },
  scale = 42,
  octaves = 2,
  offset = 50,
},true)

-- Set heat blend noise params
minetest.set_mapgen_setting_noiseparams("mg_biome_np_heat_blend",{
  flags = "default",
  lacunarity = 1.678,
  persistence = 0.625,
  seed = 13,
  spread = {
    x = 24,
    y = 24,
    z = 24,
  },
  scale = 0.525,
  octaves = 2,
  offset = 0,
},true)

-- Set humidity blend noise params
minetest.set_mapgen_setting_noiseparams("mg_biome_np_humidity_blend",{
  flags = "default",
  lacunarity = 1.678,
  persistence = 0.625,
  seed = 90003,
  spread = {
    x = 24,
    y = 24,
    z = 24,
  },
  scale = 0.525,
  octaves = 2,
  offset = 0,
},true)

--[[
  Climate analysis command
]]

-- Register climate analysis privilege
minetest.register_privilege("climate",{
  description = "Privilege required to use the /climate command",
  give_to_singleplayer = false,
  give_to_admin = true,
})

-- Register climate analysis command
minetest.register_chatcommand("climate",{
  params = "",
  description = "analyze climate at current position",
  privs = { climate = true },
  func = function(name)
    local player = minetest.get_player_by_name(name)

    if not minetest.check_player_privs("climate") then
      return false, "You do not have the 'climate' privilege necessary to use this command."
    end

    local pos = player:get_pos()
    local data = minetest.get_biome_data(pos)
    if data then
      return true, "(" .. math.floor(pos.x) .. "," .. math.floor(pos.y) .. "," .. math.floor(pos.z) .. "): biome = " .. minetest.get_biome_name(data.biome) .. ", heat = " .. data.heat .. ", humidity = " .. data.humidity
    else
      return false, "No biome data for your current position!"
    end
  end
})