local mod_name = core.get_current_modname()

-------------------------------------------------------------------------------
--Lists
-------------------------------------------------------------------------------

local overworld = {
    "default:cactus",
    "default:large_cactus_seedling",
    "default:papyrus",
    "default:junglegrass",
    "default:blueberry_bush_sapling",
    "default:sapling",
    "default:junglesapling",
    "default:pine_sapling",
    "default:acacia_sapling",
    "default:aspen_sapling",
    "farming:cotton",
    "flowers:mushroom_red",
    "flowers:mushroom_brown",
    "flowers:waterlily",
}

local underground = {
    "farming:string",
    "default:pick_stone",
    "default:pick_bronze",
    "default:shovel_stone",
    "default:shovel_bronze",
    "default:axe_stone",
    "default:axe_bronze",
    "default:sword_stone",
    "default:sword_bronze",
    "default:coal_lump",
    "default:stick",
    "default:flint",
}

local moretrees = {
    "moretrees:acorn",
    "moretrees:cedar_cone",
    "moretrees:fir_cone",
    "moretrees:spruce_cone",
    "moretrees:rubber_tree_sapling",
    "moretrees:sequoia_sapling",
    "moretrees:spruce_sapling",
    "moretrees:willow_sapling",
    "moretrees:poplar_sapling",
    "moretrees:palm_sapling",
    "moretrees:oak_sapling",
    "moretrees:fir_sapling",
    "moretrees:date_palm_sapling",
    "moretrees:apple_tree_sapling",
    "moretrees:birch_sapling",
    "moretrees:cedar_sapling",
    "moretrees:beech_sapling",
}

local armor_overworld = {
    "3d_armor:helmet_wood",
    "3d_armor:chestplate_wood",
    "3d_armor:leggings_wood",
    "3d_armor:boots_wood",
    "3d_armor:helmet_cactus",
    "3d_armor:chestplate_cactus",
    "3d_armor:leggings_cactus",
    "3d_armor:boots_cactus",
}

local armor_underground = {
    "3d_armor:helmet_bronze",
    "3d_armor:chestplate_bronze",
    "3d_armor:leggings_bronze",
    "3d_armor:boots_bronze",
}

local shields_overworld = {
    "shields:shield_wood",
    "shields:shield_enhanced_wood",
    "shields:shield_cactus",
    "shields:shield_enhanced_cactus",
}

local shields_underground = {
    "shields:shield_bronze",
}

-------------------------------------------------------------------------------
--Registrations
-------------------------------------------------------------------------------

for _,v in pairs(overworld) do
    simple_fishing.register_treasure({
        name = v,
        y_min = -32,
        y_max = 128,
    })
end

for _,v in pairs(underground) do
    simple_fishing.register_treasure({
        name = v,
        y_min = -31000,
        y_max = -32,
    })
end

if core.get_modpath("moretrees") then
    for _,v in pairs(moretrees) do
        simple_fishing.register_treasure({
            name = v,
            y_min = -32,
            y_max = 128,
        })
    end
end

if core.get_modpath("3d_armor") then
    for _,v in pairs(armor_overworld) do
        simple_fishing.register_treasure({
            name = v,
            y_min = -32,
            y_max = 128,
        })
    end

    for _,v in pairs(armor_underground) do
        simple_fishing.register_treasure({
            name = v,
            y_min = -31000,
            y_max = -32,
        })
    end
end

if core.get_modpath("shields") then
    for _,v in pairs(shields_overworld) do
        simple_fishing.register_treasure({
            name = v,
            y_min = -32,
            y_max = 128,
        })
    end

    for _,v in pairs(shields_underground) do
        simple_fishing.register_treasure({
            name = v,
            y_min = -31000,
            y_max = -32,
        })
    end
end
