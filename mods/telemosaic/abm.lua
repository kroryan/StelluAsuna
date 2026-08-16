
minetest.register_abm({
	label = "Telemosaic beacon effect",
	nodenames = {"group:telemosaic_active"},
	interval = 2.0,
	chance = 2,
	catch_up = false,
	action = function(pos)
		minetest.add_particlespawner({
			amount = 4,
			time = 2,
			minpos = vector.add(pos, {x=-0.2, y=0, z=-0.2}),
			maxpos = vector.add(pos, {x=0.2, y=0, z=0.2}),
			minvel = {x=0, y=1, z=0},
			maxvel = {x=0, y=2, z=0},
			maxexptime = 2,
			maxsize = 1.7,
			texture = "telemosaic_particle_arrival.png",
			glow = 9
		})
	end
})
