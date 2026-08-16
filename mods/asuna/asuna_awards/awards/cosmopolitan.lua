return function(award)
  -- Register goals for each base biome
  local goals = {}
  local biomes = {}
  local excluded_biomes = {
    mountain = true,
    underground = true,
    quicksand = true,
  }
  for _,biome in ipairs(asuna.biome_groups.base) do
    if not excluded_biomes[biome] then
      biomes[biome] = true
      table.insert(goals,{
        id = biome,
        description = "Explore " .. asuna.biomes[biome].name,
      })
    end
  end

  -- Register interval callback to check player biome
  asuna_awards.register_on_interval(award,function(player)
    local biome = minetest.get_biome_name(minetest.get_biome_data(player:get_pos()).biome)
    if biomes[biome] then
      return award, biome
    end
  end)

  -- Return award definition
  return {
    title = "Cosmopolitan",
    description = "Explore all Asuna surface biomes",
    difficulty = 400,
    icon = "server_favorite.png",
    goals = goals,
  }
end