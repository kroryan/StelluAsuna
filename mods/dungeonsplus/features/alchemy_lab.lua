local cids = {
  air = core.CONTENT_AIR,
  shelf = dungeonsplus.dependencies.vessels and core.get_content_id("vessels:shelf") or nil,
  glass_bottle = dungeonsplus.dependencies.vessels and core.get_content_id("vessels:glass_bottle") or nil,
  steel_bottle = dungeonsplus.dependencies.vessels and core.get_content_id("vessels:steel_bottle") or nil,
  firefly = dungeonsplus.dependencies.vessels and dungeonsplus.dependencies.vessels and core.get_content_id("fireflies:firefly_bottle") or nil,
}

local vs = vector.subtract
local vn = vector.new

local plen = 2
local potions = {
  cids.glass_bottle,
  cids.steel_bottle,
}

-- Add crystals if too_many_stones is present
local crystals = {}
local clen = 0
if dungeonsplus.dependencies.too_many_stones then
  for _,crystal in ipairs({
    "amazonite",
    "amber",
    "amethyst",
    "celestine",
    "chalcanthite",
    "citrine",
    "crocoite",
    "eudialite",
    "heliodor",
    "kyanite",
    "prasiolite",
    "moonstone",
    "morion_quartz",
    "quartz",
    "rose_quartz",
    "smokey_quartz",
    "tourmaline_green",
    "tourmaline_paraiba",
    "tourmaline_pink",
    "vivianite",
  }) do
    table.insert(crystals,core.get_content_id("too_many_stones:" .. crystal .. "_crystal"))
    clen = clen + 1
  end
end

if dungeonsplus.dependencies.bottles then
  core.register_on_mods_loaded(function()
    for bottle,def in pairs(bottles.registered_filled_bottles) do
      table.insert(potions,core.get_content_id(bottle))
      plen = plen + 1
    end
    table.sort(potions)
  end)
end

local function random_crystal(pcgr)
  return crystals[pcgr:next(1,clen)]
end

local function random_bottle(pcgr)
  return potions[pcgr:next(1,plen)]
end

local vessel_shelf_on_construct = core.registered_nodes["vessels:shelf"].on_construct
local function generate_loot(pos)
  vessel_shelf_on_construct(pos)
  local pcgr = PcgRandom(core.hash_node_position(pos))
  local meta = core.get_meta(pos)
  local inv = meta:get_inventory()
  local items = 0
  for i = 1, 8*2 do
    if pcgr:next(1,100) < 25 then
      inv:set_stack("vessels",i,ItemStack(core.get_name_from_content_id(potions[pcgr:next(1,#potions)])))
      items = items + 1
    end
  end
  vessel_shelf_on_construct(pos)
end

return {
  name = "Alchemy Lab",
  surfaces = "floor",
  weight = 5,
  conditions = {
    room = {
      function(room)
        return room.enclosed.y
      end,
      function(room)
        local size = vs(room.max,room.min)
        return size.x > 7 and size.y > 3 and size.z > 7
      end,
    },
    mods = {
      function(mod,path)
        return mod == "default" and path
      end,
      function(mod,path)
        return mod == "vessels" and path
      end,
    },
  },
  generate = function(data)
    local room = data.room
    local vm = data.vm
    local va = data.va
    local ystride = data.va.ystride
    local zstride = data.va.zstride
    local pos = va:indexp(room.pos)
    local vdata = data.vdata
    local vparam2 = data.vparam2
    local pcgr = PcgRandom(pos)

    local size = vs(room.max,room.min)

    -- Ensure solid floor space to place alchemy table
    for x = -2, 2 do
      for z = -2, 2 do
        if vdata[pos + x + z * zstride - ystride] == cids.air then
          return false -- do not place table over air gaps
        end
      end
    end

    -- Place alchemy table
    vm:set_data(vdata)
    vm:set_param2_data(vparam2)
    core.place_schematic_on_vmanip(vm,room.pos,dungeonsplus.modpath .. "/schematics/alchemy_table.mts",0,nil,true,"place_center_x,place_center_z")
    vm:get_data(vdata)
    vm:get_param2_data(vparam2)

    -- Place loot in alchemy table shelves
    for y = 0, 1 do
      for _,adj in ipairs({ -1, 1, zstride, -zstride }) do
        local lootpos = pos + y * ystride + adj
        generate_loot(va:position(lootpos))
      end
    end

    -- Place potions/crystals on table
    for _,ppos in ipairs({
      pos + 1 + zstride + ystride,
      pos + 1 - zstride + ystride,
      pos - 1 + zstride + ystride,
      pos - 1 - zstride + ystride,
      pos + 2 + zstride + ystride,
      pos + 2 - zstride + ystride,
      pos - 2 + zstride + ystride,
      pos - 2 - zstride + ystride,
      pos + 1 + zstride * 2 + ystride,
      pos + 1 - zstride * 2 + ystride,
      pos - 1 + zstride * 2 + ystride,
      pos - 1 - zstride * 2 + ystride,
    }) do
      local chance = pcgr:next(1,100)
      if chance < 45 then
        vdata[ppos] = random_bottle(pcgr)
      elseif chance < 55 then
        vdata[ppos] = cids.firefly
      elseif clen > 0 and chance < 70 then
        vdata[ppos] = random_crystal(pcgr)
        vparam2[ppos] = 1
      end
    end

    -- Place alchemy hutches if possible
    if size.x > 6 or size.z > 6 then
      vm:set_data(vdata)
      vm:set_param2_data(vparam2)
      for _,wall in ipairs({
        {
          distance = room.pos.x - room.min.x,
          location = vn(room.min.x + 1,room.pos.y,room.pos.z),
          rotation = "180",
          check = function(self) -- FIXME check three nodes beneath cpos
            local cpos = va:indexp(self.location) - ystride
            for z = -1, 1 do
              if vdata[cpos + z * zstride] == cids.air then
                return false
              end
            end
            cpos = cpos + ystride - 1
            for y = -1, 1 do
              for z = -1, 1 do
                local ccpos = cpos + y * ystride + z * zstride
                if vdata[ccpos] == cids.air then
                  return false
                end
              end
            end
            return true
          end,
          loot = function(self)
            local pos = va:indexp(self.location)
            for z = -1, 1 do
              local lootpos = pos + ystride + z * zstride
              generate_loot(va:position(lootpos))
            end
          end,
        },
        {
          distance = room.max.x - room.pos.x,
          location = vn(room.max.x - 1,room.pos.y,room.pos.z),
          rotation = "0",
          check = function(self)
            local cpos = va:indexp(self.location) - ystride
            for z = -1, 1 do
              if vdata[cpos + z * zstride] == cids.air then
                return false
              end
            end
            local cpos = cpos + ystride + 1
            for y = -1, 1 do
              for z = -1, 1 do
                local ccpos = cpos + y * ystride + z * zstride
                if vdata[ccpos] == cids.air then
                  return false
                end
              end
            end
            return true
          end,
          loot = function(self)
            local pos = va:indexp(self.location)
            for z = -1, 1 do
              local lootpos = pos + ystride + z * zstride
              generate_loot(va:position(lootpos))
            end
          end,
        },
        {
          distance = room.pos.z - room.min.z,
          location = vn(room.pos.x,room.pos.y,room.min.z + 1),
          rotation = "90",
          check = function(self)
            local cpos = va:indexp(self.location) - ystride
            for x = -1, 1 do
              if vdata[cpos + x] == cids.air then
                return false
              end
            end
            cpos = cpos + ystride - zstride
            for y = -1, 1 do
              for x = -1, 1 do
                local ccpos = cpos + y * ystride + x
                if vdata[ccpos] == cids.air then
                  return false
                end
              end
            end
            return true
          end,
          loot = function(self)
            local pos = va:indexp(self.location)
            for x = -1, 1 do
              local lootpos = pos + ystride + x
              generate_loot(va:position(lootpos))
            end
          end,
        },
        {
          distance = room.max.z - room.pos.z,
          location = vn(room.pos.x,room.pos.y,room.max.z - 1),
          rotation = "270",
          check = function(self)
            local cpos = va:indexp(self.location) - ystride
            for x = -1, 1 do
              if vdata[cpos + x] == cids.air then
                return false
              end
            end
            cpos = cpos + ystride + zstride
            for y = -1, 1 do
              for x = -1, 1 do
                local ccpos = cpos + y * ystride + x
                if vdata[ccpos] == cids.air then
                  return false
                end
              end
            end
            return true
          end,
          loot = function(self)
            local pos = va:indexp(self.location)
            for x = -1, 1 do
              local lootpos = pos + ystride + x
              generate_loot(va:position(lootpos))
            end
          end,
        },
      }) do
        if wall.distance > 5 and wall:check() then
          core.place_schematic_on_vmanip(vm,wall.location,dungeonsplus.modpath .. "/schematics/alchemy_hutch.mts",wall.rotation,nil,true,"place_center_x,place_center_z")
          wall:loot()
        end
      end
      vm:get_data(vdata)
      vm:get_param2_data(vparam2)
    end

    return true
  end,
}