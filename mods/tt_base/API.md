# API for `tt_base`

`tt_base` allows to make a few adjustments to the custom tooltips
added by this mod.

Note this API is specific for `tt_base` only. This mod is an extension for
the `tt` mod which also has its own API. Use the `tt` API if you need
full customization.

Recommendations for game makers:

* Add the food fields below for food items
* If your tools use unique digging or damage groups, register them
* Review the tooltips of **ALL** items to ensure high quality
* Consider adding additional custom snippets using the `tt` API
  for stuff that `tt_base` didn't cover

## What `tt_base` adds

This is a technical description of what information `tt_base` adds
to the tooltips specifically:

* Tool digging groups and digging times (`tool_capabilities.groupcaps.times`)
	* Descriptions for common groups `crumbly`, `cracky`, `snappy`, `choppy`,
	  `oddly_breakable_by_hand` and `dig_immediate`
	* Description for `catchable` (from Minetest Game)
	* Fallback text for other groups (can be extended, see below)
* Tool/weapon damage (`tool_capabilities.damage_groups`)
* Full punch interval (`tool_capabilities.full_punch_interval`)
* Food stats (information must be explicitly provided in item definition, see below)
* Node information:
	* Node damage (field `damage_per_second` (negative number = healing))
	* Drowning damage (field `drowning`)
	* Climbable (field `climbable`)
	* Light level (field `light_level`)
	* Disabled jumping or climbing/swimming up/-downwards (groups `disable_jump`, `disable_descend`)
	* Fall damage modifier (group `fall_damage_add_percent`)
	* Slippery (group `slippery`)
	* Bouncy (group `bouncy`)

Some customization of this is possible, see below.

## Tooltip configuration

This mod introduces support for new item definition fields:

* `_tt_food`: If `true`, item is a food item that can be consumed by the player
* `_tt_food_hp`: Health increase (in HP) for player when consuming food item
* `_tt_base_ignore`: If set to true, it suppresses all snippets (tooltip extensions)
   from this mod for the item (snippets added by other mods are unaffected)

Because there is no standard way in Luanti to mark an item as food, the food
fields required for food items to be recognized as such.

## Custom group descriptions

By default, this mod provides descriptions to describe what tools dig
for the following groups:

* The special group `dig_immediate`;
* the common digging groups `cracky`, `choppy`, `snappy` and `oddly_breakable_by_hand`;
* and the Minetest Game digging group `catchable`.

For example, the description for tools that dig `cracky` nodes is:

> Breaks tough, crackable blocks like stone

For any other group, this mod shows a fallback description of the form:

> Digs [groupname] blocks

This fallback is of lower quality as always shows the ugly technical group name
which cannot be translated.

If your game includes more digging groups, you can
register additional descriptions to improve tooltip quality. You can also register
the groups mentioned above again to overwrite the default descriptions.

To do this, use the function below:

### `tt_base.register_group(groupname, descriptions)`

Registers translatable descriptions for a group.

* `groupname`: The technical group identifier
* `descriptions`: Table of translatable descriptions:
	* `dig_long`: Long description to describe what the tool digs (example: “Digs dirt- and sandlike blocks” for `crumbly`)
	* `damage`: Name of the group when used as a damage group (usually only one word) (not necessary for `fleshy`)

This function **MUST** be called *before* `tt_base` runs. For games, this can be done by adding this function in
a new special mod (that you create) called “`tt_base_groups`”. This works because `tt_base` optionally depends on `tt_base_groups`.
