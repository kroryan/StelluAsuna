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

---@type XEnchanting
XEnchanting = {
    tools_enchantability = {
        -- picks
        ['default:pick_wood'] = 15,
        ['default:pick_stone'] = 5,
        ['default:pick_bronze'] = 22,
        ['default:pick_steel'] = 14,
        ['default:pick_mese'] = 15,
        ['default:pick_diamond'] = 10,
        -- shovels
        ['default:shovel_wood'] = 15,
        ['default:shovel_stone'] = 5,
        ['default:shovel_bronze'] = 22,
        ['default:shovel_steel'] = 14,
        ['default:shovel_mese'] = 15,
        ['default:shovel_diamond'] = 10,
        -- axes
        ['default:axe_wood'] = 15,
        ['default:axe_stone'] = 5,
        ['default:axe_bronze'] = 22,
        ['default:axe_steel'] = 14,
        ['default:axe_mese'] = 15,
        ['default:axe_diamond'] = 10,
        -- swords
        ['default:sword_wood'] = 15,
        ['default:sword_stone'] = 5,
        ['default:sword_bronze'] = 22,
        ['default:sword_steel'] = 14,
        ['default:sword_mese'] = 15,
        ['default:sword_diamond'] = 10
    },
    roman_numbers = {
        [1] = 'I',
        [2] = 'II',
        [3] = 'III',
        [4] = 'IV',
        [5] = 'V',
    },
    enchantment_defs = {
        -- Living things like animals and the player. This could imply
        -- some blood effects when hitting
        sharpness = {
            name = S('Sharpness'),
            -- what level should be taken, `level = min/max values`
            final_level_range = {
                [1] = { 1, 21 },
                [2] = { 12, 32 },
                [3] = { 23, 43 },
                [4] = { 34, 54 },
                [5] = { 45, 65 },
            },
            -- level definition, `level = added value`
            level_def = {
                [1] = 1.25,
                [2] = 2.5,
                [3] = 3.75,
                [4] = 5,
                [5] = 6.25,
            },
            weight = 10,
            groups = {
                'sword'
            }
        },
        looting = {
            name = S('Looting'),
            -- what level should be taken, `level = min/max values`
            final_level_range = {
                [1] = { 15, 65 },
                [2] = { 24, 74 },
                [3] = { 33, 83 }
            },
            -- level definition, `level = number to add`
            level_def = {
                [1] = 1,
                [2] = 2,
                [3] = 3
            },
            weight = 2,
            groups = {
                'sword'
            }
        },
        fortune = {
            name = S('Fortune'),
            -- what level should be taken, `level = min/max values`
            final_level_range = {
                [1] = { 15, 65 },
                [2] = { 24, 74 },
                [3] = { 33, 83 }
            },
            -- level definition, `level = number to add`
            level_def = {
                [1] = 1,
                [2] = 2,
                [3] = 3
            },
            weight = 2,
            groups = {
                'pickaxe',
                'shovel',
                'axe'
            },
            incompatible = { 'silk_touch' }
        },
        unbreaking = {
            name = S('Unbreaking'),
            -- what level should be taken, `level = min/max values`
            final_level_range = {
                [1] = { 5, 55 },
                [2] = { 13, 63 },
                [3] = { 21, 71 }
            },
            -- level definition, `level = percentage increase`
            level_def = {
                [1] = 100,
                [2] = 200,
                [3] = 300
            },
            weight = 5,
            -- all applicable
            groups = nil
        },
        efficiency = {
            name = S('Efficiency'),
            -- what level should be taken, `level = min/max values`
            final_level_range = {
                [1] = { 1, 51 },
                [2] = { 11, 61 },
                [3] = { 21, 71 },
                [4] = { 31, 81 },
                [5] = { 41, 91 },
            },
            -- level definition, `level = percentage increase`
            level_def = {
                [1] = 25,
                [2] = 30,
                [3] = 35,
                [4] = 40,
                [5] = 45,
            },
            weight = 10,
            groups = {
                'pickaxe',
                'shovel',
                'axe'
            }
        },
        silk_touch = {
            name = S('Silk Touch'),
            final_level_range = {
                [1] = { 15, 65 }
            },
            level_def = {
                [1] = 1
            },
            weight = 1,
            secondary = true,
            groups = {
                'pickaxe',
                'shovel',
                'axe'
            },
            incompatible = { 'fortune' }
        },
        curse_of_vanishing = {
            name = S('Curse of Vanishing'),
            final_level_range = {
                [1] = { 25, 50 }
            },
            level_def = {
                [1] = 1
            },
            weight = 1,
            secondary = true,
            -- all applicable
            groups = nil,
            cursed = true
        },
        knockback = {
            name = S('Knockback'),
            final_level_range = {
                [1] = { 5, 55 },
                [2] = { 25, 75 }
            },
            -- increase %
            level_def = {
                [1] = 105,
                [2] = 190
            },
            weight = 5,
            groups = {
                'sword'
            }
        },
        power = {
            -- Increases arrow damage.
            -- Damage has to be calculated in the MOD where the bow comes from!
            name = S('Power'),
            final_level_range = {
                [1] = { 1, 16 },
                [2] = { 11, 26 },
                [3] = { 21, 36 },
                [4] = { 31, 46 },
                [5] = { 41, 56 }
            },
            -- increase %
            level_def = {
                [1] = 50,
                [2] = 75,
                [3] = 100,
                [4] = 125,
                [5] = 150
            },
            weight = 10,
            groups = {
                'bow'
            }
        },
        punch = {
            -- Increases arrow knockback.
            -- Knockback has to be calculated in the MOD where the bow comes from!
            name = S('Punch'),
            final_level_range = {
                [1] = { 12, 37 },
                [2] = { 32, 57 }
            },
            -- multiplier
            level_def = {
                [1] = 3,
                [2] = 6
            },
            weight = 2,
            groups = {
                'bow'
            }
        },
        infinity = {
            -- Prevents regular arrows from being consumed when shot.
            -- One arrow is needed to use a bow enchanted with Infinity.
            -- Only set in item meta, logic for this has to be in the MOD where the bow comes from!
            name = S('Infinity'),
            final_level_range = {
                [1] = { 20, 50 }
            },
            -- will be set in meta as float
            level_def = {
                [1] = 1
            },
            weight = 1,
            secondary = true,
            groups = {
                'bow'
            }
        },
    },
    form_context = {},
    player_seeds = {},
    scroll_animations = {
        scroll_open = { { x = 1, y = 40 }, 80, 0, false },
        scroll_close = { { x = 45, y = 84 }, 80, 0, false },
        scroll_open_idle = { { x = 41, y = 42 }, 0, 0, false },
        scroll_closed_idle = { { x = 43, y = 44 }, 0, 0, false }
    },
    registered_ores = {}
}

---Merge two tables with key/value pair
---@param t1 table
---@param t2 table
---@return table
local function mergeTables(t1, t2)
    for k, v in pairs(t2) do t1[k] = v end
    return t1
end

---Gets length of hashed table
---@param table any
---@return integer
local function get_table_length(table)
    local length = 0
    for _ in pairs(table) do
        length = length + 1
    end

    return length
end

---Find element v of t satisfying f(v)
local function tableFind(t, f)
    for _, v in ipairs(t) do
        if f(v) then
            return v
        end
    end

    return nil
end

---@diagnostic disable-next-line: unused-local
function XEnchanting.has_tool_group(self, name)
    if core.get_item_group(name, 'pickaxe') > 0 then
        return 'pickaxe'
    elseif core.get_item_group(name, 'shovel') > 0 then
        return 'shovel'
    elseif core.get_item_group(name, 'axe') > 0 then
        return 'axe'
    elseif core.get_item_group(name, 'sword') > 0 then
        return 'sword'
    elseif core.get_item_group(name, 'bow') > 0 then
        return 'bow'
    end

    return false
end

function XEnchanting.set_tool_enchantability(self, tool_def)
    if core.get_item_group(tool_def.name, 'enchantability') > 0 then
        -- enchantability is already set, we dont need to override the item
        return
    end

    local _enchantability = 1

    if self.tools_enchantability[tool_def.name] then
        _enchantability = self.tools_enchantability[tool_def.name]
    end

    core.override_item(tool_def.name, {
        groups = mergeTables(tool_def.groups, { enchantability = _enchantability })
    })
end

---@diagnostic disable-next-line: unused-local
function XEnchanting.get_enchanted_tool_capabilities(self, tool_def, enchantments)
    local tool_stack = ItemStack({ name = tool_def.name })
    local tool_capabilities = tool_stack:get_tool_capabilities()

    ---@diagnostic disable-next-line: unused-local
    for i, enchantment in ipairs(enchantments) do
        -- Efficiency
        if enchantment.id == 'efficiency' then
            -- apply enchantment
            if tool_capabilities.groupcaps then
                -- groupcaps
                for group_name, def in pairs(tool_capabilities.groupcaps) do
                    local highest_cap_level = 0

                    -- times
                    if def.times then
                        local old_times = def.times
                        local new_times = {}

                        for lvl, old_time in pairs(old_times) do
                            local new_time = old_time - (old_time * (enchantment.value / 100))

                            if new_time < 0.15 then
                                new_time = 0.15
                            end

                            if highest_cap_level < lvl then
                                highest_cap_level = lvl
                            end

                            new_times[lvl] = new_time
                        end

                        -- extend groupcaps levels
                        while highest_cap_level > 1 do
                            highest_cap_level = highest_cap_level - 1

                            if not new_times[highest_cap_level] then
                                -- add new cap level time
                                local old_time = new_times[highest_cap_level + 1]
                                local new_time = old_time * 2

                                if new_time < 0.15 then
                                    new_time = 0.15
                                end

                                new_times[highest_cap_level] = new_time
                            end
                        end

                        tool_capabilities.groupcaps[group_name].times = new_times
                    end

                    -- maxlevel
                    if def.maxlevel and def.maxlevel < enchantment.level then
                        tool_capabilities.groupcaps[group_name].maxlevel = enchantment.level
                    end
                end
            end

            if tool_capabilities.full_punch_interval then
                -- full_punch_interval
                local old_fpi = tool_capabilities.full_punch_interval
                local new_fpi = old_fpi - (old_fpi * (enchantment.value / 100))

                if new_fpi < 0.15 then
                    new_fpi = 0.15
                end

                tool_capabilities.full_punch_interval = new_fpi
            end
        end

        -- Unbreaking
        if enchantment.id == 'unbreaking' then
            if tool_capabilities.groupcaps then
                -- groupcaps
                for group_name, def in pairs(tool_capabilities.groupcaps) do
                    -- uses
                    if def.uses then
                        local old_uses = def.uses
                        local new_uses = old_uses + (old_uses * (enchantment.value / 100))

                        tool_capabilities.groupcaps[group_name].uses = new_uses
                    end
                end
            end

            if tool_capabilities.punch_attack_uses then
                -- punch_attack_uses
                local old_uses = tool_capabilities.punch_attack_uses
                local new_uses = old_uses + (old_uses * (enchantment.value / 100))

                tool_capabilities.punch_attack_uses = new_uses
            end
        end

        -- Sharpness
        if enchantment.id == 'sharpness' and tool_capabilities.damage_groups then
            for group_name, val in pairs(tool_capabilities.damage_groups) do
                local old_damage = val
                local new_damage = old_damage + enchantment.value

                tool_capabilities.damage_groups[group_name] = new_damage
            end
        end

        -- Fortune
        if enchantment.id == 'fortune' or enchantment.id == 'looting' and tool_capabilities.max_drop_level then
            local old_max_drop_level = tool_capabilities.max_drop_level
            local new_max_drop_level = old_max_drop_level + enchantment.value

            tool_capabilities.max_drop_level = new_max_drop_level
        end
    end

    return tool_capabilities
end

---@diagnostic disable-next-line: unused-local
function XEnchanting.get_randomseed(self)
    return tonumber(tostring(os.time()):reverse():sub(1, 9)) --[[@as integer]]
end

function XEnchanting.get_enchanted_descriptions(self, enchantments)
    local enchantments_desc = {}
    local enchantments_desc_masked = {}

    ---@diagnostic disable-next-line: unused-local
    for i, enchantment in ipairs(enchantments) do
        local add_roman_numbers = true

        if get_table_length(self.enchantment_defs[enchantment.id].final_level_range) == 1 then
            add_roman_numbers = false
        end

        if add_roman_numbers then
            enchantments_desc[#enchantments_desc + 1] = self.enchantment_defs[enchantment.id].name
                .. ' '
                .. self.roman_numbers[enchantment.level]
        else
            enchantments_desc[#enchantments_desc + 1] = self.enchantment_defs[enchantment.id].name
        end

        if #enchantments_desc_masked == 0 and not enchantment.secondary then
            enchantments_desc_masked[#enchantments_desc_masked + 1] = self.enchantment_defs[enchantment.id].name

            if add_roman_numbers then
                enchantments_desc_masked[#enchantments_desc_masked + 1] = ' ' .. self.roman_numbers[enchantment.level]
            end
        end
    end

    enchantments_desc = '\n' .. core.colorize('#AE81FF', S('Enchanted'))
        .. '\n' .. table.concat(enchantments_desc, '\n')
    enchantments_desc_masked = table.concat(enchantments_desc_masked, '') .. '..?'

    return {
        enchantments_desc = enchantments_desc,
        enchantments_desc_masked = enchantments_desc_masked
    }
end

function XEnchanting.get_glint_texture_modifier(self, image)
    return image .. '^((' .. image .. '^[contrast:127:127)^[mask:x_enchanting_glint.png^[opacity:80)'
end

function XEnchanting.set_enchanted_tool(self, pos, itemstack, level, player_name)
    local data = self.form_context[player_name].data

    if not data then
        return
    end

    local capabilities = data.slots[level].tool_cap_data
    local description = data.slots[level].descriptions.enchantments_desc
    local final_enchantments = data.slots[level].final_enchantments
    local inv = core.get_meta(pos):get_inventory()
    local tool_def = core.registered_tools[itemstack:get_name()]
    local node_meta = core.get_meta(pos)

    if not tool_def then
        return
    end

    local stack_meta = itemstack:get_meta()
    ---@type table<string, {["value"]: number}>
    local final_enchantments_meta = {}

    ---@diagnostic disable-next-line: unused-local
    for i, enchantment in ipairs(final_enchantments) do
        stack_meta:set_float('is_' .. enchantment.id, enchantment.value)
        -- store only necessary data, keeping the meta optimized
        final_enchantments_meta[enchantment.id] = {
            value = enchantment.value
        }
    end

    stack_meta:set_tool_capabilities(capabilities)
    stack_meta:set_string('description', itemstack:get_description() .. '\n' .. description)
    stack_meta:set_string('short_description', S('Enchanted') .. ' ' .. itemstack:get_short_description())
    stack_meta:set_int('is_enchanted', 1)
    stack_meta:set_string('x_enchanting', core.serialize(final_enchantments_meta))

    if tool_def and tool_def.inventory_image and tool_def.inventory_image ~= '' then
        stack_meta:set_string('inventory_image', tool_def.inventory_image .. '^((' .. tool_def.inventory_image .. '^[contrast:127:127)^[mask:x_enchanting_glint.png^[opacity:80)')
    end

    if tool_def and tool_def.inventory_overlay and tool_def.inventory_overlay ~= '' then
        stack_meta:set_string('inventory_overlay', tool_def.inventory_overlay .. '^((' .. tool_def.inventory_overlay .. '^[contrast:127:127)^[mask:x_enchanting_glint.png^[opacity:80)')
    end

    if tool_def and tool_def.wield_image and tool_def.wield_image ~= '' then
        stack_meta:set_string('wield_image', tool_def.wield_image .. '^((' .. tool_def.wield_image .. '^[contrast:127:127)^[mask:x_enchanting_glint.png^[opacity:80)')
    end

    if tool_def and tool_def.wield_overlay and tool_def.wield_overlay ~= '' then
        stack_meta:set_string('wield_overlay', tool_def.wield_overlay .. '^((' .. tool_def.wield_overlay .. '^[contrast:127:127)^[mask:x_enchanting_glint.png^[opacity:80)')
    end

    inv:set_stack('item', 1, itemstack)

    local trade_stack = inv:get_stack('trade', 1)
    trade_stack:take_item(level)
    inv:set_stack('trade', 1, trade_stack)

    -- set new seed
    self.player_seeds[player_name] = self:get_randomseed()

    local formspec = self:get_formspec(pos, player_name)
    node_meta:set_string('formspec', formspec)

    core.sound_play('x_enchanting_enchant', {
        gain = 0.3,
        pos = pos,
        max_hear_distance = 10
    }, true)

    -- particles
    local particlespawner_def = {
        amount = 50,
        time = 0.5,
        minpos = { x = pos.x - 1, y = pos.y + 1, z = pos.z - 1 },
        maxpos = { x = pos.x + 1, y = pos.y + 1.5, z = pos.z + 1 },
        minvel = { x = -0.1, y = -0.5, z = -0.1 },
        maxvel = { x = 0.1, y = -1.5, z = 0.1 },
        minacc = { x = -0.1, y = -0.5, z = -0.1 },
        maxacc = { x = 0.1, y = -1.5, z = 0.1 },
        minexptime = 0.5,
        maxexptime = 1,
        minsize = 0.5,
        maxsize = 1,
        texture = 'x_enchanting_scroll_particle.png^[colorize:#A179E9:256',
        glow = 1
    }

    if core.has_feature({ dynamic_add_media_table = true, particlespawner_tweenable = true }) then
        -- new syntax, after v5.6.0
        particlespawner_def = {
            amount = 50,
            time = 0.5,
            size = {
                min = 0.5,
                max = 1,
            },
            exptime = 2,
            pos = {
                min = vector.new({ x = pos.x - 1.5, y = pos.y + 1, z = pos.z - 1.5 }),
                max = vector.new({ x = pos.x + 1.5, y = pos.y + 1.5, z = pos.z + 1.5 }),
            },
            attract = {
                kind = 'point',
                strength = 2,
                origin = vector.new({ x = pos.x, y = pos.y + 0.65, z = pos.z }),
                die_on_contact = true
            },
            texture = {
                name = 'x_enchanting_scroll_particle.png^[colorize:#A179E9:256',
                alpha_tween = {
                    0.5, 1,
                    style = 'fwd',
                    reps = 1
                }
            },
            glow = 1
        }
    end

    core.add_particlespawner(particlespawner_def)
end

function XEnchanting.get_enchantment_data(self, player, nr_of_bookshelfs, tool_def)
    local p_name = player:get_player_name()
    local randomseed = self.player_seeds[p_name] or self:get_randomseed()
    math.randomseed(randomseed)
    local _nr_of_bookshelfs = nr_of_bookshelfs
    local data = {
        slots = {}
    }

    if _nr_of_bookshelfs > 15 then
        _nr_of_bookshelfs = 15
    end

    ----
    -- Filter out enchantments compatible for this item group
    ----

    local group_enchantments = {}

    for enchantment_name, enchantment_def in pairs(self.enchantment_defs) do
        if not enchantment_def.groups then
            group_enchantments[enchantment_name] = enchantment_def
        else
            ---@diagnostic disable-next-line: unused-local
            for i, group in ipairs(enchantment_def.groups) do
                if core.get_item_group(tool_def.name, group) > 0 then
                    group_enchantments[enchantment_name] = enchantment_def
                    break
                end
            end
        end
    end

    ----
    -- 0 Show slots in formspec
    ----

    -- Base enchantment
    local base = math.random(1, 8) + math.floor(_nr_of_bookshelfs / 2) + math.random(0, _nr_of_bookshelfs)
    local top_slot_base_level = math.floor(math.max(base / 3, 1))
    local middle_slot_base_level = math.floor((base * 2) / 3 + 1)
    local bottom_slot_base_level = math.floor(math.max(base, _nr_of_bookshelfs * 2))

    for i, slot_lvl in ipairs({ top_slot_base_level, middle_slot_base_level, bottom_slot_base_level }) do
        ----
        -- 1 Applying modifiers to the enchantment level
        ----

        local chosen_enchantment_level = slot_lvl
        -- Applying modifiers to the enchantment level
        local enchantability = core.get_item_group(tool_def.name, 'enchantability')
        -- Generate a random number between 1 and 1+(enchantability/2), with a triangular distribution
        local rand_enchantability = 1 + math.random(enchantability / 4 + 1) + math.random(enchantability / 4 + 1)
        -- Choose the enchantment level
        local k = chosen_enchantment_level + rand_enchantability
        -- A random bonus, between .85 and 1.15
        local rand_bonus_percent = 1 + ((math.random(0, 99) / 100) + (math.random(0, 99) / 100) - 1) * 0.15
        -- Finally, we calculate the level
        local final_level = math.round(k * rand_bonus_percent)

        if final_level < 1 then
            final_level = 1
        end

        ----
        -- 2 Find possible enchantments
        ----

        ---@type Enchantment[]
        local possible_enchantments = {}

        -- Get level
        -- If the modified level is within two overlapping ranges for the same
        -- enchantment type, the higher power value is used.
        for enchantment_name, enchantment_def in pairs(group_enchantments) do
            local levels = {}

            -- find matching levels
            for level, final_level_range in ipairs(enchantment_def.final_level_range) do
                local min = final_level_range[1]
                local max = final_level_range[2]

                if final_level >= min and final_level <= max then
                    table.insert(levels, level)
                end
            end

            -- pick the highest level
            local level = levels[#levels]

            if level then
                table.insert(possible_enchantments, {
                    id = enchantment_name,
                    value = enchantment_def.level_def[level],
                    level = level,
                    secondary = enchantment_def.secondary,
                    incompatible = enchantment_def.incompatible
                })
            end
        end

        ----
        -- 3 Select a set of enchantments from the list
        ----

        ---@type Enchantment[]
        local final_enchantments = {}
        local total_weight = 0

        -- calculate total weight
        ---@diagnostic disable-next-line: unused-local
        for j, enchantment in ipairs(possible_enchantments) do
            total_weight = total_weight + self.enchantment_defs[enchantment.id].weight
        end

        -- Pick a random integer in the half range [0; total_weight / 2] as a number `rand_weight`
        local rand_weight = math.random(0, total_weight / 2)
        -- local probability = (final_level + 1) / 50
        local probability_level = final_level
        ---@type Enchantment[]
        local possible_enchantments_excl_secodnary = {}

        for _, enchantment in pairs(possible_enchantments) do
            if not enchantment.secondary then
                table.insert(possible_enchantments_excl_secodnary, enchantment)
            end
        end

        -- Select final enchantments
        -- Iterate through each enchantment in the list, subtracting its weight from `rand_weight`.
        -- If `rand_weight` is now negative, select the current enchantment.
        for j = 1, #possible_enchantments, 1 do
            local rand_ench_idx = math.random(1, #possible_enchantments)
            local rand_ench = possible_enchantments[rand_ench_idx]

            if j == 1 then
                -- First pick
                -- Dont add cursed/secondary enchantment as first pick
                rand_ench_idx = math.random(1, #possible_enchantments_excl_secodnary)
                rand_ench = possible_enchantments_excl_secodnary[rand_ench_idx]

                table.insert(final_enchantments, rand_ench)

                for idx, value in pairs(possible_enchantments) do
                    if rand_ench.id == value.id then
                        table.remove(possible_enchantments, idx)
                    end

                    -- remove incomaptible enchantments
                    if rand_ench.incompatible
                        and table.indexof(rand_ench.incompatible, value.id) ~= -1
                    then
                        table.remove(possible_enchantments, idx)
                    end
                end
            else
                local probability = (probability_level + 1) / 50

                local alreadyInTable = tableFind(final_enchantments, function(value)
                    return value.id == rand_ench.id
                end)

                if not alreadyInTable then
                    table.insert(final_enchantments, rand_ench)
                end

                table.remove(possible_enchantments, rand_ench_idx)

                for idx, value in pairs(possible_enchantments) do
                    -- remove incomaptible enchantments
                    if rand_ench.incompatible
                        and table.indexof(rand_ench.incompatible, value.id) ~= -1
                    then
                        table.remove(possible_enchantments, idx)
                    end
                end

                -- With probability (`final_level` + 1) / 50, keep going. Otherwise, stop picking bonus enchantments.
                local rand_probability = math.random()

                if rand_probability < probability then
                    -- Divide the `final_level` in half, rounded down
                    -- (this does not affect the possible enchantments themselves,
                    -- because they were all pre-calculated in Step Two).
                    break
                end

                -- Repeat from the beginning.
                probability_level = probability_level / 2
            end

            rand_weight = rand_weight - self.enchantment_defs[rand_ench.id].weight

            -- If `rand_weight` is now negative, select the current enchantment and stop.
            if rand_weight < 0 then
                break
            end
        end

        local tool_cap_data = self:get_enchanted_tool_capabilities(tool_def, final_enchantments)
        local descriptions = self:get_enchanted_descriptions(final_enchantments)

        table.insert(data.slots, i, {
            level = slot_lvl,
            final_enchantments = final_enchantments,
            tool_cap_data = tool_cap_data,
            descriptions = descriptions
        })
    end

    return data
end

local function get_hotbar_bg(x, y)
    local out = ''

    for i = 0, 7, 1 do
        out = out .. 'image[' .. x + i .. ',' .. y .. ';1,1;x_enchanting_gui_hb_bg.png]'
    end

    return out
end

local function get_list_bg(x, y)
    local out = ''

    for row = 0, 2, 1 do
        for i = 0, 7, 1 do
            out = out .. 'image[' .. x + i .. ',' .. y + row .. ';1,1;x_enchanting_gui_slot_bg.png]'
        end
    end

    return out
end

local function get_formspec_bg(player_name, bg_img)
    local bg_image = bg_img and bg_img or 'x_enchanting_gui_formbg.png'
    local info = core.get_player_information(player_name)
    local bg = 'background[5,5;1,1;' .. bg_image .. ';true]'

    if info.formspec_version > 1 then
        bg = 'background9[5,5;1,1;' .. bg_image .. ';true;10]'
    end

    return bg
end

function XEnchanting.get_formspec(self, pos, player_name, data)
    local spos = pos.x .. ',' .. pos.y .. ',' .. pos.z
    local inv = core.get_meta(pos):get_inventory()
    ---@diagnostic disable-next-line: codestyle-check
    local model_scroll_open = 'model[0,0;2,3;x_enchanting_table;x_enchanting_scroll.b3d;x_enchanting_scroll_mesh.png,x_enchanting_scroll_handles_mesh.png,x_enchanting_scroll_mesh.png;89,0;false;false;' .. self.scroll_animations.scroll_open_idle[1].x .. ',' .. self.scroll_animations.scroll_open_idle[1].y .. ';0]'
    ---@diagnostic disable-next-line: codestyle-check
    local model_scroll_closed = 'model[0,0;2,3;x_enchanting_table;x_enchanting_scroll.b3d;x_enchanting_scroll_mesh.png,x_enchanting_scroll_handles_mesh.png,x_enchanting_scroll_mesh.png;89,0;false;false;' .. self.scroll_animations.scroll_closed_idle[1].x .. ',' .. self.scroll_animations.scroll_closed_idle[1].y .. ';0]'
    local model_scroll_is_open

    local formspec = {
        'size[8,9]',
        'bgcolor[#080808BB;true]',
        'listcolors[#FFFFFF00;#FFFFFF1A;#FFFFFF00;#30434C;#FFF]',
        get_formspec_bg(player_name),
        'style_type[label;font=mono,bold]',
        'style[slot_1,slot_2,slot_3;font=mono,bold;textcolor=#4D413A]',
        'label[0, 0;' .. S('Enchant') .. ']',
        -- item
        'list[nodemeta:' .. spos .. ';item;0, 2.5;1, 1;]',
        'image[0, 2.5;1,1;x_enchanting_gui_cloth_bg.png]',
        -- trade
        'list[nodemeta:' .. spos .. ';trade;1, 2.5;1, 1;]',
        'image[1, 2.5;1,1;x_enchanting_gui_cloth_trade_bg.png]',
        -- inventories
        'list[current_player;main;0, 4.85;8, 1;]',
        'list[current_player;main;0, 6.08;8, 3;8]',
        'listring[nodemeta:' .. spos .. ';trade]',
        'listring[current_player;main]',
        'listring[nodemeta:' .. spos .. ';item]',
        'listring[current_player;main]',
    }

    formspec[#formspec + 1] = get_hotbar_bg(0, 4.85)
    formspec[#formspec + 1] = get_list_bg(0, 6.08)

    -- data
    if data then
        for i, slot in ipairs(data.slots) do
            if #slot.final_enchantments > 0 then
                -- show buttons with content

                if inv:get_stack('trade', 1):get_count() >= i then
                    ---@diagnostic disable-next-line: codestyle-check
                    formspec[#formspec + 1] = 'image_button[3.125,' .. -0.5 + i .. ';5.125,1;x_enchanting_image_button.png;slot_' .. i .. ';' .. slot.descriptions.enchantments_desc_masked .. core.formspec_escape(' [' .. slot.level .. ']') .. ']'
                else
                    ---@diagnostic disable-next-line: codestyle-check
                    formspec[#formspec + 1] = 'image_button[3.125,' .. -0.5 + i .. ';5.125,1;x_enchanting_image_button_disabled.png;slot_' .. i .. ';' .. slot.descriptions.enchantments_desc_masked .. core.formspec_escape(' [' .. slot.level .. ']') .. ']'
                end

                formspec[#formspec + 1] = 'image[2.3,' .. -0.5 + i .. ';1,1;x_enchanting_image_trade_' .. i .. '.png;]'
            else
                -- disabled buttons
                ---@diagnostic disable-next-line: codestyle-check
                formspec[#formspec + 1] = 'image_button[3.125,' .. -0.5 + i .. ';5.125,1;x_enchanting_image_button_disabled.png;slot_' .. i .. ';]'
            end
        end

        model_scroll_is_open = true
    else
        for i = 1, 3, 1 do
            -- disabled buttons
            ---@diagnostic disable-next-line: codestyle-check
            formspec[#formspec + 1] = 'image_button[3.125,' .. -0.5 + i .. ';5.125,1;x_enchanting_image_button_disabled.png;slot_' .. i .. ';]'
        end

        model_scroll_is_open = false
    end

    if model_scroll_is_open then
        formspec[#formspec + 1] = model_scroll_open
    else
        formspec[#formspec + 1] = model_scroll_closed
    end

    self.form_context[player_name] = {
        data = data,
        pos = pos
    }

    return table.concat(formspec, '')
end

function XEnchanting.get_grindstone_formspec(self, pos, player_name, data)
    local _data = data or {}
    local spos = pos.x .. ',' .. pos.y .. ',' .. pos.z
    local model = 'model[0,0;2,3;x_enchanting_grindstone;x_enchanting_grindstone.obj;x_enchanting_grindstone_mesh.png;0,0;true;false;]'

    local formspec = {}
    formspec[#formspec + 1] = 'size[8,9]'
    formspec[#formspec + 1] = 'bgcolor[#080808BB;true]'
    formspec[#formspec + 1] = 'listcolors[#FFFFFF00;#FFFFFF1A;#FFFFFF00;#30434C;#FFF]'
    formspec[#formspec + 1] = get_formspec_bg(player_name)
    formspec[#formspec + 1] = 'style_type[label;font=mono,bold]'
    formspec[#formspec + 1] = 'style[slot_1,slot_2,slot_3;font=mono,bold;textcolor=#4D413A]'
    formspec[#formspec + 1] = 'label[0, 0;' .. S('Disenchant') .. ']'
    -- item
    formspec[#formspec + 1] = 'list[nodemeta:' .. spos .. ';item;0.5, 2.5;1, 1;]'
    formspec[#formspec + 1] = 'image[0.5, 2.5;1,1;x_enchanting_gui_cloth_bg.png]'
    -- result
    if _data.result_disabled then
        formspec[#formspec + 1] = 'image[4.75, 1.25;1.5,1.5;x_enchanting_gui_cloth_bg_corssed.png]'
    else
        formspec[#formspec + 1] = 'list[nodemeta:' .. spos .. ';result;5, 1.5;1, 1;]'
        formspec[#formspec + 1] = 'image[5, 1.5;1,1;x_enchanting_gui_cloth_bg.png]'
    end

    -- inventories
    formspec[#formspec + 1] = 'list[current_player;main;0, 4.85;8, 1;]'
    formspec[#formspec + 1] = 'list[current_player;main;0, 6.08;8, 3;8]'
    formspec[#formspec + 1] = 'listring[nodemeta:' .. spos .. ';result]'
    formspec[#formspec + 1] = 'listring[current_player;main]'
    formspec[#formspec + 1] = 'listring[nodemeta:' .. spos .. ';item]'
    formspec[#formspec + 1] = 'listring[current_player;main]'

    formspec[#formspec + 1] = get_hotbar_bg(0, 4.85)
    formspec[#formspec + 1] = get_list_bg(0, 6.08)
    formspec[#formspec + 1] = model

    return table.concat(formspec, '')
end

function XEnchanting.has_all_cursed_ench(self, itemstack)
    if itemstack:is_empty() then
        return false
    end

    local item_stack_meta = itemstack:get_meta()
    local stack_enchantment_data = core.deserialize(item_stack_meta:get_string('x_enchanting')) or {}
    local stack_enchantment_data_length = get_table_length(stack_enchantment_data)
    local cursed_ench = 0

    -- Get cursed enchantments
    for id, value in pairs(stack_enchantment_data) do
        local ench_def = self.enchantment_defs[id]

        if ench_def.cursed then
            cursed_ench = cursed_ench + 1
        end
    end

    return cursed_ench == stack_enchantment_data_length
end

--
-- Sounds
--

function XEnchanting.node_sound_wood_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_enchanting_wood_footstep', gain = 0.15 }
    table.dig = table.dig or { name = 'x_enchanting_wood_hit', gain = 0.5 }
    table.dug = table.dug or { name = 'x_enchanting_wood_place', gain = 0.1 }
    table.place = table.place or { name = 'x_enchanting_wood_place', gain = 0.15 }
    return table
end
