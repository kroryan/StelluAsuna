
local S = chemistry.getter

minetest.register_node("chemistry:thermite_burning", {
	description = S("Burning Thermite"),
	drawtype = "liquid",
	tiles = {
		{
			name = "thermite_liquid_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "thermite_liquid_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	paramtype = "light",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:thermite_burning_flowing",
	liquid_alternative_source = "chemistry:thermite_burning",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 30,
	post_effect_color = {a = 240, r = 255, g = 195, b = 0},
	groups = {liquid = 1, not_in_creative_inventory = 1, hot_thermite = 1, igniter = 1, lava = 1},
   on_timer = function(pos)
   	minetest.set_node(pos, {name="default:steelblock"})
   end,
   on_construct = function(pos)
   	minetest.get_node_timer(pos):start(math.random(25, 50))
		minetest.sound_play(
			"thermite_ignite",
			{pos = pos, max_hear_distance = 18, gain = 0.5}
      )
   end,
})

minetest.register_node("chemistry:thermite_burning_flowing", {
	description = S("Burning Thermite Flowing"),
	drawtype = "flowingliquid",
	tiles = {"thermite_liquid.png"},
	special_tiles = {
		{
			name = "thermite_liquid_flowing_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
		{
			name = "thermite_liquid_flowing_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:thermite_burning_flowing",
	liquid_alternative_source = "chemistry:thermite_burning",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 30,
	liquid_range = 5,
	post_effect_color = {a = 240, r = 255, g = 195, b = 0},
	groups = {liquid = 1, not_in_creative_inventory = 1, hot_thermite = 1, igniter = 1, lava = 1},
})

minetest.register_node("chemistry:thermite", {
	description = S("Thermite"),
	tiles = {{
		name = "thermite.png",
    	align_style = "world",
	    scale       = 2,
	}},
	groups = {crumbly = 3, falling_node = 1, thermite = 1},
	sounds = default.node_sound_sand_defaults(),
   on_heat = function(pos)
		minetest.set_node(pos, {name="chemistry:thermite_burning"})
	   minetest.registered_nodes["chemistry:thermite_burning"].on_construct(pos)
   end,
})

if chemistry.config.allow_node_melt then
	minetest.register_abm({
		label = "chemistry: bismuth melting",
		nodenames = {"group:cracky", "group:level", "group:crumbly", "group:choppy"},
		neighbors = {"group:hot_thermite"},
		interval = 2.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
	      if node.name == "default:stone" then
		      minetest.swap_node(pos, {name = "chemistry:lava"})
	      elseif node.name == "default:copperblock" then
		      minetest.swap_node(pos, {name = "chemistry:mcopper"})
	      elseif node.name == "chemistry:bismuth_block" then
		      minetest.swap_node(pos, {name = "chemistry:lbismuth"})
	      elseif node.name == "default:sand" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "default:silver_sand" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "default:desert_sand" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "default:glass" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "chemistry:impurities_glass" then
		      minetest.swap_node(pos, {name = "chemistry:mglass"})
	      elseif node.name == "chemistry:impurities_glass_low" then
		      minetest.swap_node(pos, {name = "chemistry:mglass_flowing"})
	      elseif node.name == "chemistry:thermite" then
            minetest.set_node(pos, {name = "chemistry:thermite_burning"})
         end
		end,
	})
	
    minetest.register_abm({
		label = "chemistry: bismuth melting",
		nodenames = {"chemistry:thermite"},
		neighbors = {"group:igniter"},
		interval = 10.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
            minetest.set_node(pos, {name="chemistry:thermite_burning"})
		end
	})
end

	minetest.register_abm({
		label = "Ignite flame",
		nodenames = {"group:flammable", "group:anthracite_material"},
		neighbors = {"group:hot_thermite", "group:strong_lava", "group:super_hot_metal"},
		interval = 1,
		chance = 7.5,
		catch_up = false,
		action = function(pos, node)
			local p = minetest.find_node_near(pos, 1, {"air"})
			if p then
	         if minetest.get_item_group(node.name, "flora") > 1 then
		   	   minetest.swap_node(pos, {name = "fire:basic_flame"})
            elseif minetest.get_item_group(node.name, "leaves") > 1 then
               minetest.swap_node(pos, {name = "fire:basic_flame"})
            elseif minetest.get_item_group(node.name, "flammable") > 1 then
               minetest.set_node(p, {name = "fire:basic_flame"})
            elseif minetest.get_item_group(node.name, "anthracite_material") > 1 then
               minetest.set_node(p, {name = "chemistry:anthracite_fire"})
            end
			end
		end
	})

minetest.register_craft({
	output = 'chemistry:thermite',
    recipe = {
	  	{'chemistry:iron_iii_oxide', 'chemistry:aluminium_dust', 'chemistry:iron_iii_oxide'},
	 	{'chemistry:aluminium_dust', 'chemistry:iron_iii_oxide', 'chemistry:aluminium_dust'},
	    {'chemistry:iron_iii_oxide', 'chemistry:aluminium_dust', 'chemistry:iron_iii_oxide'},
    }
})

