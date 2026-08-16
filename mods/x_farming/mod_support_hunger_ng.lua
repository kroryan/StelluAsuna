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

-- Beetroot
hunger_ng.add_hunger_data('x_farming:beetroot', { satiates = 3 })
hunger_ng.add_hunger_data('x_farming:beetroot_soup', { satiates = 6 }, 'x_farming:bowl')

-- Carrot
hunger_ng.add_hunger_data('x_farming:carrot', { satiates = 3 })
hunger_ng.add_hunger_data('x_farming:carrot_golden', { satiates = 10, heals = 10 })

-- Coffee
hunger_ng.add_hunger_data('x_farming:coffee_cup_hot', { satiates = 6, heals = 4 })

-- Corn
hunger_ng.add_hunger_data('x_farming:corn_pop', { satiates = 1 })
hunger_ng.add_hunger_data('x_farming:corn_popcorn', { satiates = 5 })

-- Melon
hunger_ng.add_hunger_data('x_farming:melon', { satiates = 2 })
hunger_ng.add_hunger_data('x_farming:golden_melon', { satiates = 10, heals = 10 })

-- Potato
hunger_ng.add_hunger_data('x_farming:potato', { satiates = 2 })
hunger_ng.add_hunger_data('x_farming:bakedpotato', { satiates = 6 })
hunger_ng.add_hunger_data('x_farming:poisonouspotato', { satiates = -6, heals= -6 })

-- Pumpkin
hunger_ng.add_hunger_data('x_farming:pumpkin_pie', { satiates = 6 })

-- Fish stew
hunger_ng.add_hunger_data('x_farming:fish_stew', { satiates = 8, returns = 'x_farming:bowl' })

-- Cocoa
hunger_ng.add_hunger_data('x_farming:cookie', { satiates = 2 })
hunger_ng.add_hunger_data('x_farming:chocolate', { satiates = 3 })

-- Kiwi
hunger_ng.add_hunger_data('x_farming:kiwi_fruit', { satiates = 2 })

-- Dragon fruit
hunger_ng.add_hunger_data('x_farming:cactus_fruit_item', { satiates = 2 })

-- Strawberry
hunger_ng.add_hunger_data('x_farming:strawberry', { satiates = 2 })

-- Pine Nut Roasted
hunger_ng.add_hunger_data('x_farming:pine_nut_roasted', { satiates = 2 })

-- Donuts
hunger_ng.add_hunger_data('x_farming:donut', { satiates = 3 })
hunger_ng.add_hunger_data('x_farming:donut_chocolate', { satiates = 4 })

--  Fries
hunger_ng.add_hunger_data('x_farming:fries', { satiates = 6 })
hunger_ng.add_hunger_data('x_farming:bread', { satiates = 5 })

-- Bottle Honey
if x_farming.vessels then
    hunger_ng.add_hunger_data('x_farming:bottle_honey', { satiates = 6, returns = 'vessels:glass_bottle' })
else
    hunger_ng.add_hunger_data('x_farming:bottle_honey', { satiates = 6, returns = 'x_farming:glass_bottle' })
end

-- Sushi
hunger_ng.add_hunger_data('x_farming:sushi_maki', { satiates = 5 })
hunger_ng.add_hunger_data('x_farming:sushi_nigiri', { satiates = 3 })

hunger_ng.add_hunger_data('x_farming:bowl_french_potatoes', { satiates = 8, returns = 'x_farming:bowl' })
hunger_ng.add_hunger_data('x_farming:bowl_baked_fish', { satiates = 8, returns = 'x_farming:bowl' })
hunger_ng.add_hunger_data('x_farming:bowl_melon_slush', { satiates = 8, returns = 'x_farming:bowl' })

hunger_ng.add_hunger_data('x_farming:slice_strawberry_pie', { satiates = 6 })
hunger_ng.add_hunger_data('x_farming:slice_chocolate_pie', { satiates = 6 })
hunger_ng.add_hunger_data('x_farming:slice_honey_kiwi_pie', { satiates = 6 })
