for _,node in ipairs({
  "livingjungle:jungleground",
  "livingjungle:leafyjungleground",
}) do
  bottles.register_filled_bottle({
    target = node,
    replacement = "default:dirt",
  })
end