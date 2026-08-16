-- Copyright (c) 2013-18 rubenwardy. MIT.

local S = awards.translator
local GOAL_ID_SEPARATOR = string.char(31)

function awards.register_award(name, def)
	def.name = name
	def.goals = def.goals or {}

	-- Add legacy trigger as a goal
	if def.trigger and def.trigger.type then
		table.insert(def.goals,{
			description = def.description or def.trigger.type,
			trigger = def.trigger,
		})
		def.trigger = nil
	end

	-- Add goals
	def.goals.show_unlocked = def.goals.show_unlocked == nil and true or def.goals.show_unlocked
	def.goals.show_locked = def.goals.show_locked == nil and true or def.goals.show_locked
	for i = 1, #def.goals do
		local goal = def.goals[i]
		local goal_id = name .. GOAL_ID_SEPARATOR .. (goal.id or i)
		goal.id = goal_id
		goal.name = goal.id
		function goal:can_unlock(data)
			return def:can_unlock(data)
		end
		if goal.trigger then
			local tdef = awards.registered_triggers[goal.trigger.type]
			assert(tdef, "Trigger not found: " .. goal.trigger.type)
			tdef:on_register(goal)
		end
	end

	def.goals.target = def.goals.target or #def.goals

	function def:can_unlock(data)
		if not self.requires then
			return true
		end

		for i=1, #self.requires do
			if not data.unlocked[self.requires[i]] then
				return false
			end
		end
		return true
	end

	-- Add Award
	awards.registered_awards[name] = def

	local tdef = awards.registered_awards[name]
	if def.description == nil and tdef.getDefaultDescription then
		def.description = tdef:getDefaultDescription()
	end
end


-- This function is called whenever a target condition is met.
-- It checks if a player already has that award, and if they do not,
-- it gives it to them
----------------------------------------------
--awards.unlock(name, award)
-- name - the name of the player
-- award - the name of the award to give
function awards.unlock(name, award, goal)
	-- Ensure the player is online.
	if not minetest.get_player_by_name(name) then
		return
	end

	-- Access Player Data
	local data  = awards.player(name)

	-- Do nothing if awards are disabled for the player
	if data.disabled then
		return
	end

	-- Check for full award+goal string submitted by triggers
	local separator_pos = award:find(GOAL_ID_SEPARATOR)
	if separator_pos then
		goal = award:sub(separator_pos + 1,-1)
		award = award:sub(1,separator_pos - 1)
	end

	-- Generate full goal string if we're unlocking a goal
	if goal then
		goal = award .. GOAL_ID_SEPARATOR .. goal
	end

	local awdef = awards.registered_awards[award]
	assert(awdef, "Unable to unlock an award which doesn't exist!")

	if not awdef:can_unlock(data) then
		minetest.log("warning", "can_unlock returned false in unlock of " ..
				award .. " for " .. name)
		return
	end

	-- Complete goal and proceed with award if target goals are complete
	if goal then
		if data.unlocked[goal] then
			return
		end
		data.unlocked[goal] = goal
		awards.save()
		local goals_unlocked = 0
		for _,goal in ipairs(awdef.goals) do
			if data.unlocked[goal.id] then
				goals_unlocked = goals_unlocked + 1
			end
		end
		if goals_unlocked < awdef.goals.target then
			return
		end
	end

	-- Return if award is already unlocked
	if data.unlocked[award] then
		return
	end

	-- Unlock Award
	minetest.log("action", name.." has unlocked award "..award)
	data.unlocked[award] = award
	awards.save()

	-- Give Prizes
	if awdef and awdef.prizes then
		for i = 1, #awdef.prizes do
			local itemstack = ItemStack(awdef.prizes[i])
			if not itemstack:is_empty() then
				local receiverref = minetest.get_player_by_name(name)
				if receiverref then
					receiverref:get_inventory():add_item("main", itemstack)
				end
			end
		end
	end

	-- Run callbacks
	if awdef.on_unlock and awdef.on_unlock(name, awdef) then
		return
	end
	for _, callback in pairs(awards.on_unlock) do
		if callback(name, awdef) then
			return
		end
	end

	-- Get Notification Settings
	local title = awdef.title or award
	local desc = awdef.description or ""
	local background = awdef.hud_background or awdef.background or "awards_bg_default.png"
	local icon = (awdef.icon or "awards_unknown.png") .. "^[resize:32x32"
	local sound = awdef.sound
	if sound == nil then
		-- Explicit check for nil because sound could be `false` to disable it
		sound = {name="awards_got_generic", gain=0.25}
	end

	-- Do Notification
	if sound then
		-- Enforce sound delay to prevent sound spamming
		local lastsound = data.lastsound
		if lastsound == nil or os.difftime(os.time(), lastsound) >= 1 then
			minetest.sound_play(sound, {to_player=name})
			data.lastsound = os.time()
		end
	end

	if awards.show_mode == "chat" then
		local chat_announce
		if awdef.secret then
			chat_announce = S("Secret Award Unlocked: %s")
		else
			chat_announce = S("Award Unlocked: %s")
		end
		-- use the chat console to send it
		minetest.chat_send_player(name, string.format(chat_announce, title))
		if desc~="" then
			minetest.chat_send_player(name, desc)
		end
	else
		local player = minetest.get_player_by_name(name)
		local one = player:hud_add({
			hud_elem_type = "image",
			name = "award_bg",
			scale = {x = 2, y = 1},
			text = background,
			position = {x = 0.5, y = 0.05},
			offset = {x = 0, y = 138},
			alignment = {x = 0, y = -1}
		})
		local hud_announce
		if awdef.secret then
			hud_announce = S("Secret Award Unlocked!")
		else
			hud_announce = S("Award Unlocked!")
		end
		local two = player:hud_add({
			hud_elem_type = "text",
			name = "award_au",
			number = 0xFFFFFF,
			scale = {x = 100, y = 20},
			text = hud_announce,
			position = {x = 0.5, y = 0.05},
			offset = {x = 0, y = 45},
			alignment = {x = 0, y = -1}
		})
		local three = player:hud_add({
			hud_elem_type = "text",
			name = "award_title",
			number = 0xFFFFFF,
			scale = {x = 100, y = 20},
			text = title,
			position = {x = 0.5, y = 0.05},
			offset = {x = 0, y = 100},
			alignment = {x = 0, y = -1}
		})
		local four = player:hud_add({
			hud_elem_type = "image",
			name = "award_icon",
			scale = {x = 2, y = 2}, -- adjusted for 32x32 from x/y = 4
			text = icon,
			position = {x = 0.5, y = 0.05},
			offset = {x = -200.5, y = 126},
			alignment = {x = 0, y = -1}
		})
		minetest.after(4, function()
			local player2 = minetest.get_player_by_name(name)
			if player2 then
				player2:hud_remove(one)
				player2:hud_remove(two)
				player2:hud_remove(three)
				player2:hud_remove(four)
			end
		end)
	end
end

function awards.remove(name, award)
	local data  = awards.player(name)
	local awdef = awards.registered_awards[award]
	assert(awdef, "Unable to remove an award which doesn't exist!")

	if data.disabled or
			(not data.unlocked[award]) then
		return
	end

	minetest.log("action", "Award " .. award .." has been removed from ".. name)
	data.unlocked[award] = nil
	awards.save()
end

local function sorter(a,b)
	return a.score < b.score
end

function awards.get_award_states(name)
	local hash_is_unlocked = {}
	local retval = {}

	-- Add all unlocked awards
	local data = awards.player(name)
	if data and data.unlocked then
		for awardname, _ in pairs(data.unlocked) do
			local def = awards.registered_awards[awardname]
			if def then
				hash_is_unlocked[awardname] = true
				local difficulty = def.difficulty or 1
				local score = -1000000 + difficulty

				retval[#retval + 1] = {
					name     = awardname,
					def      = def,
					goals    = (function()
						local goals = {
							show_locked = def.goals.show_locked,
							show_unlocked = def.goals.show_unlocked,
						}
						if def.goals then
							for i = 1, #def.goals do
								local goal = def.goals[i]
								local progress = goal.get_progress and goal:get_progress(data)
								table.insert(goals,{
									def = goal,
									progress = progress,
									unlocked = data.unlocked[goal.id] and true or false,
								})
							end
						end
						return #goals > 0 and goals or nil
					end)(),
					unlocked = true,
					started  = true,
					score    = score,
					progress = nil,
				}
			end
		end
	end

	-- Add all locked awards
	local in_progress = {}
	local not_started = {}
	for _, def in pairs(awards.registered_awards) do
		if not hash_is_unlocked[def.name] and def:can_unlock(data) then
			local total_progress = { current = 0, target = 0 }
			local started = false
			local difficulty = def.difficulty or 1
			local score = difficulty
			if def.secret then
				score = 1000000
			end

			local award = {
				name     = def.name,
				def      = def,
				goals    = (function()
					local goals = {
						show_locked = def.goals.show_locked,
						show_unlocked = def.goals.show_unlocked,
					}
					if def.goals then
						local target = def.goals.target
						for i = 1, #def.goals do
							local goal = def.goals[i]
							local progress = goal.get_progress and goal:get_progress(data) or { current = data.unlocked[goal.id] and 1 or 0, target = 1 }
							total_progress.current = total_progress.current + progress.current
							total_progress.target = total_progress.target + progress.target
							local perc = progress.current / progress.target
							if perc > 0 then
								started = true
							end
							table.insert(goals,{
								def = goal,
								progress = progress,
								unlocked = data.unlocked[goal.id] and true or false,
							})
						end
					end
					return #goals > 0 and goals or nil
				end)(),
				unlocked = false,
				started  = started,
				score    = score,
				progress = total_progress,
			}

			if award.started then
				table.insert(in_progress,award)
			else
				table.insert(not_started,award)
			end
		end
	end

	-- Sort award categories
	table.sort(retval,sorter)
	table.sort(in_progress,sorter)
	table.sort(not_started,sorter)

	-- Append categories to the return value
	for _,award in ipairs(in_progress) do
		table.insert(retval,award)
	end
	for _,award in ipairs(not_started) do
		table.insert(retval,award)
	end

	-- Return complete list of awards
	return retval
end
