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

-- SOYBEAN
x_farming.register_plant('x_farming:soybean', {
    description = S('Soybean Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Soybean Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_soybean_seed.png',
    steps = 7,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland' },
    groups = { flammable = 4 },
    place_param2 = 3,
})

-- needed
core.override_item('x_farming:soybean', {
    description = S('Soybean') .. '\n' .. S('Compost chance') .. ': 65%',
    short_description = S('Soybean'),
    groups = {
        -- X Farming
        compost = 65,
        -- MCL
        compostability = 65
    },
})

core.register_craftitem('x_farming:bottle_soymilk', {
    description = S('Soymilk Bottle'),
    short_description = S('Soymilk Bottle'),
    tiles = { 'x_farming_bottle_soymilk.png' },
    inventory_image = 'x_farming_bottle_soymilk.png',
    wield_image = 'x_farming_bottle_soymilk.png',
    groups = { vessel = 1 },
    sounds = x_farming.node_sound_thin_glass_defaults(),
})

core.register_craftitem('x_farming:bottle_soymilk_raw', {
    description = S('Raw Soymilk Bottle'),
    short_description = S('Raw Soymilk Bottle'),
    tiles = { 'x_farming_bottle_soymilk_raw.png' },
    inventory_image = 'x_farming_bottle_soymilk_raw.png',
    wield_image = 'x_farming_bottle_soymilk_raw.png',
    groups = { vessel = 1, dig_immediate = 3, attached_node = 1 },
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:bottle_soymilk_raw',
    recipe = {
        'x_farming:soybean',
        'x_farming:soybean',
        'x_farming:soybean',
        'x_farming:soybean',
        'x_farming:soybean',
        'x_farming:bottle_water'
    }
})

---crate
x_farming.register_crate('crate_soybean_3', {
    description = S('Soybean Crate'),
    short_description = S('Soybean Crate'),
    tiles = { 'x_farming_crate_soybean_3.png' },
    _custom = {
        crate_item = 'x_farming:soybean'
    }
})

core.register_decoration(asuna.features.crops.soybean.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1112,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:soybean_5",
        "x_farming:soybean_6",
        "x_farming:soybean_7",
    },
}))
