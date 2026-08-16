local mod_name = core.get_current_modname()

simple_fishing.register_fishing_rod({
    name = mod_name .. ":wooden_fishing_rod",
    description = "Wooden Fishing Rod",
    inv_texture = mod_name .. "_wooden_fishing_rod.png",
    wield_texture = mod_name .. "_wooden_fishing_rod.png^[transformFXR270",
    wield_texture_active =
        mod_name .. "_wooden_fishing_rod_active.png^[transformFXR270",
    wield_scale = 1.3,
    sound_use = mod_name .. "_whoosh",
    sound_return = mod_name .. "_whoosh",
    sound_gain = 0.7,
    uses = 64,
    chance = 0.04,
    treasure_chance = 0.1,
    length = 12,
})

simple_fishing.register_fishing_rod({
    name = mod_name .. ":steel_fishing_rod",
    description = "Steel Fishing Rod",
    inv_texture = mod_name .. "_steel_fishing_rod.png",
    wield_texture = mod_name .. "_steel_fishing_rod.png^[transformFXR270",
    wield_texture_active =
        mod_name .. "_steel_fishing_rod_active.png^[transformFXR270",
    wield_scale = 1.3,
    sound_use = mod_name .. "_whoosh",
    sound_return = mod_name .. "_whoosh",
    sound_gain = 0.7,
    uses = 256,
    chance = 0.06,
    treasure_chance = 0.1,
    length = 16,
})

if core.get_modpath("moreores") then
    simple_fishing.register_fishing_rod({
        name = mod_name .. ":mithril_fishing_rod",
        description = "Mithril Fishing Rod",
        inv_texture = mod_name .. "_mithril_fishing_rod.png",
        wield_texture =
            mod_name .. "_mithril_fishing_rod.png^[transformFXR270",
        wield_texture_active =
            mod_name .. "_mithril_fishing_rod_active.png^[transformFXR270",
        wield_scale = 1.3,
        sound_use = mod_name .. "_whoosh",
        sound_return = mod_name .. "_whoosh",
        sound_gain = 0.7,
        uses = 1024,
        chance = 0.08,
        treasure_chance = 0.1,
        length = 24,
    })
end


if core.get_modpath("simple_materials_magic") then
    simple_fishing.register_fishing_rod({
        name = mod_name .. ":meteorite_fishing_rod",
        description = "Meteorite Fishing Rod",
        inv_texture = mod_name .. "_meteorite_fishing_rod.png",
        wield_texture =
            mod_name .. "_meteorite_fishing_rod.png^[transformFXR270",
        wield_texture_active =
            mod_name .. "_meteorite_fishing_rod_active.png^[transformFXR270",
        wield_scale = 1.3,
        sound_use = mod_name .. "_whoosh",
        sound_return = mod_name .. "_whoosh",
        sound_gain = 0.7,
        uses = 512,
        chance = 0.12,
        treasure_chance = 0.2,
        length = 28,
    })
end


if core.get_modpath("simple_materials_technic") then
    simple_fishing.register_fishing_rod({
        name = mod_name .. ":adamantium_fishing_rod",
        description = "Adamantium Fishing Rod",
        inv_texture = mod_name .. "_adamantium_fishing_rod.png",
        wield_texture =
            mod_name .. "_adamantium_fishing_rod.png^[transformFXR270",
        wield_texture_active =
            mod_name .. "_adamantium_fishing_rod_active.png^[transformFXR270",
        wield_scale = 1.3,
        sound_use = mod_name .. "_whoosh",
        sound_return = mod_name .. "_whoosh",
        sound_gain = 0.7,
        uses = 2048,
        chance = 0.1,
        treasure_chance = 0.1,
        length = 32,
    })
end
