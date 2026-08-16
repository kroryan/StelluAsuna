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

local function particle_effect(pos)
    core.add_particlespawner({
        amount = 8,
        time = 2,
        minpos = { x = pos.x - 0.4, y = pos.y + 0.4, z = pos.z - 0.4 },
        maxpos = { x = pos.x + 0.4, y = pos.y + 0.6, z = pos.z + 0.4 },
        minvel = { x = -0.1, y = 0, z = -0.1 },
        maxvel = { x = 0.1, y = 0.1, z = 0.1 },
        minacc = vector.new({ x = -0.1, y = 0, z = -0.1 }),
        maxacc = vector.new({ x = 0.1, y = 0.1, z = 0.1 }),
        minexptime = 1,
        maxexptime = 2,
        minsize = 1,
        maxsize = 2,
        texture = 'x_farming_x_bonemeal_particles.png',
        animation = {
            type = 'vertical_frames',
            aspect_w = 8,
            aspect_h = 8,
            length = 3,
        },
    })
end

for i = 1, 5, 1 do
    local def = {}

    def.name = 'x_farming:composter_' .. i
    def.description = S('Composter') .. ' ' .. i
    def.short_description = S('Composter') .. ' ' .. i
    def.drawtype = 'mesh'
    def.mesh = 'x_farming_crate.obj'
    def.tiles = { 'x_farming_composter_' .. i .. '.png' }
    def.use_texture_alpha = 'clip'
    def.sounds = x_farming.node_sound_wood_defaults()
    def.paramtype = 'light'
    def.paramtype2 = 'facedir'
    def.place_param2 = 0
    def.is_ground_content = false
    def.groups = {
        -- MTG
        choppy = 2,
        oddly_breakable_by_hand = 2,
        flammable = 2,
        not_in_creative_inventory = 1,
        -- MCL
        handy = 1,
        material_wood = 1,
        deco_block = 1,
        dirtifier = 1,
        fire_encouragement = 3,
        fire_flammability = 4,
    }
    def.stack_max = 1
    def.mod_origin = 'x_farming'
    def.drop = 'x_farming:composter_1'
    def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local p_name = clicker:get_player_name()

        if core.is_protected(pos, p_name) then
            return itemstack
        end

        local wield_stack = clicker:get_wielded_item()
        local wield_stack_name = wield_stack:get_name()

        -- percentage, higher = better, max 100%
        local chance = 0

        if core.get_item_group(wield_stack_name, 'compost') > 0 then
            -- defined in groups, e.g. `{ compost = 10 }`
            chance = core.get_item_group(wield_stack_name, 'compost')
        elseif core.get_item_group(wield_stack_name, 'food_bread') == 1
            or core.get_item_group(wield_stack_name, 'wool') == 1
            or node.name == 'farming:straw'
        then
            chance = 85
        elseif core.get_item_group(wield_stack_name, 'flora') == 1
            or core.get_item_group(wield_stack_name, 'food_apple') == 1
            or core.get_item_group(wield_stack_name, 'fern') == 1
            or core.get_item_group(wield_stack_name, 'food_wheat') == 1
            or core.get_item_group(wield_stack_name, 'food_flour') == 1
            or core.get_item_group(wield_stack_name, 'mushroom') == 1
            or core.get_item_group(wield_stack_name, 'flower') == 1
        then
            chance = 65
        elseif core.get_item_group(wield_stack_name, 'marram_grass') == 1
            or core.get_item_group(wield_stack_name, 'junglegrass') == 1
            or node.name == 'default:cactus'
            or node.name == 'default:coral_green'
            or node.name == 'default:coral_pink'
            or node.name == 'default:coral_cyan'
        then
            chance = 50
        elseif core.get_item_group(wield_stack_name, 'leaves') == 1
            or core.get_item_group(wield_stack_name, 'seed') == 1
            or core.get_item_group(wield_stack_name, 'grass') == 1
            or core.get_item_group(wield_stack_name, 'snappy') == 3
            or core.get_item_group(wield_stack_name, 'sapling') == 1
            or core.get_item_group(wield_stack_name, 'food_blueberries') == 1
            or core.get_item_group(wield_stack_name, 'food_berry') == 1
            or node.name == 'default:sand_with_kelp'
            or node.name == 'default:large_cactus_seedling'
        then
            chance = 30
        end

        if chance == 0 then
            return itemstack
        end

        -- fill the composter
        if math.random() < chance / 100 then
            local meta = core.get_meta(pos)
            local prev_status = meta:get_int('composter_status')
            local status = prev_status + 10

            if status > 100 then
                status = 100
            end

            meta:set_int('composter_status', status)

            local node_def = core.registered_nodes[node.name]

            if math.fmod(status, 50) == 0 and node_def._next_state then
                local placenode = { name = node_def._next_state }

                core.swap_node(pos, placenode)
                particle_effect(pos)

                if i == 3 then
                    -- placed nr 4
                    core.get_node_timer(pos):start(math.random(1, 2))
                end
            elseif i == 1 then
                -- convert to visual 1st level
                core.swap_node(pos, { name = 'x_farming:composter_2' })
                particle_effect(pos)
            end
        end

        core.sound_play('x_farming_dirt_hit', { gain = 0.3, pos = pos, max_hear_distance = 10 }, true)

        if not core.is_creative_enabled(clicker:get_player_name()) then
            itemstack:take_item()
        end

        return itemstack
    end

    if i == 1 then
        -- empty composter is craftable, so can be in creative inventory
        def.groups = {
            -- MTG
            choppy = 2,
            oddly_breakable_by_hand = 2,
            -- MCL
            handy = 1,
            material_wood = 1,
            deco_block = 1,
            dirtifier = 1,
            fire_encouragement = 3,
            fire_flammability = 4,
            -- ALL
            flammable = 2,
        }
        def.description = S('Composter') .. ' (' .. S('right-click/place with item to create compost') .. ')'
        def.short_description = S('Composter')
    end

    if i < 4 then
        -- all except the last
        def._next_state = 'x_farming:composter_' .. i + 1
    end

    if i == 4 then
        def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            -- do nothing
        end

        -- last step
        def.on_timer = function(pos, elapsed)
            core.swap_node(pos, { name = 'x_farming:composter_5' })
        end
    end

    if i == 5 then
        def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local p_name = clicker:get_player_name()

            if core.is_protected(pos, p_name) then
                return itemstack
            end

            local meta = core.get_meta(pos)
            local above = vector.new(pos.x, pos.y + 0.5, pos.z)
            local drop_pos = core.find_node_near(above, 0.5, { 'air' }) or above

            core.sound_play('x_farming_dirt_hit', { gain = 0.3, pos = pos, max_hear_distance = 10 }, true)
            -- drop bonemeal
            core.add_item(
                vector.new(drop_pos.x, drop_pos.y + 1, drop_pos.z),
                ItemStack({ name = 'x_farming:bonemeal', count = math.random(1, 2) })
            )
            -- swap to beginning
            core.swap_node(pos, { name = 'x_farming:composter_1' })
            -- reset status
            meta:set_int('composter_status', 0)
        end
    end

    -- MCL
    def._mcl_hardness = 0.6
    def._mcl_blast_resistance = 0.6

    core.register_node(def.name, def)
end
