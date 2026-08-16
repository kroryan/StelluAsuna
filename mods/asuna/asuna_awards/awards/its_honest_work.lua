return function(award)
  local oghou = farming.hoe_on_use
  farming.hoe_on_use = function(itemstack, user, pointed_thing, uses)
    local retval = oghou(itemstack, user, pointed_thing, uses)
    if retval ~= nil then
      awards.unlock(user:get_player_name(),award)
    end
    return retval
  end

  return {
    title = "It's Honest Work",
    description = "Till soil for farming using a hoe",
    difficulty = 40,
    icon = "farming_tool_stonehoe.png",
  }
end