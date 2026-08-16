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

-- COFFEE
x_farming.register_plant('x_farming:coffee', {
    description = S('Coffee Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Coffee Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_coffee_seed.png',
    steps = 5,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland' },
    groups = { flammable = 4 },
    place_param2 = 0,
})

-- needed
core.override_item('x_farming:coffee', {
    description = S('Coffee bean') .. '\n' .. S('Compost chance') .. ': 50%',
    short_description = S('Coffee bean'),
    groups = {
        -- MTG
        compost = 50,
        -- MCL
        compostability = 50,
    }
})

core.register_craftitem('x_farming:bottle_coffee', {
    description = S('Coffee Bottle'),
    tiles = { 'x_farming_bottle_coffee.png' },
    inventory_image = 'x_farming_bottle_coffee.png',
    wield_image = 'x_farming_bottle_coffee.png',
    groups = { vessel = 1 },
})

-- Hot cup of coffee
local coffee_cup_hot_def = {
    description = S('Hot Cup of Coffee') .. '\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 6'),
    short_description = S('Hot Cup of Coffee') .. '\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 6'),
    drawtype = 'mesh',
    mesh = 'x_farming_coffee_cup_hot.obj',
    tiles = { 'x_farming_coffee_cup_hot_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_coffee_cup_hot.png',
    wield_image = 'x_farming_coffee_cup_hot.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.4, 0.25, 0.5, 0.25 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.4, 0.25, 0, 0.25 }
    },
    groups = {
        -- MTG
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        -- MCL
        food = 3,
        eatable = 6,
        handy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
    },
    on_use = core.item_eat(6),
    sounds = x_farming.node_sound_thin_glass_defaults(),
    sunlight_propagates = true,
    -- MCL
    _mcl_saturation = 0.6,
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
}

if x_farming.hbhunger ~= nil or x_farming.hunger_ng ~= nil then
    coffee_cup_hot_def.description = coffee_cup_hot_def.description .. '\n' .. core.colorize(x_farming.colors.red, S('Heal') .. ': 4')
    coffee_cup_hot_def.short_description = coffee_cup_hot_def.short_description .. '\n' .. core.colorize(x_farming.colors.red, S('Heal') .. ': 4')
end

if core.get_modpath('mcl_farming') then
    coffee_cup_hot_def.on_secondary_use = core.item_eat(6)
end

core.register_node('x_farming:coffee_cup_hot', coffee_cup_hot_def)

-- Crate
x_farming.register_crate('crate_coffee_3', {
    description = S('Coffee Crate'),
    short_description = S('Coffee Crate'),
    tiles = { 'x_farming_crate_coffee_3.png' },
    _custom = {
        crate_item = 'x_farming:coffee'
    }
})

core.register_decoration(asuna.features.crops.coffee.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1104,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:coffee_3",
        "x_farming:coffee_4",
        "x_farming:coffee_5",
    },
}))
