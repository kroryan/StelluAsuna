--
-- Worldgate linking functions
--

-- Telemosaic location hashing and unhashing functions
local function hash_pos(pos)
  return math.floor(pos.x + 0.5)..':'..
    math.floor(pos.y + 0.5)..':'..
    math.floor(pos.z + 0.5)
end

local function unhash_pos(hash)
	local list = string.split(hash, ':')
	local p = {
		x = tonumber(list[1]),
		y = tonumber(list[2]),
		z = tonumber(list[3])
	}
	if p.x and p.y and p.z then
		return p
	end
end

-- Polyfill for vector.in_area
if not vector.in_area then
  function vector.in_area(pos, min, max)
    return (pos.x >= min.x) and (pos.x <= max.x) and
      (pos.y >= min.y) and (pos.y <= max.y) and
      (pos.z >= min.z) and (pos.z <= max.z)
  end
end

-- Garbage collection index to manage force-loaded chunks
local forceloader = {
  index = {},
  load = function(self,blockpos)
    -- Get the reference counter for the mapblock
    local hash = minetest.hash_node_position(blockpos)
    local refcounter = self.index[hash] or 0

    -- Force-load mapblock if it is not yet force-loaded
    if refcounter == 0 then
      minetest.forceload_block(blockpos,true)
    end

    -- Store updated reference counter
    refcounter = refcounter + 1
    self.index[hash] = refcounter
  end,
  unload = function(self,blockpos)
    -- Get the reference counter for the mapblock
    local hash = minetest.hash_node_position(blockpos)
    local refcounter = self.index[hash] or 1

    -- Decrement reference counter and unload mapblock if there are no more
    -- references to it
    refcounter = refcounter - 1
    if refcounter == 0 then
      minetest.forceload_free_block(blockpos,true)
    end

    -- Store updated reference counter
    self.index[hash] = refcounter
  end,
}

-- Function for linking and force-loading gate destinations
function worldgate.link(pos)
  -- Get meta/destination
  local nodemeta = minetest.get_meta(pos)
  local destination = nodemeta:get("telemosaic:dest")
  local do_worldgate_link = false

  -- Check for worldgate destination and convert to vector
  local dpos = nil
  if not destination then
    dpos = nodemeta:get("worldgate:destination")
    if not dpos then
      return true
    end
    destination = minetest.string_to_pos(dpos)
    do_worldgate_link = true
  else
    destination = vector.new(unhash_pos(destination))
  end

  -- Look for players near this gate
  local players = minetest.get_connected_players()
  for i = 1, #players do
    -- If a player is found, then force-load the destination
    local player = players[i]
    if player and player:get_pos():in_area(pos:add(-32),pos:add(32)) then
      if not nodemeta:get("worldgate:player_nearby") then
        -- Define destination area to emerge
        local mapblock = destination:divide(16):floor():multiply(16)
        local emin = mapblock:add(vector.new(0,-32,0))
        local emax = mapblock:add(vector.new(0,47,0))

        -- Emerge the destination mapblocks
        minetest.emerge_area(emin,emax,function(blockpos,action,calls_remaining)
          -- Do worldgate link to Telemosaic if defined for this gate
          if calls_remaining == 0 then
            if do_worldgate_link then
              destination = nil
              local beacons = minetest.find_nodes_in_area(emin:add(vector.new(-1,-1,-1)),emax:add(vector.new(1,1,1)),"group:telemosaic")
              for beacon = 1, #beacons do
                beacon = beacons[beacon]
                local spos = minetest.get_meta(beacon):get("worldgate:source")
                if dpos == spos then
                  destination = beacon
                  nodemeta:set_string("telemosaic:dest",hash_pos(beacon))
                  break
                end
              end
            end

            if destination then
              -- Force-load destination mapblocks and own mapblock
              forceloader:load(pos:divide(16):floor())
              for p = -32, 32, 16 do
                forceloader:load(destination:add(vector.new(0,p,0)):divide(16):floor())
              end
            else
              -- Beacon cannot be linked
              minetest.swap_node(pos,{ name = "telemosaic:beacon_off", param2 = 0 })
              return false
            end
          end
        end)

        -- Flag this beacon as having a player nearby
        nodemeta:set_string("worldgate:player_nearby","1")
      end
      return true
    end
  end

  -- No players found, unload all force-loaded blocks and unflag the beacon
  if nodemeta:get("worldgate:player_nearby") then
    forceloader:unload(pos:divide(16):floor())
    for p = -32, 32, 16 do
      forceloader:unload(destination:add(vector.new(0,p,0)):divide(16):floor())
    end
    nodemeta:set_string("worldgate:player_nearby","")
  end
  return true
end

-- Run linking function on node timer
for _,beacon in ipairs({
  "telemosaic:beacon",
  "telemosaic:beacon_protected",
}) do
  minetest.override_item(beacon,{
    on_timer = worldgate.link,
  })
end

-- Queue for linking function calls
local linkq = {}

-- Run linking function when a player teleports
local tt = telemosaic.teleport
telemosaic.teleport = function(player,src,dest)
  tt(player,src,dest)
  dest.y = dest.y - 1
  worldgate.link(vector.new(src))
  worldgate.link(vector.new(dest))
end

-- Run linking function when a beacon changes its state
local tss = telemosaic.set_state
telemosaic.set_state = function(pos,state)
  tss(pos,state)
  worldgate.link(vector.new(pos))
end

-- Register LBM to jump-start force-load timers
minetest.register_abm({
  label = "Run worldgate linking function",
  nodenames = "group:telemosaic",
  interval = 3,
  chance = 1,
  catch_up = false,
  action = function(pos)
    worldgate.link(pos)
  end,
})