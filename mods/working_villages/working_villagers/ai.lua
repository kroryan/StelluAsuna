-- Cooperative village AI for working_villagers.
-- Keeps the existing job coroutines intact and only takes control while a
-- villager is defending itself, fleeing, or delivering building materials.

local log = working_villages.require("log")

working_villages.ai_registry = working_villages.ai_registry or {}

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

function working_villages.villager:ai_set_target(target, shared)
	if not alive_object(target) or target == self.object or not self:ai_is_enemy(target) then
		return false
	end
	self.ai_target = target
	self.ai_state = "engage"
	self.ai_state_time = 0
	self.ai_shared_threat = shared == true
	self.pause = false
	self:set_displayed_action("defending the village")
	self:set_state_info("I detected a threat and alerted nearby villagers.")
	if not shared then
		alert_allies(self, target)
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
		self:ai_set_target(puncher, false)
	end
end

local function move_away(villager, target_pos)
	local pos = villager.object:get_pos()
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
		move_toward(villager, target:get_pos())
	elseif villager.ai_attack_cooldown <= 0 then
		local direction = vector.direction(villager.object:get_pos(), target:get_pos())
		villager.object:set_velocity({x = 0, y = villager.object:get_velocity().y, z = 0})
		villager:set_yaw_by_direction(direction)
		villager:set_animation(working_villages.animation_frames.MINE)
		target:punch(villager.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 4},
		}, direction)
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
	-- Guards keep watch even when nobody has been hit yet. Other villagers
	-- react to nearby hostiles once alerted, which keeps the server lighter.
	local watch_radius = self:get_job_name() == "working_villages:job_guard" and 20 or 6
	for _, object in ipairs(minetest.get_objects_inside_radius(self.object:get_pos(), watch_radius)) do
		if is_hostile_entity(object) then
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

minetest.register_globalstep(function()
	for object, _ in pairs(working_villages.ai_registry) do
		if not alive_object(object) then
			working_villages.ai_registry[object] = nil
		end
	end
end)

log.action("cooperative villager AI enabled")
