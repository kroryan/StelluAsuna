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

-- Localize data buffer table outside the loop, to be re-used for all
-- mapchunks, therefore minimising memory use.
local data = {}
local p2data = {}

core.register_on_generated(function(minp, maxp, blockseed)
    -- Start time of mapchunk generation.
    -- local t0 = os.clock()
    local rand = PcgRandom(blockseed)
    -- Array containing the biome IDs of nodes in the most recently generated chunk by the current mapgen
    local biomemap = core.get_mapgen_object('biomemap') or {}
    -- Table mapping requested generation notification types to arrays of positions at which the corresponding generated structures are located within the current chunk
    local gennotify = core.get_mapgen_object('gennotify')
    -- Load the voxelmanip with the result of engine mapgen
    local vm, emin, emax = core.get_mapgen_object('voxelmanip')
    -- 'area' is used later to get the voxelmanip indexes for positions
    local area = VoxelArea:new({ MinEdge = emin, MaxEdge = emax })
    -- Get the content ID data from the voxelmanip in the form of a flat array.
    -- Set the buffer parameter to use and reuse 'data' for this.
    vm:get_data(data)
    -- Raw `param2` data read into the `VoxelManip` object
    vm:get_param2_data(p2data)
    -- Side length of mapchunk
    local shared_args = {}

    --
    -- on_data
    --
    -- read/write to `data` what will be eventually saved (set_data)
    -- used for voxelmanip `data` manipulation
    for _, def in ipairs(Everness.on_generated_queue) do
        if def.can_run(biomemap) and def.on_data then
            shared_args[def.name] = shared_args[def.name] or {}
            def.on_data(minp, maxp, area, data, p2data, gennotify, rand, shared_args[def.name])
        end
    end

    -- set data after they have been manipulated (from above)
    vm:set_data(data)
    vm:set_param2_data(p2data)

    --
    -- after_set_data
    --
    -- read-only (but cant and should not manipulate) voxelmanip `data`
    -- used for `place_schematic_on_vmanip` which will invalidate `data`
    -- therefore we are doing it after we set the data
    for _, def in ipairs(Everness.on_generated_queue) do
        if def.can_run(biomemap) and def.after_set_data then
            shared_args[def.name] = shared_args[def.name] or {}
            def.after_set_data(minp, maxp, vm, area, data, p2data, gennotify, rand, shared_args[def.name])
        end
    end

    -- Recalculate lighting after Everness edits without zeroing sunlight.
    -- Forcing day=0 here makes every freshly generated chunk pitch black in
    -- the merged StelluAsuna world (including the player's hand/tools).
    vm:calc_lighting()
    -- Liquid nodes were placed so set them flowing.
    vm:update_liquids()
    -- Write what has been created to the world.
    vm:write_to_map()

    --
    -- after_write_to_map
    --
    -- Cannot read/write voxelmanip or its data
    -- Used for direct manipulation of the world chunk nodes where the
    -- definitions of nodes are available and node callback can be executed
    -- or e.g. for `core.fix_light`
    for _, def in ipairs(Everness.on_generated_queue) do
        if def.can_run(biomemap) and def.after_write_to_map then
            shared_args[def.name] = shared_args[def.name] or {}
            def.after_write_to_map(shared_args[def.name], gennotify, rand)
        end
    end

    -- Print generation time of this mapchunk.
    -- local chugent = math.ceil((os.clock() - t0) * 1000)
    -- print('[Everness] Mapchunk generation time ' .. chugent .. ' ms')
end)

local mpath = minetest.get_modpath('everness')

--
-- Giant Sequoia Tree
--

local sequoia_tree_schem = minetest.get_modpath('everness') .. '/schematics/everness_giant_sequoia_tree.mts'

abdecor.register_advanced_decoration('everness_giant_sequoia_tree',{
    target = {
        place_on = {
            'default:dirt_with_coniferous_litter',
            'default:dirt_with_snow',
            'default:dirt_with_dry_grass',
        },
        spawn_by = {
            'default:dirt_with_coniferous_litter',
            'default:dirt_with_snow',
            'default:dirt_with_dry_grass',
        },
        num_spawn_by = 8,
        sidelen = 80,
        fill_ratio = 0.000095,
        y_max = 31000,
        y_min = 8,
        biomes = {
            'mesa',
            'taiga',
            'coniferous_forest',
        },
    },
    fn = function(mapgen)
        -- Get provided values
        local pos = mapgen.pos
        local va = mapgen.voxelarea
        local vdata = mapgen.data
        local ystride = va.ystride
        local zstride = va.zstride

        -- Check that there is likely enough space to place a tree
        local vpos = va:index(pos.x,pos.y,pos.z)
        for i = 2, 20 do -- y
            if vdata[vpos + ystride * i] ~= minetest.CONTENT_AIR then
                return -- not enough ceiling clearance
            end
        end
        for i = -6, 6 do -- x
            if vdata[vpos + i] == minetest.CONTENT_AIR then
                return -- not enough space in the x dimension
            end
        end
        for i = -6, 6 do -- z
            if vdata[vpos + i * zstride] == minetest.CONTENT_AIR then
                return -- not enough space in the z dimension
            end
        end

        -- Roughly enough space, emerge mapchunks and place a sequoia tree
        minetest.emerge_area(
            vector.new(pos.x - 12, pos.y, pos.z - 12),
            vector.new(pos.x + 12, pos.y + 75, pos.z + 12),
            function(blockpos, action, calls_remaining, param)
                Everness:emerge_area(blockpos, action, calls_remaining, param)
            end,
            {
                callback = function()
                    -- Place sequoia tree
                    minetest.place_schematic(
                        pos,
                        sequoia_tree_schem,
                        'random',
                        nil,
                        true,
                        'place_center_x, place_center_z'
                    )

                    -- Fix lighting
                    minetest.fix_light(
                        { x = pos.x - 12, y = pos.y, z = pos.z - 12},
                        { x = pos.x + 12, y = pos.y + 75, z = pos.z + 12},
                        true
                    )
                end
            }
        )
    end,
})

--
-- Underground Mese Tree
--

local mese_tree_schem = minetest.get_modpath('everness') .. '/schematics/everness_mese_tree.mts'

abdecor.register_advanced_decoration('everness_mese_tree_underground',{
    target = {
        place_on = 'everness:moss_block',
        sidelen = 80,
        fill_ratio = 0.0000125,
        y_max = -300,
        y_min = -31000,
        biomes = asuna.features.cave.bamboo,
        flags = 'all_floors',
    },
    fn = function(mapgen)
        -- Get provided values
        local pos = mapgen.pos
        local va = mapgen.voxelarea
        local vdata = mapgen.data
        local ystride = va.ystride
        local zstride = va.zstride

        -- Check that there is likely enough space to place a tree
        local vpos = va:index(pos.x,pos.y,pos.z)
        for i = 2, 10 do -- y
            if vdata[vpos + ystride * i] ~= minetest.CONTENT_AIR then
                return -- not enough ceiling clearance
            end
        end
        vpos = vpos + ystride * 5
        for i = -3, 3 do -- x
            if vdata[vpos + i] ~= minetest.CONTENT_AIR then
                return -- not enough space in the x dimension
            end
        end
        for i = -3, 3 do -- z
            if vdata[vpos + i * zstride] ~= minetest.CONTENT_AIR then
                return -- not enough space in the z dimension
            end
        end

        -- Roughly enough space, place a mese tree
        mapgen.place_schematic({
            pos = pos,
            schematic = mese_tree_schem,
            flags = 'place_center_x,place_center_z',
        })

        -- Fix lighting
        mapgen.calc_lighting(
            { x = pos.x - 3, y = pos.y, z = pos.z - 3 },
            { x = pos.x + 3, y = pos.y + 10, z = pos.z + 3 },
            true
        )
    end,
    flags = {
        schematic = true,
    }
})
