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

-- how often a growth failure tick is retried (e.g. too dark)
local function tick_again(pos)
    core.get_node_timer(pos):start(math.random(80, 160))
end

-- SALT
core.register_craftitem('x_farming:salt', {
    description = S('Salt'),
    short_description = S('Salt'),
    tiles = { 'x_farming_salt.png' },
    inventory_image = 'x_farming_salt.png',
    wield_image = 'x_farming_salt.png'
})

core.register_node('x_farming:seed_salt', {
    description = S('Salty Water (plant soil)'),
    short_description = S('Salty Water (plant soil)'),
    inventory_image = 'x_farming_salt_water.png',
    wield_image = 'x_farming_salt_water.png',
    fertility = { 'grassland' },
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_1_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png'
    },
    use_texture_alpha = 'clip',
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        seed = 1,
        snappy = 3,
        flammable = 2,
        plant = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    next_plant = 'x_farming:salt_1',
    on_timer = x_farming.grow_plant,

    on_place = function(itemstack, placer, pointed_thing)
        local under = pointed_thing.under
        local node = core.get_node(under)
        local udef = core.registered_nodes[node.name]
        if udef and udef.on_rightclick
            and not (placer and placer:is_player()
            and placer:get_player_control().sneak)
        then
            return udef.on_rightclick(under, node, placer, itemstack, pointed_thing) or itemstack
        end

        return x_farming.place_seed(itemstack, placer, pointed_thing, 'x_farming:seed_salt')
    end,
})

-- 1
core.register_node('x_farming:salt_1', {
    description = S('Salt') .. ' 1',
    short_description = S('Salt') .. ' 1',
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_1_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png'
    },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    sunlight_propagates = true,
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    is_ground_content = false,
    walkable = false,
    buildable_to = true,
    drop = {
        items = {
            { items = { 'x_farming:salt' }, rarity = 8 },
            { items = { 'x_farming:seed_salt' }, rarity = 8 },
        }
    },
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        snappy = 3,
        flammable = 2,
        plant = 1,
        not_in_creative_inventory = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    next_plant = 'x_farming:salt_2',
    on_timer = x_farming.grow_plant,
    minlight = 13,
    maxlight = 15
})

-- 2
core.register_node('x_farming:salt_2', {
    description = S('Salt') .. ' 2',
    short_description = S('Salt') .. ' 2',
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_2_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png',
        'x_farming_salt_1_side.png'
    },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    sunlight_propagates = true,
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    is_ground_content = false,
    walkable = false,
    buildable_to = true,
    drop = {
        items = {
            { items = { 'x_farming:salt' }, rarity = 7 },
            { items = { 'x_farming:seed_salt' }, rarity = 7 },
        }
    },
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        snappy = 3,
        flammable = 2,
        plant = 1,
        not_in_creative_inventory = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    next_plant = 'x_farming:salt_3',
    on_timer = x_farming.grow_plant,
    minlight = 13,
    maxlight = 15
})

-- 3
core.register_node('x_farming:salt_3', {
    description = S('Salt') .. ' 3',
    short_description = S('Salt') .. ' 3',
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_2_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_2_side.png',
        'x_farming_salt_2_side.png',
        'x_farming_salt_2_side.png',
        'x_farming_salt_2_side.png'
    },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    sunlight_propagates = true,
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    is_ground_content = false,
    walkable = false,
    buildable_to = true,
    drop = {
        items = {
            { items = { 'x_farming:salt' }, rarity = 6 },
            { items = { 'x_farming:seed_salt' }, rarity = 6 },
        }
    },
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
            { -0.0625, -0.5, -0.0625, 0.0625, -0.25, 0.0625 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        snappy = 3,
        flammable = 2,
        plant = 1,
        not_in_creative_inventory = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    next_plant = 'x_farming:salt_4',
    on_timer = x_farming.grow_plant,
    minlight = 13,
    maxlight = 15
})

-- 4
core.register_node('x_farming:salt_4', {
    description = S('Salt') .. ' 4',
    short_description = S('Salt') .. ' 4',
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_3_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_2_side.png',
        'x_farming_salt_2_side.png',
        'x_farming_salt_2_side.png',
        'x_farming_salt_2_side.png'
    },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    sunlight_propagates = true,
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    is_ground_content = false,
    walkable = false,
    buildable_to = true,
    drop = {
        items = {
            { items = { 'x_farming:salt' }, rarity = 5 },
            { items = { 'x_farming:seed_salt' }, rarity = 5 },
        }
    },
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
            { -0.0625, -0.5, -0.0625, 0.0625, -0.25, 0.0625 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        snappy = 3,
        flammable = 2,
        plant = 1,
        not_in_creative_inventory = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    next_plant = 'x_farming:salt_5',
    on_timer = x_farming.grow_plant,
    minlight = 13,
    maxlight = 15
})

-- 5
core.register_node('x_farming:salt_5', {
    description = S('Salt') .. ' 5',
    short_description = S('Salt') .. ' 5',
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_3_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_3_side.png',
        'x_farming_salt_3_side.png',
        'x_farming_salt_3_side.png',
        'x_farming_salt_3_side.png'
    },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    sunlight_propagates = true,
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    is_ground_content = false,
    walkable = false,
    buildable_to = true,
    drop = {
        items = {
            { items = { 'x_farming:salt' }, rarity = 4 },
            { items = { 'x_farming:seed_salt' }, rarity = 4 },
        }
    },
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
            { -0.1875, -0.375, -0.1875, 0.1875, -0.25, 0.1875 },
            { -0.0625, -0.25, -0.0625, 0.0625, -0.125, 0.0625 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        snappy = 3,
        flammable = 2,
        plant = 1,
        not_in_creative_inventory = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    next_plant = 'x_farming:salt_6',
    on_timer = x_farming.grow_plant,
    minlight = 13,
    maxlight = 15
})

-- 6
core.register_node('x_farming:salt_6', {
    description = S('Salt') .. ' 6',
    short_description = S('Salt') .. ' 6',
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_4_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_3_side.png',
        'x_farming_salt_3_side.png',
        'x_farming_salt_3_side.png',
        'x_farming_salt_3_side.png'
    },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    sunlight_propagates = true,
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    is_ground_content = false,
    walkable = false,
    buildable_to = true,
    drop = {
        items = {
            { items = { 'x_farming:salt' }, rarity = 3 },
            { items = { 'x_farming:seed_salt' }, rarity = 3 },
        }
    },
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
            { -0.1875, -0.375, -0.1875, 0.1875, -0.25, 0.1875 },
            { -0.0625, -0.25, -0.0625, 0.0625, -0.125, 0.0625 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        snappy = 3,
        flammable = 2,
        plant = 1,
        not_in_creative_inventory = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    next_plant = 'x_farming:salt_7',
    on_timer = x_farming.grow_plant,
    minlight = 13,
    maxlight = 15
})

-- 7
core.register_node('x_farming:salt_7', {
    description = S('Salt') .. ' 7',
    short_description = S('Salt') .. ' 7',
    drawtype = 'nodebox',
    tiles = {
        {
            name = "x_farming_salt_4_top.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        'x_farming_salt_1_bottom.png',
        'x_farming_salt_4_side.png',
        'x_farming_salt_4_side.png',
        'x_farming_salt_4_side.png',
        'x_farming_salt_4_side.png'
    },
    use_texture_alpha = 'clip',
    paramtype = 'light',
    sunlight_propagates = true,
    on_rotate = function(pos, node, user, mode, new_param2)
        return false
    end,
    is_ground_content = false,
    walkable = false,
    buildable_to = true,
    drop = {
        items = {
            { items = { 'x_farming:salt' }, rarity = 1 },
            { items = { 'x_farming:salt' }, rarity = 2 },
            { items = { 'x_farming:seed_salt' }, rarity = 1 },
            { items = { 'x_farming:seed_salt' }, rarity = 2 },
        }
    },
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
            { -0.3125, -0.5, -0.3125, 0.3125, -0.25, 0.3125 },
            { -0.1875, -0.5, -0.1875, 0.1875, -0.125, 0.1875 },
            { -0.0625, -0.5, -0.0625, 0.0625, 0, 0.0625 },
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
        },
    },
    groups = {
        -- MTG
        snappy = 3,
        flammable = 2,
        plant = 1,
        not_in_creative_inventory = 1,
        attached_node = 1,
        -- MCL
        handy = 1,
        shearsy = 1,
        deco_block = 1,
        dig_by_water = 1,
        destroy_by_lava_flow = 1,
        dig_by_piston = 1
    },
    _mcl_blast_resistance = 0,
    _mcl_hardness = 0,
    sounds = x_farming.node_sound_leaves_defaults(),
    minlight = 13,
    maxlight = 15
})

-- replacement LBM for pre-nodetimer plants
core.register_lbm({
    name = 'x_farming:start_nodetimer_salt',
    nodenames = {
        'x_farming:seed_salt',
        'x_farming:salt_1',
        'x_farming:salt_2',
        'x_farming:salt_3',
        'x_farming:salt_4',
        'x_farming:salt_5',
        'x_farming:salt_6',
    },
    action = function(pos, node)
        tick_again(pos)
    end,
})

---bag
x_farming.register_bag('bag_salt', {
    description = S('Salt') .. ' Bag',
    short_description = S('Salt') .. ' Bag',
    tiles = { 'x_farming_bag_salt.png' },
    _custom = {
        bag_item = 'x_farming:salt'
    }
})

core.register_on_mods_loaded(function()
    local deco_place_on = {}
    local deco_biomes = {}

    -- MTG
    if core.get_modpath('default') then
        table.insert(deco_place_on, 'default:dirt')
        table.insert(deco_place_on, 'default:dry_dirt')
        table.insert(deco_biomes, 'rainforest_swamp')
        table.insert(deco_biomes, 'savanna_shore')
    end

    -- MCL
    if core.get_modpath('mcl_core') then
        table.insert(deco_place_on, 'mcl_core:sand')
        table.insert(deco_biomes, 'Savanna_beach')
    end

    if next(deco_place_on) and next(deco_biomes) then
        core.register_decoration({
            name = 'x_farming:salt',
            deco_type = 'schematic',
            place_on = deco_place_on,
            sidelen = 16,
            noise_params = {
                offset = -0.3,
                scale = 0.7,
                spread = { x = 200, y = 200, z = 200 },
                seed = 354,
                octaves = 3,
                persist = 0.7
            },
            biomes = deco_biomes,
            y_max = 0,
            y_min = 0,
            schematic = core.get_modpath('x_farming') .. '/schematics/x_farming_salt_decor.mts',
        })
    end
end)
