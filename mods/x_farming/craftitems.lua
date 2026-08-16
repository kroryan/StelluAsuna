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

--
-- Craft items
--

local S = core.get_translator(core.get_current_modname())

-- Flour

core.register_craftitem('x_farming:flour', {
    description = S('Barley Flour'),
    inventory_image = 'x_farming_flour.png',
    groups = { food_flour = 1, flammable = 1 },
})

-- Bread

local bread_def = {
    description = S('Barley Bread'),
    inventory_image = 'x_farming_bread.png',
    groups = {
        -- MTG
        food_bread = 1,
        flammable = 2,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 85
    },
    _mcl_saturation = 6.0,
}

if core.get_modpath('farming') then
    bread_def.on_use = core.item_eat(5)
end

if core.get_modpath('mcl_farming') then
    bread_def.on_place = core.item_eat(5)
    bread_def.on_secondary_use = core.item_eat(5)
end

core.register_craftitem('x_farming:bread', bread_def)

-- String(
if core.get_modpath("farming") then
    core.register_alias("x_farming:string","farming:string")
else
    core.register_craftitem('x_farming:string', {
        description = S('Cotton String'),
        inventory_image = 'x_farming_string.png',
        groups = { flammable = 2 },
    })
end

-- Soup Bowl
if core.registered_items["farming:bowl"] then
    core.register_alias("x_farming:bowl","farming:bowl")
else
    core.register_craftitem('x_farming:bowl', {
        description = S('Empty Soup Bowl'),
        inventory_image = 'x_farming_bowl.png',
    })
end

-- Bottle Water
if core.registered_items["bottles:bottle_of_water"] then
    core.register_alias("x_farming:bottle_water","bottles:bottle_of_water")
else
    core.register_craftitem('x_farming:bottle_water', {
        description = S('Water Bottle'),
        tiles = { 'x_farming_bottle_water.png' },
        inventory_image = 'x_farming_bottle_water.png',
        wield_image = 'x_farming_bottle_water.png',
        groups = { vessel = 1 },
    })
end

-- Bottle Honey
local bottle_honey_def = {
    description = S('Honey Bottle') .. '\n' .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 6'),
    tiles = { 'x_farming_bottle_honey.png' },
    inventory_image = 'x_farming_bottle_honey.png',
    wield_image = 'x_farming_bottle_honey.png',
    groups = {
        -- MCL
        craftitem = 1,
        food = 3,
        eatable = 6,
        can_eat_when_full = 1
    },
    _mcl_saturation = 1.2,
}

if core.get_modpath('farming') then
    if x_farming.vessels then
        bottle_honey_def.on_use = core.item_eat(6, 'vessels:glass_bottle')
    else
        bottle_honey_def.on_use = core.item_eat(6, 'x_farming:glass_bottle')
    end
end

if core.get_modpath('mcl_farming') then
    if x_farming.vessels then
        bottle_honey_def.on_place = core.item_eat(6, 'x_farming:glass_bottle')
        bottle_honey_def.on_secondary_use = core.item_eat(6, 'x_farming:glass_bottle')
    else
        bottle_honey_def.on_place = core.item_eat(6, 'x_farming:glass_bottle')
        bottle_honey_def.on_secondary_use = core.item_eat(6, 'x_farming:glass_bottle')
    end
end

core.register_craftitem('x_farming:bottle_honey', bottle_honey_def)

-- Honeycomb
core.register_craftitem('x_farming:honeycomb', {
    description = S('Honeycomb'),
    inventory_image = 'x_farming_honeycomb.png',
})

-- Jar empty
core.register_craftitem('x_farming:jar_empty', {
    description = S('Empty Jar - Right-click to catch Bee with it'),
    inventory_image = 'x_farming_jar_empty.png',
    groups = { vessel = 1 }
})

-- Jar with bee
core.register_craftitem('x_farming:jar_with_bee', {
    description = S('Jar with Bee - Right-click to add bee to a Hive'),
    inventory_image = 'x_farming_jar_with_bee.png',
    groups = { bee = 1, not_in_creative_inventory = 1 }
})

-- Rice
core.register_craftitem('x_farming:rice_grains', {
    description = S('Rice Grains'),
    inventory_image = 'x_farming_rice_grains.png',
})

-- Sushi
local sushi_maki_def = {
    description = S('Sushi Maki') .. '\n' .. S('Compost chance') .. ': 85%\n'
    .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 5'),
    inventory_image = 'x_farming_sushi_maki.png',
    groups = {
        -- MTG
        flammable = 2,
        -- MCL
        food = 2,
        eatable = 5,
        compostability = 85
    },
    _mcl_saturation = 6.0,
}

if core.get_modpath('farming') then
    sushi_maki_def.on_use = core.item_eat(5)
end

if core.get_modpath('mcl_farming') then
    sushi_maki_def.on_place = core.item_eat(5)
    sushi_maki_def.on_secondary_use = core.item_eat(5)
end

core.register_craftitem('x_farming:sushi_maki', sushi_maki_def)

local sushi_nigiri_def = {
    description = S('Sushi Nigiri') .. '\n' .. S('Compost chance') .. ': 85%\n'
    .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 3'),
    inventory_image = 'x_farming_sushi_nigiri.png',
    groups = {
        -- MTG
        flammable = 2,
        -- MCL
        food = 2,
        eatable = 3,
        compostability = 85
    },
    _mcl_saturation = 4.0,
}

if core.get_modpath('farming') then
    sushi_nigiri_def.on_use = core.item_eat(3)
end

if core.get_modpath('mcl_farming') then
    sushi_nigiri_def.on_place = core.item_eat(3)
    sushi_nigiri_def.on_secondary_use = core.item_eat(3)
end

core.register_craftitem('x_farming:sushi_nigiri', sushi_nigiri_def)

-- Brick
core.register_craftitem('x_farming:silt_loam_brick', {
    description = S('Silt Loam Brick'),
    inventory_image = 'x_farming_silt_loam_brick.png',
})
