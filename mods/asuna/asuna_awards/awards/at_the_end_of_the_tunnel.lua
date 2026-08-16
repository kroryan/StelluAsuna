return function(award)
  -- Process all applicable TMS and Caverealms glow gems/minerals
  local goals = {}
  for _,node in ipairs({
    "caverealms:glow_amethyst",
    "caverealms:glow_crystal",
    "caverealms:glow_ruby",
    "caverealms:glow_emerald",
    "caverealms:glow_gem",
    "too_many_stones:glow_apatite",
    "too_many_stones:glow_calcite",
    "too_many_stones:glow_esperite",
    "too_many_stones:glow_fluorite",
    "too_many_stones:glow_selenite",
    "too_many_stones:glow_sodalite",
    "too_many_stones:glow_willemite",
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
    title = "At the End of the Tunnel",
    description = "Mine every underground glow gem and glow mineral",
    difficulty = 215,
    icon = "[inventorycube{tms_glow_willemite.png{tms_glow_willemite.png{tms_glow_willemite.png",
    goals = goals,
  }
end