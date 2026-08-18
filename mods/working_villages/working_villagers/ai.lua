-- Cooperative village AI for working_villagers.
-- Keeps the existing job coroutines intact and only takes control while a
-- villager is defending itself, fleeing, or delivering building materials.

local log = working_villages.require("log")

working_villages.ai_registry = working_villages.ai_registry or {}
working_villages.bed_reservations = working_villages.bed_reservations or {}
working_villages.navigation_memory = working_villages.navigation_memory or {
	zones = {},
	blocked_edges = {},
}

local ZONE_SIZE = 8

local function zone_key(pos)
	return table.concat({
		math.floor(pos.x / ZONE_SIZE),
		math.floor(pos.y / 4),
		math.floor(pos.z / ZONE_SIZE),
	}, ":")
end

local function edge_key(a, b)
	return minetest.hash_node_position(vector.round(a)) .. ">" ..
		minetest.hash_node_position(vector.round(b))
end

function working_villages.navigation_note_blocked(a, b)
	if not a or not b then return end
	working_villages.navigation_memory.blocked_edges[edge_key(a, b)] =
		minetest.get_gametime() + 45
end

function working_villages.navigation_is_blocked(a, b)
	if not a or not b or type(a.x) ~= "number" or type(b.x) ~= "number" then
		return false
	end
	local key = edge_key(a, b)
	local expiry = working_villages.navigation_memory.blocked_edges[key]
	if expiry and expiry > minetest.get_gametime() then return true end
	working_villages.navigation_memory.blocked_edges[key] = nil
	return false
end

function working_villages.navigation_scan_zone(pos)
	local key = zone_key(pos)
	local now = minetest.get_gametime()
	local zone = working_villages.navigation_memory.zones[key]
	if zone and now - zone.last_scan < 8 then return zone end
	zone = zone or {exits = {}, doors = {}, blocked = {}}
	zone.last_scan = now
	zone.exits = {}
	zone.doors = {}
	zone.blocked = {}
	local minp = {x = math.floor(pos.x / ZONE_SIZE) * ZONE_SIZE, y = math.floor(pos.y) - 3, z = math.floor(pos.z / ZONE_SIZE) * ZONE_SIZE}
	local maxp = {x = minp.x + ZONE_SIZE - 1, y = pos.y + 3, z = minp.z + ZONE_SIZE - 1}
	for x = minp.x, maxp.x do
		for y = minp.y, maxp.y do
			for z = minp.z, maxp.z do
				local p = {x = x, y = y, z = z}
				local node = minetest.get_node_or_nil(p)
				if node then
					local name = node.name
					if name:find("doors:") then
						zone.doors[#zone.doors + 1] = vector.new(p)
					elseif minetest.registered_nodes[name] and minetest.registered_nodes[name].walkable then
						zone.blocked[#zone.blocked + 1] = vector.new(p)
					end
				end
			end
		end
	end
	-- Record walkable boundary cells as known exits for every villager.
	for x = minp.x, maxp.x do
		for _, z in ipairs({minp.z, maxp.z}) do
			local p = {x = x, y = math.floor(pos.y), z = z}
			if minetest.get_node(p).name == "air" then zone.exits[#zone.exits + 1] = p end
		end
	end
	for z = minp.z + 1, maxp.z - 1 do
		for _, x in ipairs({minp.x, maxp.x}) do
			local p = {x = x, y = math.floor(pos.y), z = z}
			if minetest.get_node(p).name == "air" then zone.exits[#zone.exits + 1] = p end
		end
	end
	working_villages.navigation_memory.zones[key] = zone
	return zone
end

function working_villages.navigation_find_nearest_door(pos, radius)
	local best, best_distance
	local minp = vector.subtract(pos, radius or 12)
	local maxp = vector.add(pos, radius or 12)
	for _, candidate in ipairs(minetest.find_nodes_in_area(minp, maxp, {"group:door"})) do
		local distance = vector.distance(pos, candidate)
		if not best_distance or distance < best_distance then
			best, best_distance = candidate, distance
		end
	end
	-- Some door mods do not expose group:door; use the shared scan as a
	-- fallback so all villagers still learn the same exits.
	if not best then
		local zone = working_villages.navigation_memory.zones[zone_key(pos)]
		for _, candidate in ipairs(zone and zone.doors or {}) do
			local distance = vector.distance(pos, candidate)
			if distance <= (radius or 12) and (not best_distance or distance < best_distance) then
				best, best_distance = candidate, distance
			end
		end
	end
	return best
end

function working_villages.navigation_get_door_exit(villager, door_pos)
	if not door_pos then return nil end
	local pos = villager.object:get_pos()
	local direction = vector.subtract(door_pos, pos)
	direction.y = 0
	if vector.length(direction) < 0.1 then
		direction = villager:get_look_direction()
	end
	direction = vector.round(vector.normalize(direction))
	if direction.x == 0 and direction.z == 0 then direction = {x = 1, y = 0, z = 0} end
	-- The door node itself is not a valid stopping point: aim two nodes
	-- beyond it so the pathfinder must cross the threshold.
	return {
		x = math.floor(door_pos.x) + direction.x * 2,
		y = math.floor(door_pos.y),
		z = math.floor(door_pos.z) + direction.z * 2,
	}
end

local function bed_key(pos)
	return pos and minetest.hash_node_position(vector.round(pos))
end

local function bed_is_valid(pos)
	if not pos then return false end
	local node = minetest.get_node_or_nil(pos)
	return node and minetest.get_item_group(node.name, "villager_bed_bottom") > 0
end

local function bed_is_occupied(pos, villager)
	for _, object in ipairs(minetest.get_objects_inside_radius(pos, 0.9)) do
		if object ~= villager.object then
			if object:is_player() then
				return true
			end
			local entity = object:get_luaentity()
			if entity and entity.ai_sleeping then
				return true
			end
		end
	end
	return false
end

local function reserve_bed(villager, preferred)
	preferred = preferred or villager.ai_preferred_bed
	if not preferred then return nil end
	villager.ai_preferred_bed = vector.new(preferred)
	local key = bed_key(preferred)
	local owner = key and working_villages.bed_reservations[key]
	if bed_is_valid(preferred) and not bed_is_occupied(preferred, villager)
		and (owner == nil or owner == villager.inventory_name) then
		working_villages.bed_reservations[key] = villager.inventory_name
		villager.ai_assigned_bed = vector.new(preferred)
		return preferred
	end

	-- A generated house can contain several beds. Pick the closest free one
	-- when a stale/duplicated assignment is detected.
	local best, best_distance
	for _, candidate in ipairs(minetest.find_nodes_in_area(
		vector.subtract(preferred, 8), vector.add(preferred, 8), {"group:villager_bed_bottom"})) do
		local candidate_key = bed_key(candidate)
		local candidate_owner = candidate_key and working_villages.bed_reservations[candidate_key]
		if (not candidate_owner or candidate_owner == villager.inventory_name)
			and not bed_is_occupied(candidate, villager) then
			local distance = vector.distance(preferred, candidate)
			if not best_distance or distance < best_distance then
				best, best_distance = candidate, distance
			end
		end
	end
	if best then
		working_villages.bed_reservations[bed_key(best)] = villager.inventory_name
		villager.ai_assigned_bed = vector.new(best)
		return best
	end
	return nil
end

function working_villages.villager:ai_reserve_bed()
	local assigned = reserve_bed(self, self.pos_data and self.pos_data.bed_pos)
	if assigned then
		self.pos_data.bed_pos = vector.new(assigned)
		self.ai_no_bed = false
	else
		self.ai_no_bed = true
	end
	return assigned
end

local function remember_key(object)
	if object:is_player() then
		return "player:" .. object:get_player_name()
	end
	local entity = object:get_luaentity()
	return "entity:" .. ((entity and entity.name) or "unknown")
end

local function remember_threat(villager, object)
	villager.ai_memory = villager.ai_memory or {}
	local key = remember_key(object)
	villager.ai_memory[key] = {
		expires = minetest.get_gametime() + 60,
		pos = vector.round(object:get_pos()),
	}
end

local function alive_object(object)
	return object and object:get_pos() ~= nil and object:get_hp() > 0
end

local function entity_name(object)
	local entity = object and object:get_luaentity()
	return entity and entity.name or ""
end

local function is_villager_object(object)
	return object and not object:is_player() and working_villages.is_villager(entity_name(object))
end

local function is_hostile_entity(object)
	if not object or object:is_player() then
		return false
	end
	local entity = object:get_luaentity()
	if not entity then
		return false
	end
	if working_villages.is_villager(entity.name) then
		return false
	end
	if entity.type == "monster" or entity.type == "enemy" then
		return true
	end
	local name = entity.name or ""
	return name:match("^mobs_monster:") ~= nil
		or name:match("^aliveai_threats:") ~= nil
		or name:match("zombie") ~= nil
		or name:match("skeleton") ~= nil
		or name:match("spider") ~= nil
end

-- Dedicated Working Villagers perception/combat helpers.  These are adapted
-- from the MIT-licensed AliveAI behaviour algorithms, but do not call or
-- depend on the AliveAI runtime.
local function ai_visible(from, to)
	if not from or not to then return false end
	local delta = {x = from.x - to.x, y = from.y - to.y - 2, z = from.z - to.z}
	local distance = vector.distance(from, to)
	if distance < 0.01 then return true end
	local step = vector.multiply(delta, -1 / math.max(distance, 0.01))
	for i = 1, math.floor(distance) do
		local node = minetest.get_node_or_nil({
			x = from.x + step.x * i,
			y = from.y + step.y * i,
			z = from.z + step.z * i,
		})
		local def = node and minetest.registered_nodes[node.name]
		if def and def.walkable then return false end
	end
	return true
end

local function villager_attack(villager, target, damage)
	if not target or not target:get_pos() then return true end
	target:punch(villager.object, 1.0, {
		full_punch_interval = 1.0,
		damage_groups = {fleshy = damage},
	}, vector.direction(villager.object:get_pos(), target:get_pos()))
	return true
end

-- Adjacent-node tactical search: choose a walkable position around a target,
-- then let Working Villagers' own pathfinder perform the movement.
local function tactical_approach(villager, target_pos)
	local origin = villager.object:get_pos()
	local base = vector.round(target_pos)
	local candidates = {
		{x=base.x-1,y=base.y,z=base.z}, {x=base.x+1,y=base.y,z=base.z},
		{x=base.x,y=base.y,z=base.z-1}, {x=base.x,y=base.y,z=base.z+1},
		{x=base.x-1,y=base.y,z=base.z-1}, {x=base.x+1,y=base.y,z=base.z+1},
	}
	local best, best_distance
	for _, point in ipairs(candidates) do
		local node = minetest.get_node_or_nil(point)
		local below = minetest.get_node_or_nil({x=point.x,y=point.y-1,z=point.z})
		local above = minetest.get_node_or_nil({x=point.x,y=point.y+1,z=point.z})
		local below_def = below and minetest.registered_nodes[below.name]
		local node_def = node and minetest.registered_nodes[node.name]
		local above_def = above and minetest.registered_nodes[above.name]
		if node_def and not node_def.walkable and above_def and not above_def.walkable
		and below_def and below_def.walkable and ai_visible(origin, point) then
			local distance = vector.distance(origin, point)
			if not best_distance or distance < best_distance then best, best_distance = point, distance end
		end
	end
	if best then return best end
	return nil
end

local function has_item(villager, item_name)
	local inventory = villager:get_inventory()
	return inventory and inventory:contains_item("main", ItemStack(item_name))
end

local function give_item(recipient, item_name)
	local inventory = recipient:get_inventory()
	if not inventory or not inventory:room_for_item("main", ItemStack(item_name)) then
		return false
	end
	inventory:add_item("main", ItemStack(item_name))
	return true
end

local function clear_target(villager)
	villager.ai_target = nil
	villager.advanced_route = nil
	villager.ai_state = "calm"
	villager.ai_state_time = 0
	villager.ai_attack_cooldown = 0
	villager:set_displayed_action("active")
	villager:set_state_info("Returning to my normal duties.")
end

local function alert_allies(villager, target)
	local pos = villager.object:get_pos()
	for _, object in ipairs(minetest.get_objects_inside_radius(pos, 14)) do
		if object ~= villager.object and is_villager_object(object) then
			local ally = object:get_luaentity()
			if ally and ally.ai_set_target then
				ally:ai_set_target(target, true)
			end
		end
	end
end

function working_villages.villager:ai_set_target(target, shared, forced)
	local shared_player_alert = shared == true and target and target:is_player()
	if not alive_object(target) or target == self.object
		or (not forced and not shared_player_alert and not self:ai_is_enemy(target)) then
		return false
	end
	self.ai_target = target
	remember_threat(self, target)
	self.ai_state = "engage"
	self.ai_state_time = 0
	self.ai_shared_threat = shared == true
	self.pause = false
	if self.ai_sleeping then
		local pos = self.object:get_pos()
		self.ai_sleeping = false
		self.object:set_pos({x = pos.x, y = pos.y + 0.5, z = pos.z})
		self:set_animation(working_villages.animation_frames.STAND)
	end
	self:set_displayed_action("defending the village")
	self:set_state_info("I detected a threat and alerted nearby villagers.")
	if not shared then
		alert_allies(self, target)
	end
	if not shared and working_villages.advanced_ai and working_villages.advanced_ai.alert then
		working_villages.advanced_ai.alert(self, target, shared and "ally" or "detected")
	end
	return true
end

function working_villages.villager:ai_is_enemy(object)
	if not object or object == self.object or not alive_object(object) then
		return false
	end
	if object:is_player() then
		-- Villagers only retaliate against players who attacked them first.
		return self.ai_target == object
	end
	return is_hostile_entity(object)
end

function working_villages.villager:ai_on_punch(puncher)
	if not alive_object(puncher) then
		return
	end
	if self:ai_is_enemy(puncher) or puncher:is_player() then
		if working_villages.advanced_ai and working_villages.advanced_ai.alert then
			working_villages.advanced_ai.alert(self, puncher, "attacked")
		end
		-- A player is not an enemy until they attack first.  This forced path is
		-- the retaliation event; it also lets alert_allies share that target.
		self:ai_set_target(puncher, false, true)
	end
end

local function move_away(villager, target_pos)
	local pos = villager.object:get_pos()
	if working_villages.advanced_ai and villager.ai_target
		and working_villages.advanced_ai.retreat_point then
		local retreat = working_villages.advanced_ai.retreat_point(villager, villager.ai_target)
		if retreat then target_pos = vector.subtract(pos, vector.subtract(retreat, pos)) end
	end
	local direction = vector.subtract(pos, target_pos)
	direction.y = 0
	if vector.length(direction) < 0.1 then
		direction = {x = 1, y = 0, z = 0}
	end
	direction = vector.normalize(direction)
	villager.object:set_velocity({x = direction.x * 3.2, y = villager.object:get_velocity().y, z = direction.z * 3.2})
	villager:set_yaw_by_direction(direction)
	villager:set_animation(working_villages.animation_frames.WALK)
	villager:handle_obstacles(true)
end

local function move_toward(villager, target_pos)
	local pos = villager.object:get_pos()
	if working_villages.advanced_ai and vector.distance(pos, target_pos) > 3
		and working_villages.advanced_ai.next_waypoint then
		local waypoint = working_villages.advanced_ai.next_waypoint(villager, target_pos)
		if waypoint then target_pos = waypoint end
	end
	local direction = vector.subtract(target_pos, pos)
	direction.y = 0
	if vector.length(direction) < 0.1 then
		villager.object:set_velocity({x = 0, y = villager.object:get_velocity().y, z = 0})
		return
	end
	direction = vector.normalize(direction)
	villager.object:set_velocity({x = direction.x * 2.2, y = villager.object:get_velocity().y, z = direction.z * 2.2})
	villager:set_yaw_by_direction(direction)
	villager:set_animation(working_villages.animation_frames.WALK)
	villager:handle_obstacles(true)
end

local function combat_step(villager, dtime)
	local target = villager.ai_target
	if not alive_object(target) then
		clear_target(villager)
		return false
	end
	local distance = vector.distance(villager.object:get_pos(), target:get_pos())
	villager.ai_state_time = villager.ai_state_time + dtime
	villager.ai_attack_cooldown = math.max(0, (villager.ai_attack_cooldown or 0) - dtime)
	if distance > 30 or villager.ai_state_time > 35 then
		clear_target(villager)
		return false
	end

	local hp = villager.object:get_hp()
	local max_hp = villager.initial_properties.hp_max or 20
	local job_name = villager:get_job_name()
	local flee = hp <= max_hp * (job_name == "working_villages:job_guard" and 0.20 or 0.45)
	if flee then
		villager.ai_state = "flee"
		villager:set_displayed_action("fleeing from danger")
		villager:set_state_info("I am injured and retreating before I fight again.")
		move_away(villager, target:get_pos())
		if distance > 14 then
			clear_target(villager)
		end
		return true
	end

	villager:set_displayed_action("defending the village")
	villager:set_state_info("Fighting a hostile creature or attacker.")
	if distance > 2.5 then
		move_toward(villager, tactical_approach(villager, target:get_pos()) or target:get_pos())
	elseif villager.ai_attack_cooldown <= 0 then
		local direction = vector.direction(villager.object:get_pos(), target:get_pos())
		villager.object:set_velocity({x = 0, y = villager.object:get_velocity().y, z = 0})
		villager:set_yaw_by_direction(direction)
		villager:set_animation(working_villages.animation_frames.MINE)
		local damage = 4
		local wield = villager:get_wield_item_stack()
		local capabilities = wield and wield:get_definition().tool_capabilities
		if capabilities and capabilities.damage_groups and capabilities.damage_groups.fleshy then
			damage = math.max(1, capabilities.damage_groups.fleshy)
		end
		villager_attack(villager, target, damage)
		villager.ai_attack_cooldown = 1.1
	end
	return true
end

local function delivery_step(villager)
	local delivery = villager.ai_delivery
	if not delivery or not alive_object(delivery.recipient) then
		villager.ai_delivery = nil
		return false
	end
	local recipient = delivery.recipient:get_luaentity()
	local distance = vector.distance(villager.object:get_pos(), delivery.recipient:get_pos())
	if distance > 2 then
		move_toward(villager, delivery.recipient:get_pos())
		return true
	end
	if give_item(recipient, delivery.item_name) then
		recipient.ai_build_request = nil
		recipient.ai_delivery_from = nil
		recipient.pause = false
		recipient:set_displayed_action("active")
		recipient:set_state_info("A fellow villager supplied the materials I needed.")
		villager:set_state_info("I delivered materials to a builder.")
	end
	villager.ai_delivery = nil
	return false
end

local function seek_builder_request(villager)
	local pos = villager.object:get_pos()
	for _, object in ipairs(minetest.get_objects_inside_radius(pos, 20)) do
		if object ~= villager.object and is_villager_object(object) then
			local recipient = object:get_luaentity()
			local request = recipient.ai_build_request
			if request and request.expires > minetest.get_gametime()
				and has_item(villager, request.item_name)
				and not recipient.ai_delivery_from then
				recipient.ai_delivery_from = villager
				villager.ai_delivery = {recipient = object, item_name = request.item_name}
				villager:set_displayed_action("helping a builder")
				villager:set_state_info("I am bringing materials to a fellow villager.")
				return true
			end
		end
	end
	return false
end

function working_villages.request_build_material(villager, item_name)
	villager.ai_build_request = {
		item_name = item_name,
		expires = minetest.get_gametime() + 90,
	}
	villager:set_state_info("Waiting for a fellow villager to bring " .. item_name .. ".")
end

function working_villages.villager:ai_step(dtime)
	local pos = self.object:get_pos()
	if pos then
		local previous = self.ai_last_pos
		local velocity = self.object:get_velocity()
		if previous and not self.ai_target and not self.ai_delivery
			and vector.distance(pos, previous) < 0.08
			and vector.length(velocity) > 0.8 then
			self.ai_stuck_time = (self.ai_stuck_time or 0) + dtime
		else
			self.ai_stuck_time = 0
		end
		self.ai_last_pos = vector.new(pos)
	if (self.ai_stuck_time or 0) >= 3 then
			-- Abort the coroutine that is waiting on an unreachable waypoint and
			-- give the villager a short random escape maneuver.
			self.job_thread = nil
			self.path = nil
			self.destination = nil
			self.ai_recovery_time = 1.8
			local door = working_villages.navigation_find_nearest_door(pos, 12)
			if door then
				self.ai_navigation_target = vector.new(door)
				self.ai_navigation_thread = coroutine.create(function()
					return self:go_to(self.ai_navigation_target)
				end)
			end
			self.ai_stuck_time = 0
			self:set_state_info("I got stuck and am finding another route.")
		end
	end
	if self.ai_navigation_thread then
		local thread = self.ai_navigation_thread
		if coroutine.status(thread) == "suspended" then
			local ok, result = coroutine.resume(thread)
			if not ok then
				self.ai_navigation_thread = nil
				self.ai_navigation_target = nil
			elseif coroutine.status(thread) == "dead" then
				self.ai_navigation_thread = nil
				self.ai_navigation_target = nil
			end
		else
			self.ai_navigation_thread = nil
			self.ai_navigation_target = nil
		end
		return true
	end
	if self.ai_recovery_time and self.ai_recovery_time > 0 then
		self.ai_recovery_time = self.ai_recovery_time - dtime
		self:change_direction_randomly()
		return true
	end
	if self.ai_target then
		return combat_step(self, dtime)
	end
	if self.ai_delivery then
		return delivery_step(self)
	end
	self.ai_scan_timer = (self.ai_scan_timer or 0) + dtime
	if self.ai_scan_timer < 1.0 then
		return false
	end
	self.ai_scan_timer = 0
	working_villages.navigation_scan_zone(self.object:get_pos())
	-- Guards keep watch even when nobody has been hit yet. Other villagers
	-- react to nearby hostiles once alerted, which keeps the server lighter.
	local watch_radius = self:get_job_name() == "working_villages:job_guard" and 20 or 6
	for _, object in ipairs(minetest.get_objects_inside_radius(self.object:get_pos(), watch_radius)) do
		if is_hostile_entity(object)
		and ai_visible(self.object:get_pos(), object:get_pos()) then
			self:ai_set_target(object, false)
			return combat_step(self, dtime)
		end
	end
	if self.ai_build_request and self.ai_build_request.expires <= minetest.get_gametime() then
		self.ai_build_request = nil
		self.ai_delivery_from = nil
	end
	if not self.pause then
		seek_builder_request(self)
	end
	return false
end

-- Replace the old unconditional bed teleport with an exclusive reservation.
-- The original routine still handles animation, doors and dawn timing.
local original_goto_bed = working_villages.villager.goto_bed
working_villages.villager.goto_bed = function(self)
		if self.pos_data then
			local assigned = self:ai_reserve_bed()
			self.pos_data.bed_pos = assigned
			self.ai_sleeping = assigned ~= nil
		end
		local result = original_goto_bed(self)
		self.ai_sleeping = false
		return result
end

minetest.register_globalstep(function()
	for object, _ in pairs(working_villages.ai_registry) do
		if not alive_object(object) then
			working_villages.ai_registry[object] = nil
		end
	end
end)

log.action("cooperative villager AI enabled")
