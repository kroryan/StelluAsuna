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
local minlight = 0
local maxlight = 14

-- OBSIDIAN WART
x_farming.register_plant('x_farming:obsidian_wart', {
    description = S('Obsidian Wart Seed') .. '\n' .. S('Plant on Obsidian') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Obsidian Wart Seed'),
    paramtype2 = 'meshoptions',
    inventory_image = 'x_farming_obsidian_wart_seed.png',
    steps = 6,
    minlight = minlight,
    maxlight = maxlight,
    fertility = { 'underground' },
    groups = { flammable = 4 },
    place_param2 = 3
})

-- needed
core.override_item('x_farming:obsidian_wart', {
    description = S('Obsidian Wart') .. '\n' .. S('Compost chance') .. ': 65%',
    short_description = S('Obsidian Wart'),
    groups = {
        -- X Farming
        compost = 65,
        -- MCL
        compostability = 65
    },
})

if core.get_modpath('default') then
    -- default obsidian
    core.override_item('default:obsidian', {
        groups = {
            -- MTG
            cracky = 1,
            level = 2,
            soil = 1,
            underground = 1
        },
        soil = {
            base = 'default:obsidian',
            dry = 'x_farming:obsidian_soil',
            wet = 'x_farming:obsidian_soil_wet'
        },
    })

    -- obsidian - soil
    core.register_node('x_farming:obsidian_soil', {
        description = S('Obsidian Soil'),
        short_description = S('Obsidian Soil'),
        drop = 'default:obsidian',
        tiles = { 'x_farming_obsidian_soil.png', 'default_obsidian.png' },
        groups = { cracky = 1, level = 2, soil = 2, underground = 1, field = 1, not_in_creative_inventory = 1 },
        sounds = x_farming.node_sound_stone_defaults(),
        soil = {
            base = 'default:obsidian',
            dry = 'x_farming:obsidian_soil',
            wet = 'x_farming:obsidian_soil_wet'
        }
    })

    -- obsidian - soil - wet
    core.register_node('x_farming:obsidian_soil_wet', {
        description = S('Wet Obsidian Soil'),
        short_description = S('Wet Obsidian Soil'),
        drop = 'default:obsidian',
        tiles = { 'x_farming_obsidian_soil_wet.png', 'default_obsidian.png^x_farming_soil_wet_side.png' },
        groups = { cracky = 1, level = 2, soil = 3, wet = 1, underground = 1, field = 1, not_in_creative_inventory = 1 },
        sounds = x_farming.node_sound_stone_defaults(),
        soil = {
            base = 'default:obsidian',
            dry = 'x_farming:obsidian_soil',
            wet = 'x_farming:obsidian_soil_wet'
        }
    })
elseif core.get_modpath('mcl_core') then
    -- mcl_core obsidian
    core.override_item('mcl_core:obsidian', {
        groups = {
            pickaxey = 5,
            building_block = 1,
            material_stone = 1,
            soil = 1,
            underground = 1,
        },
        soil = {
            base = 'default:obsidian',
            dry = 'x_farming:mcl_obsidian_soil',
            wet = 'x_farming:mcl_obsidian_soil_wet'
        },
        _mcl_blast_resistance = 1200,
        _mcl_hardness = 50,
    })

    -- mcl_core obsidian - soil
    core.register_node('x_farming:mcl_obsidian_soil', {
        description = S('Obsidian Soil'),
        short_description = S('Obsidian Soil'),
        drop = 'mcl_core:obsidian',
        tiles = { 'x_farming_obsidian_soil.png', 'default_obsidian.png' },
        groups = {
            pickaxey = 5,
            building_block = 1,
            material_stone = 1,
            soil = 2,
            field = 1,
            not_in_creative_inventory = 1,
            underground = 1
        },
        sounds = x_farming.node_sound_stone_defaults(),
        soil = {
            base = 'mcl_core:obsidian',
            dry = 'x_farming:mcl_obsidian_soil',
            wet = 'x_farming:mcl_obsidian_soil_wet'
        },
        _mcl_blast_resistance = 1200,
        _mcl_hardness = 50,
    })

    -- mcl_core obsidian - soil - wet
    core.register_node('x_farming:mcl_obsidian_soil_wet', {
        description = S('Wet Obsidian Soil'),
        short_description = S('Wet Obsidian Soil'),
        drop = 'mcl_core:obsidian',
        tiles = { 'x_farming_obsidian_soil_wet.png', 'default_obsidian.png^x_farming_soil_wet_side.png' },
        groups = {
            pickaxey = 5,
            building_block = 1,
            material_stone = 1,
            soil = 3,
            wet = 1,
            field = 1,
            not_in_creative_inventory = 1,
            underground = 1
        },
        sounds = x_farming.node_sound_stone_defaults(),
        soil = {
            base = 'mcl_core:obsidian',
            dry = 'x_farming:mcl_obsidian_soil',
            wet = 'x_farming:mcl_obsidian_soil_wet'
        },
        _mcl_blast_resistance = 1200,
        _mcl_hardness = 50,
    })
end

--
-- Nodes
--
core.register_node('x_farming:wart_block', {
    description = S('Wart Block') .. '\n' .. S('Compost chance') .. ': 85%',
    short_description = S('Wart Block'),
    tiles = { 'x_farming_wart_block.png' },
    groups = {
        -- MTG
        cracky = 3,
        compost = 85,
        -- MCL
        pickaxey = 1,
        sandstone = 1,
        normal_sandstone = 1,
        building_block = 1,
        material_stone = 1,
    },
    sounds = x_farming.node_sound_stone_defaults(),
    _mcl_blast_resistance = 0.8,
    _mcl_hardness = 0.8,
})

core.register_node('x_farming:wartrack', {
    description = S('Wartrack'),
    short_description = S('Wartrack'),
    tiles = { 'x_farming_wartrack.png' },
    groups = {
        -- MTG
        cracky = 3,
        -- MCL
        -- MCL
        pickaxey = 1,
        sandstone = 1,
        normal_sandstone = 1,
        building_block = 1,
        material_stone = 1,
        -- ALL
        stone = 1
    },
    sounds = x_farming.node_sound_stone_defaults(),
    _mcl_blast_resistance = 0.8,
    _mcl_hardness = 0.8,
})

core.register_node('x_farming:wart_brick_block', {
    description = S('Wart Brick Block'),
    short_description = S('Wart Brick Block'),
    tiles = { 'x_farming_wart_brick_block.png' },
    groups = {
        -- MTG
        cracky = 2,
        -- MCL
        -- MCL
        pickaxey = 1,
        sandstone = 1,
        normal_sandstone = 1,
        building_block = 1,
        material_stone = 1,
        -- ALL
        stone = 1
    },
    sounds = x_farming.node_sound_stone_defaults(),
    _mcl_blast_resistance = 0.8,
    _mcl_hardness = 0.8,
})

core.register_node('x_farming:wart_red_brick_block', {
    description = S('Wart Red Brick Block'),
    short_description = S('Wart Red Brick Block'),
    tiles = { 'x_farming_wart_red_brick_block.png' },
    groups = {
        -- MTG
        cracky = 2,
        -- MCL
        -- MCL
        pickaxey = 1,
        sandstone = 1,
        normal_sandstone = 1,
        building_block = 1,
        material_stone = 1,
        -- ALL
        stone = 1
    },
    sounds = x_farming.node_sound_stone_defaults(),
    _mcl_blast_resistance = 0.8,
    _mcl_hardness = 0.8,
})

--
-- Register Wart stairs and slabs
--
if core.get_modpath('stairs') then
    stairs.register_stair_and_slab(
        'wart_block',
        'x_farming:wart_block',
        { cracky = 3 },
        { 'x_farming_wart_block.png' },
        S('Wart Block Stair'),
        S('Wart Block Slab'),
        x_farming.node_sound_stone_defaults()
    )

    stairs.register_stair_and_slab(
        'wart_brick_block',
        'x_farming:wart_brick_block',
        { cracky = 2 },
        { 'x_farming_wart_brick_block.png' },
        S('Wart Brick Stair'),
        S('Wart Brick Slab'),
        x_farming.node_sound_stone_defaults()
    )

    stairs.register_stair_and_slab(
        'wart_red_brick_block',
        'x_farming:wart_red_brick_block',
        { cracky = 2 },
        { 'x_farming_wart_red_brick_block.png' },
        S('Wart Red Brick Stair'),
        S('Wart Red Brick Slab'),
        x_farming.node_sound_stone_defaults()
    )

    stairs.register_stair_and_slab(
        'wartrack',
        'x_farming:wartrack',
        { cracky = 3 },
        { 'x_farming_wartrack.png' },
        S('Wartrack Stair'),
        S('Wartrack Slab'),
        x_farming.node_sound_stone_defaults()
    )
end

if core.get_modpath('mcl_stairs') then
    mcl_stairs.register_stair_and_slab(
        'x_farming_wart_block',
        'x_farming:wart_block',
        {
            -- MCL
            pickaxey = 1,
            sandstone = 1,
            normal_sandstone = 1,
            building_block = 1,
            material_stone = 1,
        },
        { 'x_farming_wart_block.png' },
        S('Wart Block Stair'),
        S('Wart Block Slab'),
        x_farming.node_sound_stone_defaults(),
        6,
        2,
        S('Double Wart Block Slab'),
        nil
    )

    mcl_stairs.register_stair_and_slab(
        'x_farming_wart_brick_block',
        'x_farming:wart_brick_block',
        {
            -- MCL
            pickaxey = 1,
            sandstone = 1,
            normal_sandstone = 1,
            building_block = 1,
            material_stone = 1,
        },
        { 'x_farming_wart_brick_block.png' },
        S('Wart Brick Stair'),
        S('Wart Brick Slab'),
        x_farming.node_sound_stone_defaults(),
        6,
        2,
        S('Double Wart Brick Slab'),
        nil
    )

    mcl_stairs.register_stair_and_slab(
        'x_farming_wart_red_brick_block',
        'x_farming:wart_red_brick_block',
        {
            -- MCL
            pickaxey = 1,
            sandstone = 1,
            normal_sandstone = 1,
            building_block = 1,
            material_stone = 1,
        },
        { 'x_farming_wart_red_brick_block.png' },
        S('Wart Red Brick Stair'),
        S('Wart Red Brick Slab'),
        x_farming.node_sound_stone_defaults(),
        6,
        2,
        S('Double Wart Red Brick Slab'),
        nil
    )

    mcl_stairs.register_stair_and_slab(
        'x_farming_wartrack',
        'x_farming:wartrack',
        {
            -- MCL
            pickaxey = 1,
            sandstone = 1,
            normal_sandstone = 1,
            building_block = 1,
            material_stone = 1,
        },
        { 'x_farming_wartrack.png' },
        S('Wartrack Stair'),
        S('Wartrack Slab'),
        x_farming.node_sound_stone_defaults(),
        6,
        2,
        S('Double Wartrack Slab'),
        nil
    )
end

core.register_craftitem('x_farming:wart_brick', {
    description = S('Wart Brick'),
    inventory_image = 'x_farming_wart_brick.png',
    groups = { craftitem = 1 },
})

core.register_node('x_farming:obsidian_wart_decor', {
    description = S('Obsidian Wart'),
    short_description = S('Obsidian Wart'),
    drawtype = 'plantlike_rooted',
    paramtype = 'light',
    tiles = { 'default_obsidian.png' },
    special_tiles = { { name = 'x_farming_obsidian_wart_6.png', tileable_vertical = true } },
    inventory_image = 'x_farming_obsidian_wart_6.png',
    groups = {
        -- MTG
        snappy = 3,
        not_in_creative_inventory = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    light_source = 4,
    glow = 0,
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
            { -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
        },
    },
    node_dig_prediction = 'default:obsidian',
    node_placement_prediction = '',
    -- MCL
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_stone_defaults({
        dig = { name = 'default_dig_snappy', gain = 0.2 },
        dug = { name = 'default_grass_footstep', gain = 0.25 },
    }),
    drop = {
        items = {
            { items = { 'x_farming:obsidian_wart' }, rarity = 1 },
            { items = { 'x_farming:obsidian_wart' }, rarity = 2 },
            { items = { 'x_farming:seed_obsidian_wart' }, rarity = 1 },
            { items = { 'x_farming:seed_obsidian_wart' }, rarity = 2 }
        }
    },

    after_destruct = function(pos, oldnode)
        core.set_node(pos, { name = 'default:obsidian' })
    end,
})

---crate
x_farming.register_crate('crate_obsidian_wart_3', {
    description = S('Obsidian Wart Crate'),
    short_description = S('Obsidian Wart Crate'),
    tiles = { 'x_farming_crate_obsidian_wart_3.png' },
    _custom = {
        crate_item = 'x_farming:obsidian_wart'
    }
})

core.register_decoration({
    deco_type = "simple",
    place_on = {"default:obsidian"},
    biomes = {"fiery","fiery_below"},
    sidelen = 8,
    fill_ratio = 0.1,
    y_max = 31000,
    y_min = -31000,
    place_offset_y = -1,
    flags = "force_placement",
    decoration = "x_farming:obsidian_wart_decor",
})
