-- Research level group bonus
if researcher.settings.group_research_bonus > 0 and researcher.settings.group_research_bonus_max > 0 then
  researcher.register_bonus({
    name = "researcher:research_group_research_bonus",
    reason = "Group Research",
    calculate = function(item,player_data)
      local bonus = 0
      for subject,research in pairs(player_data.research) do
        if researcher.do_items_share_groups(item,subject) then
          bonus = bonus + (research.level - 1) * researcher.settings.group_research_bonus
        end
      end
      return bonus
    end,
    initialize_player_data = function()
      -- all bonus calculation comes from research; nothing to initialize
    end,
  })
else
  researcher.register_bonus({
    name = "researcher:research_group_research_bonus",
    reason = "Group Research",
    calculate = function() return 0 end,
    initialize_player_data = function()
      -- bonus is calculated from research; nothing to initialize
    end,
  })
end

-- Focused research bonus
if researcher.settings.focused_research_bonus_max > 0 and (researcher.settings.focused_research_bonus_exact > 0 or researcher.settings.focused_research_bonus_group > 0) then
  researcher.register_bonus({
    name = "researcher:focused_research_bonus",
    reason = "Focused Research",
    calculate = function(item,player_data)
      -- Calculate bonus value
      if item == player_data.focused_research.item then
        player_data.focused_research.bonus = player_data.focused_research.bonus + researcher.settings.focused_research_bonus_exact
      elseif researcher.do_items_share_groups(item,player_data.focused_research.item) then
        player_data.focused_research.bonus = player_data.focused_research.bonus + researcher.settings.focused_research_bonus_group
      else
        player_data.focused_research.bonus = 0
      end

      -- Set focused item
      player_data.focused_research.item = item

      -- Return capped bonus value
      player_data.focused_research.bonus = math.min(player_data.focused_research.bonus,researcher.settings.focused_research_bonus_max)
      return player_data.focused_research.bonus
    end,
    initialize_player_data = function(player_data)
      player_data.focused_research = {
        item = "",
        bonus = 0,
      }
    end,
  })
else
  researcher.register_bonus({
    name = "researcher:focused_research_bonus",
    reason = "Focused Research",
    calculate = function() return 0 end,
    initialize_player_data = function(player_data)
      player_data.focused_research = {
        item = "",
        bonus = 0,
      }
    end,
  })
end

-- Research table bonus
if researcher.settings.research_table_bonus_exact > 0 or researcher.settings.research_table_bonus_group > 0 or (researcher.settings.research_table_adjacency_bonus > 0 and researcher.settings.research_table_adjacency_max > 0) then
  researcher.register_bonus({
    name = "researcher:research_table_bonus",
    reason = "Research Table",
    calculate = function(item,player_data)
      -- Initialize bonus and max flag
      local bonus = 0
      local bonusmax = false

      -- Track limits when tallying bonuses
      local nadj = 0
      local function rtbonus(bonus,increment,adjacency)
        local result = bonus
        if adjacency then
          local adj_bounded = math.min(adjacency,researcher.settings.research_table_adjacency_max - nadj)
          nadj = nadj + adj_bounded
          result = result + researcher.settings.research_table_adjacency_bonus * adj_bounded
        else
          result = bonus + increment
        end
        return math.min(result,researcher.settings.research_table_bonus_max), (result >= researcher.settings.research_table_bonus_max or nadj >= researcher.settings.research_table_adjacency_max)
      end

      -- Scan radius around player for research tables
      local player = minetest.get_player_by_name(player_data.name)
      local research_table = nil
      if player then
        local pos = player:get_pos()
        local radius = researcher.settings.research_table_player_radius
        for _,rt in ipairs(minetest.find_nodes_in_area(pos:add(-radius),pos:add(radius),"researcher:research_table")) do
          -- Get research table's focus
          local meta = minetest.get_meta(rt)
          local inventory = meta:get_inventory()
          local itemstack = inventory:get_stack("focus",1)
          local name = itemstack:get_name()

          -- If the focus item matches the item in question, then add to the
          -- calculated bonus accordingly
          if item == name then
            bonus, bonusmax = rtbonus(bonus,(research_table and (researcher.settings.research_table_bonus_exact - researcher.settings.research_table_bonus_group) or researcher.settings.research_table_bonus_exact))
            if bonusmax then
              return bonus
            end
            research_table = rt
            break -- cannot do better than an exact match
          elseif not research_table and researcher.do_items_share_groups(item,name) then
            bonus, bonusmax = rtbonus(bonus,researcher.settings.research_table_bonus_group)
            if bonusmax then
              return bonus
            end
            research_table = rt
            -- keep scanning for better matches
          end
        end

        -- Calculate adjacency bonus for research table
        if research_table then
          local radius = researcher.settings.research_table_adjacency_radius
          local pos1 = research_table:add(-radius)
          local pos2 = research_table:add(radius)

          -- Check nearby node groups
          bonus, bonusmax = rtbonus(bonus,researcher.settings.research_table_adjacency_bonus,#minetest.find_nodes_in_area(pos1,pos2,(function()
            local groups = {}
            for group,_ in pairs(researcher.registered_items[item].groups) do
              table.insert(groups,"group:" .. group)
            end
            return groups
          end)()))
          if bonusmax then
            return bonus
          end

          -- Check nearby node inventories
          for _,node in ipairs(minetest.find_nodes_with_meta(pos1,pos2)) do
            if not node:equals(research_table) then
              local nodemeta = minetest.get_meta(node)
              local nodeinventory = nodemeta:get_inventory()
              if nodeinventory then
                for list,stacks in pairs(nodeinventory:get_lists() or {}) do
                  for _,itemstack in ipairs(stacks or {}) do
                    if not itemstack:is_empty() and researcher.do_items_share_groups(item,itemstack:get_name()) then
                      bonus, bonusmax = rtbonus(bonus,researcher.settings.research_table_adjacency_bonus,itemstack:get_count())
                      if bonusmax then
                        return bonus
                      end
                    end
                  end
                end
              end
            end
          end
        else
          return 0 -- no bonus if no research table was found
        end
      else
        return 0 -- no bonus if player is mysteriously not found
      end

      -- Return partial bonus total
      return bonus
    end,
  })
else
  researcher.register_bonus({
    name = "researcher:research_table_bonus",
    reason = "Research Table",
    calculate = function() return 0 end,
  })
end