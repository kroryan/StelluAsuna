minetest.register_abm({
	label = "chemistry:radon decay",
	nodenames = {"chemistry:radon"},
	interval = 10.0,
	chance = 12,
	catch_up = true,
	action = function(pos, node)
      minetest.set_node(pos, {name="air"})
   end,
})

