-- ------- --
--  ARMOR  --
-- ------- --

local sf = "astralcraft:star_fragment"

armor:register_armor(":astralcraft:star_helmet",{
  description = "Star Helmet",
  inventory_image = "astralcraft_inv_star_helmet.png",
  light_source = 5,
  groups = {
    armor_head = 1,
    armor_heal = 0,
    armor_use = 1500,
  },
  armor_groups = {
    fleshy = 5,
  },
  damage_groups = {
    cracky = 2,
  },
})

core.register_craft({
  recipe = {
    {sf, sf, sf},
    {sf, "", sf},
    {"", "", ""},
  },
  output = "astralcraft:star_helmet",
})

armor:register_armor(":astralcraft:star_chestplate",{
  description = "Star Chestplate",
  inventory_image = "astralcraft_inv_star_chestplate.png",
  light_source = 5,
  groups = {
    armor_torso = 1,
    armor_heal = 10,
    armor_use = 1500,
  },
  armor_groups = {
    fleshy = 20,
  },
  damage_groups = {
    cracky = 2,
  },
})

core.register_craft({
  recipe = {
    {sf, "", sf},
    {sf, sf, sf},
    {sf, sf, sf},
  },
  output = "astralcraft:star_chestplate",
})

armor:register_armor(":astralcraft:star_leggings",{
  description = "Star Leggings",
  inventory_image = "astralcraft_inv_star_leggings.png",
  light_source = 5,
  groups = {
    armor_legs = 1,
    armor_heal = 5,
    armor_use = 1500,
  },
  armor_groups = {
    fleshy = 15,
  },
  damage_groups = {
    cracky = 2,
  },
})

core.register_craft({
  recipe = {
    {sf, sf, sf},
    {sf, "", sf},
    {sf, "", sf},
  },
  output = "astralcraft:star_leggings",
})

armor:register_armor(":astralcraft:star_boots",{
  description = "Star Boots",
  inventory_image = "astralcraft_inv_star_boots.png",
  light_source = 5,
  groups = {
    armor_feet = 1,
    armor_heal = 0,
    armor_use = 1500,
  },
  armor_groups = {
    fleshy = 5,
  },
  damage_groups = {
    cracky = 2,
  },
})

core.register_craft({
  recipe = {
    {"", "", ""},
    {sf, "", sf},
    {sf, "", sf},
  },
  output = "astralcraft:star_boots",
})

-- ------------- --
--  BONUS ARMOR  --
-- ------------- --

local star_armors = {}
local armor_bonuses = {
  ["astralcraft:star_helmet"] = {
    fleshy = 0.05,
  },
  ["astralcraft:star_chestplate"] = {
    fleshy = 0.1,
  },
  ["astralcraft:star_leggings"] = {
    fleshy = 0.1,
  },
  ["astralcraft:star_boots"] = {
    fleshy = 0.05,
  },
}

local full_armor_set = {
  head = true,
  torso = true,
  legs = true,
  feet = true,
}

local function calculate_armor_bonus(player)
  local total_bonus_armor = {}
  local has_bonuses = false
  local set_counter = 0
  for element,armor in pairs(armor:get_weared_armor_elements(player) or {}) do
    if armor:find("^astralcraft:star_") then
      if full_armor_set[element] then
        set_counter = set_counter + 1
      end
      local bonuses = armor_bonuses[armor] or {}
      for group,bonus in pairs(bonuses) do
        total_bonus_armor[group] = (total_bonus_armor[group] or 1) - bonus
        has_bonuses = true
      end
    end

    local pname = player:get_player_name()
    if has_bonuses then
      star_armors[pname] = {
        armor = total_bonus_armor,
        light = (set_counter > 0) and ("astralcraft:star_armor_light_level_" .. (set_counter * 3 + 2)) or nil,
      }
    else
      armor_monoid.monoid:del_change(player,"astralcraft:star_armor_bonus")
      star_armors[pname] = nil
    end
  end
end

core.register_on_joinplayer(function(player)
  calculate_armor_bonus(player)
end)

armor:register_on_equip(function(player,index,item)
  if item:get_name():find("^astralcraft:star_") then
    calculate_armor_bonus(player)
  end
end)

armor:register_on_unequip(function(player,index,item)
  if item:get_name():find("^astralcraft:star_") then
    calculate_armor_bonus(player)
  end
end)

-- Grant extra armor to players who are wearing star armor in the moonlight
local armor_interval = 4
core.register_globalstep(function(dtime)
  armor_interval = armor_interval - dtime
  if armor_interval <= 0 then
    armor_interval = 4
    local time_of_day = core.get_timeofday()
    for player,bonus in pairs(star_armors) do
      player = core.get_player_by_name(player)
      if player then
        if (time_of_day < 0.205 or time_of_day > 0.76) and (core.get_natural_light(player:get_pos(),0) or 0) > 0 then -- in moonlight at night
          armor_monoid.monoid:add_change(player,bonus.armor,"astralcraft:star_armor_bonus")
        else -- no moonlight
          armor_monoid.monoid:del_change(player,"astralcraft:star_armor_bonus")
        end
      end
    end
  end
end)

-- ---------------- --
--  LIGHT EMISSION  --
-- ---------------- --

for i = 5, 14, 3 do
  core.register_craftitem(":astralcraft:star_armor_light_level_" .. i,{
    description = "Star Armor Light Level " .. i,
    inventory_image = "no_texture.png",
    light_source = i,
    groups = { not_in_creative_inventory = 1 },
  })
end

-- Grant armor light to players who are wearing a full set of star armor
if astralcraft.dependencies.wielded_light then
  wielded_light.register_player_lightstep(function(player)
    local bonus = star_armors[player:get_player_name()]
    if bonus and bonus.light then
      wielded_light.track_user_entity(player,"star_armor_light",bonus.light)
    else
      wielded_light.track_user_entity(player,"star_armor_light",nil)
    end
  end)
end

-- ------------ --
--  STAR CHARM  --
-- ------------ --

table.insert(armor.elements,"accessory")

armor:register_armor(":astralcraft:star_charm",{
  description = "Star Charm",
  inventory_image = "astralcraft_inv_star_charm.png",
  preview = "blank.png",
  texture = "blank.png",
  light_source = 3,
  groups = {
    armor_accessory = 1,
    armor_heal = 0,
    armor_use = 0,
  },
  armor_groups = {},
  damage_groups = {},
})

core.register_craft({
  recipe = {
    {"", "default:steel_ingot", ""},
    {sf, "", sf},
    {"", sf, ""},
  },
  output = "astralcraft:star_charm",
})

if asuna.content.stratosphere.astralcraft then
  local settings = astralcraft.settings.shooting_star
  astralcraft.register_shooting_star_spawner({
    interval_min = settings.interval_min,
    interval_max = settings.interval_max,
    chance_min = settings.chance_min + 10,
    chance_max = settings.chance_max,
    node_radius = settings.node_radius,
    chance_step = settings.chance_step + 5,
    y_min = settings.y_min,
    y_max = settings.y_max,
    is_player_eligible = function(self,player)
      local equipment = armor:get_weared_armor_elements(player)
      for element,armor in pairs(equipment) do
        if armor == "astralcraft:star_charm" then
          return true
        end
      end
      return false
    end,
  })
end