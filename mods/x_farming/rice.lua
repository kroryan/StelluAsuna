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

x_farming.register_plant('x_farming:rice', {
    description = S('Rice Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Rice Seed'),
    tiles = { 'x_farming_silt_loam_soil.png' },
    inventory_image = 'x_farming_rice_seed_inv.png',
    steps = 8,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland' },
    drawtype = 'plantlike_rooted',
    paramtype2 = 'none',
    visual_scale = 3.0,
    special_tiles = 'x_farming_rice_seed.png',
    node_dig_prediction = 'x_farming:silt_loam_soil',
    groups = {
        -- MTG
        attached_node = 0,
        -- VL
        plant = 1,
        dig_by_water = 0,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1,
        compostability = 30,
        -- X Farming
        compost = 30,
    },
    node_placement_prediction = '',
    buildable_to = false,
    floodable = false,
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
        },
    },
    selection_box_1 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
        },
    },
    selection_box_2 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
        },
    },
    selection_box_3 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 2, 4 / 16 },
        },
    },
    selection_box_4 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 2.5, 4 / 16 },
        },
    },
    selection_box_5 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 2.5, 4 / 16 },
        },
    },
    selection_box_6 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 3, 4 / 16 },
        },
    },
    selection_box_7 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 3, 4 / 16 },
        },
    },
    selection_box_8 = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 3, 4 / 16 },
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= 'node' or not placer then
            return itemstack
        end

        local player_name = placer:get_player_name()
        local pos_under = pointed_thing.under
        local pos_above = pointed_thing.above
        local node_under = core.get_node(pos_under)
        local def_under = core.registered_nodes[node_under.name]

        if def_under and def_under.on_rightclick and not placer:get_player_control().sneak then
            return def_under.on_rightclick(pos_under, node_under, placer, itemstack, pointed_thing) or itemstack
        end

        local water_above = core.find_nodes_in_area(
            vector.new(pos_above),
            vector.new(pos_above.x, pos_above.y + 2, pos_above.z),
            { 'group:water' }
        )

        if node_under.name ~= 'x_farming:silt_loam_soil'
            or core.get_item_group(core.get_node(pos_above).name, 'water') == 0
            or #water_above ~= 1
        then
            return itemstack
        end

        if core.is_protected(pos_under, player_name)
            or core.is_protected(pos_above, player_name)
        then
            core.record_protection_violation(pos_under, player_name)
            return itemstack
        end

        node_under.name = itemstack:get_name()
        core.set_node(pos_under, node_under)
        x_farming.tick(pos_under)

        if not core.is_creative_enabled(player_name) then
            itemstack:take_item()
        end

        return itemstack
    end,
    after_destruct = function(pos, oldnode)
        core.set_node(pos, { name = 'x_farming:silt_loam_soil' })
    end,
    on_timer = function(pos, elapsed)
        local node = core.get_node(pos)
        local name = node.name
        local def = core.registered_nodes[name]

        if not def.next_plant then
            -- disable timer for fully grown plant
            return
        end

        -- grow seed
        if core.get_item_group(node.name, 'seed') and def.fertility then
            local water_above = core.find_nodes_in_area(
                vector.new(pos),
                vector.new(pos.x, pos.y + 2, pos.z),
                { 'default:water_source' }
            )

            if #water_above ~= 1 then
                x_farming.tick_again(pos)
                return
            end
            -- omitted is a check for light, we assume seeds can germinate in the dark.
            local placenode = { name = def.next_plant }

            if def.place_param2 then
                placenode.param2 = def.place_param2
            end

            core.swap_node(pos, placenode)

            if core.registered_nodes[def.next_plant].next_plant then
                x_farming.tick(pos)
                return
            end

            return
        end

        -- check if emerged in water
        local water_above = core.find_nodes_in_area(
            vector.new(pos),
            vector.new(pos.x, pos.y + 2, pos.z),
            { 'default:water_source' }
        )

        local air_above = core.find_nodes_in_area(
            vector.new(pos),
            vector.new(pos.x, pos.y + 3, pos.z),
            { 'air' }
        )

        if #water_above ~= 1 or #air_above ~= 2 then
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
    end
})

-- Registered before the stairs so the stairs get fuel recipes.
core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:rice_stack',
    burntime = 3,
})

if core.get_modpath('stairs') then
    do
        local recipe = 'x_farming:rice'
        local groups = { snappy = 3, flammable = 4 }
        local images = { 'x_farming_rice_stack_side.png' }
        local sounds = x_farming.node_sound_leaves_defaults()

        stairs.register_stair('rice_stack', recipe, groups, images, S('Rice Stack Stair'),
            sounds, true)
        stairs.register_stair_inner('rice_stack', recipe, groups, images, '',
            sounds, true, S('Inner Rice Stack Stair'))
        stairs.register_stair_outer('rice_stack', recipe, groups, images, '',
            sounds, true, S('Outer Rice Stack Stair'))
        stairs.register_slab('rice_stack', recipe, groups, images, S('Rice Stack Slab'),
            sounds, true)
    end
end

-- crate
x_farming.register_crate('crate_rice_3', {
    description = S('Rice Crate'),
    short_description = S('Rice Crate'),
    tiles = { 'x_farming_crate_rice_3.png' },
    _custom = {
        crate_item = 'x_farming:rice'
    }
})

-- bag
x_farming.register_bag('bag_rice_grains', {
    description = S('Rice Grain') .. ' Bag',
    short_description = S('Rice Grain') .. ' Bag',
    tiles = { 'x_farming_bag_rice_grains.png' },
    _custom = {
        bag_item = 'x_farming:rice_grains'
    }
})
