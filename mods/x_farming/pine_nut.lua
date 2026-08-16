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

-- Minetest Game compatibility
if core.get_modpath("default") then
    -- Aliases
    core.register_alias("x_farming:pine_nut_tree","default:pine_tree")
    core.register_alias("x_farming:pine_nut_leaves","default:pine_needles")
    core.register_alias("x_farming:pine_nut_sapling","default:pine_sapling")
    core.register_alias("x_farming:pine_nut_wood","default:pine_wood")
    core.register_alias("stairs:stair_pine_nut_wood","stairs:stair_pine_wood")
    core.register_alias("stairs:stair_inner_pine_nut_wood","stairs:stair_inner_pine_wood")
    core.register_alias("stairs:stair_outer_pine_nut_wood","stairs:stair_outer_pine_wood")
    core.register_alias("stairs:slab_pine_nut_wood","slab:stair_pine_wood")
else
    -- trunk
    core.register_node('x_farming:pine_nut_tree', {
        description = S('Pine Nut Tree'),
        short_description = S('Pine Nut Tree'),
        tiles = { 'x_farming_pine_nut_tree_top.png', 'x_farming_pine_nut_tree_top.png', 'x_farming_pine_nut_tree.png' },
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
    core.register_node('x_farming:pine_nut_leaves', {
        description = S('Pine Nut Needles') .. '\n' .. S('Compost chance') .. ': 30%',
        short_description = S('Pine Nut Needles'),
        drawtype = 'allfaces_optional',
        waving = 1,
        tiles = { 'x_farming_pine_nut_leaves.png' },
        special_tiles = { 'x_farming_pine_nut_leaves.png' },
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
                    items = { 'x_farming:pine_nut_sapling' },
                    rarity = 20,
                },
                {
                    -- player will get leaves only if he get no saplings,
                    -- this is because max_items is 1
                    items = { 'x_farming:pine_nut_leaves' },
                }
            }
        },
        sounds = x_farming.node_sound_leaves_defaults(),
        after_place_node = x_farming.after_place_leaves,
    })

    -- sapling
    core.register_node('x_farming:pine_nut_sapling', {
        description = S('Pine Nut Sapling') .. '\n' .. S('Compost chance') .. ': 30%',
        short_description = S('Pine Nut Sapling'),
        drawtype = 'plantlike',
        tiles = { 'x_farming_pine_nut_sapling.png' },
        inventory_image = 'x_farming_pine_nut_sapling.png',
        wield_image = 'x_farming_pine_nut_sapling.png',
        paramtype = 'light',
        sunlight_propagates = true,
        walkable = false,
        on_timer = x_farming.grow_pine_nut_tree,
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
                'x_farming:pine_nut_sapling',
                -- minp, maxp to be checked, relative to sapling pos
                -- minp_relative.y = 1 because sapling pos has been checked
                { x = -2, y = 1, z = -2 },
                { x = 2, y = 8, z = 2 },
                -- maximum interval of interior volume check
                4)

            return itemstack
        end,
    })

    if core.global_exists('stairs') and core.get_modpath('stairs') then
        stairs.register_stair_and_slab(
            'pine_nut_wood',
            'x_farming:pine_nut_wood',
            { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
            { 'x_farming_pine_nut_wood.png' },
            S('Pine Nut Wooden Stair'),
            S('Pine Nut Wooden Slab'),
            x_farming.node_sound_wood_defaults(),
            false
        )
    end
    
    if core.get_modpath('mcl_stairs') then
        mcl_stairs.register_stair_and_slab(
            'pine_nut_wood',
            'x_farming:pine_nut_wood',
            { handy = 1, axey = 1, building_block = 1, material_wood = 1, fire_encouragement = 5, fire_flammability = 20, flammable = 3, wood = 1, },
            { 'x_farming_pine_nut_wood.png' },
            S('Pine Nut Wooden Stair'),
            S('Pine Nut Wooden Slab'),
            x_farming.node_sound_wood_defaults(),
            6,
            2,
            S('Double Pine Nut Wooden Slab'),
            nil
        )
    end

    -- planks
    core.register_node('x_farming:pine_nut_wood', {
        description = S('Pine Nut Wood Planks'),
        short_description = S('Pine Nut Wood Planks'),
        paramtype2 = 'facedir',
        place_param2 = 0,
        tiles = { 'x_farming_pine_nut_wood.png' },
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
end

-- Ethereal compatibility
if core.get_modpath("ethereal") then
    core.override_item("default:pine_needles",{
        drop = {
            max_items = 1,
            items = {
                {items = {"default:pine_sapling"}, rarity = 20},
                {items = {"default:pine_needles"}}
            }
        },
    })
    core.register_alias_force("ethereal:pine_nuts","x_farming:pine_nut")
end

-- fruit
local pine_nut_def = {
    description = S('Pine Nut') .. '\n' .. S('Compost chance') .. ': 65%',
    short_description = S('Pine Nut'),
    drawtype = 'plantlike',
    tiles = { 'x_farming_pine_nut.png' },
    inventory_image = 'x_farming_pine_nut_item.png',
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    is_ground_content = false,
    selection_box = {
        type = 'fixed',
        fixed = {
            -4 / 16,
            -5 / 16,
            -4 / 16,
            4 / 16,
            7 / 16,
            4 / 16
        }
    },
    groups = {
        -- MTG
        fleshy = 3,
        dig_immediate = 3,
        leafdecay = 3,
        leafdecay_drop = 1,
        compost = 65,
        -- MCL
        handy = 1,
        shearsy = 1,
        non_mycelium_plant = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        compostability = 65,
        -- ALL
        flammable = 2,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),

    after_place_node = function(pos, placer, itemstack, pointed_thing)
        core.set_node(pos, { name = 'x_farming:pine_nut', param2 = 1 })
    end,

    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        if oldnode.param2 == 0 then
            core.set_node(pos, { name = 'x_farming:pine_nut_mark' })
            core.get_node_timer(pos):start(math.random(300, 1500))
        end
    end,
}

core.register_node('x_farming:pine_nut', pine_nut_def)

local pine_nut_roasted_def = {
    description = S('Pine Nut Roasted') .. '\n' .. S('Compost chance') .. ': 85%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 2'),
    short_description = S('Pine Nut Roasted'),
    inventory_image = 'x_farming_pine_nut_roasted.png',
    groups = {
        -- MTG
        fleshy = 3,
        dig_immediate = 3,
        compost = 85,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        non_mycelium_plant = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        compostability = 85,
        food = 2,
        eatable = 1,
        -- ALL
        flammable = 2,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
}

if core.get_modpath('farming') then
    pine_nut_roasted_def.on_use = core.item_eat(2)
end

if core.get_modpath('mcl_farming') then
    pine_nut_roasted_def.on_place = core.item_eat(2)
    pine_nut_roasted_def.on_secondary_use = core.item_eat(2)
end

core.register_craftitem('x_farming:pine_nut_roasted', pine_nut_roasted_def)

core.register_node('x_farming:pine_nut_mark', {
    description = S('Pine Nut Marker'),
    short_description = S('Pine Nut Marker'),
    inventory_image = 'x_farming:pine_nut.png^x_farming_invisible_node_overlay.png',
    wield_image = 'x_farming:pine_nut.png^x_farming_invisible_node_overlay.png',
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
        if not core.find_node_near(pos, 1, {'x_farming:pine_nut_leaves',"default:pine_needles"}) then
            core.remove_node(pos)
        elseif core.get_node_light(pos) < 11 then
            core.get_node_timer(pos):start(200)
        else
            core.set_node(pos, { name = 'x_farming:pine_nut' })
        end
    end
})

-- leafdecay
-- this doesnt do anything since christmas tree is loaded adterwards
-- and is overriding it due to the same trunk

-- x_farming.register_leafdecay({
--     trunks = { 'x_farming:pine_nut_tree' },
--     leaves = {
--         'x_farming:pine_nut',
--         'x_farming:pine_nut_leaves'
--     },
--     radius = 3,
-- })

---crate
x_farming.register_crate('crate_pine_nut_3', {
    description = S('Pine Nut Crate'),
    short_description = S('Pine Nut Crate'),
    tiles = { 'x_farming_crate_pine_nut_3.png' },
    _custom = {
        crate_item = 'x_farming:pine_nut'
    }
})

--[[core.register_decoration(asuna.features.crops.pine_nut.inject_decoration({
    deco_type = "schematic",
    sidelen = 16,
    noise_params = {
        offset = -0.010,
        scale = 0.005,
        spread = { x = 100, y = 100, z = 100 },
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    y_max = 31000,
    y_min = 4,
    schematic = core.get_modpath("x_farming") .. '/schematics/x_farming_pine_nut_tree.mts',
    flags = 'place_center_x, place_center_z'
}))]]

-- Mapgen
local c_pine_nut = core.get_content_id("x_farming:pine_nut")

local c_pine_tree = {}
for _,tree in ipairs({
    "default:pine_tree",
    "naturalbiomes:alppine1_trunk",
    "naturalbiomes:alppine2_trunk",
}) do
    c_pine_tree[core.get_content_id(tree)] = true
end

local c_pine_needles = {}
for _,needles in ipairs({
    "default:pine_needles",
    "naturalbiomes:alppine1_leaves",
    "naturalbiomes:alppine2_leaves",
}) do
    c_pine_needles[core.get_content_id(needles)] = true
end

abdecor.register_advanced_decoration("x_farming_pine_nut",{
    target = {
        place_on = {
            "default:dirt_with_coniferous_litter",
            "default:dirt_with_snow",
            "naturalbiomes:alpine_litter",
        },
        spawn_by = {
            "default:pine_tree",
            "naturalbiomes:alppine1_trunk",
            "naturalbiomes:alppine2_trunk",
        },
        num_spawn_by = 1,
        fill_ratio = 0.0275,
        biomes = asuna.features.crops.pine_nut,
        y_min = 5,
        y_max = 31000,
        sidelen = 80,
    },
    fn = function(mapgen)
        -- Get provided values
        local pos = mapgen.pos
        local va = mapgen.voxelarea
        local vdata = mapgen.data

        -- Get stride values and adjust position
        local ystride = va.ystride
        local zstride = va.zstride
        pos = va:index(pos.x,pos.y + 1,pos.z)

        -- Align pos with center of tree if possible
        local tpos
        for x = -1, 1, 1 do
            for z = -zstride, zstride, zstride do
                tpos = pos + x + z
                if c_pine_tree[vdata[tpos]] then
                    pos = tpos
                    break
                end
            end
        end

        -- Scan nodes for pine nut placement
        local pnpos
        local place = {}
        for x = -2, 2, 1 do
            for z = -2 * zstride, 2 * zstride, zstride do
                for y = 0, 11 * ystride, ystride do
                    pnpos = pos + x + z + y
                    if vdata[pnpos] == core.CONTENT_AIR and c_pine_needles[vdata[pnpos + ystride]] then
                        table.insert(place,pnpos)
                        y = y + ystride
                    end
                end
            end
        end

        -- Ensure that placement locations exist
        local p = #place
        if p == 0 then
            return
        end

        -- Place pine nuts at random placement locations
        local pcgr = PcgRandom(mapgen.seed)
        for i = 1, pcgr:next(1,math.ceil(p / 7)) do
            vdata[place[pcgr:next(1,p)]] = c_pine_nut
        end
    end,
})
