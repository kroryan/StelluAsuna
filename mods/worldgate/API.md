API
---

All of the API functions for Worldgate are defined in the `worldgate` global variable.

### `worldgate.add_gate(def)`

This function adds a worldgate to the world. This is useful for adding your own custom worldgates to the world. The `def` parameter must be a table with the following fields:

```lua
{
  -- position: The x/y/z location where the worldgate will be generated. This
  -- value must be a vector created with vector.new.
  position = vector.new(...),

  -- base: A schematic specifier that identifies a 'base' schematic that forms
  -- the base, or bottom half, of the worldgate which typically contains a
  -- Telemosaic beacon and range extender marker nodes.
  base = worldgate.get_random_base(pcgr),

  -- decor: A schematic specifier that identifies a 'decor' schematic that forms
  -- a decoration placed on the worldgate base. This is typically some form of
  -- housing or adornment for the worldgate.
  decor = worldgate.get_random_decor(pcgr),

  -- quality: Determines the quality of range extenders that generate as part
  -- of this worldgate. It must be an integer with a value of -1, 0, or 1 which
  -- corresponds to lower quality, equal quality, or better quality extenders,
  -- respectively.
  quality = worldgate.get_random_quality(pcgr),

  -- exact: A boolean value that specifies if the worldgate should be placed at
  -- the exact position specified. If true, the worldgate will be placed at the
  -- point specified by the position parameter regardless of surrounding
  -- terrain. If false, the mod will attempt to place the worldgate according to
  -- the available terrain which favors the heightmap first, below air second,
  -- then any random position in the mapchunk if all else fails.
  exact = false,

  -- destination: A vector that matches the position of another worldgate that
  -- this worldgate will be linked to automatically. If this value is nil, then
  -- the gate's beacon will be deactivated and it will have no destination.
  destination = nil,
}
```

### `worldgate.get_random_base(pcgr)`

This function returns a path to a random schematic file in the `worldgate/schematics/base/` directory that corresponds to a worldgate base. Every built-in base schematic will contain a single beacon and extender marker nodes. The optional argument is a PcgRandom object that can be used to choose the random base schematic.

### `worldgate.get_random_decor(pcgr)`

This function returns a path to a random schematic file in the `worldgate/schematics/decor/` directory that corresponds to a worldgate decoration. Decorations typically provide some form of housing or adornment surrounding the worldgate's Telemosaic beacon. A decoration schematic is not necessary for a worldgate to function, but decor does look pretty nice!

The optional argument is a PcgRandom object that can be used to choose the random decor schematic.

### `worldgate.get_random_quality(pcgr)`

This function returns a random value of either -1, 0, or 1, values which correspond to the quality values of a worldgate. This is useful for creating gates with a random quality. The optional argument is a PcgRandom object that can be used to choose the random value.

### `worldgate.get_gates_for_mapblock(position)`

This function returns a list of all gates that should be generated for the mapblock of the given vector location. The `position` parameter must be a vector created with `vector.new`.

### `worldgate.reigster_on_worldgate_generated(fn)`

This function registers a callback function that will be called when a worldgate is successfully generated in the world. The function is called with three parameters:

- `location`: A vector representing the point at which the worldgate was actually placed in the world
- `gate`: The definition of the generated worldgate as specified for `worldgate.add_gate(def)`
- `strategy`: A string that specifies the placement algorithm that the mapgen function used to place the worldgate, in order of mapgen preference:
  - `"exact"`: The location is the worldgate's `position` value specified with `exact = true`
  - `"heightmap"`: A suitable location was found matching the heightmap for the worldgate's mapchunk
  - `"grounded"`: A suitable location was found by probing downwards from a random air node
  - `"random"`: A location was selected at random with no regards for the surrounding terrain

### `worldgate.register_on_worldgate_failed(fn)`

This function registers a callback function that will be called when a worldgate tries but fails to generate. This is most likely to happen if mod settings prevent worldgates from spawning in midair or underwater and such a position is selected via the `random` placement strategy during mapgen. A gate that fails to generate in this manner will not attempt to be generated again.

The callback function is called with just one parameter

- `gate`: The gate definition of the worldgate that failed to generate as specified for `worldgate.add_gate(def)`

Dark and Dangerous API
----------------------

**WARNING: ACCESSING THESE FUNCTIONS/VARIABLES CAN CAUSE UNPREDICTABLE LOSS/DAMAGE TO YOUR WORLD; DO NOT USE UNLESS YOU KNOW WHAT YOU ARE DOING**

### `worldgate.add_gate_unsafe(def)`

This function fills the same role as `worldgate.add_gate(def)`, but it doesn't perform any validation checks to ensure that the gate is valid. This function is used internally during native gate generation for faster performance. Use only if you're sure that your gate definitions do not require validation.