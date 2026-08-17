
if minetest.get_modpath("climate_api") and minetest.global_exists("climate_api") and minetest.get_modpath("regional_weather") and climate_api.register_weather ~= nil then

	local undergroundSky = {
		sky_data = {
			base_color = nil,
			type = "plain",
			textures = nil,
			clouds = false,
		},
		sun_data = {
			visible = false,
			sunrise_visible = false
		},
		moon_data = {
			visible = false
		},
		star_data = {
			visible = false
		}
	}

	local st_ly = table.copy(undergroundSky)
	st_ly.sky_data.base_color = "#444444"

	climate_api.register_weather(
		"chemistry:strong_stone_fog",
		{ has_biome = {
			"strong_stone_layer"
		} },
		{ ["climate_api:skybox"] = st_ly }
	)


	climate_api.register_weather("chemistry:acid_rain", {
		min_height = -50,
		max_height = 120,
		min_heat = 30,
		min_humidity = 40,
		max_humidity = 65,
		min_biome_humidity = 26,
		indoors = false,
		has_biome = {
			"ash_wasteland",
			"ash_wasteland_ocean"
		}
	},
	{
		["climate_api:sound"] = {
 		 	name = "weather_rain",
  		 	gain = 1.5
        },
		["climate_api:particles"] = {
			boxsize = { x = 18, y = 2, z = 18 },
			v_offset = 6,
			expirationtime = 1.6,
			size = 2,
			amount = 15,
			velocity = 6,
			acceleration = 0.05,
			texture = "weather_raindrop.png^[colorize:#000000:70",
			glow = 5
		},
		["climate_api:damage"] = {
			rarity = 1,
			value = 2,
			check = {
				type = "raycast",
				height = 7,
				velocity = 10
			}
		}
	})
	climate_api.register_weather("chemistry:acid_rain_heavy", {
		min_height = -50,
		max_height = 120,
		min_heat = 40,
		min_humidity = 65,
		min_biome_humidity = 26,
		indoors = false,
		has_biome = {"ash_wasteland", "ash_wasteland_ocean"}
	},
	{
		["climate_api:sound"] = {
			name = "weather_rain_heavy",
			gain = 2
        },
		["climate_api:particles"] = {
			boxsize = { x = 18, y = 0, z = 18 },
			v_offset = 7,
			velocity = 7,
			amount = 17,
			expirationtime = 1.2,
			minsize = 25,
			maxsize = 35,
			texture = {
				"weather_rain.png^[colorize:#000000:70",
				"weather_rain.png^[colorize:#000000:70",
				"weather_rain_medium.png^[colorize:#000000:70"
			},
			glow = 5
		},
		["climate_api:damage"] = {
			value = 3,
			check = {
				type = "raycast",
				height = 7,
				velocity = 10
			}
		},
		["climate_api:skybox"] = {
			cloud_data = {
				color = "#5e676eb5"
			},
			priority = 11
		},
		["regional_weather:lightning"] = 1 / 20
	})
end
