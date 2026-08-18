local NORTH = vector.new(0, 0, -1)
local UP = vector.new(0, 1, 0)

--Skybox planet/star entity
minetest.register_entity("stl_core:skybox", {
    initial_properties = {
        visual = "mesh",
        visual_size = {x=100, y=100, z=32000},
        mesh = "skybox.obj",
        textures = {"blank.png"},
        use_texture_alpha = true,
        glow = -1,
        static_save = false,
        pointable = false
    },
    on_activate = function (self, staticdata)
        self.player = minetest.get_player_by_name(staticdata)
    end,
    set_star = function (self, i)
        self.star = i
        self.object:set_properties({textures={"sun.png"}})
    end,
    set_planet = function (self, i)
        self.planet = i
        self.object:set_properties({textures={stellua.planets[i].icon}})
    end,
    on_step = function (self)
        if not self.player:is_valid() then self.object:remove() return end
        local pos = self.player:get_pos()
        pos.y = pos.y+self.player:get_properties().eye_height
        if vector.distance(self.object:get_pos(), pos) > 90 then self.object:remove() return end

        local index = stellua.get_planet_index(pos.y)
        local slot = stellua.get_slot_index(pos)
        local current_star, current_pos, fog_dist, rot
        if index then
            local planet = stellua.planets[index]
            current_star, current_pos = planet.star, planet.pos
            fog_dist = planet.fog_dist
        elseif slot then
            current_star, current_pos, rot = stellua.get_slot_info(slot)
            fog_dist = 180
        else self.object:remove() return end
        if not current_star then self.object:remove() return end

        local dir, sf
        if self.planet then
            dir = stellua.planets[self.planet].pos-current_pos
            sf = 0.1*stellua.planets[self.planet].scale/vector.distance(stellua.planets[self.planet].pos, current_pos)
        elseif self.star == current_star then
            dir = UP
            sf = 0.1*stellua.stars[self.star].scale
        else
            dir = stellua.stars[self.star].pos-stellua.stars[current_star].pos
            sf = 0.005
        end

        if index then
            rot = vector.dir_to_rotation(vector.rotate_around_axis(dir, NORTH, (minetest.get_timeofday()+0.5)*2*math.pi))
        else
            rot = vector.dir_to_rotation(vector.rotate(dir, rot))
        end

        self.object:set_pos(pos)
        self.object:set_velocity(self.player:get_velocity())
        self.object:set_rotation(rot)
        local dist = 160*(fog_dist-10)
        local scale = dist*sf
        self.object:set_properties({visual_size={x=scale, y=scale, z=dist-scale*0.5}})
    end
})

-- Keep presentation and realm physics authoritative here. Updating these
-- every engine tick caused needless client traffic and fought other physics
-- providers while a vehicle was being controlled.
local realm_states = {}
local realm_timer = 0

local function set_realm_physics(player, attribute, id, value)
	playerphysics.add_physics_factor(player, attribute, id, value)
end

local function clear_realm_physics(player, attribute, id)
	playerphysics.remove_physics_factor(player, attribute, id)
end

local function apply_homeworld(player, state)
	if state.realm_key == "home" then return end
	player:set_sky({type="regular", clouds=true})
	player:set_sun({visible=true, sunrise_visible=true, scale=1})
	player:set_moon({visible=true})
	player:set_stars({visible=true})
	player:set_clouds({height=120})
	clear_realm_physics(player, "gravity", "stl_core:realm_gravity")
	clear_realm_physics(player, "speed", "stl_core:realm_speed")
	stellua.set_space_armor(player, false)
	state.realm_key = "home"
	state.physics_key = "home"
end

minetest.register_globalstep(function(dtime)
	realm_timer = realm_timer + dtime
	if realm_timer < 0.2 then return end
	realm_timer = 0

	for _, player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local state = realm_states[name] or {}
		realm_states[name] = state
		local player_pos = player:get_pos()
		local index = stellua.get_planet_index(player_pos.y)
		local slot = stellua.get_slot_index(player_pos)

		if not index and not slot then
			apply_homeworld(player, state)
		else
			local sky_pos = vector.add(player_pos, {x=0, y=player:get_properties().eye_height, z=0})
			local current_star
			local realm_key
			local physics_key
			if not index then
				current_star = slot and stellua.get_slot_info(slot)
				realm_key = "slot:" .. tostring(slot)
				physics_key = "space"
			else
				local planet = stellua.planets[index]
				local height = math.min(math.max(((planet.water_level or planet.level)-sky_pos.y)*0.004+1, 0), 1)
				current_star = planet.star
				realm_key = "planet:" .. tostring(index) .. ":" .. tostring(math.floor(height * 20))
				physics_key = "planet:" .. tostring(index)
				if state.realm_key ~= realm_key then
					player:set_sky(planet.sky(minetest.get_timeofday(), height))
					player:set_sun(planet.sun)
					player:set_stars(planet.stars(height))
					player:set_clouds({height=(planet.water_level or planet.level)+120})
				end
			end

			if not index and state.realm_key ~= realm_key then
				player:set_sky({type="plain", base_color="#000000", clouds=false})
				player:set_sun({visible=false})
				player:set_stars({day_opacity=1})
			end

			if state.physics_key ~= physics_key then
				if index then
					local planet = stellua.planets[index]
					set_realm_physics(player, "gravity", "stl_core:realm_gravity", planet.gravity)
					set_realm_physics(player, "speed", "stl_core:realm_speed", planet.walk_speed)
				else
					set_realm_physics(player, "gravity", "stl_core:realm_gravity", 0.001)
					set_realm_physics(player, "speed", "stl_core:realm_speed", 1)
				end
				stellua.set_space_armor(player, true)
				state.physics_key = physics_key
			end

			local has_skybox = false
			for _, obj in ipairs(minetest.get_objects_inside_radius(sky_pos, 100)) do
				local entity = obj:get_luaentity()
				if entity and entity.name == "stl_core:skybox" and entity.player == player then
					has_skybox = true
					break
				end
			end
			if not has_skybox then
				for i in ipairs(stellua.stars) do
					if i ~= current_star or not index then
						local obj = minetest.add_entity(sky_pos, "stl_core:skybox", name)
						if obj then obj:get_luaentity():set_star(i) end
					end
				end
				if current_star then
					for _, i in ipairs(stellua.stars[current_star].planets) do
						if i ~= index then
							local obj = minetest.add_entity(sky_pos, "stl_core:skybox", name)
							if obj then obj:get_luaentity():set_planet(i) end
						end
					end
				end
			end
			state.realm_key = realm_key
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	if player:get_pos().y < (stellua.hybrid_space_min or 6368) then return end
    player:set_sun({sunrise_visible=false})
    player:set_moon({visible=false})
    player:set_stars({star_color = "#ebebff20"})
    player:set_lighting({shadows={intensity=0.5}, volumetric_light={strength=0.1}})
end)

minetest.register_on_leaveplayer(function(player)
	realm_states[player:get_player_name()] = nil
end)
