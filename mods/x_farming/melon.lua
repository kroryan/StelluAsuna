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

-- MELON
x_farming.register_plant('x_farming:melon', {
    description = S('Melon Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Melon Seed'),
    inventory_image = 'x_farming_melon_seed.png',
    steps = 8,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland' },
    groups = { flammable = 4 },
    place_param2 = 3,
})

-- needed
local melon_def = {
    description = S('Melon') .. '\n' .. S('Compost chance') .. ': 50%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 2'),
    groups = {
        -- X Farming
        compost = 50,
        -- MCL
        food = 2,
        eatable = 2,
        compostability = 50,
    },
    _mcl_saturation = 1.2,
    wield_image = 'x_farming_melon.png',
}

if core.get_modpath('farming') then
    melon_def.on_use = core.item_eat(2)
end

if core.get_modpath('mcl_farming') then
    melon_def.on_place = core.item_eat(2)
    melon_def.on_secondary_use = core.item_eat(2)
end

core.override_item('x_farming:melon', melon_def)

-- MELON FRUIT - HARVEST
core.register_node('x_farming:melon_fruit', {
    description = S('Melon Fruit'),
    tiles = {
        'x_farming_melon_fruit_top.png',
        'x_farming_melon_fruit_bottom.png',
        'x_farming_melon_fruit_side.png',
        'x_farming_melon_fruit_side.png',
        'x_farming_melon_fruit_side.png',
        'x_farming_melon_fruit_side.png'
    },
    sounds = x_farming.node_sound_wood_defaults(),
    is_ground_content = false,
    groups = {
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
        max_items = 7, -- Maximum number of items to drop.
        items = { -- Choose max_items randomly from this list.
            {
                items = { 'x_farming:melon' }, -- Items to drop.
                rarity = 1, -- Probability of dropping is 1 / rarity.
            },
            {
                items = { 'x_farming:melon' }, -- Items to drop.
                rarity = 2, -- Probability of dropping is 1 / rarity.
            },
            {
                items = { 'x_farming:melon' }, -- Items to drop.
                rarity = 2, -- Probability of dropping is 1 / rarity.
            },
            {
                items = { 'x_farming:melon' }, -- Items to drop.
                rarity = 2, -- Probability of dropping is 1 / rarity.
            },
            {
                items = { 'x_farming:melon' }, -- Items to drop.
                rarity = 3, -- Probability of dropping is 1 / rarity.
            },
            {
                items = { 'x_farming:melon' }, -- Items to drop.
                rarity = 3, -- Probability of dropping is 1 / rarity.
            },
            {
                items = { 'x_farming:melon' }, -- Items to drop.
                rarity = 3, -- Probability of dropping is 1 / rarity.
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
            and parent_node.name == 'x_farming:melon_8' then

            x_farming.tick_block(parent_pos_from_child)
        end
    end
})

-- MELON BLOCK - HARVEST from crops
core.register_node('x_farming:melon_block', {
    description = S('Melon Block') .. '\n' .. S('Compost chance') .. ': 65%',
    short_description = S('Melon Block'),
    tiles = {
        'x_farming_melon_fruit_top.png',
        'x_farming_melon_fruit_bottom.png',
        'x_farming_melon_fruit_side.png',
        'x_farming_melon_fruit_side.png',
        'x_farming_melon_fruit_side.png',
        'x_farming_melon_fruit_side.png'
    },
    sounds = x_farming.node_sound_wood_defaults(),
    is_ground_content = false,
    groups = {
        -- MTG
        snappy = 3,
        flammable = 4,
        fall_damage_add_percent = -30,
        not_in_creative_inventory = 1,
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

-- take over the growth from minetest_game farming from here
core.override_item('x_farming:melon_8', {
    next_plant = 'x_farming:melon_fruit',
    on_timer = x_farming.grow_block
})

--  Golden Melon
local golden_melon_def = {
    description = S('Golden Melon') .. '\n' .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 10'),
    inventory_image = 'x_farming_golden_melon.png',
    wield_image = 'x_farming_golden_melon.png',
    groups = {
        -- MCL
        food = 2,
        eatable = 1,
    },
    _mcl_saturation = 14.4,
}

if x_farming.hbhunger ~= nil or x_farming.hunger_ng ~= nil then
    golden_melon_def.description = golden_melon_def.description .. '\n' .. core.colorize(x_farming.colors.red, S('Heal') .. ': 10')
end

if core.get_modpath('farming') then
    golden_melon_def.on_use = core.item_eat(10)
end

if core.get_modpath('mcl_farming') then
    golden_melon_def.on_place = core.item_eat(10)
    golden_melon_def.on_secondary_use = core.item_eat(10)
end

core.register_craftitem('x_farming:golden_melon', golden_melon_def)

-- replacement LBM for pre-nodetimer plants
core.register_lbm({
    name = 'x_farming:start_nodetimer_melon',
    nodenames = { 'x_farming:melon_8' },
    action = function(pos, node)
        x_farming.tick_block_short(pos)
    end,
})

---crate
x_farming.register_crate('crate_melon_3', {
    description = S('Melon Crate'),
    short_description = S('Melon Crate'),
    tiles = { 'x_farming_crate_melon_3.png' },
    _custom = {
        crate_item = 'x_farming:melon'
    }
})

core.register_decoration(asuna.features.crops.melon.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1107,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:melon_5",
        "x_farming:melon_6",
        "x_farming:melon_7",
        "x_farming:melon_8",
        "x_farming:melon_block",
    },
}))
