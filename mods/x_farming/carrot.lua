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
local minlight = 13
local maxlight = 14

-- carrot
x_farming.register_plant('x_farming:carrot', {
    description = S('Planting Carrot') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Planting Carrot'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_carrot_seed.png',
    steps = 8,
    minlight = minlight,
    maxlight = maxlight,
    fertility = { 'grassland' },
    groups = { flammable = 4, compost = 65 },
    place_param2 = 3,
})

-- needed
local carrot_def = {
    description = S('Carrot') .. '\n' .. S('Compost chance') .. ': 65%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 3'),
    short_description = S('Carrot'),
    groups = {
        -- X Farming
        compost = 65,
        -- MCL
        food = 2,
        eatable = 1,
        compostability = 65
    },
    _mcl_saturation = 3.6,
    _mcl_blast_resistance = 0,
}

if core.get_modpath('farming') then
    carrot_def.on_use = core.item_eat(3)
end

if core.get_modpath('mcl_farming') then
    carrot_def.on_place = core.item_eat(3)
    carrot_def.on_secondary_use = core.item_eat(3)
end

core.override_item('x_farming:carrot', carrot_def)

-- Golden carrot
local golden_carrot_def = {
    description = S('Golden Carrot') .. '\n' .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 10'),
    inventory_image = 'x_farming_carrot_golden.png',
    wield_image = 'x_farming_carrot_golden.png',
    groups = {
        -- MCL
        food = 2,
        eatable = 1,
    },
    _mcl_saturation = 14.4,
}

if x_farming.hbhunger ~= nil or x_farming.hunger_ng ~= nil then
    golden_carrot_def.description = golden_carrot_def.description .. '\n' .. core.colorize(x_farming.colors.red, S('Heal') .. ': 10')
end

if core.get_modpath('farming') then
    golden_carrot_def.on_use = core.item_eat(10)
end

if core.get_modpath('mcl_farming') then
    golden_carrot_def.on_place = core.item_eat(10)
    golden_carrot_def.on_secondary_use = core.item_eat(10)
end

core.register_craftitem('x_farming:carrot_golden', golden_carrot_def)

---crate
x_farming.register_crate('crate_carrot_3', {
    description = S('Carrot Crate'),
    short_description = S('Carrot Crate'),
    tiles = { 'x_farming_crate_carrot_3.png' },
    _custom = {
        crate_item = 'x_farming:carrot'
    }
})

core.register_decoration(asuna.features.crops.carrot.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1103,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:carrot_5",
        "x_farming:carrot_6",
        "x_farming:carrot_7",
        "x_farming:carrot_8",
    },
}))
