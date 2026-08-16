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
				self:go_to(ft)
			else
				self:handle_night()
				self:set_state_info("Following my village routine.")
				self:set_displayed_action("village resident")
				
				local pos = self.object:get_pos()
				if pos then
					local center = self.pos_data.job_pos or self.pos_data.home_pos or pos
					local target = {
						x = center.x + math.random(-15, 15),
						y = center.y,
						z = center.z + math.random(-15, 15)
					}
					local ok, gpos = pcall(working_villages.require("jobs/util").find_ground_below, target)
					if ok and gpos then target = gpos end
					self:go_to(target)
				end
				self:delay(math.random(1, 3))
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
	local existing = find_existing(bed_pos, id)
	if existing then return existing end

	local spawn_pos = house_entrance(bpos, bed_nr, bed)
	spawn_pos.y = spawn_pos.y + 0.5
	local gender = bed.gender == "f" and "female" or "male"
	local object = minetest.add_entity(spawn_pos, "working_villages:villager_" .. gender)
	if not object then
		minetest.log("error", "[stl_village_bridge] Could not spawn resident for " .. id)
		return nil
	end

	local villager = object:get_luaentity()
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
	return villager.inventory_name or id
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
						local flee_dir = vector.normalize(vec)
						local flee_target = vector.add(mypos, vector.multiply(flee_dir, 15))
						flee_target = vector.round(flee_target)
						local ok, gpos = pcall(working_villages.require("jobs/util").find_ground_below, flee_target)
						if ok and gpos then flee_target = gpos end
						
						self.flee_target = flee_target
						self.path = {}
						if self.set_timer then self:set_timer("delay", 9999) end
					end
				end
			end
		end
	end
end)
