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

local path = core.get_modpath('x_enchanting')
local mod_start_time = core.get_us_time()

dofile(path .. '/api.lua')
dofile(path .. '/table.lua')
dofile(path .. '/grindstone.lua')

---Check if string X starts with string Y
---@param str string
---@param start string
---@return boolean
local function starts_with(str, start)
    return str:sub(1, #start) == start
end

core.register_on_mods_loaded(function()
    -- Tools override
    for name, tool_def in pairs(core.registered_tools) do
        if XEnchanting:has_tool_group(name) then
            XEnchanting:set_tool_enchantability(tool_def)
        end
    end

    -- Ores override - Fortune
    for _, def in pairs(core.registered_ores) do
        if not XEnchanting.registered_ores[def.ore] then
            XEnchanting.registered_ores[def.ore] = true
        end
    end

    -- Entities override - Looting
    for name, def in pairs(core.registered_entities) do
        if starts_with(name, 'mobs_animal:')
            or starts_with(name, 'mobs_monster:')
        then
            if def.on_punch and def.drops then
                local prev_on_punch = def.on_punch

                ---@param self table
                ---@param puncher ObjectRef|nil
                ---@param time_from_last_punch number|integer|nil
                ---@param tool_capabilities ToolCapabilitiesDef|nil
                ---@param dir Vector
                ---@param damage number|integer
                ---@return boolean|nil
                def.on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
                    if not self
                        or not self.object
                        or not self.object:get_luaentity()
                        or not puncher
                        or not tool_capabilities
                    then
                        return prev_on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
                    end

                    local wield_stack = puncher:get_wielded_item()
                    local wield_stack_meta = wield_stack:get_meta()
                    local looting = wield_stack_meta:get_float('is_looting')

                    if looting == 0 then
                        return prev_on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
                    end

                    local pos = self.object:get_pos()

                    prev_on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)

                    if self.health and self.health <= 0 then
                        local death_by_player = self.cause_of_death
                            and self.cause_of_death.puncher
                            and self.cause_of_death.puncher:is_player()

                        if death_by_player and pos then
                            for _, drop in ipairs(def.drops) do
                                if math.random(10, 100) / 100 < looting / (looting + 1) then
                                    local drop_min = drop.min or 0
                                    local drop_max = drop.max or 0
                                    local count = math.random(drop_min, drop_max)
                                    local stack = ItemStack({
                                        name = drop.name,
                                        count = count
                                    })
                                    local chance = math.random(1, tool_capabilities.max_drop_level)

                                    stack:set_count(stack:get_count() * chance)

                                    if stack:get_count() > 0 then
                                        core.item_drop(stack, puncher, pos)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        elseif starts_with(name, 'animalia:') then
            if def.death_func and def.drops then
                local prev_death_func = def.death_func

                ---@param self table
                def.death_func = function(self)
                    local puncher = self._puncher

                    if not self
                        or not self.object
                        or not self.object:get_luaentity()
                        or not puncher
                        or not puncher:is_player()
                        or self._looting_dropped
                    then
                        return prev_death_func(self)
                    end

                    local wield_stack = puncher:get_wielded_item()
                    local wield_stack_meta = wield_stack:get_meta()
                    local looting = wield_stack_meta:get_float('is_looting')

                    if looting == 0 then
                        return prev_death_func(self)
                    end

                    local pos = self.object:get_pos()

                    prev_death_func(self)

                    local death_by_player = puncher and puncher:is_player()

                    if death_by_player and pos then
                        local tool_capabilities = wield_stack:get_tool_capabilities()
                        self._looting_dropped = true

                        for _, drop in ipairs(def.drops) do
                            if math.random(10, 100) / 100 < looting / (looting + 1) then
                                local drop_min = drop.min or 0
                                local drop_max = drop.max or 0
                                local count = math.random(drop_min, drop_max)
                                local stack = ItemStack({
                                    name = drop.name,
                                    count = count
                                })
                                local chance = math.random(1, tool_capabilities.max_drop_level)

                                stack:set_count(stack:get_count() * chance)

                                if stack:get_count() > 0 then
                                    core.item_drop(stack, puncher, pos)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

---@diagnostic disable-next-line: unused-local
core.register_on_joinplayer(function(player, last_login)
    XEnchanting.form_context[player:get_player_name()] = nil

    if not XEnchanting.player_seeds[player:get_player_name()] then
        XEnchanting.player_seeds[player:get_player_name()] = XEnchanting.get_randomseed()
    end
end)

---@diagnostic disable-next-line: unused-local
core.register_on_leaveplayer(function(player, timed_out)
    XEnchanting.form_context[player:get_player_name()] = nil
end)

local old_handle_node_drops = core.handle_node_drops

function core.handle_node_drops(pos, drops, digger)
    if not digger
        or not digger:is_player()
    then
        return old_handle_node_drops(pos, drops, digger)
    end

    local node = core.get_node(pos)
    local wield_stack = digger:get_wielded_item()
    local wield_stack_meta = wield_stack:get_meta()

    -- Fortune
    local fortune = wield_stack_meta:get_float('is_fortune')

    if fortune > 0 then
        local new_drops = {}

        for _, itemstring in ipairs(drops) do
            if XEnchanting.registered_ores[node.name]
                or core.get_item_group(node.name, 'stone') > 0
                or core.get_item_group(node.name, 'soil') > 0
                or core.get_item_group(node.name, 'sand') > 0
                or core.get_item_group(node.name, 'snowy') > 0
                or core.get_item_group(node.name, 'slippery') > 0
                or core.get_item_group(node.name, 'tree') > 0
                or core.get_item_group(node.name, 'leaves') > 0
            then
                local tool_capabilities = wield_stack:get_tool_capabilities()
                local stack = ItemStack(itemstring)
                local chance = math.random(1, tool_capabilities.max_drop_level)

                stack:set_count(stack:get_count() * chance)

                if stack:get_count() > 0 then
                    table.insert(new_drops, stack)
                end
            end
        end

        if #new_drops > 0 then
            return old_handle_node_drops(pos, new_drops, digger)
        end

        return old_handle_node_drops(pos, drops, digger)
    end

    -- Silk Touch
    local silk_touch = wield_stack_meta:get_float('is_silk_touch')

    if silk_touch > 0
        and core.get_item_group(node.name, 'no_silktouch') == 0
    then
        -- drop raw item/node
        return old_handle_node_drops(pos, { ItemStack(node.name) }, digger)
    end

    return old_handle_node_drops(pos, drops, digger)
end

---@diagnostic disable-next-line: unused-local
core.register_on_player_hpchange(function(player, hp_change, reason)
    -- Curse of Vanishing
    if (player:get_hp() + hp_change) <= 0 then
        -- Going to die
        local player_inv = player:get_inventory() --[[@as InvRef]]
        local player_inventory_lists = { 'main', 'craft' }

        for _, list_name in ipairs(player_inventory_lists) do
            if not player_inv:is_empty(list_name) then
                for i = 1, player_inv:get_size(list_name) do
                    local stack = player_inv:get_stack(list_name, i)
                    local stack_meta = stack:get_meta()

                    if stack_meta:get_float('is_curse_of_vanishing') > 0 then
                        player_inv:set_stack(list_name, i, ItemStack(''))
                    end
                end
            end
        end
    end

    return hp_change
end, true)

-- Knockback (only for players)
local old_calculate_knockback = core.calculate_knockback

function core.calculate_knockback(player, hitter, time_from_last_punch,
    tool_capabilities, dir, distance, damage)
    if hitter and hitter:is_player() then
        local hitter_wield_stack = hitter:get_wielded_item()
        local hitter_wield_stack_meta = hitter_wield_stack:get_meta()
        local ench_knockback = hitter_wield_stack_meta:get_float('is_knockback')

        if ench_knockback > 0 then
            local orig_knockback = old_calculate_knockback(
                player,
                hitter,
                time_from_last_punch,
                tool_capabilities,
                dir,
                distance,
                damage
            )

            orig_knockback = orig_knockback + 1

            local new_knockback = orig_knockback + (orig_knockback * (ench_knockback / 100))

            player:add_velocity(vector.new(0, new_knockback, 0))

            return new_knockback
        end
    end

    return old_calculate_knockback(player, hitter, time_from_last_punch,
    tool_capabilities, dir, distance, damage)
end

local mod_end_time = (core.get_us_time() - mod_start_time) / 1000000

print('[Mod] x_enchanting loaded.. [' .. mod_end_time .. 's]')
