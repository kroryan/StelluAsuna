--
-- Worldgate functions
--

-- Function for selecting a random base schematic
local base_schematics = (function()
  local schems = {}
  for _,schematic in ipairs(minetest.get_dir_list(worldgate.modpath .. "/schematics/base/",false)) do
    table.insert(schems,worldgate.modpath .. "/schematics/base/" .. schematic)
  end
  return schems
end)()
local base_count = #base_schematics
worldgate.schematics = {}
worldgate.schematics.base = base_schematics

function worldgate.get_random_base(pcgr)
  return base_schematics[pcgr and pcgr:next(1,base_count) or math.random(1,base_count)]
end

-- Function for selecting a random decor schematic
local decor_schematics = (function()
  local schems = {}
  for _,schematic in ipairs(minetest.get_dir_list(worldgate.modpath .. "/schematics/decor/",false)) do
    table.insert(schems,worldgate.modpath .. "/schematics/decor/" .. schematic)
  end
  return schems
end)()
local decor_count = #decor_schematics
worldgate.schematics.decor = decor_schematics

function worldgate.get_random_decor(pcgr)
  return decor_schematics[pcgr and pcgr:next(1,decor_count) or math.random(1,decor_count)]
end

-- Function for selecting a random quality value
function worldgate.get_random_quality(pcgr)
  return pcgr and pcgr:next(-1,1) or math.random(-1,1)
end

-- Function for adding new worldgates without data checks
function worldgate.add_gate_unsafe(def)
  -- Add gate to list of gates
  local ngates = #worldgate.gates
  worldgate.gates[ngates + 1] = def

  -- Index the gate via mapblock hashing
  local hash = minetest.hash_node_position(def.position:divide(16):floor())
  local gates = worldgate.hash_index[hash] or {}
  gates[#gates + 1] = ngates + 1
  worldgate.hash_index[hash] = gates
end

-- Function for adding new worldgates
local ymin = math.max(-29900,worldgate.settings.ymin)
local ymax = math.min(29900,worldgate.settings.ymax)
function worldgate.add_gate(def)
  -- Position must be a valid vector
  if not def.position then
    error("Attempted to add a worldgate without a position")
  elseif not vector.check(def.position) then
    error("Worldgate position must be a vector created with vector.new")
  elseif def.position.y > ymax or def.position.y < ymin then
    error("Worldgate position " .. minetest.pos_to_string(def.position) .. " is beyond ymin/ymax values")
  end

  if not def.base then
    def.base = worldgate.get_random_base()
  elseif type(def.base) ~= "string" then
    error("Worldgate base must be a string that identifies a schematic")
  end

  if not def.decor then
    def.decor = worldgate.get_random_decor()
  elseif type(def.decor) ~= "string" then
    error("Worldgate decor must be a string that identifies a schematic")
  end

  if not def.quality then
    def.quality = worldgate.get_random_quality()
  elseif not (def.quality == -1 or def.quality == 0 or def.quality == 1) then
    error("Worldgate quality must be an integer between -1 and 1 inclusive")
  end

  if def.exact == nil then
    def.exact = false
  else
    def.exact = not not def.exact -- boolean cast
  end

  -- Add gate via unsafe function
  worldgate.add_gate_unsafe(def)
end

-- Function for checking a mapblock against the gate hash index
function worldgate.get_gates_for_mapblock(pos)
  local gates = worldgate.hash_index[minetest.hash_node_position(pos:divide(16):floor())] or {}
  for i = 0, #gates do
    gates[i] = worldgate.gates[gates[i]]
  end
  return gates
end

-- Function for finding a suitable placement for a worldgate within a given area
function worldgate.find_worldgate_location_in_area(minp,maxp)
end

-- Function for spawning a worldgate
function worldgate.generate_gate(pos)
end

-- Function for gate generation callbacks
worldgate.worldgate_generated_callbacks = {}
function worldgate.reigster_on_worldgate_generated(fn)
  table.insert(worldgate.worldgate_generated_callbacks,fn)
end

-- Function for failed gate generation callbacks
worldgate.worldgate_failed_callbacks = {}
function worldgate.reigster_on_worldgate_failed(fn)
  table.insert(worldgate.worldgate_failed_callbacks,fn)
end