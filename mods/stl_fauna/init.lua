-- Original, deliberately lightweight planet fauna for StelluAsuna.
-- Each generated planet gets its own registered species name, palette,
-- silhouette and behaviour profile. Spawning is capped per player/planet.

local modname = "stl_fauna"
local species = {}
local palettes = {
	"#ff6b4a", "#7bdff2", "#d4a5ff", "#b8e986", "#ffd166", "#f78fb3",
	"#8be9fd", "#caffbf", "#ff9f1c", "#b8b8ff", "#f7b267", "#70d6ff",
	"#e07a5f", "#81b29a", "#f2cc8f", "#c77dff", "#80ed99", "#ff70a6",
	"#90e0ef", "#f4a261", "#a7c957", "#e9c46a", "#bb9af7", "#ef476f",
}

local function esc(value)
	return minetest.formspec_escape(tostring(value or ""))
end

local function on_step(self, dtime)
	if not self.object:is_valid() then return end
	local pos = self.object:get_pos()
	if not pos then self.object:remove(); return end
	if stellua.get_planet_index(pos.y) ~= self.planet then
		self.object:remove(); return
	end
	self.age = (self.age or 0) + dtime
	self.think = (self.think or 0) - dtime
	if self.age > 900 then self.object:remove(); return end
	if self.think > 0 then return end
	self.think = 1.5 + (self.seed % 10) * 0.08
	local target
	for _, player in ipairs(minetest.get_connected_players()) do
		local p = player:get_pos()
		if minetest.get_planet_index(p.y) == self.planet and vector.distance(pos, p) < 18 then
			target = player; break
		end
	end
	local dir = vector.new(((self.seed % 3) - 1), 0, (((self.seed * 7) % 3) - 1))
	if target and self.hostile then
		dir = target:get_pos() - pos
		dir.y = 0
		if vector.distance(pos, target:get_pos()) < 1.8 then
			target:set_hp(math.max(target:get_hp() - 1, 0), {reason="hit", type="by_mob"})
		end
	end
	if vector.length(dir) > 0 then dir = vector.normalize(dir) end
	local speed = self.speed or 0.8
	self.object:set_velocity(vector.new(dir.x * speed, self.object:get_velocity().y, dir.z * speed))
	self.object:set_yaw(math.atan2(-dir.x, dir.z))
end

for i = 1, 23 do
	local id = string.format("%02d", i)
	local color = palettes[i]
	local scale = 0.65 + (i % 5) * 0.12
	local hostile = (i % 4 == 0)
	local name = modname .. ":planet_" .. id
	species[i] = name
	minetest.register_entity(name, {
		initial_properties = {
			physical = true, collide_with_objects = true,
			collisionbox = {-0.32*scale, -0.5*scale, -0.32*scale, 0.32*scale, 0.5*scale, 0.32*scale},
			visual = "cube", visual_size = {x=scale, y=scale, z=scale},
			textures = {"stl_core_stone"..((i-1)%8+1)..".png^[colorize:"..color..":180"},
			makes_footstep_sound = false, static_save = true,
		},
		planet = i, hostile = hostile, speed = 0.5 + (i % 4) * 0.18,
		on_activate = function(self, staticdata)
			local data = staticdata and minetest.deserialize(staticdata)
			if type(data) == "table" then self.age = tonumber(data.age) or 0; self.seed = tonumber(data.seed) or i end
			self.seed = self.seed or i * 17
		end,
		get_staticdata = function(self)
			return minetest.serialize({age=self.age or 0, seed=self.seed or i*17})
		end,
		on_step = on_step,
	})
end

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < 18 then return end
	timer = 0
	for _, player in ipairs(minetest.get_connected_players()) do
		local p = player:get_pos()
		local planet = stellua.get_planet_index(p.y)
		if planet and p.y > (stellua.planets[planet].level - 24) then
			local count = 0
			for _, obj in ipairs(minetest.get_objects_inside_radius(p, 32)) do
				local ent = obj:get_luaentity()
				if ent and ent.name == species[planet] then count = count + 1 end
			end
			if count == 0 then
				local base = vector.round(p + vector.new(math.random(-12,12), 0, math.random(-12,12)))
				local ground = minetest.find_nodes_in_area_under_air(
					vector.subtract(base, 4), vector.add(base, 4), {"group:soil", "group:stone"})
				for _, g in ipairs(ground or {}) do
					local spawn = vector.add(g, {x=0, y=1, z=0})
					local above = minetest.get_node_or_nil(spawn)
					local above2 = minetest.get_node_or_nil(vector.add(spawn, {x=0,y=1,z=0}))
					if above and above2 and above.name == "air" and above2.name == "air" then
						local obj = minetest.add_entity(spawn, species[planet], minetest.serialize({seed=math.random(1,999999)}))
						if obj then obj:get_luaentity().planet = planet end
						break
					end
				end
			end
		end
	end
end)

minetest.log("action", "[stl_fauna] Registered 23 original planet-specific species")
