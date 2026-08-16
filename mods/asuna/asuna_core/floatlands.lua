-- Set floatlands config
if asuna.content.stratosphere.floatlands then
  minetest.set_mapgen_setting("mgv7_spflags","mountains,ridges,caverns,floatlands",true)
  minetest.set_mapgen_setting("mgv7_floatland_ymin",287,true)
  minetest.set_mapgen_setting("mgv7_floatland_ymax",28000,true)
  minetest.set_mapgen_setting("mgv7_floatland_taper",-32,true)
  minetest.set_mapgen_setting("mgv7_float_taper_exp",2,true)
  minetest.set_mapgen_setting("mgv7_floatland_density",-1.111,true)
  minetest.set_mapgen_setting("mgv7_floatland_ywater",-31000,true)
  minetest.set_mapgen_setting_noiseparams("mgv7_np_floatland",{
    flags = "defaults,eased",
    lacunarity = 1.6275,
    persistence = 0.9,
    seed = 1009,
    spread = {
      x = 180,
      y = 71,
      z = 180,
    },
    scale = 0.575,
    octaves = 4,
    offset = 0.25,
  },true)
else
  minetest.set_mapgen_setting("mgv7_spflags","mountains,ridges,caverns,nofloatlands",true)
end