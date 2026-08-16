---@diagnostic disable
--[[
    X Enchanting. Adds Enchanting Mechanics and API.
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

----
--- Table Node
----

core.register_node('x_enchanting:table', {
    description = S('Enchanting Table'),
    short_description = S('Enchanting Table'),
    drawtype = 'mesh',
    mesh = 'x_enchanting_table.obj',
    tiles = { 'x_enchanting_table.png' },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    paramtype2 = 'facedir',
    walkable = true,
    wield_scale = { x = 2, y = 2, z = 2 },
    selection_box = {
        type = 'fixed',
        fixed = { -1 / 2, -1 / 2, -1 / 2, 1 / 2, 1 / 2 - 4 / 16, 1 / 2 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -1 / 2, -1 / 2, -1 / 2, 1 / 2, 1 / 2 - 4 / 16, 1 / 2 }
    },
    sounds = {
        footstep = {
            name = 'x_enchanting_scroll',
            gain = 0.2
        },
        dug = {
            name = 'x_enchanting_scroll',
            gain = 1.0
        },
        place = {
            name = 'x_enchanting_scroll',
            gain = 1.0
        }
    },
    is_ground_content = false,
    groups = { cracky = 1, level = 2 },
    stack_max = 1,
    mod_origin = 'x_enchanting',
    light_source = 6,
    ---@param pos Vector
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()

        meta:set_string('infotext', S('Enchanting Table'))
        meta:set_string('owner', '')
        inv:set_size('item', 1)
        inv:set_size('trade', 1)
        core.add_entity({ x = pos.x, y = pos.y + 0.7, z = pos.z }, 'x_enchanting:table_scroll')
        core.get_node_timer(pos):start(5)
    end,
    ---@param pos Vector
    ---@param placer ObjectRef | nil
    ---@param itemstack ItemStack
    ---@param pointed_thing PointedThingDef
    ---@diagnostic disable-next-line: unused-local
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        local meta = core.get_meta(pos)

        if not placer then
            return
        end

        local player_name = placer:get_player_name()

        meta:set_string('owner', player_name)
        meta:set_string('infotext', S('Enchanting Table') .. ' (' .. S('owned by') .. ' ' .. player_name .. ')')

        local formspec = XEnchanting:get_formspec(pos, player_name)
        meta:set_string('formspec', formspec)
    end,
    ---@param pos Vector
    ---@param node NodeDef
    ---@param clicker ObjectRef
    ---@param itemstack ItemStack
    ---@param pointed_thing? PointedThingDef
    ---@diagnostic disable-next-line: unused-local
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local p_name = clicker:get_player_name()

        if core.is_protected(pos, p_name) then
            return itemstack
        end

        core.sound_play('x_enchanting_scroll', {
            gain = 0.3,
            pos = pos,
            max_hear_distance = 10
        }, true)

        -- bookshelfs
        local bookshelfs = core.find_nodes_in_area(
            { x = pos.x - 2, y = pos.y, z = pos.z - 2 },
            { x = pos.x + 2, y = pos.y + 2, z = pos.z + 2 },
            { 'default:bookshelf', 'group:bookshelf' }
        )

        local inv = core.get_meta(pos):get_inventory()

        if not inv:is_empty('item') and inv:get_stack('item', 1):get_meta():get_int('is_enchanted') ~= 1 then
            local item_stack = inv:get_stack('item', 1)
            local data = XEnchanting:get_enchantment_data(
                clicker,
                #bookshelfs,
                core.registered_tools[item_stack:get_name()]
            )
            local formspec = XEnchanting:get_formspec(pos, p_name, data)

            meta:set_string('formspec', formspec)
        else
            local formspec = XEnchanting:get_formspec(pos, p_name)

            meta:set_string('formspec', formspec)
        end

        return itemstack
    end,
    ---@param pos Vector
    ---@param intensity? number
    ---@return table | nil
    ---@diagnostic disable-next-line: unused-local
    on_blast = function(pos, intensity)
        if core.is_protected(pos, '') then
            return
        end

        local drops = {}
        local inv = core.get_meta(pos):get_inventory()
        local stack_item = inv:get_stack('item', 1)
        local stack_trade = inv:get_stack('trade', 1)

        if not stack_item:is_empty() then
            drops[#drops + 1] = stack_item:to_table()
        end

        if not stack_trade:is_empty() then
            drops[#drops + 1] = stack_trade:to_table()
        end

        drops[#drops + 1] = 'x_enchanting:table'
        core.remove_node(pos)

        return drops
    end,
    ---@param pos Vector
    ---@param player? ObjectRef
    can_dig = function(pos, player)
        if not player then
            return false
        end

        local inv = core.get_meta(pos):get_inventory()

        return inv:is_empty('item')
            and inv:is_empty('trade')
            and not core.is_protected(pos, player:get_player_name())
    end,
    ---@diagnostic disable-next-line: unused-local
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    ---@param pos Vector
    ---@param elapsed number
    ---@diagnostic disable-next-line: unused-local
    on_timer = function(pos, elapsed)
        -- entity
        local table_scroll = core.get_objects_inside_radius(pos, 0.9)

        if #table_scroll == 0 then
            core.add_entity({ x = pos.x, y = pos.y + 0.7, z = pos.z }, 'x_enchanting:table_scroll')
        end

        local particlespawner_def = {
            amount = 50,
            time = 5,
            minpos = { x = pos.x - 0.1, y = pos.y + 0.2, z = pos.z - 0.1 },
            maxpos = { x = pos.x + 0.1, y = pos.y + 0.3, z = pos.z + 0.1 },
            minvel = { x = -0.1, y = 0.1, z = -0.1 },
            maxvel = { x = 0.1, y = 0.2, z = 0.1 },
            minacc = { x = -0.1, y = 0.1, z = -0.1 },
            maxacc = { x = 0.1, y = 0.2, z = 0.1 },
            minexptime = 1.5,
            maxexptime = 2.5,
            minsize = 0.1,
            maxsize = 0.3,
            texture = 'x_enchanting_scroll_particle.png',
            glow = 1
        }

        if core.has_feature({ dynamic_add_media_table = true, particlespawner_tweenable = true }) then
            -- new syntax, after v5.6.0
            particlespawner_def = {
                amount = 50,
                time = 5,
                size = {
                    min = 0.1,
                    max = 0.3,
                },
                exptime = 2,
                pos = {
                    min = vector.new({ x = pos.x - 0.5, y = pos.y, z = pos.z - 0.5 }),
                    max = vector.new({ x = pos.x + 0.5, y = pos.y, z = pos.z + 0.5 }),
                },
                attract = {
                    kind = 'point',
                    strength = 0.5,
                    origin = vector.new({ x = pos.x, y = pos.y + 0.65, z = pos.z })
                },
                texture = {
                    name = 'x_enchanting_scroll_particle.png',
                    alpha_tween = {
                        0, 1,
                        style = 'fwd',
                        reps = 1
                    }
                },
                glow = 1
            }
        end

        core.add_particlespawner(particlespawner_def)

        ---bookshelfs
        local bookshelfs = core.find_nodes_in_area(
            { x = pos.x - 2, y = pos.y, z = pos.z - 2 },
            { x = pos.x + 2, y = pos.y + 2, z = pos.z + 2 },
            { 'default:bookshelf', 'group:bookshelf' }
        )

        if #bookshelfs == 0 then
            return true
        end

        -- symbol particles
        ---@diagnostic disable-next-line: unused-local
        for i = 1, 10, 1 do
            local pos_random = bookshelfs[math.random(1, #bookshelfs)]
            local x = pos.x - pos_random.x
            local y = pos_random.y - pos.y
            local z = pos.z - pos_random.z
            local rand1 = (math.random(150, 250) / 100) * -1
            local rand2 = math.random(10, 500) / 100
            local rand3 = math.random(50, 200) / 100

            core.after(rand2, function()
                core.add_particle({
                    pos = pos_random,
                    velocity = { x = x, y = 2 - y, z = z },
                    acceleration = { x = 0, y = rand1, z = 0 },
                    expirationtime = 1,
                    size = rand3,
                    texture = 'x_enchanting_symbol_' .. math.random(1, 26) .. '.png',
                    glow = 6
                })
            end)
        end

        return true
    end,
    ---@param pos Vector
    on_destruct = function(pos)
        for _, obj in ipairs(core.get_objects_inside_radius(pos, 0.9)) do
            if obj
                and obj:get_luaentity()
                and obj:get_luaentity().name == 'x_enchanting:table_scroll'
            then
                obj:remove()
                break
            end
        end
    end,
    ---@param pos Vector
    ---@param listname string
    ---@param index number
    ---@param stack ItemStack
    ---@param player ObjectRef
    ---@diagnostic disable-next-line: unused-local
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local st_meta = stack:get_meta()
        local st_name = stack:get_name()
        local is_enchanted = st_meta:get_int('is_enchanted')

        if listname == 'item'
            and core.get_item_group(st_name, 'enchantability') > 0
            and is_enchanted ~= 1
        then
            return stack:get_count()
        elseif listname == 'trade'
            and (
                st_name == 'default:mese_crystal'
                or core.get_item_group(st_name, 'enchanting_trade') > 0
            )
            and is_enchanted ~= 1
        then
            return stack:get_count()
        end

        return 0
    end,
    ---@param pos Vector
    ---@param listname string
    ---@param index number
    ---@param stack ItemStack
    ---@param player ObjectRef
    ---@diagnostic disable-next-line: unused-local
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local st_name = stack:get_name()

        if listname == 'item' then
            return stack:get_count()
        elseif listname == 'trade'
            and (
                st_name == 'default:mese_crystal'
                or core.get_item_group(st_name, 'enchanting_trade') > 0
            )
        then
            return stack:get_count()
        end

        return 0
    end,
    ---@param pos Vector
    ---@param from_list string
    ---@param from_index number
    ---@param to_list string
    ---@param to_index number
    ---@param count number
    ---@param player ObjectRef
    ---@diagnostic disable-next-line: unused-local
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        return 0
    end,
    ---@param pos Vector
    ---@param listname string
    ---@param index number
    ---@param stack ItemStack
    ---@param player ObjectRef
    ---@diagnostic disable-next-line: unused-local
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        local p_name = player:get_player_name()
        local inv = meta:get_inventory()
        local item_stack = inv:get_stack('item', 1)
        local item_stack_meta = item_stack:get_meta()
        local is_enchanted = item_stack_meta:get_int('is_enchanted')

        if not inv:is_empty('item') and is_enchanted == 0 then
            -- bookshelfs
            local bookshelfs = core.find_nodes_in_area(
                { x = pos.x - 2, y = pos.y, z = pos.z - 2 },
                { x = pos.x + 2, y = pos.y + 2, z = pos.z + 2 },
                { 'default:bookshelf', 'group:bookshelf' }
            )

            local data = XEnchanting:get_enchantment_data(
                player,
                #bookshelfs,
                core.registered_tools[item_stack:get_name()]
            )
            local formspec = XEnchanting:get_formspec(pos, p_name, data)

            meta:set_string('formspec', formspec)
        else
            local formspec = XEnchanting:get_formspec(pos, p_name)

            meta:set_string('formspec', formspec)
        end
    end,
    ---@param pos Vector
    ---@param listname string
    ---@param index number
    ---@param stack ItemStack
    ---@param player ObjectRef
    ---@diagnostic disable-next-line: unused-local
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        local p_name = player:get_player_name()
        local inv = meta:get_inventory()
        local item_stack = inv:get_stack('item', 1)
        local item_stack_meta = item_stack:get_meta()
        local is_enchanted = item_stack_meta:get_int('is_enchanted')

        if not inv:is_empty('item') and is_enchanted == 0 then
            -- bookshelfs
            local bookshelfs = core.find_nodes_in_area(
                { x = pos.x - 2, y = pos.y, z = pos.z - 2 },
                { x = pos.x + 2, y = pos.y + 2, z = pos.z + 2 },
                { 'default:bookshelf', 'group:bookshelf' }
            )

            local data = XEnchanting:get_enchantment_data(
                player,
                #bookshelfs,
                core.registered_tools[item_stack:get_name()]
            )
            local formspec = XEnchanting:get_formspec(pos, p_name, data)

            meta:set_string('formspec', formspec)
        else
            local formspec = XEnchanting:get_formspec(pos, p_name)

            meta:set_string('formspec', formspec)
        end
    end,
    -- form receive fields
    ---@param pos Vector
    ---@param formname string
    ---@param fields table
    ---@param sender ObjectRef
    ---@diagnostic disable-next-line: unused-local
    on_receive_fields = function(pos, formname, fields, sender)
        local p_name = sender:get_player_name()

        if fields.quit then
            XEnchanting.form_context[p_name] = nil
            return
        end

        local selected_slot

        if fields.slot_1 and fields.slot_1 ~= '' then
            selected_slot = 1
        elseif fields.slot_2 and fields.slot_2 ~= '' then
            selected_slot = 2
        elseif fields.slot_3 and fields.slot_3 ~= '' then
            selected_slot = 3
        end

        if not XEnchanting.form_context[p_name] or not selected_slot then
            return
        end

        local inv = core.get_meta(pos):get_inventory()

        if inv:is_empty('trade') or inv:is_empty('item') then
            return
        end

        local trade_stack = inv:get_stack('trade', 1)

        if trade_stack:get_count() < selected_slot then
            return
        end

        local item_stack = inv:get_stack('item', 1)
        local is_enchanted = item_stack:get_meta():get_int('is_enchanted')

        if is_enchanted == 1 then
            return
        end

        -- Enchant item
        XEnchanting:set_enchanted_tool(
            pos,
            item_stack,
            selected_slot,
            p_name
        )
    end
})

----
--- Entity (Scroll)
----

core.register_entity('x_enchanting:table_scroll', {
    initial_properties = {
        visual = 'mesh',
        mesh = 'x_enchanting_scroll.b3d',
        textures = {
            --- back
            'x_enchanting_scroll_mesh.png',
            -- handles
            'x_enchanting_scroll_handles_mesh.png',
            --- front
            'x_enchanting_scroll_mesh.png',
        },
        collisionbox = { 0, 0, 0, 0, 0, 0 },
        selectionbox = { 0, 0, 0, 0, 0, 0 },
        physical = false,
        hp_max = 1,
        visual_size = { x = 1, y = 1, z = 1 },
        glow = 1,
        pointable = false,
        infotext = S('Scroll of Enchantments'),
    },
    ---@param self table
    ---@param killer ObjectRef
    ---@diagnostic disable-next-line: unused-local
    on_death = function(self, killer)
        self.object:remove()
    end,
    ---@param self table
    ---@param staticdata StringAbstract
    ---@param dtime_s number
    ---@diagnostic disable-next-line: unused-local
    on_activate = function(self, staticdata, dtime_s)
        self._scroll_closed = true
        self._tablechecktimer = 5
        self._playerchecktimer = 1
        self._player = nil
        self._last_rotation = nil

        self.object:set_armor_groups({ immortal = 1 })
        self.object:set_animation({ x = 0, y = 0 }, 0, 0, false)
    end,
    ---@param self table
    ---@param dtime number
    ---@param moveresult? table
    ---@diagnostic disable-next-line: unused-local
    on_step = function(self, dtime, moveresult)
        local pos = self.object:get_pos()

        self._last_rotation = self.object:get_rotation()
        self._tablechecktimer = self._tablechecktimer - dtime
        self._playerchecktimer = self._playerchecktimer - dtime

        -- table
        if self._tablechecktimer <= 0 then
            self._tablechecktimer = 5
            local node = core.get_node({ x = pos.x, y = pos.y - 0.7, z = pos.z })

            if node.name ~= 'x_enchanting:table' then
                -- remove entity when no table under it
                self.object:remove()
            end
        end

        -- player
        if self._playerchecktimer <= 0 then
            self._playerchecktimer = 1
            local objects = core.get_objects_inside_radius(pos, 5)

            -- inital value
            local shortest_distance = 10
            local found_player = false

            if #objects > 0 then
                ---@diagnostic disable-next-line: unused-local
                for i, obj in ipairs(objects) do
                    if obj:is_player() and obj:get_pos() then
                        -- player
                        found_player = true
                        local distance = vector.distance(pos, obj:get_pos())

                        if distance < shortest_distance then
                            shortest_distance = distance
                            self._player = obj
                        end
                    end
                end
            else
                self._player = nil
            end

            if not found_player then
                self._player = nil
            end

            -- scroll open/close animation
            if self._player and self._scroll_closed then
                self._scroll_closed = false
                self.object:set_animation(unpack(XEnchanting.scroll_animations.scroll_open))

                core.sound_play('x_enchanting_scroll', {
                    gain = 0.3,
                    pos = pos,
                    max_hear_distance = 10
                }, true)
            elseif not self._player and not self._scroll_closed then
                self._scroll_closed = true
                self.object:set_animation(unpack(XEnchanting.scroll_animations.scroll_close))

                core.sound_play('x_enchanting_scroll', {
                    gain = 0.3,
                    pos = pos,
                    max_hear_distance = 10
                }, true)
            end
        end

        -- rotation
        if self._player and self._player:get_pos() then
            local direction = vector.direction(pos, self._player:get_pos())
            self.object:set_yaw(core.dir_to_yaw(direction))
        else
            self.object:set_rotation({
                x = self._last_rotation.x,
                y = self._last_rotation.y + (math.pi / -50),
                z = self._last_rotation.z
            })
        end
    end,
    ---@param self table
    ---@param puncher ObjectRef
    ---@param time_from_last_punch number | nil
    ---@param tool_capabilities ToolCapabilitiesDef | nil
    ---@param dir Vector
    ---@param damage number
    ---@return boolean | nil
    ---@diagnostic disable-next-line: unused-local
    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
        return true
    end
})

----
-- Recipe
---

if core.get_modpath('xdecor') then
    core.register_craft({
        output = 'x_enchanting:table',
        recipe = {
            { 'default:book', '', '' },
            { 'default:diamond', 'default:obsidian', 'default:diamond' },
            { 'default:obsidian', 'default:obsidian', 'default:obsidian' }
        }
    })
else
    core.register_craft({
        output = 'x_enchanting:table',
        recipe = {
            { '', 'default:book', '' },
            { 'default:diamond', 'default:obsidian', 'default:diamond' },
            { 'default:obsidian', 'default:obsidian', 'default:obsidian' }
        }
    })
end
