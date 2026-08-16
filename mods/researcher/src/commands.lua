local show_formspec = (function()
  if researcher.dependencies.sfinv and sfinv.enabled then
    return function(name)
      local player = minetest.get_player_by_name(name)
      sfinv.set_page(player,"researcher:player_research")
      return "Use the inventory (default key 'i') to perform research."
    end
  elseif researcher.dependencies.mcl_inventory then
    return function(name)
      return "Use the inventory (default key 'i') to perform research."
    end
  elseif researcher.dependencies.unified_inventory then
    return function(name)
      return "Use the inventory (default key 'i') to perform research."
    end
  elseif researcher.dependencies.i3 then
    return function(name)
      local player = minetest.get_player_by_name(name)
      i3.set_tab(player,"research")
      return "Use the inventory (default key 'i') to perform research."
    end
  else
    return function(name)
      minetest.show_formspec(name,"researcher:player_research",researcher.get_formspec(name))
    end
  end
end)()

minetest.register_chatcommand("research",{
  params = "<action> <value>",
  description = "interact with researcher",
  func = function(name,params)
    if params == "reset" then
      researcher.data["player_" .. name] = researcher.initialize_player_data(name)
      return true, "Research has been fully reset."
    end

    if params:find("^reset .+$") then
      local item = params:split(" ")[2]
      researcher.get_player_data(name).research[item] = nil
      researcher.save_player_data(name)
      return true, "Research has been reset for " .. item
    end

    if not params or params == "" or params == "show" then
      return true, show_formspec(name)
    end

    return false, "Unknown or incorrect researcher command"
  end
})