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
-- Crafting recipes
--

-- Cocoa
core.register_craft({
    output = 'dye:brown',
    recipe = {
        { 'x_farming:cocoa_bean' },
    }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:cookie 8',
    recipe = { 'x_farming:barley', 'x_farming:cocoa_bean', 'x_farming:flour', 'x_farming:bottle_soymilk', 'x_farming:sugar' }
})

core.register_craft({
    output = 'x_farming:chocolate',
    recipe = {
        { '', '', 'x_farming:cocoa_bean' },
        { '', 'x_farming:cocoa_bean', '' },
        { 'default:paper', '', '' },
    }
})

core.register_craft({
    output = 'x_farming:jungle_wood 4',
    recipe = {
        { 'x_farming:jungle_tree' },
    }
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:jungle_tree',
    burntime = 38,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:jungle_wood',
    burntime = 9,
})

-- Soup Bowl
core.register_craft({
    output = 'x_farming:bowl 3',
    recipe = {
        { 'group:wood', '', 'group:wood' },
        { '', 'group:wood', '' }
    }
})

-- fish stew
core.register_craft({
    output = 'x_farming:fish_stew',
    recipe = {
        { '', 'group:fish', '' },
        { 'x_farming:carrot', 'x_farming:bakedpotato', 'x_farming:salt' },
        { '', 'x_farming:bowl', '' }
    }
})

core.register_craft({
    output = 'x_farming:beetroot_soup',
    recipe = {
        { 'x_farming:beetroot', 'x_farming:beetroot', 'x_farming:beetroot' },
        { 'x_farming:beetroot', 'x_farming:beetroot', 'x_farming:beetroot' },
        { '', 'x_farming:bowl', '' }
    }
})

-- Carrot
core.register_craft({
    output = 'x_farming:carrot_golden',
    recipe = {
        { 'default:gold_lump', 'default:gold_lump', 'default:gold_lump' },
        { 'default:gold_lump', 'x_farming:carrot', 'default:gold_lump' },
        { 'default:gold_lump', 'default:gold_lump', 'default:gold_lump' }
    },
})

-- Coffee
core.register_craft({
    type = 'shapeless',
    output = 'x_farming:bottle_coffee',
    recipe = { 'x_farming:coffee', 'x_farming:bottle_water' }
})

if x_farming.vessels then
    core.register_craft({
        type = 'cooking',
        cooktime = 7,
        output = 'x_farming:coffee_cup_hot',
        recipe = 'x_farming:bottle_coffee',
        replacements = { { 'x_farming:bottle_coffee', 'vessels:glass_bottle' } }
    })
else
    core.register_craft({
        type = 'cooking',
        cooktime = 7,
        output = 'x_farming:coffee_cup_hot',
        recipe = 'x_farming:bottle_coffee',
        replacements = { { 'x_farming:bottle_coffee', 'x_farming:glass_bottle' } }
    })
end

-- Corn
core.register_craft({
    type = 'cooking',
    cooktime = 10,
    output = 'x_farming:corn_pop',
    recipe = 'x_farming:corn'
})

core.register_craft({
    output = 'x_farming:corn_popcorn',
    recipe = {
        { 'x_farming:corn_pop', 'x_farming:corn_pop', 'x_farming:corn_pop' },
        { 'default:paper', 'x_farming:salt', 'default:paper' },
        { 'default:paper', 'default:paper', 'default:paper' },
    }
})

-- Melon
core.register_craft({
    output = 'x_farming:golden_melon',
    recipe = {
        { 'default:gold_lump', 'default:gold_lump', 'default:gold_lump' },
        { 'default:gold_lump', 'x_farming:melon', 'default:gold_lump' },
        { 'default:gold_lump', 'default:gold_lump', 'default:gold_lump' }
    },
})

core.register_craft({
    output = 'x_farming:melon_block',
    recipe = {
        { 'x_farming:melon', 'x_farming:melon', 'x_farming:melon' },
        { 'x_farming:melon', 'x_farming:melon', 'x_farming:melon' },
        { 'x_farming:melon', 'x_farming:melon', 'x_farming:melon' }
    },
})

-- Obsidian Wart
core.register_craft({
    type = 'cooking',
    cooktime = 10,
    output = 'x_farming:wart_brick',
    recipe = 'x_farming:obsidian_wart'
})

core.register_craft({
    output = 'x_farming:wart_block',
    groups = { compost = 85 },
    recipe = {
        { 'x_farming:obsidian_wart', 'x_farming:obsidian_wart', 'x_farming:obsidian_wart' },
        { 'x_farming:obsidian_wart', 'x_farming:obsidian_wart', 'x_farming:obsidian_wart' },
        { 'x_farming:obsidian_wart', 'x_farming:obsidian_wart', 'x_farming:obsidian_wart' }
    }
})

core.register_craft({
    output = 'x_farming:wart_brick_block',
    recipe = {
        { 'x_farming:wart_brick', 'x_farming:wart_brick', '' },
        { 'x_farming:wart_brick', 'x_farming:wart_brick', '' }
    }
})

core.register_craft({
    output = 'x_farming:wart_red_brick_block',
    recipe = {
        { 'x_farming:obsidian_wart', 'x_farming:wart_brick', '' },
        { 'x_farming:wart_brick', 'x_farming:obsidian_wart', '' }
    },
})

core.register_craft({
    output = 'x_farming:wartrack 4',
    recipe = {
        { 'x_farming:wart_block', 'x_farming:wart_block', '' },
        { 'x_farming:wart_block', 'x_farming:wart_block', '' }
    },
})

core.register_craft({
    type = 'cooking',
    cooktime = 10,
    output = 'x_farming:bakedpotato',
    recipe = 'x_farming:potato'
})

-- Pumpkin
-- pumpkin lantern recipe
core.register_craft({
    output = 'x_farming:pumpkin_lantern',
    recipe = {
        { '', '', '' },
        { '', 'x_farming:pumpkin_block', '' },
        { '', 'group:torch', '' }
    },
})

-- pumpkin pie crafting recipe
core.register_craft({
    type = 'shapeless',
    output = 'x_farming:pumpkin_pie',
    recipe = { 'group:pumpkin', 'x_farming:flour', 'x_farming:bottle_soymilk', 'x_farming:sugar' }
})

-- pumpkin block carving
core.register_craft({
    type = 'shapeless',
    output = 'x_farming:pumpkin_block',
    recipe = { 'x_farming:pumpkin_fruit' }
})

--- FUELS

-- pumpkin as fuel (better than cactus)
core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:pumpkin_block',
    burntime = 20,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:pumpkin_lantern',
    burntime = 20,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:string',
    burntime = 1,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:barley',
    burntime = 1,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:rice',
    burntime = 1,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:cotton',
    burntime = 1,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:hoe_wood',
    burntime = 5,
})

core.register_craft({
    type = 'fuel',
    recipe = 'group:pillow',
    burntime = 5,
})

-- Bottle Water
if core.get_modpath("bottles_default") then
    -- do nothing, water bottles are implemented via Filled Bottles mod
elseif x_farming.vessels then
    core.register_craft({
        type = 'shapeless',
        output = 'x_farming:bottle_water 5',
        recipe = {
            'vessels:glass_bottle', 'vessels:glass_bottle', 'vessels:glass_bottle',
            'vessels:glass_bottle', 'vessels:glass_bottle', 'bucket:bucket_water'
        },
        replacements = { { 'bucket:water_bucket', 'bucket:bucket_empty' } },
    })

    core.register_craft({
        type = 'shapeless',
        output = 'x_farming:bottle_water 5',
        recipe = {
            'vessels:glass_bottle', 'vessels:glass_bottle', 'vessels:glass_bottle',
            'vessels:glass_bottle', 'vessels:glass_bottle', 'x_farming:seed_salt'
        },
        replacements = { { 'x_farming:seed_salt', 'x_farming:seed_salt' } },
    })
else
    core.register_craft({
        type = 'shapeless',
        output = 'x_farming:bottle_water 5',
        recipe = {
            'x_farming:glass_bottle', 'x_farming:glass_bottle', 'x_farming:glass_bottle',
            'x_farming:glass_bottle', 'x_farming:glass_bottle', 'bucket:bucket_water'
        },
        replacements = { { 'bucket:water_bucket', 'bucket:bucket_empty' } },
    })

    core.register_craft({
        type = 'shapeless',
        output = 'x_farming:bottle_water 5',
        recipe = {
            'x_farming:glass_bottle', 'x_farming:glass_bottle', 'x_farming:glass_bottle',
            'x_farming:glass_bottle', 'x_farming:glass_bottle', 'x_farming:seed_salt'
        },
        replacements = { { 'x_farming:seed_salt', 'x_farming:seed_salt' } },
    })
end

-- Donuts
core.register_craft({
    type = 'shapeless',
    output = 'x_farming:donut',
    recipe = { 'x_farming:bottle_soymilk', 'x_farming:sugar', 'x_farming:flour' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:donut_chocolate',
    recipe = { 'x_farming:bottle_soymilk', 'x_farming:sugar', 'x_farming:flour', 'x_farming:cocoa_bean' }
})

-- Fries

core.register_craft({
    output = 'x_farming:fries',
    recipe = {
        { '', '', 'x_farming:salt' },
        { '', 'x_farming:bakedpotato', '' },
        { 'default:paper', '', '' }
    },
})

-- Ice Fishing

core.register_craft({
    output = 'x_farming:seed_icefishing',
    recipe = {
        { 'group:pillow', 'x_farming:string', 'group:stick' },
        { '', 'x_farming:string', 'group:stick' },
        { '', 'x_farming:string', 'group:stick' }
    },
})

core.register_craft({
    output = 'dye:black 4',
    recipe = {
        { 'x_farming:black_seashroom' }
    }
})

core.register_craft({
    output = 'dye:blue 4',
    recipe = {
        { 'x_farming:blue_seashroom' }
    }
})

core.register_craft({
    output = 'dye:brown 4',
    recipe = {
        { 'x_farming:brown_seashroom' }
    }
})

core.register_craft({
    output = 'dye:cyan 4',
    recipe = {
        { 'x_farming:cyan_seashroom' }
    }
})

core.register_craft({
    output = 'dye:dark_grey 4',
    recipe = {
        { 'x_farming:gray_seashroom' }
    }
})

core.register_craft({
    output = 'dye:grey 4',
    recipe = {
        { 'x_farming:light_gray_seashroom' }
    }
})

core.register_craft({
    output = 'dye:dark_green 4',
    recipe = {
        { 'x_farming:green_seashroom' }
    }
})

core.register_craft({
    output = 'dye:green 4',
    recipe = {
        { 'x_farming:lime_seashroom' }
    }
})

core.register_craft({
    output = 'dye:magenta 4',
    recipe = {
        { 'x_farming:magenta_seashroom' }
    }
})

core.register_craft({
    output = 'dye:orange 4',
    recipe = {
        { 'x_farming:orange_seashroom' }
    }
})

core.register_craft({
    output = 'dye:pink 4',
    recipe = {
        { 'x_farming:pink_seashroom' }
    }
})

core.register_craft({
    output = 'dye:violet 4',
    recipe = {
        { 'x_farming:purple_seashroom' }
    }
})

core.register_craft({
    output = 'dye:red 4',
    recipe = {
        { 'x_farming:red_seashroom' }
    }
})

core.register_craft({
    output = 'dye:white 4',
    recipe = {
        { 'x_farming:white_seashroom' }
    }
})

core.register_craft({
    output = 'dye:yellow 4',
    recipe = {
        { 'x_farming:yellow_seashroom' }
    }
})

core.register_craft({
    output = 'default:diamond',
    recipe = {
        { 'x_farming:diamond_angler' }
    }
})

core.register_craft({
    output = 'default:gold_lump',
    recipe = {
        { 'x_farming:goldfish' }
    }
})

core.register_craft({
    output = 'default:gold_ingot',
    recipe = {
        { 'x_farming:true_goldfish' }
    }
})

core.register_craft({
    output = 'default:iron_lump',
    recipe = {
        { 'x_farming:ironfish' }
    }
})

core.register_craft({
    output = 'x_farming:seed_pumpkin',
    recipe = {
        { 'x_farming:pumpkinseed' }
    }
})


-- crates and bags
core.register_craft({
    output = 'x_farming:crate_empty',
    recipe = {
        { 'group:wood', 'group:stick', 'group:wood' },
        { 'group:wood', 'group:stick', 'group:wood' },
        { 'group:wood', 'group:wood', 'group:wood' }
    }
})

core.register_craft({
    output = 'x_farming:bag_empty',
    recipe = {
        { 'x_farming:barley_stack', '', 'x_farming:barley_stack' },
        { 'x_farming:barley_stack', '', 'x_farming:barley_stack' },
        { 'x_farming:barley_stack', 'x_farming:barley_stack', 'x_farming:barley_stack' }
    }
})

-- composter
core.register_craft({
    output = 'x_farming:composter_1',
    recipe = {
        { 'group:wood', 'group:fence', 'group:wood' },
        { 'group:wood', 'group:fence', 'group:wood' },
        { 'group:wood', 'group:wood', 'group:wood' }
    }
})

-- Cactus brick
core.register_craft({
    output = 'x_farming:cactus_brick',
    recipe = {
        { 'x_farming:cactus_fruit_item', 'x_farming:cactus_fruit_item' },
        { 'x_farming:cactus_fruit_item', 'x_farming:cactus_fruit_item' },
    }
})

-- Scarecrow
core.register_craft({
    output = 'x_farming:scarecrow',
    recipe = {
        { '', 'x_farming:pumpkin_block', '' },
        { 'x_farming:barley_stack', 'group:pillow', 'x_farming:barley_stack' },
        { '', 'group:wood', '' },
    }
})

-- Pine wood
core.register_craft({
    output = 'x_farming:pine_nut_wood 4',
    recipe = {
        { 'x_farming:pine_nut_tree' },
    }
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:pine_nut_wood',
    burntime = 6,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:pine_nut_tree',
    burntime = 26,
})

core.register_craft({
    type = 'cooking',
    cooktime = 7,
    output = 'x_farming:pine_nut_roasted',
    recipe = 'x_farming:pine_nut'
})

-- Kiwi

core.register_craft({
    output = 'x_farming:kiwi_wood 4',
    recipe = {
        { 'x_farming:kiwi_tree' },
    }
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:kiwi_wood',
    burntime = 8,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:kiwi_tree',
    burntime = 22,
})

-- Christmas tree
core.register_craft({
    output = 'x_farming:christmas_tree_sapling',
    recipe = {
        { 'default:goldblock', 'default:meselamp', 'default:goldblock' },
        { 'x_farming:pillow_green', 'default:pine_sapling', 'x_farming:pillow_blue' },
        { 'x_farming:pillow_yellow', 'default:pine_sapling', 'x_farming:pillow_red' }
    }
})

-- Barley

core.register_craft({
    output = 'x_farming:barley_stack 3',
    recipe = {
        { 'x_farming:barley', 'x_farming:barley', 'x_farming:barley' },
        { 'x_farming:barley', 'x_farming:barley', 'x_farming:barley' },
        { 'x_farming:barley', 'x_farming:barley', 'x_farming:barley' },
    }
})

core.register_craft({
    output = 'x_farming:barley 3',
    recipe = {
        { 'x_farming:barley_stack' },
    }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:flour',
    recipe = { 'x_farming:barley', 'x_farming:barley', 'x_farming:barley', 'x_farming:barley' }
})

core.register_craft({
    type = 'cooking',
    cooktime = 15,
    output = 'x_farming:bread',
    recipe = 'x_farming:flour'
})

-- Cotton
core.register_craft({
    output = 'x_farming:pillow_white',
    recipe = {
        { 'x_farming:cotton', 'x_farming:cotton' },
        { 'x_farming:cotton', 'x_farming:cotton' },
    }
})

core.register_craft({
    output = 'x_farming:string 2',
    recipe = {
        { 'x_farming:cotton' },
        { 'x_farming:cotton' },
    }
})

-- Soybean
core.register_craft({
    type = 'cooking',
    output = 'x_farming:bottle_soymilk',
    recipe = 'x_farming:bottle_soymilk_raw',
    cooktime = 15,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:soybean',
    burntime = 1,
})

-- Stevia

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:sugar',
    recipe = { 'x_farming:stevia', 'x_farming:stevia', 'x_farming:stevia', 'x_farming:stevia' }
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:stevia',
    burntime = 1,
})

-- Empty Jar
core.register_craft({
    output = 'x_farming:jar_empty',
    recipe = {
        { 'x_farming:glass_bottle', 'x_farming:glass_bottle' }
    }
})

core.register_craft({
    output = 'x_farming:jar_empty',
    recipe = {
        { 'vessels:glass_bottle', 'vessels:glass_bottle' }
    }
})

-- Hive
core.register_craft({
    output = 'x_farming:bee_hive',
    recipe = {
        { 'group:wood', 'group:wood', 'group:wood' },
        { 'x_farming:honeycomb', 'x_farming:honeycomb', 'x_farming:honeycomb' },
        { 'group:wood', 'group:wood', 'group:wood' }
    }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:honeycomb',
    recipe = { 'x_farming:jar_with_bee', 'x_farming:jar_with_bee', 'x_farming:jar_with_bee' }
})

-- Honeycomb saw
core.register_craft({
    output = 'x_farming:honeycomb_saw',
    recipe = {
        { '', 'x_farming:honeycomb', 'default:steel_ingot' },
        { 'x_farming:honeycomb', 'default:steel_ingot', '' },
        { 'group:stick', '', '' }
    }
})

core.register_craft({
    output = 'x_farming:honeycomb_block',
    recipe = {
        { 'x_farming:honeycomb', 'x_farming:honeycomb' },
        { 'x_farming:honeycomb', 'x_farming:honeycomb' },
    },
})

core.register_craft({
    output = 'x_farming:honey_block',
    recipe = {
        { 'x_farming:bottle_honey', 'x_farming:bottle_honey' },
        { 'x_farming:bottle_honey', 'x_farming:bottle_honey' },
    },
    replacements = {
        { 'x_farming:bottle_honey', 'x_farming:glass_bottle' },
        { 'x_farming:bottle_honey', 'x_farming:glass_bottle' },
        { 'x_farming:bottle_honey', 'x_farming:glass_bottle' },
        { 'x_farming:bottle_honey', 'x_farming:glass_bottle' },
    },
})

core.register_craft({
    output = 'x_farming:honey_block',
    recipe = {
        { 'x_farming:bottle_honey', 'x_farming:bottle_honey' },
        { 'x_farming:bottle_honey', 'x_farming:bottle_honey' },
    },
    replacements = {
        { 'x_farming:bottle_honey', 'vessels:glass_bottle' },
        { 'x_farming:bottle_honey', 'vessels:glass_bottle' },
        { 'x_farming:bottle_honey', 'vessels:glass_bottle' },
        { 'x_farming:bottle_honey', 'vessels:glass_bottle' },
    },
})

-- Candles

core.register_craft({
    output = 'x_farming:candle_off_1',
    recipe = {
        { 'x_farming:string' },
        { 'x_farming:honeycomb' },
    },
})

core.register_craft({
    output = 'x_farming:candle_off_1',
    recipe = {
        { 'farming:string' },
        { 'x_farming:honeycomb' },
    },
})

-- Rope

core.register_craft({
    output = 'x_farming:rope',
    recipe = {
        { '', 'x_farming:barley', '' },
        { '', 'x_farming:barley', '' },
        { '', 'x_farming:barley', '' }
    }
})

core.register_craft({
    output = 'x_farming:rope',
    recipe = {
        { '', 'group:vine', '' },
        { '', 'group:vine', '' },
        { '', 'group:vine', '' }
    }
})

if core.get_modpath("ethereal") then
    core.register_craft({
        output = 'x_farming:rope',
        recipe = {
            { '', 'ethereal:vine', '' },
            { '', 'ethereal:vine', '' },
            { '', 'ethereal:vine', '' }
        }
    })
end

if core.get_modpath("farming") and farming.mod == "redo" then
    core.register_alias_force("farming:hemp_rope","x_farming:rope")
    core.register_craft({
        output = 'x_farming:rope',
        recipe = {
            { '', 'farming:hemp_fibre', '' },
            { '', 'farming:hemp_fibre', '' },
            { '', 'farming:hemp_fibre', '' }
        }
    })
end

core.register_craft({
    output = 'x_farming:rope_fence 4',
    recipe = {
        { 'x_farming:rope', 'x_farming:rope', 'x_farming:rope' },
        { 'x_farming:rope', 'x_farming:rope', 'x_farming:rope' },
    }
})

core.register_craft({
    output = 'x_farming:safety_net',
    recipe = {
        { 'x_farming:rope', 'x_farming:rope' },
        { 'x_farming:rope', 'x_farming:rope' },
    }
})

-- Rice
core.register_craft({
    type = 'shapeless',
    output = 'x_farming:silt_loam_soil',
    recipe = { 'group:soil', 'default:clay', 'group:sand' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:silt_loam_soil',
    recipe = { 'group:soil', 'default:clay', 'group:everness_sand' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:silt_loam_soil',
    recipe = { 'group:soil', 'group:hardenedclay', 'group:sand' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:silt_loam_soil',
    recipe = { 'group:soil', 'group:hardenedclay', 'group:everness_sand' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:silt_loam_soil',
    recipe = { 'group:soil', 'group:hardenedclay_smooth', 'group:sand' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:silt_loam_soil',
    recipe = { 'group:soil', 'group:hardenedclay_smooth', 'group:everness_sand' }
})

core.register_craft({
    type = 'cooking',
    output = 'x_farming:rice_grains',
    recipe = 'x_farming:rice'
})

core.register_craft({
    output = 'x_farming:rice_stack 3',
    recipe = {
        { 'x_farming:rice', 'x_farming:rice', 'x_farming:rice' },
        { 'x_farming:rice', 'x_farming:rice', 'x_farming:rice' },
        { 'x_farming:rice', 'x_farming:rice', 'x_farming:rice' },
    }
})

core.register_craft({
    output = 'x_farming:rice 3',
    recipe = {
        { 'x_farming:rice_stack' },
    }
})

core.register_craft({
    output = 'x_farming:silt_loam_brick_block',
    recipe = {
        { 'x_farming:silt_loam_brick', 'x_farming:silt_loam_brick' },
        { 'x_farming:silt_loam_brick', 'x_farming:silt_loam_brick' },
    }
})

core.register_craft({
    output = 'x_farming:silt_loam_brick 4',
    recipe = {
        { 'x_farming:silt_loam_brick_block' },
    }
})

core.register_craft({
    type = 'cooking',
    output = 'x_farming:silt_loam_brick',
    recipe = 'x_farming:silt_loam_soil',
})

core.register_craft({
    output = 'x_farming:stove',
    recipe = {
        { 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
        { 'x_farming:silt_loam_brick_block', '', 'x_farming:silt_loam_brick_block' },
        { 'x_farming:silt_loam_brick_block', 'default:furnace', 'x_farming:silt_loam_brick_block' }
    }
})

-- Sushi

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:sushi_maki',
    recipe = { 'x_farming:rice_grains', 'default:sand_with_kelp', 'group:fish' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:sushi_nigiri',
    recipe = { 'x_farming:rice_grains', 'group:fish' }
})

-- Feasts

core.register_craft({
    output = 'x_farming:french_potatoes_1',
    recipe = {
        { 'x_farming:bakedpotato', 'x_farming:bottle_soymilk', 'x_farming:bakedpotato' },
        { 'x_farming:bakedpotato', 'x_farming:corn', 'x_farming:bakedpotato' },
        { 'x_farming:salt', 'x_farming:bowl', 'x_farming:salt' },
    }
})

core.register_craft({
    output = 'x_farming:baked_fish_1',
    recipe = {
        { 'x_farming:beetroot', 'x_farming:rice_grains', 'x_farming:beetroot' },
        { 'x_farming:carrot', 'group:fish', 'x_farming:carrot' },
        { 'x_farming:salt', 'x_farming:bowl', 'x_farming:salt' },
    }
})

core.register_craft({
    output = 'x_farming:melon_slush_1',
    recipe = {
        { 'x_farming:sugar', 'x_farming:melon_block', 'x_farming:sugar' },
        { 'default:ice', 'x_farming:melon_block', 'default:ice' },
        { 'default:ice', 'default:glass', 'default:ice' },
    }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:french_potatoes_1',
    recipe = { 'x_farming:bowl_french_potatoes', 'x_farming:bowl_french_potatoes', 'x_farming:bowl_french_potatoes', 'x_farming:bowl_french_potatoes' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:baked_fish_1',
    recipe = { 'x_farming:bowl_baked_fish', 'x_farming:bowl_baked_fish', 'x_farming:bowl_baked_fish', 'x_farming:bowl_baked_fish' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:melon_slush_1',
    recipe = { 'x_farming:bowl_melon_slush', 'x_farming:bowl_melon_slush', 'x_farming:bowl_melon_slush', 'x_farming:bowl_melon_slush' }
})

-- Pies
core.register_craft({
    output = 'x_farming:strawberry_pie_1',
    recipe = {
        { 'x_farming:barley', 'x_farming:barley', 'x_farming:barley' },
        { 'x_farming:strawberry', 'x_farming:strawberry', 'x_farming:strawberry' },
        { 'x_farming:sugar', 'x_farming:flour', 'x_farming:sugar' },
    }
})

core.register_craft({
    output = 'x_farming:chocolate_pie_1',
    recipe = {
        { 'x_farming:chocolate', 'x_farming:chocolate', 'x_farming:chocolate' },
        { 'x_farming:bottle_soymilk', 'x_farming:bottle_soymilk', 'x_farming:bottle_soymilk' },
        { 'x_farming:sugar', 'x_farming:flour', 'x_farming:sugar' },
    }
})

core.register_craft({
    output = 'x_farming:honey_kiwi_pie_1',
    recipe = {
        { 'x_farming:bottle_honey', 'x_farming:bottle_honey', 'x_farming:bottle_honey' },
        { 'x_farming:kiwi_fruit', 'x_farming:kiwi_fruit', 'x_farming:kiwi_fruit' },
        { 'x_farming:bottle_soymilk', 'x_farming:flour', 'x_farming:bottle_soymilk' },
    }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:strawberry_pie_1',
    recipe = { 'x_farming:slice_strawberry_pie', 'x_farming:slice_strawberry_pie', 'x_farming:slice_strawberry_pie', 'x_farming:slice_strawberry_pie' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:chocolate_pie_1',
    recipe = { 'x_farming:slice_chocolate_pie', 'x_farming:slice_chocolate_pie', 'x_farming:slice_chocolate_pie', 'x_farming:slice_chocolate_pie' }
})

core.register_craft({
    type = 'shapeless',
    output = 'x_farming:honey_kiwi_pie_1',
    recipe = { 'x_farming:slice_honey_kiwi_pie', 'x_farming:slice_honey_kiwi_pie', 'x_farming:slice_honey_kiwi_pie', 'x_farming:slice_honey_kiwi_pie' }
})
