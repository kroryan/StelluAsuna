
if chemistry.config.node_particles == "All" then
	minetest.register_abm({
		label = "chemistry:liquid nitrogen vaporation",
		nodenames = {"group:freezer"},
		neighbors = {"air"},
		interval = 2.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then

	      	minetest.add_particlespawner({
	      		amount = 2,
			      time = 1,
	      		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
		      	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
			      minvel = {x = 0.2, y = 0.2, z = 0.2},
	      		maxvel = {x = 0.4, y = 0.8, z = 0.4},
		      	minacc = {x = -0.2, y = 0, z = -0.2},
	      		maxacc = {x = 0.2, y = 0.1, z = 0.2},
		      	minexptime = 2,
		      	maxexptime = 2,
	      		minsize = 1,
		      	maxsize = 3,
	      		collisiondetection = true,
	      		vertical = false,
	      		texture = "default_item_smoke.png"
	      	})
			end	
		end,
	})

minetest.register_abm({
	label = "chemistry:air pollution",
	nodenames = {"group:fire"},
	neighbors = {"group:flammable", "group:anthracite_material"},
	interval = 2.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, "air") then

	   	minetest.add_particlespawner({
      		amount = 2,
		      time = 1,
      		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
	      	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
			   minvel = {x = 0.2, y = 0.2, z = 0.2},
	      	maxvel = {x = 0.4, y = 0.8, z = 0.4},
		      minacc = {x = -0.2, y = 0, z = -0.2},
	      	maxacc = {x = 0.2, y = 0.1, z = 0.2},
		      minexptime = 5,
		      maxexptime = 5,
	      	minsize = 10,
		      maxsize = 5,
	      	collisiondetection = true,
	      	vertical = false,
	      	texture = "tnt_smoke.png"
	      })
		end	
	end,
})

minetest.register_abm({
	label = "chemistry:air pollution",
	nodenames = {"group:fire"},
	neighbors = {"group:air_pollutioner"},
	interval = 2.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, "air") then

	   	minetest.add_particlespawner({
      		amount = 2,
		      time = 1,
      		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
	      	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
			   minvel = {x = 0.2, y = 0.2, z = 0.2},
	      	maxvel = {x = 0.4, y = 0.8, z = 0.4},
		      minacc = {x = -0.2, y = 0, z = -0.2},
	      	maxacc = {x = 0.2, y = 0.1, z = 0.2},
		      minexptime = 5,
		      maxexptime = 5,
	      	minsize = 10,
		      maxsize = 5,
	      	collisiondetection = true,
	      	vertical = false,
	      	texture = "default_item_smoke.png^[colorize:#000:122"
	      })
		end	
	end,
})

minetest.register_abm({
	label = "chemistry:air pollution",
	nodenames = {"chemistry:white_phosphorus"},
	neighbors = {"air", "group:igniter"},
	interval = 2.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, "air") then

	   	minetest.add_particlespawner({
      		amount = 2,
		      time = 1,
      		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
	      	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
			   minvel = {x = 0.2, y = 0.2, z = 0.2},
	      	maxvel = {x = 0.4, y = 0.8, z = 0.4},
		      minacc = {x = -0.2, y = 0, z = -0.2},
	      	maxacc = {x = 0.2, y = 0.1, z = 0.2},
		      minexptime = 5,
		      maxexptime = 5,
	      	minsize = 10,
		      maxsize = 5,
	      	collisiondetection = true,
	      	vertical = false,
	      	texture = "default_item_smoke.png"
	      })
		end	
	end,
})

minetest.register_abm({
	label = "chemistry:thermite_particles",
	nodenames = {"group:hot_thermite"},
	neighbors = {"air"},
	interval = 2.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)

    	local thermite_particles = {
    		amount = 5,
     		time = 1,
    		minpos = {x=pos.x - 0.5, y=pos.y + 0.3, z=pos.z - 0.5},
    		maxpos = {x=pos.x + 0.5, y=pos.y + 0.5, z=pos.z + 0.5},
    		minvel = {x = -1.5, y = 1.5, z = -1.5},
    		maxvel = {x =  1.5, y = 5,   z =  1.5},
    		minacc = {x = 0, y = -10, z = 0},
    		maxacc = {x = 0, y = -10, z = 0},
    		minexptime = 1,
    		maxexptime = 1,
	    	minsize = .2,
    		maxsize = .8,
    		texture = "blank.png^[noalpha^[colorize:#FC0:255",
    		glow = 8
    	}
    	minetest.add_particlespawner(thermite_particles)
	end
})

elseif chemistry.config.node_particles == "Decreased" then
	minetest.register_abm({
		label = "chemistry:liquid nitrogen vaporation",
		nodenames = {"group:freezer"},
		neighbors = {"air"},
		interval = 2.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then

	      	minetest.add_particlespawner({
	      		amount = 1,
			      time = 1,
	      		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
		      	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
			      minvel = {x = 0.2, y = 0.2, z = 0.2},
	      		maxvel = {x = 0.4, y = 0.8, z = 0.4},
		      	minacc = {x = -0.2, y = 0, z = -0.2},
	      		maxacc = {x = 0.2, y = 0.1, z = 0.2},
		      	minexptime = 2,
		      	maxexptime = 2,
	      		minsize = 1,
		      	maxsize = 3,
	      		collisiondetection = true,
	      		vertical = false,
	      		texture = "default_item_smoke.png"
	      	})
			end	
		end,
	})

minetest.register_abm({
	label = "chemistry:air pollution",
	nodenames = {"group:fire"},
	neighbors = {"group:flammable", "group:anthracite_material"},
	interval = 3.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, "air") then

	   	minetest.add_particlespawner({
			amount = 1,
      		time = 1,
	   		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
 		  	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
				minvel = {x = 0.2, y = 0.2, z = 0.2},
   	   	maxvel = {x = 0.4, y = 0.8, z = 0.4},
	 		  minacc = {x = -0.2, y = 0, z = -0.2},
		   	maxacc = {x = 0.2, y = 0.1, z = 0.2},
			   minexptime = 5,
		      maxexptime = 5,
		   	minsize = 7,
		      maxsize = 5,
		   	collisiondetection = true,
         	vertical = false,
	      	texture = "tnt_smoke.png"
		   })
		end	
	end,
})

minetest.register_abm({
	label = "chemistry:air pollution",
	nodenames = {"group:fire"},
	neighbors = {"group:air_pollutioner"},
	interval = 3.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, "air") then

	   	minetest.add_particlespawner({
      		amount = 1,
		      time = 1,
      		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
	      	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
			   minvel = {x = 0.2, y = 0.2, z = 0.2},
	      	maxvel = {x = 0.4, y = 0.8, z = 0.4},
		      minacc = {x = -0.2, y = 0, z = -0.2},
	      	maxacc = {x = 0.2, y = 0.1, z = 0.2},
		      minexptime = 5,
		      maxexptime = 5,
	      	minsize = 10,
		      maxsize = 5,
	      	collisiondetection = true,
	      	vertical = false,
	      	texture = "default_item_smoke.png^[colorize:#000:122"
	      })
		end	
	end,
})
minetest.register_abm({
	label = "chemistry:air pollution",
	nodenames = {"chemistry:white_phosphorus"},
	neighbors = {"air", "group:igniter"},
	interval = 3.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, "air") then

	   	minetest.add_particlespawner({
      		amount = 1,
		      time = 1,
      		minpos = {x = pos.x - 1, y = pos.y + 0.5, z = pos.z - 1},
	      	maxpos = {x = pos.x + 1, y = pos.y + 0.5, z = pos.z + 1},
			   minvel = {x = 0.2, y = 0.2, z = 0.2},
	      	maxvel = {x = 0.4, y = 0.8, z = 0.4},
		      minacc = {x = -0.2, y = 0, z = -0.2},
	      	maxacc = {x = 0.2, y = 0.1, z = 0.2},
		      minexptime = 5,
		      maxexptime = 5,
	      	minsize = 7,
		      maxsize = 5,
	      	collisiondetection = true,
	      	vertical = false,
	      	texture = "default_item_smoke.png"
	      })
		end	
	end,
})

minetest.register_abm({
	label = "chemistry:thermite_particles",
	nodenames = {"group:hot_thermite"},
	neighbors = {"air"},
	interval = 2.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)

    	local thermite_particles = {
    		amount = 2,
     		time = 1,
    		minpos = {x=pos.x - 0.5, y=pos.y + 0.3, z=pos.z - 0.5},
    		maxpos = {x=pos.x + 0.5, y=pos.y + 0.5, z=pos.z + 0.5},
    		minvel = {x = -1.5, y = 1.5, z = -1.5},
    		maxvel = {x =  1.5, y = 5,   z =  1.5},
    		minacc = {x = 0, y = -10, z = 0},
    		maxacc = {x = 0, y = -10, z = 0},
    		minexptime = 1,
    		maxexptime = 1,
	    	minsize = .2,
    		maxsize = .8,
    		texture = "blank.png^[noalpha^[colorize:#FC0:255",
    		glow = 8
    	}
    	minetest.add_particlespawner(thermite_particles)
	end
	})
end