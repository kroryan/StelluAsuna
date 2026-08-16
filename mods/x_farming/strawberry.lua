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

-- STRAWBERRY
x_farming.register_plant('x_farming:strawberry', {
    description = S('Strawberry Seed') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Strawberry Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_strawberry_seed.png',
    steps = 4,
    minlight = 13,
    maxlight = 14,
    fertility = { 'grassland' },
    groups = { flammable = 4 },
    place_param2 = 0
})

-- needed
local strawberry_def = {
    description = S('Strawberry') .. '\n' .. S('Compost chance') .. ': 30%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 2'),
    groups = {
        -- X Farming
        compost = 30,
        -- MCL
        compostability = 30
    },
    short_description = S('Strawberry'),
}

if core.get_modpath('farming') then
    strawberry_def.on_use = core.item_eat(2)
end

if core.get_modpath('mcl_farming') then
    strawberry_def.on_place = core.item_eat(2)
    strawberry_def.on_secondary_use = core.item_eat(2)
end

core.override_item('x_farming:strawberry', strawberry_def)

---crate
x_farming.register_crate('crate_strawberry_3', {
    description = S('Strawberry Crate'),
    short_description = S('Strawberry Crate'),
    tiles = { 'x_farming_crate_strawberry_3.png' },
    _custom = {
        crate_item = 'x_farming:strawberry'
    }
})

core.register_decoration(asuna.features.crops.strawberry.inject_decoration({
    deco_type = "simple",
    sidelen = 8,
    noise_params = {
      offset = -0.4125,
      scale = 0.3575,
      spread = {x = 14, y = 14, z = 14},
      seed = 1114,
      octaves = 2,
      persist = 0.62,
      lacunarity = 0.675,
    },
    y_max = 31000,
    y_min = 5,
    decoration = {
        "x_farming:strawberry_1",
        "x_farming:strawberry_2",
        "x_farming:strawberry_3",
        "x_farming:strawberry_4",
    },
  }))
