# [Mod] X Farming [x_farming] API

## Types

`BonemealTreeDef`

```typescript
type BonemealTreeDef = {
    // sapling name
    name: string
    // 1 out of `chance`, e.g. 2 = 50% chance
    chance: number
    // grow tree from sapling, should return `true` if the growing was successful
    grow_tree: function(pos: Vector): boolean
}
```

## Class `x_farming.x_bonemeal`

**Method**

`is_on_soil(pos: Vector): boolean`

Check if node has a soil below its self.

**Method**

`is_on_sand(pos: Vector): boolean`

Check if node has a sand below its self.

**Method**

`register_tree_defs(self: x_bonemeal, defs: BonemealTreeDef[]): void`

Register tree definition for bonemeal to work on this sapling.
Other mods can register new tree growth from sapling using bonemeal.

example

```lua
 x_farming.x_bonemeal:register_tree_defs({
    {
        name = 'everness:coral_tree_sapling',
        chance = 3,
        grow_tree = function(pos)
            if not x_farming.x_bonemeal.is_on_soil(pos) then
                return false
            end

            core.place_schematic(
                { x = pos.x - 19, y = pos.y, z = pos.z - 19 },
                core.get_modpath('mymod') .. '/schematics/mymod_mytree_from_sapling.mts',
                'random',
                nil,
                false
            )

            return true
        end
    }
})
```
