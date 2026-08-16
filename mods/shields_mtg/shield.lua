-- Tablas para guardar las entidades visuales y los estados de animación de cada jugador
local player_shield_entities = {}
local player_shield_states = {}
local shield_cooldowns = {} -- Tabla para controlar el retraso al recibir cualquier ataque

-- Función de interpolación lineal (Lerp) para movimiento fluido
local function lerp(a, b, t)
    return a + (b - a) * math.min(t, 1)
end

----------------------------------------------------
-- 1. REGISTRO DE LA ENTIDAD VISUAL DEL ESCUDO
----------------------------------------------------
minetest.register_entity("shields_mtg:shield_entity", {
    initial_properties = {
        physical = false,
        visual = "mesh",
        mesh = "shield.obj",
        textures = {"shield.png"},
        
        -- Escala visual del modelo
        visual_size = {x = 10, y = 10, z = 10},
        
        backface_culling = false,
        collisionbox = {0, 0, 0, 0, 0, 0},
        pointable = false,
        static_save = false,
    },
    on_step = function(self, dtime)
        if not self.object:get_attach() then
            self.object:remove()
        end
    end
})

----------------------------------------------------
-- 2. REGISTRO DEL ÍTEM / HERRAMIENTA
----------------------------------------------------
minetest.register_tool("shields_mtg:shield", {
    description = "Shield",
    inventory_image = "shield_inv.png",
    wield_image = "blank.png",   -- Textura transparente en mano (usamos la entidad visual)
    
    tool_capabilities = {
        full_punch_interval = 2.0,
        max_drop_level = 0,
        groupcaps = {},
        damage_groups = {fleshy = 0},
    },
    
    on_use = function(itemstack, user, pointed_thing)
        return itemstack
    end,
    on_secondary_use = function(itemstack, user, pointed_thing)
        return itemstack
    end,

    -- 📦 AL TIRAR EL ÍTEM AL SUELO (Teclas Q o Soltar)
    on_drop = function(itemstack, dropper, pos)
        if not dropper then return itemstack end
        
        local p_pos = dropper:get_pos()
        local dir = dropper:get_look_dir()
        
        -- Posición justo en frente del jugador
        local drop_pos = {
            x = p_pos.x + dir.x * 1.2,
            y = p_pos.y + 1.2 + dir.y * 1.2,
            z = p_pos.z + dir.z * 1.2
        }
        
        -- Spawnea la entidad de ítem tirado
        local obj = minetest.add_item(drop_pos, itemstack)
        if obj then
            -- Le da un impulso físico hacia adelante
            obj:set_velocity({
                x = dir.x * 2,
                y = dir.y * 2 + 1.5,
                z = dir.z * 2
            })
            
            -- Cambia su representación en el suelo a MODELO 3D
            obj:set_properties({
                visual = "mesh",
                mesh = "shield.obj",
                textures = {"shield.png"},
                visual_size = {x = 3, y = 3, z = 3}, -- Ajusta el tamaño en el piso si lo ves muy grande/chico
            })
        end
        
        return ItemStack("") -- Vacía la mano del jugador
    end,
})

----------------------------------------------------
-- 3. RECETA DE CRAFTEO
----------------------------------------------------
minetest.register_craft({
    output = "shields_mtg:shield",
    recipe = {
        {"group:wood", "default:steel_ingot", "group:wood"},
        {"group:wood", "group:wood",          "group:wood"},
        {"",           "group:wood",          ""}
    }
})

----------------------------------------------------
-- 4. INTEGRACIÓN CON SFINV Y CASILLA DE EQUIPAMIENTO
----------------------------------------------------

-- Crear la casilla en el inventario del jugador
minetest.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    if inv then
        inv:set_size("shield_slot", 1)
    end
end)

-- Validar que solo se puedan colocar escudos en la casilla "shield_slot"
minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
    if action == "put" and inventory_info.listname == "shield_slot" then
        if inventory_info.stack:get_name() == "shields_mtg:shield" then
            return inventory_info.stack:get_count()
        end
        return 0
    elseif action == "move" and inventory_info.to_list == "shield_slot" then
        local stack = inventory:get_stack(inventory_info.from_list, inventory_info.from_index)
        if stack:get_name() == "shields_mtg:shield" then
            return inventory_info.count
        end
        return 0
    end
end)

-- Registro de la pestaña en sfinv
if minetest.get_modpath("sfinv") and sfinv then
    sfinv.register_page("shields_mtg:shield_page", {
        title = "shield",
        get = function(self, player, context)
            local formspec = "label[2.8,0.7;shield equip]" ..
                             "list[current_player;shield_slot;3.5,1.2;1,1;]" ..
                             "listring[current_player;shield_slot]" ..
                             "listring[current_player;main]"
            return sfinv.make_formspec(player, context, formspec, true)
        end,
    })
end

-- Función auxiliar para verificar si el jugador tiene un escudo equipado o en mano
local function has_shield_equipped(player)
    local inv = player:get_inventory()
    if inv then
        local stack = inv:get_stack("shield_slot", 1)
        if stack and not stack:is_empty() and stack:get_name() == "shields_mtg:shield" then
            return true
        end
    end
    
    -- También permite usarlo si lo lleva directamente en la mano
    if player:get_wielded_item():get_name() == "shields_mtg:shield" then
        return true
    end
    
    return false
end

-- Función auxiliar para aplicar desgaste/durabilidad al escudo (337 puntos totales)
local function damage_shield(player, damage_amount)
    local inv = player:get_inventory()
    
    -- 65535 es el desgaste máximo en Minetest.
    -- (65535 / 337) ≈ 195 de desgaste por cada punto de daño bloqueado.
    local points_lost = math.max(1, damage_amount or 1)
    local wear_to_add = math.ceil(65535 / 337) * points_lost

    -- 1. Buscar primero en la casilla de equipamiento de sfinv
    if inv then
        local stack = inv:get_stack("shield_slot", 1)
        if stack and not stack:is_empty() and stack:get_name() == "shields_mtg:shield" then
            stack:add_wear(wear_to_add)
            
            if stack:is_empty() or stack:get_count() == 0 then
                minetest.sound_play("default_tool_breaks", {
                    pos = player:get_pos(),
                    gain = 1.0,
                    max_hear_distance = 12
                }, true)
            end
            
            inv:set_stack("shield_slot", 1, stack)
            return
        end
    end

    -- 2. Si no está en la casilla especial, buscar en la mano activa
    local stack = player:get_wielded_item()
    if stack and stack:get_name() == "shields_mtg:shield" then
        stack:add_wear(wear_to_add)
        
        if stack:is_empty() or stack:get_count() == 0 then
            minetest.sound_play("default_tool_breaks", {
                pos = player:get_pos(),
                gain = 1.0,
                max_hear_distance = 12
            }, true)
        end
        
        player:set_wielded_item(stack)
    end
end

----------------------------------------------------
-- 5. BUCLE GLOBALSTEP (MOVIMIENTO Y ROTACIÓN FLUIDA)
----------------------------------------------------
minetest.register_globalstep(function(dtime)
    local current_time = minetest.get_us_time() / 1000000

    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()

        -- Verificar si el jugador tiene el escudo equipado (Ranura o Mano)
        if has_shield_equipped(player) then
            
            -- Crear la entidad si aún no existe
            if not player_shield_entities[name] or not player_shield_entities[name]:get_pos() then
                local ent = minetest.add_entity(player:get_pos(), "shields_mtg:shield_entity")
                if ent then
                    player_shield_entities[name] = ent
                end
            end

            local pitch = player:get_look_vertical()
            local pitch_deg = (pitch / math.pi) * 180

            -- Inicializar estado de animación si no existe
            if not player_shield_states[name] then
                player_shield_states[name] = {
                    x = -4,
                    y_offset = -5.5,
                    z = 4.5,
                    rot_x = 0,
                    rot_y = -15
                }
            end

            local shield_model = player_shield_entities[name]
            local state = player_shield_states[name]

            if shield_model and state then
                local eye_height = player:get_properties().eye_height or 1.47
                local controls = player:get_player_control()
                
                local target_x, target_y_off, target_z, target_rot_x, target_rot_y

                -- Comprobar si está en cooldown por recibir un ataque
                local in_cooldown = shield_cooldowns[name] and current_time < shield_cooldowns[name]

                -- SOLO rota/bloquea si presiona RMB y NO está en cooldown
                if controls.RMB and not in_cooldown then
                    -- 🛡️ OBJETIVO: Bloqueo (Suavizado hacia el frente)
                    target_x = -3
                    target_y_off = -3.5
                    target_z = 4.5
                    target_rot_x = pitch_deg
                    target_rot_y = 0
                else
                    -- 🗡️ OBJETIVO: Reposo (Suavizado hacia abajo y de lado)
                    target_x = -4
                    target_y_off = -5.5
                    target_z = 4.5
                    target_rot_x = 0
                    target_rot_y = -15
                end

                -- Velocidad de interpolación ajustada (un poco más orgánica y fluida)
                local speed = 12 * dtime

                -- Transiciones suaves (Lerp)
                state.x = lerp(state.x, target_x, speed)
                state.y_offset = lerp(state.y_offset, target_y_off, speed)
                state.z = lerp(state.z, target_z, speed)
                state.rot_x = lerp(state.rot_x, target_rot_x, speed)
                state.rot_y = lerp(state.rot_y, target_rot_y, speed)

                -- Aplicar transformaciones al modelo
                shield_model:set_attach(
                    player,
                    "",
                    {
                        x = state.x,
                        y = (eye_height * 10) + state.y_offset,
                        z = state.z
                    },
                    {
                        x = state.rot_x,
                        y = state.rot_y,
                        z = 0
                    },
                    true
                )
            end
        else
            -- Si ya no tiene escudo equipado, eliminamos el modelo 3D
            if player_shield_entities[name] then
                player_shield_entities[name]:remove()
                player_shield_entities[name] = nil
            end
            player_shield_states[name] = nil
        end
    end
end)

-- Limpieza al desconectarse
minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    if player_shield_entities[name] then
        player_shield_entities[name]:remove()
        player_shield_entities[name] = nil
    end
    player_shield_states[name] = nil
    shield_cooldowns[name] = nil
end)

----------------------------------------------------
-- 6. SISTEMA DE BLOQUEO DIRECCIONAL, SONIDOS Y DURABILIDAD
----------------------------------------------------
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    if player then
        local controls = player:get_player_control()
        local name = player:get_player_name()
        local current_time = minetest.get_us_time() / 1000000

        -- Verificar si está en cooldown por un golpe reciente
        if shield_cooldowns[name] and current_time < shield_cooldowns[name] then
            return false
        end
        
        -- Verificar si tiene el escudo equipado Y está cubriéndose con Clic Derecho
        if has_shield_equipped(player) and controls.RMB then
            
            -- COMPROBACIÓN DE ÁNGULO (Solo bloquear desde el frente)
            if hitter then
                local p_pos = player:get_pos()
                local h_pos = hitter:get_pos()
                
                if p_pos and h_pos then
                    -- Vector 2D desde el jugador defensivo hacia el atacante
                    local dx = h_pos.x - p_pos.x
                    local dz = h_pos.z - p_pos.z
                    local len = math.sqrt(dx * dx + dz * dz)
                    
                    if len > 0 then
                        dx = dx / len
                        dz = dz / len
                        
                        -- Vector 2D hacia donde mira el jugador defensivo
                        local look_dir = player:get_look_dir()
                        local look_len = math.sqrt(look_dir.x * look_dir.x + look_dir.z * look_dir.z)
                        
                        if look_len > 0 then
                            local lx = look_dir.x / look_len
                            local lz = look_dir.z / look_len
                            
                            -- Producto punto: mide qué tan enfrentados están ambos vectores
                            local dot = (dx * lx) + (dz * lz)
                            
                            -- dot < 0.3 implica que el ataque está fuera del cono frontal (~140°)
                            if dot < 0.3 then
                                -- El ataque fue por los lados o la espalda, activa el cooldown de 0.25s
                                shield_cooldowns[name] = current_time + 0.25
                                return false -- Recibe daño
                            end
                        end
                    end
                end
            end

            -- Si pasa la prueba de ángulo, se bloquea el daño y aplica el cooldown de 0.25s
            shield_cooldowns[name] = current_time + 0.25
            local pos = player:get_pos()
            
            -- Sonido 1: Impacto de madera
            minetest.sound_play("default_wood_footstep", {
                pos = pos,
                max_hear_distance = 12,
                gain = 0.8,
            }, true)
            
            -- Sonido 2: Impacto metálico
            minetest.sound_play("default_metal_footstep", {
                pos = pos,
                max_hear_distance = 12,
                gain = 0.6,
            }, true)
            
            -- Descontar durabilidad (337 usos en total)
            local actual_damage = damage or 1
            damage_shield(player, actual_damage)
            
            return true -- Anula el daño recibido por el frente
        end
    end
    return false
end)
