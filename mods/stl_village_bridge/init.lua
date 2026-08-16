local RESIDENT_JOB = "stl_village_bridge:resident_routine"

working_villages.register_job(RESIDENT_JOB, {
	description = "village resident",
	long_description = "I follow the village day/night routine and return home to sleep.",
	inventory_image = "default_paper.png",
	jobfunc = function(self)
		while true do
			-- working_villages supplies the pathfinding, bedtime threshold,
			-- bed animation, dawn wait and return-home behaviour.
			self:handle_night()
			self:set_state_info("Following my village routine.")
			self:set_displayed_action("village resident")
			
			local pos = self.object:get_pos()
			if pos then
				local center = self.pos_data.job_pos or self.pos_data.home_pos or pos
				local target = {
					x = center.x + math.random(-10, 10),
					y = center.y,
					z = center.z + math.random(-10, 10)
				}
				-- Find ground so they don't try to fly
				local ok, gpos = pcall(working_villages.require("jobs/util").find_ground_below, target)
				if ok and gpos then target = gpos end
				self:go_to(target)
			end
			
			self:delay(math.random(30, 80))
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

-- mg_villages intentionally exposes this hook for a mob implementation.
-- Its mapgen calls it once for every named bed whose mapblock is generated.
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
