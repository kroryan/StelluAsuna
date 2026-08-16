return function(award)
  local goals = {
    target = 20,
    show_locked = false,
  }

  for item,def in pairs(minetest.registered_items) do
    if def.on_use then
      table.insert(goals,{
        id = item:gsub(":","_"),
        description = "Eat " .. def.description,
        trigger = {
          type = "eat",
          target = 1,
          item = item,
        },
      })
    end
  end

  return {
    title = "Gourmand",
    description = "Eat 20 different food items",
    difficulty = 180,
    icon = "farming_bread.png",
    goals = goals,
  }
end