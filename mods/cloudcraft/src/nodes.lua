-- ----------- --
--  DEW DROPS  --
-- ----------- --

core.register_craftitem("cloudcraft:dew_drops",{
  description = "Dew Drops",
  inventory_image = "cloudcraft_dew_drops.png",
})

core.register_craft({
  type = "cooking",
  recipe = "cloudcraft:dew_drops",
  output = "cloudcraft:cloud",
  cooktime = 2,
})

-- -------- --
--  CLOUDS  --
-- -------- --

local vz = vector.zero
local ma = math.abs

local function cloud_iterate(pos,fns)
  local npos = vz()
  local mx, my, mz
  for z = -2, 2, 1 do
    npos.z = pos.z + z
    mz = ma(z)
    for y = -2, 2, 1 do
      npos.y = pos.y + y
      my = ma(y)
      for x = -2, 2, 1 do
        npos.x = pos.x + x
        mx = ma(x)
        local node = core.get_node(npos)
        if node.name == "cloudcraft:cloud" and node.param2 ~= 1 then
          if mx == 2 or my == 2 or mz == 2 then
            fns.outer(npos,node)
          else
            fns.inner(npos,node)
          end
        end
      end
    end
  end
end

local function noop()
  -- does nothing
end

local function cloud_disperse(pos,node)
  core.get_node_timer(pos):stop()
  core.remove_node(pos)
end

local function cloud_fragile(pos,node)
  if node.param2 == 0 then
    core.swap_node(pos,{ name = node.name, param2 = 2 })
    core.get_node_timer(pos):start(math.random(2,4))
  elseif node.param2 == 2 then
    cloud_disperse(pos,node)
  end
end

local function cloud_dig_light_low(pos)
  cloud_iterate(pos,{
    inner = cloud_fragile,
    outer = noop,
  })
end

local function cloud_dig_light_mid(pos)
  cloud_iterate(pos,{
    inner = cloud_disperse,
    outer = cloud_fragile,
  })
end

local function cloud_dig_light_high(pos)
  cloud_iterate(pos,{
    inner = cloud_disperse,
    outer = cloud_disperse,
  })
end

local cloud_dig_light_map = {
  [0] = cloud_dig_light_low,
  [1] = cloud_dig_light_low,
  [2] = cloud_dig_light_mid,
  [3] = cloud_dig_light_mid,
  [4] = cloud_dig_light_mid,
  [5] = cloud_dig_light_mid,
  [6] = cloud_dig_light_mid,
  [7] = cloud_dig_light_mid,
  [8] = cloud_dig_light_mid,
  [9] = cloud_dig_light_mid,
  [10] = cloud_dig_light_high,
  [11] = cloud_dig_light_high,
  [12] = cloud_dig_light_high,
  [13] = cloud_dig_light_high,
  [14] = cloud_dig_light_high,
}

core.register_node("cloudcraft:cloud",{
  description = "Cloud",
  drawtype = "glasslike",
  tiles = { "[fill:16x16:#F9F9F9F0" },
  use_texture_alpha = true,
  post_effect_color = "#F9F9F9F0",
  sunlight_propagates = false,
  light_source = 1,
  paramtype = "light",
  is_ground_content = false,
  walkable = false,
  climbable = false,
  groups = {
    oddly_breakable_by_hand = 1,
    dig_immediate = 3,
  },
  drop = {
    max_items = 1,
    items = {
      {
        tools = { "~cloudcraft:cloud_" },
        rarity = 1,
        items = { "cloudcraft:cloud" },
      },
      {
        rarity = 8,
        items = { "cloudcraft:dew_drops" },
      },
    },
  },
  sounds = nil,
  on_dig = function(pos, node, digger)
    local drops = core.node_dig(pos,node,digger)
    if digger and digger:is_player() then
      local tool = core.registered_items[digger:get_wielded_item():get_name()] or core.registered_items[""] or {}
      cloud_dig_light_map[math.min(14,tool.light_source or 0)](pos)
    end
    return drops
  end,
  on_timer = function(pos)
    local node = core.get_node(pos)
    if node.param2 == 2 then
      core.remove_node(pos)
    end
  end,
  after_place_node = function(pos, placer)
    if placer and placer:is_player() then
      local node = minetest.get_node(pos)
      node.param2 = 1
      minetest.set_node(pos, node)
    end
  end,
})

-- --------------- --
--  MAPGEN MARKER  --
-- --------------- --

-- Marker nodes that determine where random clouds should spawn
core.register_node("cloudcraft:cloud_marker",{
  -- Should be invisible and as unobtrusive as possible
  drawtype = "airlike",
  buildable_to = true,
  pointable = false,
  paramtype = "light",
  sunlight_propagates = true,
  groups = { not_in_creative_inventory = 1, fall_damage_add_percent = -100 },

  -- Unused marker nodes should harmlessly self-destruct after being given a
  -- fair chance to be replaced by mapgen
  on_construct = function(pos)
    core.get_node_timer(pos):start(5)
  end,
  on_timer = function(pos)
    if core.get_node(pos).name == "cloudcraft:cloud_marker" then
      core.remove_node(pos)
    end
  end,
})

core.register_chatcommand("pp",{
  params = "",
  -- Short parameter description.  See the below note.

  description = "",
  -- General description of the command's purpose.

  privs = {},
  -- Required privileges to run. See `core.check_player_privs()` for
  -- the format and see [Privileges] for an overview of privileges.

  func = function(name, param)
    local player = core.get_player_by_name(name)
    local physics = player:get_physics_override()
    local message = "pp " .. name .. ":\n"
    message = message .. "  speed: " .. physics.speed .. "\n"
    message = message .. "  jump: " .. physics.jump .. "\n"
    message = message .. "  gravity: " .. physics.gravity .. "\n"
    core.log(message)
  end,
})