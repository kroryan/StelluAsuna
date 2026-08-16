return function(award)
  local goals = {
    target = 50,
    show_locked = false,
  }

  for node,def in pairs(minetest.registered_nodes) do
    local groups = def.groups
    if def.is_ground_content and groups and groups.stone and groups.stone > 0 then
      table.insert(goals,{
        id = node:gsub(":","_"),
        description = "Mine " .. def.description,
        trigger = {
          type = "dig",
          target = 1,
          node = node,
        },
      })
    end
  end

  return {
    title = "Rock On",
    description = "Mine " .. goals.target .. " different types of stone",
    difficulty = 180,
    icon = "[inventorycube{default_stone.png{default_stone.png{default_stone.png",
    goals = goals,
  }
end