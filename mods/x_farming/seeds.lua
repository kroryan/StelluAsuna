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

-- Register farming items as dungeon loot
if core.global_exists('dungeon_loot') then
    dungeon_loot.register({
        { name = 'x_farming:seed_obsidian_wart', chance = 0.3, count = { 1, 2 } },
        { name = 'x_farming:seed_pumpkin', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:seed_beetroot', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:seed_carrot', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:seed_potato', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:seed_coffee', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:seed_corn', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:seed_melon', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:cocoa_bean', chance = 0.4, count = { 1, 4 } },
        { name = 'x_farming:large_cactus_with_fruit_seedling', chance = 0.4, count = { 1, 1 } },
        { name = 'x_farming:kiwi_sapling', chance = 0.4, count = { 1, 1 } },
        { name = 'x_farming:seed_strawberry', chance = 0.4, count = { 1, 4 } },
    })
end
