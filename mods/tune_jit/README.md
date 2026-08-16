# Tune JIT `tune_jit`

A Luanti mod tuning LuaJIT parameters to improve server performance by
preventing constant GC.


## Wait, what does it exactly do?

At a base level, this mod implements the same thing as [VoxeLibre](https://git.minetest.land/VoxeLibre/VoxeLibre/src/commit/161dbaea03a7816db1393ca767c84a5f275ef162/mods/CORE/mcl_init/tune_jit.lua)
and [Mineclonia](https://codeberg.org/mineclonia/mineclonia/src/commit/94467d9f822ae31838e3c76d643950be2ee891f8/mods/ENTITIES/mcl_mobs/pathfinding.lua#L1627-L1636)
but for other Luanti games, with more configurability for the server operator.

[The `jit.opt.*` API](https://luajit.org/ext_jit.html) is leveraged in order to
modify JIT compiler optimization parameters on server startup. This won't work
with LuaJIT 1.x, but if you have a LuaJIT that ancient, most of your server-side
performance issues should go away after you upgrade it. The coolest thing is
that this mod doesn't have to be in the `secure.trusted_mods` list in order to
apply the parameters.

In [@halon](https://codeberg.org/halon)'s words:

> Large minetest servers on stock luajit spend most of their globalsteps
> recording and jit compiling traces that are evicted for exceeding one of the
> minuscule limits on trace count or mcode size defined by default

The specific parameters that are modified are `maxtrace`, `maxrecord`,
`minstitch` and `maxmcode`. Please refer to this mod's `settingtypes.txt` and
LuaJIT documentation for details.


## Will it help with client-side lag?

Unless it was the server's fault, no.

For singleplayer, remember that Luanti just starts up a server under the hood
and connects you to it, with the same server/client communication rules and
specifics. The only difference is that both server and client are now ran on the
same machine, though most likely in different threads.

Mobs freezing and map generation suddenly stopping might get removed, but this
won't have any effect on rendering or audio playback.


## License

The source code is licensed under 0BSD ("public domain"). See `LICENSE` file for
details.
