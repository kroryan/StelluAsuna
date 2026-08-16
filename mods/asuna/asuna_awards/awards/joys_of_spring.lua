return function(award)
  local goals = {
    target = 50,
    show_locked = false,
  }

  for node,def in pairs(minetest.registered_nodes) do
    local groups = def.groups
    if groups and groups.flower and groups.flower > 0 then
      table.insert(goals,{
        id = node:gsub(":","_"),
        description = "Pick " .. def.description,
        trigger = {
          type = "dig",
          target = 1,
          node = node,
        },
      })
    end
  end

  return {
    title = "Joys of Spring",
    description = "Pick " .. goals.target .. " different types of flower",
    difficulty = 140,
    icon = "flowers_rose.png",
    goals = goals,
  }
end