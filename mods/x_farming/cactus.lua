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

-- Large cactus

if core.get_modpath("default") then
    -- Alias cactus and seedling
    core.register_alias("x_farming:cactus","default:cactus")
    core.register_alias("x_farming:large_cactus_with_fruit_seedling","default:large_cactus_seedling")

    -- Add cactus fruits to grown large cactus
    local oglcsot = core.registered_items["default:large_cactus_seedling"].on_timer
    core.override_item("default:large_cactus_seedling",{
        on_timer = function(pos)
            local retval = oglcsot(pos)
            local fruit_locations = core.find_nodes_in_area_under_air(pos:add(vector.new(-2,1,-2)),pos:add(vector.new(2,8,2)),"default:cactus")
            for _,cpos in ipairs(fruit_locations) do
                if math.random(1,10) < 7 then
                    core.set_node(cpos:add(vector.new(0,1,0)),{ name = "x_farming:cactus_fruit" })
                end
            end
            return retval
        end,
    })
else
    core.register_node('x_farming:cactus', {
        description = S('Cactus'),
        tiles = {
            'x_farming_cactus_top.png',
            'x_farming_cactus_top.png',
            'x_farming_cactus.png',
            'x_farming_cactus.png',
            'x_farming_cactus.png^[transformFX',
            'x_farming_cactus.png^[transformFX',
        },
        paramtype2 = 'facedir',
        groups = {
            -- MTG
            choppy = 3,
            -- X Farming
            compost = 50,
            -- MCL
            handy = 1,
            deco_block = 1,
            dig_by_piston = 1,
            plant = 1,
            enderman_takable = 1,
            compostability = 50
        },
        sounds = x_farming.node_sound_wood_defaults(),
        on_place = core.rotate_node,
    })

    core.register_node('x_farming:large_cactus_with_fruit_seedling', {
        description = S('Large Cactus with Fruit Seedling') .. '\n' .. S('Compost chance') .. ': 30%',
        short_description = S('Large Cactus with Fruit Seedling'),
        drawtype = 'plantlike',
        tiles = { 'x_farming_large_cactus_with_fruit_seedling.png' },
        inventory_image = 'x_farming_large_cactus_with_fruit_seedling.png',
        wield_image = 'x_farming_large_cactus_with_fruit_seedling.png',
        paramtype = 'light',
        sunlight_propagates = true,
        walkable = false,
        selection_box = {
            type = 'fixed',
            fixed = {
                -5 / 16, -0.5, -5 / 16,
                5 / 16, 0.5, 5 / 16
            }
        },
        groups = {
            -- MTG
            choppy = 3,
            dig_immediate = 3,
            attached_node = 1,
            compost = 30,
            -- MCL
            handy = 1,
            deco_block = 1,
            dig_by_piston = 1,
            compostability = 30
        },
        sounds = x_farming.node_sound_wood_defaults(),
    
        on_place = function(itemstack, placer, pointed_thing)
            itemstack = x_farming.sapling_on_place(itemstack, placer, pointed_thing,
                'x_farming:large_cactus_with_fruit_seedling',
                { x = -3, y = 0, z = -3 },
                { x = 3, y = 6, z = 3 },
                4)
    
            return itemstack
        end,
    
        on_construct = function(pos)
            -- Normal cactus farming adds 1 cactus node by ABM,
            -- interval 12s, chance 83.
            -- Consider starting with 5 cactus nodes. We make sure that growing a
            -- large cactus is not a faster way to produce new cactus nodes.
            -- Confirmed by experiment, when farming 5 cacti, on average 1 new
            -- cactus node is added on average every
            -- 83 / 5 = 16.6 intervals = 16.6 * 12 = 199.2s.
            -- Large cactus contains on average 14 cactus nodes.
            -- 14 * 199.2 = 2788.8s.
            -- Set random range to average to 2789s.
            core.get_node_timer(pos):start(math.random(1859, 3719))
        end,
    
        on_timer = function(pos, elapsed)
            local node_under = core.get_node_or_nil(
                { x = pos.x, y = pos.y - 1, z = pos.z })
            if not node_under then
                -- Node under not yet loaded, try later
                core.get_node_timer(pos):start(300)
                return
            end
    
            if core.get_item_group(node_under.name, 'sand') == 0 then
                -- Seedling dies
                core.remove_node(pos)
                return
            end
    
            local light_level = core.get_node_light(pos)
            if not light_level or light_level < 13 then
                -- Too dark for growth, try later in case it's night
                core.get_node_timer(pos):start(300)
                return
            end
    
            core.log('action', 'A large cactus seedling grows into a large' ..
                'cactus at ' .. core.pos_to_string(pos))
            x_farming.grow_large_cactus(pos)
        end,
    })

    core.register_craft({
        output = 'x_farming:large_cactus_with_fruit_seedling',
        recipe = {
            { '', 'x_farming:cactus_fruit_item', '' },
            { 'x_farming:cactus_fruit_item', 'x_farming:cactus', 'x_farming:cactus_fruit_item' },
            { '', 'x_farming:cactus_fruit_item', '' },
        }
    })
    
    core.register_craft({
        type = 'fuel',
        recipe = 'x_farming:large_cactus_with_fruit_seedling',
        burntime = 5,
    })
end

core.register_node('x_farming:cactus_fruit', {
    description = S('Dragon Fruit'),
    short_description = S('Dragon Fruit'),
    inventory_image = 'x_farming_cactus_fruit_sides.png',
    is_ground_content = false,
    tiles = {
        'x_farming_cactus_fruit_top.png',
        'x_farming_cactus_fruit_bottom.png',
        'x_farming_cactus_fruit_sides.png',
        'x_farming_cactus_fruit_sides.png',
        'x_farming_cactus_fruit_sides.png',
        'x_farming_cactus_fruit_sides.png'
    },
    use_texture_alpha = 'clip',
    drawtype = 'nodebox',
    paramtype = 'light',
    node_box = {
        type = 'fixed',
        fixed = {
            { -0.25, -0.5, -0.25, 0.25, 0.0625, 0.25 },
        }
    },
    selection_box = {
        type = 'fixed',
        fixed = { -0.25, -0.5, -0.25, 0.25, 0.0625, 0.25 },
    },
    drop = {
        max_items = 1, -- Maximum number of items to drop.
        items = { -- Choose max_items randomly from this list.
            {
                items = { 'x_farming:cactus_fruit_item' }, -- Items to drop.
                rarity = 1, -- Probability of dropping is 1 / rarity.
            }
        },
    },
    groups = {
        -- MTG
        choppy = 3,
        flammable = 2,
        not_in_creative_inventory = 1,
        leafdecay = 3,
        leafdecay_drop = 1,
        -- MCL
        handy = 1,
        deco_block = 1,
        dig_by_piston = 1,
        plant = 1,
        enderman_takable = 1,
        compostability = 50
    },
    sounds = x_farming.node_sound_wood_defaults(),

    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        if oldnode.param2 == 20 then
            core.set_node(pos, { name = 'x_farming:cactus_fruit_mark' })
            core.get_node_timer(pos):start(math.random(300, 1500))
        end
    end,
})

core.register_node('x_farming:cactus_fruit_mark', {
    description = S('Cactus Fruit Marker'),
    short_description = S('Cactus Fruit Marker'),
    inventory_image = 'x_farming_cactus_fruit_sides.png^x_farming_invisible_node_overlay.png',
    wield_image = 'x_farming_cactus_fruit_sides.png^x_farming_invisible_node_overlay.png',
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
        local n = core.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

        if not ( n.name == 'x_farming:cactus' or n.name == "default:cactus" ) then
            core.remove_node(pos)
        elseif core.get_node_light(pos) < 11 then
            core.get_node_timer(pos):start(200)
        else
            core.set_node(pos, { name = 'x_farming:cactus_fruit', param2 = 20 })
        end
    end
})

--  Fruit Item

local cactus_fruit_item_def = {
    description = S('Dragon Fruit') .. '\n' .. S('Compost chance') .. ': 65%\n'
        .. core.colorize(x_farming.colors.brown, S('Hunger') .. ': 2'),
    short_description = S('Dragon Fruit'),
    drawtype = 'plantlike',
    tiles = { 'x_farming_cactus_fruit_item.png' },
    inventory_image = 'x_farming_cactus_fruit_item.png',
    on_use = core.item_eat(2),
    sounds = x_farming.node_sound_leaves_defaults(),
    groups = {
        -- X Farming
        compost = 65,
        -- MCL
        food = 2,
        eatable = 1,
        compostability = 65,
    },

    after_place_node = function(pos, placer, itemstack, pointed_thing)
        core.set_node(pos, { name = 'x_farming:cactus_fruit' })
    end,
}

if core.get_modpath('mcl_farming') then
    cactus_fruit_item_def.on_secondary_use = core.item_eat(2)
end


core.register_node('x_farming:cactus_fruit_item', cactus_fruit_item_def)

x_farming.register_leafdecay({
    trunks = { 'x_farming:cactus' },
    leaves = { 'x_farming:cactus_fruit' },
    radius = 1,
})

core.register_craft({
    type = 'fuel',
    recipe = 'x_farming:cactus_fruit_item',
    burntime = 10,
})

---crate
x_farming.register_crate('crate_cactus_fruit_item_3', {
    description = S('Cactus Fruit Crate'),
    short_description = S('Cactus Fruit Crate'),
    tiles = { 'x_farming_crate_cactus_fruit_item_3.png' },
    _custom = {
        crate_item = 'x_farming:cactus_fruit_item'
    }
})

--[[core.register_decoration(asuna.features.crops.cactus.inject_decoration({
    deco_type = "schematic",
    sidelen = 16,
    noise_params = {
        offset = -0.0004,
        scale = 0.0005,
        spread = { x = 200, y = 200, z = 200 },
        seed = 230,
        octaves = 2,
        persist = 0.6
    },
    y_max = 31000,
    y_min = 4,
    schematic = core.get_modpath("x_farming") .. '/schematics/x_farming_large_cactus.mts',
    flags = 'place_center_x, place_center_z',
    rotation = 'random',
}))]]

core.register_decoration({
    deco_type = "simple",
    decoration = "x_farming:cactus_fruit",
    place_on = "default:cactus",
    sidelen = 80,
    y_min = 4,
    y_max = 31000,
    fill_ratio = 0.05,
})
