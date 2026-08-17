
function chemistry.node_sound_soft(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "default_hard_footstep", gain = 0.10}
	tbl.dig = tbl.dig or
			{name = "default_dig_oddly_breakable_by_hand", gain = 0.35}
	tbl.dug = tbl.dug or
			{name = "default_dug_node", gain = 1.0}
	default.node_sound_defaults(tbl)
	return tbl
end

function chemistry.node_sound_strong(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "strong_footstep", gain = 0.2}
	tbl.dig = tbl.dig or
			{name = "strong_dig", gain = 0.45}
	tbl.dug = tbl.dug or
			{name = "strong_dug", gain = 1.0}
	default.node_sound_defaults(tbl)
	return tbl
end

function chemistry.node_sound_limestone(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "limestone_footstep", gain = 0.15}
	tbl.dig = tbl.dig or
			{name = "default_dig_cracky", gain = 0.4}
	tbl.dug = tbl.dug or
			{name = "default_hard_footstep", gain = 1.0}
	default.node_sound_defaults(tbl)
	return tbl
end

function chemistry.node_sound_oil(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or
			{name = "oil_footstep", gain = 0.2}
	default.node_sound_defaults(tbl)
	return tbl
end

local radius = 8

local allsounds = {
	["env_sounds_acid"] = {
		trigger = {"chemistry:hcl_acid_flowing", "chemistry:hydrogen_peroxide_flowing", "chemistry:cwater_flowing", 
          "chemistry:ch3cooh_acid_flowing", "chemistry:hso_acid_flowing", "chemistry:hno_acid_flowing", "chemistry:aqua_regia_flowing",
          "chemistry:hso_diluted_water_flowing"},
		base_volume = 0.04,
		max_volume = 0.4,
		per_node = 0.004,
	},
	["env_sounds_mmetal"] = {
		trigger = {"chemistry:msteel", "chemistry:msteel_flowing", "chemistry:mcopper", "chemistry:mcopper_flowing", "chemistry:mtin",
		   "chemistry:mtin_flowing", "chemistry:stone_cobble_glow2", "chemistry:stone_cobble_glow3", "chemistry:mosmium", "chemistry:mosmium_flowing",
         "chemistry:mtitanium", "chemistry:mtitanium_flowing", "chemistry:mtungsten", "chemistry:mtungsten_flowing",},
		base_volume = 0.04,
		max_volume = 0.4,
		per_node = 0.004,
   },
	["env_sounds_thermite"] = {
		trigger = {"chemistry:thermite_burning", "chemistry:thermite_burning_flowing", "chemistry:hot_kmno4"},
		base_volume = 0.04,
		max_volume = 0.4,
		per_node = 0.004,
   },
   ["env_sounds_lava"] = {
		trigger = {"chemistry:st_lava", "chemistry:st_lava_flowing", "chemistry:stone_cobble_glow1"},
		base_volume = 8.0,
		max_volume = 30.0,
		per_node = 0.004,
	},
}

local cache_triggers = {}

for sound, def in pairs(allsounds) do
	for _, name in ipairs(def.trigger) do
		table.insert(cache_triggers, name)
	end
end

local function update_sound(player)
	local player_name = player:get_player_name()
	local ppos = player:get_pos()
	ppos = vector.add(ppos, player:get_properties().eye_height)
	local areamin = vector.subtract(ppos, radius)
	local areamax = vector.add(ppos, radius)

	local pos = minetest.find_nodes_in_area(areamin, areamax, cache_triggers, true)
	if next(pos) == nil then -- If table empty
		return
	end
	for sound, def in pairs(allsounds) do
		-- Find average position
		local posav = {0, 0, 0}
		local count = 0
		for _, name in ipairs(def.trigger) do
			if pos[name] then
				for _, p in ipairs(pos[name]) do
					posav[1] = posav[1] + p.x
					posav[2] = posav[2] + p.y
					posav[3] = posav[3] + p.z
				end
				count = count + #pos[name]
			end
		end

		if count > 0 then
			posav = vector.new(posav[1] / count, posav[2] / count,
				posav[3] / count)

			-- Calculate gain
			local gain = def.base_volume
			if type(def.per_node) == 'table' then
				for name, multiplier in pairs(def.per_node) do
					if pos[name] then
						gain = gain + #pos[name] * multiplier
					end
				end
			else
				gain = gain + count * def.per_node
			end
			gain = math.min(gain, def.max_volume)

			minetest.sound_play(sound, {
				pos = posav,
				to_player = player_name,
				gain = gain,
			}, true)
		end
	end
end


-- Update sound when player joins

minetest.register_on_joinplayer(function(player)
	update_sound(player)
end)


-- Cyclic sound update

local function cyclic_update()
	for _, player in pairs(minetest.get_connected_players()) do
		update_sound(player)
	end
	minetest.after(3.5, cyclic_update)
end

minetest.after(0, cyclic_update)

minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if reason.node ~= nil and (minetest.get_node_group(reason.node, "corrosive") > 0 or minetest.get_node_group(reason.node, "acid") > 0 ) then
		minetest.sound_play("acid_damage",
			{to_player = player:get_player_name(), pitch = 1, gain = 0.5}
		)
	end
end)

minetest.register_on_dieplayer(function(player, reason)
	if reason.node ~= nil and (minetest.get_node_group(reason.node, "corrosive") > 0 or minetest.get_node_group(reason.node, "acid") > 0 ) then
		minetest.sound_play("acid_damage",
			{to_player = player:get_player_name(), pitch = 0.7, gain = 0.8}
		)
	end
end)