
local S = chemistry.getter

chemistry.intoxicated = {}
	
if chemistry.config.allow_intoxication then
	function chemistry.intoxicate_player(player, name, damage, time, first_hit)
		if not player then
			core.log("warning", "[chemistry] Attempted to apply poisoning to a non existant player")
			return
		end
		if not name or not minetest.get_player_by_name(name) then
			core.log("warning", "[chemistry] Attempted to apply poisoning to a non existant player")
			return
		end

		if not chemistry.intoxicated[name] and not first_hit then
			return
		end

		if not chemistry.intoxicated[name] then
			chemistry.intoxicated[name] = {
				time_left = time
			}
		else
			player:set_hp(player:get_hp() + damage, {type = "toxic", chemistry = true})

			if not first_hit then
				chemistry.intoxicated[name].time_left = chemistry.intoxicated[name].time_left - 1
			else
				chemistry.intoxicated[name].time_left = time
			end
		end
		if chemistry.intoxicated[name].time_left > 0 then
			minetest.after(1, function()
				chemistry.intoxicate_player(player, name, damage, time, false)
			end)
		else

		end
	end

	minetest.register_on_player_hpchange(function(player, hp_change, reason)
		local name = player:get_player_name()
		if reason.type == "node_damage" then
			if minetest.get_item_group(reason.node, "toxic") > 0 then
				hp_change = hp_change
				chemistry.intoxicate_player(player, name, math.round(hp_change / 2), math.round(math.random(5, 10)), true)
			end
		end
		return hp_change
	end, true)

	minetest.register_on_punchplayer(function(player, hitter, _, toolcaps, _, dmg)
		if hitter and hitter:is_player() and toolcaps.damage_groups.toxic_damage and player and (player:get_hp() - dmg) > 0 then
			local duration = toolcaps.damage_groups.toxic_duration or 5
			chemistry.intoxicate_player(player, player:get_player_name(), toolcaps.damage_groups.toxic_damage, duration, true)
		end
		return false
	end)
end

minetest.register_craftitem("chemistry:arsenic", {
	description = S("Arsenic Rock"),
	inventory_image = "arsenic.png",
})

minetest.register_node("chemistry:arsenic_water", {
	description = S("Arsenic Water"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "liquid_source_animated.png^[opacity:150^[colorize:black:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "liquid_source_animated.png^[opacity:150^[colorize:black:150",
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
   damage_per_second = 7,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:arsenic_water_flowing",
	liquid_alternative_source = "chemistry:arsenic_water",
	liquid_viscosity = 1,
	post_effect_color = {a = 155, r = 0, g = 0, b = 0},
	groups = {liquid = 3, cools_lava = 1, toxic=1, water = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("chemistry:arsenic_water_flowing", {
	description = S("Flowing Arsenic Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"liquid.png^[opacity:150^[colorize:black:150"},
	special_tiles = {
		{
			name = "liquid_flowing_animated.png^[opacity:150^[colorize:black:150",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "liquid_flowing_animated.png^[opacity:150^[colorize:black:150",
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
	buildable_to = true,
	is_ground_content = false,
	drop = "",
   damage_per_second = 7,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:arsenic_water_flowing",
	liquid_alternative_source = "chemistry:arsenic_water",
	liquid_viscosity = 1,
	post_effect_color = {a = 155, r = 0, g = 0, b = 0},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1, toxic=1, water = 1, toxic_to_crops = 1},
	sounds = default.node_sound_water_defaults(),
})

bucket.register_liquid(
	"chemistry:arsenic_water",
	"chemistry:arsenic_water_flowing",
	"chemistry:arsenic_water_bucket",
	"arsenic_wt_bucket.png",
	S("Arsenic Water Bucket"),
	{tool = 1, toxic = 1}
)

plastic_bucket.register_liquid(
	"chemistry:arsenic_water",
	"chemistry:arsenic_water_flowing",
	"chemistry:arsenic_water_bucket_plastic",
	"acid_bucket.png",
	S("Arsenic Water Bucket"),
	{tool = 1, toxic = 1}
)

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:arsenic_water_bucket',
	recipe = {
		'bucket:bucket_water', 'chemistry:arsenic',
	}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:arsenic_water_bucket_plastic',
	recipe = {
		'plastic_bucket:bucket_water', 'chemistry:arsenic',
	}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:osmium_tetroxide',
	recipe = {
		'group:water_bucket', 'chemistry:osmium_dust',
	}
})

minetest.register_craftitem("chemistry:osmium_tetroxide", {
	description = S("Osmium Tetroxide Crystals"),
	inventory_image = "osmium_tetroxide.png",
})

minetest.register_node("chemistry:mercury", {
	description = S("Mercury"),
	drawtype = "liquid",
	tiles = {
		{
			name = "lmetal_source_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "lmetal_source_anim.png",
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
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "chemistry:mercury_flowing",
	liquid_alternative_source = "chemistry:mercury",
	liquid_viscosity = 1,
	liquid_renewable = false,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 3, toxic=1, toxic_to_crops = 1},
})

minetest.register_node("chemistry:mercury_flowing", {
	description = S("Flowing Mercury"),
	drawtype = "flowingliquid",
	tiles = {"lmetal.png"},
	special_tiles = {
		{
			name = "lmetal_flowing_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "lmetal_flowing_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 0,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "chemistry:mercury_flowing",
	liquid_alternative_source = "chemistry:mercury",
	liquid_viscosity = 1,
	liquid_renewable = false,
	damage_per_second = 0,
	post_effect_color = {a = 240, r = 80, g = 80, b = 80},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		toxic=1, toxic_to_crops = 1},
})

bucket.register_liquid(
	"chemistry:mercury",
	"chemistry:mercury_flowing",
	"chemistry:mercury_bucket",
	"lmetal_bucket.png",
	S("Mercury Bucket"),
	{tool = 1, toxic = 1}
)

core.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	
	if not chemistry.intoxicated[name] then return end

	chemistry.intoxicated[name] = nil
end)