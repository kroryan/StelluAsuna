--[[
    X Farming. Extends Luanti farming mod with new plants, crops and ice fishing.
    Copyright (C) 2025 SaKeL

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]

local S = core.get_translator(core.get_current_modname())

local stove_fire_sounds = {}

local function get_grid_matrix_items(grid)
    local grid_matrix = table.copy(grid)
    local _items = {}

    for row, items in ipairs(grid_matrix) do
        for item_pos, item in pairs(items) do
            if item.itemstring ~= '' then
                -- add entity position to item table
                item.ent_pos = item_pos
                table.insert(_items, item)
            end
        end
    end

    return _items
end

local function add_item_to_grid_matrix(grid_matrix, item)
    local result = {}

    for row, items in ipairs(grid_matrix) do
        local found = false

        for item_pos, _item in pairs(items) do
            if _item.itemstring == '' then
                grid_matrix[row][item_pos] = item
                result.added_to_row = row
                result.added_to_pos = item_pos
                found = true
                break
            end
        end

        if found then
            break
        end
    end

    return result
end

local function stop_stove_sound(pos, fadeout_step)
    local hash = core.hash_node_position(pos)
    local sound_ids = stove_fire_sounds[hash]

    if sound_ids then
        for _, sound_id in ipairs(sound_ids) do
            core.sound_fade(sound_id, -1, 0)
        end

        stove_fire_sounds[hash] = nil
    end
end

local function remove_item_from_grid_matrix(grid_matrix, item)
    local result = {}

    for row, items in ipairs(grid_matrix) do
        local found = false

        for item_pos, _item in pairs(items) do
            if _item.itemstring == item.itemstring then
                grid_matrix[row][item_pos] = {
                    itemstring = '',
                    output = {}
                }
                result.removed_from_row = row
                result.removed_from_pos = item_pos
                found = true
                break
            end
        end

        if found then
            break
        end
    end

    return result
end

local function add_item_smoke_particles(pos)
    local particlespawner_def = {
        amount = 5,
        time = 1,
        minpos = vector.new(pos.x - 0.1, pos.y, pos.z - 0.1),
        maxpos = vector.new(pos.x + 0.1, pos.y, pos.z + 0.1),
        minvel = vector.new(-0.1, 0.2, -0.1),
        maxvel = vector.new(0.1, 0.4, 0.1),
        minacc = vector.new(0, 0.1, 0),
        maxacc = vector.new(0, 0.2, 0),
        minexptime = 1,
        maxexptime = 3,
        minsize = 1,
        maxsize = 1.5,
        texture = 'x_farming_stove_item_smoke_particle.png',
        collisiondetection = true
    }

    if core.has_feature({ dynamic_add_media_table = true, particlespawner_tweenable = true }) then
        -- new syntax, after v5.6.0
        particlespawner_def = {
            amount = 5,
            time = 1,
            pos = {
                min = vector.new(pos.x - 0.1, pos.y, pos.z - 0.1),
                max = vector.new(pos.x + 0.1, pos.y, pos.z + 0.1)
            },
            size = {
                min = 1,
                max = 1.5,
            },
            vel = {
                min = vector.new(-0.1, 0.2, -0.1),
                max = vector.new(0.1, 0.4, 0.1)
            },
            acc = {
                min = vector.new(0, 0.1, 0),
                max = vector.new(0, 0.2, 0)
            },
            exptime = {
                min = 1,
                max = 3
            },
            texture = {
                name = 'x_farming_stove_item_smoke_particle.png',
                alpha_tween = {
                    1, 0.5,
                    style = 'fwd',
                    reps = 1
                },
                scale_tween = {
                    { x = 1, y = 1 },
                    { x = 0.5, y = 0.5 },
                }
            },
            collisiondetection = true
        }
    end

    core.add_particlespawner(particlespawner_def)
end

-- Entity

core.register_entity('x_farming:stove_food', {
    initial_properties = {
        visual = 'wielditem',
        visual_size = { x = 0.2, y = 0.2, z = 0.2 },
        physical = false,
        collide_with_objects = false,
        collisionbox = { 0, 0, 0, 0, 0, 0 },
        -- collisionbox = { -0.15, -0.05, -0.15, 0.15, 0.05, 0.15 },
        selectionbox = { 0, 0, 0, 0, 0, 0 },
        -- selectionbox = { -0.15, -0.05, -0.15, 0.15, 0.05, 0.15 },
        pointable = false,
        makes_footstep_sound = false,
        static_save = true,
        shaded = true,
        glow = 4
    },
    on_activate = function(self, staticdata, dtime_s)
        if not self or not staticdata or staticdata == '' then
            self.object:remove()
            return
        end

        local _staticdata = core.deserialize(staticdata)

        for key, value in pairs(_staticdata) do
            self[key] = value
        end

        self._nodechecktimer = 2

        self.object:set_armor_groups({ immortal = 1, stove_food = 1, fleshy = 100 })

        self.object:set_properties({
            wield_item = _staticdata.itemname,
            infotext = _staticdata.itemname,
        })
    end,
    on_step = function(self, dtime, moveresult)
        self._nodechecktimer = self._nodechecktimer - dtime

        if self._nodechecktimer <= 0 then
            self._nodechecktimer = 2
            local pos = self.object:get_pos()
            local node_above = core.get_node(vector.new(pos.x, pos.y + 0.5, pos.z))
            local node_under = core.get_node(vector.new(pos.x, pos.y - 0.5, pos.z))

            -- drop items if above is obstructed or no heat_source below
            if node_above.name ~= 'air'
                or core.get_item_group(node_under.name, 'heat_source') < 1
            then
                local meta = core.get_meta(vector.new(pos.x, pos.y - 0.5, pos.z))
                local grid_matrix = core.deserialize(meta:get_string('grid_matrix'))

                if not grid_matrix then
                    return
                end

                local grid_items = get_grid_matrix_items(grid_matrix)

                -- remove item from stove meta
                for i, value in ipairs(grid_items) do
                    remove_item_from_grid_matrix(grid_matrix, value)
                end

                meta:set_string('grid_matrix', core.serialize(grid_matrix))

                -- remove entity and drop item
                core.add_item(pos, ItemStack({ name = self.itemname }))
                self.object:remove()
                return
            end
        end
    end,
    get_staticdata = function(self)
        local staticdata = {
            itemname = self.itemname
        }
        return core.serialize(staticdata)
    end,
})

-- Nodes
core.register_node('x_farming:stove', {
    description = S('Stove (inactive)'),
    tiles = {
        'x_farming_stove_top.png',
        'x_farming_stove_side.png',
        'x_farming_stove_side.png',
        'x_farming_stove_side.png',
        'x_farming_stove_side.png',
        'x_farming_stove_front.png',
    },
    paramtype2 = '4dir',
    is_ground_content = false,
    groups = {
        -- MTG
        cracky = 2,
        -- MCL
        pickaxey = 1,
        container = 4,
        deco_block = 1,
        material_stone = 1
    },
    _mcl_blast_resistance = 3.5,
    _mcl_hardness = 3.5,
    sounds = x_farming.node_sound_stone_defaults(),
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local infotext = S('Stove inactive.') .. ' ' .. S('Activate by torch or flint and steel.')
        local node = core.get_node(pos)

        local x_shift = -0.6
        local m_pos = vector.new(pos.x - 0.6, pos.y + 0.5, pos.z)
        -- param2 = 0 or 2
        local initial_grid_matrix = {
            [1] = {
                [vector.to_string(vector.new(m_pos.x + (1 * 0.3), m_pos.y, m_pos.z + 0.2))] = {
                    itemstring = '',
                    output = {},
                    cooked_time = 0
                },
                [vector.to_string(vector.new(m_pos.x + (2 * 0.3), m_pos.y, m_pos.z + 0.2))] = {
                    itemstring = '',
                    output = {},
                    cooked_time = 0
                },
                [vector.to_string(vector.new(m_pos.x + (3 * 0.3), m_pos.y, m_pos.z + 0.2))] = {
                    itemstring = '',
                    output = {},
                    cooked_time = 0
                }
            },
            [2] = {
                [vector.to_string(vector.new(m_pos.x + (1 * 0.3), m_pos.y, m_pos.z - 0.2))] = {
                    itemstring = '',
                    output = {},
                    cooked_time = 0
                },
                [vector.to_string(vector.new(m_pos.x + (2 * 0.3), m_pos.y, m_pos.z - 0.2))] = {
                    itemstring = '',
                    output = {},
                    cooked_time = 0
                },
                [vector.to_string(vector.new(m_pos.x + (3 * 0.3), m_pos.y, m_pos.z - 0.2))] = {
                    itemstring = '',
                    output = {},
                    cooked_time = 0
                }
            },
        }

        if node.param2 == 1 or node.param2 == 3 then
            m_pos = vector.new(pos.x, pos.y + 0.5, pos.z + x_shift)

            initial_grid_matrix = {
                [1] = {
                    [vector.to_string(vector.new(m_pos.x + 0.2, m_pos.y, m_pos.z + (1 * 0.3)))] = {
                        itemstring = '',
                        output = {},
                        cooked_time = 0
                    },
                    [vector.to_string(vector.new(m_pos.x + 0.2, m_pos.y, m_pos.z + (2 * 0.3)))] = {
                        itemstring = '',
                        output = {},
                        cooked_time = 0
                    },
                    [vector.to_string(vector.new(m_pos.x + 0.2, m_pos.y, m_pos.z + (3 * 0.3)))] = {
                        itemstring = '',
                        output = {},
                        cooked_time = 0
                    }
                },
                [2] = {
                    [vector.to_string(vector.new(m_pos.x - 0.2, m_pos.y, m_pos.z + (1 * 0.3)))] = {
                        itemstring = '',
                        output = {},
                        cooked_time = 0
                    },
                    [vector.to_string(vector.new(m_pos.x - 0.2, m_pos.y, m_pos.z + (2 * 0.3)))] = {
                        itemstring = '',
                        output = {},
                        cooked_time = 0
                    },
                    [vector.to_string(vector.new(m_pos.x - 0.2, m_pos.y, m_pos.z + (3 * 0.3)))] = {
                        itemstring = '',
                        output = {},
                        cooked_time = 0
                    }
                },
            }
        end

        meta:set_string('grid_matrix', core.serialize(initial_grid_matrix))
        meta:set_string('infotext', infotext)
    end,
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local stack = player:get_wielded_item()
        local stack_name = stack:get_name()

        if core.get_item_group(stack_name, 'torch') > 0
            or stack_name == 'fire:flint_and_steel'
            or stack_name == 'mcl_fire:flint_and_steel'
        then
            local infotext = S('Stove active.') .. ' ' .. S('De-activate with shovel. Stove will de-activate by its self after a while if there are no items to cook.')
            meta:set_string('infotext', infotext)
            core.swap_node(pos, { name = 'x_farming:stove_active', param2 = node.param2 })
            core.get_node_timer(pos):start(1)
        end

        return itemstack
    end,
    on_rotate = function()
        return false
    end
})

-- Active stove
core.register_node('x_farming:stove_active', {
    description = S('Stove active'),
    tiles = {
        {
            name = 'x_farming_stove_top_animated.png',
            animation = {
                type = 'vertical_frames',
                aspect_w = 16,
                aspect_h = 16,
                length = 5
            },
        },
        'x_farming_stove_side.png',
        'x_farming_stove_side.png',
        'x_farming_stove_side.png',
        'x_farming_stove_side.png',
        {
            name = 'x_farming_stove_front_animated.png',
            animation = {
                type = 'vertical_frames',
                aspect_w = 16,
                aspect_h = 16,
                length = 2
            },
        },
    },
    paramtype2 = '4dir',
    is_ground_content = false,
    groups = {
        -- MTG
        cracky = 2,
        heat_source = 1,
        not_in_creative_inventory = 1,
        -- MCL
        pickaxey = 1,
        container = 4,
        deco_block = 1,
        material_stone = 1
    },
    _mcl_blast_resistance = 3.5,
    _mcl_hardness = 3.5,
    sounds = x_farming.node_sound_stone_defaults(),
    light_source = 8,
    drop = 'x_farming:stove',
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local infotext = S('Stove active.') .. ' ' .. S('De-activate with shovel. Stove will de-activate by its self after a while if there are no items to cook.')

        meta:set_string('infotext', infotext)
    end,
    on_timer = function(pos, elapsed)
        local meta = core.get_meta(pos)
        local grid_matrix = core.deserialize(meta:get_string('grid_matrix'))

        if not grid_matrix then
            return
        end

        local timer_elapsed = meta:get_int('timer_elapsed') or 0
        meta:set_int('timer_elapsed', timer_elapsed + 1)

        -- total running time without items to cook
        local total_running_time = meta:get_float('total_running_time') or 0
        local grid_items = get_grid_matrix_items(grid_matrix)

        if #grid_items == 0 then
            total_running_time = total_running_time + elapsed
        elseif total_running_time > 0 then
            -- reset time when added another item to cook
            total_running_time = 0
        end

        if total_running_time > 180 then
            -- extinguish stove
            total_running_time = 0
            meta:set_float('total_running_time', total_running_time)

            local node = core.get_node(pos)
            core.swap_node(pos, { name = 'x_farming:stove', param2 = node.param2 })
            meta:set_int('timer_elapsed', 0)
            local infotext = S('Stove inactive.') .. ' ' .. S('Activate by torch or flint and steel.')
            meta:set_string('infotext', infotext)
            stop_stove_sound(pos)

            return false
        end

        -- play sound
        if timer_elapsed == 0 or (timer_elapsed + 1) % 5 == 0 then
            local sound_id = core.sound_play('x_farming_stove_active', { pos = pos, max_hear_distance = 16, gain = 0.25 })
            local hash = core.hash_node_position(pos)

            stove_fire_sounds[hash] = stove_fire_sounds[hash] or {}
            table.insert(stove_fire_sounds[hash], sound_id)

            -- Only remember the 3 last sound handles
            if #stove_fire_sounds[hash] > 3 then
                table.remove(stove_fire_sounds[hash], 1)
            end

            -- Remove the sound ID automatically from table after 11 seconds
            core.after(11, function()
                if not stove_fire_sounds[hash] then
                    return
                end

                for f = #stove_fire_sounds[hash], 1, -1 do
                    if stove_fire_sounds[hash][f] == sound_id then
                        table.remove(stove_fire_sounds[hash], f)
                    end
                end

                if #stove_fire_sounds[hash] == 0 then
                    stove_fire_sounds[hash] = nil
                end
            end)
        end

        -- cook items, update cooked times
        -- if cooked drop items and remove from meta
        for row, items in ipairs(grid_matrix) do
            for item_pos, item in pairs(items) do
                if item.itemstring ~= '' then
                    grid_matrix[row][item_pos].cooked_time = (grid_matrix[row][item_pos].cooked_time or 0) + elapsed

                    -- drop cooked item and remove from meta
                    if grid_matrix[row][item_pos].cooked_time > item.output.time then
                        -- drop cooked item
                        core.add_item(vector.from_string(item_pos), ItemStack(item.output.item))

                        -- drop recipe replacements
                        for _, replacement in ipairs(item.output.replacements) do
                            core.add_item(vector.from_string(item_pos), ItemStack(replacement))
                        end

                        -- remove from metadata
                        local removed_items_result = remove_item_from_grid_matrix(grid_matrix, item)

                        if removed_items_result.removed_from_pos then
                            -- remove entity
                            for _, o in ipairs(core.get_objects_inside_radius(pos, 0.7)) do
                                local armor_groups = o:get_armor_groups() or {}

                                if armor_groups.stove_food and armor_groups.stove_food > 0 then
                                    if o:get_pos() and vector.to_string(vector.new(o:get_pos())) == removed_items_result.removed_from_pos then
                                        o:remove()
                                        break
                                    end
                                end
                            end
                        end

                        -- Play cooling sound
                        core.sound_play('x_farming_stove_sizzle', {
                            pos = vector.from_string(item_pos),
                            max_hear_distance = 16,
                            gain = 0.07
                        }, true)
                    else
                        add_item_smoke_particles(vector.from_string(item_pos))
                    end

                    -- restore entity items after `clearobjects`
                    local missing_items = table.copy(items)

                    for _, obj in ipairs(core.get_objects_inside_radius(pos, 0.7)) do
                        local armor_groups = obj:get_armor_groups() or {}

                        if armor_groups.stove_food and armor_groups.stove_food > 0 then
                            local lua_ent = obj:get_luaentity()

                            if lua_ent and obj:get_pos() then
                                -- match entity with metadata
                                -- removing the one we found and leaving
                                -- only the ones what needs to be restored
                                for ent_pos, value in pairs(missing_items) do
                                    local obj_pos = vector.to_string(vector.new(obj:get_pos()))

                                    if obj_pos == ent_pos then
                                        missing_items[obj_pos] = nil
                                        break
                                    end
                                end
                            end
                        end
                    end

                    for ent_pos, value in pairs(missing_items) do
                        if value.itemstring ~= '' then
                            local staticdata = {
                                itemname = value.itemstring
                            }

                            local obj = core.add_entity(
                                vector.from_string(ent_pos),
                                'x_farming:stove_food',
                                core.serialize(staticdata)
                            )

                            if obj then
                                obj:set_rotation(vector.from_string(value.ent_rot))
                            end
                        end
                    end
                end
            end
        end

        -- set meta
        meta:set_string('grid_matrix', core.serialize(grid_matrix))
        meta:set_float('total_running_time', total_running_time)

        return true
    end,
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local wield_stack = player:get_wielded_item()
        local wield_stack_name = wield_stack:get_name()

        -- de-activate stove
        if core.get_item_group(wield_stack_name, 'shovel') > 0 then
            core.swap_node(pos, { name = 'x_farming:stove', param2 = node.param2 })
            meta:set_int('timer_elapsed', 0)
            local infotext = S('Stove inactive.') .. ' ' .. S('Activate by torch or flint and steel.')
            meta:set_string('infotext', infotext)
            stop_stove_sound(pos)
        end

        -- check if item is cook-able
        local output = core.get_craft_result({
            method = 'cooking',
            width = 1,
            items = { itemstack }
        })

        if output.item:is_empty() then
            -- item is not cook-able
            return itemstack
        end

        -- check if space above
        if core.get_node(vector.new(pos.x, pos.y + 1, pos.z)).name ~= 'air' then
            return itemstack
        end

        local grid_matrix = core.deserialize(meta:get_string('grid_matrix'))
        local grid_items = get_grid_matrix_items(grid_matrix)

        if #grid_items >= 6 then
            -- stove is full
            return itemstack
        end

        local _output = {
            time = output.time,
            replacements = {},
            item = output.item:to_table()
        }

        for _, value in ipairs(output.replacements) do
            table.insert(_output.replacements, value:to_table())
        end

        -- degrees to radians
        local pitch = -90 * (math.pi / 180)
        local roll = math.pi * 2 + node.param2 * math.pi / 2

        -- x = pitch (elevation), y = yaw (heading), z = roll (bank)
        local ent_rot = vector.new(pitch, 0, roll)
        local added_item_result = add_item_to_grid_matrix(grid_matrix, {
            itemstring = wield_stack_name,
            output = _output,
            ent_rot = vector.to_string(ent_rot),
            cooked_time = 0
        })

        if not (added_item_result.added_to_row and added_item_result.added_to_pos) then
            return itemstack
        end

        local ent_pos = vector.from_string(added_item_result.added_to_pos)

        if not ent_pos then
            return itemstack
        end

        -- Add Entity
        local staticdata = {
            itemname = wield_stack_name
        }

        local obj = core.add_entity(
            ent_pos,
            'x_farming:stove_food',
            core.serialize(staticdata)
        )

        if obj then
            -- 90 degress to radians
            obj:set_rotation(ent_rot)
        end

        -- Play cooling sound
        core.sound_play('x_farming_stove_sizzle_put', {
            pos = ent_pos,
            max_hear_distance = 16,
            gain = 0.1
        }, true)

        meta:set_string('grid_matrix', core.serialize(grid_matrix))
        itemstack:take_item()

        return itemstack
    end,
    on_destruct = function(pos)
        stop_stove_sound(pos)
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        if not oldmetadata.fields.grid_matrix then
            return
        end

        local objs = core.get_objects_inside_radius(pos, 0.7)
        local grid_matrix = core.deserialize(oldmetadata.fields.grid_matrix)
        local grid_items = get_grid_matrix_items(grid_matrix)

        -- remove entitites
        for _, obj in ipairs(objs) do
            local armor_groups = obj:get_armor_groups() or {}

            if armor_groups.stove_food and armor_groups.stove_food > 0 then
                obj:remove()
            end
        end

        -- drop items
        for _, item in ipairs(grid_items) do
            core.add_item(vector.new(pos.x, pos.y + 0.7, pos.z), ItemStack(item.itemstring))
        end
    end,
    on_rotate = function()
        return false
    end
})
