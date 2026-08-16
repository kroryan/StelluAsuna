Filled Bottles
==============

Fill empty glass bottles with a variety of earthly materials including water, dirt, sand, and more! With an empty glass bottle in hand, simply point at the node that you wish to capture then click to fill the bottle. Conversely, using a filled bottle will empty it, thus allowing you to reuse the empty glass bottle.

On their own, filled bottles are only good for collecting and decoration. However, other mods may wish to make use of filled bottles for other purposes, such as for ingredients in cooking or chemistry. It's also possible to define your own filled bottles; see the API section below for details.

Bottles function in a very similar fashion to buckets with two key differences. First, many bottles may be filled from one single node before the node is exhausted (10 bottles by default), and an exhausted node may be fully consumed (e.g., sand or water) or replaced with a "stripped" version of itself (e.g., dirt with grass becomes only dirt). Secondly, emptying a filled bottle does not dispense its contents, it simply becomes an empty glass bottle when emptied. In this way, bottles are effectively "transformed" into other types of bottles but they do not actually carry their contents the way buckets do.

Also note that partially bottled nodes have a chance to yield no drops when dug. This chance scales with how many times the node is bottled such that bottling a node more times increases the chance that it will not yield drops when dug. This is a balance measure to prevent infinite bottling of a single node.

The chance to yield no drops does not apply to liquids by default as liquids can easily be exploited to bypass this restriction, but this can be changed via settings if needed for a special case.

Supported games/mods
--------------------

- Minetest Game and its derivatives such as MeseCraft, Asuna, etc.
- Ethereal
- Everness
- Wilhelmines Living Jungle
- Wilhelmines Natural Biomes
- Caverealms
- Many biomes from the Biomes modpack by Atlante

API
---

Want to create your own filled bottles? Use the `bottles.register_filled_bottle` function to register a filled bottle for any node you like. The function takes in a single table argument that conforms to the following:

```lua
{
  target = <string or array>, -- the node to target for a bottle to be filled
                              -- from; either a string for a single node name
                              -- or an array that is a list of node names

  replacement = <string>, -- the node to replace the target node(s) with when
                          -- a target node is fully drained; default is "air"

  name = <string>, -- a name for the filled bottle item; will be prefixed with
                   -- `bottles:`, so don't include any such namespace; default
                   -- value is "bottle_of_" + the name of the target node

  description = <string>, -- the display name of the filled bottle; default
                          -- value is "Bottle of " + the description of the
                          -- target node

  contents = <string>, -- the node that represents the contents of this bottle;
                       -- default value is the target node, or the first node in
                       -- the list of target nodes

  image = <string>, -- the image to use for the contents of the filled bottle;
                    -- the first 16x16 pixels of this image will be rendered
                    -- 'inside' of the bottle; default value is the tile image
                    -- of the target node, or the first of such tiles of the
                    -- target node

  sound = <string>, -- the name of a sound that conforms to the Minetest sound
                    -- spec; played at a high pitch when a bottle is filled or
                    -- spilled; default value is `nil`
}
```

For example, this is the registration for a bottle of water:

```lua
bottles.register_filled_bottle({
  target = "default:water_source",
  sound = "default_water_footstep",
  name = "bottle_of_water",
  description = "Bottle of Water",
})
```

Note that this mod expects the target node(s) to be registered with Minetest prior to registering a filled bottle of its type, so if you wish to define new filled bottles with your own node targets, make sure to call `minetest.register_node` before calling `bottles.register_filled_bottle`. Also remember to add `bottles` to your dependency list in your mod's `mod.conf` file.

If you wish to further extend the uses and capabilities of empty glass bottles or filled bottles, the functions assigned to the `on_use` field of the bottles are defined as `bottles.fill` (assigned to empty glass bottles to fill them with a targeted material) and `bottles.spill` (to empty the contents of a filled bottle). These functions are provided so that you can override them or wrap them in programming logic -- a task that is beyond the scope of this documentation.
