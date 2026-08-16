local RESIDENT_JOB = "stl_village_bridge:resident_routine"

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
	
	minetest.after(2, function()
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
		villager.pos_data.bed_pos = bed_pos
		villager.pos_data.job_pos = workplace(village_id, bed)
		villager.pos_data.stelluasuna_bed_id = id
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
			def.on_activate = function(self, staticdata, dtime_s)
				if old_on_activate then old_on_activate(self, staticdata, dtime_s) end
				if self.pause and self.get_job_name and self:get_job_name() == RESIDENT_JOB then
					self.pause = false
					minetest.log("action", "[stl_village_bridge] Recovered and unpaused resident " .. tostring(self.nametag) .. " on load.")
				end
			end
			
			local old_on_punch = def.on_punch
			def.on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
				if old_on_punch then old_on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir, damage) end
				
				if puncher and puncher:get_pos() then
					local mypos = self.object:get_pos()
					local ppos = puncher:get_pos()
					if mypos and ppos then
						local vec = vector.subtract(mypos, ppos)
						vec.y = 0
						if vector.length(vec) < 0.1 then vec = {x=math.random()-0.5, y=0, z=math.random()-0.5} end
						
						-- Retaliate before running!
						if puncher.get_hp and puncher:get_hp() > 0 then
							puncher:punch(self.object, 1.0, {
								full_punch_interval = 1.0,
								damage_groups = {fleshy = 2}
							}, nil)
						end
						
						local flee_dir = vector.normalize(vec)
						local flee_target = nil
						-- Check distances 8, 6, 4, 2 to find a point that is in line of sight
						for _, dist in ipairs({8, 6, 4, 2}) do
							local tgt = vector.add(mypos, vector.multiply(flee_dir, dist))
							tgt = vector.round(tgt)
							local ok, gp = pcall(working_villages.require("jobs/util").find_ground_below, tgt)
							if ok and gp then
								local p1 = {x=mypos.x, y=mypos.y+1, z=mypos.z}
								local p2 = {x=gp.x, y=gp.y+1, z=gp.z}
								if minetest.line_of_sight(p1, p2) then
									flee_target = gp
									break
								end
							end
						end
						
						if flee_target then
							self.flee_target = flee_target
							self.path = {}
							if self.set_timer then self:set_timer("delay", 9999) end
						end
					end
				end
			end
		end
	end
end)
