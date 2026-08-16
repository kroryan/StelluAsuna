-- Logging for successfully generated worldgates
worldgate.reigster_on_worldgate_generated(function(pos,gate,strategy)
  minetest.log("action","Worldgate generated at " .. minetest.pos_to_string(pos) .. " using the " .. strategy .. " strategy")
end)

-- Logging for worldgates that failed to generate
worldgate.reigster_on_worldgate_failed(function(gate)
  minetest.log("warning","Worldgate failed to generate" .. (gate.exact and " at " or " near ") .. minetest.pos_to_string(gate.position))
end)