
local S = chemistry.getter

if minetest.get_modpath("technic") then
minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_bucket_radioactive_green',
	recipe = {
		'bucket:bucket_water', 'chemistry:radium_dust', 'chemistry:zinc_sulfide',
	},
})
minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_plastic_bucket_radioactive_green',
	recipe = {
		'plastic_bucket:bucket_water', 'chemistry:radium_dust', 'chemistry:zinc_sulfide',
	},
})
end

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_bucket_red',
	recipe = {
		'group:glowing_water_bucket', 'dye:red',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_bucket_radioactive_green',
	recipe = {
		'group:glowing_water_bucket', 'dye:cyan', 'dye:green',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_bucket_blue',
	recipe = {
		'group:glowing_water_bucket', 'dye:blue',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_bucket_yellow',
	recipe = {
		'group:glowing_water_bucket', 'dye:yellow',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_bucket_pink',
	recipe = {
		'group:glowing_water_bucket', 'dye:pink',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_plastic_bucket_red',
	recipe = {
		'group:glowing_water_bucket_plastic', 'dye:red',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_plastic_bucket_radioactive_green',
	recipe = {
		'group:glowing_water_bucket_plastic', 'dye:cyan', 'dye:green',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_plastic_bucket_blue',
	recipe = {
		'group:glowing_water_bucket_plastic', 'dye:blue',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_plastic_bucket_yellow',
	recipe = {
		'group:glowing_water_bucket_plastic', 'dye:yellow',
	},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:glow_water_plastic_bucket_pink',
	recipe = {
		'group:glowing_water_bucket_plastic', 'dye:pink',
	},
})


function chemistry.register_glow_ice_and_water(name, pec)
	local lname = string.lower(name)
	lname = string.gsub(lname, ' ', '_')
   minetest.register_node("chemistry:glow_ice_"..lname, {
	   description = S("@1 Glow Ice", S(name)),
	   tiles = {"ice_"..lname..".png"},
	   is_ground_content = false,
	   paramtype = "light",
      light_source = 7,
      glow = 7,
	   groups = {cracky = 3, cools_lava = 1, slippery = 4, glowing_ice = 1},
	   sounds = default.node_sound_ice_defaults(),
   })

   minetest.register_node("chemistry:glow_ice_"..lname.."_compact", {
	   description = S("@1 Glow Ice Compact", S(name)),
	   tiles = {"ice_"..lname.."_compact.png"},
	   is_ground_content = false,
	   paramtype = "light",
      light_source = 7,
      glow = 7,
	   groups = {cracky = 3, cools_lava = 1, slippery = 6, glowing_ice = 1},
	   sounds = default.node_sound_ice_defaults(),
   })

minetest.register_node("chemistry:glow_water_"..lname, {
	description = S("@1 Glow Water", S(name)),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_"..lname.."_anim.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_"..lname.."_anim.png^[opacity:180",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
   light_source = 7,
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
   glow = 7,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:glow_water_"..lname.."_flowing",
	liquid_alternative_source = "chemistry:glow_water_"..lname,
	liquid_viscosity = 1,
	post_effect_color = pec,
	groups = {liquid = 3, cools_lava = 1, water = 3, glowing_water = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:glow_water_"..lname.."_flowing", {
	description = S("Flowing @1 Glow Water", S(name)),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid_"..lname..".png"},
	special_tiles = {
		{
			name = "liquid_"..lname.."_flowing_anim.png^[opacity:180",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_"..lname.."_flowing_anim.png^[opacity:180",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
   light_source = 7,
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 0,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
   glow = 7,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:glow_water_"..lname.."_flowing",
	liquid_alternative_source = "chemistry:glow_water_"..lname,
	liquid_viscosity = 1,
	post_effect_color = pec,
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, water = 3, glowing_water = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:glow_water_"..lname,
		"chemistry:glow_water_"..lname.."_flowing",
		"chemistry:glow_water_bucket_"..lname,
		lname.."_wt_bucket.png",
		S("@1 Glow Water Bucket", S(name)),
		{tool = 1, glowing_water_bucket = 1}
	)
	plastic_bucket.register_liquid(
		"chemistry:glow_water_"..lname,
		"chemistry:glow_water_"..lname.."_flowing",
		"chemistry:glow_water_plastic_bucket_"..lname,
		lname.."_wt_bucket_plastic.png",
		S("@1 Glow Water Bucket", S(name)),
		{tool = 1, glowing_water_bucket_plastic = 1}
	)
	minetest.register_abm({
		label = "chemistry:glowing Ice cooling",
		nodenames = {"chemistry:glow_water_"..lname},
		neighbors = {"group:snowy"},
		interval = 10.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:glow_ice_"..lname})
		end,
   })
	minetest.register_abm({
		label = "chemistry:glowing Ice cooling",
		nodenames = {"chemistry:glow_water_"..lname},
		neighbors = {"group:cools_water"},
		interval = 1.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:glow_ice_"..lname})
		end,
   })
	minetest.register_abm({
		label = "chemistry:glowing Ice cooling",
		nodenames = {"chemistry:glow_water_"..lname},
		neighbors = {"group:freezer"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			minetest.set_node(pos, {name="chemistry:glow_ice_"..lname})
		end,
   })
	minetest.register_abm({
		label = "chemistry:glowing Ice melting",
		nodenames = {"chemistry:glow_ice_"..lname},
		neighbors = {"group:lava", "group:fire"},
		interval = 5.0,
		chance = 8,
		catch_up = true,
		action = function(pos, node)
         if minetest.find_node_near(pos, 1, {name="group:igniter"}) then
			   minetest.set_node(pos, {name="chemistry:glow_water_"..lname})
         end
		end,
   })
   if chemistry.config.allow_node_melt then
	minetest.register_abm({
		label = "chemistry:glowing Ice melting",
		nodenames = {"chemistry:glow_ice_"..lname, "chemistry:glow_ice_"..lname.."_compact"},
		neighbors = {"group:strong_lava", "group:hot_thermite"},
		interval = 1.0,
		chance = 4,
		catch_up = true,
		action = function(pos, node)
		   minetest.set_node(pos, {name="chemistry:glow_water_"..lname})
		end,
   })
   end

if minetest.get_modpath("technic") then
   local recipes = {
   	{"chemistry:glow_water_bucket_"..lname, { "chemistry:glow_ice_"..lname, "bucket:bucket_empty" } }
   }

   for _, data in pairs(recipes) do
   	technic.register_freezer_recipe({input = {data[1]}, output = data[2]})
   end
end
end

local colors = {
	{"Red", {a=122, r=200, g=80, b=90}},
	{"Radioactive Green", {a=122, r=0, g=255, b=195}},
	{"Blue", {a=122, r=90, g=80, b=200}},
	{"Yellow", {a=122, r=255, g=195, b=55}},
	{"Pink", {a=122, r=255, g=75, b=195}},
}

for _, data in ipairs(colors) do
	chemistry.register_glow_ice_and_water(data[1], data[2])
end
