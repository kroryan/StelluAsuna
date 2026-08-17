
local S = chemistry.getter

minetest.register_craftitem("chemistry:radium_raw", {
	description = S("Raw Radium"),
	inventory_image = "radium_raw.png",
})

minetest.register_craftitem("chemistry:radium", {
	description = S("Radium Ingot"),
	inventory_image = "radium.png",
})

minetest.register_node("chemistry:radium_block", {
	description = S("Radium Block"),
	tiles = {"radium_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, radioactive = 10, level = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	output = 'chemistry:radium_block',
	recipe = {
		{'chemistry:radium', 'chemistry:radium', 'chemistry:radium'},
		{'chemistry:radium', 'chemistry:radium', 'chemistry:radium'},
		{'chemistry:radium', 'chemistry:radium', 'chemistry:radium'},
	}
})

minetest.register_craft({
	output = 'chemistry:radium 9',
	recipe = {
		{'chemistry:radium_block'},
	}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "chemistry:radium",
	recipe = "chemistry:radium_raw"
})

-- Ore generation
-- -128 <-> -255

minetest.register_node("chemistry:radon", {
	description = S("Radon Gas"),
	walkable = false,
	pointable = false,
	diggable = false,
	is_ground_content = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
   damage_per_second = 0,
	post_effect_color = {a = 122, r = 122, g = 122, b = 122},
	tiles = {"incolored_gas.png^[opacity:15"},
	wield_image = "radon_wl.png",
	inventory_image = "radon_wl.png",
	use_texture_alpha = "blend",
	groups = {not_in_creative_inventory=0, ropes_can_extend_into=1, not_solid=1, not_opaque=1, radioactive = 1, inert = 1, gas=1, gaseous = 1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_craftitem("chemistry:polonium", {
	description = S("Polonium Scrap"),
	inventory_image = "polonium.png",
})

minetest.register_node("chemistry:polonium_block", {
	description = S("Polonium Block"),
	tiles = {"polonium_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, radioactive = 7, toxic=1, level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'chemistry:polonium_block',
	recipe = {
		{'chemistry:polonium', 'chemistry:polonium', 'chemistry:polonium'},
		{'chemistry:polonium', 'chemistry:polonium', 'chemistry:polonium'},
		{'chemistry:polonium', 'chemistry:polonium', 'chemistry:polonium'},
	}
})

minetest.register_craft({
	output = 'chemistry:polonium 9',
	recipe = {
		{'chemistry:polonium_block'},
	}
})


minetest.register_craftitem("chemistry:thorium", {
	description = S("Thorium Ingot"),
	inventory_image = "thorium.png",
})

minetest.register_craftitem("chemistry:thorium_raw", {
	description = S("Raw Thorium"),
	inventory_image = "thorium_raw.png",
})

minetest.register_node("chemistry:thorium_block", {
	description = S("Thorium Block"),
	tiles = {"thorium_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, radioactive = 5, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	output = 'chemistry:thorium_block',
	recipe = {
		{'chemistry:thorium', 'chemistry:thorium', 'chemistry:thorium'},
		{'chemistry:thorium', 'chemistry:thorium', 'chemistry:thorium'},
		{'chemistry:thorium', 'chemistry:thorium', 'chemistry:thorium'},
	}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "chemistry:thorium",
	recipe = "chemistry:thorium_raw"
})

minetest.register_craft({
	output = 'chemistry:thorium 9',
	recipe = {
		{'chemistry:thorium_block'},
	}
})

-- Ore generation
-- -128 <-> -255

local orthogonal = {
	{x=0,y=0,z=1},
	{x=0,y=1,z=0},
	{x=1,y=0,z=0},
	{x=0,y=0,z=-1},
	{x=0,y=-1,z=0},
	{x=-1,y=0,z=0},
}

minetest.register_abm({
	label = "chemistry:thorite decay",
	nodenames = {"chemistry:thorite"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 10,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.set_node(target_pos, {name="chemistry:radon"})
			if math.random() < 0.5 then
				minetest.sound_play(
					"",
					{pos = pos, max_hear_distance = 8, gain = 0.05}
				)
			end
		end	
	end,
})

minetest.register_node("chemistry:uranium_dioxide", {
	description = S("Uranium Dioxide"),
	tiles = {{
		name = "uranium_dioxide.png",
    	align_style = "world",
	    scale       = 2,
	}},
	groups = {crumbly = 3, falling_node = 1, radioactive = 2},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("chemistry:uranium_water", {
	description = S("Uranium Water"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_yellow_anim.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_yellow_anim.png^[opacity:150",
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
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:uranium_water_flowing",
	liquid_alternative_source = "chemistry:uranium_water",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 0},
	groups = {liquid = 3, cools_lava = 1, radioactive = 2, water = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:uranium_water_flowing", {
	description = S("Flowing Uranium Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid_yellow.png"},
	special_tiles = {
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_yellow_flowing_anim.png^[opacity:150",
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
	walkable = false,
	pointable = false,
	diggable = false,
   damage_per_second = 5,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:uranium_water_flowing",
	liquid_alternative_source = "chemistry:uranium_water",
	liquid_viscosity = 1,
	post_effect_color = {a = 122, r = 122, g = 122, b = 0},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, radioactive = 2, water = 1},
	sounds = default.node_sound_water_defaults(),
})

	bucket.register_liquid(
		"chemistry:uranium_water",
		"chemistry:uranium_water_flowing",
		"chemistry:uranium_water_bucket",
		"yellow_wt_bucket.png",
		("Uranium Water Bucket"),
		{tool = 1}
	)

	plastic_bucket.register_liquid(
		"chemistry:uranium_water",
		"chemistry:uranium_water_flowing",
		"chemistry:uranium_water_bucket_plastic",
		"yellow_wt_bucket_plastic.png",
		("Uranium Water Bucket"),
		{tool = 1}
	)

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:uranyl_acetate',
	recipe = {
		'chemistry:uranium_dioxide', 'chemistry:ch3cooh_acid_bucket',
	},
	replacements = {{'chemistry:ch3cooh_acid_bucket', 'plastic_bucket:bucket_empty'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:uranyl_nitrate',
	recipe = {
		'chemistry:uranyl_acetate', 'chemistry:hno_acid_bucket',
	},
	replacements = {{'chemistry:hno_acid_bucket', 'plastic_bucket:bucket_empty'}, {'chemistry:uranyl_acetate', 'chemistry:nitrogen_dioxide 5'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:uranium_water_bucket',
	recipe = {
		'chemistry:uranyl_nitrate', 'bucket:bucket_water',
	}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:uranium_water_bucket_plastic',
	recipe = {
		'chemistry:uranyl_nitrate', 'plastic_bucket:bucket_water',
	}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:sodium_diuranate',
	recipe = {
		'chemistry:uranium_water_bucket', 'chemistry:cwater_bucket', 'vessels:glass_bottle',
	},
	replacements = {{'chemistry:cwater_bucket', 'plastic_bucket:bucket_empty'}, {'chemistry:uranium_water_bucket', 'chemistry:uranium_water_bucket'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:sodium_diuranate',
	recipe = {
		'chemistry:uranium_water_bucket_plastic', 'chemistry:cwater_bucket', 'vessels:glass_bottle',
	},
	replacements = {{'chemistry:cwater_bucket', 'plastic_bucket:bucket_empty'}, {'chemistry:uranium_water_bucket_plastic', 'chemistry:uranium_water_bucket_plastic'}},
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:uranium_comp',
	recipe = {
		'chemistry:sodium_diuranate', 'vessels:glass_fragments',
	}
})

minetest.register_craftitem("chemistry:uranyl_acetate", {
	description = S("Uranyl Acetate Crystals"),
	inventory_image = "uranyl_acetate.png",
})

minetest.register_craftitem("chemistry:uranyl_nitrate", {
	description = S("Uranyl Nitrate Crystals"),
	inventory_image = "uranyl_nitrate.png",
})

minetest.register_craftitem("chemistry:sodium_diuranate", {
	description = S("Sodium Diuranate Flask"),
	inventory_image = "sodium_diuranate.png",
})

minetest.register_craftitem("chemistry:uranium_comp", {
	description = S("Uranium Compound"),
	inventory_image = "uranium_comp.png",
})

minetest.register_node("chemistry:uranium_glass", {
	description = S("Uranium Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"uranium_glass.png", "uranium_glass_detail.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
   light_source = 7,
   glow = 7,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "chemistry:uranium_glass",
	recipe = "chemistry:uranium_comp"
})

-- Ore generation
-- -128 <-> -255

minetest.register_craftitem("chemistry:plutonium_raw", {
	description = S("Raw Plutonium"),
	inventory_image = "plutonium_raw.png",
})

minetest.register_craftitem("chemistry:plutonium_ingot", {
	description = S("Plutonium Ingot"),
	inventory_image = "titanium.png^[colorize:black:200",
})

minetest.register_node("chemistry:plutonium_block", {
	description = S("Plutonium Block"),
	tiles = {"titanium_block.png^[colorize:black:200"},
	is_ground_content = true,
	groups = {cracky = 1, radioactive = 6, level = 4},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 9,
	output = "chemistry:plutonium_ingot",
	recipe = "chemistry:plutonium_raw"
})

minetest.register_craft({
	output = 'chemistry:plutonium_block',
	recipe = {
		{'chemistry:plutonium_ingot', 'chemistry:plutonium_ingot', 'chemistry:plutonium_ingot'},
		{'chemistry:plutonium_ingot', 'chemistry:plutonium_ingot', 'chemistry:plutonium_ingot'},
		{'chemistry:plutonium_ingot', 'chemistry:plutonium_ingot', 'chemistry:plutonium_ingot'},
	}
})

minetest.register_craft({
	output = 'chemistry:plutonium_ingot 9',
	recipe = {
		{'chemistry:plutonium_block'},
	}
})

minetest.register_craftitem("chemistry:americium", {
	description = S("Americium Ingot"),
	inventory_image = "americium.png",
})

minetest.register_node("chemistry:americium_block", {
	description = S("Americium Block"),
	tiles = {"americium_block.png"},
	is_ground_content = true,
	groups = {cracky = 2, radioactive = 7, level = 4},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_craft({
	output = 'chemistry:americium_block',
	recipe = {
		{'chemistry:americium', 'chemistry:americium', 'chemistry:americium'},
		{'chemistry:americium', 'chemistry:americium', 'chemistry:americium'},
		{'chemistry:americium', 'chemistry:americium', 'chemistry:americium'},
	}
})

minetest.register_craft({
	output = 'chemistry:americium 9',
	recipe = {
		{'chemistry:americium_block'},
	}
})

if minetest.get_modpath("uraniumstuff") then
local allow_armor_damage = minetest.settings:get_bool("uraniumstuff.allow_armor_radiation", true)
    
    local function has_item(player_name, item_name)
        local inventory = minetest.get_inventory({type="player", name=player_name})
        local main_list = inventory:get_list("main")
        for _, stack in ipairs(main_list) do
            if stack:get_name() == item_name then
                return true
            end
        end
        return false
    end

    local function alter_health(player, change)
        if player == nil then return end
        local hp_max = player:get_properties().hp_max
        local current_health = player:get_hp()
        local new_health = current_health + change

        if new_health > hp_max then new_health = hp_max end
        if new_health < 0 then new_health = 0 end

        player:set_hp(new_health)
    end

    local function pattern_count(base, pattern)
        return select(2, string.gsub(base, pattern, ""))
    end

    local function get_radioactive_armor_count(player)
        local inv_3d = player:get_meta():get_string("3d_armor_inventory")
        if not inv_3d then return 0 end
        return pattern_count(inv_3d, "cchemistry:")
    end

    local function damage_players()
        local players = minetest.get_connected_players()
        for _, player in ipairs(players) do
            local damage = 0
            if allow_armor_damage then
                damage = damage + get_radioactive_armor_count(player)
            end
            if damage > 0 then
                local player_name = player:get_player_name()
                local has_gem = has_item(player_name, "uraniumstuff:uranium_protection_gem")
                if not has_gem then
                    alter_health(player, damage*-1)
                end
            end
        end
        minetest.after(2, damage_players)
    end
    damage_players()

end


for p = 0, 24 do
	local perc_fmt = string.format("%.1f", p/10)

	local nici = (p ~= 0 and p ~= 5 and p ~= 24) and 1 or nil
	local psuffix = p == 5 and "" or p
	local ingot = "chemistry:plutonium"..psuffix.."_ingot"
	local block = "chemistry:plutonium"..psuffix.."_block"
	local ov = p == 5 and minetest.override_item or nil;
	(ov or minetest.register_craftitem)(ingot, {
		description = S("@1%-Fissile Plutonium Ingot", perc_fmt),
		inventory_image = "titanium.png^[colorize:black:200",
		groups = {plutonium_ingot=1, not_in_creative_inventory=nici},
	})
	local radioactivity = math.floor(math.sqrt((1+6*p/20) * 18 / (1+6*4/20)) + 0.5);
	(ov or minetest.register_node)(block, {
		description = S("@1%-Fissile Plutonium Block", perc_fmt),
		tiles = {"titanium_block.png^[colorize:black:200"},
		is_ground_content = true,
		groups = {plutonium_block=1, not_in_creative_inventory=nici,
			cracky=1, level=3, radioactive=radioactivity},
		sounds = default.node_sound_stone_defaults(),
	})
	if not ov then
		minetest.register_craft({
			output = block,
			recipe = {
				{ingot, ingot, ingot},
				{ingot, ingot, ingot},
				{ingot, ingot, ingot},
			},
		})
		minetest.register_craft({
			output = ingot.." 9",
			recipe = {{block}},
		})
	end
end

for p = 0, 24 do
	local nici = (p ~= 0 and p ~= 5 and p ~= 24) and 1 or nil
	local psuffix = p == 5 and "" or p
	local ingot = "chemistry:plutonium"..psuffix.."_ingot"
	local dust = "chemistry:plutonium"..psuffix.."_dust"
	minetest.register_craftitem(dust, {
		description = S("@1 Dust", S("@1%-Fissile Plutonium", string.format("%.1f", p/10))),
		inventory_image = "titanium_dust.png^[colorize:black:200",
		on_place_on_ground = minetest.craftitem_place_item,
		groups = {plutonium_dust=1, not_in_creative_inventory=nici},
	})
	minetest.register_craft({
		type = "cooking",
		recipe = dust,
		output = ingot,
	})
	technic.register_grinder_recipe({ input = {ingot}, output = dust })
end

local function plutonium_dust(p)
	return "chemistry:plutonium"..(p == 5 and "" or p).."_dust"
end
for pa = 0, 23 do
	for pb = pa+1, 24 do
		local pc = (pa+pb)/2
		if pc == math.floor(pc) then
			minetest.register_craft({
				type = "shapeless",
				recipe = { plutonium_dust(pa), plutonium_dust(pb) },
				output = plutonium_dust(pc).." 2",
			})
		end
	end
end

minetest.register_craftitem("chemistry:plutonium_fuel", {
	description = S("Plutonium Fuel"),
	inventory_image = "technic_uranium_fuel.png^[colorize:#FF0000:150",
})

minetest.register_craftitem("chemistry:technetium", {
	description = S("Technetium Scrap"),
	inventory_image = "technetium.png",
})

