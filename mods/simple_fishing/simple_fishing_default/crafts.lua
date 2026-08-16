local mod_name = core.get_current_modname()

-------------------------------------------------------------------------------
--Fishing rods
-------------------------------------------------------------------------------

core.register_craft({
    output = mod_name .. ":wooden_fishing_rod",
    recipe = {
        {"", "", "default:stick"},
        {"", "default:stick", "farming:string"},
        {"default:stick", "", "default:tin_ingot"},
    },
})

core.register_craft({
    output = mod_name .. ":steel_fishing_rod",
    recipe = {
        {"", "", "default:steel_ingot"},
        {"", "default:steel_ingot", "farming:string"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    },
})

if core.get_modpath("moreores") then
    core.register_craft({
        output = mod_name .. ":mithril_fishing_rod",
        recipe = {
            {"", "", "moreores:mithril_ingot"},
            {"", "moreores:mithril_ingot", "farming:string"},
            {"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
        },
    })
end


if core.get_modpath("simple_materials_magic") then
    core.register_craft({
        output = mod_name .. ":meteorite_fishing_rod",
        recipe = {
            {"", "", "simple_materials_magic:meteorite_ingot"},
            {"", "simple_materials_magic:meteorite_ingot", "farming:string"},
            {
                "simple_materials_magic:meteorite_ingot",
                "",
                "simple_materials_magic:meteorite_ingot"
            },
        },
    })
end


if core.get_modpath("simple_materials_technic") then
    core.register_craft({
        output = mod_name .. ":adamantium_fishing_rod",
        recipe = {
            {"", "", "simple_materials_technic:adamantium_ingot"},
            {
                "",
                "simple_materials_technic:adamantium_ingot",
                "farming:string"
            },
            {
                "simple_materials_technic:adamantium_ingot",
                "",
                "simple_materials_technic:adamantium_ingot"
            },
        },
    })
end

-------------------------------------------------------------------------------
--Fish
-------------------------------------------------------------------------------

local fish_names = {
    "river",
    "cave",
    "red",
}

if core.get_modpath("df_caverns") then
    table.insert(fish_names, "mushroom")
    table.insert(fish_names, "primordial")
end

for _,nm in pairs(fish_names) do
    
    core.register_craft({
        type = "cooking",
        cooktime = 3,
        output = mod_name .. ":fried_" .. nm .. "_fish_steak",
        recipe = mod_name .. ":raw_" .. nm .. "_fish_steak",
    })
    
    core.register_craft({
        type = "cooking",
        cooktime = 1.5,
        output = mod_name .. ":fried_" .. nm .. "_fish_fillet",
        recipe = mod_name .. ":raw_" .. nm .. "_fish_fillet"
    })
    
    core.register_craft({
        type = "shapeless",
        output = mod_name .. ":raw_" .. nm .. "_fish_steak 4",
        recipe = {
            mod_name .. ":raw_" .. nm .. "_fish",
        },
    })
    
    core.register_craft({
        type = "shapeless",
        output = mod_name .. ":raw_" .. nm .. "_fish_fillet 2",
        recipe = {
            mod_name .. ":raw_" .. nm .. "_fish_steak",
        },
    })
    
    core.register_craft({
        type = "shapeless",
        output = mod_name .. ":fried_" .. nm .. "_fish_fillet 2",
        recipe = {
            mod_name .. ":fried_" .. nm .. "_fish_steak",
        },
    })
end
