local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

chemistry = {version = 1.9, fix = 1}
chemistry.config = {}
chemistry.config.allow_corrosion = minetest.settings:get_bool("chemistry_allow_corrosion", true)
chemistry.config.allow_intoxication = minetest.settings:get_bool("chemistry_allow_intoxication", true)
chemistry.config.allow_alkali_reaction = minetest.settings:get_bool("chemistry_allow_alkali_reaction", true)
chemistry.config.enable_nuke = minetest.settings:get_bool("chemistry_enable_nuke", true)
chemistry.config.allow_node_melt = minetest.settings:get_bool("chemistry_allow_st_lava_melt", true)
chemistry.config.allow_explosive_nodes = minetest.settings:get_bool("chemistry_allow_explosive_nodes", true)
chemistry.config.node_particles = minetest.settings:get("chemistry_node_particles") or "All"
chemistry.config.enable_corrosion_protection = minetest.settings:get_bool("chemistry_enable_corrosion_protection", true)


chemistry.getter = core.get_translator("chemistry")

dofile(path.."sounds.lua")
dofile(path.."halogens.lua")
dofile(path.."alkali_metals.lua")
dofile(path.."gases.lua")
dofile(path.."others.lua")
dofile(path.."thermite.lua")
dofile(path.."crop_withering.lua")
if chemistry.config.allow_corrosion then
   dofile(path.."corrosion.lua")
end
dofile(path.."acids.lua")
dofile(path.."glow_water.lua")
dofile(path.."hydrocarbons.lua")
dofile(path.."fuel_flammability.lua")
dofile(path.."mapgen.lua")
dofile(path.."minerals.lua")
if chemistry.config.node_particles ~= "None" then
   dofile(path.."particle_gen.lua")
end
dofile(path.."reactives.lua")
dofile(path.."freezing.lua")
dofile(path.."torches.lua")
dofile(path.."alternate_tools.lua")
dofile(path.."tools.lua")
dofile(path.."molten_metals.lua")
dofile(path.."schems.lua")
dofile(path.."strong_lava.lua")
if minetest.get_modpath("3d_armor") then
   dofile(path.."armor.lua")
end
if minetest.get_modpath("bonemeal") then
   dofile(path.."bonemeal.lua")
end
dofile(path.."toxic_elements.lua")
if minetest.get_modpath("technic") then
   dofile(path.."half-life.lua")
   dofile(path.."radioactive.lua")
   if chemistry.config.enable_nuke then
      dofile(path.."nuke.lua")
   end
   dofile(path.."detectors.lua")
   dofile(path.."machines/init.lua")
   dofile(path.."technic_exclusive.lua")
end
dofile(path.."weather.lua")
