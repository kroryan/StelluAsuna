local mod_name = core.get_current_modname()

-------------------------------------------------------------------------------
--Limits
-------------------------------------------------------------------------------

local overworld_ymin = -32
local overworld_ymax = 128

local cavefish_ymin = tonumber(
    core.settings:get("dfcaverns_sunless_sea_min") or -2512)
local cavefish_ymax = overworld_ymin

local mushroom_ymin = tonumber(
    core.settings:get("dfcaverns_sunless_sea_min") or -2512)
local mushroom_ymax = tonumber(
    core.settings:get("dfcaverns_ymax") or -193)

local primordial_ymin = tonumber(
    core.settings:get("dfcaverns_primordial_min") or -4032)
local primordial_ymax = tonumber(
    core.settings:get("dfcaverns_primordial_max") or -3393)

-------------------------------------------------------------------------------
--Fish
-------------------------------------------------------------------------------

simple_fishing.register_fish({
    name = mod_name .. ":raw_river_fish",
    y_min = overworld_ymin,
    y_max = overworld_ymax,
})

simple_fishing.register_fish({
    name = mod_name .. ":raw_red_fish",
    y_min = overworld_ymin,
    y_max = overworld_ymax,
})

simple_fishing.register_fish({
    name = mod_name .. ":raw_cave_fish",
    y_min = cavefish_ymin,
    y_max = cavefish_ymax,
})

if core.get_modpath("df_caverns") then
    simple_fishing.register_fish({
        name = mod_name .. ":raw_mushroom_fish",
        y_min = mushroom_ymin,
        y_max = mushroom_ymax,
    })

    simple_fishing.register_fish({
        name = mod_name .. ":raw_primordial_fish",
        y_min = primordial_ymin,
        y_max = primordial_ymax,
    })
end
