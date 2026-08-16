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

-- BARLEY
x_farming.register_plant('x_farming:barley', {
    description = S('Barley Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Barley Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_barley_seed.png',
    steps = 8,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland' },
    groups = { flammable = 4 },
    place_param2 = 0,
})

-- needed
local override_def = {
    description = S('Barley') .. '\n' .. S('Compost chance') .. ': 50%',
    short_description = S('Barley'),
    groups = {
        -- X Farming
        compost = 50,
        -- MCL
        compostability = 50
    },
    _mcl_blast_resistance = 0,
}

core.override_item('x_farming:barley', override_def)

-- Registered before the stairs so the stairs get fuel recipes.
core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:barley_stack',
    burntime = 3,
})

if core.get_modpath('stairs') then
    do
        local recipe = 'x_farming:barley'
        local groups = { snappy = 3, flammable = 4 }
        local images = { 'x_farming_barley_stack_side.png' }
        local sounds = x_farming.node_sound_leaves_defaults()

        stairs.register_stair('barley_stack', recipe, groups, images, S('Barley Stack Stair'),
            sounds, true)
        stairs.register_stair_inner('barley_stack', recipe, groups, images, '',
            sounds, true, S('Inner Barley Stack Stair'))
        stairs.register_stair_outer('barley_stack', recipe, groups, images, '',
            sounds, true, S('Outer Barley Stack Stair'))
        stairs.register_slab('barley_stack', recipe, groups, images, S('Barley Stack Slab'),
            sounds, true)
    end
end

---crate
x_farming.register_crate('crate_barley_3', {
    description = S('Barley Crate'),
    short_description = S('Barley Crate'),
    tiles = { 'x_farming_crate_barley_3.png' },
    _custom = {
        crate_item = 'x_farming:barley'
    }
})

core.register_decoration(asuna.features.crops.barley.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1100,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:barley_5",
        "x_farming:barley_6",
        "x_farming:barley_7",
        "x_farming:barley_8",
    },
}))
