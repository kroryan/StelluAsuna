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

---ICE FISHING
local icefishing = {
    drops = {
        treasure = {
            "default:mese_crystal",
            "default:diamond",
            "x_farming:diamond_angler",
            "x_farming:goldfish",
            "x_farming:true_goldfish",
            "x_farming:rusty_skullfin",
            "x_farming:slimefish",
            "x_farming:illager_ghostfish",
            "x_farming:father_sun",
            "x_farming:mother_moon",
        },
        tier_1 = {
            "default:stick",
            "default:wood",
            "default:coral_brown",
            "default:coral_orange",
            "default:coral_skeleton",
            "bones:bones",
            "default:clay",
            "x_farming:sea_cucumber",
            "default:sand_with_kelp"
        },
        tier_2 = {
            "x_farming:shrimp",
            "x_farming:anchovy",
            "x_farming:albacore",
            "x_farming:black_seashroom",
            "x_farming:blue_seashroom",
            "x_farming:brown_seashroom",
            "x_farming:cyan_seashroom",
            "x_farming:gray_seashroom",
            "x_farming:light_gray_seashroom",
            "x_farming:green_seashroom",
            "x_farming:lime_seashroom",
            "x_farming:magenta_seashroom",
            "x_farming:orange_seashroom",
            "x_farming:pink_seashroom",
            "x_farming:purple_seashroom",
            "x_farming:red_seashroom",
            "x_farming:white_seashroom",
            "x_farming:yellow_seashroom",
            "default:sand_with_kelp"
        },
        tier_3 = {
            "x_farming:goldeye",
            "x_farming:halibut",
            "x_farming:herring",
            "x_farming:ironfish",
            "x_farming:pearlwog",
            "x_farming:blobfish",
            "x_farming:tancho_koi",
            "x_farming:pike",
        },
        tier_4 = {
            "x_farming:red_mullet",
            "x_farming:rainbow_trout",
            "x_farming:crab",
            "x_farming:lobster",
            "x_farming:stingray",
            "x_farming:tilapia",
            "x_farming:obster",
            "x_farming:totemfish",
        }
    },
    biomes = {
        ["icesheet_ocean"] = {
            "x_farming:angler",
            "x_farming:frozen_boneminnow",
            "x_farming:frozen_ocean_hermit_crab",
            "x_farming:paddlefish",
            "x_farming:pearl_isopod",
        },
        ["taiga_ocean"] = {
            "x_farming:armored_catfish",
            "x_farming:gar",
            "x_farming:giant_moray",
            "x_farming:perch",
            "x_farming:piglish",
        },
        ["desert_ocean"] = {
            "x_farming:arrow_squid",
            "x_farming:desert_frog",
            "x_farming:desert_sunfish",
            "x_farming:piranha",
            "x_farming:prismfish",
            "x_farming:pumpkinseed",
        },
        ["tundra_ocean"] = {
            "x_farming:barracuda",
            "x_farming:flier",
            "x_farming:floral_faefish",
            "x_farming:flounder",
            "x_farming:fourhorn_sculpin",
        },
        ["snowy_grassland_ocean"] = {
            "x_farming:grass_pickerel",
            "x_farming:guppy",
            "x_farming:hagfish",
            "x_farming:rainbowfish",
            "x_farming:red_snapper",
        },
        ["coniferous_forest_ocean"] = {
            "x_farming:bream",
            "x_farming:redbreast_sunfish",
            "x_farming:rockfish",
            "x_farming:rohu",
            "x_farming:rosefish",
        },
        ["grassland_ocean"] = {
            "x_farming:conger",
            "x_farming:sablefish",
            "x_farming:sardine",
            "x_farming:sawfish",
            "x_farming:skate",
            "x_farming:skullfin",
        },
        ["savanna_ocean"] = {
            "x_farming:chorus_snail",
            "x_farming:white_bullhead",
            "x_farming:whitefish",
            "x_farming:wolffish",
            "x_farming:woodskip",
        },
        ["cold_desert_ocean"] = {
            "x_farming:chub",
            "x_farming:cold_ocean_hermit_crab",
            "x_farming:oscar",
            "x_farming:leerfish",
        },
        ["sandstone_desert_ocean"] = {
            "x_farming:clam",
            "x_farming:skykoi",
            "x_farming:smallmouth_bass",
            "x_farming:sterlet",
        },
        ["deciduous_forest_ocean"] = {
            "x_farming:crayfish",
            "x_farming:damselfish",
            "x_farming:danios",
            "x_farming:vampire_squid",
            "x_farming:walleye",
            "x_farming:warm_ocean_hermit_crab",
        },
        ["rainforest_ocean"] = {
            "x_farming:burbot",
            "x_farming:koi",
            "x_farming:lamprey",
            "x_farming:largemouth_bass",
            "x_farming:lava_eel",
            "x_farming:leech",
        },
        ["rainforest_swamp"] = {
            "x_farming:swamp_darter",
            "x_farming:swamp_frog",
            "x_farming:sturgeon",
            "x_farming:sunfish",
            "x_farming:swordfish",
        },
        ["icesheet"] = {
            "x_farming:dwarf_caiman",
            "x_farming:eel",
            "x_farming:electric_eel",
            "x_farming:endray",
            "x_farming:tench",
        },
        ["tundra_beach"] = {
            "x_farming:carp",
            "x_farming:catfish",
            "x_farming:catla",
            "x_farming:ocean_hermit_crab",
            "x_farming:octopus",
        },
        ["savanna_shore"] = {
            "x_farming:angelfish",
            "x_farming:lingcod",
            "x_farming:lukewarm_ocean_hermit_crab",
            "x_farming:magma_slimefish",
            "x_farming:manta_ray",
        },
        ["deciduous_forest_shore"] = {
            "x_farming:congo_tiger_fish",
            "x_farming:convict_cichlid",
            "x_farming:minnow",
            "x_farming:mud_flounder",
            "x_farming:neon_tetra",
        },
    }
}

---how often node timers for plants will tick, +/- some random value
function icefishing.tick(pos)
    core.get_node_timer(pos):start(math.random(166, 286))
end

---how often a growth failure tick is retried (e.g. too dark)
function icefishing.tick_again(pos)
    core.get_node_timer(pos):start(math.random(40, 80))
end

icefishing.on_construct = function(pos)
    local under = { x = pos.x, y = pos.y - 1, z = pos.z }
    local biome_data = core.get_biome_data(under)

    if not biome_data then
        return
    end

    local biome_name = core.get_biome_name(biome_data.biome)

    if not biome_name then
        return
    end

    local meta = core.get_meta(pos)
    meta:set_string("infotext", S("Biome") .. ": "
        .. string.gsub(string.gsub(biome_name, "(_)", " "), "(%a)([%w_']*)", x_farming.tchelper))
end

icefishing.after_destruct = function(pos, oldnode, oldmetadata, digger)
    local max_steps = 9
    local current_step = tonumber(string.reverse(string.reverse(oldnode.name):split("_")[1]))

    ---is a seed
    if not current_step then
        core.add_item(pos, ItemStack("x_farming:seed_icefishing"))
        return
    end

    ---too short for getting a fish or junk (tier_1)
    if current_step < 6 then
        core.add_item(pos, ItemStack("x_farming:seed_icefishing"))
        return
    end

    ---get ice nodes around
    local under = { x = pos.x, y = pos.y - 1, z = pos.z }
    local biome_data = core.get_biome_data(under)

    if not biome_data then
        return
    end

    local biome_name = core.get_biome_name(biome_data.biome)
    local positions = core.find_nodes_in_area_under_air(
        { x = under.x - 1, y = under.y, z = under.z - 1 },
        { x = under.x + 1, y = under.y, z = under.z + 1 },
        { 'default:ice', 'group:ice' }
    )
    ---subtract 1 - not including the node where the icefishing was
    local rarity = 8 - (current_step - 1) * 7 / (max_steps - 1)
    rarity = math.floor(rarity)
    local positions_count = #positions - 1
    local items_to_drop = {}
    local tier = 1

    ---tiers
    if current_step == max_steps then
        if positions_count >= 4 and positions_count < 6 then
            tier = 2
        elseif positions_count >= 6 and positions_count < 8 then
            tier = 3
        elseif positions_count >= 8 then
            tier = 4
        end
    end

    ---initial item to drop
    local tier_items = icefishing.drops["tier_" .. tier]
    local biome_items = icefishing.biomes[biome_name]

    ---add specific biome items
    if biome_items ~= nil and tier == 4 then
        tier_items = x_farming.mergeTables(tier_items, biome_items)
    end

    local tier_item = tier_items[math.random(1, #tier_items)]
    table.insert(items_to_drop, tier_item)

    ---rarity - add extra item from list of items to drop
    if math.random(1, rarity) == 1 then
        local random_item = items_to_drop[math.random(1, #items_to_drop)]

        table.insert(items_to_drop, random_item)
    end

    ---50% chance to drop the ice fishing equipment
    if math.random(1, 2) == 1 then
        table.insert(items_to_drop, "x_farming:seed_icefishing")
    end

    ---treasure chance (10%)
    if math.random(1, 10) == 1 and tier == 4 then
        local random_items = icefishing.drops.treasure
        local random_item = random_items[math.random(1, #random_items)]

        table.insert(items_to_drop, random_item)
    end

    for i, v in ipairs(items_to_drop) do
        local obj = core.add_item(pos, ItemStack(v))

        if obj and core.registered_items[v] then
            if obj then
                obj:set_velocity({
                    x = math.random(-1, 1),
                    y = 2,
                    z = math.random(-1, 1),
            })
            end
        else
            core.log('warning', '[x_farming] Tried to drop non-existing item "' .. dump(v) .. '" ')
        end
    end
end

---Seed placement
icefishing.place_seed = function(itemstack, placer, pointed_thing, plantname)
    local pt = pointed_thing
    ---check if pointing at a node
    if not pt then
        return itemstack
    end
    if pt.type ~= "node" then
        return itemstack
    end

    local under = core.get_node(pt.under)
    local above = core.get_node(pt.above)

    local player_name = placer and placer:get_player_name() or ""

    if core.is_protected(pt.under, player_name) then
        core.record_protection_violation(pt.under, player_name)
        return
    end
    if core.is_protected(pt.above, player_name) then
        core.record_protection_violation(pt.above, player_name)
        return
    end

    ---return if any of the nodes is not registered
    if not core.registered_nodes[under.name] then
        return itemstack
    end
    if not core.registered_nodes[above.name] then
        return itemstack
    end

    ---check if pointing at the top of the node
    if pt.above.y ~= pt.under.y + 1 then
        return itemstack
    end

    ---check if you can replace the node above the pointed node
    if not core.registered_nodes[above.name].buildable_to then
        return itemstack
    end

    ---check if pointing at soil
    if under.name ~= "x_farming:drilled_ice" then
        return itemstack
    end

    ---add the node and remove 1 item from the itemstack
    core.log("action", player_name .. " places node " .. plantname .. " at " ..
        core.pos_to_string(pt.above))
    core.add_node(pt.above, { name = plantname, param2 = 1 })
    icefishing.tick(pt.above)
    if not (creative and creative.is_enabled_for
            and creative.is_enabled_for(player_name)) then
        itemstack:take_item()
    end
    return itemstack
end

icefishing.grow_plant = function(pos, elapsed)
    local node = core.get_node(pos)
    local name = node.name
    local def = core.registered_nodes[name]

    if not def.next_plant then
        ---disable timer for fully grown plant
        return
    end

    ---grow seed
    if core.get_item_group(node.name, "seed") and def.fertility then
        local soil_node = core.get_node_or_nil({ x = pos.x, y = pos.y - 1, z = pos.z })
        if not soil_node then
            icefishing.tick_again(pos)
            return
        end
        ---omitted is a check for light, we assume seeds can germinate in the dark.
        for _, v in pairs(def.fertility) do
            if core.get_item_group(soil_node.name, v) ~= 0 then
                local placenode = { name = def.next_plant }
                if def.place_param2 then
                    placenode.param2 = def.place_param2
                end
                core.swap_node(pos, placenode)
                if core.registered_nodes[def.next_plant].next_plant then
                    icefishing.tick(pos)
                    return
                end
            end
        end

        return
    end

    ---check if on ice
    local below = core.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })
    if below.name ~= "x_farming:drilled_ice" then
        icefishing.tick_again(pos)
        return
    end

    ---check light
    local light = core.get_node_light(pos)
    if not light or light < def.minlight or light > def.maxlight then
        icefishing.tick_again(pos)
        return
    end

    ---grow
    local placenode = { name = def.next_plant }
    if def.place_param2 then
        placenode.param2 = def.place_param2
    end
    core.swap_node(pos, placenode)

    core.add_particlespawner({
        amount = 7,
        time = 3,
        minpos = { x = pos.x - 0.2, y = pos.y - 0.2, z = pos.z - 0.2 },
        maxpos = { x = pos.x + 0.2, y = pos.y - 0.4, z = pos.z + 0.2 },
        minacc = { x = -0.1, y = 0.1, z = -0.1 },
        maxacc = { x = 0.1, y = 0.1, z = 0.1 },
        minexptime = 0.4,
        maxexptime = 0.8,
        minsize = 1.5,
        maxsize = 2,
        texture = 'bubble.png'
    })

    ---new timer needed?
    if core.registered_nodes[def.next_plant].next_plant then
        icefishing.tick(pos)
    end
    return
end

---Items / Harvest

local fishes = {
    { name = "crab", item_eat = 1, item_eat_cooked = 6 },
    { name = "goldeye", item_eat = 1, item_eat_cooked = 3 },
    { name = "halibut", item_eat = 1, item_eat_cooked = 6 },
    { name = "herring", item_eat = 1, item_eat_cooked = 3 },
    { name = "rainbow_trout", item_eat = 1, item_eat_cooked = 6 },
    { name = "red_mullet", item_eat = 1, item_eat_cooked = 6 },
    { name = "shrimp", item_eat = 1, item_eat_cooked = 2 },
    { name = "swamp_frog", item_eat = 1, item_eat_cooked = 2 },
    { name = "swamp_darter", item_eat = 1, item_eat_cooked = 4 },
    { name = "jungle_frog", item_eat = 1, item_eat_cooked = 2 },
    { name = "albacore", item_eat = 1, item_eat_cooked = 4 },
    { name = "anchovy", item_eat = 1, item_eat_cooked = 4 },
    { name = "angelfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "angler", item_eat = 1, item_eat_cooked = 4 },
    { name = "armored_catfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "arrow_squid", item_eat = 1, item_eat_cooked = 8 },
    { name = "barracuda", item_eat = 1, item_eat_cooked = 4 },
    { name = "black_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "blobfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "blue_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "bream", item_eat = 1, item_eat_cooked = 4 },
    { name = "brown_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "burbot", item_eat = 1, item_eat_cooked = 4 },
    { name = "carp", item_eat = 1, item_eat_cooked = 4 },
    { name = "catfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "catla", item_eat = 1, item_eat_cooked = 4 },
    { name = "chorus_snail", item_eat = 1, item_eat_cooked = 2 },
    { name = "chub", item_eat = 1, item_eat_cooked = 4 },
    { name = "clam", item_eat = 1, item_eat_cooked = 2 },
    { name = "cold_ocean_hermit_crab", item_eat = 1, item_eat_cooked = 2 },
    { name = "conger", item_eat = 1, item_eat_cooked = 4 },
    { name = "congo_tiger_fish", item_eat = 1, item_eat_cooked = 4 },
    { name = "convict_cichlid", item_eat = 1, item_eat_cooked = 4 },
    { name = "crayfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "cyan_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "damselfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "danios", item_eat = 1, item_eat_cooked = 4 },
    { name = "desert_frog", item_eat = 1, item_eat_cooked = 2 },
    { name = "desert_sunfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "diamond_angler", item_eat = 1, item_eat_cooked = 8 },
    { name = "dwarf_caiman", item_eat = 1, item_eat_cooked = 4 },
    { name = "eel", item_eat = 1, item_eat_cooked = 4 },
    { name = "electric_eel", item_eat = 1, item_eat_cooked = 4 },
    { name = "endray", item_eat = 1, item_eat_cooked = 5 },
    { name = "father_sun", item_eat = 1, item_eat_cooked = 10 },
    { name = "flier", item_eat = 1, item_eat_cooked = 4 },
    { name = "floral_faefish", item_eat = 1, item_eat_cooked = 4 },
    { name = "flounder", item_eat = 1, item_eat_cooked = 4 },
    { name = "fourhorn_sculpin", item_eat = 1, item_eat_cooked = 4 },
    { name = "frozen_boneminnow", item_eat = 1, item_eat_cooked = 4 },
    { name = "frozen_ocean_hermit_crab", item_eat = 1, item_eat_cooked = 2 },
    { name = "gar", item_eat = 1, item_eat_cooked = 4 },
    { name = "giant_moray", item_eat = 1, item_eat_cooked = 6 },
    { name = "goldfish", item_eat = 1, item_eat_cooked = 8 },
    { name = "grass_pickerel", item_eat = 1, item_eat_cooked = 4 },
    { name = "gray_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "green_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "guppy", item_eat = 1, item_eat_cooked = 4 },
    { name = "hagfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "illager_ghostfish", item_eat = 1, item_eat_cooked = 10 },
    { name = "ironfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "koi", item_eat = 1, item_eat_cooked = 4 },
    { name = "lamprey", item_eat = 1, item_eat_cooked = 4 },
    { name = "largemouth_bass", item_eat = 1, item_eat_cooked = 4 },
    { name = "lava_eel", item_eat = 1, item_eat_cooked = 6 },
    { name = "leech", item_eat = 1, item_eat_cooked = 4 },
    { name = "leerfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "light_gray_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "lime_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "lingcod", item_eat = 1, item_eat_cooked = 4 },
    { name = "lobster", item_eat = 1, item_eat_cooked = 8 },
    { name = "lukewarm_ocean_hermit_crab", item_eat = 1, item_eat_cooked = 2 },
    { name = "magenta_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "magma_slimefish", item_eat = 1, item_eat_cooked = 4 },
    { name = "manta_ray", item_eat = 1, item_eat_cooked = 4 },
    { name = "minnow", item_eat = 1, item_eat_cooked = 4 },
    { name = "mother_moon", item_eat = 1, item_eat_cooked = 10 },
    { name = "mud_flounder", item_eat = 1, item_eat_cooked = 4 },
    { name = "neon_tetra", item_eat = 1, item_eat_cooked = 4 },
    { name = "obster", item_eat = 1, item_eat_cooked = 4 },
    { name = "ocean_hermit_crab", item_eat = 1, item_eat_cooked = 2 },
    { name = "octopus", item_eat = 1, item_eat_cooked = 8 },
    { name = "orange_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "oscar", item_eat = 1, item_eat_cooked = 4 },
    { name = "paddlefish", item_eat = 1, item_eat_cooked = 4 },
    { name = "pearl_isopod", item_eat = 1, item_eat_cooked = 4 },
    { name = "pearlwog", item_eat = 1, item_eat_cooked = 4 },
    { name = "perch", item_eat = 1, item_eat_cooked = 4 },
    { name = "piglish", item_eat = 1, item_eat_cooked = 4 },
    { name = "pike", item_eat = 1, item_eat_cooked = 4 },
    { name = "pink_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "piranha", item_eat = 1, item_eat_cooked = 6 },
    { name = "prismfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "pumpkinseed", item_eat = 1, item_eat_cooked = 4 },
    { name = "purple_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "rainbowfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "red_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "red_snapper", item_eat = 1, item_eat_cooked = 6 },
    { name = "redbreast_sunfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "rockfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "rohu", item_eat = 1, item_eat_cooked = 4 },
    { name = "rosefish", item_eat = 1, item_eat_cooked = 4 },
    { name = "rusty_skullfin", item_eat = 1, item_eat_cooked = 10 },
    { name = "sablefish", item_eat = 1, item_eat_cooked = 4 },
    { name = "sardine", item_eat = 1, item_eat_cooked = 4 },
    { name = "sawfish", item_eat = 1, item_eat_cooked = 5 },
    { name = "sea_cucumber", item_eat = 1, item_eat_cooked = 2 },
    { name = "skate", item_eat = 1, item_eat_cooked = 4 },
    { name = "skullfin", item_eat = 1, item_eat_cooked = 4 },
    { name = "skykoi", item_eat = 1, item_eat_cooked = 4 },
    { name = "slimefish", item_eat = 1, item_eat_cooked = 8 },
    { name = "smallmouth_bass", item_eat = 1, item_eat_cooked = 4 },
    { name = "sterlet", item_eat = 1, item_eat_cooked = 4 },
    { name = "stingray", item_eat = 1, item_eat_cooked = 6 },
    { name = "sturgeon", item_eat = 1, item_eat_cooked = 4 },
    { name = "sunfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "swordfish", item_eat = 1, item_eat_cooked = 6 },
    { name = "tancho_koi", item_eat = 1, item_eat_cooked = 4 },
    { name = "tench", item_eat = 1, item_eat_cooked = 4 },
    { name = "tilapia", item_eat = 1, item_eat_cooked = 4 },
    { name = "totemfish", item_eat = 1, item_eat_cooked = 4 },
    { name = "true_goldfish", item_eat = 1, item_eat_cooked = 10 },
    { name = "vampire_squid", item_eat = 1, item_eat_cooked = 6 },
    { name = "walleye", item_eat = 1, item_eat_cooked = 4 },
    { name = "warm_ocean_hermit_crab", item_eat = 1, item_eat_cooked = 2 },
    { name = "white_bullhead", item_eat = 1, item_eat_cooked = 4 },
    { name = "white_seashroom", item_eat = 1, item_eat_cooked = 3 },
    { name = "whitefish", item_eat = 1, item_eat_cooked = 4 },
    { name = "wolffish", item_eat = 1, item_eat_cooked = 4 },
    { name = "woodskip", item_eat = 1, item_eat_cooked = 4 },
    { name = "yellow_seashroom", item_eat = 1, item_eat_cooked = 3 },
}

for i, def in ipairs(fishes) do
    local name = "x_farming:" .. def.name
    local desc = string.gsub(string.gsub(def.name, "(_)", " "), "(%a)([%w_']*)", x_farming.tchelper)
    local img = "x_farming_fish_" .. def.name .. ".png"

    -- raw
    local raw_fish_def = {
        description = desc .. "\n"
            .. core.colorize(x_farming.colors.brown, S("Hunger") .. ": " .. def.item_eat),
        tiles = { img },
        inventory_image = img,
        wield_image = img .. "^[transformFXR90",
        groups = {
            -- X Farming
            fish = 1,
            -- MCL
            food = 2,
            eatable = 2,
            smoker_cookable = 1
        },
        _mcl_saturation = 0.4
    }

    if core.get_modpath('farming') then
        raw_fish_def.on_use = core.item_eat(def.item_eat)
    end

    if core.get_modpath('mcl_farming') then
        raw_fish_def.on_place = core.item_eat(def.item_eat)
        raw_fish_def.on_secondary_use = core.item_eat(def.item_eat)
    end

    core.register_craftitem(name, raw_fish_def)

    -- hbhunger
    if x_farming.hbhunger and x_farming.hbhunger ~= nil then
        if hbhunger.register_food ~= nil then
            hbhunger.register_food(name, def.item_eat)
        end
    end

    -- hunger_ng
    if x_farming.hunger_ng ~= nil then
        hunger_ng.add_hunger_data(name, { satiates = def.item_eat })
    end

    if def.item_eat_cooked ~= nil then
        -- cooked
        local cooked_fish_def = {
            description = S("Cooked") .. " " .. desc .. "\n"
                .. core.colorize(x_farming.colors.brown, S("Hunger") .. ": "
                .. def.item_eat_cooked),
            tiles = { img },
            inventory_image = img .. '^[colorize:#3B2510:204' ..
                '^(' .. img .. '^[colorize:#FFFFFF:255^[mask:x_farming_cooked_mask.png^[opacity:191)',
            wield_image = img .. '^[transformFXR90^[colorize:#3B2510:204' ..
                '^(' .. img .. '^[colorize:#FFFFFF:255^[mask:x_farming_cooked_mask.png^[opacity:191)',
            groups = {
                -- MCL
                food = 2,
                eatable = 5,
            },
            _mcl_saturation = 6,
        }

        if core.get_modpath('farming') then
            cooked_fish_def.on_use = core.item_eat(def.item_eat_cooked)
        end

        if core.get_modpath('mcl_farming') then
            cooked_fish_def.on_place = core.item_eat(def.item_eat_cooked)
            cooked_fish_def.on_secondary_use = core.item_eat(def.item_eat_cooked)
        end

        core.register_craftitem(name .. "_cooked", cooked_fish_def)

        core.register_craft({
            type = "cooking",
            cooktime = 15,
            output = name .. "_cooked",
            recipe = name
        })

        ---hbhunger
        if x_farming.hbhunger ~= nil then
            if hbhunger.register_food ~= nil then
                hbhunger.register_food(name .. "_cooked", def.item_eat_cooked)
            end
        end

        -- hunger_ng
        if x_farming.hunger_ng ~= nil then
            hunger_ng.add_hunger_data(name .. "_cooked", { satiates = def.item_eat_cooked })
        end
    end
end

---Ice fishing equipment

icefishing.register_equipment = function(name, def)
    local mname = name:split(":")[1]
    local pname = name:split(":")[2]

    ---Register seed
    local lbm_nodes = { mname .. ":seed_" .. pname }

    core.register_node(mname .. ":seed_" .. pname, {
        description = def.description,
        ---top, bottom, sides
        tiles = {
            "x_farming_icefishing_bottom.png",
            "x_farming_icefishing_bottom.png",
            "x_farming_icefishing_right.png",
            "x_farming_icefishing_left.png",
            "x_farming_icefishing_front_0.png",
            "x_farming_icefishing_back_0.png"
        },
        use_texture_alpha = 'clip',
        inventory_image = "x_farming_icefishing_inv.png",
        wield_image = "x_farming_icefishing_inv.png",
        drawtype = "nodebox",
        groups = {
            -- MTG
            seed = 1,
            snappy = 3,
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
        paramtype = "light",
        walkable = false,
        sunlight_propagates = true,
        node_box = {
            type = "fixed",
            fixed = {
                { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
                { -0.5, -0.375, 0, 0.5, 0.5, 0 },
                { 0, -0.375, -0.5, 0, -0.25, 0.5 },
            }
        },
        collision_box = {
            type = "fixed",
            fixed = {
                { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
            },
        },
        fertility = { "ice_fishing" },
        drop = "",
        sounds = x_farming.node_sound_wood_defaults(),
        next_plant = mname .. ":" .. pname .. "_1",
        on_timer = icefishing.grow_plant,
        minlight = 13,
        maxlight = 15,

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

            return icefishing.place_seed(itemstack, placer, pointed_thing, "x_farming:seed_icefishing")
        end,

        on_construct = icefishing.on_construct,
        after_destruct = icefishing.after_destruct,
    })

    ---Register growing steps
    for i = 1, def.steps do
        local next_plant = nil
        local last_step = i == def.steps

        if i < def.steps then
            next_plant = mname .. ":" .. pname .. "_" .. (i + 1)
            lbm_nodes[#lbm_nodes + 1] = mname .. ":" .. pname .. "_" .. i
        end

        local tiles = {
            {
                name = "x_farming_icefishing_top_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
            { name = mname .. "_" .. pname .. "_bottom.png" },
            { name = mname .. "_" .. pname .. "_right.png" },
            { name = mname .. "_" .. pname .. "_left.png" },
            { name = mname .. "_" .. pname .. "_front_" .. i .. ".png" },
            { name = mname .. "_" .. pname .. "_back_" .. i .. ".png" },
        }

        if last_step then
            tiles[1] = {
                name = "x_farming_icefishing_top_animated_9.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            }
        end

        core.register_node(mname .. ":" .. pname .. "_" .. i, {
            drawtype = "nodebox",
            ---Textures of node; +Y, -Y, +X, -X, +Z, -Z
            ---Textures of node; top, bottom, right, left, front, back
            tiles = tiles,
            use_texture_alpha = 'clip',
            paramtype = "light",
            walkable = false,
            buildable_to = true,
            sunlight_propagates = true,
            on_rotate = function(pos, node, user, mode, new_param2)
                return false
            end,
            drop = "",
            node_box = {
                type = "fixed",
                fixed = {
                    { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
                    { -0.5, -0.375, 0, 0.5, 0.5, 0 },
                    { 0, -0.375, -0.5, 0, -0.25, 0.5 },
                }
            },
            collision_box = {
                type = "fixed",
                fixed = {
                    { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
                },
            },
            selection_box = {
                type = "fixed",
                fixed = {
                    { -0.5, -0.5, -0.5, 0.5, -0.375, 0.5 },
                },
            },
            groups = {
                -- MTG
                seed = 1,
                snappy = 3,
                plant = 1,
                attached_node = 1,
                not_in_creative_inventory = 1,
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
            next_plant = next_plant,
            on_timer = icefishing.grow_plant,
            minlight = 13,
            maxlight = 15,

            after_destruct = icefishing.after_destruct,
        })
    end

    ---replacement LBM for pre-nodetimer plants
    core.register_lbm({
        name = mname .. ":start_nodetimer_" .. pname,
        nodenames = lbm_nodes,
        action = function(pos, node)
            icefishing.tick_again(pos)
        end,
    })

    ---Return
    local r = {
        seed = mname .. ":seed_" .. pname
    }
    return r
end

icefishing.register_equipment("x_farming:icefishing", {
    description = S("Ice Fishing (Place on drilled Ice)"),
    steps = 9,
})

---nodes

core.register_node("x_farming:drilled_ice", {
    description = S("Drilled Ice"),
    tiles = {
        { name = "x_farming_ice.png^x_farming_drilled_ice.png", tileable_vertical = false },
        "x_farming_ice.png",
        "x_farming_ice.png",
        "x_farming_ice.png",
        "x_farming_ice.png",
        "x_farming_ice.png",
    },
    paramtype = "light",
    drop = "default:ice",
    groups = {
        -- MTG
        cracky = 3,
        cools_lava = 1,
        not_in_creative_inventory = 1,
        ice_fishing = 1,
        -- MCL
        handy = 1,
        pickaxey = 1,
        building_block = 1,
        ice = 1,
        -- ALL
        slippery = 3
    },
    sounds = x_farming.node_sound_ice_defaults(),
})

---tools

core.register_tool("x_farming:ice_auger", {
    description = S("Ice Auger drills hole in ice for ice fishing."),
    inventory_image = "x_farming_ice_auger.png",
    wield_image = "x_farming_ice_auger.png^[transformR270",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        if not user then
            return
        end

        local pt = pointed_thing
        ---check if pointing at a node
        if not pt then
            return
        end
        if pt.type ~= "node" then
            return
        end

        local uses = 500
        local under = core.get_node(pt.under)
        local p = { x = pt.under.x, y = pt.under.y + 1, z = pt.under.z }
        local above = core.get_node(p)

        ---return if any of the nodes is not registered
        if not core.registered_nodes[under.name] then
            return
        end
        if not core.registered_nodes[above.name] then
            return
        end

        ---check if the node above the pointed thing is air
        if above.name ~= "air" then
            return
        end

        ---check if pointing at soil
        if under.name ~= "default:ice" and core.get_item_group(under.name, 'ice') == 0 then
            return
        end

        if core.is_protected(pt.under, user:get_player_name()) then
            core.record_protection_violation(pt.under, user:get_player_name())
            return
        end

        if core.is_protected(pt.above, user:get_player_name()) then
            core.record_protection_violation(pt.above, user:get_player_name())
            return
        end

        ---turn the node into soil and play sound
        core.set_node(pt.under, { name = "x_farming:drilled_ice" })
        core.sound_play("x_farming_ice_dug", {
            pos = pt.under,
            gain = 0.5,
        }, true)

        core.add_particlespawner({
            amount = 10,
            time = 0.5,
            minpos = { x = pt.above.x - 0.4, y = pt.above.y - 0.4, z = pt.above.z - 0.4 },
            maxpos = { x = pt.above.x + 0.4, y = pt.above.y - 0.5, z = pt.above.z + 0.4 },
            minvel = { x = 0, y = 1, z = 0 },
            maxvel = { x = 0, y = 2, z = 0 },
            minacc = { x = 0, y = -4, z = 0 },
            maxacc = { x = 0, y = -8, z = 0 },
            minexptime = 1,
            maxexptime = 1.5,
            node = { name = "default:snowblock" },
            collisiondetection = true,
            object_collision = true,
        })

        if not (creative and creative.is_enabled_for and creative.is_enabled_for(user:get_player_name())) then
            ---wear tool
            local wdef = itemstack:get_definition()
            itemstack:add_wear(65535 / (uses - 1))
            ---tool break sound
            if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
                core.sound_play(wdef.sound.breaks, { pos = pt.above,
                    gain = 0.5 }, true)
            end
        end

        return itemstack
    end,
    sound = { breaks = "default_tool_breaks" },
})

core.register_craft({
    output = "x_farming:ice_auger",
    recipe = {
        { "group:stick", "default:coalblock", "group:stick" },
        { "", "default:steel_ingot", "" },
        { "", "default:steel_ingot", "" },
    }
})

---crate
x_farming.register_crate('crate_fish_3', {
    description = S('Fish Crate'),
    tiles = { 'x_farming_crate_fish_3.png' },
})

core.register_on_mods_loaded(function()
    local deco_place_on = {}
    local deco_biomes = {}

    -- MTG
    if core.get_modpath('default') then
        table.insert(deco_place_on, 'default:ice')
        table.insert(deco_place_on, 'default:snowblock')
        table.insert(deco_place_on, 'default:snow')
        table.insert(deco_place_on, 'default:dirt_with_snow')
        table.insert(deco_biomes, 'icesheet')
        table.insert(deco_biomes, 'snowy_grassland')
        table.insert(deco_biomes, 'icesheet_ocean')
    end

    -- Everness
    if core.get_modpath('everness') then
        table.insert(deco_place_on, 'everness:frosted_snowblock')
        table.insert(deco_biomes, 'everness:frosted_icesheet')
    end

    -- MCL
    if core.get_modpath('mcl_core') then
        table.insert(deco_place_on, 'mcl_core:snow')
        table.insert(deco_biomes, 'IcePlains')
    end

    if next(deco_place_on) and next(deco_biomes) then
        core.register_decoration({
            name = 'x_farming:icefishing',
            deco_type = 'schematic',
            place_on = deco_place_on,
            sidelen = 16,
            noise_params = {
                offset = 0,
                scale = 0.0025,
                spread = { x = 100, y = 100, z = 100 },
                seed = 2,
                octaves = 3,
                persist = 0.7
            },
            biomes = deco_biomes,
            y_max = 30,
            y_min = 1,
            schematic = core.get_modpath('x_farming') .. '/schematics/x_farming_icefishing.mts',
            flags = 'force_placement',
            rotation = 'random',
        })
    end
end)

