return function(award)
  local goals = {
    target = 25,
    show_locked = false,
  }

  for node,def in pairs(minetest.registered_nodes) do
    local groups = def.groups
    if groups and groups.tree and groups.tree > 0 then
      table.insert(goals,{
        id = node:gsub(":","_"),
        description = "Chop " .. def.description,
        trigger = {
          type = "dig",
          target = 1,
          node = node,
        },
      })
    end
  end

  return {
    title = "Paul Bunyan",
    description = "Chop " .. goals.target .. " different types of timber",
    difficulty = 180,
    icon = "[inventorycube{default_tree_top.png{default_tree.png{default_tree.png",
    goals = goals,
  }
end