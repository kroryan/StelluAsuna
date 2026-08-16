## X-Decor-libre [`xdecor`] ##

[![ContentDB](https://content.luanti.org/packages/Wuzzy/xdecor/shields/downloads/)](https://content.luanti.org/packages/Wuzzy/xdecor/)

X-Decor-libre is a libre Luanti mod which adds various decorative blocks
as well as simple gimmicks.

This is a libre version (free software, free media) of the X-Decor mod for Luanti.
It is the same as X-Decor, except with all the non-free files replaced and with
bugfixes. There are no major new features.

## Version

This is version `libre19`.

## New blocks

This mod adds many decoration blocks: Flower pot, weathervane, radio, speaker,
wooden tile, new bricks, lamps, candles, new doors, packed ice, and more.

This mod also adds 7 new block shapes for many Minetest Game blocks. They can
be created by using the workbench. This includes panels, mini blocks and flat
stairs.

## Special blocks

Most blocks in this mod are purely decorative, but there are also many special
blocks with special features:

* Workbench: Storage, crafting, cutting and repairing
    * Storage: 16 item slots for item storage
    * Craft: 3×3 crafting grid
    * Cut: Put a full cube-shaped block to create new shapes
    * Repair: Put a damaged tool and a hammer and wait for it to be repaired
* Enchanting table: Upgrade your tools with mese crystals
* Ender Chest: Interdimensional inventory that is the same no matter
               where you put the ender chest
* Mailbox: Lets you receive items from other players
* Item Frame: You can place an item into it to show it off
* Cushion: Reduces fall damage
* Cushion Block: Reduces fall damage even more
* Trampoline: Jump on it to bounce off. Very low fall damage
* Cauldron: For storing water and cooking soups
    * Recipe: Pour water in, light a fire below it and throw
      in some food items. Collect the soup with a bowl
* Lever: Pull the lever to activate doors next to it
* Pressure Plate: Step on it to activate doors next to it
* Chessboard: Play Chess against a player or the computer (see `CHESS_README.md`)

## Supported mods

This mod interacts with the following mods to add new features:

* `tt`: Tooltips will explain the special items and blocks
* `mesecons`: Doors react to mesecon signals
* `unified_inventory`: Add honey in crafting guide
* `toolranks`: Compatibility for enchanted tools
* `moreblocks`: Compatibility changes (other recipes, etc.)

## For developers and translators

X-Decor-libre can be extended in a limited fashion. See `API.md` for details.

This mod can also be translated. The recommended way to translate this mod is
online on Codeberg Translate:

<https://translate.codeberg.org/projects/xdecor/>

For technical details, see the text file `TRANSLATING.md`.

## Information about the original mod

### Compatibility

X-Decor-libre is highly compatible with X-Decor. Read
“`historic/upgrade.md`” for details on how to upgrade from X-Decor
to X-Decor-libre.

### More information

For more information about the original X-Decor mod (from which this one
is derived) and a comparison between both mods, see the text files
in the directory named “`historic`”.

## Technical information

X-Decor-libre is a fork of X-Decor, from <https://github.com/minetest-mods/xdecor>,
forked at Git commit ID 8b614b3513f2719d5975c883180c011cb7428c8d.

Note the technical mod name of X-Decor-libre is the same as for X-Decor: `xdecor`.
This is because this mod is meant to be a drop-in-replacement.

The original readme of X-Decor can be found at `historic/OLD_README.md`.
