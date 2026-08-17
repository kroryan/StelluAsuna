
local S = chemistry.getter

--
-- Aluminium
--

minetest.register_tool("chemistry:aluminium_pick", {
	description = S("Aluminium Pickaxe"),
	inventory_image = "aluminium_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.40, [2]=1.80, [3]=0.90}, uses=65, maxlevel=2},
		},
		damage_groups = {fleshy=3.5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:aluminium_sword", {
	description = S("Aluminium Sword"),
	inventory_image = "aluminium_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.6, [2]=1.30, [3]=0.45}, uses=65, maxlevel=2},
		},
		damage_groups = {fleshy=5.5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:aluminium_shovel", {
	description = S("Aluminium Shovel"),
	inventory_image = "aluminium_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.60, [2]=0.90, [3]=0.50}, uses=65, maxlevel=2},
		},
		damage_groups = {fleshy=2.5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:aluminium_axe", {
	description = S("Aluminium Axe"),
	inventory_image = "aluminium_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.60, [2]=1.50, [3]=1.10}, uses=65, maxlevel=2},
		},
		damage_groups = {fleshy=4.5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})
---
--- Steel-Manganese Alloy
---

minetest.register_tool("chemistry:steel_sword", {
	description = S("Steel-Manganese alloy Sword"),
	inventory_image = "default_tool_steelsword.png^[colorize:red:50",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:steel_axe", {
	description = S("Steel-Manganese alloy Axe"),
	inventory_image = "default_tool_steelaxe.png^[colorize:red:50",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.25, [2]=1.20, [3]=0.75}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("chemistry:steel_shovel", {
	description = S("Steel-Manganese alloy Shovel"),
	inventory_image = "default_tool_steelshovel.png^[colorize:red:50",
	wield_image = "default_tool_steelshovel.png^[colorize:red:50",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.00, [2]=0.10, [3]=0.05}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:steel_pick", {
	description = S("Steel-Manganese alloy Pickaxe"),
	inventory_image = "default_tool_steelpick.png^[colorize:red:50",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=3.70, [2]=1.40, [3]=0.65}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

---
--- Molybdenum-Aluminium Alloy (same as Manganese alloy but faster)
---

minetest.register_tool("chemistry:mol_alu_sword", {
	description = S("Molybdenum-Aluminium alloy Sword"),
	inventory_image = "mol-alu_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.2, [2]=1.15, [3]=0.325}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:mol_alu_axe", {
	description = S("Molybdenum-Aluminium alloy Axe"),
	inventory_image = "mol-alu_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.15, [2]=1.15, [3]=0.70}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("chemistry:mol_alu_shovel", {
	description = S("Molybdenum-Aluminium alloy Shovel"),
	inventory_image = "mol-alu_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.95, [2]=0.10, [3]=0.05}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:mol_alu_pick", {
	description = S("Molybdenum-Aluminium alloy Pickaxe"),
	inventory_image = "mol-alu_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=3.60, [2]=1.30, [3]=0.60}, uses=70, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

----
---- Titanium
----

minetest.register_tool("chemistry:titanium_sword", {
	description = S("Titanium Sword"),
	inventory_image = "titanium_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.5, [2]=0.20, [3]=0.35}, uses=380, maxlevel=4},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:titanium_pick", {
	description = S("Titanium Pickaxe"),
	inventory_image = "titanium_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.70, [2]=0.80, [3]=0.45}, uses=180, maxlevel=4},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:titanium_shovel", {
	description = S("Titanium Shovel"),
	inventory_image = "titanium_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.40, [2]=0.90, [3]=0.30}, uses=270, maxlevel=4},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:titanium_axe", {
	description = S("Titanium Axe"),
	inventory_image = "titanium_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.30, [2]=1.00, [3]=0.90}, uses=200, maxlevel=4},
		},
		damage_groups = {fleshy=8},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

-----
----- Cobalt
-----

minetest.register_tool("chemistry:cobalt_sword", {
	description = S("Cobalt Sword"),
	inventory_image = "cobalt_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.5, [2]=0.40, [3]=0.35}, uses=680, maxlevel=5},
		},
		damage_groups = {fleshy=13},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:cobalt_pick", {
	description = S("Cobalt Pickaxe"),
	inventory_image = "cobalt_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.9,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.60, [2]=0.70, [3]=0.50}, uses=200, maxlevel=5},
		},
		damage_groups = {fleshy=11},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:cobalt_shovel", {
	description = S("Cobalt Shovel"),
	inventory_image = "cobalt_shovel.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.05}, uses=270, maxlevel=5},
		},
		damage_groups = {fleshy=10},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:cobalt_axe", {
	description = S("Cobalt Axe"),
	inventory_image = "cobalt_axe.png",
	tool_capabilities = {
		full_punch_interval = 5.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.00, [2]=0.90, [3]=0.60}, uses=400, maxlevel=5},
		},
		damage_groups = {fleshy=12},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

------
------ Osmium
------

minetest.register_tool("chemistry:osmium_sword", {
	description = S("Osmium Sword"),
	inventory_image = "osmium_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.5, [2]=0.20, [3]=0.35}, uses=680, maxlevel=6},
		},
		damage_groups = {fleshy=17},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:osmium_pick", {
	description = S("Osmium Pickaxe"),
	inventory_image = "osmium_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.9,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.60, [2]=0.60, [3]=0.45}, uses=400, maxlevel=6},
		},
		damage_groups = {fleshy=15},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:osmium_shovel", {
	description = S("Osmium Shovel"),
	inventory_image = "osmium_shovel.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.20, [2]=0.20, [3]=0.05}, uses=470, maxlevel=6},
		},
		damage_groups = {fleshy=14},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:osmium_axe", {
	description = S("Osmium Axe"),
	inventory_image = "osmium_axe.png",
	tool_capabilities = {
		full_punch_interval = 5.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=600, maxlevel=6},
		},
		damage_groups = {fleshy=16},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

-------
------- Tungsten
-------

minetest.register_tool("chemistry:tungsten_sword", {
	description = S("Tungsten Sword"),
	inventory_image = "tungsten_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.5, [2]=0.20, [3]=0.35}, uses=750, maxlevel=7},
		},
		damage_groups = {fleshy=22},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:tungsten_pick", {
	description = S("Tungsten Pickaxe"),
	inventory_image = "tungsten_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.9,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.80, [2]=0.90, [3]=0.45}, uses=600, maxlevel=7},
		},
		damage_groups = {fleshy=20},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:tungsten_shovel", {
	description = S("Tungsten Shovel"),
	inventory_image = "tungsten_shovel.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.20, [2]=0.20, [3]=0.05}, uses=770, maxlevel=7},
		},
		damage_groups = {fleshy=19},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:tungsten_axe", {
	description = S("Tungsten Axe"),
	inventory_image = "tungsten_axe.png",
	tool_capabilities = {
		full_punch_interval = 5.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=800, maxlevel=7},
		},
		damage_groups = {fleshy=21},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

--------
-------- Tungsten Carbide (Technic Exclusive)
--------

if minetest.get_modpath("technic") then
minetest.register_tool("chemistry:wc_sword", {
	description = S("Tungsten Carbide Sword"),
	inventory_image = "tungsten_carbide_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.25, [2]=0.10, [3]=0.15}, uses=1000, maxlevel=7},
		},
		damage_groups = {fleshy=27},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:wc_pick", {
	description = S("Tungsten Carbide Pickaxe"),
	inventory_image = "tungsten_carbide_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.9,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.40, [2]=0.45, [3]=0.35}, uses=1000, maxlevel=7},
		},
		damage_groups = {fleshy=25},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:wc_shovel", {
	description = S("Tungsten Carbide Shovel"),
	inventory_image = "tungsten_carbide_shovel.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.10, [2]=0.10, [3]=0.05}, uses=1000, maxlevel=7},
		},
		damage_groups = {fleshy=24},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:wc_axe", {
	description = S("Tungsten Carbide Axe"),
	inventory_image = "tungsten_carbide_axe.png",
	tool_capabilities = {
		full_punch_interval = 5.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.60, [2]=0.30, [3]=0.15}, uses=1000, maxlevel=7},
		},
		damage_groups = {fleshy=26},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})
end

---------
--------- Stronger Stone
---------

minetest.register_tool("chemistry:stone_sword", {
	description = S("Stronger Stone Sword"),
	inventory_image = "strong_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.25, [2]=0.10, [3]=0.15}, uses=1000, maxlevel=8},
		},
		damage_groups = {fleshy=32},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:stone_pick", {
	description = S("Stronger Stone Pickaxe"),
	inventory_image = "strong_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.9,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.40, [2]=0.45, [3]=0.325}, uses=1000, maxlevel=8},
		},
		damage_groups = {fleshy=30},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:stone_shovel", {
	description = S("Stronger Stone Shovel"),
	inventory_image = "strong_shovel.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.10, [2]=0.10, [3]=0.05}, uses=1000, maxlevel=8},
		},
		damage_groups = {fleshy=29},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:stone_axe", {
	description = S("Stronger Stone Axe"),
	inventory_image = "strong_axe.png",
	tool_capabilities = {
		full_punch_interval = 5.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.60, [2]=0.30, [3]=0.15}, uses=1000, maxlevel=8},
		},
		damage_groups = {fleshy=31},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

----------
---------- Stronger Obsidian
----------

minetest.register_tool("chemistry:obsidian_sword", {
	description = S("Stronger Obsidian Sword"),
	inventory_image = "st_obsidian_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.20, [2]=0.05, [3]=0.075}, uses=1250, maxlevel=9},
		},
		damage_groups = {fleshy=39},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:obsidian_pick", {
	description = S("Stronger Obsidian Pickaxe"),
	inventory_image = "st_obsidian_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.9,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.00, [2]=0.15, [3]=0.075}, uses=1250, maxlevel=9},
		},
		damage_groups = {fleshy=37},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:obsidian_shovel", {
	description = S("Stronger Obsidian Shovel"),
	inventory_image = "st_obsidian_shovel.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.050, [2]=0.050, [3]=0.025}, uses=1250, maxlevel=9},
		},
		damage_groups = {fleshy=36},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:obsidian_axe", {
	description = S("Stronger Obsidian Axe"),
	inventory_image = "st_obsidian_axe.png",
	tool_capabilities = {
		full_punch_interval = 5.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.30, [2]=0.15, [3]=0.15}, uses=1250, maxlevel=9},
		},
		damage_groups = {fleshy=38},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})
-----------
----------- Strong Gem
----------- 

minetest.register_tool("chemistry:strong_gem_sword", {
	description = S("Strong Gem Sword"),
	inventory_image = "st_gem_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.20, [2]=0.05, [3]=0.075}, uses=2000, maxlevel=10},
		},
		damage_groups = {fleshy=45},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1},
   light_source = 7,
})

minetest.register_tool("chemistry:strong_gem_pick", {
	description = S("Strong Gem Pickaxe"),
	inventory_image = "st_gem_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.9,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=1.00, [2]=0.15, [3]=0.075}, uses=2000, maxlevel=10},
		},
		damage_groups = {fleshy=43},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1},
   light_source = 7,
})

minetest.register_tool("chemistry:strong_gem_shovel", {
	description = S("Strong Gem Shovel"),
	inventory_image = "st_gem_shovel.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.050, [2]=0.050, [3]=0.025}, uses=2000, maxlevel=10},
		},
		damage_groups = {fleshy=42},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1},
   light_source = 7,
})

minetest.register_tool("chemistry:strong_gem_axe", {
	description = S("Strong Gem Axe"),
	inventory_image = "st_gem_axe.png",
	tool_capabilities = {
		full_punch_interval = 5.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.30, [2]=0.15, [3]=0.15}, uses=2000, maxlevel=10},
		},
		damage_groups = {fleshy=44},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1},
   light_source = 7,
})

---
--- Crafting
---

minetest.register_craft({
	output = 'chemistry:aluminium_pick',
	recipe = {
		{'chemistry:aluminium', 'chemistry:aluminium', 'chemistry:aluminium'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:aluminium_axe',
	recipe = {
		{'chemistry:aluminium', 'chemistry:aluminium', ''},
		{'chemistry:aluminium', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:aluminium_shovel',
	recipe = {
		{'', 'chemistry:aluminium', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:aluminium_sword',
	recipe = {
		{'', 'chemistry:aluminium', ''},
		{'', 'chemistry:aluminium', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:steel_pick',
	recipe = {
		{'chemistry:steel_ingot', 'chemistry:steel_ingot', 'chemistry:steel_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:steel_axe',
	recipe = {
		{'chemistry:steel_ingot', 'chemistry:steel_ingot', ''},
		{'chemistry:steel_ingot', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:steel_shovel',
	recipe = {
		{'', 'chemistry:steel_ingot', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:steel_sword',
	recipe = {
		{'', 'chemistry:steel_ingot', ''},
		{'', 'chemistry:steel_ingot', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:mol_alu_pick',
	recipe = {
		{'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:mol_alu_axe',
	recipe = {
		{'chemistry:mol_alu_ingot', 'chemistry:mol_alu_ingot', ''},
		{'chemistry:mol_alu_ingot', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:mol_alu_shovel',
	recipe = {
		{'', 'chemistry:mol_alu_ingot', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:mol_alu_sword',
	recipe = {
		{'', 'chemistry:mol_alu_ingot', ''},
		{'', 'chemistry:mol_alu_ingot', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:titanium_pick',
	recipe = {
		{'chemistry:titanium', 'chemistry:titanium', 'chemistry:titanium'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:titanium_axe',
	recipe = {
		{'chemistry:titanium', 'chemistry:titanium', ''},
		{'chemistry:titanium', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:titanium_shovel',
	recipe = {
		{'', 'chemistry:titanium', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:titanium_sword',
	recipe = {
		{'', 'chemistry:titanium', ''},
		{'', 'chemistry:titanium', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:cobalt_pick',
	recipe = {
		{'chemistry:cobalt', 'chemistry:cobalt', 'chemistry:cobalt'},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:cobalt_axe',
	recipe = {
		{'chemistry:cobalt', 'chemistry:cobalt', ''},
		{'chemistry:cobalt', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:cobalt_shovel',
	recipe = {
		{'', 'chemistry:cobalt', ''},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:cobalt_sword',
	recipe = {
		{'', 'chemistry:cobalt', ''},
		{'', 'chemistry:cobalt', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:tungsten_pick',
	recipe = {
		{'chemistry:tungsten', 'chemistry:tungsten', 'chemistry:tungsten'},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:tungsten_axe',
	recipe = {
		{'chemistry:tungsten', 'chemistry:tungsten', ''},
		{'chemistry:tungsten', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:tungsten_shovel',
	recipe = {
		{'', 'chemistry:tungsten', ''},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:tungsten_sword',
	recipe = {
		{'', 'chemistry:tungsten', ''},
		{'', 'chemistry:tungsten', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:wc_pick',
	recipe = {
		{'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide'},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:wc_axe',
	recipe = {
		{'chemistry:tungsten_carbide', 'chemistry:tungsten_carbide', ''},
		{'chemistry:tungsten_carbide', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:wc_shovel',
	recipe = {
		{'', 'chemistry:tungsten_carbide', ''},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:wc_sword',
	recipe = {
		{'', 'chemistry:tungsten_carbide', ''},
		{'', 'chemistry:tungsten_carbide', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:stone_pick',
	recipe = {
		{'chemistry:stone_ingot', 'chemistry:stone_ingot', 'chemistry:stone_ingot'},
		{'', 'chemistry:diamond_handle', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:stone_axe',
	recipe = {
		{'chemistry:stone_ingot', 'chemistry:stone_ingot', ''},
		{'chemistry:stone_ingot', 'chemistry:diamond_handle', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:stone_shovel',
	recipe = {
		{'', 'chemistry:stone_ingot', ''},
		{'', 'chemistry:diamond_handle', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:stone_sword',
	recipe = {
		{'', 'chemistry:stone_ingot', ''},
		{'', 'chemistry:stone_ingot', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_pick',
	recipe = {
		{'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot'},
		{'', 'chemistry:diamond_handle', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_axe',
	recipe = {
		{'chemistry:obsidian_ingot', 'chemistry:obsidian_ingot', ''},
		{'chemistry:obsidian_ingot', 'chemistry:diamond_handle', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_shovel',
	recipe = {
		{'', 'chemistry:obsidian_ingot', ''},
		{'', 'chemistry:diamond_handle', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:obsidian_sword',
	recipe = {
		{'', 'chemistry:obsidian_ingot', ''},
		{'', 'chemistry:obsidian_ingot', ''},
		{'', 'chemistry:diamond_handle', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:osmium_pick',
	recipe = {
		{'chemistry:osmium', 'chemistry:osmium', 'chemistry:osmium'},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:osmium_axe',
	recipe = {
		{'chemistry:osmium', 'chemistry:osmium', ''},
		{'chemistry:osmium', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:osmium_shovel',
	recipe = {
		{'', 'chemistry:osmium', ''},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:osmium_sword',
	recipe = {
		{'', 'chemistry:osmium', ''},
		{'', 'chemistry:osmium', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:strong_gem_pick',
	recipe = {
		{'chemistry:strong_gem', 'chemistry:strong_gem', 'chemistry:strong_gem'},
		{'', 'chemistry:tungsten', ''},
		{'', 'chemistry:tungsten', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:strong_gem_axe',
	recipe = {
		{'chemistry:strong_gem', 'chemistry:strong_gem', ''},
		{'chemistry:strong_gem', 'chemistry:tungsten', ''},
		{'', 'chemistry:tungsten', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:strong_gem_shovel',
	recipe = {
		{'', 'chemistry:strong_gem', ''},
		{'', 'chemistry:tungsten', ''},
		{'', 'chemistry:tungsten', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:strong_gem_sword',
	recipe = {
		{'', 'chemistry:strong_gem', ''},
		{'', 'chemistry:strong_gem', ''},
		{'', 'chemistry:tungsten', ''},
	}
})

if minetest.get_modpath("uraniumstuff") then
-----
----- Radioactive
-----

--
-- Thorium
--

minetest.register_tool("chemistry:thorium_pick", {
	description = S("Thorium Pickaxe"),
	inventory_image = "thorium_pick.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level = 2,
		groupcaps = {
			cracky = {times = {[1] = 2.35, [2] = 1.25, [3] = 0.95}, uses = 200, maxlevel = 2},
		},
		damage_groups = {fleshy = 6, radioactive = 2.5},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:thorium_shovel", {
    description = S("Thorium Shovel"),
    inventory_image = "thorium_shovel.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level = 2,
		groupcaps = {
			crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.30}, uses = 200, maxlevel = 2},
		},
		damage_groups = {fleshy = 5, radioactive = 2.5},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:thorium_axe", {
    description = S("Thorium Axe"),
    inventory_image = "thorium_axe.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level = 2,
		groupcaps = {
			choppy = {times = {[1] = 1.45, [2] = 0.55, [3] = 0.55}, uses = 220, maxlevel = 2},
			fleshy = {times = {[2] = 0.85, [3] = 0.20}, uses = 300, maxlevel = 3},
		},
		damage_groups = {fleshy = 7, radioactive = 2.5},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("chemistry:thorium_sword", {
    description = S("Thorium Sword"),
    inventory_image = "thorium_sword.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level = 2,
		groupcaps = {
			fleshy = {times = {[2] = 0.55, [3] = 0.15}, uses = 300, maxlevel = 3},
			snappy = {times = {[1] = 1.60, [2] = 0.60, [3] = 0.15}, uses = 300, maxlevel = 3},
		},
		damage_groups = {fleshy = 8, radioactive = 2.5},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

--
-- Polonium (Same as Thorium but deals a ton of damage)
--

minetest.register_tool("chemistry:polonium_pick", {
	description = S("Polonium Pickaxe"),
	inventory_image = "polonium_pick.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level = 2,
		groupcaps = {
			cracky = {times = {[1] = 2.35, [2] = 1.25, [3] = 0.95}, uses = 200, maxlevel = 2},
		},
		damage_groups = {fleshy = 14, radioactive = 9, toxic_damage=6, toxic_duration=20},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:polonium_shovel", {
    description = S("Polonium Shovel"),
    inventory_image = "polonium_shovel.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level = 2,
		groupcaps = {
			crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.30}, uses = 200, maxlevel = 2},
		},
		damage_groups = {fleshy = 13, radioactive = 9, toxic_damage=6, toxic_duration=20},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:polonium_axe", {
    description = S("Polonium Axe"),
    inventory_image = "polonium_axe.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level = 2,
		groupcaps = {
			choppy = {times = {[1] = 1.45, [2] = 0.55, [3] = 0.55}, uses = 220, maxlevel = 2},
			fleshy = {times = {[2] = 0.85, [3] = 0.20}, uses = 220, maxlevel = 9},
		},
		damage_groups = {fleshy = 15, radioactive = 9, toxic_damage=6, toxic_duration=20},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("chemistry:polonium_sword", {
    description = S("Polonium Sword"),
    inventory_image = "polonium_sword.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level = 2,
		groupcaps = {
			fleshy = {times = {[2] = 0.55, [3] = 0.15}, uses = 220, maxlevel = 9},
			snappy = {times = {[1] = 1.60, [2] = 0.60, [3] = 0.15}, uses = 220, maxlevel = 2},
		},
		damage_groups = {fleshy = 16, radioactive = 9, toxic_damage=6, toxic_duration=20},
        radioactive = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

--- 
--- Radium
---

minetest.register_tool("chemistry:radium_pick", {
	description = S("Radium Pickaxe"),
	inventory_image = "radium_pick.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 2.05, [2] = 0.95, [3] = 0.65}, uses = 280, maxlevel = 3},
		},
		damage_groups = {fleshy = 10, radioactive = 10},
        radioactive = 4,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:radium_shovel", {
    description = S("Radium Shovel"),
    inventory_image = "radium_shovel.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level = 3,
		groupcaps = {
			crumbly = {times = {[1] = 0.50, [2] = 0.25, [3] = 0.10}, uses = 280, maxlevel = 3},
		},
		damage_groups = {fleshy = 9, radioactive = 10},
        radioactive = 4,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:radium_axe", {
    description = S("Radium Axe"),
    inventory_image = "radium_axe.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level = 3,
		groupcaps = {
			choppy = {times = {[1] = 1.65, [2] = 0.35, [3] = 0.35}, uses = 300, maxlevel = 3},
			fleshy = {times = {[2] = 0.85, [3] = 0.20}, uses = 300, maxlevel = 3},
		},
		damage_groups = {fleshy = 11, radioactive = 10},
        radioactive = 4,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("chemistry:radium_sword", {
    description = S("Radium Sword"),
    inventory_image = "radium_sword.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level = 3,
		groupcaps = {
			fleshy = {times = {[2] = 0.55, [3] = 0.15}, uses = 300, maxlevel = 3},
			snappy = {times = {[1] = 1.60, [2] = 0.60, [3] = 0.15}, uses = 300, maxlevel = 3},
		},
		damage_groups = {fleshy = 12, radioactive = 10},
        radioactive = 4,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

----
---- Americium
----

minetest.register_tool("chemistry:americium_pick", {
	description = S("Americium Pickaxe"),
	inventory_image = "americium_pick.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 1.85, [2] = 0.95, [3] = 0.55}, uses = 280, maxlevel = 4},
		},
		damage_groups = {fleshy = 12, radioactive = 7},
        radioactive = 2,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_tool("chemistry:americium_shovel", {
    description = S("Americium Shovel"),
    inventory_image = "americium_shovel.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level = 3,
		groupcaps = {
			crumbly = {times = {[1] = 0.50, [2] = 0.25, [3] = 0.10}, uses = 280, maxlevel = 4},
		},
		damage_groups = {fleshy = 11, radioactive = 7},
        radioactive = 2,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_tool("chemistry:americium_axe", {
    description = S("Americium Axe"),
    inventory_image = "americium_axe.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level = 3,
		groupcaps = {
			choppy = {times = {[1] = 1.65, [2] = 0.35, [3] = 0.35}, uses = 300, maxlevel = 4},
			fleshy = {times = {[2] = 0.85, [3] = 0.20}, uses = 300, maxlevel = 4},
		},
		damage_groups = {fleshy = 13, radioactive = 7},
        radioactive = 2,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_tool("chemistry:americium_sword", {
    description = S("Americium Sword"),
    inventory_image = "americium_sword.png",
    light_source = 5,
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level = 3,
		groupcaps = {
			fleshy = {times = {[2] = 0.55, [3] = 0.15}, uses = 300, maxlevel = 4},
			snappy = {times = {[1] = 1.60, [2] = 0.60, [3] = 0.15}, uses = 300, maxlevel = 4},
		},
		damage_groups = {fleshy = 14, radioactive = 7},
        radioactive = 2,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

---
--- Crafting
---

minetest.register_craft({
	output = 'chemistry:radium_pick',
	recipe = {
		{'chemistry:radium', 'chemistry:radium', 'chemistry:radium'},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:radium_axe',
	recipe = {
		{'chemistry:radium', 'chemistry:radium', ''},
		{'chemistry:radium', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:radium_shovel',
	recipe = {
		{'', 'chemistry:radium', ''},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:radium_sword',
	recipe = {
		{'', 'chemistry:radium', ''},
		{'', 'chemistry:radium', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:thorium_pick',
	recipe = {
		{'chemistry:thorium', 'chemistry:thorium', 'chemistry:thorium'},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:thorium_axe',
	recipe = {
		{'chemistry:thorium', 'chemistry:thorium', ''},
		{'chemistry:thorium', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:thorium_shovel',
	recipe = {
		{'', 'chemistry:thorium', ''},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:thorium_sword',
	recipe = {
		{'', 'chemistry:thorium', ''},
		{'', 'chemistry:thorium', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:americium_pick',
	recipe = {
		{'chemistry:americium', 'chemistry:americium', 'chemistry:americium'},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:americium_axe',
	recipe = {
		{'chemistry:americium', 'chemistry:americium', ''},
		{'chemistry:americium', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:americium_shovel',
	recipe = {
		{'', 'chemistry:americium', ''},
		{'', 'basic_materials:steel_bar', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

minetest.register_craft({
	output = 'chemistry:americium_sword',
	recipe = {
		{'', 'chemistry:americium', ''},
		{'', 'chemistry:americium', ''},
		{'', 'basic_materials:steel_bar', ''},
	}
})

end

-----
----- Toxic
-----

minetest.register_tool("chemistry:steel_arsenic_sword", {
	description = S("Steel Sword with Arsenic"),
	inventory_image = "arsenic_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=8,toxic_damage=4.5,toxic_duration=10},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_tool("chemistry:osmium_tetroxide_sword", {
	description = S("Osmium Tetroxide Coated Sword"),
	inventory_image = "osmium_tetroxide_sword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.5, [2]=0.20, [3]=0.35}, uses=680, maxlevel=6},
		},
		damage_groups = {fleshy=18,toxic_damage=3,toxic_duration=5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1, toxic = 1}
})

---
--- Crafting
---

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:osmium_tetroxide_sword',
	recipe = {
		'chemistry:osmium_sword', 'chemistry:osmium_tetroxide',
	}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:steel_arsenic_sword',
	recipe = {
		'default:sword_steel', 'chemistry:arsenic_water_bucket',
	},
   replacements = {{'chemistry:arsenic_water_bucket', 'bucket:bucket_empty'}}
})

minetest.register_craft({
   type = "shapeless",
	output = 'chemistry:steel_arsenic_sword',
	recipe = {
		'default:sword_steel', 'chemistry:arsenic_water_bucket_plastic',
	},
   replacements = {{'chemistry:arsenic_water_bucket_plastic', 'plastic_bucket:bucket_empty'}}
})

---
--- Other
---

minetest.register_craftitem("chemistry:diamond_handle", {
	description = S("Diamond Handle"),
	inventory_image = "diamond_handle.png",
})

minetest.register_craft({
	output = 'chemistry:diamond_handle 3',
	recipe = {
		{'', '', 'default:diamond'},
		{'', 'default:diamond', ''},
		{'default:diamond', '', ''},
	}
})
