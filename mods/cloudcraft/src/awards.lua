if cloudcraft.dependencies.awards then
  if cloudcraft.dependencies["3d_armor"] then
    awards.register_award("cloudcraft:weightless",{
      title = "Weightless",
      description = "Equip a full set of cloud armor",
      icon = "cloudcraft_inv_cloud_chestplate.png",
      difficulty = 145,
    })
  end

  awards.register_award("cloudcraft:cumulonimble",{
    title = "Cumulonimble",
    description = "Get a node's unique self-drop by digging with an appropriate cloud tool",
    icon = "cloudcraft_cloud_pickaxe.png",
    difficulty = 115,
  })
end