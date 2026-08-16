return function(award)
  local goals = { target = 1 }

  for node,def in pairs(minetest.registered_nodes) do
    if node:find("^marinara:sand_with_seashells") then
      table.insert(goals,{
        id = node:gsub(":","_"),
        description = "Dig " .. def.description,
        trigger = {
          type = "dig",
          target = 1,
          node = node,
        },
      })
    end
  end

  return {
    title = "By the Seashore",
    description = "Dig up any seashells",
    difficulty = 10,
    icon = "[inventorycube{default_sand.png&marinara_seashells.png{default_sand.png&marinara_seashells.png{default_sand.png&marinara_seashells.png",
    goals = goals,
  }
end