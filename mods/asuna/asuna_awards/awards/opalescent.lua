return function(award)
  -- Process all applicable TMS opal
  local goals = { target = 1 }
  for _,node in ipairs({
    "too_many_stones:opal",
    "too_many_stones:black_opal",
    "too_many_stones:fire_opal",
  }) do
    table.insert(goals,{
      description = "Mine " .. minetest.registered_nodes[node].description,
      trigger = {
        type = "dig",
        target = 1,
        node = node,
      },
    })
  end

  -- Add triggers to award
  return {
    title = "Opalescent",
    description = "Mine any opal",
    difficulty = 205,
    icon = "[inventorycube{[combine:16x16:0,0=tms_opal_animated.png{[combine:16x16:0,0=tms_opal_animated.png{[combine:16x16:0,0=tms_opal_animated.png",
    goals = goals,
  }
end