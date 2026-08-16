-- Scan all items for groups
minetest.register_on_mods_loaded(function()
  -- Reduce research difficulty for items not present in mapgen
  local mapgen_nodes = {}
  if researcher.settings.discount_mapgen < 0 then
    mapgen_nodes = {
      map_drop = function(self,node)
        local def = minetest.registered_nodes[node]
        if not def then
          return "<ndef>"
        end
  
        local drop = def.drop
        if not drop or drop == "" then
          self[node] = true
          return node
        elseif type(drop) == "string" then
          self[drop] = true
          return drop
        elseif type(drop) == "table" then
          for _,item in ipairs(drop.items or {}) do
            if type(item) == "table" then
              for _,i in ipairs(item.items) do
                self[i] = true
              end
            end
          end
        end
      end,
    }

    for _,def in pairs(minetest.registered_biomes) do
      for _,node_type in ipairs({
        "node_top",
        "node_filler",
        "node_stone",
        "node_water_top",
        "node_water",
        "node_river_water",
        "node_riverbed",
        "node_cave_liquid",
        "node_dungeon",
        "node_dungeon_alt",
        "node_dungeon_stair",
      }) do
        if def[node_type] then
          local node = def[node_type]
          if type(node) == "string" then
            mapgen_nodes[node] = true
            mapgen_nodes:map_drop(node)
          elseif type(node) == "table" then
            for _,n in ipairs(node) do
              if type(n) == "string" then
                mapgen_nodes[n] = true
                mapgen_nodes:map_drop(n)
              end
            end
          end
        end
      end
    end

    local read_schematics = {}
    for _,def in pairs(minetest.registered_decorations) do
      if (not def.deco_type or def.deco_type == "simple") and def.decoration then
        if type(def.decoration) == "string" then
          mapgen_nodes[def.decoration] = true
          mapgen_nodes:map_drop(def.decoration)
        elseif type(def.decoration) == "table" then
          for _,node in ipairs(def.decoration) do
            if type(node) == "string" then
              mapgen_nodes[node] = true
              local to = mapgen_nodes:map_drop(node)
            end
          end
        end
      elseif def.deco_type == "schematic" and def.schematic then
        local schematic
        if type(def.schematic) == "string" and not read_schematics[def.schematic] then
          read_schematics[def.schematic] = true
          schematic = minetest.read_schematic(def.schematic,{ write_yslice_prob = "none" })
        elseif type(def.schematic) == "table" then
          schematic = def.schematic
        end

        if schematic then
          for _,node in ipairs(schematic.data) do
            if type(node.name) == "string" and node.name ~= "air" then
              mapgen_nodes[node.name] = true
              mapgen_nodes:map_drop(node.name)
            end
          end
        end
      end
    end

    for _,def in pairs(minetest.registered_ores) do
      if type(def.ore) == "string" then
        mapgen_nodes[def.ore] = true
        mapgen_nodes:map_drop(def.ore)
      end
    end

    researcher.register_adjustment({
      name = "researcher:discount_mapgen",
      reason = "Item not abundant in the world",
      calculate = function(item)
        return (not mapgen_nodes[item]) and researcher.settings.discount_mapgen or 0
      end,
    })
  else
    researcher.register_adjustment({
      name = "researcher:discount_mapgen",
      reason = "Item not abundant in world",
      calculate = function() return 0 end,
    })
  end

  -- Register low stack discount
  local stack_max = researcher.dependencies.mcl_inventory and 64 or tonumber(minetest.settings:get("default_stack_max",99) or 99)
  local low_stack = {}
  if researcher.settings.discount_stack_max < 0 then
    researcher.register_adjustment({
      name = "researcher:discount_stack_max",
      reason = "Item has a stack max less than the default max",
      calculate = function(item)
        return low_stack[item] and researcher.settings.discount_stack_max or 0
      end,
    })
  else
    researcher.register_adjustment({
      name = "researcher:discount_stack_max",
      reason = "Item has a stack max less than the default max",
      calculate = function() return 0 end,
    })
  end

  -- Reduce research difficulty for items that are not craftable
  local not_craftable = {}
  if researcher.settings.discount_not_craftable < 0 then
    researcher.register_adjustment({
      name = "researcher:discount_not_craftable",
      reason = "Item is not craftable",
      calculate = function(item)
        return (not mapgen_nodes[item] and not_craftable[item]) and researcher.settings.discount_not_craftable or 0
      end,
    })
  else
    researcher.register_adjustment({
      name = "researcher:discount_not_craftable",
      reason = "Item is not craftable",
      calculate = function() return 0 end,
    })
  end

  -- Register items with Researcher
  for name,def in pairs(minetest.registered_items) do
    -- Get low stack data
    if def.tool_capabilities or ((def.stack_max or stack_max) < stack_max) then
      low_stack[name] = def.stack_max or (def.tool_capabilities and 1) or stack_max
    end

    -- Filter out unwanted groups
    local groups = def.groups
    local keep_groups = {}

    if groups then
      for group,value in pairs(groups) do
        if value > 0 and not researcher.excluded_groups[group] then
          table.insert(keep_groups,group)
        end
      end
    end

    -- Check for valid recipes
    local recipes = minetest.get_all_craft_recipes(name) or {}
    for _,recipe in ipairs(recipes) do
      if recipe.method == "normal" or recipe.method == "cooking" then
        recipes = 1
        break
      end
    end

    if recipes ~= 1 then
      not_craftable[name] = true
    end

    -- Register item
    researcher.register_item({
      name = name,
      points_per_level = researcher.settings.points_per_level,
      groups = keep_groups,
    })
  end
end)