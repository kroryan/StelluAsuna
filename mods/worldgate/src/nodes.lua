--
-- Worldgate structure nodes
-- These get replaced with "real" nodes defined by games/mods/mapgen

for name,def in pairs({
  Extender1 = {
    color = "#00FF00",
    group = "worldgate_extender",
    group_value = 1,
  },
  Extender2 = {
    color = "#0000FF",
    group = "worldgate_extender",
    group_value = 2,
  },
  Extender3 = {
    color = "#FF00FF",
    group = "worldgate_extender",
    group_value = 3,
  },
}) do
  minetest.register_node("worldgate:structure_" .. name:lower(),{
    description = "Worldgate Structure Node: " .. name,
    groups = {
      not_in_creative_inventory = 1,
      oddly_breakable_by_hand = 1,
      [def.group] = def.group_value,
    },
    color = def.color,
  })
end