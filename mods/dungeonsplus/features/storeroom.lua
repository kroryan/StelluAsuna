local cids = {
  air = core.CONTENT_AIR,
  chest = core.get_content_id("default:chest"),
  shelf = core.get_content_id("vessels:shelf"),
  log = core.get_content_id("default:tree"),
  straw = core.get_content_id("farming:straw"),
  wood = core.get_content_id("default:wood"),
  slab = nil, -- get slab below after mods loaded
  bottle = core.get_content_id("vessels:glass_bottle"),
}

core.register_on_mods_loaded(function()
  cids.slab = core.get_content_id("stairs:slab_wood")
end)

local vs = vector.subtract

local function blocked(pos,vdata)
  return vdata[pos] ~= cids.air
end

local chest_on_construct = core.registered_nodes["default:chest"].on_construct

local loot_table = {
  function(chance) -- misc. materials
    local item
    if chance < 30 then
      item = "default:stick"
    elseif chance < 55 then
      item = "default:flint"
    elseif chance < 80 then
      item = "vessels:glass_bottle"
    else
      item = "default:paper " .. (chance % 5 + 1)
    end
    return item .. (chance % 2 == 1 and " 2" or "")
  end,
  function(chance) -- ore
    local item
    if chance < 65 then
      item = "default:coal_lump"
    elseif chance < 85 then
      item = "default:steel_ingot"
    elseif chance < 95 then
      item = "default:gold_ingot"
    elseif chance < 98 then
      item = "default:mese_crystal_fragment"
    elseif chance < 100 then
      item = "default:mese_crystal"
    else
      item = "default:diamond"
    end
    return item .. ((chance < 98 and chance % 2 == 1) and " 2" or "")
  end,
  function(chance) -- tools
    local tool
    local mod = "default"
    if chance < 21 then
      tool = "sword"
    elseif chance < 41 then
      tool = "axe"
    elseif chance < 61 then
      tool = "pick"
    elseif chance < 81 then
      tool = "hoe"
      mod = "farming"
    else
      tool = "shovel"
    end

    local material
    if chance < 40 then
      material = "wood"
    elseif chance < 80 then
      material = "stone"
    else
      material = "steel"
    end

    return mod .. ":" .. tool .. "_" .. material, true
  end,
  function(chance) -- food
    return chance < 70 and "default:apple" or "farming:bread"
  end,
  function(chance) -- wood
    return chance < 50 and "default:tree" or "default:wood"
  end,
  function(chance) -- stone
    local item
    if chance < 45 then
      item = "default:cobble"
    elseif chance < 85 then
      item = "default:stonebrick"
    elseif chance < 99 then
      item = "default:obsidian"
    else
      item = "default:mese"
    end
    return item .. (chance < 90 and ((" ") .. (chance % 5 + 1)) or "")
  end,
  function(chance) -- soil
    local item
    if chance < 34 then
      item = "default:dirt"
    elseif chance < 67 then
      item = "default:gravel"
    else
      item = "default:clay_lump"
    end
    return item .. " " .. (chance % 5 + 1)
  end,
}

local function generate_loot(pcgr)
  local chance = pcgr:next(1,100)
  local item, wear = loot_table[pcgr:next(1,#loot_table)](chance)
  item = ItemStack(item)
  if wear then
    item:add_wear(pcgr:next(20000,50000))
  end
  return item
end

local features = {
  small = {
    function(pos,vdata,va)
      vdata[pos] = cids.chest
      local vpos = va:position(pos)
      chest_on_construct(vpos)

      local pcgr = PcgRandom(core.hash_node_position(vpos))
      local meta = core.get_meta(vpos)
      local inv = meta:get_inventory()
      for i = 1, 32 do
        if pcgr:next(1,100) < 25 then
          inv:set_stack("main",i,generate_loot(pcgr))
        end
      end
      return true
    end,
    function(pos,vdata)
      vdata[pos] = cids.straw
      return false
    end,
    function(pos,vdata)
      vdata[pos] = cids.straw
      return false
    end,
    function(pos,vdata)
      vdata[pos] = cids.wood
      return false
    end,
    function(pos,vdata)
      vdata[pos] = cids.slab
      return false
    end,
    function(pos,vdata)
      vdata[pos] = cids.bottle
      return false
    end,
  },
  large = {
    function(pos,vdata,vparam2,ystride,zstride,pcgr) -- straw stack
      for x = -1, 1 do
        for z = -1, 1 do
          if x == 0 or z == 0 then
            vdata[pos + x + z * zstride] = cids.straw
            if x == 0 and z == 0 then
              vdata[pos + ystride] = cids.straw
            end
          end
        end
      end
    end,
    function(pos,vdata,vparam2,ystride,zstride,pcgr) -- log stack
      local orientation = pcgr:next(0,1) == 1 and 9 or 12
      for x = -1, 1 do
        for z = -1, 1 do
          local npos = pos + x + z * zstride
          vdata[npos] = cids.log
          vparam2[npos] = orientation
          if orientation == 9 then
            if x == 0 then
              vdata[npos + ystride] = cids.log
              vparam2[npos + ystride] = orientation
            end
          else
            if z == 0 then
              vdata[npos + ystride] = cids.log
              vparam2[npos + ystride] = orientation
            end
          end
        end
      end
    end,
    function(pos,vdata,vparam2,ystride,zstride,pcgr) -- lumber stack
      local orientation = pcgr:next(0,1)
      for x = -1, 1 do
        for z = -1, 1 do
          local npos = pos + x + z * zstride
          vdata[npos] = cids.wood
          if orientation == 0 then
            if x == 0 then
              vdata[npos + ystride] = cids.wood
            end
          else
            if z == 0 then
              vdata[npos + ystride] = cids.wood
            end
          end
        end
      end
    end,
  },
}

return {
  name = "Storeroom",
  surfaces = "floor",
  weight = 2,
  conditions = {
    mods = {
      function(mod,path)
        return mod == "default" and path
      end,
      function(mod,path)
        return mod == "farming" and path
      end,
      function(mod,path)
        return mod == "stairs" and path
      end,
      function(mod,path)
        return mod == "vessels" and path
      end,
    },
  },
  generate = function(data)
    local room = data.room
    local va = data.va
    local ystride = va.ystride
    local zstride = va.zstride
    local pos = va:indexp(room.min) + ystride
    local vdata = data.vdata
    local vparam2 = data.vparam2
    local pcgr = PcgRandom(pos)

    local size = vs(room.max,room.min)
    local xmin = 1
    local xmax = size.x - 1
    local zmin = 1
    local zmax = size.z - 1

    -- Add large feature if possible
    if size.x > 6 and size.z > 6 then
      local largepos = data.va:indexp(room.pos) + pcgr:next(-1,1) + pcgr:next(-1,1) * zstride
      if vdata[largepos - ystride] ~= cids.air then
        features.large[pcgr:next(1,#features.large)](largepos,vdata,vparam2,ystride,zstride,pcgr)
      end
    end

    -- Add small features
    for x = xmin, xmax do
      for z = zmin, zmax do repeat
        local npos = pos + x + z * zstride
        if blocked(npos,vdata) or not blocked(npos - ystride,vdata) then
          break
        end

        local against = false
        local p2 = 0
        for _,adj in ipairs({
          { npos + 1, 1 },
          { npos - 1, 3 },
          { npos + zstride, 0 },
          { npos - zstride, 2 },
        }) do
          if blocked(adj[1],vdata) then
            against = true
            p2 = adj[2]
            break
          end
        end

        if not against then
          break
        end

        if pcgr:next(1,100) < 14 then
          if features.small[pcgr:next(1,#features.small)](npos,vdata,va) then
            vparam2[npos] = p2
          end
        end
      until true end
    end

    return true
  end,
}
