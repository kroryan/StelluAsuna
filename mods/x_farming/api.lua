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

-- main class
x_farming = {
    hunger_ng = core.get_modpath('hunger_ng'),
    hbhunger = core.get_modpath('hbhunger') and core.global_exists('hbhunger'),
    vessels = core.get_modpath('vessels'),
    bucket = core.get_modpath('bucket'),
    colors = {
        brown = '#DEB887',
        red = '#FF8080',
        green = '#98E698'
    },
    x_bonemeal = {
        tree_defs = {
            ['x_farming:christmas_tree_sapling'] = {
                -- christmas tree
                name = 'x_farming:christmas_tree_sapling',
                chance = 2,
                grow_tree = function(pos)
                    if not x_farming.x_bonemeal.is_on_soil(pos) then
                        return false
                    end

                    x_farming.grow_christmas_tree(pos)

                    return true
                end
            },
            ['x_farming:kiwi_sapling'] = {
                -- Kiwi Tree
                name = 'x_farming:kiwi_sapling',
                chance = 2,
                grow_tree = function(pos)
                    if not x_farming.x_bonemeal.is_on_soil(pos) then
                        return false
                    end

                    x_farming.grow_kiwi_tree(pos)

                    return true
                end
            },
            ['x_farming:large_cactus_with_fruit_seedling'] = {
                -- Cactus Seedling
                name = 'x_farming:large_cactus_with_fruit_seedling',
                chance = 2,
                grow_tree = function(pos)
                    if not x_farming.x_bonemeal.is_on_sand(pos) then
                        return false
                    end

                    x_farming.grow_large_cactus(pos)

                    return true
                end
            },
            ['x_farming:jungle_with_cocoa_sapling'] = {
                -- Jungle Tree with Cocoa
                name = 'x_farming:jungle_with_cocoa_sapling',
                chance = 2,
                grow_tree = function(pos)
                    if not x_farming.x_bonemeal.is_on_soil(pos) then
                        return false
                    end

                    x_farming.grow_jungle_tree(pos)

                    return true
                end
            },
            ['x_farming:pine_nut_sapling'] = {
                -- Pine Nut Tree
                name = 'x_farming:pine_nut_sapling',
                chance = 2,
                grow_tree = function(pos)
                    if not x_farming.x_bonemeal.is_on_soil(pos) then
                        return false
                    end

                    x_farming.grow_pine_nut_tree(pos)

                    return true
                end
            },
        }
    },
    allowed_crate_items = {},
    allowed_bag_items = {},
    registered_crates = {},
    lbm_nodenames_crates = {},
    registered_plants = {},
    mcl = {},
    candle_colors = {
        black = {
            name = S('Black'),
            hex = '#2B2B2B',
            mcl_groups = { basecolor_black = 1, excolor_black = 1, unicolor_black = 1 }
        },
        dark_grey = {
            name = S('Dark Grey'),
            hex = '#4E4E4E',
            mcl_groups = { basecolor_grey = 1, excolor_darkgrey = 1, unicolor_darkgrey = 1 }
        },
        grey = {
            name = S('Grey'),
            hex = '#A5A5A5',
            mcl_groups = { basecolor_grey = 1, excolor_grey = 1, unicolor_grey = 1 }
        },
        red = {
            name = S('Red'),
            hex = '#AB5C4A',
            mcl_groups = { basecolor_red = 1, excolor_red = 1, unicolor_red = 1 }
        },
        violet = {
            name = S('Violet'),
            hex = '#595287',
            mcl_groups = { basecolor_magenta = 1, excolor_violet = 1, unicolor_violet = 1 }
        },
        magenta = {
            name = S('Magenta'),
            hex = '#A25B5D',
            mcl_groups = { basecolor_magenta = 1, excolor_red_violet = 1, unicolor_red_violet = 1 }
        },
        pink = {
            name = S('Pink'),
            hex = '#FFA6A6',
            mcl_groups = { basecolor_red = 1, excolor_red = 1, unicolor_light_red = 1 }
        },
        dark_green = {
            name = S('Dark Green'),
            hex = '#556E48',
            mcl_groups = { basecolor_green = 1, excolor_green = 1, unicolor_dark_green = 1 }
        },
        green = {
            name = S('Green'),
            hex = '#779154',
            mcl_groups = { basecolor_green = 1, excolor_green = 1, unicolor_green = 1 }
        },
        cyan = {
            name = S('Cyan'),
            hex = '#4E7683',
            mcl_groups = { basecolor_cyan = 1, excolor_cyan = 1, unicolor_cyan = 1 }
        },
        blue = {
            name = S('Blue'),
            hex = '#4B6696',
            mcl_groups = { basecolor_blue = 1, excolor_blue = 1, unicolor_blue = 1 }
        },
        light_blue = {
            name = S('Light Blue'),
            hex = '#648CB4',
            craft_dye = 'group:dye,color_light_blue',
            mcl_groups = { basecolor_blue = 1, excolor_blue = 1, unicolor_light_blue = 1 }
        },
        orange = {
            name = S('Orange'),
            hex = '#A86A4D',
            mcl_groups = { basecolor_orange = 1, excolor_orange = 1, unicolor_orange = 1 }
        },
        yellow = {
            name = S('Yellow'),
            hex = '#BD8D39',
            mcl_groups = { basecolor_yellow = 1, excolor_yellow = 1, unicolor_yellow = 1 }
        },
        brown = {
            name = S('Brown'),
            hex = '#684E45',
            mcl_groups = { basecolor_brown = 1, excolor_orange = 1, unicolor_dark_orange = 1 }
        }
    },
}

function x_farming.node_sound_grass_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_grass_footstep', gain = 0.4 }
    table.dig = table.dig or { name = 'x_farming_grass_hit', gain = 1.2 }
    table.dug = table.dug or { name = 'x_farming_dirt_hit', gain = 1.0 }
    table.place = table.place or { name = 'x_farming_dirt_hit', gain = 1.0 }
    return table
end

function x_farming.node_sound_leaves_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_leaves_footstep', gain = 0.1 }
    table.dig = table.dig or { name = 'x_farming_leaves_hit', gain = 0.25 }
    table.dug = table.dug or { name = 'x_farming_leaves_dug', gain = 0.5 }
    table.place = table.place or { name = 'x_farming_leaves_place', gain = 0.4 }
    return table
end

function x_farming.node_sound_wood_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_wood_footstep', gain = 0.15 }
    table.dig = table.dig or { name = 'x_farming_wood_hit', gain = 0.5 }
    table.dug = table.dug or { name = 'x_farming_wood_place', gain = 0.1 }
    table.place = table.place or { name = 'x_farming_wood_place', gain = 0.15 }
    return table
end

function x_farming.node_sound_sand_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_sand_footstep', gain = 0.1 }
    table.dig = table.dig or { name = 'x_farming_sand_hit', gain = 0.5 }
    table.dug = table.dug or { name = 'x_farming_sand_dug', gain = 0.1 }
    table.place = table.place or { name = 'x_farming_sand_place', gain = 0.15 }
    return table
end

function x_farming.node_sound_thin_glass_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_thin_glass_footstep', gain = 0.3 }
    table.dig = table.dig or { name = 'x_farming_thin_glass_footstep', gain = 0.5 }
    table.dug = table.dug or { name = 'x_farming_break_thin_glass', gain = 1.0 }
    table.place = table.place or { name = 'x_farming_glass_place', gain = 0.2 }
    return table
end

function x_farming.node_sound_dirt_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_dirt_footstep', gain = 0.15 }
    table.dig = table.dig or { name = 'x_farming_dirt_hit', gain = 0.4 }
    table.dug = table.dug or { name = 'x_farming_dirt_hit', gain = 1.0 }
    table.place = table.place or { name = 'x_farming_dirt_hit', gain = 1.0 }
    return table
end

function x_farming.node_sound_ice_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_ice_footstep', gain = 0.2 }
    table.dig = table.dig or { name = 'x_farming_ice_hit', gain = 0.4 }
    table.dug = table.dug or { name = 'x_farming_ice_hit', gain = 1.0 }
    table.place = table.place or { name = 'x_farming_ice_hit', gain = 1.0 }
    return table
end

function x_farming.node_sound_stone_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_stone_footstep', gain = 0.2 }
    table.dig = table.dig or { name = 'x_farming_stone_hit', gain = 1.0 }
    table.dug = table.dug or { name = 'x_farming_stone_dug', gain = 0.6 }
    table.place = table.place or { name = 'x_farming_stone_place', gain = 1.0 }
    return table
end

function x_farming.node_sound_slime_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_slime_footstep', gain = 0.2 }
    table.dig = table.dig or { name = 'x_farming_slime_dig', gain = 1.0 }
    table.dug = table.dug or { name = 'x_farming_slime_dug', gain = 0.3 }
    table.place = table.place or { name = 'x_farming_slime_footstep', gain = 1.0 }
    return table
end

function x_farming.node_sound_rope_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_rope_footstep', gain = 0.05 }
    table.dig = table.dig or { name = 'x_farming_rope_hit', gain = 0.7 }
    table.dug = table.dug or { name = 'x_farming_rope_dug', gain = 0.2 }
    table.place = table.place or { name = 'x_farming_rope_hit', gain = 0.8 }
    return table
end

function x_farming.node_sound_pillow_defaults(table)
    table = table or {}
    table.footstep = table.footstep or { name = 'x_farming_pillow_footstep', gain = 0.1 }
    table.dig = table.dig or { name = 'x_farming_pillow_hit', gain = 0.15 }
    table.dug = table.dug or { name = 'x_farming_pillow_dug', gain = 0.2 }
    table.place = table.place or { name = 'x_farming_pillow_footstep', gain = 0.25 }
    return table
end

---how often node timers for plants will tick, +/- some random value
function x_farming.tick_block(pos)
    core.get_node_timer(pos):start(math.random(498, 1287))
end

---how often a growth failure tick is retried (e.g. too dark)
function x_farming.tick_block_short(pos)
    core.get_node_timer(pos):start(math.random(332, 858))
end

-- how often node timers for plants will tick, +/- some random value
function x_farming.tick(pos)
    core.get_node_timer(pos):start(math.random(166, 286))
end
-- how often a growth failure tick is retried (e.g. too dark)
function x_farming.tick_again(pos)
    core.get_node_timer(pos):start(math.random(40, 80))
end

---just shorthand for minetest metadata handling
function x_farming.meta_get_str(key, pos)
    local meta = core.get_meta(pos)
    return meta:get_string(key)
end

---just shorthand for minetest metadata handling
function x_farming.meta_set_str(key, value, pos)
    local meta = core.get_meta(pos)
    meta:set_string(key, value)
end

---merge two indexed tables
function x_farming.mergeTables(t1, t2)
    local _t1 = { unpack(t1) }
    local _t2 = { unpack(t2) }

    for k, v in ipairs(_t2) do
        table.insert(_t1, v)
    end

    return _t1
end

---Change an entire string to Title Case (i.e. capitalise the first letter of each word)
function x_farming.tchelper(first, rest)
    return first:upper() .. rest:lower()
end

--- Hoes - copy from MTG

x_farming.hoe_on_use = function(itemstack, user, pointed_thing, uses)
    local pt = pointed_thing
    -- check if pointing at a node
    if not pt then
        return
    end
    if pt.type ~= 'node' then
        return
    end

    local under = core.get_node(pt.under)
    local p = { x = pt.under.x, y = pt.under.y + 1, z = pt.under.z }
    local above = core.get_node(p)

    -- return if any of the nodes is not registered
    if not core.registered_nodes[under.name] then
        return
    end
    if not core.registered_nodes[above.name] then
        return
    end

    -- check if the node above the pointed thing is air
    if above.name ~= 'air' then
        return
    end

    -- check if pointing at soil
    if core.get_item_group(under.name, 'soil') ~= 1 then
        return
    end

    -- check if (wet) soil defined
    local regN = core.registered_nodes
    if regN[under.name].soil == nil or regN[under.name].soil.wet == nil or regN[under.name].soil.dry == nil then
        return
    end

    local player_name = user and user:get_player_name() or ''

    if core.is_protected(pt.under, player_name) then
        core.record_protection_violation(pt.under, player_name)
        return
    end

    if core.is_protected(pt.above, player_name) then
        core.record_protection_violation(pt.above, player_name)
        return
    end

    -- turn the node into soil and play sound
    core.set_node(pt.under, { name = regN[under.name].soil.dry })
    core.sound_play('x_farming_dirt_hit', {
        pos = pt.under,
        gain = 0.3,
    }, true)

    if not core.is_creative_enabled(player_name) then
        -- wear tool
        local wdef = itemstack:get_definition()
        itemstack:add_wear_by_uses(uses)
        -- tool break sound
        if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
            core.sound_play(wdef.sound.breaks, {pos = pt.above,
                gain = 0.5}, true)
        end
    end
    return itemstack
end

-- Register new hoes
x_farming.register_hoe = function(name, def)
    local _def = table.copy(def)
    -- Check for : prefix (register new hoes in your mod's namespace)
    if name:sub(1, 1) ~= ':' then
        name = ':' .. name
    end
    -- Check def table
    if _def.description == nil then
        _def.description = S('Hoe')
    end
    if _def.inventory_image == nil then
        _def.inventory_image = 'x_farming_unknown_item.png'
    end
    if _def.max_uses == nil then
        _def.max_uses = 30
    end

    if core.get_modpath('farming') then
        _def.on_use = function(itemstack, user, pointed_thing)
            return x_farming.hoe_on_use(itemstack, user, pointed_thing, _def.max_uses)
        end
    end

    if core.get_modpath('mcl_farming') then
        _def.on_place = x_farming.mcl.hoe_on_place_function(_def.max_uses)
    end

    -- MCL
    _def.groups = _def.groups
    _def.sound = { breaks = 'x_farming_tool_breaks' }
    _def.wield_scale = _def.wield_scale or { x = 1, y = 1, z = 1 }

    -- Register the tool
    core.register_tool(name, _def)
    -- Register its recipe
    if _def.recipe then
        core.register_craft({
            output = name:sub(2),
            recipe = _def.recipe
        })
    elseif _def.material then
        core.register_craft({
            output = name:sub(2),
            recipe = {
                { _def.material, 'group:stick' },
                { _def.material, 'group:stick' },
                { '', 'group:stick' }
            }
        })
    end
end

--
-- Log API / helpers - copy from MTG
--

local log_non_player_actions = core.settings:get_bool('log_non_player_actions', false)

local is_pos = function(v)
    return type(v) == 'table' and
        type(v.x) == 'number' and type(v.y) == 'number' and type(v.z) == 'number'
end

function x_farming.log_player_action(player, ...)
    local msg = player:get_player_name()
    if player.is_fake_player or not player:is_player() then
        if not log_non_player_actions then
            return
        end
        msg = msg .. '(' .. (type(player.is_fake_player) == 'string'
            and player.is_fake_player or '*') .. ')'
    end
    for _, v in ipairs({ ... }) do
        -- translate pos
        local part = is_pos(v) and core.pos_to_string(v) or v
        -- no leading spaces before punctuation marks
        msg = msg .. (string.match(part, '^[;,.]') and '' or ' ') .. part
    end
    core.log('action', msg)
end

function x_farming.set_inventory_action_loggers(def, name)
    def.on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        x_farming.log_player_action(player, 'moves stuff in', name, 'at', pos)
    end
    def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
        x_farming.log_player_action(player, 'moves', stack:get_name(), 'to', name, 'at', pos)
    end
    def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
        x_farming.log_player_action(player, 'takes', stack:get_name(), 'from', name, 'at', pos)
    end
end

--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function x_farming.sapling_on_place(itemstack, placer, pointed_thing, sapling_name, minp_relative, maxp_relative, interval)
    -- Position of sapling
    local pos = pointed_thing.under
    local node = core.get_node_or_nil(pos)
    local pdef = node and core.registered_nodes[node.name]

    if not node then
        return itemstack
    end

    if pdef and pdef.on_rightclick and
        not (placer and placer:is_player() and
        placer:get_player_control().sneak)
    then
        return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
    end

    if not pdef or not pdef.buildable_to then
        pos = pointed_thing.above
        node = core.get_node_or_nil(pos)
        pdef = node and core.registered_nodes[node.name]
        if not pdef or not pdef.buildable_to then
            return itemstack
        end
    end

    local player_name = placer and placer:get_player_name() or ''

    -- Check sapling position for protection
    if core.is_protected(pos, player_name) then
        core.record_protection_violation(pos, player_name)
        return itemstack
    end

    -- Check tree volume for protection
    if core.is_area_protected(
            vector.add(pos, minp_relative),
            vector.add(pos, maxp_relative),
            player_name,
            interval) then
        core.record_protection_violation(pos, player_name)
        -- Print extra information to explain
        -- core.chat_send_player(player_name,
        -- itemstack:get_definition().description .. ' will intersect protection ' ..
        -- 'on growth')
        core.chat_send_player(
            player_name,
            S('@1 will intersect protection on growth.', itemstack:get_definition().description)
        )
        return itemstack
    end

    x_farming.log_player_action(placer, 'places node', sapling_name, 'at', pos)

    local take_item = not core.is_creative_enabled(player_name)
    local newnode = { name = sapling_name }
    local ndef = core.registered_nodes[sapling_name]
    core.set_node(pos, newnode)

    -- Run callback
    if ndef and ndef.after_place_node then
        -- Deepcopy place_to and pointed_thing because callback can modify it
        if ndef.after_place_node(table.copy(pos), placer, itemstack, table.copy(pointed_thing)) then
            take_item = false
        end
    end

    -- Run script hook
    for _, callback in ipairs(core.registered_on_placenodes) do
        -- Deepcopy pos, node and pointed_thing because callback can modify them
        if callback(table.copy(pos), table.copy(newnode),
                placer, table.copy(node or {}),
                itemstack, table.copy(pointed_thing)) then
            take_item = false
        end
    end

    if take_item then
        itemstack:take_item()
    end

    return itemstack
end

--
-- Leafdecay
--

-- Prevent decay of placed leaves

function x_farming.after_place_leaves(pos, placer, itemstack, pointed_thing)
    if placer and placer:is_player() then
        local node = core.get_node(pos)
        node.param2 = 1
        core.set_node(pos, node)
    end
end

-- Leafdecay
local function leafdecay_after_destruct(pos, oldnode, def)
    for _, v in pairs(core.find_nodes_in_area(vector.subtract(pos, def.radius), vector.add(pos, def.radius), def.leaves)) do
        local node = core.get_node(v)
        local timer = core.get_node_timer(v)
        if (node.param2 ~= 1 or core.get_item_group('cocoa') == 0) and not timer:is_started() then
            timer:start(math.random(20, 120) / 10)
        end
    end
end

local movement_gravity = tonumber(core.settings:get('movement_gravity')) or 9.81

local function leafdecay_on_timer(pos, def)
    if core.find_node_near(pos, def.radius, def.trunks) then
        return false
    end

    local node = core.get_node(pos)
    local drops = core.get_node_drops(node.name)
    for _, item in ipairs(drops) do
        local is_leaf
        for _, v in pairs(def.leaves) do
            if v == item then
                is_leaf = true
            end
        end

        if core.get_item_group(item, 'leafdecay_drop') ~= 0 or not is_leaf then
            core.add_item({
                x = pos.x - 0.5 + math.random(),
                y = pos.y - 0.5 + math.random(),
                z = pos.z - 0.5 + math.random(),
            }, item)
        end
    end

    core.remove_node(pos)
    core.check_for_falling(pos)

    -- spawn a few particles for the removed node
    core.add_particlespawner({
        amount = 8,
        time = 0.001,
        minpos = vector.subtract(pos, { x = 0.5, y = 0.5, z = 0.5 }),
        maxpos = vector.add(pos, { x = 0.5, y = 0.5, z = 0.5 }),
        minvel = vector.new(-0.5, -1, -0.5),
        maxvel = vector.new(0.5, 0, 0.5),
        minacc = vector.new(0, -movement_gravity, 0),
        maxacc = vector.new(0, -movement_gravity, 0),
        minsize = 0,
        maxsize = 0,
        node = node,
    })
end

function x_farming.register_leafdecay(def)
    assert(def.leaves)
    assert(def.trunks)
    assert(def.radius)

    for _, v in pairs(def.trunks) do
        core.override_item(v, {
            after_destruct = function(pos, oldnode)
                leafdecay_after_destruct(pos, oldnode, def)
            end,
        })
    end

    for _, v in pairs(def.leaves) do
        core.override_item(v, {
            on_timer = function(pos)
                leafdecay_on_timer(pos, def)
            end,
        })
    end
end

-- Seed placement - copy from MTG
function x_farming.place_seed(itemstack, placer, pointed_thing, plantname)
    local pt = pointed_thing
    -- check if pointing at a node
    if not pt then
        return itemstack
    end
    if pt.type ~= 'node' then
        return itemstack
    end

    local under = core.get_node(pt.under)
    local above = core.get_node(pt.above)

    local player_name = placer and placer:get_player_name() or ''

    if core.is_protected(pt.under, player_name) then
        core.record_protection_violation(pt.under, player_name)
        return itemstack
    end
    if core.is_protected(pt.above, player_name) then
        core.record_protection_violation(pt.above, player_name)
        return itemstack
    end

    -- return if any of the nodes is not registered
    if not core.registered_nodes[under.name] then
        return itemstack
    end
    if not core.registered_nodes[above.name] then
        return itemstack
    end

    -- check if pointing at the top of the node
    if pt.above.y ~= pt.under.y + 1 then
        return itemstack
    end

    -- check if you can replace the node above the pointed node
    if not core.registered_nodes[above.name].buildable_to then
        return itemstack
    end

    -- check if pointing at soil
    if core.get_item_group(under.name, 'soil') < 2 then
        return itemstack
    end

    -- add the node and remove 1 item from the itemstack
    x_farming.log_player_action(placer, 'places node', plantname, 'at', pt.above)
    core.add_node(pt.above, { name = plantname, param2 = 1 })
    x_farming.tick(pt.above)
    if not core.is_creative_enabled(player_name) then
        itemstack:take_item()
    end

    return itemstack
end

x_farming.grow_plant = function(pos, elapsed)
    local node = core.get_node(pos)
    local name = node.name
    local def = core.registered_nodes[name]

    if not def.next_plant then
        -- disable timer for fully grown plant
        return
    end

    -- grow seed
    if core.get_item_group(node.name, 'seed') and def.fertility then
        local soil_node = core.get_node_or_nil({ x = pos.x, y = pos.y - 1, z = pos.z })
        if not soil_node then
            x_farming.tick_again(pos)
            return
        end
        -- omitted is a check for light, we assume seeds can germinate in the dark.
        for _, v in pairs(def.fertility) do
            if core.get_item_group(soil_node.name, v) ~= 0 or string.find(soil_node.name, 'mcl_farming:soil') then
                local placenode = { name = def.next_plant }
                if def.place_param2 then
                    placenode.param2 = def.place_param2
                end
                core.swap_node(pos, placenode)
                if core.registered_nodes[def.next_plant].next_plant then
                    x_farming.tick(pos)
                    return
                end
            end
        end

        return
    end

    -- check if on wet soil
    local below = core.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })
    if core.get_item_group(below.name, 'soil') < 3 then
        x_farming.tick_again(pos)
        return
    end

    -- check light
    local light = core.get_node_light(pos)
    if not light or light < def.minlight or light > def.maxlight then
        x_farming.tick_again(pos)
        return
    end

    -- grow
    local placenode = { name = def.next_plant }
    if def.place_param2 then
        placenode.param2 = def.place_param2
    end
    core.swap_node(pos, placenode)

    -- new timer needed?
    if core.registered_nodes[def.next_plant].next_plant then
        x_farming.tick(pos)
    end
    return
end

-- Register plants
x_farming.register_plant = function(name, def)
    local mname = name:split(':')[1]
    local pname = name:split(':')[2]

    -- Check def table
    if not def.description then
        def.description = S('Seed')
    end
    if not def.harvest_description then
        def.harvest_description = pname:gsub('^%l', string.upper)
    end
    if not def.inventory_image then
        def.inventory_image = 'unknown_item.png'
    end
    if not def.steps then
        return nil
    end
    if not def.minlight then
        def.minlight = 1
    end
    if not def.maxlight then
        def.maxlight = 14
    end
    if not def.fertility then
        def.fertility = {}
    end

    x_farming.registered_plants[pname] = def

    -- Register seed
    local lbm_nodes = { mname .. ':seed_' .. pname }
    local g = {
        -- MTG
        seed = 1,
        snappy = 3,
        attached_node = 1,
        flammable = 2,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    }

    for k, v in pairs(def.fertility) do
        g[v] = 1
    end

    if def.groups then
        for group, value in pairs(def.groups) do
            g[group] = value
        end
    end

    core.register_node(':' .. mname .. ':seed_' .. pname, {
        description = def.description,
        tiles = def.tiles or { def.inventory_image },
        inventory_image = def.inventory_image,
        wield_image = def.inventory_image,
        drawtype = def.drawtype or 'signlike',
        groups = g,
        paramtype = 'light',
        paramtype2 = def.paramtype2 or 'wallmounted',
        place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
        walkable = false,
        sunlight_propagates = true,
        selection_box = def.selection_box or {
            type = 'fixed',
            fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
        },
        fertility = def.fertility,
        sounds = x_farming.node_sound_grass_defaults(),
        special_tiles = def.special_tiles and { { name = def.special_tiles, tileable_vertical = true } } or nil,
        visual_scale = def.visual_scale or 1,
        node_dig_prediction = def.node_dig_prediction or '',
        node_placement_prediction = def.node_placement_prediction or nil,

        on_place = def.on_place or function(itemstack, placer, pointed_thing)
            local under = pointed_thing.under
            local node = core.get_node(under)
            local udef = core.registered_nodes[node.name]
            if udef and udef.on_rightclick and
                not (placer and placer:is_player() and
                placer:get_player_control().sneak)
            then
                return udef.on_rightclick(under, node, placer, itemstack, pointed_thing) or itemstack
            end

            return x_farming.place_seed(itemstack, placer, pointed_thing, mname .. ':seed_' .. pname)
        end,
        after_destruct = def.after_destruct or nil,
        next_plant = mname .. ':' .. pname .. '_1',
        on_timer = def.on_timer or x_farming.grow_plant,
        minlight = def.minlight,
        maxlight = def.maxlight,
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
    })

    -- Register harvest
    core.register_craftitem(':' .. mname .. ':' .. pname, {
        description = def.harvest_description,
        inventory_image = mname .. '_' .. pname .. '.png',
        groups = def.groups or { flammable = 2 },
    })

    -- Register growing steps
    for i = 1, def.steps do
        local base_rarity = 1
        if def.steps ~= 1 then
            base_rarity = 8 - (i - 1) * 7 / (def.steps - 1)
        end
        local drop = {
            items = {
                {items = { mname .. ':' .. pname }, rarity = base_rarity },
                {items = { mname .. ':' .. pname }, rarity = base_rarity * 2 },
                {items = { mname .. ':seed_' .. pname }, rarity = base_rarity },
                {items = { mname .. ':seed_' .. pname }, rarity = base_rarity * 2 },
            }
        }
        local nodegroups = {
            -- MTG
            snappy = 3,
            flammable = 2,
            plant = 1,
            not_in_creative_inventory = 1,
            attached_node = 1,
            -- MCL
            handy = 1,
            shearsy = 1,
            deco_block = 1,
            dig_by_water = 1,
            destroy_by_lava_flow = 1,
            dig_by_piston = 1
        }
        nodegroups[pname] = i

        if def.groups then
            for group, value in pairs(def.groups) do
                nodegroups[group] = value
            end
        end

        local next_plant = nil

        if i < def.steps then
            next_plant = mname .. ':' .. pname .. '_' .. (i + 1)
            lbm_nodes[#lbm_nodes + 1] = mname .. ':' .. pname .. '_' .. i
        end

        local _buildable_to = true

        if def.buildable_to ~= nil then
            _buildable_to = def.buildable_to
        end

        core.register_node(':' .. mname .. ':' .. pname .. '_' .. i, {
            drawtype = def.drawtype or 'plantlike',
            waving = 1,
            tiles = def.tiles or { mname .. '_' .. pname .. '_' .. i .. '.png' },
            special_tiles = def.special_tiles and { { name = mname .. '_' .. pname .. '_' .. i .. '.png', tileable_vertical = true } } or nil,
            paramtype = 'light',
            paramtype2 = def.paramtype2 or nil,
            place_param2 = def.place_param2 or nil,
            visual_scale = def.visual_scale or 1,
            node_dig_prediction = def.node_dig_prediction or '',
            node_placement_prediction = def.node_placement_prediction or nil,
            walkable = false,
            buildable_to = _buildable_to,
            drop = drop,
            selection_box = def['selection_box_' .. i] and def['selection_box_' .. i] or {
                type = 'fixed',
                fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
            },
            groups = nodegroups,
            sounds = x_farming.node_sound_leaves_defaults(),
            next_plant = next_plant,
            on_timer = def.on_timer or x_farming.grow_plant,
            minlight = def.minlight,
            maxlight = def.maxlight,
            _mcl_blast_resistance = 0,
            _mcl_hardness = 0,
            after_destruct = def.after_destruct or nil,
        })
    end

    -- replacement LBM for pre-nodetimer plants
    core.register_lbm({
        name = ':' .. mname .. ':start_nodetimer_' .. pname,
        nodenames = lbm_nodes,
        action = function(pos, node)
            x_farming.tick_again(pos)
        end,
    })

    -- Return
    local r = {
        seed = mname .. ':seed_' .. pname,
        harvest = mname .. ':' .. pname
    }
    return r
end

---grow blocks next to the plant
function x_farming.grow_block(pos, elapsed)
    local node = core.get_node(pos)
    local random_pos = false
    local spawn_positions = {}
    local right_pos = { x = pos.x + 1, y = pos.y, z = pos.z }
    local front_pos = { x = pos.x, y = pos.y, z = pos.z + 1 }
    local left_pos = { x = pos.x - 1, y = pos.y, z = pos.z }
    local back_pos = { x = pos.x, y = pos.y, z = pos.z - 1 }
    local right = core.get_node(right_pos)
    local front = core.get_node(front_pos)
    local left = core.get_node(left_pos)
    local back = core.get_node(back_pos)
    local def = core.registered_nodes[node.name]

    local children = {}

    ---look for fruits around the stem
    if (right.name == def.next_plant) then
        children.right = right_pos
    end
    if (front.name == def.next_plant) then
        children.front = front_pos
    end
    if (left.name == def.next_plant) then
        children.left = left_pos
    end
    if (back.name == def.next_plant) then
        children.back = back_pos
    end

    ---check if the fruit belongs to this stem
    for side, child_pos in pairs(children) do

        local parent_pos_from_child = x_farming.meta_get_str('parent', child_pos)

        ---disable timer for fully grown plant - fruit for this stem already exists
        if core.pos_to_string(pos) == parent_pos_from_child then
            return
        end
    end

    ---make sure that at least one side of the plant has space to put fruit
    if right.name == 'air' then
        table.insert(spawn_positions, right_pos)
    end
    if front.name == 'air' then
        table.insert(spawn_positions, front_pos)
    end
    if left.name == 'air' then
        table.insert(spawn_positions, left_pos)
    end
    if back.name == 'air' then
        table.insert(spawn_positions, back_pos)
    end

    ---plant is closed from all sides
    if #spawn_positions < 1 then
        x_farming.tick_block_short(pos)
        return
    else
        ---pick random from the open sides
        local pick_random

        if #spawn_positions == 1 then
            pick_random = #spawn_positions
        else
            pick_random = math.random(1, #spawn_positions)
        end

        for k, v in pairs(spawn_positions) do
            if k == pick_random then
                random_pos = v
            end
        end
    end

    ---check light
    local light = core.get_node_light(pos)
    if not light or light < 13 or light > 14 then
        x_farming.tick_block_short(pos)
        return
    end

    ---spawn block
    if random_pos then
        core.set_node(random_pos, { name = def.next_plant })
        x_farming.meta_set_str('parent', core.pos_to_string(pos), random_pos)
    end
    return
end

function x_farming.grow_kiwi_tree(pos)
    local path = core.get_modpath('x_farming') ..
        '/schematics/x_farming_kiwi_tree_from_sapling.mts'
    core.place_schematic({ x = pos.x - 2, y = pos.y, z = pos.z - 2 },
        path, 'random', nil, false)
end

-- 'can grow' function - copy from MTG

function x_farming.can_grow(pos)
    local node_under = core.get_node_or_nil({ x = pos.x, y = pos.y - 1, z = pos.z })
    if not node_under then
        return false
    end

    if core.get_item_group(node_under.name, 'soil') == 0 then
        return false
    end

    local light_level = core.get_node_light(pos)

    if not light_level or light_level < 13 then
        return false
    end

    return true
end

---Grow sapling

function x_farming.grow_sapling(pos)
    if not x_farming.can_grow(pos) then
        ---try again 5 min later
        core.get_node_timer(pos):start(300)
        return
    end

    local node = core.get_node(pos)
    if node.name == 'x_farming:kiwi_sapling' then
        core.log('action', 'A sapling grows into a tree at ' ..
            core.pos_to_string(pos))
        x_farming.grow_kiwi_tree(pos)
    end
end

---Grow Large Cactus

function x_farming.grow_large_cactus(pos)
    local path = core.get_modpath('x_farming') ..
        '/schematics/x_farming_large_cactus_from_seedling.mts'
    core.place_schematic({ x = pos.x, y = pos.y, z = pos.z },
        path, 'random', nil, false, 'place_center_x, place_center_z')
end

---Grow Jungle Tree

function x_farming.grow_jungle_tree(pos)
    local path = core.get_modpath('x_farming') ..
        '/schematics/x_farming_jungle_tree_with_cocoa_from_sapling.mts'
    core.place_schematic({ x = pos.x - 2, y = pos.y - 1, z = pos.z - 2 },
        path, nil, nil, false)
end

---Pine Nut Tree

function x_farming.grow_pine_nut_tree(pos)
    local path = core.get_modpath('x_farming') ..
        '/schematics/x_farming_pine_nut_tree_from_sapling.mts'
    core.place_schematic({ x = pos.x - 2, y = pos.y, z = pos.z - 2 },
        path, '0', nil, false)
end

---Christmas Tree

function x_farming.grow_christmas_tree(pos)
    local path
    if math.random() > 0.5 then
        path = core.get_modpath('x_farming') .. '/schematics/x_farming_christmas_tree_large.mts'
        core.place_schematic({ x = pos.x - 2, y = pos.y, z = pos.z - 2 }, path, '0', nil, false)
    else
        path = core.get_modpath('x_farming') .. '/schematics/x_farming_christmas_tree.mts'
        core.place_schematic({ x = pos.x - 1, y = pos.y, z = pos.z - 1 }, path, '0', nil, false)
    end
end

----
--- Crates and Bags
----

function x_farming.tick_crates(pos)
    core.get_node_timer(pos):start(math.random(332, 572))
end

function x_farming.tick_again_crates(pos)
    core.get_node_timer(pos):start(math.random(80, 160))
end

function x_farming.get_crate_or_bag_formspec(pos, label_copy)
    local spos = pos.x .. ',' .. pos.y .. ',' .. pos.z
    local hotbar_bg = ''
    local list_bg = ''

    for i = 0, 7, 1 do
        hotbar_bg = hotbar_bg .. 'image[' .. 0 + i .. ', ' .. 4.85 .. ';1,1;x_farming_crate_ui_bg_hb_slot.png]'
    end

    for row = 0, 2, 1 do
        for i = 0, 7, 1 do
            list_bg = list_bg .. 'image[' .. 0 + i .. ',' .. 6.08 + row .. ';1,1;x_farming_crate_ui_bg_slot.png]'
        end
    end

    local formspec = {
        'size[8,9]',
        'style_type[label;textcolor=#FFFFFF]',
        'background[5,5;1,1;x_farming_crate_ui_bg.png;true]',
        'list[nodemeta:', spos, ';main;0,0.3;8,4;]',
        'list[current_player;main;0,4.85;8,1;]',
        'list[current_player;main;0,6.08;8,3;8]',
        'listring[nodemeta:', spos, ';main]',
        'listring[current_player;main]',
        'label[2,0;' .. core.formspec_escape(label_copy) .. ']',
        list_bg,
        hotbar_bg,
        'image[0,0.3;1,1;x_farming_crate_ui_bg_hb_slot.png]'
    }

    formspec = table.concat(formspec, '')

    return formspec
end

---Crate
function x_farming.register_crate(name, def)
    local _def = table.copy(def) or {}

    _def._custom = _def._custom or {}

    local mod = "x_farming"
    if name:find(":") then
        local n = name:split(":")
        mod = n[1]
        name = n[2]
    end

    _def.name = 'x_farming:' .. name
    _def.description = def.description or name
    _def.short_description = def.short_description or def.description
    _def.drawtype = 'mesh'
    _def.paramtype = 'light'
    _def.paramtype2 = 'facedir'
    _def.mesh = 'x_farming_crate.obj'
    _def.tiles = def.tiles
    _def.use_texture_alpha = 'clip'
    _def.sounds = def.sounds or x_farming.node_sound_wood_defaults()
    _def.is_ground_content = false
    _def.groups = def.groups or {
        -- MTG
        choppy = 2,
        oddly_breakable_by_hand = 2,
        -- MCL
        handy = 1,
        material_wood = 1,
        deco_block = 1,
        fire_encouragement = 3,
        fire_flammability = 4,
        -- ALL
        not_in_creative_inventory = 1,
        flammable = 2
    }
    _def.stack_max = def.stack_max or 1
    _def.mod_origin = mod
    -- MCL
    _def._mcl_hardness = 0.6
    _def._mcl_blast_resistance = 0.6

    if _def._custom.crate_item then
        x_farming.allowed_crate_items[_def._custom.crate_item] = true
    end

    _def.on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        meta:set_string('infotext', _def.short_description)
        meta:set_string('owner', '')
        inv:set_size('main', 1)
    end

    _def.after_place_node = function(pos, placer, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local meta_st = itemstack:get_meta()
        local crate_inv = core.deserialize(meta_st:get_string('crate_inv'))
        local inv = meta:get_inventory()

        if crate_inv then
            inv:add_item('main', ItemStack(crate_inv))
        end

        local node = core.get_node(pos)

        meta:set_string('owner', placer:get_player_name() or '')

        if not inv:is_empty('main') then
            local inv_stack = inv:get_stack('main', 1)

            meta:set_string('infotext', _def.short_description
                .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')\n'
                .. inv_stack:get_description() .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())
        else
            local swap_node = core.registered_nodes['x_farming:crate_empty']
            if swap_node and inv:is_empty('main') and node.name ~= swap_node.name then
                core.swap_node(pos, { name = swap_node.name, param2 = node.param2 })
                meta:set_string('infotext', swap_node.short_description
                    .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')')
            end
        end
    end

    _def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local p_name = clicker:get_player_name()
        if core.is_protected(pos, p_name) then
            return itemstack
        end

        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local inv_stack = inv:get_stack('main', 1)
        local label_copy = _def.short_description .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner')
            .. ')\n' .. inv_stack:get_description()
        core.show_formspec(p_name, _def.name, x_farming.get_crate_or_bag_formspec(pos, label_copy))
        core.sound_play('x_farming_wood_hit', { gain = 0.3, pos = pos, max_hear_distance = 10 }, true)
    end

    _def.on_blast = function(pos, intensity)
        if core.is_protected(pos, '') then
            return
        end

        local drops = {}
        local inv = core.get_meta(pos):get_inventory()
        local n = #drops

        for i = 1, inv:get_size('main') do
            local stack = inv:get_stack('main', i)
            if stack:get_count() > 0 then
                drops[n + 1] = stack:to_table()
                n = n + 1
            end
        end

        drops[#drops + 1] = name
        core.remove_node(pos)
        return drops
    end

    _def.can_dig = function(pos, player)
        return not core.is_protected(pos, player:get_player_name())
    end

    _def.preserve_metadata = function(pos, oldnode, oldmeta, drops)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local stack = drops[1]
        local meta_drop = stack:get_meta()

        if not inv:is_empty('main') then
            local inv_stack = inv:get_stack('main', 1)

            meta_drop:set_string('crate_inv', core.serialize(inv_stack:to_table()))
            meta_drop:set_string('description', stack:get_description() .. '\n' .. inv_stack:get_description()
                .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())

            return
        end
    end

    _def.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local st_name = stack:get_name()

        if core.is_protected(pos, player:get_player_name())
            or (
                not x_farming.allowed_crate_items[st_name]
                and core.get_item_group(st_name, 'fish') == 0
            )
        then
            return 0
        end

        return stack:get_count()
    end

    _def.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local st_name = stack:get_name()

        if core.is_protected(pos, player:get_player_name())
            or (
                not x_farming.allowed_crate_items[st_name]
                and core.get_item_group(st_name, 'fish') == 0
            )
        then
            return 0
        end

        return stack:get_count()
    end

    _def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
        local stack_name = stack:get_name()

        if not stack_name or stack_name == '' then
            return
        end

        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local node = core.get_node(pos)
        local inv_stack = inv:get_stack('main', 1)
        local split_name = stack_name:split(':')

        if core.get_item_group(stack_name, 'fish') ~= 0 then
            split_name = { 'x_farming', 'fish' }
        end

        if stack_name == 'x_farming:cotton' then
            split_name = { 'x_farming', 'cotton2' }
        end

        local swap_node = core.registered_nodes['x_farming:crate_' .. split_name[2] .. '_3']

        if not swap_node then
            return
        end

        if not inv:is_empty(listname) and node.name ~= swap_node.name then
            local p_name = player:get_player_name()

            core.swap_node(pos, { name = swap_node.name, param2 = node.param2 })

            local label_copy = swap_node.short_description .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')\n'
                .. inv_stack:get_description()

            core.show_formspec(p_name, _def.name, x_farming.get_crate_or_bag_formspec(pos, label_copy))
        end

        meta:set_string('infotext', swap_node.short_description .. ' (' .. S('owned by')
            .. ' ' .. meta:get_string('owner') .. ')\n'
            .. inv_stack:get_description() .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())
    end

    _def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local inv_stack = inv:get_stack('main', 1)
        local node = core.get_node(pos)

        if inv:is_empty(listname) then
            local p_name = player:get_player_name()
            local swap_node = core.registered_nodes['x_farming:crate_empty']

            if swap_node then
                core.swap_node(pos, { name = swap_node.name, param2 = node.param2 })
                meta:set_string('infotext', swap_node.short_description
                    .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')')

                local label_copy = swap_node.short_description .. ' (' .. S('owned by') .. ' '
                    .. meta:get_string('owner') .. ')\n' .. inv_stack:get_description()

                core.show_formspec(p_name, _def.name, x_farming.get_crate_or_bag_formspec(pos, label_copy))
            end
        else
            local node_def = core.registered_nodes[node.name]

            if node_def then
                meta:set_string('infotext', node_def.short_description
                    .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')\n'
                    .. inv_stack:get_description() .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())
            end
        end
    end

    _def.on_timer = function(pos, elapsed)
        local pos_above = { x = pos.x, y = pos.y + 1, z = pos.z }
        local node_above = core.get_node(pos_above)

        if not node_above then
            x_farming.tick_again_crates(pos)
            return
        end

        if node_above.name ~= 'air' then
            x_farming.tick_again_crates(pos)
            return
        end

        local rand1 = math.random(1, 2) / 10

        core.add_particlespawner({
            amount = 60,
            time = 15,
            minpos = { x = pos_above.x - 0.1, y = pos_above.y - 0.3, z = pos_above.z - 0.1 },
            maxpos = { x = pos_above.x + 0.1, y = pos_above.y + 0.4, z = pos_above.z + 0.1 },
            minvel = { x = rand1 * -1, y = rand1 * -1, z = rand1 * -1 },
            maxvel = { x = rand1, y = rand1, z = rand1 },
            minacc = { x = rand1 * -1, y = rand1 * -1, z = rand1 * -1 },
            maxacc = { x = rand1, y = rand1, z = rand1 },
            minexptime = 1,
            maxexptime = 1.5,
            minsize = 0.1,
            maxsize = 0.3,
            texture = 'x_farming_fly.png',
            collisiondetection = true,
            object_collision = true
        })

        x_farming.tick_crates(pos)
    end

    x_farming.registered_crates[_def.name] = _def

    if _def.name ~= 'x_farming:crate_empty' then
        table.insert(x_farming.lbm_nodenames_crates, _def.name)
    end

    core.register_node(_def.name, _def)
end

---Bag
function x_farming.register_bag(name, def)
    local _def = table.copy(def) or {}

    _def._custom = _def._custom or {}

    _def.name = 'x_farming:' .. name
    _def.description = def.description or name
    _def.short_description = def.short_description or def.description
    _def.drawtype = 'mesh'
    _def.paramtype = 'light'
    _def.paramtype2 = 'facedir'
    _def.mesh = 'x_farming_bag.obj'
    _def.tiles = def.tiles
    _def.use_texture_alpha = 'clip'
    _def.sounds = def.sounds or x_farming.node_sound_sand_defaults()
    _def.is_ground_content = false
    _def.groups = def.groups or {
        -- MTG
        choppy = 2,
        oddly_breakable_by_hand = 2,
        -- MCL
        handy = 1,
        building_block = 1,
        deco_block = 1,
        -- ALL
        not_in_creative_inventory = 1,
        flammable = 2
    }
    -- MCL
    _def._mcl_hardness = 0.6
    _def._mcl_blast_resistance = 0.6
    _def.stack_max = def.stack_max or 1
    _def.mod_origin = 'x_farming'

    if _def._custom.bag_item then
        x_farming.allowed_bag_items[_def._custom.bag_item] = true
    end

    _def.on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        meta:set_string('infotext', _def.short_description)
        meta:set_string('owner', '')
        inv:set_size('main', 1)
    end

    _def.after_place_node = function(pos, placer, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local meta_st = itemstack:get_meta()
        local bag_inv = core.deserialize(meta_st:get_string('bag_inv'))
        local inv = meta:get_inventory()

        if bag_inv then
            inv:add_item('main', ItemStack(bag_inv))
        end

        local node = core.get_node(pos)

        meta:set_string('owner', placer:get_player_name() or '')

        if not inv:is_empty('main') then
            local inv_stack = inv:get_stack('main', 1)

            meta:set_string('infotext', _def.short_description .. ' (' .. S('owned by') .. ' '
                .. meta:get_string('owner') .. ')\n' .. inv_stack:get_description()
                .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())
        else
            local swap_node = core.registered_nodes['x_farming:bag_empty']
            if swap_node and inv:is_empty('main') and node.name ~= swap_node.name then
                core.swap_node(pos, { name = swap_node.name, param2 = node.param2 })
                meta:set_string('infotext', swap_node.short_description
                    .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')')
            end
        end
    end

    _def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local p_name = clicker:get_player_name()

        if core.is_protected(pos, p_name) then
            return itemstack
        end

        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local inv_stack = inv:get_stack('main', 1)
        local label_copy = _def.short_description .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')\n'
            .. inv_stack:get_description()
        core.show_formspec(p_name, _def.name, x_farming.get_crate_or_bag_formspec(pos, label_copy))
        core.sound_play('x_farming_sand_footstep', { gain = 0.3, pos = pos, max_hear_distance = 10 }, true)
    end

    _def.on_blast = function(pos, intensity)
        if core.is_protected(pos, '') then
            return
        end

        local drops = {}
        local inv = core.get_meta(pos):get_inventory()
        local n = #drops

        for i = 1, inv:get_size('main') do
            local stack = inv:get_stack('main', i)
            if stack:get_count() > 0 then
                drops[n + 1] = stack:to_table()
                n = n + 1
            end
        end

        drops[#drops + 1] = name
        core.remove_node(pos)
        return drops
    end

    _def.can_dig = function(pos, player)
        return not core.is_protected(pos, player:get_player_name())
    end

    _def.preserve_metadata = function(pos, oldnode, oldmeta, drops)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local stack = drops[1]
        local meta_drop = stack:get_meta()

        if not inv:is_empty('main') then
            local inv_stack = inv:get_stack('main', 1)

            meta_drop:set_string('bag_inv', core.serialize(inv_stack:to_table()))
            meta_drop:set_string('description', stack:get_description() .. '\n'
                .. inv_stack:get_description() .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())

            return
        end
    end

    _def.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        if core.is_protected(pos, player:get_player_name()) or not x_farming.allowed_bag_items[stack:get_name()] then
            return 0
        end

        return stack:get_count()
    end

    _def.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        if core.is_protected(pos, player:get_player_name()) or not x_farming.allowed_bag_items[stack:get_name()] then
            return 0
        end

        return stack:get_count()
    end

    _def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
        local stack_name = stack:get_name()

        if not stack_name or stack_name == '' then
            return
        end

        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local split_name = stack_name:split(':')
        local node = core.get_node(pos)
        local swap_node = core.registered_nodes['x_farming:bag_' .. split_name[2]]
        local inv_stack = inv:get_stack('main', 1)

        if not swap_node then
            return
        end

        if not inv:is_empty(listname) and node.name ~= swap_node.name then
            local p_name = player:get_player_name()

            core.swap_node(pos, { name = swap_node.name, param2 = node.param2 })

            local label_copy = swap_node.short_description .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')\n'
                .. inv_stack:get_description()

            core.show_formspec(p_name, _def.name, x_farming.get_crate_or_bag_formspec(pos, label_copy))
        end

        meta:set_string('infotext', swap_node.short_description .. ' (' .. S('owned by')
            .. ' ' .. meta:get_string('owner') .. ')\n'
            .. inv_stack:get_description() .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())
    end

    _def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        local inv_stack = inv:get_stack('main', 1)
        local node = core.get_node(pos)

        if inv:is_empty(listname) then
            local p_name = player:get_player_name()
            local swap_node = core.registered_nodes['x_farming:bag_empty']

            if swap_node then
                core.swap_node(pos, { name = swap_node.name, param2 = node.param2 })
                meta:set_string('infotext', swap_node.short_description
                    .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')')

                local label_copy = swap_node.short_description
                    .. ' (' .. S('owned by') .. ' ' .. meta:get_string('owner') .. ')\n' .. inv_stack:get_description()

                core.show_formspec(p_name, _def.name, x_farming.get_crate_or_bag_formspec(pos, label_copy))
            end
        else
            local node_def = core.registered_nodes[node.name]

            if node_def then
                meta:set_string('infotext', node_def.short_description .. ' (' .. S('owned by') .. ' '
                    .. meta:get_string('owner') .. ')\n' .. inv_stack:get_description()
                    .. '\n' .. S('Quantity') .. ': ' .. inv_stack:get_count())
            end
        end
    end

    core.register_node(_def.name, _def)
end

--
---Bonemeal
--

------------
---Main API for x_bonemeal Mod
---@author Juraj Vajda
---@license GNU LGPL 2.1
----

---Get creative mode setting from core.conf
local creative_mod_cache = core.settings:get_bool('creative_mode')

---Check if creating mode is enabled or player has creative privs
---@param name string name
---@return boolean
function x_farming.x_bonemeal.is_creative(name)
    return creative_mod_cache or core.check_player_privs(name, { creative = true })
end

---Check if node has a soil below its self
---@param under Vector of position
---@return boolean
function x_farming.x_bonemeal.is_on_soil(under)
    local below = core.get_node_or_nil({ x = under.x, y = under.y - 1, z = under.z })

    if not below then
        return false
    end

    if core.get_item_group(below.name, 'soil') == 0 and below.name ~= 'mcl_farming:soil_wet' then
        return false
    end

    return true
end

---Check if node has a sand below its self
---@param under Vector of position
---@return boolean
function x_farming.x_bonemeal.is_on_sand(under)
    local below = core.get_node_or_nil({ x = under.x, y = under.y - 1, z = under.z })

    if not below then
        return false
    end

    if core.get_item_group(below.name, 'sand') == 0
        and core.get_item_group(below.name, 'everness_sand') == 0
    then
        return false
    end

    return true
end

---Growth steps for farming plants, there is no way of getting them dynamically,
--- so they are defined in the local table variable
local farming_steps = {
    ['farming:wheat'] = 8,
    ['farming:cotton'] = 8,
    ['x_farming:coffee'] = 5,
    ['x_farming:corn'] = 10,
    ['x_farming:obsidian_wart'] = 6,
    ['x_farming:melon'] = 8,
    ['x_farming:pumpkin'] = 8,
    ['x_farming:carrot'] = 8,
    ['x_farming:potato'] = 8,
    ['x_farming:beetroot'] = 8,
    ['x_farming:strawberry'] = 4,
    ['x_farming:stevia'] = 8,
    ['x_farming:soybean'] = 7,
    ['x_farming:salt'] = 7,
    ['x_farming:barley'] = 8,
    ['x_farming:cotton'] = 8,
}

---Particle and sound effect after the bone meal is successfully used
---@param pos Vector containing position
function x_farming.x_bonemeal.particle_effect(pos)
    core.sound_play('x_farming_x_bonemeal_grow', {
        pos = pos,
        gain = 0.5,
    })

    core.add_particlespawner({
        amount = 6,
        time = 3,
        minpos = { x = pos.x - 0.4, y = pos.y - 0.4, z = pos.z - 0.4 },
        maxpos = { x = pos.x + 0.4, y = pos.y, z = pos.z + 0.4 },
        minvel = { x = 0, y = 0, z = 0 },
        maxvel = { x = 0, y = 0.1, z = 0 },
        minacc = vector.new({ x = 0, y = 0, z = 0 }),
        maxacc = vector.new({ x = 0, y = 0.1, z = 0 }),
        minexptime = 2,
        maxexptime = 3,
        minsize = 1,
        maxsize = 3,
        texture = 'x_farming_x_bonemeal_particles.png',
        animation = {
            type = 'vertical_frames',
            aspect_w = 8,
            aspect_h = 8,
            length = 3,
        },
    })
end

function x_farming.x_bonemeal.tableContains(table, value)
    local found = false

    if not table or type(table) ~= 'table' then
        return found
    end

    for k, v in ipairs(table) do
        if v == value then
            found = true
            break
        end
    end

    return found
end

function x_farming.x_bonemeal.groupContains(groups, fertility, value)
    local found = false

    if not groups or type(groups) ~= 'table' then
        return found
    end

    if groups[fertility] and groups[fertility] == value then
        found = true
    end

    return found
end

---Handle growth of decorations based on biome
---@param itemstack ItemStack
---@param user ObjectRef | nil
---@param pointed_thing PointedThingDef
---@return { ['success']: boolean, ['itemstack']: ItemStack }
function x_farming.x_bonemeal.grow_grass_and_flowers(itemstack, user, pointed_thing)
    local result = {
        success = false,
        itemstack = itemstack
    }
    local node = core.get_node(pointed_thing.under)

    if not node then
        return result
    end

    local pos0 = vector.subtract(pointed_thing.under, 3)
    local pos1 = vector.add(pointed_thing.under, 3)
    local biome_data = core.get_biome_data(pointed_thing.under)

    if not biome_data then
        return result
    end

    local biome_name = core.get_biome_name(biome_data.biome)

    if not biome_name then
        return result
    end

    local random_number = math.random(2, 6)
    local registered_decorations_filtered = {}
    ---@type ItemStack | nil
    local returned_itemstack
    local node_def = core.registered_nodes[node.name]
    local below_water = false
    local floats_on_water = false
    local node_in_decor = false
    local positions_dirty
    local positions = {}
    local decor_place_on = {}
    -- print('biome_name', biome_name)

    ---check 1 node below pointed node (floats on water)
    local test_node = core.get_node({
        x = pointed_thing.under.x,
        y = pointed_thing.under.y - 1,
        z = pointed_thing.under.z
    })
    local test_node_def = core.registered_nodes[test_node.name]

    if test_node_def
        and test_node_def.liquidtype == 'source'
        and core.get_item_group(test_node_def.name, 'water') > 0
    then
        floats_on_water = true
    end

    ---check 2 nodes above pointed nodes (below water)
    local water_nodes_above = 0
    for i = 1, 2 do
        local test_node2 = core.get_node({
            x = pointed_thing.under.x,
            y = pointed_thing.under.y + i,
            z = pointed_thing.under.z
        })
        local test_node_def2 = core.registered_nodes[test_node2.name]

        if test_node_def2
            and test_node_def2.liquidtype == 'source'
            and core.get_item_group(test_node_def2.name, 'water') > 0
        then
            water_nodes_above = water_nodes_above + 1
        end
    end

    if water_nodes_above == 2 then
        below_water = true
    end

    if below_water then
        positions_dirty = core.find_nodes_in_area(pos0, pos1, node.name)
    elseif floats_on_water then
        positions_dirty = core.find_nodes_in_area(pos0, pos1, 'air')
    else
        positions_dirty = core.find_nodes_in_area_under_air(pos0, pos1, node.name)
    end

    ---find suitable decorations
    for _, v in pairs(core.registered_decorations) do
        ---only for 'simple' decoration types
        if v.deco_type == 'simple' then
            ---filter based on biome name in `biomes` table and node name in `place_on` table
            if x_farming.x_bonemeal.tableContains(v.biomes, biome_name) then
                table.insert(registered_decorations_filtered, v)
            end
        end

        ---clicked node is in decoration
        local _decoration = v.decoration

        if type(v.decoration) == 'string' then
            _decoration = { v.decoration }
        end

        if x_farming.x_bonemeal.tableContains(_decoration, node.name) then
            node_in_decor = true
        end

        ---all nodes on which decoration can be placed on
        ---indexed by name
        if not decor_place_on[v.place_on] then
            if type(v.place_on) == 'string' then
                decor_place_on[v.place_on] = true
            elseif type(v.place_on) == 'table' then
                for _, v2 in ipairs(v.place_on) do
                    decor_place_on[v2] = true
                end
            end
        end
    end

    ---find suitable positions
    for j, pos_value in ipairs(positions_dirty) do
        local node_at_pos = core.get_node(pos_value)

        if below_water then
            ---below water
            local water_nodes_above2 = 0

            ---check if 2 nodes above are water
            for i = 1, 2 do
                local test_node3 = core.get_node({ x = pos_value.x, y = pos_value.y + i, z = pos_value.z })
                local test_node_def3 = core.registered_nodes[test_node3.name]

                if test_node_def3
                    and test_node_def3.liquidtype == 'source'
                    and core.get_item_group(test_node_def3.name, 'water') > 0
                then
                    water_nodes_above2 = water_nodes_above2 + 1
                end
            end

            if water_nodes_above2 == 2 and decor_place_on[test_node.name] then
                table.insert(positions, pos_value)
            end
        else
            ---above water (not on water)
            if decor_place_on[node_at_pos.name] then
                table.insert(positions, pos_value)
            end
        end
    end

    ---find suitable positions (float on water)
    if floats_on_water then
        for _, pos_value in ipairs(positions_dirty) do
            local node_at_pos_below = core.get_node({ x = pos_value.x, y = pos_value.y - 1, z = pos_value.z })
            local test_node_def4 = core.registered_nodes[node_at_pos_below.name]

            if test_node_def4
                and test_node_def4.liquidtype == 'source'
                and core.get_item_group(test_node_def4.name, 'water') > 0
            then
                table.insert(positions, pos_value)
            end
        end
    end

    local returned_itemstack_success = 0

    ---place decorations on random positions
    if #positions > 0 and #registered_decorations_filtered > 0 then
        for i = 1, random_number do
            local idx = math.random(1, #positions)
            local random_pos = positions[idx]
            local random_decor = registered_decorations_filtered[math.random(1, #registered_decorations_filtered)]
            local random_decor_item = random_decor.decoration

            if floats_on_water and node_in_decor then
                random_decor_item = node.name
            elseif type(random_decor.decoration) == 'table' then
                random_decor_item = random_decor.decoration[math.random(1, #random_decor.decoration)]
            end

            local random_decor_item_def = core.registered_nodes[random_decor_item]

            if random_pos ~= nil and random_decor_item_def.drawtype ~= 'airlike' then
                if random_decor_item_def.on_place ~= nil and node_def and not node_def.on_rightclick then
                    ---on_place
                    local pt = {
                        type = 'node',
                        above = {
                            x = random_pos.x,
                            y = random_pos.y + 1,
                            z = random_pos.z
                        },
                        under = {
                            x = random_pos.x,
                            y = random_pos.y,
                            z = random_pos.z
                        }
                    }

                    if floats_on_water then
                        pt.above.y = random_pos.y
                        pt.under.y = random_pos.y - 1
                    end

                    returned_itemstack = random_decor_item_def.on_place(ItemStack(random_decor_item), user, pt)

                    if returned_itemstack and returned_itemstack:is_empty() then
                        returned_itemstack_success = returned_itemstack_success + 1
                        x_farming.x_bonemeal.particle_effect(pt.above)
                    end
                elseif random_decor_item_def ~= nil then
                    ---everything else
                    local pos_y = 1

                    if random_decor.place_offset_y ~= nil then
                        pos_y = random_decor.place_offset_y
                    end

                    x_farming.x_bonemeal.particle_effect(random_pos)
                    core.set_node({
                        x = random_pos.x,
                        y = random_pos.y + pos_y,
                        z = random_pos.z
                    },
                    { name = random_decor_item })
                end

                table.remove(positions, idx)
            else
                return result
            end
        end
    else
        return result
    end

    ---take item
    if user and returned_itemstack_success > 0
        and not x_farming.x_bonemeal.is_creative(user:get_player_name())
    then
        itemstack:take_item()
    end

    result.success = true
    result.itemstack = itemstack
    return result
end

---Handle farming and farming addons plants.
---Needed to copy this function from minetest_game and modify it in order to ommit some checks (e.g. light..)
---@param itemstack ItemStack
---@param user ObjectRef | nil
---@param pointed_thing PointedThingDef
---@return { ['success']: boolean, ['itemstack']: ItemStack }
function x_farming.x_bonemeal.grow_farming(itemstack, user, pointed_thing)
    local result = {
        success = false,
        itemstack = itemstack
    }
    local pos_under = pointed_thing.under
    local replace_node_name = core.get_node(pos_under).name
    local ndef = core.registered_nodes[replace_node_name]
    local take_item = false

    if not ndef.next_plant
        or ndef.next_plant == 'x_farming:pumpkin_fruit'
        or ndef.next_plant == 'x_farming:melon_fruit'
    then
        return result
    end

    local pos0 = vector.subtract(pointed_thing.under, 3)
    local pos1 = vector.add(pointed_thing.under, 3)
    local positions = core.find_nodes_in_area(pos0, pos1, { 'group:plant', 'group:seed' })

    for i, pos in ipairs(positions) do
        local isFertile = false
        replace_node_name = core.get_node(pos).name

        ---check if on wet soil
        local below = core.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })
        local below_def = core.registered_nodes[below.name]

        if core.get_item_group(below.name, 'soil') == 3 or below.name == 'mcl_farming:soil_wet' then
            local current_step = tonumber(string.reverse(string.reverse(replace_node_name):split('_')[1]))
            local max_step = farming_steps[replace_node_name:gsub('_%d+', '', 1)]

            ---check if seed
            ---farming:seed_wheat
            local mod_plant = replace_node_name:split(':')
            ---seed_wheat
            local seed_plant = mod_plant[2]:split('_')
            local seed_name = replace_node_name

            if seed_plant[1] == 'seed' then
                current_step = 0
                if replace_node_name == 'x_farming:seed_obsidian_wart' then
                    replace_node_name = mod_plant[1] .. ':' .. seed_plant[2] .. '_' .. seed_plant[3]
                else
                    replace_node_name = mod_plant[1] .. ':' .. seed_plant[2]
                end
                max_step = farming_steps[replace_node_name]
                replace_node_name = replace_node_name .. '_' .. current_step
            else
                if string.find(replace_node_name, 'obsidian_wart') then
                    seed_name = mod_plant[1] .. ':seed_' .. seed_plant[1] .. '_' .. seed_plant[2]
                else
                    seed_name = mod_plant[1] .. ':seed_' .. seed_plant[1]
                end
            end

            ---search for fertility (again after checking soil)
            local seed_def = core.registered_nodes[seed_name]

            if seed_def and below_def then
                if below_def.groups then
                    for _, v in ipairs(seed_def.fertility) do
                        if not isFertile then
                            isFertile = x_farming.x_bonemeal.groupContains(below_def.groups, v, 1) or below.name == 'mcl_farming:soil_wet'
                        end
                    end
                end
            end

            if current_step ~= nil and max_step ~= nil and current_step ~= max_step and isFertile then
                local available_steps = max_step - current_step
                local new_step = max_step - available_steps + math.random(available_steps)
                local new_plant = replace_node_name:gsub('_%d+', '_' .. new_step, 1)
                take_item = true

                local placenode_def = core.registered_nodes[new_plant]

                local placenode = { name = new_plant }
                if placenode_def and placenode_def.place_param2 then
                    placenode.param2 = placenode_def.place_param2
                end
                x_farming.x_bonemeal.particle_effect(pos)
                core.swap_node(pos, placenode)
            end
        end
    end

    ---take item if not in creative
    if user and not x_farming.x_bonemeal.is_creative(user:get_player_name()) and take_item then
        itemstack:take_item()
    end

    return {
        success = true,
        itemstack = itemstack
    }
end

---XBonemeal on_use
---@param self table x_farming.x_bonemeal
---@param itemstack ItemStack
---@param user ObjectRef | nil
---@param pointed_thing any
---@return { ['success']: boolean, ['itemstack']: ItemStack }
function x_farming.x_bonemeal.on_use(self, itemstack, user, pointed_thing)
    local result = {
        success = false,
        itemstack = itemstack
    }

    if not user then
        return result
    end

    local under = pointed_thing.under

    if not under then
        return result
    end
    if pointed_thing.type ~= 'node' then
        return result
    end
    if core.is_protected(under, user:get_player_name()) then
        return result
    end

    local node = core.get_node(under)

    if not node then
        return result
    end
    if node.name == 'ignore' then
        return result
    end

    local mod = node.name:split(':')[1]

    if (mod == 'farming' or mod == 'x_farming')
        and not string.find(node.name, '_sapling')
        and not string.find(node.name, '_seedling')
    then
        --
        -- Farming
        --
        return self.grow_farming(itemstack, user, pointed_thing)
    elseif self.tree_defs[node.name] then
        --
        -- Default (Trees, Bushes, Papyrus)
        --
        local def = self.tree_defs[node.name]
        local chance = math.random(1, def.chance)

        if chance == 1 then
            local success = def.grow_tree(under)

            if not success then
                return result
            end

            self.particle_effect({ x = under.x, y = under.y + 1, z = under.z })
        end

        -- take item if not in creative
        if not self.is_creative(user:get_player_name()) then
            itemstack:take_item()
        end

        return {
            success = true,
            itemstack = itemstack
        }
    else
        return self.grow_grass_and_flowers(itemstack, user, pointed_thing)
    end
end

--- API for registering tree growing from saplings using bonemeal
function x_farming.x_bonemeal.register_tree_defs(self, defs)
    if not defs or type(defs) ~= 'table' then
        core.log('warning', '[x_farming][x_bonemeal] Missing or incorrect definition: \n' .. dump(defs))
    end

    for _, value in ipairs(defs) do
        local def = table.copy(value)
        if not self.tree_defs[def.name] then
            self.tree_defs[def.name] = value
        end
    end
end

-- TheTermos (MIT)
-- vec components can be omitted e.g. vec={y=1}
function x_farming.pos_shift(pos, vec)
    vec.x = vec.x or 0
    vec.y = vec.y or 0
    vec.z = vec.z or 0

    return {
        x = pos.x + vec.x,
        y = pos.y + vec.y,
        z = pos.z + vec.z
    }
end

-- TheTermos (MIT)
function x_farming.get_node_pos(pos)
    return {
        x = math.floor(pos.x + 0.5),
        y = math.floor(pos.y + 0.5),
        z = math.floor(pos.z + 0.5),
    }
end

-- TheTermos (MIT)
function x_farming.nodeatpos(pos)
    local node = core.get_node_or_nil(pos)
    if node then
        return core.registered_nodes[node.name]
    end
end

-- TheTermos (MIT)
function x_farming.get_node_height(pos)
    local npos = x_farming.get_node_pos(pos)
    local node = x_farming.nodeatpos(npos)
    if node == nil then
        return nil
    end

    if node.walkable then
        if node.drawtype == 'nodebox' then
            if node.node_box and node.node_box.type == 'fixed' then
                if type(node.node_box.fixed[1]) == 'number' then
                    return npos.y + node.node_box.fixed[5], 0, false
                elseif type(node.node_box.fixed[1]) == 'table' then
                    return npos.y + node.node_box.fixed[1][5], 0, false
                else
                    -- todo handle table of boxes
                    return npos.y + 0.5, 1, false
                end
            elseif node.node_box and node.node_box.type == 'leveled' then
                return core.get_node_level(pos) / 64 - 0.5 + x_farming.get_node_pos(pos).y, 0, false
            else
                -- the unforeseen
                return npos.y + 0.5, 1, false
            end
        else
            -- full node
            return npos.y + 0.5, 1, false
        end
    else
        local liquidflag = false
        if node.drawtype == 'liquid' then liquidflag = true end
        return npos.y - 0.5, -1, liquidflag
    end
end

-- TheTermos (MIT)
-- get_terrain_height
-- steps(optional) number of recursion steps; default=3
-- dir(optional) is 1=up, -1=down, 0=both; default=0
-- liquidflag(forbidden) never provide this parameter.
-- dir is 1=up, -1=down, 0=both
function x_farming.get_terrain_height(pos, steps, dir, liquidflag)
    steps = steps or 3
    dir = dir or 0

    local h, f, l = x_farming.get_node_height(pos)
    if h == nil then
        return nil
    end
    if l then
        liquidflag = true
    end

    if f == 0 then
        return h, liquidflag
    end

    if dir == 0 or dir == f then
        steps = steps - 1
        if steps <= 0 then
            return nil
        end

        return x_farming.get_terrain_height(x_farming.pos_shift(pos, { y = f }), steps, f, liquidflag)
    else
        return h, liquidflag
    end
end

-- TheTermos (MIT)
-- modified by SaKeL
function x_farming.get_spawn_pos_abr(dtime, intrvl, radius, chance, reduction)
    dtime = math.min(dtime, 0.1)
    local players = core.get_connected_players()
    intrvl = 1 / intrvl

    if math.random() < dtime * (intrvl * #players) then
        -- choose random player
        local player = players[math.random(#players)]
        local vel = player:get_velocity()
        local spd = vector.length(vel)
        chance = (1 - chance) * 1 / (spd * 0.75 + 1)

        local yaw
        if spd > 1 then
            -- spawn in the front arc
            yaw = core.dir_to_yaw(vel) + math.random() * 0.35 - 0.75
        else
            -- random yaw
            yaw = math.random() * math.pi * 2 - math.pi
        end

        local pos = player:get_pos()
        local dir = vector.multiply(core.yaw_to_dir(yaw), radius)
        local pos2 = vector.add(pos, dir)

        pos2.y = pos2.y - 5

        local height, liquidflag = x_farming.get_terrain_height(pos2, 32)
        if height then
            local objs = core.find_node_near(pos, radius * 1.1, { 'group:bee' }) or {}

            -- count mobs in abrange
            for _, obj in ipairs(objs) do
                chance = chance + (1 - chance) * reduction
            end

            if chance < math.random() then
                pos2.y = height
                objs = core.get_objects_inside_radius(pos2, radius * 0.95)

                -- do not spawn if another player around
                for _, obj in ipairs(objs) do
                    if obj:is_player() then
                        return
                    end
                end

                return pos2, liquidflag
            end
        end
    end
end

function x_farming.on_flood_candle(pos, oldnode, newnode)
    local drops = core.get_node_drops(oldnode)

    for _, item_name in ipairs(drops) do
        core.add_item(pos, ItemStack(item_name))
    end

    -- Play flame-extinguish sound if liquid is not an 'igniter'
    local nodedef = core.registered_items[newnode.name]

    if not (nodedef and nodedef.groups
        and nodedef.groups.igniter and nodedef.groups.igniter > 0)
        and core.get_item_group(oldnode.name, 'candle_on') > 0
    then
        core.sound_play(
            'x_farming_extinguish_candle',
            { pos = pos, max_hear_distance = 16, gain = 0.07 },
            true
        )
    end

    -- Remove the torch node
    return false
end

-- Feasts
function x_farming.register_feast(name, def)
    local g = {
        -- MTG
        choppy = 3,
        oddly_breakable_by_hand = 3,
        compost = 100,
        no_silktouch = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        non_mycelium_plant = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        compostability = 100,
        food = 2,
        eatable = 1,
        -- ALL
        flammable = 2,
        attached_node = 1,
    }

    -- merge groups from `def`
    if def.groups then
        for group, value in pairs(def.groups) do
            g[group] = value
        end
    end

    local _def = {
        description = def.description,
        short_description = def.short_description or def.description,
        drawtype = 'mesh',
        mesh = def.mesh,
        use_texture_alpha = def.use_texture_alpha or 'clip',
        inventory_image = def.inventory_image or ('x_farming_' .. name .. '_item.png'),
        wield_image = def.wield_image or ('x_farming_' .. name .. '_item.png'),
        wield_scale = { x = 2, y = 2, z = 1 },
        paramtype = 'light',
        paramtype2 = '4dir',
        is_ground_content = false,
        walkable = false,
        selection_box = def.selection_box,
        groups = g,
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
        sounds = def.sounds or x_farming.node_sound_wood_defaults(),
        sunlight_propagates = true,
    }

    for i = 1, def.steps do
        local d = table.copy(_def)

        d._next_step = i + 1
        d.tiles = {
            { name = 'x_farming_' .. name .. '_mesh.png', backface_culling = def.tiles_backface_culling or false },
            { name = 'x_farming_' .. name .. '_mesh_' .. i .. '.png', backface_culling = def.tiles_backface_culling or false },
        }

        if i ~= 1 then
            d.groups['not_in_creative_inventory'] = 1
        end

        -- last (no more food) step
        if i == def.steps then
            d.drop = def.last_drop or 'x_farming:bowl'
        else
            d.drop = {
                max_items = def.steps - i,
                items = {
                    {
                        rarity = 1,
                        items = {
                            'x_farming:bowl_' .. name
                        }
                    },
                    {
                        rarity = 1,
                        items = {
                            'x_farming:bowl_' .. name
                        }
                    },
                    {
                        rarity = 1,
                        items = {
                            'x_farming:bowl_' .. name
                        }
                    },
                    {
                        rarity = 1,
                        items = {
                            'x_farming:bowl_' .. name
                        }
                    },
                }
            }
        end

        d.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local n = core.registered_nodes[node.name]
            local p_name = clicker:get_player_name()
            local inv = clicker:get_inventory()
            local stack_name = itemstack:get_name()

            if not n then
                return itemstack
            end

            -- last (no more food) step
            if n._next_step > def.steps then
                core.chat_send_player(p_name, S('There is no more food left!'))
                return itemstack
            end

            if stack_name == 'x_farming:bowl' then
                core.swap_node(pos, { name = 'x_farming:' .. name .. '_' .. n._next_step, param2 = node.param2 })

                if not core.is_creative_enabled(p_name) then
                    itemstack:take_item()
                end

                core.sound_play('x_farming_wooden_bowl', {
                    pos = pos,
                    gain = 0.4,
                    max_hear_distance = 16
                })

                local stack_bowl = ItemStack({ name = 'x_farming:bowl_' .. name })

                if inv and inv:room_for_item('main', stack_bowl) then
                    inv:add_item('main', stack_bowl)
                else
                    -- drop on the ground
                    core.add_item(clicker:get_pos(), stack_bowl)
                end
            else
                core.chat_send_player(p_name, S('You need to hold empty bowl if you want to take portion of the food!'))
            end

            return itemstack
        end

        -- Node
        core.register_node('x_farming:' .. name .. '_' .. i, d)

        -- Craftitem definition
        local craftitem_def = {
            description = def.short_description .. ' ' .. S('Bowl') .. '\n' .. S('Compost chance') .. ': 100%\n'
            .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 8'),
            inventory_image = 'x_farming_bowl_' .. name .. '.png',
            wield_image = 'x_farming_bowl_' .. name .. '.png',
            groups = {
                -- MTG
                -- X Farming
                compost = 100,
                -- MCL
                food = 3,
                eatable = 10,
                compostability = 100,
            },
            -- MCL
            _mcl_saturation = 12.0,
        }

        if core.get_modpath('farming') then
            craftitem_def.on_use = core.item_eat(8)
        end

        if core.get_modpath('mcl_farming') then
            craftitem_def.on_place = core.item_eat(8)
            craftitem_def.on_secondary_use = core.item_eat(8)
        end

        -- Craftitem
        core.register_craftitem('x_farming:bowl_' .. name, craftitem_def)
    end
end

-- Pies

function x_farming.register_pie(name, def)
    local g = {
        -- MTG
        choppy = 3,
        oddly_breakable_by_hand = 3,
        compost = 100,
        no_silktouch = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        non_mycelium_plant = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        compostability = 100,
        food = 2,
        eatable = 1,
        -- ALL
        flammable = 2,
        attached_node = 1,
    }

    -- merge groups from `def`
    if def.groups then
        for group, value in pairs(def.groups) do
            g[group] = value
        end
    end

    local _def = {
        description = def.description,
        short_description = def.short_description or def.description,
        drawtype = 'mesh',
        mesh = def.mesh,
        use_texture_alpha = def.use_texture_alpha or 'clip',
        inventory_image = def.inventory_image or ('x_farming_' .. name .. '_item.png'),
        wield_image = def.wield_image or ('x_farming_' .. name .. '_item.png'),
        wield_scale = { x = 2, y = 2, z = 1 },
        paramtype = 'light',
        paramtype2 = '4dir',
        is_ground_content = false,
        walkable = false,
        selection_box = {
            type = 'fixed',
            fixed = { -7 / 16, -8 / 16, -7 / 16, 7 / 16, -3 / 16, 7 / 16 }
        },
        groups = g,
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
        sounds = def.sounds or x_farming.node_sound_wood_defaults(),
        sunlight_propagates = true,
        item_eat = 6
    }

    for i = 1, def.steps do
        local d = table.copy(_def)

        d._next_step = i + 1
        d.tiles = {
            { name = 'x_farming_' .. name .. '_mesh_' .. i .. '.png', backface_culling = def.tiles_backface_culling or false },
        }

        if i ~= 1 then
            d.groups['not_in_creative_inventory'] = 1
        end

        d.drop = {
            max_items = def.steps - i + 1,
            items = {
                {
                    rarity = 1,
                    items = {
                        'x_farming:slice_' .. name
                    }
                },
                {
                    rarity = 1,
                    items = {
                        'x_farming:slice_' .. name
                    }
                },
                {
                    rarity = 1,
                    items = {
                        'x_farming:slice_' .. name
                    }
                },
                {
                    rarity = 1,
                    items = {
                        'x_farming:slice_' .. name
                    }
                },
            }
        }

        d.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local n = core.registered_nodes[node.name]

            if not n then
                return itemstack
            end

            if i < def.steps then
                core.swap_node(pos, { name = 'x_farming:' .. name .. '_' .. n._next_step, param2 = node.param2 })
            else
                core.remove_node(pos)
                core.check_for_falling(pos)
            end

            local sound_name = 'x_farming_wooden_bowl'

            if core.get_modpath('hunger_ng') then
                hunger_ng.alter_hunger(clicker:get_player_name(), _def.item_eat)
                sound_name = 'hunger_ng_eat'
            elseif core.get_modpath('hbhunger') then
                hbhunger.eat(_def.item_eat, nil, ItemStack({ name = 'x_farming:' .. name .. '_1' }), clicker, pointed_thing)
                sound_name = nil
            elseif core.get_modpath('stamina') and core.global_exists('stamina') then
                -- extra check for global variable since there are some mods called "stamina" without registering global "stamina" namespace
                -- @see https://content.core.net/threads/6791/
                stamina.change_saturation(clicker, _def.item_eat)
                sound_name = 'stamina_eat'
            elseif core.get_modpath('mcl_hunger') then
                local h = mcl_hunger.get_hunger(clicker)
                mcl_hunger.set_hunger(clicker, math.min(h + _def.item_eat, 20))
                sound_name = 'mcl_hunger_bite'
            else
                core.item_eat(_def.item_eat)
            end

            if sound_name then
                core.sound_play(sound_name, { pos = pos, gain = 0.7, max_hear_distance = 5 }, true)
            end

            return itemstack
        end

        -- Node
        core.register_node('x_farming:' .. name .. '_' .. i, d)

        local craftitem_def = {
            description = def.short_description .. ' ' .. S('Slice') .. '\n' .. S('Compost chance') .. ': 100%\n'
            .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': ' .. _def.item_eat),
            inventory_image = 'x_farming_slice_' .. name .. '.png',
            wield_image = 'x_farming_slice_' .. name .. '.png',
            groups = {
                -- MTG
                -- X Farming
                compost = 100,
                -- MCL
                food = 3,
                eatable = 10,
                compostability = 100,
            },
            -- MCL
            _mcl_saturation = 10.0,
        }

        if core.get_modpath('farming') then
            craftitem_def.on_use = core.item_eat(_def.item_eat)
        end

        if core.get_modpath('mcl_farming') then
            craftitem_def.on_place = core.item_eat(_def.item_eat)
            craftitem_def.on_secondary_use = core.item_eat(_def.item_eat)
        end

        -- Craftitem
        core.register_craftitem('x_farming:slice_' .. name, craftitem_def)
    end
end

--
-- MCL
--

function x_farming.mcl.create_soil(pos, inv)
    if pos == nil then
        return false
    end
    local node = core.get_node(pos)
    local name = node.name
    local above = core.get_node({ x = pos.x, y = pos.y + 1, z = pos.z })
    if core.get_item_group(name, 'cultivatable') == 2 then
        if above.name == 'air' then
            node.name = 'mcl_farming:soil'
            core.set_node(pos, node)
            core.sound_play('x_farming_dirt_hit', { pos = pos, gain = 0.5 }, true)
            return true
        end
    elseif core.get_item_group(name, 'cultivatable') == 1 then
        if above.name == 'air' then
            node.name = 'mcl_core:dirt'
            core.set_node(pos, node)
            core.sound_play('x_farming_dirt_hit', { pos = pos, gain = 0.6 }, true)
            return true
        end
    end
    return false
end

function x_farming.mcl.hoe_on_place_function(uses)
    return function(itemstack, user, pointed_thing)
        -- Call on_rightclick if the pointed node defines it
        local node = core.get_node(pointed_thing.under)

        -- Custom: add support for MTG definition farming
        local regN = core.registered_nodes
        if regN[node.name].soil ~= nil
            and regN[node.name].soil.wet ~= nil
            and regN[node.name].soil.dry ~= nil
        then
            return x_farming.hoe_on_use(itemstack, user, pointed_thing, uses)
        end

        if user and not user:get_player_control().sneak then
            if core.registered_nodes[node.name] and core.registered_nodes[node.name].on_rightclick then
                return core.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, user, itemstack) or itemstack
            end
        end

        if core.is_protected(pointed_thing.under, user:get_player_name()) then
            core.record_protection_violation(pointed_thing.under, user:get_player_name())
            return itemstack
        end

        if x_farming.mcl.create_soil(pointed_thing.under, user:get_inventory()) then
            if not core.is_creative_enabled(user:get_player_name()) then
                itemstack:add_wear_by_uses(uses)
            end
            return itemstack
        end
    end
end
