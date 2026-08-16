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

core.register_tool('x_farming:honeycomb_saw', {
    description = S('Honeycomb Saw'),
    inventory_image = 'x_farming_honeycomb_saw.png',
    wield_image = 'x_farming_honeycomb_saw.png',
    wield_scale = { x = 2, y = 2, z = 1 },
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            crumbly = { times = { [2] = 3.00,[3] = 0.70 }, uses = 0, maxlevel = 1 },
            snappy = { times = { [3] = 0.40 }, uses = 0, maxlevel = 1 },
            oddly_breakable_by_hand = { times = { [1] = 3.50,[2] = 2.00,[3] = 0.70 }, uses = 0 }
        },
        damage_groups = { fleshy = 1 },
    },
    sound = { breaks = 'x_farming_tool_breaks' },
    -- MCL
    _mcl_toollike_wield = true,
})
