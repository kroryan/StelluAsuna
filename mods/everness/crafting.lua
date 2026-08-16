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

--- Single shapeless craft
---@param input_name string
---@param output_name string
local function register_craft_single(input_name, output_name)
    core.register_craft({
        type = 'shapeless',
        output = output_name,
        recipe = { input_name }
    })
end

--- 2x2 same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_2x2(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name},
            {input_name, input_name},
        }
    })
end

--- 3x2 same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_3x2(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name, input_name},
            {input_name, input_name, input_name},
        }
    })
end

--- 3x2 shaped craft, top same material, bottom (different from top) same material
---@param input_top_name string
---@param input_bottom_name string
---@param output_name string
local function register_craft_3x2_composite(input_top_name, input_bottom_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_top_name, input_top_name, input_top_name},
            {input_bottom_name, input_bottom_name, input_bottom_name},
        }
    })
end

--- 1x2 shaped craft, top same material, bottom (different from top) same material
---@param input_top_name string
---@param input_bottom_name string
---@param output_name string
local function register_craft_1x2_composite(input_top_name, input_bottom_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_top_name},
            {input_bottom_name},
        }
    })
end

--- 1x3 same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_1x3(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name},
            {input_name},
            {input_name},
        }
    })
end

--- 2x1 same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_2x1(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name},
        }
    })
end

--- 2x1 shaped craft, each material different
---@param input_first_name string
---@param input_second_name string
---@param output_name string
local function register_craft_2x1_composite(input_first_name, input_second_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_first_name, input_second_name},
        }
    })
end

--- 2x3 same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_2x3(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name},
            {input_name, input_name},
            {input_name, input_name},
        }
    })
end

--- 3x1 same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_3x1(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name, input_name},
        }
    })
end

--- 3x3 same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_3x3(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name, input_name},
            {input_name, input_name, input_name},
            {input_name, input_name, input_name},
        }
    })
end

--- 'anvil' pattern, same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_anvil_pattern(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name, input_name},
            {'', input_name, ''},
            {input_name, input_name, input_name},
        }
    })
end

--- 'bullseye' pattern, shaped craft, same material around the center, center different material
---@param input_around_name string
---@param input_center_name string
---@param output_name string
local function register_craft_bullseye_pattern(input_around_name, input_center_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_around_name, input_around_name, input_around_name},
            {input_around_name, input_center_name, input_around_name},
            {input_around_name, input_around_name, input_around_name},
        }
    })
end

--- 'sandwich' pattern, shaped craft, same material top/bottom rows, center row different material
---@param input_around_name string
---@param input_center_name string
---@param output_name string
local function register_craft_sandwich_pattern(input_around_name, input_center_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_around_name, input_around_name, input_around_name},
            {input_center_name, input_center_name, input_center_name},
            {input_around_name, input_around_name, input_around_name},
        }
    })
end

--- 'pillar top' pattern, same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_pillar_top(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {input_name, input_name, input_name},
            {'', input_name, ''},
            {'', input_name, ''},
        }
    })
end

--- 'pillar bottom' pattern, same material shaped craft
---@param input_name string
---@param output_name string
local function register_craft_pillar_bottom(input_name, output_name)
    core.register_craft({
        type = 'shaped',
        output = output_name,
        recipe = {
            {'', input_name, ''},
            {'', input_name, ''},
            {input_name, input_name, input_name},
        }
    })
end

--
-- Default Blocks
--
if core.get_modpath('default') then
    register_craft_3x3('default:snowblock', 'everness:snowcobble 9')
    register_craft_3x3('default:ice', 'everness:icecobble 9')
    register_craft_single('everness:chest', 'default:chest')
end

--
-- Cobbles
--
register_craft_3x3('everness:frosted_ice', 'everness:icecobble 9')
register_craft_3x3('everness:frosted_snowblock', 'everness:snowcobble 9')

--
-- Bamboo
--
register_craft_2x2('everness:bamboo_item', 'everness:bamboo_wood')
register_craft_3x3('everness:bamboo_item', 'everness:bamboo_block')
register_craft_2x2('everness:bamboo_wood', 'everness:bamboo_mosaic_wood')
register_craft_3x2('everness:bamboo_wood', 'everness:trapdoor_bamboo 2')

--
-- Ice
--
register_craft_single('everness:frosted_ice', 'everness:frosted_ice_translucent')
register_craft_single('everness:frosted_ice_translucent', 'everness:frosted_ice')

--
-- Trapdoors
--
register_craft_3x2('everness:crystal_wood', 'everness:trapdoor_crystal_wood 2')
register_craft_3x2('everness:dry_wood', 'everness:trapdoor_cursed_wood 2')
register_craft_3x2('everness:lava_tree_wood', 'everness:trapdoor_lava_tree 2')
register_craft_3x2('everness:palm_tree_wood', 'everness:trapdoor_palm_wood 2')

--
-- Pyrite
--
register_craft_3x3('everness:pyrite_ingot', 'everness:pyriteblock')

register_craft_2x2('everness:pyriteblock_forged', 'everness:pyriteblock_brick 4')
register_craft_3x3('everness:pyriteblock_forged', 'everness:pyriteblock_polished 9')
register_craft_2x3('everness:pyriteblock_forged', 'everness:pyrite_roof_tile 6')

register_craft_1x2_composite('group:glass', 'everness:pyrite_ingot', 'everness:pyrite_glass')

if core.get_modpath('default') then
    register_craft_1x2_composite('default:glass', 'everness:pyrite_ingot', 'everness:pyrite_glass')
end

register_craft_1x2_composite('everness:pyrite_glass', 'everness:pyrite_ingot', 'everness:pyrite_lantern')
register_craft_2x1('everness:pyriteblock_forged', 'everness:pyriteblock_slab_brick 2')

register_craft_bullseye_pattern('everness:pyriteblock_forged', '', 'everness:pyriteblock_spiral 8')

register_craft_pillar_bottom('everness:pyriteblock_forged', 'everness:pyrite_pillar_bottom 5')
register_craft_1x3('everness:pyriteblock_forged', 'everness:pyrite_pillar_middle 3')
register_craft_pillar_top('everness:pyriteblock_forged', 'everness:pyrite_pillar_top 5')

register_craft_anvil_pattern('everness:pyriteblock_forged', 'everness:pyrite_pillar_small 7')

--
-- Glass
--
register_craft_bullseye_pattern('everness:glass', 'everness:bloodspore_plant', 'everness:tinted_glass_red 8')
register_craft_bullseye_pattern('everness:glass', 'everness:bloodspore_plant_small', 'everness:tinted_glass_red 8')

--
-- Tree into wood
--
local recipes_wood = {
    {'everness:baobab_tree', 'everness:baobab_wood 4'},
    {'everness:coral_tree', 'everness:coral_wood 4'},
    {'everness:crystal_tree', 'everness:crystal_wood 4'},
    {'everness:dry_tree', 'everness:dry_wood 4'},
    {'everness:lava_tree', 'everness:lava_tree_wood 4'},
    {'everness:lava_tree_with_lava', 'everness:lava_tree_wood 4'},
    {'everness:mese_tree', 'everness:mese_wood 4'},
    {'everness:sequoia_tree', 'everness:sequoia_wood 4'},
    {'everness:willow_tree', 'everness:willow_wood 4'},
    {'everness:palm_tree', 'everness:palm_tree_wood 4'},
}

for _, data in ipairs(recipes_wood) do
    register_craft_single(data[1], data[2])
end

--
-- Sand into sandstone
--
local recipes_sandstone = {
    {'everness:coral_forest_deep_ocean_sand', 'everness:coral_deep_ocean_sandstone_block 4'},
    {'everness:coral_sand', 'everness:coral_sandstone 4'},
    {'everness:coral_white_sand', 'everness:coral_white_sandstone 4'},
    {'everness:crystal_forest_deep_ocean_sand', 'everness:crystal_forest_deep_ocean_sandstone_block 4'},
    {'everness:crystal_sand', 'everness:crystal_sandstone 4'},
    {'everness:cursed_lands_deep_ocean_sand', 'everness:cursed_lands_deep_ocean_sandstone_block 4'},
    {'everness:cursed_sand', 'everness:cursed_sandstone_block 4'},
    {'everness:mineral_sand', 'everness:mineral_sandstone 4'},
}

for _, data in ipairs(recipes_sandstone) do
    register_craft_2x2(data[1], data[2])
end

--
-- Stone and bone into brick
--
local recipes_brick = {
    {'everness:coral_bones_block', 'everness:coral_bones_brick 4'},
    {'everness:coral_deep_ocean_sandstone_block', 'everness:coral_deep_ocean_sandstone_brick 4'},
    {'everness:coral_desert_stone', 'everness:coral_desert_stone_brick 4'},
    {'everness:coral_sandstone', 'everness:coral_sandstone_brick 4'},
    {'everness:coral_white_sandstone', 'everness:coral_white_sandstone_brick 4'},
    {'everness:crystal_forest_deep_ocean_sandstone_block', 'everness:crystal_forest_deep_ocean_sandstone_brick 4'},
    {'everness:crystal_sandstone', 'everness:crystal_sandstone_brick 4'},
    {'everness:cursed_lands_deep_ocean_sandstone_block', 'everness:cursed_lands_deep_ocean_sandstone_brick 4'},
    {'everness:cursed_sandstone_block', 'everness:cursed_sandstone_brick 4'},
    {'everness:cursed_stone', 'everness:cursed_brick 4'},
    {'everness:forsaken_desert_stone', 'everness:forsaken_desert_brick_red 4'},
    {'everness:forsaken_tundra_stone', 'everness:forsaken_tundra_brick 4'},
    {'everness:mineral_sandstone', 'everness:mineral_sandstone_brick 4'},
    {'everness:mineral_stone', 'everness:mineral_stone_brick 4'},
}

for _, data in ipairs(recipes_brick) do
    register_craft_2x2(data[1], data[2])
end

--
-- Base materials into blocks
--
register_craft_2x2('everness:quartz_crystal', 'everness:quartz_block 4')

register_craft_3x3('everness:coral_bones', 'everness:coral_bones_block 9')
register_craft_3x3('everness:coral_desert_stone', 'everness:coral_desert_stone_block 9')
register_craft_3x3('everness:crystal_cyan', 'everness:crystal_block_cyan')
register_craft_3x3('everness:crystal_orange', 'everness:crystal_block_orange')
register_craft_3x3('everness:crystal_purple', 'everness:crystal_block_purple')
register_craft_3x3('everness:mineral_sandstone', 'everness:mineral_sandstone_block 9')
register_craft_3x3('everness:mineral_stone', 'everness:mineral_stone_block 9')

--
-- Blocks into base materials
--
register_craft_single('everness:crystal_block_cyan', 'everness:crystal_cyan 9')
register_craft_single('everness:crystal_block_orange', 'everness:crystal_orange 9')
register_craft_single('everness:crystal_block_purple', 'everness:crystal_purple 9')

--
-- Carved and chiseled blocks
--
register_craft_2x2('everness:coral_sandstone_chiseled', 'everness:coral_sandstone_carved_1 9')
register_craft_2x2('everness:quartz_block', 'everness:quartz_chiseled 4')

register_craft_3x3('everness:coral_sandstone', 'everness:coral_sandstone_chiseled 9')
register_craft_3x3('everness:crystal_sandstone', 'everness:crystal_sandstone_chiseled 9')
register_craft_3x3('everness:cursed_brick', 'everness:cursed_brick_carved 9')

register_craft_1x2_composite('everness:forsaken_desert_brick_red', 'everness:forsaken_desert_brick', 'everness:forsaken_desert_chiseled_stone')

--
-- Masonry items
--
register_craft_1x3('everness:coral_white_sandstone', 'everness:coral_white_sandstone_pillar 3')
register_craft_1x3('everness:quartz_block', 'everness:quartz_pillar 3')

register_craft_2x1_composite('everness:cursed_brick', 'group:leaves', 'everness:cursed_brick_with_growth 4')

core.register_craft({
    output = 'everness:cursed_brick_mixed 4',
    recipe = {
        { 'everness:cursed_stone', 'everness:cursed_brick' },
        { 'everness:cursed_brick', 'everness:cursed_stone' },
    }
})

register_craft_2x1_composite('everness:forsaken_desert_cobble_red', 'everness:forsaken_desert_sand', 'everness:forsaken_desert_cobble')
register_craft_2x1_composite('everness:forsaken_desert_brick_red', 'everness:forsaken_desert_sand', 'everness:forsaken_desert_brick')

register_craft_2x2('everness:forsaken_desert_brick', 'everness:forsaken_desert_engraved_stone 4')

--
-- Misc items
--
core.register_craft({
    output = 'everness:coral_forest_deep_ocean_lantern 1',
    recipe = {
        { 'everness:coral_deep_ocean_sandstone_block', 'group:glass', 'everness:coral_deep_ocean_sandstone_block' },
        { 'group:glass', 'group:torch', 'group:glass' },
        { 'everness:coral_deep_ocean_sandstone_block', 'group:glass', 'everness:coral_deep_ocean_sandstone_block' },
    }
})

if core.get_modpath('default') then
    core.register_craft({
        output = 'everness:coral_forest_deep_ocean_lantern 1',
        recipe = {
            { 'everness:coral_deep_ocean_sandstone_block', 'default:glass', 'everness:coral_deep_ocean_sandstone_block' },
            { 'default:glass', 'group:torch', 'default:glass' },
            { 'everness:coral_deep_ocean_sandstone_block', 'default:glass', 'everness:coral_deep_ocean_sandstone_block' },
        }
    })
end

core.register_craft({
    output = 'everness:shell_of_underwater_breathing',
    recipe = {
        { '', '', 'group:everness_crystal_forest_deep_ocean_coral' },
        { '', 'group:everness_cursed_lands_deep_ocean_coral', '' },
        { 'group:everness_coral_forest_deep_ocean_coral', '', '' },
    }
})

register_craft_3x3('everness:mese_tree_fruit', 'default:mese_crystal_fragment')

register_craft_3x1('everness:lotus_leaf_3', 'default:paper')

register_craft_single('everness:mineral_sandstone', 'everness:mineral_sand 4')

register_craft_3x2_composite('everness:mineral_sandstone', 'everness:mineral_sandstone_brick', 'everness:mineral_sandstone_brick_block 6')

register_craft_sandwich_pattern('group:flora', 'everness:mineral_stone_brick', 'everness:mineral_stone_brick_with_growth 3')
register_craft_sandwich_pattern('everness:mineral_stone_brick_with_growth', 'group:flower', 'everness:mineral_stone_brick_with_flower_growth 6')

register_craft_3x2('everness:mineral_sandstone', 'everness:sand_castle_wall 6')

core.register_craft({
    output = 'everness:ceramic_pot_blank',
    recipe = {
        { '', 'everness:ceramic_pot_sherd_blank', ''},
        { 'everness:ceramic_pot_sherd_blank', '', 'everness:ceramic_pot_sherd_blank'},
        { '', 'everness:ceramic_pot_sherd_blank', ''},
    }
})

register_craft_single('everness:ceramic_pot_blank', 'everness:ceramic_pot_sherd_blank 4')

--
-- Tools
--
local recipes_tool = {
    {'everness:hammer', {
        { 'group:everness_obsidian', 'group:everness_obsidian', 'group:everness_obsidian' },
        { 'group:everness_obsidian', 'everness:pyriteblock_forged', 'group:everness_obsidian' },
        { '', 'group:stick', '' }
    }},
    {'everness:hammer_sharp', {
        { 'everness:pyriteblock_forged', 'everness:pyriteblock_forged', 'everness:pyriteblock_forged' },
        { 'everness:pyriteblock_forged', 'everness:hammer', 'everness:pyriteblock_forged' },
        { '', 'everness:hammer', '' }
    }},
    {'everness:pick_archeological', {
        { 'group:stone', 'group:stone', 'group:stone' },
        { '', 'group:stick', '' },
        { 'group:stick', '', '' }
    }},
    {'everness:pick_illuminating', {
        { 'everness:crystal_purple', 'everness:coral_tree_bioluminescent', 'everness:crystal_purple' },
        { '', 'everness:sulfur_stone', '' },
        { '', 'group:stick', '' }
    }},
    {'everness:shovel_silk', {
        { 'everness:ancient_emerald_ice' },
        { 'everness:glowing_pillar' },
        { 'everness:crystal_purple' }
    }},
    {'everness:vine_shears', {
        { '', 'everness:pyrite_ingot', '' },
        { 'group:stick', 'group:wood', 'everness:pyrite_ingot' },
        { '', '', 'group:stick' }
    }},
}

for _, data in ipairs(recipes_tool) do
    core.register_craft({
        type = 'shaped',
        output = data[1],
        recipe = data[2]
    })
end

--
-- Fuel
--
local recipes_fuel = {
    {'everness:baobab_wood', 8},
    {'everness:bamboo_block', 15},
    {'everness:bamboo_dry_block', 15},
    {'everness:bamboo_item', 3},
    {'everness:bamboo_mosaic_wood', 15},
    {'everness:bamboo_wood', 15},
    {'everness:coral_burdock_1', 3},
    {'everness:coral_burdock_2', 3},
    {'everness:crystal_wood', 15},
    {'everness:door_bamboo', 14},
    {'everness:lava_tree_wood', 30},
    {'everness:lotus_leaf_3', 1},
    {'everness:mese_wood', 15},
    {'everness:sequoia_wood', 6},
    {'everness:sulfur_stone', 370},
    {'everness:trapdoor_bamboo', 7},
    {'everness:trapdoor_crystal_wood', 7},
}

for _, data in ipairs(recipes_fuel) do
    core.register_craft({
        type = 'fuel',
        recipe = data[1],
        burntime = data[2],
    })
end

--
-- Cooking recipes
--
local recipes_cooking = {
    {'everness:coral_desert_cobble', 'everness:coral_desert_stone'},
    {'everness:coral_desert_mossy_cobble', 'everness:coral_desert_stone'},
    {'everness:crystal_cobble', 'everness:crystal_stone'},
    {'everness:crystal_mossy_cobble', 'everness:crystal_stone'},
    {'everness:forsaken_desert_cobble_red', 'everness:forsaken_desert_stone'},
    {'everness:forsaken_tundra_cobble', 'everness:forsaken_tundra_stone'},
    {'everness:mineral_cave_cobblestone', 'everness:mineral_cave_stone'},
    {'everness:mineral_lava_stone_dry', 'everness:mineral_lava_stone'},
    {'everness:mineral_stone_cobble', 'everness:mineral_stone'},
    --
    {'everness:bamboo_block', 'everness:bamboo_dry_block'},
    {'everness:baobab_fruit', 'everness:baobab_fruit_roasted'},
    {'everness:cursed_stone', 'everness:cursed_stone_carved'},
    {'everness:lotus_leaf', 'everness:lotus_leaf_3'},
    {'everness:lotus_leaf_2', 'everness:lotus_leaf_3'},
    {'everness:pyriteblock', 'everness:pyriteblock_forged'},
    {'group:everness_sand', 'everness:glass'},
}

for _, data in ipairs(recipes_cooking) do
    core.register_craft({
        type = 'cooking',
        output = data[2],
        recipe = data[1],
    })
end

--
-- Saplings
--
register_craft_1x2_composite('group:lantern', 'everness:coral_tree_sapling', 'everness:coral_tree_bioluminescent_sapling')
register_craft_1x2_composite('group:lantern', 'everness:dry_tree_sapling', 'everness:cursed_dream_tree_sapling')

register_craft_2x2('everness:crystal_tree_sapling', 'everness:crystal_tree_large_sapling')
