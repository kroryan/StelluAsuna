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

-- Donuts
local donut_def = {
    description = S('Donut') .. '\n' .. S('Compost chance') .. ': 85%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 3'),
    short_description = S('Donut'),
    drawtype = 'mesh',
    mesh = 'x_farming_donut.obj',
    tiles = { 'x_farming_donut_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_donut.png',
    wield_image = 'x_farming_donut.png',
    paramtype = 'light',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.25, 0.25, -0.35, 0.25 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.25, 0.25, -0.35, 0.25 }
    },
    groups = {
        -- MTG
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
        attached_node = 1,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    on_use = core.item_eat(3),
    sunlight_propagates = true
}

if core.get_modpath('mcl_farming') then
    donut_def.on_secondary_use = core.item_eat(3)
end

core.register_node('x_farming:donut', donut_def)

local donut_chocolate_def = {
    description = S('Chocolate Donut') .. '\n' .. S('Compost chance') .. ': 85%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 4'),
    short_description = S('Chocolate Donut'),
    drawtype = 'mesh',
    mesh = 'x_farming_donut.obj',
    tiles = { 'x_farming_donut_chocolate_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_donut_chocolate.png',
    wield_image = 'x_farming_donut_chocolate.png',
    paramtype = 'light',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.25, 0.25, -0.35, 0.25 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.25, 0.25, -0.35, 0.25 }
    },
    groups = {
        -- MTG
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
        attached_node = 1,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    on_use = core.item_eat(4),
    sunlight_propagates = true
}

if core.get_modpath('mcl_farming') then
    donut_chocolate_def.on_secondary_use = core.item_eat(4)
end

core.register_node('x_farming:donut_chocolate', donut_chocolate_def)

-- Fries
local fries_def = {
    description = S('Fries') .. '\n' .. S('Compost chance') .. ': 85%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 6'),
    short_description = S('Fries'),
    drawtype = 'mesh',
    mesh = 'x_farming_fries.obj',
    tiles = { 'x_farming_fries_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_fries.png',
    wield_image = 'x_farming_fries.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.1, 0.25, 0.05, 0.1 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.1, 0.25, -0.2, 0.1 }
    },
    groups = {
        -- MTG
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
        attached_node = 1,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    on_use = core.item_eat(6),
    sunlight_propagates = true
}

if core.get_modpath('mcl_farming') then
    fries_def.on_secondary_use = core.item_eat(6)
end

core.register_node('x_farming:fries', fries_def)

-- Pumpkin pie
local pumpkin_pie_def = {
    description = S('Pumpkin Pie') .. '\n' .. S('Compost chance') .. ': 100%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 6'),
    short_description = S('Pumpkin Pie'),
    drawtype = 'mesh',
    mesh = 'x_farming_pumpkin_pie.obj',
    tiles = { 'x_farming_pumpkin_pie_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_pumpkin_pie.png',
    wield_image = 'x_farming_pumpkin_pie.png^[transformFXFYR180',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.3, -0.5, -0.3, 0.3, -0.2, 0.3 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.3, -0.5, -0.3, 0.3, -0.3, 0.3 }
    },
    groups = {
        -- MTG
        dig_immediate = 3,
        compost = 100,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        non_mycelium_plant = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        compostability = 100,
        food = 2,
        eatable = 1,
        -- ALL
        flammable = 2,
        attached_node = 1,
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    on_use = core.item_eat(6),
    sunlight_propagates = true
}

if core.get_modpath('mcl_farming') then
    pumpkin_pie_def.on_secondary_use = core.item_eat(6)
end

core.register_node('x_farming:pumpkin_pie', pumpkin_pie_def)

-- Beetroot soup
local beetroot_soup_def = {
    description = S('Beetroot Soup') .. '\n' .. S('Compost chance') .. ': 100%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 6'),
    short_description = S('Beetroot Soup'),
    drawtype = 'mesh',
    mesh = 'x_farming_beetroot_soup.obj',
    tiles = { 'x_farming_beetroot_soup_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_beetroot_soup.png',
    wield_image = 'x_farming_beetroot_soup.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        -- MTG
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        -- X Farming
        compost = 100,
        -- MCL
        food = 3,
        eatable = 6,
        compostability = 100,
        handy = 1,
        deco_block = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
    },
    sounds = x_farming.node_sound_wood_defaults(),
    sunlight_propagates = true,
    on_use = core.item_eat(6, 'x_farming:bowl'),
    -- MCL
    _mcl_saturation = 0.6,
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
}

if core.get_modpath('mcl_farming') then
    beetroot_soup_def.on_secondary_use = core.item_eat(6, 'x_farming:bowl')
end

core.register_node('x_farming:beetroot_soup', beetroot_soup_def)

-- Fish Stew
local fish_stew_def = {
    description = S('Fish Stew') .. '\n' .. S('Compost chance') .. ': 100%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 8'),
    short_description = S('Fish Stew'),
    drawtype = 'mesh',
    mesh = 'x_farming_fish_stew.obj',
    tiles = { 'x_farming_fish_stew_mesh.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_fish_stew.png',
    wield_image = 'x_farming_fish_stew.png',
    paramtype = 'light',
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.1, 0.5 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.1, 0.5 }
    },
    groups = {
        -- MTG
        vessel = 1,
        dig_immediate = 3,
        attached_node = 1,
        -- X Farming
        compost = 100,
        -- MCL
        food = 3,
        eatable = 6,
        compostability = 100,
        handy = 1,
        deco_block = 1,
        fire_encouragement = 60,
        fire_flammability = 100,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
    },
    -- MCL
    _mcl_saturation = 0.6,
    on_use = core.item_eat(8, 'x_farming:bowl'),
    sounds = x_farming.node_sound_wood_defaults(),
    sunlight_propagates = true
}

if core.get_modpath('mcl_farming') then
    fish_stew_def.on_secondary_use = core.item_eat(8, 'x_farming:bowl')
end

core.register_node('x_farming:fish_stew', fish_stew_def)

-- Cactus brick
core.register_node('x_farming:cactus_brick', {
    description = S('Cactus Brick'),
    short_description = S('Cactus Brick'),
    paramtype2 = 'facedir',
    place_param2 = 0,
    tiles = {
        'x_farming_cactus_brick.png^[transformFX',
        'x_farming_cactus_brick.png',
    },
    is_ground_content = false,
    groups = {
        -- MTG
        cracky = 2,
        -- MCL
        pickaxey = 1,
        stonebrick = 1,
        building_block = 1
    },
    _mcl_blast_resistance = 6,
    _mcl_hardness = 3,
    sounds = x_farming.node_sound_stone_defaults()
})

if core.global_exists('stairs') and core.get_modpath('stairs') then
    stairs.register_stair_and_slab(
        'cactus_brick',
        'x_farming:cactus_brick',
        { cracky = 3 },
        { 'x_farming_cactus_brick.png' },
        S('Cactus Brick Stair'),
        S('Cactus Brick Slab'),
        x_farming.node_sound_stone_defaults(),
        false
    )
end

if core.get_modpath('mcl_stairs') then
    mcl_stairs.register_stair_and_slab(
        'cactus_brick',
        'x_farming:cactus_brick',
        { pickaxey = 1 },
        { 'x_farming_cactus_brick.png' },
        S('Cactus Brick Stair'),
        S('Cactus Brick Slab'),
        x_farming.node_sound_stone_defaults(),
        6,
        2,
        S('Double Cactus Brick Slab'),
        nil
    )
end

local function tick_scarecrow(pos)
    -- core.get_node_timer(pos):start(math.random(1, 2))
    core.get_node_timer(pos):start(math.random(83, 143))
end

-- Scarecrow
core.register_node('x_farming:scarecrow', {
    description = S('Scarecrow'),
    short_description = S('Scarecrow'),
    drawtype = 'mesh',
    mesh = 'x_farming_scarecrow.obj',
    tiles = { 'x_farming_scarecrow_1.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_scarecrow_1_item.png',
    wield_image = 'x_farming_scarecrow_1_item.png',
    paramtype = 'light',
    sunlight_propagates = true,
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    selection_box = {
        type = 'fixed',
        fixed = { -0.4, -0.5, -0.4, 0.4, 1.5, 0.4 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.4, -0.5, -0.4, 0.4, 1.5, 0.4 }
    },
    groups = {
        -- MTG
        choppy = 1,
        oddly_breakable_by_hand = 1,
        flammable = 2,
        -- MCL
        handy = 1,
        axey = 1,
    },
    _mcl_blast_resistance = 1,
    _mcl_hardness = 1,
    sounds = x_farming.node_sound_wood_defaults(),
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_string('x_farming_scarecrow_state', 'inactive')
        meta:set_string('infotext', 'Scarecrow - Activate with bonemeal.')
        meta:set_string('owner', '')
    end,
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        if not placer then
            return
        end

        local meta = core.get_meta(pos)

        meta:set_string('owner', placer:get_player_name() or '')
        meta:set_string('infotext', S('Scarecrow (owned by @1) - Activate with bonemeal.', meta:get_string('owner')))
    end,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local player_name = clicker:get_player_name()

        if core.is_protected(pos, player_name)
            and not core.check_player_privs(player_name, 'protection_bypass')
        then
            core.record_protection_violation(pos, player_name)
            return itemstack
        end

        if itemstack:get_name() ~= 'x_farming:bonemeal' then
            return itemstack
        end

        local meta = core.get_meta(pos)
        local state = meta:get_string('x_farming_scarecrow_state')

        if state == 'inactive' then
            meta:set_string('x_farming_scarecrow_state', 'active')
            meta:set_string('infotext', S('Scarecrow (owned by @1) - Active', meta:get_string('owner')))
            core.swap_node(pos, { name = 'x_farming:scarecrow_2', param2 = node.param2 })
            meta:set_int('x_farming_scarecrow_fails', 0)
            tick_scarecrow(pos)
            itemstack:take_item()
        end

        return itemstack
    end,
})

core.register_node('x_farming:scarecrow_2', {
    description = S('Scarecrow 2'),
    short_description = S('Scarecrow 2'),
    drawtype = 'mesh',
    mesh = 'x_farming_scarecrow_2.obj',
    tiles = { 'x_farming_scarecrow_2.png' },
    use_texture_alpha = 'clip',
    inventory_image = 'x_farming_scarecrow_1_item.png',
    wield_image = 'x_farming_scarecrow_1_item.png',
    paramtype = 'light',
    sunlight_propagates = true,
    paramtype2 = 'facedir',
    is_ground_content = false,
    walkable = true,
    drop = 'x_farming:scarecrow',
    selection_box = {
        type = 'fixed',
        fixed = { -0.4, -0.5, -0.4, 0.4, 1.5, 0.4 }
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.4, -0.5, -0.4, 0.4, 1.5, 0.4 }
    },
    groups = {
        -- MTG
        choppy = 1,
        oddly_breakable_by_hand = 1,
        flammable = 2,
        not_in_creative_inventory = 1,
        -- MCL
        handy = 1,
        axey = 1,
    },
    _mcl_blast_resistance = 1,
    _mcl_hardness = 1,
    sounds = x_farming.node_sound_wood_defaults(),
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_string('x_farming_scarecrow_state', 'active')
    end,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local player_name = clicker:get_player_name()

        if core.is_protected(pos, player_name)
            and not core.check_player_privs(player_name, 'protection_bypass')
        then
            core.record_protection_violation(pos, player_name)
            return itemstack
        end

        local meta = core.get_meta(pos)
        local state = meta:get_string('x_farming_scarecrow_state')

        if state == 'active' then
            meta:set_string('x_farming_scarecrow_state', 'inactive')
            meta:set_string('infotext', S('Scarecrow (owned by @1) - Activate with bonemeal.', meta:get_string('owner')))
            core.swap_node(pos, { name = 'x_farming:scarecrow', param2 = node.param2 })
        end

        return itemstack
    end,
    on_timer = function(pos, elapsed)
        local meta = core.get_meta(pos)
        local state = meta:get_string('x_farming_scarecrow_state')
        local fails = meta:get_int('x_farming_scarecrow_fails')
        local player_name = meta:get_string('owner')
        local player = core.get_player_by_name(player_name)
        local node = core.get_node(pos)

        if not player then
            return true
        end

        if core.is_protected(pos, player_name)
            and not core.check_player_privs(player_name, 'protection_bypass')
        then
            return true
        end

        if state ~= 'active' then
            return false
        end

        -- bonemeal it
        local positions_raw = core.find_nodes_in_area(
            vector.subtract(vector.new(pos), 5),
            vector.add(vector.new(pos), 5),
            {
                'group:sand',
                'group:soil',
                'group:seed',
                'group:plant'
            }
        )

        local positions = {}

        for _, p in ipairs(positions_raw) do
            local n = core.get_node(p)
            if core.get_item_group(n.name, 'field') == 0 then
                local n_above = core.get_node(vector.new(p.x, p.y + 1, p.z))

                if core.get_item_group(n.name, 'seed') > 0 or core.get_item_group(n.name, 'plant') > 0 then
                    local ndef = core.registered_nodes[n.name]

                    if ndef.next_plant
                        and ndef.next_plant ~= 'x_farming:pumpkin_fruit'
                        and ndef.next_plant ~= 'x_farming:melon_fruit'
                    then
                        table.insert(positions, p)
                    end
                elseif n_above.name == 'air' then
                    table.insert(positions, p)
                end
            end
        end

        if #positions == 0 then
            meta:set_string('x_farming_scarecrow_state', 'inactive')
            meta:set_string('infotext', S('Scarecrow (owned by @1) - Activate with bonemeal.', meta:get_string('owner')))
            core.swap_node(pos, { name = 'x_farming:scarecrow', param2 = node.param2 })

            return false
        end

        local pos_rand = positions[math.random(1, #positions)]

        local pointed_thing = {
            type = 'node',
            under = pos_rand,
            above = vector.new(pos_rand.x, pos_rand.y + 1, pos_rand.z),
        }

        local result = x_farming.x_bonemeal:on_use(ItemStack({ name = 'x_farming:bonemeal' }), player, pointed_thing)

        if not result.success then
            fails = fails + 1
            meta:set_int('x_farming_scarecrow_fails', fails)
        end

        if fails < 7 then
            tick_scarecrow(pos)
        else
            meta:set_string('x_farming_scarecrow_state', 'inactive')
            meta:set_string('infotext', S('Scarecrow (owned by @1) - Activate with bonemeal.', meta:get_string('owner')))
            core.swap_node(pos, { name = 'x_farming:scarecrow', param2 = node.param2 })

            return false
        end
    end,
})

-- Honey
core.register_node('x_farming:honey_block', {
    description = S('Honey Block'),
    short_description = S('Honey Block'),
    drawtype = 'mesh',
    mesh = 'x_farming_honey.obj',
    tiles = { 'x_farming_honey_block_mesh.png' },
    use_texture_alpha = 'blend',
    paramtype = 'light',
    sunlight_propagates = true,
    wield_image = 'x_farming_honey_block_item.png',
    inventory_image = '[inventorycube{x_farming_honey_block_item.png{x_farming_honey_block_item.png{x_farming_honey_block_item.png',
    groups = {
        -- MTG
        snappy = 3,
        disable_jump = 1,
        -- MCL
        handy = 1,
        hoey = 1,
        swordy = 1,
        deco_block = 1,
        -- ALL
        fall_damage_add_percent = -80,
    },
    collision_box = {
        type = 'fixed',
        fixed = { -0.3, -0.3, -0.3, 0.3, 0.3, 0.3 }
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_slime_defaults(),
    move_resistance = 7,
})

core.register_node('x_farming:honeycomb_block', {
    description = S('Honeycomb Block'),
    short_description = S('Honeeycomb Block'),
    tiles = { 'x_farming_honeycomb_block.png' },
    paramtype = 'light',
    groups = {
        -- MTG
        crumbly = 3,
        -- MCL
        handy = 1,
        deco_block = 1,
    },
    _mcl_blast_resistance = 0.6,
    _mcl_hardness = 0.6,
    sounds = x_farming.node_sound_dirt_defaults()
})

-- Candles
for i = 1, 4 do
    -- OFF
    core.register_node('x_farming:candle_off_' .. i, {
        description = S('Candle'),
        short_description = S('Candle'),
        drawtype = 'mesh',
        mesh = 'x_farming_candle_' .. i .. '.obj',
        tiles = {
            { name = 'x_farming_candle_mesh.png' },
            {
                name = 'x_farming_candle_no_flame.png',
                backface_culling = false
            }
        },
        paramtype2 = 'facedir',
        use_texture_alpha = 'clip',
        paramtype = 'light',
        sunlight_propagates = true,
        walkable = false,
        liquids_pointable = false,
        floodable = true,
        inventory_image = 'x_farming_candle_item.png',
        wield_image = 'x_farming_candle_item.png',
        drop = {
            max_items = i,
            items = {
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                },
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                },
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                },
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                }
            },
        },
        groups = {
            -- MTG
            snappy = 3,
            candle = i == 1 and 1 or nil,
            candle_x_farming = i == 1 and 1 or nil,
            attached_node = 1,
            not_in_creative_inventory = i == 1 and 0 or 1,
            -- MCL
            handy = 1,
            hoey = 1,
            swordy = 1,
            deco_block = 1
        },
        selection_box = {
            type = 'fixed',
            fixed = { -0.3, -0.5, -0.3, 0.3, 0.4, 0.3 }
        },
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
        sounds = x_farming.node_sound_wood_defaults(),
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local stack_name = itemstack:get_name()

            if core.get_item_group(stack_name, 'candle') > 0 and i < 4 then
                core.swap_node(pos, { name = 'x_farming:candle_off_' .. i + 1, param2 = node.param2 })

                if not core.is_creative_enabled(clicker:get_player_name()) then
                    itemstack:take_item()
                end
            elseif core.get_item_group(stack_name, 'torch') > 0
                or stack_name == 'fire:flint_and_steel'
                or stack_name == 'mcl_fire:flint_and_steel'
            then
                core.swap_node(pos, { name = 'x_farming:candle_on_' .. i, param2 = node.param2 })
            end

            return itemstack
        end,
        on_flood = x_farming.on_flood_candle
    })

    -- ON
    core.register_node('x_farming:candle_on_' .. i, {
        description = S('Candle'),
        short_description = S('Candle'),
        drawtype = 'mesh',
        mesh = 'x_farming_candle_' .. i .. '.obj',
        tiles = {
            { name = 'x_farming_candle_mesh.png' },
            {
                name = 'x_farming_candle_flame_animated.png',
                backface_culling = false,
                animation = {
                    type = 'vertical_frames',
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1
                },
            }
        },
        paramtype2 = 'facedir',
        use_texture_alpha = 'clip',
        paramtype = 'light',
        sunlight_propagates = true,
        walkable = false,
        liquids_pointable = false,
        floodable = true,
        inventory_image = 'x_farming_candle_item.png',
        wield_image = 'x_farming_candle_item.png',
        drop = {
            max_items = i,
            items = {
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                },
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                },
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                },
                {
                    rarity = 1,
                    items = { 'x_farming:candle_off_1' },
                }
            },
        },
        groups = {
            -- MTG
            snappy = 3,
            attached_node = 1,
            candle_on = 1,
            not_in_creative_inventory = 1,
            -- MCL
            handy = 1,
            hoey = 1,
            swordy = 1,
            deco_block = 1
        },
        selection_box = {
            type = 'fixed',
            fixed = { -0.3, -0.5, -0.3, 0.3, 0.4, 0.3 }
        },
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
        sounds = x_farming.node_sound_wood_defaults(),
        light_source = i * 3,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local stack_name = itemstack:get_name()

            if core.get_item_group(stack_name, 'candle') > 0 and i < 4 then
                core.swap_node(pos, { name = 'x_farming:candle_on_' .. i + 1, param2 = node.param2 })

                if not core.is_creative_enabled(clicker:get_player_name()) then
                    itemstack:take_item()
                end
            else
                core.swap_node(pos, { name = 'x_farming:candle_off_' .. i, param2 = node.param2 })
            end

            return itemstack
        end,
        on_flood = x_farming.on_flood_candle
    })
end

-- Colored Candles
for color_id, color_def in pairs(x_farming.candle_colors) do
    local color_group = 'color_' .. color_id

    for i = 1, 4 do
        -- OFF
        core.register_node('x_farming:candle_' .. color_id .. '_off_' .. i, {
            description = color_def.name .. ' ' .. S('Candle'),
            short_description = color_def.name .. ' ' .. S('Candle'),
            drawtype = 'mesh',
            mesh = 'x_farming_candle_' .. i .. '.obj',
            tiles = {
                { name = 'x_farming_candle_mesh.png^[multiply:' .. color_def.hex .. ':255' },
                {
                    name = 'x_farming_candle_no_flame.png',
                    backface_culling = false
                }
            },
            paramtype2 = 'facedir',
            use_texture_alpha = 'clip',
            paramtype = 'light',
            sunlight_propagates = true,
            walkable = false,
            liquids_pointable = false,
            floodable = true,
            inventory_image = 'x_farming_candle_item.png^[multiply:' .. color_def.hex .. ':255',
            wield_image = 'x_farming_candle_item.png^[multiply:' .. color_def.hex .. ':255',
            drop = {
                max_items = i,
                items = {
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    },
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    },
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    },
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    }
                },
            },
            groups = {
                -- MTG
                snappy = 3,
                candle = i == 1 and 1 or nil,
                attached_node = 1,
                not_in_creative_inventory = i == 1 and 0 or 1,
                ['candle_' .. '_' .. color_group] = 1,
                -- MCL
                handy = 1,
                hoey = 1,
                swordy = 1,
                deco_block = 1,
            },
            selection_box = {
                type = 'fixed',
                fixed = { -0.3, -0.5, -0.3, 0.3, 0.4, 0.3 }
            },
            _mcl_blast_resistance = 0,
            _mcl_hardness = 0,
            sounds = x_farming.node_sound_wood_defaults(),
            on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                local stack_name = itemstack:get_name()

                if core.get_item_group(stack_name, 'candle') > 0
                    and core.get_item_group(stack_name, 'candle_' .. '_' .. color_group) > 0
                    and i < 4
                then
                    core.swap_node(pos, { name = 'x_farming:candle_' .. color_id .. '_off_' .. i + 1, param2 = node.param2 })

                    if not core.is_creative_enabled(clicker:get_player_name()) then
                        itemstack:take_item()
                    end
                elseif core.get_item_group(stack_name, 'torch') > 0
                    or stack_name == 'fire:flint_and_steel'
                    or stack_name == 'mcl_fire:flint_and_steel'
                then
                    core.swap_node(pos, { name = 'x_farming:candle_' .. color_id .. '_on_' .. i, param2 = node.param2 })
                end

                return itemstack
            end,
            on_flood = x_farming.on_flood_candle
        })

        -- ON
        core.register_node('x_farming:candle_' .. color_id .. '_on_' .. i, {
            description = color_def.name .. ' ' .. S('Candle'),
            short_description = color_def.name .. ' ' .. S('Candle'),
            drawtype = 'mesh',
            mesh = 'x_farming_candle_' .. i .. '.obj',
            tiles = {
                { name = 'x_farming_candle_mesh.png^[multiply:' .. color_def.hex .. ':255' },
                {
                    name = 'x_farming_candle_flame_animated.png',
                    backface_culling = false,
                    animation = {
                        type = 'vertical_frames',
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 1
                    },
                }
            },
            paramtype2 = 'facedir',
            use_texture_alpha = 'clip',
            paramtype = 'light',
            sunlight_propagates = true,
            walkable = false,
            liquids_pointable = false,
            floodable = true,
            inventory_image = 'x_farming_candle_item.png^[multiply:' .. color_def.hex .. ':255',
            wield_image = 'x_farming_candle_item.png^[multiply:' .. color_def.hex .. ':255',
            drop = {
                max_items = i,
                items = {
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    },
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    },
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    },
                    {
                        rarity = 1,
                        items = { 'x_farming:candle_' .. color_id .. '_off_1' },
                    }
                },
            },
            groups = {
                -- MTG
                snappy = 3,
                attached_node = 1,
                candle_on = 1,
                -- ['candle_' .. '_' .. color_group] = 1,
                not_in_creative_inventory = 1,
                -- MCL
                handy = 1,
                hoey = 1,
                swordy = 1,
                deco_block = 1
            },
            selection_box = {
                type = 'fixed',
                fixed = { -0.3, -0.5, -0.3, 0.3, 0.4, 0.3 }
            },
            _mcl_blast_resistance = 0,
            _mcl_hardness = 0,
            sounds = x_farming.node_sound_wood_defaults(),
            light_source = i * 3,
            on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                local stack_name = itemstack:get_name()

                if core.get_item_group(stack_name, 'candle') > 0 and i < 4 then
                    core.swap_node(pos, { name = 'x_farming:candle_' .. color_id .. '_on_' .. i + 1, param2 = node.param2 })

                    if not core.is_creative_enabled(clicker:get_player_name()) then
                        itemstack:take_item()
                    end
                else
                    core.swap_node(pos, { name = 'x_farming:candle_' .. color_id .. '_off_' .. i, param2 = node.param2 })
                end

                return itemstack
            end,
            on_flood = x_farming.on_flood_candle
        })
    end

    local craft_dye = 'group:dye,' .. color_group

    if color_def.craft_dye then
        craft_dye = color_def.craft_dye
    end

    -- Crafting
    core.register_craft({
        type = 'shapeless',
        output = 'x_farming:candle_' .. color_id .. '_off_1',
        recipe = { 'group:candle_x_farming', craft_dye },
    })

    if core.get_modpath('mcl_dye') then
        local mcl_groups = {}

        for key, value in pairs(color_def.mcl_groups) do
            table.insert(mcl_groups, key)
        end

        local mcl_craft_dye = 'group:dye,' .. table.concat(mcl_groups, ',')

        core.register_craft({
            type = 'shapeless',
            output = 'x_farming:candle_' .. color_id .. '_off_1',
            recipe = { 'group:candle_x_farming', mcl_craft_dye },
        })
    end
end

-- Pillow

local pillow_colors = {
    {
        name = 'white',
        description = S('White'),
        mcl_group = { 'unicolor_white' }
    },
    {
        name = 'grey',
        description = S('Grey'),
        mcl_group = { 'unicolor_grey' }
    },
    {
        name = 'dark_grey',
        description = S('Dark Grey'),
        mcl_group = { 'unicolor_darkgrey' }
    },
    {
        name = 'black',
        description = S('Black'),
        mcl_group = { 'unicolor_black' }
    },
    {
        name = 'violet',
        description = S('Violet'),
        mcl_group = { 'unicolor_red_violet' }
    },
    {
        name = 'blue',
        description = S('Blue'),
        mcl_group = { 'unicolor_blue' }
    },
    {
        name = 'light_blue',
        description = S('Light Blue'),
        mcl_group = { 'unicolor_light_blue' }
    },
    {
        name = 'cyan',
        description = S('Cyan'),
        mcl_group = { 'unicolor_cyan' }
    },
    {
        name = 'dark_green',
        description = S('Dark Green'),
        mcl_group = { 'unicolor_dark_green' }
    },
    {
        name = 'green',
        description = S('Green'),
        mcl_group = { 'unicolor_green' }
    },
    {
        name = 'yellow',
        description = S('Yellow'),
        mcl_group = { 'unicolor_yellow' }
    },
    {
        name = 'brown',
        description = S('Brown'),
        mcl_group = { 'unicolor_dark_orange' }
    },
    {
        name = 'orange',
        description = S('Orange'),
        mcl_group = { 'unicolor_orange' }
    },
    {
        name = 'red',
        description = S('Red'),
        mcl_group = { 'unicolor_red' }
    },
    {
        name = 'magenta',
        description = S('Magenta'),
        mcl_group = { 'unicolor_red_violet' }
    },
    {
        name = 'pink',
        description = S('Pink'),
        mcl_group = { 'unicolor_light_red' }
    },
}

if not core.get_modpath('x_clay') then
    core.register_craftitem('x_farming:dye_light_blue', {
        inventory_image = 'x_farming_dye_light_blue.png',
        description = S('Light Blue Dye'),
        short_description = S('Light Blue Dye'),
        groups = { dye = 1, color_light_blue = 1 }
    })

    core.register_craft({
        type = 'shapeless',
        output = 'x_clay:dye_light_blue 2',
        recipe = { 'group:dye,color_white', 'group:dye,color_blue' },
    })
end

for _, def in ipairs(pillow_colors) do
    local color_group = 'color_' .. def.name

    if core.registered_nodes["wool:" .. def.name] then
        core.register_alias("x_farming:pillow_" .. def.name,"wool:" .. def.name)
        core.override_item("wool:" .. def.name,{
            groups = {
                -- MTG
                snappy = 2,
                choppy = 2,
                oddly_breakable_by_hand = 3,
                flammable = 3,
                wool = 1,
                pillow = 1,
                [color_group] = 1,
            },
        })
    else
        core.register_node('x_farming:pillow_' .. def.name, {
            description = S('Pillow') .. ' ' .. def.description,
            short_description = S('Pillow') .. ' ' .. def.description,
            tiles = { 'x_farming_pillow_' .. def.name .. '.png' },
            is_ground_content = false,
            groups = {
                -- MTG
                snappy = 2,
                choppy = 2,
                oddly_breakable_by_hand = 3,
                flammable = 3,
                pillow = 1,
                [color_group] = 1,
                -- MCL
                handy = 1,
                shearsy_wool = 1,
                fire_encouragement = 30,
                fire_flammability = 60,
                building_block = 1,
                [def.mcl_group[1]] = 1,
            },
            _mcl_hardness = 0.8,
            _mcl_blast_resistance = 0.8,
            sounds = x_farming.node_sound_pillow_defaults(),
        })

        if core.get_modpath('mcl_dye') and x_farming.candle_colors[def.name] then
            local mcl_groups = {}
            local color_def = x_farming.candle_colors[def.name]

            for key, value in pairs(color_def.mcl_groups) do
                table.insert(mcl_groups, key)
            end

            local mcl_craft_dye = 'group:dye,' .. table.concat(mcl_groups, ',')

            core.register_craft({
                type = 'shapeless',
                output = 'x_farming:pillow_' .. def.name,
                recipe = { mcl_craft_dye, 'group:pillow' },
            })
        end

        if core.get_modpath('dye') then
            core.register_craft({
                type = 'shapeless',
                output = 'x_farming:pillow_' .. def.name,
                recipe = { 'group:dye,' .. color_group, 'group:pillow' },
            })
        end
    end
end

core.register_node('x_farming:silt_loam_soil', {
    description = S('Silt Loam Soil. Used for farming rice.'),
    short_description = S('Silt Loam Soil'),
    tiles = { 'x_farming_silt_loam_soil.png' },
    groups = {
        -- MTG
        crumbly = 3,
        -- MCL
        handy = 1,
        shovely = 1,
        dirt = 1,
        soil_sapling = 2,
        soil_sugarcane = 1,
        cultivatable = 2,
        enderman_takable = 1,
        building_block = 1,
        -- ALL
        soil = 1,
    },
    _mcl_blast_resistance = 0.5,
    _mcl_hardness = 0.5,
    sounds = x_farming.node_sound_dirt_defaults(),
})

-- barley stack
core.register_node('x_farming:barley_stack', {
    description = S('Barley Stack'),
    tiles = {
        'x_farming_barley_stack_top.png',
        'x_farming_barley_stack_top.png',
        'x_farming_barley_stack_side.png',
    },
    paramtype2 = 'facedir',
    is_ground_content = false,
    groups = {
        -- MTG
        snappy = 3,
        -- MCL
        handy = 1,
        hoey = 1,
        building_block = 1,
        fire_encouragement = 60,
        fire_flammability = 20,
        compostability = 85,
        -- ALL
        flammable = 4,
        fall_damage_add_percent = -30,
    },
    _mcl_blast_resistance = 0.5,
    _mcl_hardness = 0.5,
    sounds = x_farming.node_sound_leaves_defaults(),
    on_place = core.rotate_node
})

-- rice stack
core.register_node('x_farming:rice_stack', {
    description = S('Rice Stack'),
    tiles = {
        'x_farming_rice_stack_top.png',
        'x_farming_rice_stack_bottom.png',
        'x_farming_rice_stack_side.png',
    },
    paramtype2 = 'facedir',
    is_ground_content = false,
    groups = {
        -- MTG
        snappy = 3,
        -- MCL
        handy = 1,
        hoey = 1,
        building_block = 1,
        fire_encouragement = 60,
        fire_flammability = 20,
        compostability = 85,
        -- ALL
        flammable = 4,
        fall_damage_add_percent = -30,
    },
    _mcl_blast_resistance = 0.5,
    _mcl_hardness = 0.5,
    sounds = x_farming.node_sound_leaves_defaults(),
    on_place = core.rotate_node
})

core.register_node('x_farming:silt_loam_brick_block', {
    description = S('Silt Loam Brick Block'),
    paramtype2 = 'facedir',
    place_param2 = 0,
    tiles = {
        'x_farming_silt_loam_brick_block.png^[transformFX',
        'x_farming_silt_loam_brick_block.png',
    },
    is_ground_content = false,
    groups = {
        -- MTG
        cracky = 3,
        -- MCL
        pickaxey = 1,
        building_block = 1,
        material_stone = 1
    },
    _mcl_blast_resistance = 6,
    _mcl_hardness = 2,
    sounds = x_farming.node_sound_stone_defaults(),
})

-- French Potatoes
x_farming.register_feast('french_potatoes', {
    description = S('French Potatoes') .. '\n' .. S('Compost chance') .. ': 100%',
    short_description = S('French Potatoes'),
    mesh = 'x_farming_french_potatoes.obj',
    selection_box = {
        type = 'fixed',
        fixed = { -8 / 16, -8 / 16, -7 / 16, 8 / 16, -1 / 16, 7 / 16 }
    },
    steps = 5
})

-- Baked Fish
x_farming.register_feast('baked_fish', {
    description = S('Baked Fish') .. '\n' .. S('Compost chance') .. ': 100%',
    short_description = S('Baked Fish'),
    mesh = 'x_farming_baked_fish.obj',
    selection_box = {
        type = 'fixed',
        fixed = { -8 / 16, -8 / 16, -7 / 16, 8 / 16, -1 / 16, 7 / 16 }
    },
    steps = 5
})

-- Melon Slush
x_farming.register_feast('melon_slush', {
    description = S('Melon Slush') .. '\n' .. S('Compost chance') .. ': 100%',
    short_description = S('Melon Slush'),
    mesh = 'x_farming_melon_slush.obj',
    selection_box = {
        type = 'fixed',
        fixed = { -7 / 16, -8 / 16, -7 / 16, 7 / 16, 3 / 16, 7 / 16 }
    },
    use_texture_alpha = 'blend',
    last_drop = 'default:glass',
    sounds = x_farming.node_sound_thin_glass_defaults(),
    steps = 5
})

-- Strawberry Pie
x_farming.register_pie('strawberry_pie', {
    description = S('Strawberry Pie') .. '\n' .. S('Compost chance') .. ': 100%',
    short_description = S('Strawberry Pie'),
    mesh = 'x_farming_pie.obj',
    steps = 4
})

-- Chocolate Pie
x_farming.register_pie('chocolate_pie', {
    description = S('Chocolade Pie') .. '\n' .. S('Compost chance') .. ': 100%',
    short_description = S('Chocolade Pie'),
    mesh = 'x_farming_pie.obj',
    steps = 4
})

-- Honey Glazed Kiwi Pie
x_farming.register_pie('honey_kiwi_pie', {
    description = S('Honey Glazed Kiwi') .. '\n' .. S('Compost chance') .. ': 100%',
    short_description = S('Honey Glazed Kiwi'),
    mesh = 'x_farming_pie.obj',
    steps = 4
})

--
-- Convert farming soils - copy from MTG
--
if not core.get_modpath('farming') then
    core.register_abm({
        label = 'X Farming soil',
        nodenames = { 'group:field' },
        interval = 15,
        chance = 4,
        action = function(pos, node)
            local n_def = core.registered_nodes[node.name] or nil
            local wet = n_def.soil.wet or nil
            local base = n_def.soil.base or nil
            local dry = n_def.soil.dry or nil
            if not n_def or not n_def.soil or not wet or not base or not dry then
                return
            end

            pos.y = pos.y + 1
            local nn = core.get_node_or_nil(pos)
            if not nn or not nn.name then
                return
            end
            local nn_def = core.registered_nodes[nn.name] or nil
            pos.y = pos.y - 1

            if nn_def and nn_def.walkable and core.get_item_group(nn.name, 'plant') == 0 then
                core.set_node(pos, { name = base })
                return
            end
            -- check if there is water nearby
            local wet_lvl = core.get_item_group(node.name, 'wet')
            if core.find_node_near(pos, 3, { 'group:water' }) then
                -- if it is dry soil and not base node, turn it into wet soil
                if wet_lvl == 0 then
                    core.set_node(pos, { name = wet })
                end
            else
                -- only turn back if there are no unloaded blocks (and therefore
                -- possible water sources) nearby
                if not core.find_node_near(pos, 3, { 'ignore' }) then
                    -- turn it back into base if it is already dry
                    if wet_lvl == 0 then
                        -- only turn it back if there is no plant/seed on top of it
                        if core.get_item_group(nn.name, 'plant') == 0 and core.get_item_group(nn.name, 'seed') == 0 then
                            core.set_node(pos, { name = base })
                        end
                    elseif wet_lvl == 1 then
                        -- if its wet turn it back into dry soil
                        core.set_node(pos, { name = dry })
                    end
                end
            end
        end,
    })
end
