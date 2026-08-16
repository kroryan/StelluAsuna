-- Globals
researcher = {
  settings = {
    -- Research points and levels
    points_per_level = tonumber(minetest.settings:get("researcher.points_per_level",600) or 600),
    points_per_research = tonumber(minetest.settings:get("researcher.points_per_research",100) or 100),
    level_max = tonumber(minetest.settings:get("researcher.level_max",10) or 10),
    level_scale = tonumber(minetest.settings:get("researcher.level_scale",1.25) or 1.25),

    -- Bonuses for group research
    group_research_bonus = tonumber(minetest.settings:get("researcher.group_research_bonus",1) or 1),
    group_research_bonus_max = tonumber(minetest.settings:get("researcher.group_research_bonus_max",150) or 150),

    -- Bonuses for focused research
    focused_research_bonus_exact = tonumber(minetest.settings:get("researcher.focused_research_bonus_exact",5) or 5),
    focused_research_bonus_group = tonumber(minetest.settings:get("researcher.focused_research_bonus_group",1) or 1),
    focused_research_bonus_max = tonumber(minetest.settings:get("researcher.focused_research_bonus_max",150) or 150),

    -- Bonuses for using a research table
    research_table_bonus_exact = tonumber(minetest.settings:get("researcher.research_table_bonus_exact",25) or 25),
    research_table_bonus_group = tonumber(minetest.settings:get("researcher.research_table_bonus_group",5) or 5),
    research_table_adjacency_bonus = tonumber(minetest.settings:get("researcher.research_table_adjacency_bonus",10) or 10),
    research_table_adjacency_max = tonumber(minetest.settings:get("researcher.research_table_adjacency_max",10) or 10),
    research_table_adjacency_radius = tonumber(minetest.settings:get("researcher.research_table_adjacency_radius",3) or 3),
    research_table_player_radius = tonumber(minetest.settings:get("researcher.research_table_player_radius",2) or 2),
    research_table_bonus_max = tonumber(minetest.settings:get("researcher.research_table_bonus_max",150) or 150),

    -- Built-in item discount amounts
    discount_stack_max = tonumber(minetest.settings:get("researcher.discount_stack_max",-250) or -250),
    discount_mapgen = tonumber(minetest.settings:get("researcher.discount_mapgen",-400) or -400),
    discount_not_craftable = tonumber(minetest.settings:get("researcher.discount_not_craftable",-250) or -250),

    -- Use research awards
    awards = minetest.settings:get_bool("researcher.awards",true) and minetest.get_modpath("awards") and true or false,

    -- Groups that are excluded from group matching
    excluded_groups = minetest.settings:get("researcher.excluded_groups") or table.concat({
      "not_in_creative_inventory",
      "attached_node",
      "connect_to_raillike",
      "dig_immediate",
      "disable_jump",
      "disable_descend",
      "fall_damage_add_percent",
      "falling_node",
      "float",
      "level",
      "oddly_breakable_by_hand",
      "immortal",
      "disable_repair",
      "creative_breakable",
      "opaque",
      "solid",
    }," "),
  },

  -- Cached mod data
  data = {
    save = {},
  },

  -- Mod storage
  storage = minetest.get_mod_storage(),

  -- Registered data
  registered_items = {},
  registered_adjustments = {},
  registered_bonuses = {},
  registered_on_research = {},

  -- Item groups indexed by group name
  groups = {},

  -- Dependency info
  dependencies = (function(deps)
    for _,mod in ipairs({
      "default",
      "mcl_sounds",
      "mcl_inventory",
      "sfinv",
      "awards",
      "unified_inventory",
      "i3",
    }) do
      deps[mod] = minetest.get_modpath(mod)
    end
    return deps
  end)({}),
}

-- Get excluded groups from settings
researcher.excluded_groups = (function()
  local groups = researcher.settings.excluded_groups:split("[ \n\r\t]+",false,-1,true)
  local exclude = {}
  for _,group in ipairs(groups) do
    exclude[group] = true
  end
  return exclude
end)()

-- Load secondary files if the Research content pack is enabled in Asuna settings
if asuna.content.research.enabled then
  local mpath = minetest.get_modpath("researcher")
  local function runfile(file)
    dofile(mpath .. "/src/" .. file .. ".lua")
  end

  for _,file in ipairs({
    "api",
    "inventory",
    "bonuses",
    "research_table",
    "scan",
    "commands",
    "gui",
    "awards",
  }) do
    runfile(file)
  end
end