-- Initialize player research inventory
minetest.register_on_joinplayer(function(player)
  player:get_inventory():set_size("research",1)
end)

-- Set the subject of the player's research based on their research inventory
minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
  if inventory_info.listname == "research" or inventory_info.to_list == "research" or inventory_info.from_list == "research" then
    -- Get item info from research inventory
    local item = inventory:get_stack("research",1)

    -- Get player name and data
    local player_name = player:get_player_name()
    local player_data = researcher.get_player_data(player_name)

    -- Cache inventory empty status
    player_data.subject.is_empty = item:is_empty()

    -- Set the player's research subject if research inventory has an item in it
    local name = item:get_name()
    local subject = player_data.subject
    local description, groups
    if not item:is_empty() then
      subject.name = name
      subject.item = researcher.registered_items[name]
      subject.image = name
      description = minetest.registered_items[name]
      if description then
        subject.description = description.description:split("\n",1)[1]
      else
        subject.description = "???"
      end

      if subject.item then
        subject.groups = (function()
          local str = ""
          local grouplist = {}
          for group,_ in pairs(subject.item.groups) do
            table.insert(grouplist,group)
          end
          table.sort(grouplist)
          return table.concat(grouplist,", ")
        end)()
        subject.research = player_data.research[name]
      else
        subject.groups = "(groups unknown)"
        subject.research = nil
        subject.item = {
          name = "???",
          groups = {},
          adjustments = {},
        }
      end
    end

    -- Save player data
    researcher.save_player_data(player_name)

    return true
  end
  return false
end)