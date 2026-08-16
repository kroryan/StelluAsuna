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

-- name, hunger_change, replace_with_item, poisen, heal, sound

-- Beetroot
hbhunger.register_food('x_farming:beetroot', 3)
hbhunger.register_food('x_farming:beetroot_soup', 6, 'x_farming:bowl')

-- Carrot
hbhunger.register_food('x_farming:carrot', 3)
hbhunger.register_food('x_farming:carrot_golden', 10, nil, nil, 10)

-- Coffee
hbhunger.register_food('x_farming:coffee_cup_hot', 6, nil, nil, 4)

-- Corn
hbhunger.register_food('x_farming:corn_pop', 1)
hbhunger.register_food('x_farming:corn_popcorn', 5)

-- Melon
hbhunger.register_food('x_farming:melon', 2)
hbhunger.register_food('x_farming:golden_melon', 10, '', nil, 10)

-- Potato
hbhunger.register_food('x_farming:potato', 2)
hbhunger.register_food('x_farming:bakedpotato', 6)
hbhunger.register_food('x_farming:poisonouspotato', -6, nil, 5)

-- Pumpkin
hbhunger.register_food('x_farming:pumpkin_pie', 6)

-- Fish stew
hbhunger.register_food('x_farming:fish_stew', 8, 'x_farming:bowl')

-- Cocoa
hbhunger.register_food('x_farming:cookie', 2)
hbhunger.register_food('x_farming:chocolate', 3)

-- Kiwi
hbhunger.register_food('x_farming:kiwi_fruit', 2)

-- Dragon fruit
hbhunger.register_food('x_farming:cactus_fruit_item', 2)

-- Strawberry
hbhunger.register_food('x_farming:strawberry', 2)

-- Pine Nut Roasted
hbhunger.register_food('x_farming:pine_nut_roasted', 2)

-- Donuts
hbhunger.register_food('x_farming:donut', 3)
hbhunger.register_food('x_farming:donut_chocolate', 4)

-- Fries
hbhunger.register_food('x_farming:fries', 6)

-- Bread
hbhunger.register_food('x_farming:bread', 5)

-- Bottle Honey
if x_farming.vessels then
    hbhunger.register_food('x_farming:bottle_honey', 6, 'vessels:glass_bottle')
else
    hbhunger.register_food('x_farming:bottle_honey', 6, 'x_farming:glass_bottle')
end

-- Sushi
hbhunger.register_food('x_farming:sushi_maki', 5)
hbhunger.register_food('x_farming:sushi_nigiri', 3)


hbhunger.register_food('x_farming:bowl_french_potatoes', 8, 'x_farming:bowl')
hbhunger.register_food('x_farming:bowl_baked_fish', 8, 'x_farming:bowl')
hbhunger.register_food('x_farming:bowl_melon_slush', 8, 'x_farming:bowl')

hbhunger.register_food('x_farming:slice_strawberry_pie', 6)
hbhunger.register_food('x_farming:slice_chocolate_pie', 6)
hbhunger.register_food('x_farming:slice_honey_kiwi_pie', 6)
