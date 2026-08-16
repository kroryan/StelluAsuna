if cloudcraft.dependencies["3d_armor"] then
  armor:register_armor_group("fall_damage_add_percent",100)

  armor:register_armor("cloudcraft:cloud_helmet",{
    description = "Cloud Helmet",
    inventory_image = "cloudcraft_inv_cloud_helmet.png",
    texture = "cloudcraft_cloud_helmet.png",
    groups = {
      armor_head = 1,
      armor_use = 10000,
      physics_gravity = -0.125,
      physics_jump = 0.05,
    },
    armor_groups = {
      fleshy = 2,
      fall_damage_add_percent = 25,
    },
    damage_groups = {},
  })

  local cc = "cloudcraft:cloud"

  core.register_craft({
    recipe = {
      {cc, cc, cc},
      {cc, "", cc},
      {"", "", ""},
    },
    output = "cloudcraft:cloud_helmet",
  })

  armor:register_armor("cloudcraft:cloud_chestplate",{
    description = "Cloud Chestplate",
    texture = "cloudcraft_cloud_chestplate.png",
    inventory_image = "cloudcraft_inv_cloud_chestplate.png",
    groups = {
      armor_torso = 1,
      armor_use = 10000,
      physics_gravity = -0.125,
      physics_jump = 0.05,
    },
    armor_groups = {
      fleshy = 4,
      fall_damage_add_percent = 25,
    },
    damage_groups = {},
  })

  core.register_craft({
    recipe = {
      {cc, "", cc},
      {cc, cc, cc},
      {cc, cc, cc},
    },
    output = "cloudcraft:cloud_chestplate",
  })

  armor:register_armor("cloudcraft:cloud_leggings",{
    description = "Cloud Leggings",
    inventory_image = "cloudcraft_inv_cloud_leggings.png",
    texture = "cloudcraft_cloud_leggings.png",
    groups = {
      armor_legs = 1,
      armor_use = 10000,
      physics_gravity = -0.125,
      physics_jump = 0.05,
    },
    armor_groups = {
      fleshy = 3,
      fall_damage_add_percent = 25,
    },
    damage_groups = {},
  })

  core.register_craft({
    recipe = {
      {cc, cc, cc},
      {cc, "", cc},
      {cc, "", cc},
    },
    output = "cloudcraft:cloud_leggings",
  })

  armor:register_armor("cloudcraft:cloud_boots",{
    description = "Cloud Boots",
    inventory_image = "cloudcraft_inv_cloud_boots.png",
    texture = "cloudcraft_cloud_boots.png",
    groups = {
      armor_feet = 1,
      armor_use = 10000,
      physics_gravity = -0.125,
      physics_jump = 0.05,
    },
    armor_groups = {
      fleshy = 1,
      fall_damage_add_percent = 25,
    },
    damage_groups = {},
  })

  core.register_craft({
    recipe = {
      {"", "", ""},
      {cc, "", cc},
      {cc, "", cc},
    },
    output = "cloudcraft:cloud_boots",
  })

  if cloudcraft.dependencies.awards then
    armor:register_on_equip(function(player, index, item)
      local equipment = armor:get_weared_armor_elements(player) or {}
      local elements = {}
      for element,armor in pairs(equipment) do
        if armor:find("^cloudcraft:") then
          elements[element] = true
        end
      end
      if elements.head and elements.torso and elements.legs and elements.feet then
        awards.unlock(player:get_player_name(),"cloudcraft:weightless")
      end
    end)
  end
end