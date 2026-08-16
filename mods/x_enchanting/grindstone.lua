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
--- Grindstone Node
----

core.register_node('x_enchanting:grindstone', {
    description = S('Grindstone'),
    short_description = S('Grindstone'),
    drawtype = 'mesh',
    mesh = 'x_enchanting_grindstone.obj',
    tiles = { 'x_enchanting_grindstone_mesh.png' },
    inventory_image = 'x_enchanting_grindstone_item.png',
    use_texture_alpha = 'clip',
    paramtype = 'light',
    paramtype2 = 'facedir',
    walkable = true,
    wield_scale = { x = 2, y = 2, z = 2 },
    selection_box = {
        type = 'fixed',
        fixed = { -1 / 2, -1 / 2, -1 / 2, 1 / 2, 1 / 2 - 1 / 16, 1 / 2 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -1 / 2, -1 / 2, -1 / 2, 1 / 2, 1 / 2 - 1 / 16, 1 / 2 }
    },
    sounds = XEnchanting.node_sound_wood_defaults(),
    is_ground_content = false,
    groups = { choppy = 2, oddly_breakable_by_hand = 2 },
    stack_max = 1,
    mod_origin = 'x_enchanting',
    ---@param pos Vector
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()

        meta:set_string('infotext', S('Grindstone'))
        meta:set_string('owner', '')
        inv:set_size('item', 1)
        inv:set_size('result', 1)
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
        meta:set_string('infotext', S('Grindstone') .. ' (' .. S('owned by') .. ' ' .. player_name .. ')')

        local formspec = XEnchanting:get_grindstone_formspec(pos, player_name)
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
        local inv = meta:get_inventory()
        local item_stack = inv:get_stack('item', 1)
        local has_all_cursed_ench = XEnchanting:has_all_cursed_ench(item_stack)

        if core.is_protected(pos, p_name) then
            return itemstack
        end

        core.sound_play('x_enchanting_wood_hit', {
            gain = 0.5,
            pos = pos,
            max_hear_distance = 10
        }, true)

        local formspec = XEnchanting:get_grindstone_formspec(pos, p_name, { result_disabled = has_all_cursed_ench })
        meta:set_string('formspec', formspec)

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

        if not stack_item:is_empty() then
            drops[#drops + 1] = stack_item:to_table()
        end

        drops[#drops + 1] = 'x_enchanting:grindstone'
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
            and inv:is_empty('result')
            and not core.is_protected(pos, player:get_player_name())
    end,
    ---@diagnostic disable-next-line: unused-local
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    ---@param pos Vector
    ---@param listname string
    ---@param index number
    ---@param stack ItemStack
    ---@param player ObjectRef
    ---@diagnostic disable-next-line: unused-local
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local st_meta = stack:get_meta()
        local is_enchanted = st_meta:get_int('is_enchanted')

        if listname == 'item' and is_enchanted == 1 then
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
        return stack:get_count()
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
        --
        -- Create new itemstack with removed enchantments (excl. curses) and populate the result slot with this new item
        --
        local meta = core.get_meta(pos)
        local p_name = player:get_player_name()
        local inv = meta:get_inventory()
        local item_stack = inv:get_stack('item', 1)
        local item_stack_meta = item_stack:get_meta()
        local is_enchanted = item_stack_meta:get_int('is_enchanted')
        local stack_enchantment_data = core.deserialize(item_stack_meta:get_string('x_enchanting')) or {}
        local has_all_cursed_ench = XEnchanting:has_all_cursed_ench(item_stack)

        if not inv:is_empty('item') and is_enchanted == 1 and not has_all_cursed_ench then
            -- Discenchanted item
            local has_curse = false
            local current_enchantments = {}

            for id, value in pairs(stack_enchantment_data) do
                -- Remove enchantment meta data (excl. cursed)
                local ench_def = XEnchanting.enchantment_defs[id]

                if not ench_def.cursed then
                    item_stack_meta:set_float('is_' .. id, 0)
                    stack_enchantment_data[id] = nil
                else
                    has_curse = true
                end

                -- Get descriptions
                if stack_enchantment_data[id] then
                    local level

                    -- Find level
                    for i, v in ipairs(ench_def.level_def) do
                        if v == value.value then
                            level = i
                            break
                        end
                    end

                    table.insert(current_enchantments, {
                        id = id,
                        value = value.value,
                        level = level,
                        secondary = ench_def.secondary,
                        incompatible = ench_def.incompatible
                    })
                end
            end

            if not has_curse then
                -- Reset meta data if not cursed
                item_stack_meta:set_string('inventory_image', '')
                item_stack_meta:set_string('inventory_overlay', '')
                item_stack_meta:set_string('wield_image', '')
                item_stack_meta:set_string('wield_overlay', '')
                item_stack_meta:set_string('description', '')
                item_stack_meta:set_string('short_description', '')
                item_stack_meta:set_int('is_enchanted', 0)
            end

            local descriptions = XEnchanting:get_enchanted_descriptions(current_enchantments)

            -- Upgrade description with remaining enchantments
            if #current_enchantments > 0 then
                local item_stack_def = core.registered_tools[item_stack:get_name()]
                item_stack_meta:set_string('description', (item_stack_def and item_stack_def.description or '') .. '\n' .. descriptions.enchantments_desc)
            end

            item_stack_meta:set_tool_capabilities(nil)
            item_stack_meta:set_string('x_enchanting', core.serialize(stack_enchantment_data))

            inv:set_stack('result', 1, item_stack)
        end

        local formspec = XEnchanting:get_grindstone_formspec(pos, p_name, { result_disabled = has_all_cursed_ench })

        meta:set_string('formspec', formspec)
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
        local result_stack = inv:get_stack('result', 1)
        local item_stack = inv:get_stack('item', 1)
        local item_stack_meta = item_stack:get_meta()
        local has_all_cursed_ench = XEnchanting:has_all_cursed_ench(item_stack)
        local stack_enchantment_data = core.deserialize(item_stack_meta:get_string('x_enchanting')) or {}
        local result_payment_stack = ItemStack({ name = 'default:mese_crystal_fragment' })

        if item_stack:is_empty() or has_all_cursed_ench then
            -- Remove result item
            inv:remove_item('result', result_stack)
        end

        -- Collect total result
        local result_total = 0

        if result_total == 0 then
            -- get payback result (excl. cursed enchantments) from the original item
            for id, value in pairs(stack_enchantment_data) do
                local ench_def = XEnchanting.enchantment_defs[id]
                local lvl_index

                if not ench_def.cursed then
                    -- find level index
                    for i, v in ipairs(ench_def.level_def) do
                        if v == stack_enchantment_data[id].value then
                            lvl_index = i
                        end
                    end
                end

                if lvl_index then
                    local final_level_range = ench_def.final_level_range[lvl_index]
                    local range_max = final_level_range[1] + final_level_range[2]
                    local range_min = math.floor(range_max / 2)
                    local result = math.random(range_min, range_max)

                    result_total = result_total + result
                end
            end

            if result_total > result_payment_stack:get_stack_max() then
                result_total = result_payment_stack:get_stack_max()
            elseif result_total == 0 then
                result_total = 1
            end
        end

        result_total = math.floor(result_total / 10)

        result_payment_stack:set_count(result_total)

        if listname == 'result' and result_stack:is_empty() then
            -- Drop payment result
            inv:set_stack('item', 1, ItemStack(''))
            core.item_drop(result_payment_stack, player, player:get_pos())

            core.sound_play('x_enchanting_disenchant', {
                gain = 0.3,
                pos = pos,
                max_hear_distance = 10
            }, true)

            -- particles
            local particlespawner_def = {
                amount = 50,
                time = 0.5,
                minpos = { x = pos.x - 0.5, y = pos.y + 0.5, z = pos.z - 0.5 },
                maxpos = { x = pos.x + 0.5, y = pos.y + 0.5, z = pos.z + 0.5 },
                minvel = { x = -1.5, y = -0.5, z = -1.5 },
                maxvel = { x = 1.5, y = -1.5, z = 1.5 },
                minacc = { x = -3.5, y = -6.5, z = -3.5 },
                maxacc = { x = 5.5, y = -7.5, z = 5.5 },
                minexptime = 0.5,
                maxexptime = 1,
                minsize = 0.5,
                maxsize = 1,
                texture = 'x_enchanting_scroll_particle.png^[colorize:#FFE5C2:256',
                glow = 1
            }

            core.add_particlespawner(particlespawner_def)
        end


        local formspec = XEnchanting:get_grindstone_formspec(pos, p_name)

        meta:set_string('formspec', formspec)
    end
})

----
-- Recipe
---

core.register_craft({
    output = 'x_enchanting:grindstone',
    recipe = {
        { 'group:stick', 'stairs:slab_stone', 'group:stick' },
        { 'group:wood', '', 'group:wood' }
    }
})
