-- Copyright (c) 2013-18 rubenwardy. MIT.

local S = awards.translator

function awards.get_formspec(name, to, sid)
	local formspec = ""
	local awards_list = awards.get_award_states(name)

	if #awards_list == 0 then
		formspec = formspec .. "label[3.9,1.5;"..minetest.formspec_escape(S("Error: No achivements available.")).."]"
		formspec = formspec .. "button_exit[4.2,2.3;3,1;close;"..minetest.formspec_escape(S("OK")).."]"
		return formspec
	end
	sid = awards_list[sid] and sid or 1

	-- Sidebar
	local sitem = awards_list[sid]
	local sdef = sitem.def
	if sdef and sdef.secret and not sitem.unlocked then
		formspec = formspec .. "label[1,2.75;"..
				minetest.formspec_escape(S("(Secret Award)")).."]"..
				"image[1,0;3,3;awards_unknown.png]"
		if sdef and sdef.description then
			formspec = formspec	.. "textarea[0.25,3.25;4.8,1.7;;"..
					minetest.formspec_escape(
							S("Unlock this award to find out what it is."))..";]"
		end
	else
		local title = sitem.name
		if sdef and sdef.title then
			title = sdef.title
		end
		local status = "@1"
		if sitem.unlocked then
			-- Don't actually use translator here. We define empty S() to fool the update_translations script
			-- into extracting that string for the templates.
			local function S(str)
				return str
			end
			status = S("@1 (unlocked)")
		end

		formspec = formspec .. "textarea[0.5,3.1;4.8,1.45;;" ..
			S(status, minetest.formspec_escape(title)) ..
			";]"

		if sdef and sdef.icon then
			formspec = formspec .. "image[0.45,0;3.5,3.5;" .. minetest.formspec_escape(sdef.icon) .. "]"  -- adjusted values from 0.6,0;3,3
		end

		-- List out goal progress
		if sitem.goals then
			local goal_list = "textlist[-0.05,5;3.9,3.7;goals;"
			local has_visible_goals = false
			local goals_target = sdef.goals.target
			local goals_unlocked = 0
			for i = 1, #sitem.goals do repeat
				local goal = sitem.goals[i]
				local goal_status
				local goal_progress = goal.progress and (" (" .. goal.progress.current .. "/" .. goal.progress.target .. ")") or ""
				if goal.unlocked then
					goals_unlocked = goals_unlocked + 1
					if not sitem.goals.show_unlocked then
						break
					else
						goal_status = "#25fc34✓ "
					end
				else
					if not sitem.goals.show_locked then
						break
					else
						goal_status = goal.progress and (goal.progress.current == 0 and "#aaaaaa☐ " or "#ffffff☐ ") or "#aaaaaa☐ "
					end
				end
				goal_list = goal_list .. goal_status .. minetest.formspec_escape(goal.def.description:split("\n")[1]) .. goal_progress .. ","
				has_visible_goals = true
			until true end

			-- Goal progress bar
			local goal_progress_bar = "box[-0.05,4.65;3.9,0.3;#191919]"
			local gpb_width = 3.9 * math.min(goals_unlocked / goals_target,1.0)
			if gpb_width > 0 then
				goal_progress_bar = goal_progress_bar .. "box[-0.05,4.65;" .. gpb_width .. ",0.3;#25fc34]"
			end
			--goal_progress_bar = goal_progress_bar .. "box[-0.05,5.05;3.9,0.05;#000000]"
			goal_progress_bar = goal_progress_bar .. "hypertext[0.295,4.7;3.9,0.4;;<global halign=center>" .. goals_unlocked .. " / " .. goals_target .. "]"

			-- Append formspec
			formspec = formspec .. goal_progress_bar .. (has_visible_goals and goal_list:sub(1,-2) or "") .. "]"
		end

		if sdef and sdef.description then
			formspec = formspec .. "box[-0.05,3.75;3.9,0.85;#000]"
			formspec = formspec	.. "textarea[0.25,3.75;3.9,0.85;;" ..
					minetest.formspec_escape(sdef.description) .. ";]"
		end
	end

	-- Create list box
	formspec = formspec .. "textlist[4,0;3.8,8.7;awards;"
	local first = true
	for _, award in pairs(awards_list) do
		local def = award.def
		if def then
			if not first then
				formspec = formspec .. ","
			end
			first = false

			if def.secret and not award.unlocked then
				formspec = formspec .. "#707070"..minetest.formspec_escape(S("(Secret Award)"))
			else
				local title = award.name
				if def and def.title then
					title = def.title
				end
				-- title = title .. " [" .. award.score .. "]"
				if award.unlocked then
					formspec = formspec .. "#25fc34" .. minetest.formspec_escape(title)
				elseif award.started then
					formspec = formspec .. "#ffffff".. minetest.formspec_escape(title)
				else
					formspec = formspec .. "#aaaaaa".. minetest.formspec_escape(title)
				end
			end
		end
	end
	return formspec .. ";"..sid.."]"
end


function awards.show_to(name, to, sid, text)
	if name == "" or name == nil then
		name = to
	end
	local data = awards.player(to)
	if name == to and data.disabled then
		minetest.chat_send_player(name, S("You've disabled awards. Type /awards enable to reenable."))
		return
	end
	if text then
		local awards_list = awards.get_award_states(name)
		if #awards_list == 0 then
			minetest.chat_send_player(to, S("Error: No award available."))
			return
		elseif not data or not data.unlocked  then
			minetest.chat_send_player(to, S("You have not unlocked any awards."))
			return
		end
		minetest.chat_send_player(to, string.format(S("%s’s awards:"), name))

		for str, _ in pairs(data.unlocked) do
			local def = awards.registered_awards[str]
			if def then
				if def.title then
					if def.description then
						minetest.chat_send_player(to, string.format("%s: %s", def.title, def.description))
					else
						minetest.chat_send_player(to, def.title)
					end
				else
					minetest.chat_send_player(to, str)
				end
			end
		end
	else
		local deco = ""
		if minetest.global_exists("default") then
			deco = default.gui_bg .. default.gui_bg_img
		end
		-- Show formspec to user
		minetest.show_formspec(to,"awards:awards",
			"size[8,8.6]" .. deco ..
			awards.get_formspec(name, to, sid))
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "awards:awards" then
		return false
	end
	if fields.quit then
		return true
	end
	local name = player:get_player_name()
	if fields.awards then
		local event = minetest.explode_textlist_event(fields.awards)
		if event.type == "CHG" then
			awards.show_to(name, name, event.index, false)
		end
	end

	return true
end)

if minetest.get_modpath("sfinv") then
	sfinv.register_page("awards:awards", {
		title = S("Awards"),
		on_enter = function(self, player, context)
			context.awards_idx = 1
		end,
		is_in_nav = function(self, player, context)
			local data = awards.player(player:get_player_name())
			return not data.disabled
		end,
		get = function(self, player, context)
			local name = player:get_player_name()
			return sfinv.make_formspec(player, context,
				awards.get_formspec(name, name, context.awards_idx),
				false)
		end,
		on_player_receive_fields = function(self, player, context, fields)
			if fields.awards then
				local event = minetest.explode_textlist_event(fields.awards)
				if event.type == "CHG" then
					context.awards_idx = event.index
					sfinv.set_player_inventory_formspec(player, context)
				end
			end
		end
	})

	local function check_and_reshow(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return
		end

		local context = sfinv.get_or_create_context(player)
		if context.page ~= "awards:awards" then
			return
		end

		sfinv.set_player_inventory_formspec(player, context)
	end

	awards.register_on_unlock(check_and_reshow)
end

if minetest.get_modpath("unified_inventory") ~= nil then
	unified_inventory.register_button("awards", {
		type = "image",
		image = "awards_ui_icon.png",
		tooltip = S("Awards"),
		action = function(player)
			local name = player:get_player_name()
			awards.show_to(name, name, nil, false)
		end,
	})
end
