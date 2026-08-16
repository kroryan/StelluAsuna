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

-- Required wrapper to allow customization of x_farming.after_place_leaves
local function after_place_leaves(...)
    return x_farming.after_place_leaves(...)
end

-- trunk
core.register_node('x_farming:kiwi_tree', {
    description = S('Kiwi Tree'),
    short_description = S('Kiwi Tree'),
    tiles = { 'x_farming_kiwi_tree_top.png', 'x_farming_kiwi_tree_top.png', 'x_farming_kiwi_tree.png' },
    paramtype2 = 'facedir',
    is_ground_content = false,
    groups = {
        -- MTG
        choppy = 2,
        oddly_breakable_by_hand = 1,
        -- MCL
        handy = 1,
        axey = 1,
        building_block = 1,
        material_wood = 1,
        fire_encouragement = 5,
        fire_flammability = 5,
        -- ALL
        tree = 1,
        flammable = 2,
    },
    _mcl_blast_resistance = 2,
    _mcl_hardness = 2,
    sounds = x_farming.node_sound_wood_defaults(),
    on_place = core.rotate_node
})

-- leaves
core.register_node('x_farming:kiwi_leaves', {
    description = S('Kiwi Tree Leaves') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Kiwi Tree Leaves'),
    drawtype = 'allfaces_optional',
    waving = 1,
    tiles = { 'x_farming_kiwi_leaves.png' },
    special_tiles = { 'x_farming_kiwi_leaves.png' },
    paramtype = 'light',
    is_ground_content = false,
    groups = {
        -- MTG
        snappy = 3,
        leafdecay = 3,
        -- MCL
        handy = 1,
        hoey = 1,
        shearsy = 1,
        swordy = 1,
        dig_by_piston = 1,
        fire_encouragement = 30,
        fire_flammability = 60,
        deco_block = 1,
        compostability = 30,
        -- ALL
        flammable = 2,
        leaves = 1,
    },
    _mcl_shears_drop = true,
    _mcl_blast_resistance = 0.2,
    _mcl_hardness = 0.2,
    _mcl_silk_touch_drop = true,
    drop = {
        max_items = 1,
        items = {
            {
                -- player will get sapling with 1/20 chance
                items = { 'x_farming:kiwi_sapling' },
                rarity = 20,
            },
            {
                -- player will get leaves only if he get no saplings,
                -- this is because max_items is 1
                items = { 'x_farming:kiwi_leaves' },
            }
        }
    },
    sounds = x_farming.node_sound_leaves_defaults(),

    after_place_node = after_place_leaves,
})

-- sapling
core.register_node('x_farming:kiwi_sapling', {
    description = S('Kiwi Tree Sapling') .. '\n' .. S('Compost chance') .. ': 30%',
    short_description = S('Kiwi Tree Sapling'),
    drawtype = 'plantlike',
    tiles = { 'x_farming_kiwi_sapling.png' },
    inventory_image = 'x_farming_kiwi_sapling.png',
    wield_image = 'x_farming_kiwi_sapling.png',
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    on_timer = x_farming.grow_sapling,
    selection_box = {
        type = 'fixed',
        fixed = { -4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16 }
    },
    groups = {
        -- MTG
        snappy = 2,
        flammable = 2,
        -- MCL
        plant = 1,
        non_mycelium_plant = 1,
        deco_block = 1,
        dig_by_water = 1,
        dig_by_piston = 1,
        destroy_by_lava_flow = 1,
        compostability = 30,
        -- ALL
        dig_immediate = 3,
        attached_node = 1,
        sapling = 1,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),

    on_construct = function(pos)
        core.get_node_timer(pos):start(math.random(300, 1500))
    end,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = x_farming.sapling_on_place(itemstack, placer, pointed_thing,
            'x_farming:kiwi_sapling',
            -- minp, maxp to be checked, relative to sapling pos
            -- minp_relative.y = 1 because sapling pos has been checked
            { x = -2, y = 1, z = -2 },
            { x = 2, y = 4, z = 2 },
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})

-- fruit - for marker only
core.register_node('x_farming:kiwi', {
    description = S('Kiwi'),
    short_description = S('Kiwi'),
    drawtype = 'plantlike',
    visual_scale = 0.5,
    tiles = { 'x_farming_kiwi.png' },
    inventory_image = 'x_farming_kiwi.png',
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    is_ground_content = false,
    drop = {
        max_items = 1, -- Maximum number of items to drop.
        items = { -- Choose max_items randomly from this list.
            {
                items = { 'x_farming:kiwi_fruit' }, -- Items to drop.
                rarity = 1, -- Probability of dropping is 1 / rarity.
            }
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = { -3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16 }
    },
    groups = {
        -- MTG
        fleshy = 3,
        dig_immediate = 3,
        leafdecay = 3,
        leafdecay_drop = 1,
        not_in_creative_inventory = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        non_mycelium_plant = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        compostability = 30,
        -- ALL
        flammable = 2,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),

    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        if oldnode.param2 == 0 then
            core.set_node(pos, { name = 'x_farming:kiwi_mark' })
            core.get_node_timer(pos):start(math.random(300, 1500))
        end
    end,
})

core.register_node('x_farming:kiwi_mark', {
    description = S('Kiwi Marker'),
    short_description = S('Kiwi Marker'),
    inventory_image = 'x_farming:kiwi_fruit.png^x_farming_invisible_node_overlay.png',
    wield_image = 'x_farming:kiwi_fruit.png^x_farming_invisible_node_overlay.png',
    drawtype = 'airlike',
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    drop = '',
    groups = { not_in_creative_inventory = 1 },
    on_timer = function(pos, elapsed)
        if not core.find_node_near(pos, 1, 'x_farming:kiwi_leaves') then
            core.remove_node(pos)
        elseif core.get_node_light(pos) < 11 then
            core.get_node_timer(pos):start(200)
        else
            core.set_node(pos, { name = 'x_farming:kiwi' })
        end
    end
})

-- Kiwi eatable fruit
local kiwi_fruit_def = {
    description = S('Kiwi') .. '\n' .. S('Compost chance') .. ': 65%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 2'),
    short_description = S('Kiwi'),
    drawtype = 'mesh',
    mesh = 'x_farming_kiwi_fruit.obj',
    tiles = { 'x_farming_kiwi_fruit_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_kiwi_fruit.png',
    wield_image = 'x_farming_kiwi_fruit.png',
    paramtype = 'light',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.2, -0.5, -0.2, 0.2, -0.2, 0.2 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.1, -0.5, -0.1, 0.1, -0.3, 0.1 }
    },
    groups = {
        -- MTG
        dig_immediate = 3,
        compost = 65,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        non_mycelium_plant = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        compostability = 65,
        food = 2,
        eatable = 1,
        -- ALL
        flammable = 2,
        attached_node = 1,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    on_use = core.item_eat(2),
    sunlight_propagates = true
}

if core.get_modpath('mcl_farming') then
    kiwi_fruit_def.on_secondary_use = core.item_eat(2)
end

core.register_node('x_farming:kiwi_fruit', kiwi_fruit_def)

-- leafdecay
x_farming.register_leafdecay({
    trunks = { 'x_farming:kiwi_tree' },
    leaves = { 'x_farming:kiwi', 'x_farming:kiwi_leaves' },
    radius = 3,
})

-- planks
core.register_node('x_farming:kiwi_wood', {
    description = S('Kiwi Wood Planks'),
    short_description = S('Kiwi Wood Planks'),
    paramtype2 = 'facedir',
    place_param2 = 0,
    tiles = { 'x_farming_kiwi_wood.png' },
    is_ground_content = false,
    groups = {
        -- MTG
        choppy = 2,
        oddly_breakable_by_hand = 2,
        -- Everness
        everness_wood = 1,
        -- MCL
        handy = 1,
        axey = 1,
        building_block = 1,
        material_wood = 1,
        fire_encouragement = 5,
        fire_flammability = 20,
        -- ALL
        flammable = 3,
        wood = 1,
    },
    _mcl_blast_resistance = 3,
    _mcl_hardness = 2,
    sounds = x_farming.node_sound_wood_defaults(),
})

-- Stairs
if core.global_exists('stairs') and core.get_modpath('stairs') then
    stairs.register_stair_and_slab(
        'kiwi_wood',
        'x_farming:kiwi_wood',
        { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
        { 'x_farming_kiwi_wood.png' },
        S('Kiwi Wooden Stair'),
        S('Kiwi Wooden Slab'),
        x_farming.node_sound_wood_defaults(),
        false
    )
end

if core.get_modpath('mcl_stairs') then
    mcl_stairs.register_stair_and_slab(
        'kiwi_wood',
        'x_farming:kiwi_wood',
        { handy = 1, axey = 1, building_block = 1, material_wood = 1, fire_encouragement = 5, fire_flammability = 20, flammable = 3, wood = 1, },
        { 'x_farming_kiwi_wood.png' },
        S('Kiwi Wooden Stair'),
        S('Kiwi Wooden Slab'),
        x_farming.node_sound_wood_defaults(),
        6,
        2,
        S('Double Kiwi Wooden Slab'),
        nil
    )
end

-- Crate
x_farming.register_crate('crate_kiwi_fruit_3', {
    description = S('Kiwi Fruit Crate'),
    short_description = S('Kiwi Fruit Crate'),
    tiles = { 'x_farming_crate_kiwi_fruit_3.png' },
    _custom = {
        crate_item = 'x_farming:kiwi_fruit'
    }
})

core.register_decoration(asuna.features.crops.kiwi.inject_decoration({
    deco_type = "schematic",
    sidelen = 16,
    noise_params = {
        offset = -0.0005,
        scale = 0.001,
        spread = { x = 80, y = 80, z = 80 },
        seed = 2,
        octaves = 1,
        persist = 0.66
    },
    y_max = 31000,
    y_min = 5,
    schematic = core.get_modpath("x_farming") .. '/schematics/x_farming_kiwi_tree.mts',
    flags = 'place_center_x, place_center_z',
    rotation = 'random',
}))
