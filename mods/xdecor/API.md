# API for X-Decor-libre

X-Decor-libre is mostly self-contained but it allows for limited extension with
a simple API. Not that extensibility is not the main goal of this mod.

The function documentation can be found in the respective source code files
under the header "--[[ API FUNCTIONS ]]".

These are the features:

## Add custom tool enchantments

You can register tools to be able to be enchanted at the enchanting table.

See `src/enchanting.lua` for details.

## Add custom hammers

You can add a custom hammer for repairing tools at the workbench,
using custom stats.

See `src/workbench.lua` for details.

## Add cut nodes

You can register "cut" node variants of an existing node which can
be created at the workbench.
This will add thin stairs, half stairs, panels, microcubes, etc.

See `src/workbench.lua` for details.

## Cauldron compatibility

The cauldron needs to interact with various items and nodes to
work properly. It uses ingredients and bowls for soup, and
fire nodes to get heated.

If your mod adds fire or hot nodes, bowls or food, this section
is relevant for you.

### Soup ingredients

The cauldron soup accepts a variety of food items as ingredients for the soup.
It uses a heuristic to determine which items it accepts as ingredient.

This heuristic may sometimes fail and recognize strange items as ingredient.
To explicitly mark any item as a soup ingredient for xdecor, add the group
`xdecor_soup_ingredient = 1` to it. To explicitly tell xdecor that an item
is NOT a soup ingredient, use `xdecor_soup_ingredient = -1` instead.
The `-1` should only be used if actually necessary.

#### Information about the heuristic

Any item without a valid `xdecor_soup_ingredient` group will be checked
by against a heuristic to determine if it counts as a soup
ingredient or not. Items that do have this group with a valid
value are not subject to the heuristic.

First, the heuristic checks if the item is 'eatable'. This basically
checks if the function `core.item_eat` or (`minetest.item_eat`) is called.
If the item is eatable, it counts as ingredient.

If not, then the heuristic looks at the part of the technical itemname after
the colon for certain keywords like 'apple', 'meat', 'potato' etc.
(for the full list, see `ingredients_list` in `src/cooking.lua`).
If a keyword was found, the item counts as an ingredient, otherwise not.

There is also a small blacklist that disqualifies a few items
from Minetest Game.

### Heater nodes

Cauldrons need a fire below to get heated. All nodes with the group `fire`
or `xdecor_cauldron_heater=1` will heat up the cauldron. You can use the latter
group if adding the `fire` group would create problems.

### Bowls

Players can use the `xdecor:bowl` item to collect soup from a cauldron.
But other mods also have their own bowls which may not be recognized by
X-Decor-libre.

The following items are recognized as bowls that can collect soup from
the cauldron:

* Items with group `xdecor_soup_bowl=1` (recommended)
* `farming:bowl` (hardcoded)
* `x_farming:bowl` (hardcoded)

If you want to make your bowl compatible with the cauldron, add the group
`xdecor_soup_bowl=1` to it. **Only use this for empty bowls!**

**Please test your bowl!**

When any valid bowl is used at the cauldron, it turns into `xdecor:bowl_soup`.
If the soup is eaten, the item will become the original bowl again, even
if it was a custom bowl.
For custom bowls (not from X-Decor-libre), the `xdecor:bowl_soup` item
remembers the name of the original bowl in the metadata under
`original_bowl`. If `original_bowl` is the empty string, or contains the
name of an unknown item, `xdecor:bowl` is the assumed default.
(However, an unknown item in `original_bowl` will trigger a warning.)


## Custom Chess bot (experimental)

You can replace the (very weak) Chess computer player with a custom one.
See `src/chess.lua` for details (`realchess.set_chessbot`).

Note this feature is relatively experimental, but it has survived
first initial tests.

## Groups

This mod introduces the following groups:

* `potted_flower=1`: Potted flower
* `food_bowl=1`: Empty bowl
* `lever=X`: Lever (1 = off, 2 = on)
* `pressure_plate=X`: Pressure plate (1 = off, 2 = on)
* `cauldron=X`: Cauldron
  * `1`: Empty cauldron
  * `2`: Cauldron with cold liquid
  * `3`: Cauldron with boiling liquid
* `xdecor_cut=1`: For nodes cut by the workbench (not the normal slab, normal stair, inner or outer stair).
  Cut nodes will also receive one of the following groups to specify the shape:
  * `xdecor_cut_microslab=1`: Microslab
  * `xdecor_cut_nanoslab=1`: Nanoslab
  * `xdecor_cut_panel=1`: Panel
  * `xdecor_cut_doublepanel=1`: Double panel
  * `xdecor_cut_micropanel=1`: Micropanel
  * `xdecor_cut_cube=1`: Cube
  * `xdecor_cut_halfstair=1`: Half stair
  * `xdecor_cut_thinstair=1`: Thin stair
* `not_cuttable=1`: Prevent this node from being cut by the workbench
* `repair_hammer=1`: A hammer that repairs tools (do not add this group manually, see `src/workbench.lua`)
* `chess_piece=X`: Chess piece for Chess (see `src/chess.lua` for details)
* `enchanted_tool=1`: Enchanted tool
  * `enchantment_durable=1`: Enchanted tool with Durability enchantment
  * `enchantment_fast=1`: Enchanted tool with Efficiency enchantment
  * `enchantment_sharp=1`: Enchanted tool with Sharpness enchantment

These groups are for cauldron features (please read the “Cauldron compatibility”
section above before using them):

* `xdecor_soup_ingredient=1`: Add this item as a possible soup ingredient
* `xdecor_soup_ingredient=-1`: Exclude this item as a possible soup ingredient
* `xdecor_cauldron_heater=1`: If placed below cauldron, it will heat it up
* `xdecor_soup_bowl=1`: A bowl that can collect soup from the cauldron

These groups are reserved for internal use:

* `xdecor_actuator=X`: A node that can turned on and off and toggles neighboring doors. 1 = off, 2 = on. Used by lever and pressure plate
* `sittable=1`: Player can sit down on this node (also needs to call `xdecor.sit` to function)
