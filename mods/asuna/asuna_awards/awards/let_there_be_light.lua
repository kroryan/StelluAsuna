return function(award)
  local goals = {
    target = 1,
    show_locked = false,
  }

  for node,def in pairs(minetest.registered_nodes) do
    if def.light_source and def.light_source > 0 then
      table.insert(goals,{
        id = node:gsub(":","_"),
        description = "Place a " .. def.description,
        trigger = {
          type = "place",
          target = 1,
          node = node,
        },
      })
    end
  end

  return {
    title = "Let There Be Light",
    description = "Place any light",
    difficulty = 15,
    icon = "default_torch_on_floor.png",
    goals = goals,
  }
end