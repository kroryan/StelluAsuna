# X-Decor-libre Autocut [`xdecor_autocut`]

## Version

This is version `1.0.0` of `xdecor_autocut`, compatible
with version `libre14` or later of X-Decor-libre.

## Description

This is a companion mod for X-Decor-libre [`xdecor`].

It automatically adds many more “cut” variants for most
cube-shaped nodes in the game so the player can cut more
nodes at the workbench. This does not guarantee that
all added cut nodes will look pretty, however,
as the nodes will be added automatically and are
not carefully curated.

By default, X-Decor-libre only adds cut node variants for
nodes from itself and the `default` mod.

With this mod, nodes from other mods will be available for
cutting as well.

This has been the original behavior of X-Decor-libre in the past,
but it has been removed in version `libre6` due to
hard-to-debug compatibility issues like naming collisions.
This mod basically replicates this old behavior, but a bit
more stable.

## Usage

To use this mod, simply copy the mod folder to your
`mods` directory of your Luanti user directory and
then enable it for your world like any other world.

### Note for server operators

You should probably not use this mod except for
compatibility with old versions of X-Decor-libre
or X-Decor.

If you are just now adding X-Decor-libre or
start with a fresh world, you’re probably better
off in writing a small mod to *explicitly* make
each node you want to be made cut cuttable, to
prevent to pollute your server with garbage nodes.
See `src/workbench.lua` for details.

This mod mainly exists because if will be useful if
your server used an older version of X-Decor-libre
or X-Decor that aggressively added many cut nodes
which have become unknown nodes in newer versions,
because since X only nodes from X-Decor-libre
and the `default` mod are cuttable, for safety
reasons.
If your world contains some cut nodes from any
other mod, and they have become unknown after
you upgraded of X-Decor-libre, this mod is for you.

Please note that this aggressive automatic
adding of cut nodes is not guaranteed to give you
the best quality. Some nodes that you probably
do not want to be cut will be cuttable, some nodes
might look ugly in their cut form, especially
custom glass nodes. It is recommended you check your
logs for `[xdecor_autocut]` messages to see which
nodes have been made cuttable.

However, this mod should still be relatively safe to
use, because it now checks for naming collisions.
If it detects that any of the required node names
for cut nodes is taken, it will refuse to add any
cut node variants and print a message in the log.

### Note for modders

You can prevent any node from being having cut node
variants added to it by adding the group
`not_cuttable=1` to it.

## License

This mod is free software, distributed under the Modified
BSD License (see `LICENSE.txt`).
