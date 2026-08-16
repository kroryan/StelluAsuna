return function(award)
  local goals = {
    target = 25,
    show_locked = false,
  }

  for bottle,def in pairs(bottles.registered_filled_bottles) do
    table.insert(goals,{
      id = bottle:gsub(":","_"),
      description = def.description:split("\n")[1],
    })
  end

  local ogbf = bottles.fill
  bottles.fill = function(itemstack,placer,target)
    local retval, bottle = ogbf(itemstack,placer,target)
    if bottle then
      awards.unlock(placer:get_player_name(),award,bottle:gsub(":","_"))
    end
    return retval
  end

  return {
    title = "Put a Cork in It",
    description = "Fill bottles with " .. goals.target .. " different substances",
    difficulty = 260,
    icon = bottles.registered_filled_bottles["bottles:bottle_of_water"].image,
    goals = goals,
  }
end