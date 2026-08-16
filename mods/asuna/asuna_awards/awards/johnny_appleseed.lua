return function(award)
  local goals = {
    target = 25,
    show_locked = false,
  }

  for node,def in pairs(minetest.registered_nodes) do
    local groups = def.groups
    if groups and groups.sapling and groups.sapling > 0 then
      table.insert(goals,{
        id = node:gsub(":","_"),
        description = "Plant a " .. def.description,
        trigger = {
          type = "place",
          target = 1,
          node = node,
        },
      })
    end
  end

  return {
    title = "Johnny Appleseed",
    description = "Plant " .. goals.target .. " different types of tree sapling",
    difficulty = 130,
    icon = "default_sapling.png",
    goals = goals,
  }
end