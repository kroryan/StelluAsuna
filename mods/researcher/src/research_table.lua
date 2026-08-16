-- Function to get formspec string
local function get_formspec(item)
  -- Set item info string
  local iteminfo = [[
    box[1,2.75;6,0.001;#00000099]
    hypertext[2.3,3.15;4,1.5;;<global halign=center>(place item above to set focus)]
  ]]
  if item then
    local description = minetest.registered_items[item] and minetest.registered_items[item].description:split("\n")[1]
    local groups = researcher.registered_items[item] and (function()
      local str = ""
      local grouplist = {}
      for group,_ in pairs(researcher.registered_items[item].groups) do
        table.insert(grouplist,group)
      end
      table.sort(grouplist)
      return table.concat(grouplist,", ")
    end)()
    iteminfo = string.format([[
      box[1,2.75;6,0.001;#00000099]
      hypertext[2.3,3;4,0.5;;<global halign=center size=24><b>%s</b>]
      hypertext[2.3,3.35;4,1.5;;<global halign=center size=18>%s]
    ]],
    description or "???",
    groups or "(groups unknown)")
  end

  return string.format([[
      size[8,9.1]
      box[0,0;7.8,5;#00000040]

      image[3.1,0.575;2,2;researcher_research_inventory_decor_%s.png]
      list[context;focus;3.5,1;1,1;0]
      listring[current_player;main]
      listring[context;focus]

      %s

      image[0,5.2;1,1;researcher_gui_hb_bg.png]
      image[1,5.2;1,1;researcher_gui_hb_bg.png]
      image[2,5.2;1,1;researcher_gui_hb_bg.png]
      image[3,5.2;1,1;researcher_gui_hb_bg.png]
      image[4,5.2;1,1;researcher_gui_hb_bg.png]
      image[5,5.2;1,1;researcher_gui_hb_bg.png]
      image[6,5.2;1,1;researcher_gui_hb_bg.png]
      image[7,5.2;1,1;researcher_gui_hb_bg.png]
      list[current_player;main;0,5.2;8,1;]
      list[current_player;main;0,6.35;8,3;8]
    ]],
    item and "active" or "inactive",
    iteminfo)
end

-- Function for refreshing infotext when node meta inventory changes
local function update_metadata(pos)
  local meta = minetest.get_meta(pos)
  local item = meta:get_inventory():get_stack("focus",1)
  if item and not item:is_empty() then
    local iname = item:get_name()
    item = minetest.registered_items[iname]
    description = ""
    if item and item.description then
      meta:set_string("infotext","Research Table: " .. item.description:split("\n")[1])
    end
    meta:set_string("formspec",get_formspec(iname))
  else
    meta:set_string("formspec",get_formspec(nil))
    meta:set_string("infotext","Research Table")
  end
end

-- Register research table node
minetest.register_node("researcher:research_table",{
  -- Node definition fields
  description = "Research Table",
  short_description = "Research Table",
  drawtype = "mesh",
  mesh = "research_table.obj",
  tiles = {
    { name = "researcher_research_table_frame.png" },
    { name = "researcher_research_table_surface.png" },
  },
  paramtype2 = "4dir",
  stack_max = 1,
  sounds = (function()
    if researcher.dependencies.default then
      return default.node_sound_wood_defaults()
    elseif researcher.dependencies.mcl_sounds then
      return mcl_sounds.node_sound_wood_defaults()
    else
      return nil -- no specific sounds
    end
  end)(),

  -- Set research table groups
  groups = {
    oddly_breakable_by_hand = 1,
  },

  -- Initialize research table data
  on_construct = function(pos)
    -- Set inventory size
    local meta = minetest.get_meta(pos)
    local inventory = meta:get_inventory()
		inventory:set_size("focus", 1)

    -- Set infotext
    meta:set_string("infotext","Research Table")

    -- Set meta formspec
    meta:set_string("formspec",get_formspec(nil))
  end,

  -- Drop inventory contents when destroyed
  on_destruct = function(pos)
    local item = minetest.get_meta(pos):get_inventory():get_stack("focus",1)
    if item and not item:is_empty() then
      minetest.add_item(pos,item)
    end
  end,

  -- Update infotext when inventory changes
  on_metadata_inventory_move = update_metadata,
  on_metadata_inventory_take = update_metadata,
  on_metadata_inventory_put = update_metadata,
})

-- Register research table crafting recipe
minetest.register_craft({
  output = "researcher:research_table",
  recipe = {
    {"group:stone", "group:stone", "group:stone"},
    {"group:wood",  "group:wood",  "group:wood"},
    {"group:wood",  "",            "group:wood"},
  },
})

-- Register ABM for activation particles
minetest.register_abm({
  label = "Researcher: Research Table Activation Particles",
  nodenames = {"researcher:research_table"},
  interval = 4,
  chance = 1,
  catch_up = false,
  action = function(pos)
    -- Do nothing if research table is empty
    if minetest.get_meta(pos):get_inventory():get_stack("focus",1):is_empty() then
      return
    end

    -- Show item particles to nearby players
    local radius = researcher.settings.research_table_player_radius
    for object in minetest.objects_in_area(pos:add(-2),pos:add(2)) do
      if object:is_player() then
        minetest.add_particlespawner({
          playername = object:get_player_name(),
          amount = 16,
          time = 4,
          pos = {
            min = pos:add(vector.new(-0.6,0,-0.6)),
            max = pos:add(vector.new(0.6,0,0.6)),
          },
          minsize = 1,
          maxsize = 1.5,
          minvel = { x = 0, y = 0.05, z = 0 },
          maxvel = { x = 0, y = 0.1, z = 0 },
          minacc = { x = 0, y = 0.1, z = 0 },
          maxacc = { x = 0, y = 0.2, z = 0 },
          minexptime = 4.5,
          maxexptime = 3,
          texture = "plus.png^[colorize:#ffff77^[opacity:180",
          glow = 14,
          collisiondetection = false,
        })
      end
    end
  end,
})