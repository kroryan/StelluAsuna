for _,dirt in ipairs({
  "Bamboo",
  "Jungle",
  "Grove",
  "Prairie",
  "Cold",
  "Crystal",
  "Mushroom",
  "Fiery",
  "Gray",
}) do
  bottles.register_filled_bottle({
    target = "ethereal:" .. dirt:lower() .. "_dirt",
    description = "Bottle of " .. dirt .. " Dirt",
    replacement = "default:dirt",
  })
end