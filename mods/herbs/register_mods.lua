local modname = herbs.modname
local hb = herbs

if(minetest.get_modpath("hunger_ng")) then
    local add = hunger_ng.add_hunger_data

    for key, value in pairs(hb.mushroomdatas) do
            add(modname .. ":" .. value[1], {satiates = value[4], heal = value[5]})
            minetest.log("action",hb.modname .. " registers " .. modname.. ":" .. value[1] .. " @hunger_ng.")
    end -- for key

end -- if(minetest.get_modname("hunger_ng

if(minetest.get_modpath("techage")) then
    local reg = techage.register_flower

    for key, value in pairs(hb.mushroomdatas) do
        reg(modname .. ":" .. value[1])
        minetest.log("action",hb.modname .. " registers " .. modname.. ":" .. value[1] .. " @techage.")

    end

    for key, value in pairs(hb.flowerdatas) do
        reg(modname .. ":" .. value[1])
        minetest.log("action",hb.modname .. " registers " .. modname..":" .. value[1] .. " @techage.")
    end

end


if(minetest.get_modpath("signs_bot")) then
    local reg = signs_bot.register_flower

    for key, value in pairs(hb.mushroomdatas) do
        reg(modname .. ":" .. value[1])
        minetest.log("action",hb.modname .. " registers " .. modname.. ":" .. value[1] .. " @signs_bot.")

    end

    for key, value in pairs(hb.flowerdatas) do
        reg(modname .. ":" .. value[1])
        minetest.log("action",hb.modname .. " registers " .. modname..":" .. value[1] .. " @signs_bot.")
    end

end

if(minetest.get_modpath("flowerpot")) then
    local reg = flowerpot.register_node

    for key, value in pairs(hb.mushroomdatas) do
        reg(modname .. ":" .. value[1])
        minetest.log("action",hb.modname .. " registers " .. modname..":" .. value[1] .. " @signs_bot.")

    end

    for key, value in pairs(hb.flowerdatas) do
        reg(modname .. ":" .. value[1])
        minetest.log("action",hb.modname .. " registers " .. modname..":" .. value[1] .. " @signs_bot.")

    end

end

if(minetest.get_modpath("technic")) then
    local extractor_recipes = {
        {"campanula_blue", "dye:blue"},
        {"trifolium_red", "dye:violet"},
        {"trifolium_white", "dye:green"},
        {"centaurea", "dye:blue"},
        {"anagallis_yellow", "dye:yellow"},
        {"leucanthemum_white", "dye:white"},
        {"leontopodium_white", "dye:grey"},
        {"papaver_red", "dye:red"},
        {"antirrhinum", "dye:pink"},
        {"drosera", "dye:red"},
        {"digitalis_blue", "dye:blue"},
        {"digitalis_yellow", "dye:yellow"},
        {"achillea_white", "dye:white"},
    }

    for _,value in pairs(extractor_recipes) do
        technic.register_extractor_recipe({input = {"herbs:" .. value[1]}, output = value[2] .. " 4"})

    end -- for _,value

end -- if(technic)
