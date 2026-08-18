local RESIDENT_JOB = "stl_village_bridge:resident_routine"
local pending_spawns = {}

working_villages.register_job(RESIDENT_JOB, {
	description = "village resident",
	long_description = "I follow the village day/night routine and return home to sleep.",
	inventory_image = "default_paper.png",
	jobfunc = function(self)
		while true do
			if self.flee_target then
				local ft = self.flee_target
				self.flee_target = nil
				self:set_state_info("Fleeing in panic!")
				self:set_animation(working_villages.animation_frames.WALK)
				-- Flee by running to the target
				self:go_to(ft)
			else
				self:handle_night()
				if self.ai_inside_home and self.pos_data.door_pos then
					self:set_state_info("I am finding the way out of my house.")
					self:set_displayed_action("leaving home")
					local exit_pos = self.pos_data.door_pos
					if working_villages.navigation_get_door_exit then
						exit_pos = working_villages.navigation_get_door_exit(self, exit_pos)
					end
					local left = self:go_to(exit_pos)
					if left == true then
						self.ai_inside_home = false
					else
						self:set_state_info("My exit is blocked; I will retry after scanning the house.")
						self:delay(30)
					end
				else
				self:set_state_info("Following my village routine.")
				self:set_displayed_action("village resident")
				
				local pos = self.object:get_pos()
				if pos then
					local gpos = nil
					for i=1, 5 do
						local target = {
							x = pos.x + math.random(-6, 6),
							y = pos.y,
							z = pos.z + math.random(-6, 6)
						}
						local ok, gp = pcall(working_villages.require("jobs/util").find_ground_below, target)
						if ok and gp then
							local p1 = {x=pos.x, y=pos.y+1, z=pos.z}
							local p2 = {x=gp.x, y=gp.y+1, z=gp.z}
							if minetest.line_of_sight(p1, p2) then
								gpos = gp
								break
							end
						end
					end
					if gpos then
						self:go_to(gpos)
					end
				end
				self:delay(math.random(20, 50))
				end
			end
		end
	end,
})

local function bridge_id(village_id, plot_nr, bed_nr)
	return tostring(village_id) .. ":" .. tostring(plot_nr) .. ":" .. tostring(bed_nr)
end

local function find_existing(pos, id)
	for _, object in ipairs(minetest.get_objects_inside_radius(pos, 12)) do
		local entity = object:get_luaentity()
		if entity and entity.pos_data and entity.pos_data.stelluasuna_bed_id == id then
			return entity.inventory_name or id
		end
	end
end

local function house_entrance(bpos, bed_nr, bed)
	if handle_schematics and handle_schematics.get_pos_in_front_of_house then
		local ok, pos = pcall(handle_schematics.get_pos_in_front_of_house, bpos, bed_nr)
		if ok and pos then return vector.round(pos) end
	end
	return {x=bed.x, y=bed.y, z=bed.z}
end

local function workplace(village_id, bed)
	local village = mg_villages.all_villages and mg_villages.all_villages[village_id]
	local plots = village and village.to_add_data and village.to_add_data.bpos
	local work = plots and bed.works_at and plots[bed.works_at]
	if not work then return nil end
	return house_entrance(work, 1, bed)
end

mg_villages.inhabitants.spawn_one_mob = function(bed, village_id, plot_nr, bed_nr, bpos)
	local id = bridge_id(village_id, plot_nr, bed_nr)
	local bed_pos = {x=bed.x, y=bed.y, z=bed.z}
	if pending_spawns[id] then return id end
	pending_spawns[id] = true
	
	minetest.after(2, function()
		pending_spawns[id] = nil
		local existing = find_existing(bed_pos, id)
		if existing then return end

		local spawn_pos = house_entrance(bpos, bed_nr, bed)
		spawn_pos.y = spawn_pos.y + 0.5
		local gender = bed.gender == "f" and "female" or "male"
		local object = minetest.add_entity(spawn_pos, "working_villages:villager_" .. gender)
		if not object then
			minetest.log("error", "[stl_village_bridge] Could not spawn resident for " .. id)
			return
		end

		local villager = object:get_luaentity()
		if not villager then return end
		villager.owner_name = "working_villages:self_employed"
		villager.nametag = table.concat({bed.first_name or "Resident", bed.middle_name or "", bed.last_name or ""}, " ")
		villager.pos_data.home_pos = vector.round(spawn_pos)
		villager.pos_data.door_pos = vector.round(spawn_pos)
		villager.pos_data.bed_pos = bed_pos
		villager.pos_data.job_pos = workplace(village_id, bed)
		villager.pos_data.stelluasuna_bed_id = id
		villager.stl_population_type = "working_villages_bed_resident"
		object:set_nametag_attributes({text=villager.nametag})

		local inventory = villager:get_inventory()
		inventory:set_stack("job", 1, ItemStack(RESIDENT_JOB))
		local job = working_villages.registered_jobs[RESIDENT_JOB]
		villager.job_thread = coroutine.create(job.jobfunc)
		villager:set_displayed_action("village resident")
		villager:set_state_info("This is my home in " .. tostring(village_id) .. ".")

		minetest.log("action", "[stl_village_bridge] Resident " .. id .. " assigned to bed " .. minetest.pos_to_string(bed_pos))
	end)
	
	return id
end

minetest.log("action", "[stl_village_bridge] mg_villages -> working_villages population bridge active")

minetest.register_on_mods_loaded(function()
	for _, gender in ipairs({"male", "female"}) do
		local entity_name = "working_villages:villager_" .. gender
		local def = minetest.registered_entities[entity_name]
		if def then
			local old_on_activate = def.on_activate
			local old_on_punch = def.on_punch
			def.on_activate = function(self, staticdata, dtime_s)
				if old_on_activate then old_on_activate(self, staticdata, dtime_s) end
				if self.pos_data and not self.pos_data.door_pos then
					self.pos_data.door_pos = self.pos_data.home_pos
				end
				if self.get_job_name and self:get_job_name() == RESIDENT_JOB then
					-- Entity persistence can restore a dead coroutine or a stale pause
					-- flag. Recreate the single resident routine so villagers never load
					-- as silent, immobile statues after a restart.
					local job = working_villages.registered_jobs[RESIDENT_JOB]
					if job and (not self.job_thread or coroutine.status(self.job_thread) == "dead") then
						self.job_thread = coroutine.create(job.jobfunc)
					end
					self.pause = false
					minetest.log("action", "[stl_village_bridge] Recovered resident " .. tostring(self.nametag) .. " on load.")
				end
			end
			
				local function damage_villager(self, amount)
					amount = tonumber(amount) or 0
					if amount <= 0 or not self.object:get_pos() then return end
					amount = math.max(1, math.floor(amount))
					local hp = self.object:get_hp()
					if hp <= 0 then return end
					local new_hp = math.max(0, hp - amount)
					self.object:set_hp(new_hp)
					if new_hp == 0 then
						self.object:remove()
					end
				end

				def.on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
					if old_on_punch then
						old_on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
					end
					-- Keep the bridge wrapper from swallowing the working_villagers AI
					-- callback. Residents must alert nearby allies and defend themselves
					-- even when another mod supplied the damage callback.
					if self.ai_on_punch and puncher then
						self:ai_on_punch(puncher)
					end
					if not damage or damage <= 0 then
						local groups = tool_capabilities and tool_capabilities.damage_groups
						damage = groups and groups.fleshy or 1
					end
					damage_villager(self, damage)
					return true
				end

				local function environment_damage(pos)
					local min_x = math.floor(pos.x - 0.3)
					local max_x = math.floor(pos.x + 0.3)
					local min_y = math.floor(pos.y - 0.25)
					local max_y = math.floor(pos.y + 1.75)
					local min_z = math.floor(pos.z - 0.3)
					local max_z = math.floor(pos.z + 0.3)
					local dps = 0

					for x = min_x, max_x do
						for y = min_y, max_y do
							for z = min_z, max_z do
								local node = minetest.get_node_or_nil({x=x, y=y, z=z})
								local defn = node and minetest.registered_nodes[node.name]
								if defn and (defn.damage_per_second or 0) > dps then
									dps = defn.damage_per_second
								end
							end
						end
					end
					return dps
				end

				local old_on_step = def.on_step
				def.on_step = function(self, dtime, moveresult)
					if old_on_step then old_on_step(self, dtime, moveresult) end
					self.env_damage_timer = (self.env_damage_timer or 0) + dtime
					if self.env_damage_timer >= 1.0 then
						local elapsed = self.env_damage_timer
						self.env_damage_timer = 0
						local pos = self.object:get_pos()
						if pos then
							damage_villager(self, environment_damage(pos) * elapsed)
						end
					end
				end
		end
	end
end)
