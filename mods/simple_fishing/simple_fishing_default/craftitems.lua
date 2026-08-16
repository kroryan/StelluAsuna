local mod_name = core.get_current_modname()

local fish_names = {}

fish_names["River"] = 2
fish_names["Cave"] = 2
fish_names["Red"] = 3

if core.get_modpath("df_caverns") then
    fish_names["Mushroom"] = 4
    fish_names["Primordial"] = 4
end

for k,v in pairs(fish_names) do

    local nm = string.lower(k)

    core.register_craftitem(mod_name .. ":raw_" .. nm .. "_fish", {
        description = "Raw " .. k .. " Fish",
        inventory_image = mod_name .. "_raw_" .. nm .. "_fish.png",
    })

    core.register_craftitem(mod_name .. ":raw_" .. nm .. "_fish_fillet", {
        description = "Raw " .. k .. " Fish Fillet",
        inventory_image = mod_name .. "_raw_" .. nm .. "_fish_fillet.png",
    })
    
    core.register_craftitem(mod_name .. ":raw_" .. nm .. "_fish_steak", {
        description = "Raw " .. k .. " Fish Steak",
        inventory_image = mod_name .. "_raw_" .. nm .. "_fish_steak.png",
    })
    
    core.register_craftitem(mod_name .. ":fried_" .. nm .. "_fish_fillet", {
        description = "Fried " .. k .. " Fish Fillet",
        inventory_image = mod_name .. "_fried_" .. nm .. "_fish_fillet.png",
        on_use = core.item_eat(v/2),
    })
    
    core.register_craftitem(mod_name .. ":fried_" .. nm .. "_fish_steak", {
        description = "Fried " .. k .. " Fish Steak",
        inventory_image = mod_name .. "_fried_" .. nm .. "_fish_steak.png",
        on_use = core.item_eat(v),
    })
    
end
