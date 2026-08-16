# modutil
[![luacheck][luacheck badge]][luacheck workflow]  
A utility mod for minetetest providing useful utilities that can be used in other mods.  

## usage
There are several modules in the mod.
These can be loaded on demand.
To load a module use:

```lua
  local your_variable = modutil.require("modulename")
```

The variable then contains the return value of the module.
That will in  most cases be a table or a function.

## modutil portable
You can put modutil into your own mod and avoid adding a hard dependency.
Therefore you have to put modutil directly into your mods folder.
You can load the portable.lua which will return the portable modlib.  
You can use the following code snippet to load it:

```lua
  local my_modutil = dofile(modpath.."/modutil/portable.lua")
  -- use the following line to add it to your prevoiusly created mod table
  -- your_modname.modutil = my_modutil or dofile(modpath.."/modutil/portable.lua")
```

Also you could check if modutil is already loaded and then use the global modutil table:

```lua
  if not modutil then
    dofile(modpath.."/modutil/portable.lua")
  end
  local log = modutil.require("log").make_loggers("action","info")
  log.action("yay, it's loaded")
```

You'll need an optional dependency on modutil if you want to use the global modutil table.

## LuaVenusCompiler

A parser for venus files. Read [it's readme](LuaVenusCompiler/README.MD) for more info.  
The parser can load and run venus files.
Example:
```lua
local vp = modutil.require("LuaVenusCompiler")
vp.dovenus(modpath.."/some_file.venus")
```

## local_require

A module for creating a function that can be used to make your own mod modular.  
It will create a module table that contains the loaded modules of your mod.  
The require function will check if the lua file is already loaded, load it if nessecary
and return the return value from the loaded file.  
It can also natively load venus files.  
Example:  
(use your modname instead of my_mod if you copy this)

```lua
  my_mod={
    modpath = minetest.get_modpath("my_mod") or minetest.get_modpath(minetest.get_current_modname())
  }
  -- this modules table is optional you don't need to give it as second argument 
  local modules = {
    -- use this if you have your own logging functions
    -- log = dofile(my_mod.modpath.."/my_log.lua")
  }
  modutil.require("local_require")(my_mod,modules)
  
  -- log is preloaded 
  local log = my_mod.require("log")
  
  -- load some files from your mod:
  -- for example if util.lua returns a table with utility functions
  local util = my_mod.require("util")
  util.do_something()
  -- load other files just like with dofile
  my_mod.require ("nodes")
  -- if your want to load venus files
  -- add the second argument: the file type
  my_mod.require("chests","venus")
  -- you don't have to add the parentheses in lua
  my_mod.require "craft"
  -- use / for folders just like dofile
  my_mod.require "items/register"
  my_mod.require("items/craft","lua")
  --if any of the files above requires util too
  --it can call my_mod.require("util") again and the util.lua file won't be run twice
```

Implementation details:
* your modtable (my_mod in the example) has to contain a field named modpath containing the modpath
* you can give a table as second argument that will be filled with the loaded modules (use this for preloading etc.)
* if no second argument is present a module table will be created
* the module log will be loaded from modutil if you don't add your own logging functions to the module table
* the module log has to return a table containing at least the function "info"
* the already loaded module log will prevent loading a file called log.lua in your modpath when require is used
* your modtable will receive a field called require containing the module loading function
  * the first argument to the require function is the module name
  * the second argument to the require function is the file type given as string
  * it can load "venus" and "lua" files
  * if no file type is given it will load the file as lua file
  * if the module is already loaded the second argument will be ignored
* if you don't have a field called init in the module table it will be set to your modtable
* by default `my_mod.require("init")` will return your modtable
* look at local_require.lua for more details

## logging

A module for creating shorter logging functions.  
The loggers will format the given log message and call minetest.log.  
Typically you want to use it as following:

```lua
  my_mod.log = modutil.require("logging").make_loggers()
  my_mod.log.action("loggers loaded")
```

You can also pass the level of the loggers to the make_loggers function:

```lua
  my_mod.log = modutil.require("logging").make_loggers("action","warning","error","debug")
```

If you create your logger after loading the mod you may want to pass the modname using:

```lua
  my_mod.log.info = modutil.require("logging").make_logger("info","my_mod")
```

## translations

A wrapper that checks if `minetest.get_translator` is avalible and replaces it if nessecary.  
The module returns a fucntion that when called returns the translator.
use:

```lua
  my_mod.S = modutil.require("translations","venus")()
  -- or for after loading
  my_mod.S = modutil.require("translations","venus")("my_mod")
```

## check_prefix

A function doing the same as the standard minetest prefix check.
It will assume the modname is correct if it called after loading.
use:

```lua
  local check_prefix = modutil.require("check_prefix","venus")
  -- checks if name is in the format "modname:name" or ":modname:name"
  -- if modname in "modname:name" is not the currently loaded mod it creates an error
  -- returns id in the format "modname:name"
  local id = check_prefix(name)
```

## textures

A module that contains some helpers for textures.
Load it as usual with:
```lua
  textures = modutil.require("textures","venus")
```

```lua
  textures.inventorycube(face_top, face_left, face_right)
```
will create an inventorycube modifier consisting the three given faces

```lua
  textures.get_node_inventory_image(nodename)
```
will return the inventory image of a node
or an inventory cube created from the tiles of the node

## strings

A module that contains some helpers for strings.
Load it as usual with:
```lua
  strings = modutil.require("strings","venus")
  -- to write it into the native string functions do
  modutil.require("strings","venus").overwrite_string()
```

```lua
  strings.starts_with(str, prefix)
  -- if overwritten you can also use
  str:starts_with(prefix)
```
checks if a given string starts with a given other

```lua
  strings.ends_with(str, suffix)
  -- if overwritten you can also use
  str:ends_with(suffix)
```
checks if a given string ends with a given other

## accumulators

A module that adds helpers to accumulate function results.
Load it as usual with:
```lua
  local accumulators = modutil.require("accumulators","venus")
```

predefined accumulators:
* number_add: adds the given numbers
* boolean_and: is only true if all added values where true
* boolean_or: is true if one of the added values was true
* string_concat: concatenates strings

using accumulators:
```lua
-- create a new accumulator based on the number_add accumulator
local acc = accumulators.number_add:new()
-- add some stuff
acc:add(10)
for x = 0, 10 do
  acc:add(x)
end
-- get the result
print(acc:get())
```

creating accumulators:
```lua
-- create a new accumulator from the accumulator base
local string_concat_spaced = accumulators.accumulator:new()
-- override the add method
function string_concat_spaced:add(n)
  self.value = self.value .. " " .. n
end
-- override the reset method
-- it is called inside "new"
function string_concat_spaced:reset()
  self.value = ""
end

-- usage
local acc = string_concat_spaced:new()
acc:add("hello")
acc:add "world"
print(acc:get())
acc:reset()
acc:add("foo")
acc:add("bar")
print(acc:get())
```

accumulating function results:

You can call `accumulators.accumulate_function_results(accumulator,function_table,...)`  
To call multiple functions with all the given args and accumulate their return values.  
`accumulate_function_results` will return the value that `accumulator:get()` returns.

example:
```lua
local function hello()
  return "hello"
end
local function spaces(n)
  local s = ""
  for x = 0, n do
    s = s .. " "
  end
  return s
end
local function concat_2_3(_,nd,rd)
  return nd .. rd
end
print(accumulators.accumulate_function_results(
  accumulators.string_concat:new(), -- the accumulator
  {hello,spaces,concat_2_3}, -- the functions
  2,"wo","rld" -- their arguments 
))
```

# license
This mod is under the MIT License.
Some string and texture utils are from modlib by appgurueu (aka LMD) which is under MIT License.

[luacheck badge]: https://github.com/theFox6/modutil/workflows/luacheck/badge.svg
[luacheck workflow]: https://github.com/theFox6/modutil/actions?query=workflow%3Aluacheck
