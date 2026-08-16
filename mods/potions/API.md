
api/init.lua
------------

s_potions.item_is_ingredient (table)
s_potions.item_is_vial (table)
s_potions.potion_backgrounds (list)
- Helper variables, do not use these

s_potions.recipes (list)
- Table with potion recipes
- Do not edit manually, use s_potions.register_potion instead
- Each entry is a table with the following fields:
	- def.brew_time (float, optional) - custom brew time (in seconds)
	- def.ingredient/vial/result (item name) - items used in the recipe
- See the corresponding fields in s_potions.register_potion for more details

s_potions.potion_default_duration (float)
- Default duration of potion effects (in seconds)

s_potions.random_sound_pitch (function(void)->float)
- Function that returns random pitch for sounds

api/api.lua
-----------

### s_potions.register_potion(def)

Used to register new potion types.

def.name (item name)
- The potion's engine item name

def.desc (string)
- The potion's in-game name

def.effect_desc (string, optional, defaults to def.desc)
- The name of the potion's effect (shown on the right of the screen next to its timer when used)

def.background (texture string)
- The texture used to create the potion sprite (for overlay with the bottle shape texture)
- For reference, the default potions mostly use the textures of their corresponding metal blocks
- This also defines the texture used for the potion particles

def.overlay (texture string, optional)
- A second texture overlaid over the one from def.background

def.image (texture string, optional)
- An entirely custom inventory image for the potion
- Overrides def.background and def.overlay
- You still need to set def.background for the potion particles

def.mese_enhanced (bool, optional)
- If set to true, it will automatically set def.ingredient to mese crystal and def.overlay to the mese dust texture

def.ingredient (item name)
- The ingredient for this potion, placed into the upper slot when brewing
- If this is set, the potion will be brewable (and won't appear in the regular crafting guide)

def.vial (item name)
- The vial or potion placed into the lower slot when brewing (this needs to be a "vessel" group item)
- Setting this to a potion (other than potion stock) will place the new potion in the "enhanced" category in the recipe list

def.brew_time (float, optional)
- Custom brew time, in seconds (overrides brewing.brew_time)

def.duration (optional)
- The potion's duration in seconds
- If undefined, the potion will last 30 seconds

def.effect (function(user))
- The function for the potion's initial effect

def.repeat_interval(float, optional)
- When this is set, def.effect will repeat itself each interval for the potion's duration

def.use_regular_repeat_interval(bool, optional)
- When set to true, it makes the potion use the regular repeat interval code from the playereffects mod
- The difference is that it displays its duration in the form of individual intervals
- Not recommended for intervals shorter than 1 second

def.effect_end (function(effect, user), optional)
- The function for when the potion's effect ends (all changes need to be cleaned up here)
- The "effect" argument here refers to the potion's effect, see the playereffects mod for how to use it

### s_potions.add_particle_spawner(particle_background, duration, object, pos)

Adds the same kind of particle spawner that's used for all the potion effects.

particle_background (texture name)
- The texture used for the particles (for overlay with the particle shape texture)

duration (float)
- The duration for the particle spawner
- If the duration equals 1 second or less, the spawner will emit a single burst of particles

object (object, optional)
- The object which the spawner will be attached to
- For players, this will remove previous particle spawners

pos (vector, optional)
- The particle spawner's set position
- If the object is set, then pos counts as relative to its position

Return value - the added particle spawner

api/helper.lua
--------------

### s_potions.get_player_effect(playername, effect_name)

Helper that returns an effect with playername and effect_name from the playereffects API.

### s_potions.is_inside_node_group(obj, group)

Returns true if obj's position is inside or 1 node above the given node group.

### change_armor_group(obj, group, value)

Helper for quickly changing obj's armor group to value.

### set_physics_factors(obj, name, physics)

Helper functions to access the playerphysics mod api.
Using that api is recommended to make the physics changes compatible with other mods.

- name is a name for the effect, used to register it in the playerphysics api
- physics is a table in the same format as that of the set_physics_override ObjectRef function

### reset_physics_factors(obj, name, physics)

Used to reset the changes made by set_physics_factors.

- name is the same name you used for set_physics_factors
- physics is an array containing the names of the attributes to reset

### s_potions.speed_effect(user, name, ground_speed, liquid_speed, air_speed, params)

Place this in a (repeated) effect function for a speed effect that distinguishes between walking and swimming speeds.
See potions/potions.lua for examples of usage.

user/name (object ref and string)
- Player ref and effect name (same as in set/reset_physics_factors)

ground_speed/liquid_speed (float, optional, defaults to 1)
- Speed values for walking and swimming, respectively

air_speed (float, optional)
- Speed value for movement in mid-air
- If set to nil, air speed will carry over the walking/swimming speed, whichever was used last
- Setting this to nil will also cause acceleration to slowly decrease while in mid-air

Rest of the params are as follows, in order:

climb_ledges (bool, optional, defaults to true)
- If true, the player will be able to climb one block tall ledges

allow_sneak (bool, optional, defaults to false)
- If false, the player will not be able to sneak

fast_climb (bool, optional, defaults to false)
- If true, the player will retain their increased speed for climbing ladders

acceleration_fast_reset (bool, optional, defaults to false)
- If true and air_speed is nil, mid-air acceleration will decrease immediately instead of gradually

### s_potions.speed_effect_end(user, name)

Helper function for resetting s_potions.speed_effect values in a potion's effect_end function.

brewing/init.lua
----------------

s_brewing.brew_time (float)
- Brew time for potions (in seconds)

s_brewing.boost_search_radius (vector)
- Indicates the (cuboid) radius in which alchemy boosts affect alchemy stands
- Also used for alchemy stands blocking each other
s_brewing.boost_value (float, from 0 to 1)
- Speed increase given by each alchemy boost
s_brewing.boost_max_count (int)
- Maximum number of alchemy boosts applicable to an alchemy stand
s_brewing.boost_min_y (int)
- The minimum y position at which alchemy stands can be affected by alchemy boosts
- Below this depth, alchemy stand efficiency is always at 50%

s_brewing.explosion_chance (float, from 0 to 1)
- Chance of alchemy stand explosion if removed while brewing

s_brewing.storage_nodes (table)
- Contains defs for nodes that can serve as extra storage for alchemy stands
- Key is the node name, value is def with inventory_list and update
	- def.inventory_list (string) - the name of the list to deposit the potions to
	- def.update (function(pos)) - function called whenever a potion is deposited
- To register a storage node:
	- Add an entry in this table
	- Call vessels_shelf_update_alchemy_stands(pos) in the following functions:
	- on_construct, after_destruct, on_metadata_inventory_move/put/take
- For an example of implementation, see brewing/vessels_shelf.lua

s_brewing.sound_handles
s_brewing.sound_timers
s_brewing.particle_handles
s_brewing.formspec_viewers
- Mod variables, do not use these

brewing/api.lua
---------------

### s_brewing.get_available_storage(pos)

If there's free inventory space for potions available at pos, returns an InvRef (otherwise returns nil).

### s_brewing.try_store_potion(pos, potion)

Attempts to deposit potion (item name) into a node inventory at pos.

### s_brewing.add_to_value_in_nearby_stands(pos, value_name, value_add)

Adds value_add to the value_name metadata int for all alchemy stands in a radius of s_brewing.boost_search_radius around pos.
Used mainly to keep track of alchemy boosts and blocking stands through the "boost_count" and "table_count" metadata keys.

### s_brewing.alchemy_stand_update_particles(pos, meta, hash, reset)

Updates the particle spawner for an alchemy stand at pos.

- meta and hash are the NodeMetaRef and hash_node_position for the pos (if set to nil, they will be fetched in the function)
- when reset is true, previous particle spawners are removed, otherwise if a particle spawner is set the function has no effect

### s_brewing.alchemy_stand_get_recipe_index(pos)

Returns the index (in s_potions.recipes) of the recipe currently in progress at an alchemy stand at pos, or 0 if not applicable.

### s_brewing.alchemy_stand_update(pos)

Updates an alchemy stand at pos, causing it to start or stop brewing.
Use this if you modify the stand's inventory or anything else that could affect it.

brewing/timers.lua
------------------

### s_brewing.alchemy_node_timer(pos, elapsed)

The node timer function for alchemy stands. Not to be used directly.

brewing/formspec.lua
--------------------

### s_brewing.update_alchemy_formspec_for(pos, meta, hash, force_update)

Updates the infotext and formspec for an alchemy stand at pos (the latter only if it's being viewed).

- meta and hash work the same as in s_brewing.alchemy_stand_update_particles
- if force_update is set to true, formspec will always update regardless of current viewers

### s_brewing.get_recipe_list_formspec()

Returns formspec string for the potion recipe list.
