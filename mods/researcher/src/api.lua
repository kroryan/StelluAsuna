-- ----------------- --
--  GROUP FUNCTIONS  --
-- ----------------- --

-- Add an item to a group
function researcher.add_item_to_group(item,group)
  researcher.groups[group] = researcher.groups[group] or {}
  researcher.groups[group][item] = true
  return true
end

-- Iterate over items in a group
function researcher.for_item_in_group(group,fn)
  for item,_ in pairs(researcher.groups[group]) do
    if fn(item) then
      return true
    end
  end
  return true
end

-- Iterate over groups of an item
function researcher.for_group_in_item(item,fn)
  item = researcher.registered_items[item]
  if not item then
    return false
  end

  for group,_ in pairs(item.groups) do
    if fn(group) then
      return true
    end
  end
  return true
end

-- Determine if item is in a specific group
function researcher.is_item_in_group(item,group)
  return researcher.groups[group] and researcher.groups[group][item] and true or false
end

-- Determine if two items have any groups in common
function researcher.do_items_share_groups(item1,item2)
  item1 = researcher.registered_items[item1]
  item2 = researcher.registered_items[item2]
  if not item1 or not item2 then
    return false
  end

  for group,_ in pairs(item1.groups) do
    if item2.groups[group] then
      return true
    end
  end
  return false
end

-- ---------------- --
--  ITEM FUNCTIONS  --
-- ---------------- --

-- Register an item with Researcher
function researcher.register_item(def)
  -- Do not register duplicate items
  if researcher.registered_items[def.name] then
    return false
  end

  -- Create internal item definition
  local item = {
    name = def.name,
    groups = {},
  }

  -- Determine base research points per level for this item
  item.points_per_level = def.points_per_level

  -- Determine research point adjustments that apply to this item
  item.adjustments = {}
  for _,adjustment in ipairs(researcher.registered_adjustments) do
    local amount = adjustment.calculate(item.name)
    if amount ~= 0 then
      item.points_per_level = math.max(researcher.settings.points_per_research,item.points_per_level + amount)
      table.insert(item.adjustments,{
        name = adjustment.name,
        amount = amount,
      })
    end
  end

  -- Determine groups for this item
  local groups = def.groups or {}
  for _,group in ipairs(groups) do
    item.groups[group] = true
    researcher.add_item_to_group(def.name,group)
  end

  -- Register the item
  researcher.registered_items[def.name] = item

  return true
end

-- ---------------------- --
--  ADJUSTMENT FUNCTIONS  --
-- ---------------------- --

-- Register a adjustment function that will return a adjustment amount
function researcher.register_adjustment(def)
  -- Do not register duplicate adjustments
  if researcher.registered_adjustments[def.name] then
    return false
  end

  -- Register the new adjustment
  local adjustment = {
    name = def.name,
    reason = def.reason,
    calculate = def.calculate,
  }

  researcher.registered_adjustments[def.name] = adjustment
  table.insert(researcher.registered_adjustments,adjustment)

  return true
end

function researcher.get_adjustments_for_item(item)
  item = researcher.registered_items[item]
  if not item then
    return {}
  end

  return item.adjustments
end

-- ----------------- --
--  BONUS FUNCTIONS  --
-- ----------------- --

-- Register a bonus
function researcher.register_bonus(def)
  -- Do not register duplicate bonuses
  if researcher.registered_bonuses[def.name] then
    return false
  end

  -- Register the new bonus
  local bonus = {
    name = def.name,
    reason = def.reason,
    calculate = def.calculate,
    initialize_player_data = def.initialize_player_data or function() end,
  }

  researcher.registered_bonuses[def.name] = bonus
  table.insert(researcher.registered_bonuses,bonus)

  return true
end

-- ---------------- --
--  DATA FUNCTIONS  --
-- ---------------- --

-- Initialize player data
function researcher.initialize_player_data(player_name)
  -- Create new player data
  local player_data = {
    -- The player's name
    name = player_name,

    -- All of the player's research progress indexed by item name
    research = {},

    -- The current subject of the player's research
    subject = {
      image = nil,
      description = "",
      groups = "(Research an item on the left to see info)",
      research = nil,
    },
  }

  -- Initialize bonus-specific data
  for _,bonus in ipairs(researcher.registered_bonuses) do
    bonus.initialize_player_data(player_data)
  end

  -- Save initialized player data to mod storage
  researcher.save_player_data(player_name)

  -- Return initialized data
  return player_data
end

-- Get player data
function researcher.get_player_data(player_name)
  -- Attempt to load player data from cache
  local pstring = "player_" .. player_name
  local player_data = researcher.data[pstring]
  if not player_data then
    -- Attempt to load player data from mod storage
    player_data = researcher.storage:get(pstring)

    -- Initialize new player data if not found or parse string if found
    if not player_data then
      player_data = researcher.initialize_player_data(player_name)
    else
      player_data = minetest.deserialize(player_data)
    end

    -- Link research subject to actual research
    if player_data.subject.research then
      player_data.subject.research = player_data.research[player_data.subject.item.name]
    end

    -- Cache player data
    researcher.data[pstring] = player_data
  end

  -- Return player data
  return player_data
end

-- Determine the number of points to the next level
-- FIXME should be (item,level)?
function researcher.get_points_to_next_level(player,item)
  item = researcher.registered_items[item]
  if item then
    local research = (type(player) == "string" and researcher.get_player_data(player) or player).research[item.name]
    if research then
      local level = research.level
      if research.level <= researcher.settings.level_max then
        return math.round(item.points_per_level * math.pow(research.level,researcher.settings.level_scale) / 100) * 100
      end
    end
  else
    return 0
  end
  return item.points_per_level
end

-- Save player data; can be called many times during the current tick but will
-- only execute once on the next tick
function researcher.save_player_data(player_name)
  if not researcher.data.save[player_name] then
    researcher.data.save[player_name] = true
    minetest.after(0,function()
      researcher.storage:set_string("player_" .. player_name,minetest.serialize(researcher.get_player_data(player_name)))
      researcher.data.save[player_name] = nil
    end)
  end
end

-- -------------------- --
--  RESEARCH FUNCTIONS  --
-- -------------------- --

-- Research an item
function researcher.research_item(player,item)
  -- Initialize result
  local result = {
    item = item,
    base = researcher.settings.points_per_research,
    bonuses = {},
    total = researcher.settings.points_per_research,
    success = true,
  }

  -- Get player data
  local player_data = type(player) == "string" and researcher.get_player_data(player) or player

  -- Cannot research beyond max research level
  if player_data.research[item] and player_data.research[item].level > researcher.settings.level_max then
    result = {
      item = item,
      base = 0,
      bonuses = {},
      total = 0,
      success = false,
    }
    return result
  end

  -- Calculate bonuses
  for _,bonus in ipairs(researcher.registered_bonuses) do
    local amount = bonus.calculate(item,player_data)
    if amount ~= 0 then
      result.total = result.total + amount
      table.insert(result.bonuses,{
        name = bonus.name,
        reason = bonus.reason,
        points = amount,
      })
    end
  end

  -- Get research entry
  local research = player_data.research[item] or {
    level = 1,
    points = 0,
  }
  player_data.research[item] = research
  player_data.subject.research = research

  -- Look up item
  item = researcher.registered_items[item]

  if not item then
    return {
      item = "???",
      base = 0,
      bonuses = {},
      total = 0,
      success = false,
    }
  end

  -- Level up research
  local points_tally = research.points + result.total
  local points_level = researcher.get_points_to_next_level(player_data,item.name)
  while points_tally >= points_level do
    research.level = math.min(researcher.settings.level_max + 1,research.level + 1)
    points_tally = points_tally - points_level
    points_level = researcher.get_points_to_next_level(player_data,item.name)
  end
  research.points = points_tally

  -- Unlock award for basic research
  if researcher.settings.awards then
    awards.unlock(player.name,"researcher:apprentice")
  end

  -- Set points to 0 at max level and unlock Prodigious award
  if research.level > researcher.settings.level_max then
    research.points = 0
    if researcher.settings.awards then
      awards.unlock(player.name,"researcher:prodigious")
    end
  end

  -- Save data
  researcher.save_player_data(player_data.name)

  -- Return final research result
  return result
end

-- Research an ItemStack
function researcher.research_itemstack(player,itemstack)
  if itemstack:is_empty() then
    return {
      item = itemstack:get_name(),
      success = false,
      remainder = ItemStack(itemstack:get_name() .. " 0"),
    }
  end

  -- Get player data for entire stack
  local player_data = type(player) == "string" and researcher.get_player_data(player) or player

  -- Research each item in the stack individually
  local name = itemstack:get_name()
  local results = {
    name = name,
    success = false,
    remainder = ItemStack(name .. " 0"),
  }

  for i = 1, itemstack:get_count() do
    local result = researcher.research_item(player_data,name)
    results.success = results.success or result.success
    if result.success then
      table.insert(results,result)
    elseif player_data.research[name].level > researcher.settings.level_max then
      itemstack:set_count(itemstack:get_count() - i + 1)
      results.remainder = itemstack
      return results
    else
      return results
    end
  end

  -- Return all results
  return results
end

-- Research an entire inventory list
function researcher.research_inventory(player,inventory,list)
  -- Get player data
  local player_data = type(player) == "string" and researcher.get_player_data(player) or player

  -- Research each ItemStack in the inventory
  local results = {
    success = false,
  }

  for i = 1, inventory:get_size(list) do
    local itemstack = inventory:get_stack(list,i)
    local result = researcher.research_itemstack(player_data,itemstack)
    results.success = results.success or result.success
    if result.success then
      inventory:set_stack(list,i,result.remainder)
    end
    table.insert(results,result)
  end

  -- Return full inventory results
  return results
end

-- ----------------------- --
--  DUPLICATION FUNCTIONS  --
-- ----------------------- --

-- Duplicate the item in the player's research inventory
function researcher.duplicate_research(player)
  local inventory = player:get_inventory()
  local itemstack = inventory:get_stack("research",1)
  if itemstack and not itemstack:is_empty() then
    local item = itemstack:get_name()
    local idef = minetest.registered_items[item]
    if idef then
      inventory:add_item("main",ItemStack(itemstack:get_name() .. " " .. itemstack:get_stack_max()))
    end
  end
end

-- --------------- --
--  GUI FUNCTIONS  --
-- --------------- --

-- Return a formspec that implements research
function researcher.get_formspec_data(player_name)
  local player_data = researcher.get_player_data(player_name)
  local subject = player_data.subject
  local data = {
    subject = subject,
    current_points = subject.research and subject.research.points or 0,
    points_to_next_level = subject.research and researcher.get_points_to_next_level(player_name,subject.item.name) or 0,
    is_max_level = subject.research and (subject.research.level > researcher.settings.level_max) and true or false,
    is_inventory_empty = minetest.get_inventory({ type = "player", name = player_name, }):get_stack("research",1):is_empty(),
    last_result = player_data.last_result,
  }
  player_data.last_result = nil -- last result is only available once immediately after research
  return data
end

-- -------------------- --
--  CALLBACK FUNCTIONS  --
-- -------------------- --

function researcher.register_on_research(fn)
  table.insert(researcher.registered_on_research,fn)
end