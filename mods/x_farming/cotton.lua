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

if core.get_modpath("farming") then
    core.register_alias("x_farming:cotton","farming:cotton")
else
    -- COTTON
    x_farming.register_plant('x_farming:cotton', {
        description = S('Cotton Seed') .. '\n' .. S('Compost chance') .. ': 30%',
        short_description = S('Cotton Seed'),
        paramtype2 = 'meshoptions',
        inventory_image = 'x_farming_cotton_seed.png',
        steps = 8,
        minlight = 13,
        maxlight = 14,
        fertility = { 'grassland' },
        groups = { flammable = 4 },
        place_param2 = 34,
    })

    -- needed
    local cotton_def = {
        description = S('Cotton') .. '\n' .. S('Compost chance') .. ': 50%',
        short_description = S('Cotton'),
        groups = {
            -- X Farming
            compost = 50,
            -- MCL
            compostability = 50,
        }
    }

    core.override_item('x_farming:cotton', cotton_def)

    core.register_decoration(asuna.features.crops.cotton.inject_decoration({
        deco_type = "simple",
        sidelen = 8,
        noise_params = {
            offset = -0.4125,
            scale = 0.3575,
            spread = {x = 14, y = 14, z = 14},
            seed = 1106,
            octaves = 2,
            persist = 0.62,
            lacunarity = 0.675,
        },
        y_max = 31000,
        y_min = 5,
        decoration = {
            "x_farming:cotton_5",
            "x_farming:cotton_6",
            "x_farming:cotton_7",
            "x_farming:cotton_8",
        },
    }))
end

-- Crate
x_farming.register_crate('crate_cotton2_3', {
    description = S('Cotton Crate'),
    short_description = S('Cotton Crate'),
    tiles = { 'x_farming_crate_cotton2_3.png' },
    _custom = {
        crate_item = 'x_farming:cotton'
    }
})
