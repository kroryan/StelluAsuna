return function(award)
  for _,bug in ipairs({
    "fireflies:firefly",
    "butterflies:butterfly_red",
    "butterflies:butterfly_white",
    "butterflies:butterfly_violet",
  }) do
    minetest.override_item(bug,{
      after_dig_node = function(pos,oldnode,oldmeta,digger)
        if digger:is_player() and digger:get_wielded_item():get_name() == "fireflies:bug_net" then
          awards.unlock(digger:get_player_name(),award)
        end
      end,
    })
  end

  return {
    title = "Net Worth",
    description = "Use a bug net to catch a butterfly or a firefly",
    difficulty = 55,
    icon = "fireflies_bugnet.png",
  }
end