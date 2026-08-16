--[[
    X Farming. Extends Luanti farming mod with new plants, crops and ice fishing.
    Copyright (C) 2025 SaKeL

    This library is free software; you can redistribute it and/or
    modify it pos the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]

-- Activate timers on bees which were spawned without starting the timer (bug was fixed in 5d04f7fdc5cb43e7573438a864c3730e05cff608)
core.register_lbm({
    -- Descriptive label for profiling purposes (optional).
    -- Definitions with identical labels will be listed as one.
    label = 'x_farming_bee_timers',

    -- Identifier of the LBM, should follow the modname:<whatever> convention
    name = 'x_farming:bee_timers',

    -- List of node names to trigger the LBM on.
    -- Names of non-registered nodes and groups (as group:groupname)
    -- will work as well.
    nodenames = {
        'x_farming:bee',
        'x_farming:lotus_flower_purple',
        'x_farming:lotus_flower_pink'
    },

    -- Function triggered for each qualifying node.
    -- `dtime_s` is the in-game time (in seconds) elapsed since the block
    -- was last active
    action = function(pos, node, dtime_s)
        local timer = core.get_node_timer(pos)

        if not timer:is_started() then
            core.get_node_timer(pos):start(1)
        end
    end
})
