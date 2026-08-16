tt_base = {}

dofile(minetest.get_modpath("tt_base").."/localize.lua")

local S, PS = minetest.get_translator("tt_base")
tt_base.registered_groups = {}

local function get_min_digtime(caps)
	local mintime
	local unique = true
	local maxlevel = caps.maxlevel
	if not maxlevel then
		maxlevel = 1
	end
	if maxlevel > 1 then
		unique = false
	end
	if caps.times then
		for r=1,3 do
			local time = caps.times[r]
			if time and maxlevel > 1 then
				time = time / maxlevel
			end
			if time and ((not mintime) or (time < mintime)) then
				if mintime and (time < mintime) then
					unique = false
				end
				mintime = time
			end
		end
	end
	return mintime, unique
end

local function newline(str)
	if str ~= "" then
		str = str .. "\n"
	end
	return str
end

function tt_base.register_group(groupname, descriptions)
	tt_base.registered_groups[groupname] = table.copy(descriptions)
end

dofile(minetest.get_modpath("tt_base").."/groups.lua")

-- Tool information (digging times, weapon stats)
tt.register_snippet(function(itemstring)
	local def = minetest.registered_items[itemstring]
	if def._tt_base_ignore == true then
		return ""
	end
	local desc = ""
	if def.tool_capabilities then
		-- Digging times
		local digs = ""
		local d
		if def.tool_capabilities.groupcaps then
			for group, caps in pairs(def.tool_capabilities.groupcaps) do
				local mintime, unique_mintime
				if caps.times then
					mintime, unique_mintime = get_min_digtime(caps)
					if mintime and (mintime > 0 or (not unique_mintime)) then
						if tt_base.registered_groups[group] and tt_base.registered_groups[group].dig_long then
							d = tt_base.registered_groups[group].dig_long .. "\n"
						else
							--~ @1 = technical group name
							d = S("Digs @1 blocks", group) .. "\n"
						end
						d = d .. S("• Minimum dig time: @1s", tt_base.localize_number(string.format("%.2f", mintime)))
						digs = newline(digs)
						digs = digs .. d
					elseif mintime and mintime == 0 then
						if tt_base.registered_groups[group] and tt_base.registered_groups[group].dig_long then
							--~ Description for when a tool can something instantly. @1 is the general dig description
							d = S("@1 (instantly)", tt_base.registered_groups[group].dig_long)
						else
							--~ @1 = technical group name
							d = S("Digs @1 blocks (instantly)", group)
						end
						digs = newline(digs)
						digs = digs .. d
					end
				end
			end
			if digs ~= "" then
				desc = desc .. digs
			end
		end
		-- Weapon stats
		if def.tool_capabilities.damage_groups then
			for group, damage in pairs(def.tool_capabilities.damage_groups) do
				local msg
				if group == "fleshy" then
					if damage >= 0 then
						msg = S("Damage: @1", damage)
					else
						msg = S("Healing: @1", math.abs(damage))
					end
				else
					local gname
					if tt_base.registered_groups[group] and tt_base.registered_groups[group].damage then
						gname = tt_base.registered_groups[group].damage
					else
						gname = group
					end
					if damage >= 0 then
						msg = S("Damage (@1): @2", gname, damage)
					else
						msg = S("Healing (@1): @2", gname, math.abs(damage))
					end
				end
				desc = newline(desc)
				desc = desc .. msg
			end
			local full_punch_interval = def.tool_capabilities.full_punch_interval
			if not full_punch_interval then
				full_punch_interval = 1
			end
			desc = newline(desc)
			desc = desc .. S("• Full punch interval: @1s", tt_base.localize_number(string.format("%.2f", full_punch_interval)))
		end
	end
	if desc == "" then
		desc = nil
	end
	return desc
end)

-- Food
tt.register_snippet(function(itemstring)
	local def = minetest.registered_items[itemstring]
	if def._tt_base_ignore == true then
		return ""
	end
	local desc
	if def._tt_food then
		desc = S("Food item")
		if def._tt_food_hp then
			local msg
			if PS then
				msg = PS("+@1 food point", "+@1 food points", def._tt_food_hp, def._tt_food_hp)
			else
				-- fallback when plural forms are unavailable
				msg = S("+@1 food points", def._tt_food_hp)
			end
			desc = desc .. "\n" .. msg
		end
	end
	return desc
end)

-- Node info
tt.register_snippet(function(itemstring)
	local def = minetest.registered_items[itemstring]
	if def._tt_base_ignore == true then
		return ""
	end
	local desc = ""

	-- Health-related node facts
	if def.damage_per_second then
		if def.damage_per_second > 0 then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DANGER, S("Contact damage: @1 per second", def.damage_per_second))
		elseif def.damage_per_second < 0 then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_GOOD, S("Contact healing: @1 per second", math.abs(def.damage_per_second)))
		end
	end
	if def.drowning and def.drowning ~= 0 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DANGER, S("Drowning damage: @1", def.drowning))
	end
	local tmp = minetest.get_item_group(itemstring, "fall_damage_add_percent")
	if tmp > 0 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DANGER, S("Fall damage: +@1%", tmp))
	elseif tmp == -100 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_GOOD, S("No fall damage"))
	elseif tmp < 0 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Fall damage: @1%", tt_base.localize_number(tmp)))
	end

	-- Movement-related node facts
	local disable_jump = minetest.get_item_group(itemstring, "disable_jump") == 1
	local disable_descend = minetest.get_item_group(itemstring, "disable_descend") == 1
	if not def.climbable then
		if def.liquidtype == "none" then
			if disable_jump then
				desc = newline(desc)
				desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No jumping"))
			end
		else
			if minetest.get_item_group(itemstring, "fake_liquid") == 0 then
				if disable_jump and disable_descend then
					desc = newline(desc)
					desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No swimming upwards or downwards"))
				elseif disable_jump then
					desc = newline(desc)
					desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No swimming upwards"))
				elseif disable_descend then
					desc = newline(desc)
					desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No swimming downwards"))
				end
			else
				if disable_jump and disable_descend then
					desc = newline(desc)
					desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No rising or sinking"))
				elseif disable_jump then
					desc = newline(desc)
					desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No rising"))
				elseif disable_descend then
					desc = newline(desc)
					desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("No sinking"))
				end
			end
		end
	end
	if def.climbable then
		if disable_jump and disable_descend then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Climbable (only horizontally)"))
		elseif disable_jump then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Climbable (only downwards)"))
		elseif disable_descend then
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Climbable (only upwards)"))
		else
			desc = newline(desc)
			desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Climbable"))
		end
	end
	if minetest.get_item_group(itemstring, "slippery") >= 1 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Slippery"))
	end
	tmp = minetest.get_item_group(itemstring, "bouncy")
	if tmp ~= 0 then
		if tmp < 0 then
			tmp = -tmp
		end
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Bouncy (@1%)", tmp))
	end

	-- Node appearance
	tmp = def.light_source
	if tmp and tmp >= 1 then
		desc = newline(desc)
		desc = desc .. minetest.colorize(tt.COLOR_DEFAULT, S("Luminance: @1", tmp))
	end


	if desc == "" then
		desc = nil
	end
	return desc, false
end)

