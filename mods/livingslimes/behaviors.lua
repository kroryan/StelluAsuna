--
-- Slime behaviors
--

local function reset_attack_vals(self)
	self.target = nil
end

-- Dig limits

livingslimes.dig_limit = {
	limit = livingslimes.settings.dig_limit,
	get = function(self,pos)
		local mapblock = minetest.hash_node_position(vector.divide(pos,16):floor())
		local value = self[mapblock] or (function()
			local stored_value = livingslimes.storage:get_int(mapblock)
			self[mapblock] = stored_value
			return stored_value
		end)()
		return mapblock, value
	end,
	limited = livingslimes.settings.dig_limit > 0 and function(self,pos)
		local mapblock, value = self:get(pos)
		return value >= self.limit
	end or function() return false end,
	increment = livingslimes.settings.dig_limit and function(self,pos)
		local mapblock, value = self:get(pos)
		value = value + 1
		livingslimes.storage:set_int(mapblock,value)
		self[mapblock] = value
	end or function() end,
}

-- Actions

function livingslimes.action_pursue(self, target, method, speed_factor, anim)
	local goal
	local function func(_self)
		local target_alive, line_of_sight, tgt_pos = _self:get_target(target)
		if not target_alive then
			return true
		end
		goal = goal or tgt_pos
		self:animate("move")
		if line_of_sight
		and vector.distance(goal, tgt_pos) > 3 then
			goal = tgt_pos
		end
		if _self:move_to(goal, method or "creatura:obstacle_avoidance", speed_factor or 0.5) then
			return true
		end
	end
	self:set_action(func)
end

function livingslimes.action_pursue_poison(self, target, method, speed_factor, anim)
	local poison_timer = 0.5
	local goal
	local function func(_self)
		local target_alive, line_of_sight, tgt_pos = _self:get_target(target)
		if not target_alive then
			return true
		end
		goal = goal or tgt_pos
		poison_timer = poison_timer - _self.dtime
		self:animate("move")
		if line_of_sight
		and vector.distance(goal, tgt_pos) > 3 then
			goal = tgt_pos
		end
		if poison_timer <= 0 then
			poison_timer = 0.5
			local pos = _self.object:get_pos()
			local nodename = minetest.get_node(pos).name
			local below = minetest.get_node(pos:add(vector.new(0,-1,0))).name
			if below ~= "air" and (nodename == "air" or nodename == _self.poison) then
				minetest.set_node(pos,{ name = _self.poison, param2 = 0 })
				minetest.get_node_timer(pos):start(10)
			end
		end
		if _self:move_to(goal, method or "creatura:obstacle_avoidance", speed_factor or 0.5) then
			return true
		end
	end
	self:set_action(func)
end

function livingslimes.action_forage(self, target, method, speed_factor, anim)
	local goal
	local item = target.item
	local function func(_self)
		local tgt_pos = item and item.object and item.object:get_pos()
		target.timeout = target.timeout - _self.dtime
		if not tgt_pos or target.timeout <= 0 then
			_self.nearby_food = nil
			return
		end
		goal = goal or tgt_pos
		self:animate(anim or "move")
		if vector.distance(goal, tgt_pos) > 3 then
			goal = tgt_pos
		end
		if _self:move_to(goal, method or "creatura:obstacle_avoidance", speed_factor or 0.5) then
			return true
		end
	end
	self:set_action(func)
end

function livingslimes.action_dig(self, node, method, speed_factor, anim)
	local goal
	local function func(_self)
		local tgt_pos = node and node.pos
		node.timeout = node.timeout - _self.dtime
		if not tgt_pos or minetest.get_node(node.pos).name ~= node.name or node.timeout <= 0 then
			_self.nearby_node = nil
			return
		end
		goal = goal or tgt_pos
		self:animate(anim or "move")
		if vector.distance(goal, tgt_pos) > 3 then
			goal = tgt_pos
		end
		if _self:move_to(goal, method or "creatura:obstacle_avoidance", speed_factor or 0.5) then
			return true
		end
	end
	self:set_action(func)
end

function livingslimes.action_punch(self, target)
	local jump_init = false
	local timeout = 2
	local function func(_self)
		local tgt_alive, _, tgt_pos = _self:get_target(target)
		if not tgt_alive then return true end
		local pos = _self.object:get_pos()
		if not pos then return end
		local dir = vector.direction(pos, tgt_pos)
		if not jump_init
		and _self.touching_ground then
			_self.object:add_velocity({x = dir.x * 3, y = 2, z = dir.z * 3})
			jump_init = true
		end
		timeout = timeout - _self.dtime
		if timeout <= 0 then return true end
		local dist = vector.distance(pos, tgt_pos)
		if dist < _self.width + 1 then
			_self:punch_target(target)
			local knockback = minetest.calculate_knockback(
				target, self.object, 1.0,
				{damage_groups = {fleshy = self.damage}},
				dir, 2.0, self.damage
			)
			target:add_velocity({x = dir.x * knockback, y = dir.y * knockback, z = dir.z * knockback})
			return true
		end
	end
	self:set_action(func)
end

-- Utilities

-- wander: slime wanders the area aimlessly
creatura.register_utility("livingslimes:wander", function(self)
	local move_chance = self.move_chance or 3
	local center = self.object:get_pos()
	if not center then return end
	local move = self.wander_action or creatura.action_move
	local function func(_self)
		if not _self:get_action() then
			local pos2 = _self:get_wander_pos(2, 3)
			if math.random(move_chance) == 1
			and vector.distance(pos2, center) < _self.tracking_range * 0.5 then
				move(_self, pos2, 2, "creatura:obstacle_avoidance", 0.35, "move")
			else
				creatura.action_idle(_self, math.random(2,5), "idle")
			end
		end
	end
	self:set_utility(func)
end)

-- attack: slime attacks a target
creatura.register_utility("livingslimes:attack", function(self, target)
	self.nearby_food = nil -- forget about food, this is a much better target >:)
	self.nearby_node = nil
	local width = self.width
	local punch_init = false
	local function func(_self)
		local pos = _self.object:get_pos()
		if not pos then return end
		local tgt_alive, _, tgt_pos = _self:get_target(target)
		if not tgt_alive then reset_attack_vals(self) return true end
		local dist = vector.distance(pos, tgt_pos)
		if dist > self.tracking_range then reset_attack_vals(self) return true end
		local punch_cooldown = self.punch_cooldown or 0
		if punch_cooldown > 0 then
			punch_cooldown = punch_cooldown - self.dtime
		end
		self.punch_cooldown = punch_cooldown
		if punch_cooldown <= 0
		and dist < width + 1
		and not punch_init then
			punch_init = true
			_self:play_sound("attack")
			livingslimes.action_punch(_self, target)
			self.punch_cooldown = 1
			if livingslimes.settings.allow_steal and math.random(100) <= livingslimes.settings.steal_chance then
				_self.steal_item(target)
				_self:play_sound("slurp")
			end
		end
		if not _self:get_action() then
			if punch_init then reset_attack_vals(self) return true end
			livingslimes.action_pursue(_self, target, "creatura:obstacle_avoidance", 0.75)
		end
	end
	self:set_utility(func)
end)

-- neutral: slime is idle unless a hostile target attacks it
creatura.register_utility("livingslimes:neutral", function(self, target)
	self.nearby_food = nil -- forget about food, this is a much better target >:)
	self.nearby_node = nil
	local width = self.width
	local punch_init = false
	local function func(_self)
		local pos = _self.object:get_pos()
		if not pos then return end
		local tgt_alive, _, tgt_pos = _self:get_target(target)
		if not tgt_alive then reset_attack_vals(self) return true end
		local dist = vector.distance(pos, tgt_pos)
		if dist > self.tracking_range then reset_attack_vals(self) return true end
		local punch_cooldown = self.punch_cooldown or 0
		if punch_cooldown > 0 then
			punch_cooldown = punch_cooldown - self.dtime
		end
		self.punch_cooldown = punch_cooldown
		if punch_cooldown <= 0
		and dist < width + 1
		and not punch_init then
			punch_init = true
			_self:play_sound("attack")
			livingslimes.action_punch(_self, target)
			self.punch_cooldown = 1
			if livingslimes.settings.allow_steal and math.random(100) <= livingslimes.settings.steal_chance then
				_self.steal_item(target)
				_self:play_sound("slurp")
			end
		end
		if not _self:get_action() then
			if punch_init then reset_attack_vals(self) return true end
			livingslimes.action_pursue(_self, target, "creatura:obstacle_avoidance", 0.75)
		end
	end
	self:set_utility(func)
end)

-- poison: slime leaves poisonous creep on the ground while attacking
creatura.register_utility("livingslimes:poison", function(self, target)
	self.nearby_food = nil -- forget about food, this is a much better target >:)
	self.nearby_node = nil
	local width = self.width
	local punch_init = false
	local function func(_self)
		local pos = _self.object:get_pos()
		if not pos then return end
		local tgt_alive, _, tgt_pos = _self:get_target(target)
		if not tgt_alive then reset_attack_vals(self) return true end
		local dist = vector.distance(pos, tgt_pos)
		if dist > self.tracking_range then reset_attack_vals(self) return true end
		local punch_cooldown = self.punch_cooldown or 0
		if punch_cooldown > 0 then
			punch_cooldown = punch_cooldown - self.dtime
		end
		self.punch_cooldown = punch_cooldown
		if punch_cooldown <= 0
		and dist < width + 1
		and not punch_init then
			punch_init = true
			_self:play_sound("attack")
			livingslimes.action_punch(_self, target)
			self.punch_cooldown = 1
		end
		if not _self:get_action() then
			if punch_init then reset_attack_vals(self) return true end
			livingslimes.action_pursue_poison(_self, target, "creatura:obstacle_avoidance", 0.75)
		end
	end
	self:set_utility(func)
end)

-- die: slime's HP reaches zero and it must die
creatura.register_utility("livingslimes:die", function(self)
	local timer = 1.5
	local init = false
	local function func(_self)
		if not init then
			_self:animate("idle")
			_self.object:set_properties({
				visual_size = {x = 8, y = 0.5},
				selectionbox = {0,0,0,0,0,0},
				pointable = false,
			})
			_self:play_sound("die")
			init = true
		end
		timer = timer - _self.dtime
		if timer <= 0 then
			local pos = _self.object:get_pos()
			if not pos then return end
			minetest.add_particlespawner({
				amount = 8,
				time = 0.25,
				minpos = {x = pos.x - 0.1, y = pos.y, z = pos.z - 0.1},
				maxpos = {x = pos.x + 0.1, y = pos.y + 0.1, z = pos.z + 0.1},
				minacc = {x = 0, y = 2, z = 0},
				maxacc = {x = 0, y = 3, z = 0},
				minvel = {x = math.random(-1, 1), y = -0.25, z = math.random(-1, 1)},
				maxvel = {x = math.random(-2, 2), y = -0.25, z = math.random(-2, 2)},
				minexptime = 0.75,
				maxexptime = 1,
				minsize = 4,
				maxsize = 4,
				texture = "creatura_smoke_particle.png",
				animation = {
					type = 'vertical_frames',
					aspect_w = 4,
					aspect_h = 4,
					length = 1,
				},
				glow = 1
			})
			creatura.drop_items(_self)
			_self.stomach:drop(pos)
			_self.object:remove()
		end
	end
	self:set_utility(func)
end)

-- eat: slime eats an item
creatura.register_utility("livingslimes:eat", function(self, target)
	local item = target.item
	local width = self.width
	local function func(_self)
		local pos = _self.object:get_pos()
		local itempos =  item and item.object and item.object:get_pos()
		if not pos or not itempos then
			_self.nearby_food = nil
			return
		end
		if vector.distance(pos,itempos) < width + 0.5 then
			_self:play_sound("slurp")
			_self.stomach:add(item.itemstring)
			item.object:remove()
			_self.nearby_food = nil
		else
			livingslimes.action_forage(_self, target, "creatura:obstacle_avoidance", 0.5)
		end
	end
	self:set_utility(func)
end)

-- dig: slime digs a node
creatura.register_utility("livingslimes:dig", function(self, node)
	local width = self.width
	local function func(_self)
		local pos = _self.object:get_pos()
		local nodepos = node.pos
		if not pos or not nodepos or minetest.get_node(nodepos).name ~= node.name then
			_self.nearby_node = nil
			return
		end
		if vector.distance(pos,nodepos) < width + 0.5 then
			local nodedef = minetest.registered_nodes[node.name]
			if nodedef and nodedef.sounds and nodedef.sounds.dug then
				minetest.sound_play(nodedef.sounds.dug,{
					gain = 0.5,
					pos = node.pos,
					max_hear_distance = 40,
				},true)
			end
			minetest.remove_node(node.pos)
			livingslimes.dig_limit:increment(node.pos)
			local drop = minetest.get_node_drops(node.name)
			if drop and drop[1] then
				_self:play_sound("slurp")
				_self.stomach:add(drop[1])
			end
			_self.nearby_node = nil
		else
			livingslimes.action_dig(_self, node, "creatura:obstacle_avoidance", 0.5)
		end
	end
	self:set_utility(func)
end)

-- digest: slime digests an item in its stomach
creatura.register_utility("livingslimes:digest", function(self, item)
	local timer = 5
	local init = false
	local function func(_self)
		if not init then
			init = true
			_self.charging = "digest"
			creatura.action_idle(_self, timer, "none")
		end
		timer = timer - _self.dtime
		if timer <= 0 then
			_self:play_sound("digest")
			_self.stomach:digest()
			_self.charging = nil
			return true
		end
	end
	self:set_utility(func)
end)

creatura.register_utility("livingslimes:fire", function(self)
	local timer = 2
	local init = false
	local function func(_self)
		local pos = _self.object:get_pos()
		if not init then
			init = true
			_self.charging = "fire"
			minetest.add_particlespawner({
				amount = 40,
				time = 2,
				minpos = {x = pos.x - 0.9, y = pos.y + 0.1, z = pos.z - 0.9},
				maxpos = {x = pos.x + 0.9, y = pos.y + 0.2, z = pos.z + 0.9},
				minacc = {x = 0, y = 2, z = 0},
				maxacc = {x = 0, y = 3, z = 0},
				minvel = {x = 0, y = 0, z = 0},
				maxvel = {x = 0, y = 0.5, z = 0},
				minexptime = 0.75,
				maxexptime = 1,
				minsize = 2.5,
				maxsize = 3.25,
				texture = {
					name = livingslimes.fire.texture,
					scale_tween = {
						{ x = 0.875, y = 1 },
						{ x = 0, y = 1.4 },
					},
					animation = {
						type = 'vertical_frames',
						aspect_w = 16,
						aspect_h = 16,
						length = 7,
					},
				},
				glow = 14,
			})
			creatura.action_idle(_self, timer, "idle")
		end
		timer = timer - _self.dtime
		if timer <= 0 then
			_self.charging = nil
			local nearby_ground = minetest.find_nodes_in_area_under_air(pos:add(vector.new(-4,-1,-4)), pos:add(vector.new(4,1,4)),{
				"group:soil",
				"group:stone",
				"group:crumbly",
				"group:cracky",
			})
			local nearby_ground_limit = #nearby_ground
			for node = 1, math.min(20,nearby_ground_limit) do
				node = nearby_ground[math.random(1,nearby_ground_limit)]:add(vector.new(0,1,0))
				minetest.set_node(node,{ name = livingslimes.fire.node, param2 = 0 })
			end
			_self:play_sound("fire")
			return true
		end
	end
	self:set_utility(func)
end)

-- Utility stack behaviors
livingslimes.behaviors = {
	wander = {
		utility = "livingslimes:wander",
		step_delay = 0.25,
		get_score = function(self)
			return 0.1, {self}
		end,
		enabled = true,
	},
	eat = {
		utility = "livingslimes:eat",
		get_score = function(self)
			-- Already seeking food
			local existing_food = self.nearby_food
			if existing_food then
				return 0.3, {self,existing_food}
			end

			-- More likely to eat if stomach is empty
			if math.random(0,self.stomach:size() * 20 + 39) == 0 then
				local items = minetest.get_objects_inside_radius(self.object:get_pos(),self.tracking_range)
				local favorite = {
					item = nil,
					score = 0,
					timeout = 6,
				}
				for item = 1, #items do
					item = items[item]:get_luaentity()
					local is_food = item and item.name == "__builtin:item" and item.itemstring and true or false
					local food_score = is_food and (self.diet[ItemStack(item.itemstring):get_name()] or (self.diet.any or -1)) or -1
					if food_score > favorite.score
					then
						favorite.item = item
						favorite.score = food_score
					end
				end
				if favorite.item then
					self.nearby_food = favorite
					return 0.3, {self,favorite}
				else
					return 0
				end
			else
				return 0
			end
		end,
		enabled = livingslimes.settings.allow_eat,
	},
	digest = {
		utility = "livingslimes:digest",
		get_score = function(self)
			return (self.charging == "digest" or (self.stomach:can_digest() and self:get_utility() == "livingslimes:wander")) and 0.6 or 0, {self}
		end,
		enabled = livingslimes.settings.allow_digest,
	},
	attack = {
		utility = "livingslimes:attack",
		step_delay = 0.25,
		get_score = function(self)
			local target = creatura.get_nearby_player(self,self.tracking_range)
			return target and 0.4 or 0, {self,target}
		end,
		enabled = livingslimes.settings.allow_attack,
	},
	neutral = {
		utility = "livingslimes:neutral",
		step_delay = 0.25,
		get_score = function(self)
			local target = creatura.get_nearby_player(self,self.tracking_range)
			return target and target:is_player() and self.enemies[target:get_player_name() or ""] and 0.4 or 0, {self,target}
		end,
		enabled = livingslimes.settings.allow_attack,
	},
	poison = {
		utility = "livingslimes:poison",
		step_delay = 0.25,
		get_score = function(self)
			local target = creatura.get_nearby_player(self,self.tracking_range)
			return target and 0.4 or 0, {self,target}
		end,
		enabled = livingslimes.settings.allow_attack and livingslimes.settings.allow_poison,
		alternative = "attack",
	},
	fire = {
		utility = "livingslimes:fire",
		get_score = function(self)
			return (self.charging == "fire" or (math.random(1,10) == 1 and self:get_utility() == "livingslimes:attack")) and 0.5 or 0, {self}
		end,
		enabled = livingslimes.settings.allow_attack and livingslimes.fire and livingslimes.settings.allow_fire,
	},
	dig = {
		utility = "livingslimes:dig",
		get_score = function(self)
			-- Already seeking node
			local existing_node = self.nearby_node
			if existing_node then
				return 0.275, {self,existing_node}
			end

			-- More likely to dig for food if stomach is empty
			if math.random(0,self.stomach:size() * 20 + 99) == 0 then
				local pos = self.object:get_pos()
				local nodes = minetest.find_nodes_in_area_under_air(
					pos:add(vector.new(-self.tracking_range,-1,-self.tracking_range)),
					pos:add(vector.new(self.tracking_range,1,self.tracking_range)),
					self.diet_set
				)
				local favorite = {
					node = nil,
					positions = nil,
					score = 0,
				}
				for _,node in ipairs(nodes) do
					node = {
						name = minetest.get_node(node).name,
						pos = node,
					}
					local food_score = self.diet[node.name] or -1
					if food_score > favorite.score then
						favorite.node = node.name
						favorite.positions = { node.pos }
						favorite.score = food_score
					elseif food_score == favorite.score then
						favorite.positions[#favorite.positions + 1] = node.pos
					end
				end
				if favorite.node then
					local pos = favorite.positions[math.random(#favorite.positions)]
					if livingslimes.dig_limit:limited(pos) then
						return 0
					else
						favorite = {
							name = favorite.node,
							pos = pos,
							timeout = 6,
						}
						self.nearby_node = favorite
						return 0.275, {self,favorite}
					end
				else
					return 0
				end
			else
				return 0
			end
		end,
		enabled = livingslimes.settings.allow_dig,
	}
}