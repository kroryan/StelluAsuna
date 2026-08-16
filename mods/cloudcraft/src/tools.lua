core.register_tool("cloudcraft:cloud_pickaxe",{
  description = "Cloud Pickaxe",
  inventory_image = "cloudcraft_cloud_pickaxe.png",
  tool_capabilities = {
    full_punch_interval = 2,
    groupcaps = {
      cracky = {
        maxlevel = 1,
        uses = 10,
        times = {
          [1] = 3.0,
          [2] = 2.0,
          [3] = 1.8,
        },
      },
    },
    damage_groups = {
      fleshy = 1,
    },
  },
  groups = {
    pickaxe = 1,
    cloud = 1,
  },
  sound = {
    breaks = "default_tool_breaks",
  },
})

local cc = "cloudcraft:cloud"
local st = "default:stick"

core.register_craft({
  recipe = {
    {cc, cc, cc},
    {"", st, ""},
    {"", st, ""},
  },
  output = "cloudcraft:cloud_pickaxe",
})

core.register_tool("cloudcraft:cloud_axe",{
  description = "Cloud Axe",
  inventory_image = "cloudcraft_cloud_axe.png",
  tool_capabilities = {
    full_punch_interval = 2,
    groupcaps = {
      choppy = {
        maxlevel = 1,
        uses = 10,
        times = {
          [1] = 3.0,
          [2] = 2.0,
          [3] = 1.8,
        },
      },
    },
    damage_groups = {
      fleshy = 1,
    },
  },
  groups = {
    axe = 1,
    cloud = 1,
  },
  sound = {
    breaks = "default_tool_breaks",
  },
})

core.register_craft({
  recipe = {
    {"", cc, cc},
    {"", st, cc},
    {"", st, ""},
  },
  output = "cloudcraft:cloud_axe",
})

core.register_tool("cloudcraft:cloud_shovel",{
  description = "Cloud Shovel",
  inventory_image = "cloudcraft_cloud_shovel.png",
  tool_capabilities = {
    full_punch_interval = 2,
    groupcaps = {
      crumbly = {
        maxlevel = 1,
        uses = 10,
        times = {
          [1] = 3.0,
          [2] = 2.0,
          [3] = 1.8,
        },
      },
    },
    damage_groups = {
      fleshy = 1,
    },
  },
  groups = {
    shovel = 1,
    cloud = 1,
  },
  sound = {
    breaks = "default_tool_breaks",
  },
})

core.register_craft({
  recipe = {
    {"", cc, ""},
    {"", st, ""},
    {"", st, ""},
  },
  output = "cloudcraft:cloud_shovel",
})

-- Override tool targets to implement self-drop when dug with cloud tools
local tool_groups = {
  cracky = "cloudcraft:cloud_pickaxe",
  choppy = "cloudcraft:cloud_axe",
  crumbly = "cloudcraft:cloud_shovel",
}

-- --------------- --
--  SPECIAL DROPS  --
-- --------------- --

local grant_self_drop_award = cloudcraft.dependencies.awards and function(player)
  awards.unlock(player:get_player_name(),"cloudcraft:cumulonimble")
end or function() end

core.register_on_mods_loaded(function()
  for node,def in pairs(core.registered_nodes) do
    local groups = def.groups or {}

    -- Get node drops as a normalized table
    local drops = (function()
      if not def.drop or def.drop == "" then
        return {
          max_items = 1,
          items = {
            {
              rarity = 1,
              items = { node },
            },
          },
        }
      elseif type(def.drop) == "string" then
        return {
          max_items = 1,
          items = {
            {
              rarity = 1,
              items = { def.drop },
            },
          },
        }
      else -- should be table, anything else is error
        local d = {}
        d.max_items = def.drop.max_items or 1
        d.items = def.drop.items or {
          rarity = 1,
          items = { node },
        }
        return d
      end
    end)()

    -- Add any supported self-drop groups to the node drops
    local has_self_drop = false
    local tools = {}
    for group,value in pairs(groups) do
      local tool = tool_groups[group]
      if tool and value > 0 then
        for i = #drops.items + 1, 2, -1 do
          drops.items[i] = drops.items[i - 1]
        end
        drops.items[1] = {
          tools = { tool },
          rarity = 1,
          items = { node },
        }
        tools[tool] = true
        has_self_drop = true
      end
    end

    -- Override node with new drops if new self-drops were added
    if has_self_drop then
      local ogadn = def.after_dig_node or function() end
      core.override_item(node,{
        drop = drops,
        after_dig_node = function(pos,oldnode,oldmeta,digger)
          local retval = ogadn(pos,oldnode,oldmeta,digger)
          if digger and digger:is_player() then
            local tool = digger:get_wielded_item():get_name()
            if tools[tool] then
              grant_self_drop_award(digger)
            end
          end
          return retval
        end
      })
    end
  end
end)