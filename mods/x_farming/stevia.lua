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

-- STEVIA
x_farming.register_plant('x_farming:stevia', {
    description = S('Stevia Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Stevia Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_stevia_seed.png',
    steps = 8,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland' },
    groups = { flammable = 4 },
    place_param2 = 4,
})

-- needed
core.override_item('x_farming:stevia', {
    description = S('Stevia') .. '\n' .. S('Compost chance') .. ': 65%',
    short_description = S('Stevia'),
    groups = {
        -- X Farming
        compost = 65,
        -- MCL
        compostability = 65
    },
})

core.register_craftitem('x_farming:sugar', {
    description = S('Sugar'),
    short_description = S('Sugar'),
    inventory_image = 'x_farming_sugar.png',
    groups = { flammable = 1 },
})

---crate
x_farming.register_crate('crate_stevia_3', {
    description = S('Stevia Crate'),
    short_description = S('Stevia Crate'),
    tiles = { 'x_farming_crate_stevia_3.png' },
    _custom = {
        crate_item = 'x_farming:stevia'
    }
})

core.register_decoration(asuna.features.crops.stevia.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1113,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:stevia_5",
        "x_farming:stevia_6",
        "x_farming:stevia_7",
        "x_farming:stevia_8",
    },
}))
