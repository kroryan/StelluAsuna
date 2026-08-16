-- ----------------- --
--  LOCAL FUNCTIONS  --
-- ----------------- --

local function format_formspec(formspec,...)
  return string.format(string.gsub(formspec,"%-%-[^\n]*",""),...)
end

local get_ui = (function()
  if researcher.dependencies.sfinv and sfinv.enabled and not researcher.dependencies.i3 then
    -- Get sfinv formspec
    return function(player_name)
      local data = researcher.get_formspec_data(player_name)

      local status_string = "hypertext[0.3,2.3;4,4;;<global halign=center>(place item above to analyze)]"
      if data.last_result then
        status_string = "hypertext[0.3,2.3;4,4;;<global halign=center><i>Research successful!</i>\n\n" .. data.last_result .. "]"
      end

      local progress_bar = data.subject.image and string.format([[
        box[4.475,3.675;%f,0.625;#00ff00]
        image[4.45,3.65;3.65,0.8;researcher_research_points_border.png;7]
        hypertext[4.3,3.65;4,0.9;;<global valign=middle halign=center><b>Level %s</b>%s]
      ]],
      data.is_max_level and 2.85 or (2.85 * (data.current_points / data.points_to_next_level)),
      data.is_max_level and "MAX" or (data.subject.research and data.subject.research.level or 1),
      data.is_max_level and "" or ("\n" .. (data.subject.research and data.subject.research.points or 0) .. " / " .. researcher.get_points_to_next_level(player_name,data.subject.item.name)))

      local decor = data.is_inventory_empty and "inactive" or "active"

      return format_formspec([[
        -- Background boxes; research/duplication on the left, info/progress on the right
        box[0,0;3.8,4.9;#00000040]
        box[4,0;3.8,4.9;#00000040]

        -- Player's 1x1 research inventory with optional research/duplication button
        -- at the bottom
        image[1.5,0.8;1,1;researcher_gui_hb_bg.png]
        image[1.1,0.375;2,2;researcher_research_inventory_decor_%s.png]
        list[current_player;research;1.5,0.8;1,1;0]
        listring[current_player;main]
        listring[current_player;research]
        %s

        -- Current research item image, name, and groups
        item_image[5,0.2;2.2,2.2;%s]
        hypertext[4.3,2.3;4,0.5;;<global halign=center size=18><b>%s</b>]
        box[4.3,2.6;3.2,0.001;#00000099]
        hypertext[4.3,2.7;4,1.5;;<global halign=center>%s]

        -- Research level/points progress bar
        %s
      ]],
      decor,
      data.is_inventory_empty and status_string or string.format("button[0.4,3.3;3.15,1.6;%s;%s]",data.is_max_level and "duplicate" or "research",data.is_max_level and "Duplicate" or "Research"),
      data.subject.image or "",
      data.subject.description,
      data.subject.research and data.subject.groups or "(research to learn item groups)",
      progress_bar or "")
    end

  -- Get Mineclonia/VoxelLibre formspec
  elseif researcher.dependencies.mcl_inventory then
    return function(player_name)
      local data = researcher.get_formspec_data(player_name)

      local status_string = "hypertext[1,2.75;4.5,4;;<global halign=center>(place item above to analyze)]"
      if data.last_result then
        status_string = "hypertext[1,2.75;4.5,4;;<global halign=center><i>Research successful!</i>\n\n" .. data.last_result .. "]"
      end

      local progress_bar = data.subject.image and string.format([[
        box[6.55,4.41;%f,0.73;#00ff00]
        image[6.5,4.4;3.725,0.75;researcher_research_points_border.png;7]
        hypertext[6.1,4.325;4.5,0.9;;<global valign=middle halign=center><b>Level %s</b>%s]
      ]],
      data.is_max_level and 3.66 or (3.66 * (data.current_points / data.points_to_next_level)),
      data.is_max_level and "MAX" or (data.subject.research and data.subject.research.level or 1),
      data.is_max_level and "" or ("\n" .. (data.subject.research and data.subject.research.points or 0) .. " / " .. researcher.get_points_to_next_level(player_name,data.subject.item.name)))

      local decor = data.is_inventory_empty and "inactive" or "active"

      return format_formspec([[
        -- Background boxes; research/duplication on the left, info/progress on the right
        box[1,0.2;4.5,5.1;#00000040]
        box[6.1,0.2;4.5,5.1;#00000040]

        -- Player's 1x1 research inventory with optional research/duplication button
        -- at the bottom
        image[2.75,1;1,1;researcher_gui_hb_bg.png]
        image[2.25,0.5;2,2;researcher_research_inventory_decor_%s.png]
        list[current_player;research;2.75,1;1,1;0]
        listring[current_player;main]
        listring[current_player;research]
        %s

        -- Current research item image, name, and groups
        item_image[7.325,0.4;2,2;%s]
        hypertext[6.1,2.5;4.5,0.5;;<global halign=center size=18><b>%s</b>]
        box[6.5,2.8;3.75,0.001;#00000099]
        hypertext[6.1,2.9;4.5,1.5;;<global halign=center>%s]

        -- Research level/points progress bar
        %s
      ]],
      decor,
      data.is_inventory_empty and status_string or string.format("button[1.25,4.4;4,0.75;%s;%s]",data.is_max_level and "duplicate" or "research",data.is_max_level and "Duplicate" or "Research"),
      data.subject.image or "",
      data.subject.description,
      data.subject.research and data.subject.groups or "(research to learn item groups)",
      progress_bar or "")
    end

  -- Get Unified Inventory formspec
  elseif researcher.dependencies.unified_inventory then
    return function(player_name)
      local data = researcher.get_formspec_data(player_name)

      local status_string = "hypertext[0.5,2.75;4.5,4;;<global halign=center>(place item above to analyze)]"
      if data.last_result then
        status_string = "hypertext[0.5,2.75;4.5,4;;<global halign=center><i>Research successful!</i>\n\n" .. data.last_result .. "]"
      end

      local progress_bar = data.subject.image and string.format([[
        box[6.05,4.61;%f,0.73;#00ff00]
        image[6,4.6;3.725,0.75;researcher_research_points_border.png;7]
        hypertext[5.6,4.525;4.5,0.9;;<global valign=middle halign=center><b>Level %s</b>%s]
      ]],
      data.is_max_level and 3.66 or (3.66 * (data.current_points / data.points_to_next_level)),
      data.is_max_level and "MAX" or (data.subject.research and data.subject.research.level or 1),
      data.is_max_level and "" or ("\n" .. (data.subject.research and data.subject.research.points or 0) .. " / " .. researcher.get_points_to_next_level(player_name,data.subject.item.name)))

      local decor = data.is_inventory_empty and "inactive" or "active"

      return format_formspec([[
        -- Background boxes; research/duplication on the left, info/progress on the right
        box[0.5,0.2;4.5,5.4;#00000040]
        box[5.6,0.2;4.5,5.4;#00000040]

        -- Player's 1x1 research inventory with optional research/duplication button
        -- at the bottom
        image[2.25,1;1,1;researcher_gui_hb_bg.png]
        image[1.75,0.5;2,2;researcher_research_inventory_decor_%s.png]
        list[current_player;research;2.25,1;1,1;0]
        listring[current_player;main]
        listring[current_player;research]
        %s

        -- Current research item image, name, and groups
        item_image[6.825,0.4;2,2;%s]
        hypertext[5.6,2.5;4.5,0.5;;<global halign=center size=18><b>%s</b>]
        box[6,2.8;3.75,0.001;#00000099]
        hypertext[5.6,2.9;4.5,1.5;;<global halign=center>%s]

        -- Research level/points progress bar
        %s
      ]],
      decor,
      data.is_inventory_empty and status_string or string.format("button[0.75,4.6;4,0.75;%s;%s]",data.is_max_level and "duplicate" or "research",data.is_max_level and "Duplicate" or "Research"),
      data.subject.image or "",
      data.subject.description,
      data.subject.research and data.subject.groups or "(research to learn item groups)",
      progress_bar or "")
    end

  -- Get i3 formspec
  elseif researcher.dependencies.i3 then
    return function(player_name)
      local data = researcher.get_formspec_data(player_name)

      local status_string = "hypertext[0.5,3.05;4.5,4;;<global halign=center>(place item above to analyze)]"
      if data.last_result then
        status_string = "hypertext[0.5,3.05;4.5,4;;<global halign=center><i>Research successful!</i>\n\n" .. data.last_result .. "]"
      end

      local progress_bar = data.subject.image and string.format([[
        box[5.75,4.925;%f,0.715;#00ff00]
        image[5.7,4.9;3.725,0.75;researcher_research_points_border.png;7]
        hypertext[5.3,4.825;4.5,0.9;;<global valign=middle halign=center><b>Level %s</b>%s]
      ]],
      data.is_max_level and 3.64 or (3.64 * (data.current_points / data.points_to_next_level)),
      data.is_max_level and "MAX" or (data.subject.research and data.subject.research.level or 1),
      data.is_max_level and "" or ("\n" .. (data.subject.research and data.subject.research.points or 0) .. " / " .. researcher.get_points_to_next_level(player_name,data.subject.item.name)))

      local decor = data.is_inventory_empty and "inactive" or "active"

      return format_formspec([[
        -- Background boxes; research/duplication on the left, info/progress on the right
        box[0.5,0.5;4.5,5.4;#00000040]
        box[5.3,0.5;4.5,5.4;#00000040]

        -- Player's 1x1 research inventory with optional research/duplication button
        -- at the bottom
        image[2.25,1.3;1,1;researcher_gui_hb_bg.png]
        image[1.75,0.8;2,2;researcher_research_inventory_decor_%s.png]
        list[current_player;research;2.25,1.3;1,1;0]
        listring[current_player;main]
        listring[current_player;research]
        %s

        -- Current research item image, name, and groups
        item_image[6.525,0.7;2,2;%s]
        hypertext[5.3,2.8;4.5,0.5;;<global halign=center size=18><b>%s</b>]
        box[5.7,3.1;3.75,0.001;#00000099]
        hypertext[5.3,3.2;4.5,1.5;;<global halign=center>%s]

        -- Research level/points progress bar
        %s
      ]],
      decor,
      data.is_inventory_empty and status_string or string.format("button[0.75,4.9;4,0.75;%s;%s]",data.is_max_level and "duplicate" or "research",data.is_max_level and "Duplicate" or "Research"),
      data.subject.image or "",
      data.subject.description,
      data.subject.research and data.subject.groups or "(research to learn item groups)",
      progress_bar or "")
    end

  -- Get universal formspec
  else
    return function(player_name)
      local data = researcher.get_formspec_data(player_name)

      local status_string = "hypertext[0.3,2.3;4,4;;<global halign=center>(place item above to analyze)]"
      if data.last_result then
        status_string = "hypertext[0.3,2.3;4,4;;<global halign=center><i>Research successful!</i>\n\n" .. data.last_result .. "]"
      end

      local progress_bar = data.subject.image and string.format([[
        box[4.475,3.675;%f,0.625;#00ff00]
        image[4.45,3.65;3.65,0.8;researcher_research_points_border.png;7]
        hypertext[4.3,3.65;4,0.9;;<global valign=middle halign=center><b>Level %s</b>%s]
      ]],
      data.is_max_level and 2.85 or (2.85 * (data.current_points / data.points_to_next_level)),
      data.is_max_level and "MAX" or (data.subject.research and data.subject.research.level or 1),
      data.is_max_level and "" or ("\n" .. (data.subject.research and data.subject.research.points or 0) .. " / " .. researcher.get_points_to_next_level(player_name,data.subject.item.name)))

      local decor = data.is_inventory_empty and "inactive" or "active"

      return format_formspec([[
        -- sfinv size + padding
        size[8,9.1]

        -- Background boxes; research/duplication on the left, info/progress on the right
        box[0,0;3.8,4.9;#00000040]
        box[4,0;3.8,4.9;#00000040]

        -- Player's 1x1 research inventory with optional research/duplication button
        -- at the bottom
        image[1.5,0.8;1,1;researcher_gui_hb_bg.png]
        image[1.1,0.375;2,2;researcher_research_inventory_decor_%s.png]
        list[current_player;research;1.5,0.8;1,1;0]
        listring[current_player;main]
        listring[current_player;research]
        %s

        -- Current research item image, name, and groups
        item_image[5,0.2;2.2,2.2;%s]
        hypertext[4.3,2.3;4,0.5;;<global halign=center size=18><b>%s</b>]
        box[4.3,2.6;3.2,0.001;#00000099]
        hypertext[4.3,2.7;4,1.5;;<global halign=center>%s]

        -- Research level/points progress bar
        %s

        -- Player's main inventory a la sfinv
        image[0,5.2;1,1;researcher_gui_hb_bg.png]
        image[1,5.2;1,1;researcher_gui_hb_bg.png]
        image[2,5.2;1,1;researcher_gui_hb_bg.png]
        image[3,5.2;1,1;researcher_gui_hb_bg.png]
        image[4,5.2;1,1;researcher_gui_hb_bg.png]
        image[5,5.2;1,1;researcher_gui_hb_bg.png]
        image[6,5.2;1,1;researcher_gui_hb_bg.png]
        image[7,5.2;1,1;researcher_gui_hb_bg.png]
        list[current_player;main;0,5.2;8,1;]
        list[current_player;main;0,6.35;8,3;8]
      ]],
      decor,
      data.is_inventory_empty and status_string or string.format("button[0.4,3.3;3.15,1.6;%s;%s]",data.is_max_level and "duplicate" or "research",data.is_max_level and "Duplicate" or "Research"),
      data.subject.image or "",
      data.subject.description,
      data.subject.research and data.subject.groups or "(research to learn item groups)",
      progress_bar or "")
    end
  end
end)()

local refresh_ui = (function()
  -- Refresh sfinv formspec
  if researcher.dependencies.sfinv and sfinv.enabled and not researcher.dependencies.i3 then
    return function(player)
      sfinv.set_player_inventory_formspec(player,sfinv.get_or_create_context(player))
    end

  -- Refresh Mineclone formspec
  elseif researcher.dependencies.mcl_inventory then 
    return function(player)
      mcl_inventory.update_inventory_formspec(player)
    end

  -- Refresh Unified Inventory formspec
  elseif researcher.dependencies.unified_inventory then
    return function(player)
      unified_inventory.set_inventory_formspec(player,"Research")
    end

  -- Refresh i3 formspec
  elseif researcher.dependencies.i3 then
    return function(player)
      i3.set_fs(player)
    end

  -- Refresh universal formspec
  else
    return function(player)
      local name = player:get_player_name()
      minetest.show_formspec(name,"researcher:player_research",get_ui(name))
    end
  end
end)()

local do_research = function(player,fields,refresh)
  if fields.research then
    local player_name = player:get_player_name()
    local inventory = player:get_inventory()
    local item = inventory:get_stack("research",1)
    if not item:is_empty() then
      -- Get research level to compare with after research
      local player_data = researcher.get_player_data(player_name)
      local research = player_data.research[item:get_name()]
      local level_before = 1
      if research then
        level_before = research.level
      end

      -- Perform research
      local results = researcher.research_inventory(player_name,inventory,"research")

      -- Aggregate results
      local totals = {
        items = 0,
        base = 0,
        bonuses = {},
      }
      for _,itemstack in ipairs(results) do
        for _,i in ipairs(itemstack) do
          totals.items = totals.items + 1
          totals.base = totals.base + i.base
          for _,bonus in ipairs(i.bonuses) do
            totals.bonuses[bonus.reason] = totals.bonuses[bonus.reason] or 0
            totals.bonuses[bonus.reason] = totals.bonuses[bonus.reason] + bonus.points
          end
        end
      end
      player_data.last_result = "Items researched: <style color=#0099cc>" .. totals.items .. "</style>\nBase points: <style color=#0099cc>" .. totals.base .. "</style>\n"
      for reason,points in pairs(totals.bonuses) do
        player_data.last_result = player_data.last_result .. reason .. ": " .. (points > 0 and "<style color=#00cc00>+" or "<style color=#cc0000>-") .. points .. "</style>\n"
      end

      -- Refresh UI
      if refresh ~= false then
        refresh_ui(player)
      end

      -- Determine level up progress
      research = player_data.research[item:get_name()]
      if research and research.level > level_before then
        -- Unlock eureka award
        if researcher.settings.awards then
          awards.unlock(player_name,"researcher:eureka")
        end

        -- Play research level up sound
        minetest.sound_play({
          name = "researcher_level_up",
          gain = 0.5,
        },{ to_player = player_name },true)
      else
        -- Play normal research sound
        minetest.sound_play({
          name = "researcher_research",
          gain = 0.1,
          pitch = 1 + (math.random(1,4) / 10),
        },{ to_player = player_name },true)
      end
    end
  elseif fields.duplicate then
    researcher.duplicate_research(player)
    minetest.sound_play({
      name = "researcher_duplicate",
      gain = 0.5,
      pitch = 1.5,
    },{ to_player = player_name },true)
  end
end

-- ------------------ --
--  GUI INTEGRATIONS  --
-- ------------------ --

-- Configure sfinv UI
if researcher.dependencies.sfinv and sfinv.enabled and not researcher.dependencies.i3 then
  sfinv.register_page("researcher:player_research",{
    title = "Research",
    get = function(self,player,context)
      return sfinv.make_formspec(player,context,get_ui(player:get_player_name()),true)
    end,
    is_in_nav = function()
      return true
    end,
    on_player_receive_fields = function(self,player,context,fields)
      do_research(player,fields)
    end,
  })

-- Configure Mineclonia/VoxelLibre UI
elseif researcher.dependencies.mcl_inventory then
  mcl_inventory.register_survival_inventory_tab({
    id = "research",
    description = "Research",
    item_icon = "researcher:research_table",
    show_inventory = true,
    build = function(player)
      return get_ui(player:get_player_name())
    end,
    handle = function(player, fields)
      do_research(player,fields)
    end,
  })

-- Configure Unified Inventory UI
elseif researcher.dependencies.unified_inventory then
  unified_inventory.register_page("Research",{
    get_formspec = function(player,formspec)
      return { formspec = formspec.standard_inv_bg .. get_ui(player:get_player_name()) }
    end,
  })

  unified_inventory.register_button("Research",{
    type = "image",
    image = "researcher_icon_black.png",
    tooltip = "Research",
    hide_lite = false,
  })

  minetest.register_on_player_receive_fields(function(player,formname,fields)
    if formname == "" and (fields.research or fields.duplicate) then
      do_research(player,fields)
      return
    end
  end)

-- Configure i3 UI
elseif researcher.dependencies.i3 then
  i3.new_tab("research",{
    description = "Research",
    slots = true,
    formspec = function(player, data, fs)
      fs(get_ui(player:get_player_name()))
    end,
    fields = function(player, data, fields)
      if fields.research or fields.duplicate then
        do_research(player,fields,false)
      end
    end,
  })

-- Configure universal/standalone UI
else
  minetest.register_on_player_receive_fields(function(player,formname,fields)
    if formname == "researcher:player_research" then
      do_research(player,fields)
      return
    end
  end)
end

-- Refresh UI when research inventory changes
minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
  if inventory_info.listname == "research" or inventory_info.to_list == "research" or inventory_info.from_list == "research" then
    refresh_ui(player)
    return true
  end
  return false
end)