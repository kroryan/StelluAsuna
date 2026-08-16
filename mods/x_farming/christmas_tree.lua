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

core.register_node('x_farming:christmas_tree_sapling', {
    description = S('Christmas Tree Sapling') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Christmas Tree Sapling'),
    drawtype = 'plantlike',
    tiles = { 'x_farming_christmas_tree_sapling.png' },
    inventory_image = 'x_farming_christmas_tree_sapling.png',
    wield_image = 'x_farming_christmas_tree_sapling.png',
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    on_timer = x_farming.grow_sapling,
    selection_box = {
        type = 'fixed',
        fixed = { -4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16 }
    },
    groups = {
        -- MTG
        snappy = 2,
        -- MCL
        plant = 1,
        non_mycelium_plant = 1,
        deco_block = 1,
        dig_by_water = 1,
        dig_by_piston = 1,
        destroy_by_lava_flow = 1,
        compostability = 30,
        -- ALL
        dig_immediate = 3,
        flammable = 3,
        attached_node = 1,
        sapling = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),

    on_construct = function(pos)
        core.get_node_timer(pos):start(math.random(300, 1500))
    end,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = x_farming.sapling_on_place(itemstack, placer, pointed_thing,
            'x_farming:christmas_tree_sapling',
            -- minp, maxp to be checked, relative to sapling pos
            -- minp_relative.y = 1 because sapling pos has been checked
            { x = -2, y = 1, z = -2 },
            { x = 2, y = 14, z = 2 },
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})

-- Decorated Pine Leaves
core.register_node('x_farming:christmas_tree_leaves', {
    description = S('Decorated Pine Leaves') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Decorated Pine Leaves'),
    drawtype = 'allfaces_optional',
    tiles = {
        {
            -- Animated, 'blinking lights' version. ~ LazyJ
            name = 'x_farming_christmas_tree_leaves_animated.png',
            animation = {
                type = 'vertical_frames',
                aspect_w = 16,
                aspect_h = 16,
                length = 20.0
            },
        }
    },
    waving = 0,
    paramtype = 'light',
    is_ground_content = false,
    groups = {
        -- MTG
        snappy = 3,
        leafdecay = 3,
        -- MCL
        handy = 1,
        hoey = 1,
        shearsy = 1,
        swordy = 1,
        dig_by_piston = 1,
        fire_encouragement = 30,
        fire_flammability = 60,
        deco_block = 1,
        compostability = 30,
        -- ALL
        flammable = 2,
        leaves = 1,
    },
    _mcl_shears_drop = true,
    _mcl_blast_resistance = 0.2,
    _mcl_hardness = 0.2,
    _mcl_silk_touch_drop = true,
    sounds = x_farming.node_sound_leaves_defaults(),
    after_place_node = x_farming.after_place_leaves,
    light_source = 5,
})

-- Star
core.register_node('x_farming:christmas_tree_star', {
    description = S('Christmas Tree Star'),
    tiles = { 'x_farming_christmas_tree_star.png' },
    inventory_image = 'x_farming_christmas_tree_star.png',
    wield_image = 'x_farming_christmas_tree_star.png',
    drawtype = 'plantlike',
    paramtype = 'light',
    walkable = false,
    groups = {
        -- MTG
        cracky = 1,
        crumbly = 1,
        choppy = 1,
        oddly_breakable_by_hand = 1,
        not_in_creative_inventory = 1,
        leafdecay = 3,
        leafdecay_drop = 1,
        -- MCL
        handy = 1,
        glass = 1,
        building_block = 1,
        material_glass = 1
    },
    _mcl_blast_resistance = 0.3,
    _mcl_hardness = 0.3,
    sounds = x_farming.node_sound_thin_glass_defaults(),
    light_source = 5,
})

x_farming.register_leafdecay({
    trunks = { 'x_farming:pine_nut_tree' },
    leaves = {
        'x_farming:christmas_tree_leaves',
        'x_farming:christmas_tree_star',
        -- since christmas tree is loaded after pine_nut_tree
        -- we are including pine_nut_leaves here
        'x_farming:pine_nut',
        'x_farming:pine_nut_leaves',
    },
    radius = 3,
})
