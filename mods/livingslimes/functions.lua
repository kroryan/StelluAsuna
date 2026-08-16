-- Get list of liquid nodes that slimes should float on
local is_liquid = {}
minetest.register_on_mods_loaded(function()
	for node,ndef in pairs(minetest.registered_nodes) do
		if ndef.liquidtype and ndef.liquidtype ~= "none" then
			is_liquid[node] = true
		end
	end
end)

-- Lookup table for poison particles
local poisonmap = {}

-- Register slimes
function livingslimes.register_slime(name,def)
	-- Skip unsupported slimes
	if not def then
		return
	end

	-- Get slime technical name component
	local tname = string.lower(name) .. "_slime"

	-- Register goo item
	local goo = "livingslimes:" .. tname .. "_goo"
	minetest.register_craftitem(goo, {
		inventory_image = "livingslimes_slime_goo.png^[colorize:" .. def.color,
		description = name .. " Slime Goo",
		groups = {slime = 1},
		on_use = def.edible ~= 0 and minetest.item_eat(def.edible) or nil,
		light_source = def.glow,
	})

	-- Register goo block
	local slime_block = "livingslimes:" .. tname .. "_block"
	minetest.register_node(slime_block, {
		tiles = {"livingslimes_slime_block.png^[colorize:" .. def.color .. "^[colorize:#000:25"},
		description = name .. " Slime Block",
		drawtype = "allfaces_optional",
		use_texture_alpha = true,
		groups = {
			slippery = 1,
			crumbly = 3,
			oddly_breakable_by_hand = 2,
			fall_damage_add_percent = -100,
			bouncy = 40,
		},
		sounds = {
			footstep = "livingslimes_hit",
			dig = "livingslimes_hit",
			dug = "livingslimes_hit",
			place = "livingslimes_hit",
		},
		damage_per_second = def.harmful,
		light_source = def.glow,
	})

	-- Register goo block recipe
	minetest.register_craft({
		output = slime_block,
		recipe = {
			{goo,goo,goo},
			{goo,goo,goo},
			{goo,goo,goo},
		}
	})

	-- Identify items and nodes that belong to dietary groups
	minetest.register_on_mods_loaded(function()
		for food,score in pairs(def.diet) do
			local mod, name = (function(match)
				return match(), match()
			end)(food:gmatch("[^:]+"))
			if mod == "group" then
				for item,idef in pairs(minetest.registered_items) do
					if idef.groups and idef.groups[name] and idef.groups[name] > 0 then
						def.diet[item] = score
					end
				end
			end
		end
	end)

	-- Create boolean map of slime behaviors
	for i = 1, #def.behaviors do
		def.behaviors[def.behaviors[i]] = true
	end

	-- Register slime punchback if the slime is harmful
	-- Deals damage to players that attack the slime bare-handed
	local punchback = function() end
	if def.harmful then
		local pbdmg = def.harmful
		punchback = function(self,puncher)
			if puncher:is_player() and puncher:get_wielded_item():is_empty() then
				puncher:punch(self.object, nil, {damage_groups={fleshy=pbdmg}}, nil)
			end
		end
	end

	-- Register slime poison node if slime is poisonous
	local poison_node = nil
	if def.behaviors.poison then
		local pdmg = def.harmful or 1
		poison_node = "livingslimes:" .. tname .. "_poison"
		minetest.register_node(poison_node,{
			description = name .. " Slime Poison",
			damage_per_second = pdmg,
			walkable = false,
			pointable = false,
			diggable = false,
			climbable = false,
			move_resistance = 1,
			buildable_to = true,
			floodable = true,
			sunlight_propagates = true,
			groups = { not_in_creative_inventory = 1 },
			drawtype = "nodebox",
			paramtype = "light",
			tiles = { "livingslimes_slime_block.png^[colorize:" .. def.color .. "^[opacity:150" },
			use_texture_alpha = "blend",
			color = def.color,
			node_box = {
				type = "fixed",
				fixed = { -0.5, -0.5, -0.5, 0.5, -0.49, 0.5 },
			},
			post_effect_color = "#cc00cc0f",
			on_construct = function(pos)
				local hash = minetest.hash_node_position(pos)
				poisonmap[hash] = minetest.add_particlespawner({
					pos = {
						min = pos:add(vector.new(-0.45,-0.05,-0.45)),
						max = pos:add(vector.new(0.45,-0.4,0.45)),
					},
					amount = 15,
					time = 0,
					collisiondetection = false,
					collision_removal = false,
					object_collision = false,
					vertical = true,
					texture = {
						name = "livingslimes_slime_inventory.png^[colorize:" .. def.color .. "^[opacity:150",
						scale_tween = {
							{ x = 1, y = 1 },
							{ x = 0, y = 0 },
						}
					},
					minsize = 0.75,
					maxsize = 1.25,
					minvel = { x = 0, y = 0.25, z = 0 },
					maxvel = { x = 0, y = 1, z = 0 },
					minexptime = 1,
					maxexptime = 2,
					glow = 1,
				})
				if poisonmap[hash] == -1 then -- adding particles did not succeed
					poisonmap[hash] = nil
				end
			end,
			on_destruct = function(pos)
				minetest.get_node_timer(pos):stop()
				local hash = minetest.hash_node_position(pos)
				if poisonmap[hash] then
					minetest.delete_particlespawner(poisonmap[hash])
					poisonmap[hash] = nil
				end
			end,
			on_timer = function(pos)
				minetest.remove_node(pos)
			end,
			drop = nil,
		})
	end

	-- Register slime mob with Creatura
	local mob = "livingslimes:" .. tname
	creatura.register_mob(mob,{
		-- Engine properties
		infotext = name .. " Slime",
		visual_size = { x = def.size, y = def.size },
		visual = "mesh",
		mesh = def.aquatic and "slime_liquid.b3d" or "slime_land.b3d",
		textures = {
			{"livingslimes_slime_block.png^[colorize:" .. def.color,"livingslimes_slime_block.png^[colorize:" .. def.color},
		},
		use_texture_alpha = true,
		stepheight = 1.1,
		glow = def.glow,

		-- Creatura properties
		max_health = def.max_health,
		armor_groups = (function()
			local groups = {fleshy = 100, fire = 100}
			local additional_groups = def.armor_groups or {}
			for group,value in pairs(additional_groups) do
				groups[group] = value
			end
			return groups
		end)(),
		fire_resistance = def.fire_resistance or 0,
		fall_resistance = 1,
		damage = def.damage,
		speed = def.speed,
		tracking_range = def.tracking_range,
		despawn_after = 1500,
		max_fall = 0,
		turn_rate = 6,
		-- water physics
		liquid_drag = 0,
		liquid_submergence = 0.0025,
		makes_footstep_sound = false,
		sounds = {
			move = {
				name = "livingslimes_move",
				gain = 2.75,
				distance = 40,
			},
			slurp = {
				name = "livingslimes_slurp",
				gain = 2.75,
				distance = 40,
			},
			attack = {
				name = "livingslimes_attack",
				gain = 10,
				distance = 40,
			},
			hit = {
				name = "livingslimes_hit",
				gain = 10,
				distance = 40,
			},
			hurt = {
				name = "livingslimes_hit",
				gain = 10,
				distance = 40,
			},
			die = {
				name = "livingslimes_die",
				gain = 10,
				distance = 40,
			},
			fire = {
				name = livingslimes.fire.sound,
				gain = 1,
				distance = 40,
			},
			digest = {
				name = "livingslimes_digest",
				gain = 2.75,
				distance = 40,
			},
		},
		hitbox = {
			width = def.size / 10,
			height = def.size / 5,
		},
		animations = {
			none = {
				range = { x = 0, y = 0 },
				speed = 10,
				loop = true,
			},
			idle = {
				range = { x = 0, y = 19 },
				speed = 10,
				frame_blend = 0.3,
				loop = true,
			},
			move = {
				range = { x = 21, y = 40 },
				speed = 30,
				frame_blend = 0.3,
				loop = true,
			},
			fall = {
				range = { x = 42, y = 62 },
				speed = 20,
				frame_blend = 0.3,
				loop = true,
			},
			jump = {
				range = { x = 63, y = 83 },
				speed = 20,
				frame_blend = 0.3,
				loop = true,
			},
		},
		drops = (function()
			local d = {
				{
					name = goo,
					min = 1,
					max = 2,
					chance = 1,
				},
			}
			if def.drops then
				for _,drop in ipairs(def.drops) do
					d[#d + 1] = drop
				end
			end
			return d
		end)(),
		utility_stack = (function()
			local stack = {}
			for i = 1, #def.behaviors do
				local behavior = livingslimes.behaviors[def.behaviors[i]]
				while behavior and not behavior.enabled do
					behavior = livingslimes.behaviors[behavior.alternative or ""]
				end
				if behavior then
					stack[#stack + 1] = behavior
				end
			end
			return stack
		end)(),

		-- Functions
		on_punch = def.behaviors.neutral and function(self, puncher, ...)
			punchback(self,puncher)
			creatura.basic_punch_func(self, puncher, ...)
			local name = puncher:is_player() and puncher:get_player_name()
			if name then
				if not self.enemies[name] then
					self.enemies[name] = true
					self.enemies[0] = self.enemies[0] + 1
					if self.enemies[0] > 15 then
						for ename,_ in pairs(self.enemies) do
							if ename ~= 0 then
								self.enemies[ename] = nil
								self.enemies[0] = 15
								break
							end
						end
					end
					self.enemies = self:memorize("enemies", self.enemies)
				end
			end
		end or function(self, puncher, ...)
			punchback(self,puncher)
			creatura.basic_punch_func(self, puncher, ...)
		end,

		activate_func = function(self)
			-- General initialization
			self:animate("idle")
			self.is_floating_mob = true
			self.step_sound_timer = 0
			self.poison = poison_node
			self.diet = def.diet
			self.diet_set = (function()
				local items = {}
				for item,_ in pairs(def.diet) do
					table.insert(items,item)
				end
				return items
			end)()

			-- Stateful initialization
			self.enemies = def.behaviors.neutral and (self:recall("enemies") or self:memorize("enemies",{ [0] = 0 })) or nil
			self.stomach = {
				contents = self:recall("stomach") or self:memorize("stomach",{
					a = 1,
					z = 0,
					digestion_timer = livingslimes.settings.digest_timer,
				}),
				add = function(self,item)
					self.contents.z = self.contents.z + 1
					self.contents[self.contents.z] = item
					self.contents.digestion_timer = self:size() == 1 and livingslimes.settings.digest_timer or self.contents.digestion_timer
				end,
				digest = function(self)
					self.contents[self.contents.a] = nil
					self.contents.a = self.contents.a + 1
					self.contents.digestion_timer = livingslimes.settings.digest_timer
				end,
				size = function(self)
					return self.contents.z - self.contents.a + 1
				end,
				tick = function(self,dtime)
					self.contents.digestion_timer = self.contents.digestion_timer - dtime
				end,
				can_digest = function(self)
					return (self:size() > 0 and self.contents.digestion_timer <= 0) and true or false
				end,
				drop = function(self,pos)
					for i = self.contents.a, self.contents.z do
						minetest.add_item({x=pos.x + math.random()/2,y=pos.y+0.5,z=pos.z+math.random()/2}, self.contents[i])
					end
				end,
			}

			-- Item stealing function
			self.steal_item = function(player)
				local inventory = player and player:get_inventory()
				local size = inventory and inventory:get_size("main")
				if size and size > 0 then
					local hotbar = {}
					for i = 1, player:hud_get_hotbar_itemcount() do
						local item = inventory:get_stack("main",i)
						if item and not item:is_empty() then
							hotbar[#hotbar + 1] = {
								index = i,
								item = item,
							}
						end
					end
					if #hotbar > 0 then
						local stolen = hotbar[math.random(#hotbar)]
						self.stomach:add(stolen.item:to_string())
						inventory:set_stack("main",stolen.index,ItemStack(nil))
					end
				end
			end
		end,

		step_func = function(self,dtime,moveresult)
			self.step_sound_timer = self.step_sound_timer - dtime
			self.stomach:tick(self.dtime)
			local velocity = self.object:get_velocity()
			local pos = self.object:get_pos()
			if (math.abs(velocity.x) > 0.025 or math.abs(velocity.z) > 0.025) and self.step_sound_timer <= 0 then
				self:play_sound("move")
				self.step_sound_timer = 1.5
			end
		end,

		death_func = function(self)
			if self:get_utility() ~= "livingslimes:die" then
				self:initiate_utility("livingslimes:die", self)
			end
		end,
	})

	-- Register spawn egg for slime mob
	creatura.register_spawn_egg(mob,def.color:sub(2,-5),"555")

	-- Create spawning rules for slime mob
	creatura.register_abm_spawn(mob,{
		chance = def.spawn_chance,
		interval = 30,
		min_height = def.min_height,
		max_height = def.max_height,
		min_light = def.min_light,
		max_light = def.max_light,
		min_group = def.min_group,
		max_group = def.max_group,
		block_protected = true,
		biomes = def.spawn_biomes,
		nodes = def.spawn_nodes,
		spawn_in_nodes = false,
		spawn_cap = def.spawn_cap,
	})
end

-- Override Creatura's default water physics; slimes must rise quickly in
-- liquids and must float on top of liquids
-- Define gravity constants
local fall_gravity = -9.8
local float_gravity = 0.0001
local rise_gravity = 2

local odwp = creatura.default_water_physics
creatura.default_water_physics = function(self)
  if not self.is_floating_mob then
    odwp(self)
  else
		local pos = self.object:get_pos()
		local below = pos:add(vector.new(0,-1,0))
		local posnode = minetest.get_node(pos).name
		local belownode = minetest.get_node(below).name
		local velocity = self.object:get_velocity()
		local gravity = fall_gravity
		if is_liquid[posnode] then
			self:set_gravity(rise_gravity)
			gravity = rise_gravity
		else
			if is_liquid[belownode] then
				self:set_gravity(float_gravity)
				gravity = float_gravity
				if math.abs(velocity.x) > 0.25 or math.abs(velocity.z) > 0.25 then
					self.object:set_velocity({x = 0, y = -0.75, z = 0})
				else
					self.object:set_velocity({x = 0, y = -0.425, z = 0})
				end
			else
				self:set_gravity(fall_gravity)
				gravity = fall_gravity
			end
		end
		self.object:set_acceleration({x = 0, y = gravity, z = 0})
	end
end