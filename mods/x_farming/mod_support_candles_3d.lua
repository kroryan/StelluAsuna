--[[
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

-- Candles

core.register_craft({
    output = 'candles_3d:unlit_orange_1',
    recipe = {
        { 'x_farming:string' },
        { 'x_farming:honeycomb' },
        { 'x_farming:honeycomb' },
    },
})

core.register_craft({
    output = 'candles_3d:unlit_orange_1',
    recipe = {
        { 'farming:string' },
        { 'x_farming:honeycomb' },
        { 'x_farming:honeycomb' },
    },
})
