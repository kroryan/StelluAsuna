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

-- Authors of source code
-- ----------------------
-- Originally by Vanessa Ezekowitz (LGPLv2.1+)
-- Modified by Perttu Ahola <celeron55@gmail.com> (LGPLv2.1+)
-- Various Luanti developers and contributors (LGPLv2.1+)

local S = core.get_translator(core.get_current_modname())

core.register_node('x_farming:glass_bottle', {
    description = S('Empty Glass Bottle'),
    drawtype = 'plantlike',
    tiles = { 'x_farming_vessels_glass_bottle.png' },
    inventory_image = 'x_farming_vessels_glass_bottle.png',
    wield_image = 'x_farming_vessels_glass_bottle.png',
    paramtype = 'light',
    is_ground_content = false,
    walkable = false,
    selection_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 }
    },
    groups = { vessel = 1, dig_immediate = 3, attached_node = 1 },
    sounds = x_farming.node_sound_thin_glass_defaults(),
})

core.register_craft({
    output = 'x_farming:glass_bottle 10',
    recipe = {
        { 'default:glass', '', 'default:glass' },
        { 'default:glass', '', 'default:glass' },
        { '', 'default:glass', '' }
    }
})

core.register_craft({
    output = 'x_farming:glass_bottle 10',
    recipe = {
        { 'group:glass', '', 'group:glass' },
        { 'group:glass', '', 'group:glass' },
        { '', 'group:glass', '' }
    }
})
