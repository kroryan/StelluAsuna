-- Planet fauna integration. This deliberately reuses Animalia/Creatura's
-- real meshes, animations, sounds, drops and AI instead of spawning cubes.
-- Each planet receives its own species profile and a distinct colour morph.

local planet_species = {
	"animalia:cow", "animalia:fox", "animalia:frog", "animalia:horse",
	"animalia:opossum", "animalia:owl", "animalia:pig", "animalia:rat",
	"animalia:reindeer", "animalia:sheep", "animalia:song_bird", "animalia:turkey",
	"animalia:tropical_fish", "animalia:wolf", "animalia:bat", "animalia:cat",
	"animalia:chicken", "animalia:grizzly_bear", "animalia:cow", "animalia:fox",
	"animalia:frog", "animalia:sheep", "animalia:wolf",
}

local morphs = {
	"#ff805c", "#77c8ff", "#d4a5ff", "#a8e063", "#ffd166", "#f48fb1",
	"#7de2d1", "#e4c1f9", "#ff9f1c", "#b8b8ff", "#f7b267", "#70d6ff",
	"#e07a5f", "#81b29a", "#f2cc8f", "#c77dff", "#80ed99", "#ff70a6",
	"#90e0ef", "#f4a261", "#a7c957", "#e9c46a", "#bb9af7",
}

local timer = 0

local function nearby_species(pos, species)
	local count = 0
	for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 36)) do
		local ent = obj:get_luaentity()
		if ent and ent.name == species then count = count + 1 end
	end
	return count
end

local function spawn_planet_animal(player, planet)
	local species = planet_species[planet]
	local def = species and minetest.registered_entities[species]
	if not def or nearby_species(player:get_pos(), species) > 0 then return end
	local p = vector.round(player:get_pos() + vector.new(math.random(-14, 14), 0, math.random(-14, 14)))
	local ground = minetest.find_nodes_in_area_under_air(
		vector.subtract(p, 5), vector.add(p, 5), {"group:soil", "group:stone"})
	for _, node_pos in ipairs(ground or {}) do
		local spawn = vector.add(node_pos, {x=0, y=1, z=0})
		local a = minetest.get_node_or_nil(spawn)
		local b = minetest.get_node_or_nil(vector.add(spawn, {x=0, y=1, z=0}))
		if a and b and a.name == "air" and b.name == "air" then
			local obj = minetest.add_entity(spawn, species)
			if obj then
				-- Keep Animalia's model, animation, sounds, drops and AI. Add an
				-- original planet-specific texture layer plus a restrained colour
				-- morph so every world has a recognisable fauna appearance.
				local props = obj:get_properties()
				local texture = props and props.textures and props.textures[1]
				if texture and morphs[planet] then
					local pattern = string.format("stl_fauna_planet_%02d.png", planet)
					obj:set_properties({textures={texture .. "^[colorize:" .. morphs[planet] .. ":45^" .. pattern}})
				end
			end
			return
		end
	end
end

minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < 22 then return end
	timer = 0
	for _, player in ipairs(minetest.get_connected_players()) do
		local pos = player:get_pos()
		local planet = stellua.get_planet_index(pos.y)
		if planet and stellua.planets[planet]
		and pos.y > (stellua.planets[planet].level - 24) then
			spawn_planet_animal(player, planet)
		end
	end
end)

minetest.log("action", "[stl_fauna] Planet fauna uses Animalia meshes, textures, sounds and AI for 23 species profiles")
