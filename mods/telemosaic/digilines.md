# Telemosaic digilines documentation

An overview of all commands and functionality, with example Lua code.

For convenience, and for using digiline buttons, all commands can also be sent as text.

### Change the digiline channel

**Lua:**

```lua
digiline_send("telemosaic", {command = "setchannel", channel = "whatever"})
```

**Text:** `setchannel whatever`

### Disable a beacon

**Lua:**

```lua
digiline_send("telemosaic", {command = "disable"})
```

**Text:** `disable`

### Enable a beacon

**Lua:**

```lua
digiline_send("telemosaic", {command = "enable"})
```

**Text:** `enable`

### Set a new destination

**Lua:**

```lua
digiline_send("telemosaic", {command = "setdest", x = 0, y = 0, z = 0})
```

or

```lua
digiline_send("telemosaic", {command = "setdest", pos = {x = 0, y = 0, z = 0}})
```

**Text:** `setdest 0,0,0`

Note that the destination will only be set if it's valid (beacon at destination).

### Get data from a beacon

**Lua**

```lua
digiline_send("telemosaic", {command = "get"})
```

**Text:** `get` or `GET`

Returns a table containing the following:

```lua
{
    state = "active",  -- or "disabled", "off", or "error"
    pos = {x = 1, y = 2, z = 3},
    destination = {x = 4, y = 5, z = 6},
    origin = {x = 1, y = 2, z = 3},  -- same as 'pos'
    target = {x = 4, y = 5, z = 6},  -- same as 'destination'
}
```
