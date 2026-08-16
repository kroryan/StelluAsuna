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

---BEETROOT
x_farming.register_plant('x_farming:beetroot', {
    description = S('Beetroot Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Beetroot Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_beetroot_seed.png',
    steps = 8,
    minlight = minlight,
    maxlight = maxlight,
    fertility = { 'grassland' },
    groups = { flammable = 4, compost = 65 },
    place_param2 = 0,
})

---needed
local beetroot_def = {
    description = S('Beetroot') .. '\n' .. S('Compost chance') .. ': 65%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 3'),
    short_description = S('Beetroot'),
    groups = {
        -- X Farming
        compost = 65,
        -- MCL
        food = 2,
        eatable = 1,
        compostability = 65
    },
    _mcl_saturation = 1.2,
    _mcl_blast_resistance = 0,
}

if core.get_modpath('farming') then
    beetroot_def.on_use = core.item_eat(3)
end

if core.get_modpath('mcl_farming') then
    beetroot_def.on_place = core.item_eat(3)
    beetroot_def.on_secondary_use = core.item_eat(3)
end

core.override_item('x_farming:beetroot', beetroot_def)

---crate
x_farming.register_crate('crate_beetroot_3', {
    description = S('Beetroot Crate'),
    tiles = { 'x_farming_crate_beetroot_3.png' },
    _custom = {
        crate_item = 'x_farming:beetroot'
    }
})

core.register_decoration(asuna.features.crops.beetroot.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
        offset = -0.4125,
        scale = 0.3575,
        spread = {x = 14, y = 14, z = 14},
        seed = 1101,
        octaves = 2,
        persist = 0.62,
        lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:beetroot_5",
        "x_farming:beetroot_6",
        "x_farming:beetroot_7",
        "x_farming:beetroot_8",
    },
}))
