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

local mod_start_time = core.get_us_time()
local path = core.get_modpath('x_farming')

-- Legacy backwards compatibility
core.register_alias('x_farming:hog_stew', 'x_farming:fish_stew')

-- MineClone2 support
if core.get_modpath('mcl_core') and core.global_exists('mcl_core') then
    dofile(path .. '/mod_support_mcl_aliases.lua')
end

dofile(path .. '/api.lua')
dofile(path .. '/craftitems.lua')
dofile(path .. '/nodes.lua')
dofile(path .. '/functions.lua')

dofile(path .. '/melon.lua')
dofile(path .. '/pumpkin.lua')
dofile(path .. '/coffee.lua')
dofile(path .. '/corn.lua')
dofile(path .. '/obsidian_wart.lua')
dofile(path .. '/potato.lua')
dofile(path .. '/beetroot.lua')
dofile(path .. '/carrot.lua')
dofile(path .. '/cocoa.lua')
dofile(path .. '/seeds.lua')
dofile(path .. '/kiwi_tree.lua')
dofile(path .. '/cactus.lua')
dofile(path .. '/strawberry.lua')
dofile(path .. '/pine_nut.lua')
dofile(path .. '/christmas_tree.lua')
dofile(path .. '/stevia.lua')
dofile(path .. '/soybean.lua')
dofile(path .. '/salt.lua')
dofile(path .. '/cotton.lua')
dofile(path .. '/barley.lua')
dofile(path .. '/bees.lua')
dofile(path .. '/ropes.lua')
dofile(path .. '/rice.lua')
dofile(path .. '/stove.lua')

dofile(path .. '/tools.lua')
dofile(path .. '/hoes.lua')

dofile(path .. '/ice_fishing.lua')
dofile(path .. '/bonemeal.lua')
dofile(path .. '/crates.lua')
dofile(path .. '/bags.lua')
dofile(path .. '/composter.lua')
dofile(path .. '/crafting.lua')

if not x_farming.vessels then
    dofile(path .. '/vessels.lua')
end

---timer for crates
core.register_lbm({
    label = 'x_farming timer for crates',
    name = 'x_farming:start_nodetimer_crates',
    nodenames = x_farming.lbm_nodenames_crates,
    action = function(pos, node)
        x_farming.tick_again_crates(pos)
    end
})

-- MOD support

if core.get_modpath('default') then
    dofile(path .. '/mod_support_default.lua')
end

-- hbhunger
if x_farming.hbhunger ~= nil then
    if hbhunger.register_food ~= nil then
        dofile(path .. '/mod_support_hbhunger.lua')
    end
end

-- hunger_ng
if x_farming.hunger_ng then
    dofile(path .. '/mod_support_hunger_ng.lua')
end

-- candles_3d
if core.get_modpath('candles_3d') then
    dofile(path .. '/mod_support_candles_3d.lua')
end

local mod_end_time = (core.get_us_time() - mod_start_time) / 1000000

print('[Mod] x_farming loaded.. [' .. mod_end_time .. 's]')
