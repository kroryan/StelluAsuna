
local S = chemistry.getter

local nuke_boom = {
	name = "nuke_boom",
	--description = "explosion caused by nuclear compound",
	radius = 20,
	tiles = {
		side = "invisible.png",
		top = "invisible.png",
		bottom = "invisible.png",
		burning = "invisible.png"
	},
}

		minetest.register_node("chemistry:nuke", {
			description = S("Nuclear Bomb"),
			tiles = {"nuke_top.png", "nuke_bottom.png", "nuke_side.png"},
			is_ground_content = false,
			groups = {dig_immediate = 2, mesecon = 2, tnt = 1, flammable = 5},
			sounds = default.node_sound_wood_defaults(),
			after_place_node = function(pos, placer)
				if placer and placer:is_player() then
					local meta = minetest.get_meta(pos)
					meta:set_string("owner", placer:get_player_name())
				end
			end,
			on_punch = function(pos, node, puncher)
				if puncher:get_wielded_item():get_name() == "default:torch" then
					minetest.swap_node(pos, {name ="chemistry:nuke_burning"})
					minetest.registered_nodes["chemistry:nuke_burning"].on_construct(pos)
					default.log_player_action(puncher, "ignites", node.name, "at", pos)
				end
			end,
			on_blast = function(pos, intensity)
				minetest.after(0.1, function()
					tnt.boom(pos, nuke_boom)
					if chemistry.config.node_particles == "All" then
						minetest.add_particlespawner({
							amount = 250,
							time = 20,
							minpos = {x=pos.x-1, y=pos.y-23, z=pos.z-1},
							maxpos = {x=pos.x+1, y=pos.y+12, z=pos.z+1},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
							minetest.add_particlespawner({
							amount = 1500,
							time = 20,
							minpos = {x=pos.x-13, y=pos.y+11, z=pos.z-13},
							maxpos = {x=pos.x+13, y=pos.y+14, z=pos.z+13},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
						minetest.add_particlespawner({
							amount = 25,
							time = 20,
							minpos = {x=-1, y=-23, z=-1},
							maxpos = {x=1, y=11, z=1},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
							minetest.add_particlespawner({
							amount = 150,
							time = 20,
							minpos = {x=-13, y=7, z=-13},
							maxpos = {x=13, y=8, z=13},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
					elseif chemistry.config.node_particles == "Decreased" then
						minetest.add_particlespawner({
							amount = 125,
							time = 20,
							minpos = {x=pos.x-1, y=pos.y-23, z=pos.z-1},
							maxpos = {x=pos.x+1, y=pos.y+12, z=pos.z+1},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
							minetest.add_particlespawner({
							amount = 750,
							time = 20,
							minpos = {x=pos.x-13, y=pos.y+11, z=pos.z-13},
							maxpos = {x=pos.x+13, y=pos.y+14, z=pos.z+13},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
						minetest.add_particlespawner({
							amount = 12,
							time = 20,
							minpos = {x=-1, y=-23, z=-1},
							maxpos = {x=1, y=11, z=1},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
							minetest.add_particlespawner({
							amount = 75,
							time = 20,
							minpos = {x=-13, y=7, z=-13},
							maxpos = {x=13, y=8, z=13},
							minvel = {x=-1, y=-1, z=-1},
							maxvel = {x=1,  y=1,  z=1},
							minexptime = 54,
							maxexptime = 62,
							minsize = 25,
							maxsize = 25,
							texture = "nuke_smoke.png",
						})
					end
				end)
			end,
			mesecons = {effector =
				{action_on =
					function(pos)
						tnt.boom(pos, nuke_boom)
						if chemistry.config.node_particles == "All" then
							minetest.add_particlespawner({
								amount = 250,
								time = 20,
								minpos = {x=pos.x-1, y=pos.y-23, z=pos.z-1},
								maxpos = {x=pos.x+1, y=pos.y+12, z=pos.z+1},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
								minetest.add_particlespawner({
								amount = 1500,
								time = 20,
								minpos = {x=pos.x-13, y=pos.y+11, z=pos.z-13},
								maxpos = {x=pos.x+13, y=pos.y+14, z=pos.z+13},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
							minetest.add_particlespawner({
								amount = 25,
								time = 20,
								minpos = {x=-1, y=-23, z=-1},
								maxpos = {x=1, y=11, z=1},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
								minetest.add_particlespawner({
								amount = 150,
								time = 20,
								minpos = {x=-13, y=7, z=-13},
								maxpos = {x=13, y=8, z=13},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
						elseif chemistry.config.node_particles == "Decreased" then
							minetest.add_particlespawner({
								amount = 125,
								time = 20,
								minpos = {x=pos.x-1, y=pos.y-23, z=pos.z-1},
								maxpos = {x=pos.x+1, y=pos.y+12, z=pos.z+1},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
								minetest.add_particlespawner({
								amount = 750,
								time = 20,
								minpos = {x=pos.x-13, y=pos.y+11, z=pos.z-13},
								maxpos = {x=pos.x+13, y=pos.y+14, z=pos.z+13},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
							minetest.add_particlespawner({
								amount = 12,
								time = 20,
								minpos = {x=-1, y=-23, z=-1},
								maxpos = {x=1, y=11, z=1},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
								minetest.add_particlespawner({
								amount = 75,
								time = 20,
								minpos = {x=-13, y=7, z=-13},
								maxpos = {x=13, y=8, z=13},
								minvel = {x=-1, y=-1, z=-1},
								maxvel = {x=1,  y=1,  z=1},
								minexptime = 54,
								maxexptime = 62,
								minsize = 25,
								maxsize = 25,
								texture = "nuke_smoke.png",
							})
						end
					end
				}
			},
			on_burn = function(pos)
				minetest.swap_node(pos, {name ="chemistry:nuke_burning"})
				minetest.registered_nodes["chemistry:nuke_burning"].on_construct(pos)
			end,
			on_ignite = function(pos, igniter)
				minetest.swap_node(pos, {name ="chemistry:nuke_burning"})
				minetest.registered_nodes["chemistry:nuke_burning"].on_construct(pos)
			end,
		})

minetest.register_node("chemistry:nuke_burning", {
			description = ("Nuclear Bomb Burning"),
		tiles = {
			{
				name = "nuke_top_burning_animated.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 1,
				}
			},
			"nuke_bottom.png", "nuke_side.png"
			},
		light_source = 10,
		drop = "",
		sounds = default.node_sound_wood_defaults(),
		groups = {falling_node = 1, not_in_creative_inventory = 1},
		on_timer = function(pos, elapsed)
			tnt.boom(pos, nuke_boom)
			if chemistry.config.node_particles == "All" then
				minetest.add_particlespawner({
					amount = 250,
					time = 20,
					minpos = {x=pos.x-1, y=pos.y-23, z=pos.z-1},
					maxpos = {x=pos.x+1, y=pos.y+12, z=pos.z+1},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
					minetest.add_particlespawner({
					amount = 1500,
					time = 20,
					minpos = {x=pos.x-13, y=pos.y+11, z=pos.z-13},
					maxpos = {x=pos.x+13, y=pos.y+14, z=pos.z+13},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
				minetest.add_particlespawner({
					amount = 25,
					time = 20,
					minpos = {x=-1, y=-23, z=-1},
					maxpos = {x=1, y=11, z=1},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
					minetest.add_particlespawner({
					amount = 150,
					time = 20,
					minpos = {x=-13, y=7, z=-13},
					maxpos = {x=13, y=8, z=13},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
			elseif chemistry.config.node_particles == "Decreased" then
				minetest.add_particlespawner({
					amount = 125,
					time = 20,
					minpos = {x=pos.x-1, y=pos.y-23, z=pos.z-1},
					maxpos = {x=pos.x+1, y=pos.y+12, z=pos.z+1},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
					minetest.add_particlespawner({
					amount = 750,
					time = 20,
					minpos = {x=pos.x-13, y=pos.y+11, z=pos.z-13},
					maxpos = {x=pos.x+13, y=pos.y+14, z=pos.z+13},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
				minetest.add_particlespawner({
					amount = 12,
					time = 20,
					minpos = {x=-1, y=-23, z=-1},
					maxpos = {x=1, y=11, z=1},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
					minetest.add_particlespawner({
					amount = 75,
					time = 20,
					minpos = {x=-13, y=7, z=-13},
					maxpos = {x=13, y=8, z=13},
					minvel = {x=-1, y=-1, z=-1},
					maxvel = {x=1,  y=1,  z=1},
					minexptime = 54,
					maxexptime = 62,
					minsize = 25,
					maxsize = 25,
					texture = "nuke_smoke.png",
				})
			end
		end,
		-- unaffected by explosions
		on_blast = function() end,
		on_construct = function(pos)
			minetest.sound_play("tnt_ignite", {pos = pos}, true)
			minetest.get_node_timer(pos):start(8)
			minetest.check_for_falling(pos)
		end,
	})

minetest.register_craft({
	output = 'chemistry:nuke',
	recipe = {
		{'chemistry:titanium_block', 'tnt:gunpowder', 'chemistry:titanium_block'},
		{'chemistry:thorium_block', 'chemistry:plutonium22_block', 'chemistry:polonium_block'},
		{'technic:uranium35_block', 'chemistry:titanium_block', 'technic:uranium35_block'},
	}
})

minetest.register_craft({
	output = 'chemistry:nuke',
	recipe = {
		{'chemistry:cobalt_block', 'tnt:gunpowder', 'chemistry:cobalt_block'},
		{'chemistry:thorium_block', 'chemistry:plutonium22_block', 'chemistry:polonium_block'},
		{'technic:uranium35_block', 'chemistry:cobalt_block', 'technic:uranium35_block'},
	}
})

