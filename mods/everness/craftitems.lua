--[[
    Everness. Never ending discovery in Everness mapgen.
    Copyright (C) 2025 SaKeL

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

--]]

local S = core.get_translator(core.get_current_modname())
local tms = core.get_modpath("too_many_stones")

--
-- Craftitem registry
--

--  Quartz Crystal
if tms then
    core.register_alias("everness:quartz_crystal","too_many_stones:quartz")
else
    Everness:register_craftitem('everness:quartz_crystal', {
        description = S('Quartz Crystal'),
        inventory_image = 'everness_quartz.png',
    })
end

Everness:register_craftitem('everness:bamboo_item', {
    description = S('Bamboo'),
    inventory_image = 'everness_bamboo_item.png',
})

Everness:register_craftitem('everness:baobab_fruit_roasted', {
    description = S('Baobab Roasted Fruit') .. '\n'.. core.colorize(Everness.colors.brown, S('Hunger') .. ': 4'),
    inventory_image = 'everness_baobab_tree_fruit_roasted.png',
    on_use = core.item_eat(4),
})

Everness:register_craftitem('everness:pyrite_ingot', {
    description = S('Pyrite Ingot'),
    inventory_image = 'everness_pyrite_ingot.png'
})

if tms then
    core.register_alias("everness:pyrite_lump","too_many_stones:pyrite")
else
    Everness:register_craftitem('everness:pyrite_lump', {
        description = S('Pyrite Lump'),
        inventory_image = 'everness_pyrite_lump.png'
    })
end

Everness:register_craftitem('everness:coconut_fruit', {
    description = S('Coconut') .. '\n'.. core.colorize(Everness.colors.brown, S('Hunger') .. ': 4'),
    inventory_image = 'everness_coconut_item.png',
    wield_scale = { x = 2, y = 2, z = 1 },
    on_use = core.item_eat(4),
})

--
-- Crafting recipes
--

core.register_craft({
    output = 'everness:pyrite_ingot 9',
    recipe = {
        { 'everness:pyriteblock' },
    }
})

--
-- Cooking recipes
--

core.register_craft({
    type = 'cooking',
    output = 'everness:pyrite_ingot',
    recipe = 'everness:pyrite_lump',
})

