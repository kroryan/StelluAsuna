--HUDs for temperature
local heat_huds, cold_huds, vignette_huds, vignette_ops = {}, {}, {}, {}

local function add_temperature_huds(player)
    local playername = player:get_player_name()
    if heat_huds[playername] and cold_huds[playername] then return end
    heat_huds[playername] = player:hud_add({
        type = "statbar",
        z_index = 0,
        position = {x=0.5, y=1},
        alignment = {x=1, y=0},
        offset = {x=-265, y=-115},
        text = "stl_weather_hud_heat.png",
        text2 = "stl_weather_hud_heat_gone.png",
        number = 0,
        item = 0
    })
    cold_huds[playername] = player:hud_add({
        type = "statbar",
        z_index = 0,
        position = {x=0.5, y=1},
        alignment = {x=1, y=0},
        offset = {x=-265, y=-115},
        text = "stl_weather_hud_cold.png",
        text2 = "stl_weather_hud_cold_gone.png",
        number = 0,
        item = 0
    })
end

minetest.register_on_joinplayer(function(player)
    -- The Asuna homeworld is intrinsically safe; clear temperature left by a
    -- previous visit to space before any globalstep can deal damage.
    if player:get_pos().y < (stellua.hybrid_space_min or 6368) then
        player:get_meta():set_float("temp", 0)
    end
    local immortal = player:get_armor_groups().immortal
    if immortal and immortal > 0 then return end
    add_temperature_huds(player)
end)

--Get temperature at position for the player's purposes
function stellua.get_temperature(pos)
    -- Asuna is the inhabited homeworld. Its normal biomes, caves and houses
    -- never apply Stellua's survival-temperature damage.
    if pos.y < (stellua.hybrid_space_min or 6368) then
        return 300 + (stellua.get_season_temperature_modifier and stellua.get_season_temperature_modifier() or 0)
    end

    --always room temperature inside vehicles, at least for now
    if stellua.assemble_vehicle(pos, true) then return 300 end

    --absolute zero in the vastness of space because I say so
    local index = stellua.get_planet_index(pos.y)
    if not index then return 0 end

    -- Planets with a breathable atmosphere and established life are treated
    -- as habitable rather than forcing thermal survival gear everywhere.
    local planet = stellua.planets[index]
    if planet.life_stat > 0.5 and planet.atmo_stat >= 0.5 and planet.atmo_stat <= 2 then
        return 300
    end

    -- Any solid cover within twelve nodes represents a cave, base or ship
    -- shelter and normalises the local temperature.
    for y = 2, 12 do
        local node = minetest.get_node_or_nil({x=pos.x, y=pos.y+y, z=pos.z})
        local def = node and minetest.registered_nodes[node.name]
        if def and def.walkable then return 300 end
    end

    --base temperature is the planet's heat stat, altered by height
    local out = stellua.planets[index].heat_stat*((500-pos.y)%1000)*0.002

    --if in weather then it gets modified by that
    local weather = stellua.get_weather(index)
    if weather and weather ~= "" then
        out = stellua.registered_weathers[weather].temp(out)
    end

    --if in a liquid then it tends towards that liquid's preferred temperature
    local defs = minetest.registered_nodes[minetest.get_node(pos).name]
    if defs and defs.temp then out = (out+defs.temp)*0.5 end

    --insert any other temperature modifying things here (nearby nodes perhaps?)

    return out
end

--Make player temperature increase or decrease depending on the planet
local elapsed = {}

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local immortal = player:get_armor_groups().immortal
        local playername = player:get_player_name()
        local meta = player:get_meta()

        --change player temperature
        local playertemp = meta:get_float("temp")
        local temp = player:get_attach() and 300 or stellua.get_temperature(vector.round(player:get_pos()))
        if temp < 270 or temp > 330 then
            -- Cold specifically builds up player temp at a fraction of the
            -- rate heat does, so players have much more tolerance before
            -- taking cold damage (heat is unaffected).
            local cold_tolerance_factor = 1
            if temp < 300 then
                -- Cold remains a slow hazard only in exposed, genuinely
                -- hostile Stellua environments.
                cold_tolerance_factor = 0.05
            end
            playertemp = math.min(math.max(playertemp+dtime*math.sign(temp-300)*((temp-300)*0.005)^2*cold_tolerance_factor, -20), 20)
        else
            playertemp = math.sign(playertemp)*math.max(math.abs(playertemp)-dtime*0.5, 0)
        end
        meta:set_float("temp", playertemp)

        if not immortal or immortal == 0 then
            --update HUDs
            add_temperature_huds(player)
            player:hud_change(heat_huds[playername], "item", playertemp > 0 and 20 or 0)
            player:hud_change(cold_huds[playername], "item", playertemp < 0 and 20 or 0)
            player:hud_change(heat_huds[playername], "number", playertemp > 0 and playertemp or 0)
            player:hud_change(cold_huds[playername], "number", playertemp < 0 and -playertemp or 0)
            local op = meta:get_int("vignette_op")
            local vtype = meta:get_string("vignette_type")

            --deal damage if too hot or cold
            if playertemp <= -20 or playertemp >= 20 then
                elapsed[playername] = (elapsed[playername] or 0)+dtime
                -- Cold damage ticks every 6s instead of 2s (a third the DPS
                -- of heat), on top of the slower cold buildup above.
                local damage_interval = playertemp < 0 and 30 or 2
                while elapsed[playername] > damage_interval do
                    elapsed[playername] = elapsed[playername]-damage_interval
                    player:set_hp(player:get_hp()-1)
                end

                --show this with a vignette
                if not vignette_huds[playername] then
                    vtype = playertemp < 0 and "cold" or "heat"
                    vignette_huds[playername] = player:hud_add({
                        type = "image",
                        scale = {x=-100, y=-100},
                        text = "stl_weather_vignette_"..vtype..".png^[opacity:0",
                        position = {x=0.5, y=0.5},
                        alignment = {x=0, y=0},
                        offset = {x=0, y=0},
                        z_index = -400
                    })
                    op = 0
                elseif op < 255 then
                    op = op+1
                    player:hud_change(vignette_huds[playername], "text", "stl_weather_vignette_"..vtype..".png^[opacity:"..op)
                end
            elseif op > 0 and vignette_huds[playername] then
                op = op-1
                player:hud_change(vignette_huds[playername], "text", "stl_weather_vignette_"..vtype..".png^[opacity:"..op)
            elseif op > 0 then
                -- HUD ids are connection-local, while the opacity metadata
                -- survives reconnects. Reset stale state instead of passing
                -- nil to hud_change and taking down the whole server.
                op = 0
            elseif vignette_huds[playername] then
                player:hud_remove(vignette_huds[playername])
                vignette_huds[playername] = nil
            end
            meta:set_int("vignette_op", op)
            meta:set_string("vignette_type", vtype)
        elseif vignette_huds[playername] then
            player:hud_remove(vignette_huds[playername])
            vignette_huds[playername] = nil
        end
    end
end)

--Restore temperature upon respawning
minetest.register_on_respawnplayer(function(player)
    local meta = player:get_meta()
    meta:set_float("temp", 0)
	meta:set_int("vignette_op", 0)
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	heat_huds[name] = nil
	cold_huds[name] = nil
	vignette_huds[name] = nil
	elapsed[name] = nil
end)
