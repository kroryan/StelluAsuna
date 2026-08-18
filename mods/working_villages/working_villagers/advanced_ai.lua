-- Advanced Working Villagers AI
--
-- This is a self-contained adaptation of the behaviour ideas used by AliveAI:
-- shared threat memory, visibility checks, tactical positioning, bounded A*
-- navigation, retreat selection and cooperative construction logistics.  It
-- deliberately operates on Working Villagers entities and jobs only.

local log = working_villages.require("log")
local pathfinder = working_villages.require("pathfinder")

working_villages.advanced_ai = working_villages.advanced_ai or {}
local blackboard = working_villages.advanced_ai
blackboard.villages = blackboard.villages or {}
blackboard.threats = blackboard.threats or {}
blackboard.build_tasks = blackboard.build_tasks or {}

local ZONE = 12
local THREAT_TTL = 45
local MAX_SEARCH = 420
local TICK = 0.25

local function now()
	return minetest.get_gametime()
end

local function valid_object(object)
	return object and object:get_pos() and (not object.get_hp or object:get_hp() > 0)
end

local function name_of(object)
	if object:is_player() then return "player:" .. object:get_player_name() end
	local entity = object:get_luaentity()
	return "entity:" .. ((entity and entity.name) or "unknown")
end

local function village_key(pos)
	return math.floor(pos.x / ZONE) .. ":" .. math.floor(pos.y / 4) .. ":" .. math.floor(pos.z / ZONE)
end

local function is_villager(object)
	local entity = object and object:get_luaentity()
	return entity and entity.object == object and working_villages.is_villager(entity.name)
		and entity.get_job_name and entity.get_inventory
end

local function visible(a, b)
	if not a or not b then return false end
	local d = vector.distance(a, b)
	if d < 0.1 then return true end
	local step = vector.multiply(vector.subtract(b, a), 1 / d)
	for i = 1, math.floor(d) do
		local p = vector.add(a, vector.multiply(step, i))
		local node = minetest.get_node_or_nil(p)
		local def = node and minetest.registered_nodes[node.name]
		if def and def.walkable then return false end
	end
	return true
end

local function hostile(object)
	if not valid_object(object) or object:is_player() then return false end
	if is_villager(object) then return false end
	local entity = object:get_luaentity()
	if not entity then return false end
	if entity.type == "monster" or entity.type == "enemy" or entity.attack_players == 1 then return true end
	local name = entity.name or ""
	return name:find("zombie", 1, true) ~= nil
		or name:find("skeleton", 1, true) ~= nil
		or name:find("spider", 1, true) ~= nil
		or name:find("monster", 1, true) ~= nil
		or name:find("horror:", 1, true) ~= nil
		or name:find("aliveai_threats:", 1, true) ~= nil
end

local function node_walkable(pos)
	local node = minetest.get_node_or_nil(pos)
	local def = node and minetest.registered_nodes[node.name]
	return def and def.walkable
end

local function node_open(pos)
	local node = minetest.get_node_or_nil(pos)
	local def = node and minetest.registered_nodes[node.name]
	return node and def and not def.walkable
end

local function can_stand(pos)
	return node_open(pos) and node_open({x=pos.x, y=pos.y+1, z=pos.z})
		and node_walkable({x=pos.x, y=pos.y-1, z=pos.z})
end

local function edge_key(a, b)
	return minetest.hash_node_position(vector.round(a)) .. ":" .. minetest.hash_node_position(vector.round(b))
end

local function neighbours(pos)
	return {
		{x=pos.x+1,y=pos.y,z=pos.z}, {x=pos.x-1,y=pos.y,z=pos.z},
		{x=pos.x,y=pos.y,z=pos.z+1}, {x=pos.x,y=pos.y,z=pos.z-1},
		{x=pos.x+1,y=pos.y+1,z=pos.z}, {x=pos.x-1,y=pos.y+1,z=pos.z},
		{x=pos.x,y=pos.y+1,z=pos.z+1}, {x=pos.x,y=pos.y+1,z=pos.z-1},
		{x=pos.x+1,y=pos.y-1,z=pos.z}, {x=pos.x-1,y=pos.y-1,z=pos.z},
		{x=pos.x,y=pos.y-1,z=pos.z+1}, {x=pos.x,y=pos.y-1,z=pos.z-1},
	}
end

local function heuristic(a, b)
	return math.abs(a.x-b.x) + math.abs(a.y-b.y) + math.abs(a.z-b.z)
end

-- Bounded A* fallback. Native pathfinding remains preferred by go_to; this
-- planner is used for combat/retreat routes and remembers blocked edges.
function blackboard.find_path(start, goal, entity)
	start, goal = vector.round(start), vector.round(goal)
	if can_stand(goal) and minetest.find_path then
		local ok, path = pcall(minetest.find_path, start, goal, 32, 1, 2, "A*_noprefetch")
		if ok and path and #path > 0 then return path end
	end
	local open, came, g, f, closed = {start}, {}, {}, {}, {}
	local skey = minetest.hash_node_position(start)
	g[skey], f[skey] = 0, heuristic(start, goal)
	local examined = 0
	while #open > 0 and examined < MAX_SEARCH do
		local best_i, best = 1, open[1]
		for i = 2, #open do
			if f[minetest.hash_node_position(open[i])] < f[minetest.hash_node_position(best)] then best_i, best = i, open[i] end
		end
		table.remove(open, best_i)
		local key = minetest.hash_node_position(best)
		if key == minetest.hash_node_position(goal) then
			local result, current = {}, key
			while current do
				table.insert(result, 1, came[current] and came[current].pos or best)
				current = came[current] and came[current].key
			end
			return result
		end
		closed[key], examined = true, examined + 1
		for _, next_pos in ipairs(neighbours(best)) do
			local next_key = minetest.hash_node_position(next_pos)
			if not closed[next_key] and can_stand(next_pos)
				and not (working_villages.navigation_is_blocked and working_villages.navigation_is_blocked(best, next_pos)) then
				local score = (g[key] or math.huge) + (next_pos.y == best.y and 1 or 1.4)
				if not g[next_key] or score < g[next_key] then
					came[next_key], g[next_key], f[next_key] = {key=key,pos=best}, score, score + heuristic(next_pos, goal)
					table.insert(open, next_pos)
				end
			end
		end
	end
	return nil
end

-- Keep a short-lived route per villager.  Combat and delivery movement can
-- therefore use the same bounded planner without rebuilding an A* graph on
-- every entity tick.  A route is invalidated when the target changes or an
-- edge is learned to be blocked.
function blackboard.next_waypoint(villager, target_pos)
	if not villager or not villager.object or not target_pos then return nil end
	local pos = villager.object:get_pos()
	if not pos then return nil end
	local target = vector.round(target_pos)
	local route = villager.advanced_route
	local stale = not route or not route.target
	if route and route.target then
		stale = vector.distance(route.target, target) > 2
			or (now() - (route.created or 0)) > 3
	end
	if stale then
		local path = blackboard.find_path(vector.round(pos), target, villager)
		villager.advanced_route = {path=path, index=1, target=target, created=now()}
		route = villager.advanced_route
	end
	if not route.path then return nil end
	while route.index <= #route.path and vector.distance(pos, route.path[route.index]) < 1.25 do
		route.index = route.index + 1
	end
	local waypoint = route.path[route.index]
	if not waypoint then villager.advanced_route = nil end
	return waypoint
end

local function remember_threat(villager, object, reason)
	if not valid_object(object) then return end
	local key = name_of(object)
	local village = village_key(villager.object:get_pos())
	blackboard.threats[village] = blackboard.threats[village] or {}
	blackboard.threats[village][key] = {
		object=object, pos=vector.round(object:get_pos()), expires=now()+THREAT_TTL, reason=reason or "seen",
	}
	villager.advanced_threat_key = key
end

local function share_threat(villager, object)
	local pos = villager.object:get_pos()
	for _, candidate in ipairs(minetest.get_objects_inside_radius(pos, 18)) do
		if candidate ~= villager.object and is_villager(candidate) then
			local other = candidate:get_luaentity()
			if other.ai_set_target then other:ai_set_target(object, true) end
			remember_threat(other, object, "ally")
		end
	end
end

function working_villages.advanced_ai.alert(villager, object, reason)
	if not villager or not valid_object(object) then return false end
	remember_threat(villager, object, reason or "alert")
	share_threat(villager, object)
	return true
end

local function choose_retreat(villager, threat)
	local pos, enemy = villager.object:get_pos(), threat:get_pos()
	local away = vector.normalize(vector.subtract(pos, enemy))
	local candidates = {}
	for radius = 4, 10, 2 do
		for side = -1, 1, 1 do
			local point = {x=math.floor(pos.x + away.x*radius - away.z*side*2), y=math.floor(pos.y), z=math.floor(pos.z + away.z*radius + away.x*side*2)}
			if can_stand(point) and visible(pos, point) then candidates[#candidates+1] = point end
		end
	end
	return candidates[1]
end

function working_villages.advanced_ai.retreat_point(villager, threat)
	if not villager or not valid_object(threat) then return nil end
	return choose_retreat(villager, threat)
end

local function assign_build_task(builder, node_name, node_pos)
	local key = minetest.hash_node_position(vector.round(node_pos))
	local task = blackboard.build_tasks[key]
	if task and task.expires > now() then return task end
	task = {pos=vector.round(node_pos), item=node_name, owner=builder, expires=now()+120, helpers={}}
	blackboard.build_tasks[key] = task
	return task
end

function working_villages.advanced_ai.request_build(builder, node_name, node_pos)
	return assign_build_task(builder, node_name, node_pos)
end

local function construction_tick()
	for key, task in pairs(blackboard.build_tasks) do
		if task.expires <= now() or not valid_object(task.owner.object) then
			blackboard.build_tasks[key] = nil
		else
			for _, object in ipairs(minetest.get_objects_inside_radius(task.pos, 20)) do
				if is_villager(object) and object ~= task.owner.object then
					local helper = object:get_luaentity()
					local inv = helper:get_inventory()
					local helper_key = helper.inventory_name or tostring(object)
					if inv and inv:contains_item("main", ItemStack(task.item))
						and not task.helpers[helper_key] and not helper.ai_delivery then
						task.helpers[helper_key] = true
						helper.ai_delivery = {recipient=task.owner.object, item_name=task.item}
						helper:set_displayed_action("supplying builder")
						helper:set_state_info("I am supplying a builder with requested materials.")
						break
					end
				end
			end
		end
	end
end

function working_villages.advanced_ai.complete_build(node_pos)
	if not node_pos then return end
	blackboard.build_tasks[minetest.hash_node_position(vector.round(node_pos))] = nil
end

local elapsed = 0
minetest.register_globalstep(function(dtime)
	 elapsed = elapsed + dtime
	 if elapsed < TICK then return end
 elapsed = 0
 construction_tick()
end)

log.action("advanced self-contained villager AI enabled")
