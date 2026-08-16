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

-- PUMPKIN
x_farming.register_plant('x_farming:pumpkin', {
    description = S('Pumpkin Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Pumpkin Seed'),
    inventory_image = 'x_farming_pumpkin_seed.png',
    steps = 8,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland', 'desert' },
    groups = { flammable = 4 },
    place_param2 = 3,
})

-- PUMPKIN FRUIT - HARVEST
local pumpkin_fruit_def = {
    description = S('Pumpkin'),
    short_description = S('Pumpkin'),
    tiles = {
        'x_farming_pumpkin_fruit_top.png',
        'x_farming_pumpkin_fruit_bottom.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side.png'
    },
    paramtype2 = 'facedir',
    sounds = x_farming.node_sound_wood_defaults(),
    is_ground_content = false,
    groups = {
        -- X Farming
        pumpkin = 1,
        -- MTG
        snappy = 3,
        flammable = 4,
        fall_damage_add_percent = -30,
        -- MCL
        handy = 1,
        axey = 1,
        plant = 1,
        dig_by_piston = 1,
    },
    _mcl_blast_resistance = 1,
    _mcl_hardness = 1,
    drop = {
        max_items = 1, -- Maximum number of items to drop.
        items = { -- Choose max_items randomly from this list.
            {
                items = { 'x_farming:pumpkin' }, -- Items to drop.
                rarity = 1, -- Probability of dropping is 1 / rarity.
            },
        },
    },
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        local parent = oldmetadata.fields.parent
        local parent_pos_from_child = core.string_to_pos(parent)
        local parent_node = nil

        -- make sure we have position
        if parent_pos_from_child
            and parent_pos_from_child ~= nil then

            parent_node = core.get_node(parent_pos_from_child)
        end

        -- tick parent if parent stem still exists
        if parent_node
            and parent_node ~= nil
            and parent_node.name == 'x_farming:pumpkin_8' then

            x_farming.tick_block(parent_pos_from_child)
        end
    end
}

core.register_node('x_farming:pumpkin_fruit', pumpkin_fruit_def)

-- PUMPKIN BLOCK - HARVEST from crops
core.register_node('x_farming:pumpkin_block', {
    description = S('Pumpkin Block') .. '\n' .. S('Compost chance') .. ': 65%',
    short_description = S('Pumpkin Block'),
    tiles = {
        'x_farming_pumpkin_fruit_top.png',
        'x_farming_pumpkin_fruit_bottom.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side_off.png'
    },
    paramtype2 = 'facedir',
    sounds = x_farming.node_sound_wood_defaults(),
    is_ground_content = false,
    groups = {
        -- X Farming
        pumpkin = 1,
        -- MTG
        snappy = 3,
        flammable = 4,
        fall_damage_add_percent = -30,
        compost = 65,
        -- MCL
        handy = 1,
        axey = 1,
        plant = 1,
        dig_by_piston = 1,
        building_block = 1,
        enderman_takable = 1,
        compostability = 65
    },
    _mcl_blast_resistance = 1,
    _mcl_hardness = 1,
})

-- PUMPKIN LANTERN -- from recipe
core.register_node('x_farming:pumpkin_lantern', {
    description = S('Pumpkin Lantern'),
    short_description = S('Pumpkin Lantern'),
    tiles = {
        'x_farming_pumpkin_fruit_top.png',
        'x_farming_pumpkin_fruit_bottom.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side.png',
        'x_farming_pumpkin_fruit_side_on.png'
    },
    paramtype = 'light',
    paramtype2 = 'facedir',
    sounds = x_farming.node_sound_wood_defaults(),
    is_ground_content = false,
    light_source = 12,
    drop = 'x_farming:pumpkin_lantern',
    groups = {
        -- MTG
        snappy = 3,
        flammable = 4,
        fall_damage_add_percent = -30,
        -- MCL
        handy = 1,
        axey = 1,
    },
    _mcl_blast_resistance = 1,
    _mcl_hardness = 1,
})

-- drop blocks instead of items
core.register_alias_force('x_farming:pumpkin', 'x_farming:pumpkin_fruit')

-- take over the growth from minetest_game farming from here
core.override_item('x_farming:pumpkin_8', {
    next_plant = 'x_farming:pumpkin_fruit',
    on_timer = x_farming.grow_block
})

-- replacement LBM for pre-nodetimer plants
core.register_lbm({
    name = 'x_farming:start_nodetimer_pumpkin',
    nodenames = { 'x_farming:pumpkin_8' },
    action = function(pos, node)
        x_farming.tick_block_short(pos)
    end,
})

---crate
x_farming.register_crate('crate_pumpkin_block_3', {
    description = S('Pumpkin Crate'),
    short_description = S('Pumpkin Crate'),
    tiles = { 'x_farming_crate_pumpkin_block_3.png' },
    _custom = {
        crate_item = 'x_farming:pumpkin_block'
    }
})

core.register_decoration(asuna.features.crops.pumpkin.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1110,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:pumpkin_5",
        "x_farming:pumpkin_6",
        "x_farming:pumpkin_7",
        "x_farming:pumpkin_fruit",
    },
}))
