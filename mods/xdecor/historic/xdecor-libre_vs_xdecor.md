### X-Decor-libre vs X-Decor

The original X-Decor mod is a popular mod in Luanti but it is (as the
time of writing this text) non-free software, there are various files
under proprietary licenses.

The purpose of this repository is to provide the community a fully-free fork of
X-Decor with clearly documented licenses and to fix bugs.

#### New feature policy

X-Decor-libre is very careful with adding new features, especially new
blocks and items, if they didn't exist in X-Decor before.

X-Decor-libre wants to preserve the features of the original mod
as much as possible, but bug-free and under fully free licensing.

No major new additions are planned.

New blocks should be added only after very careful consideration
to prevent bloat. Basically, only if they are a variant of an
existing block and they feel an actual gap. Completely brand-new
blocks should not be added.

The green chrysanthemum and black tulip have been added to
complete the full set of flowers in Minetest Game 5.0.0 and
later versions.

No major new gameplay features or changes are planned, except
for maintenance and bugfixing.

#### List of changes

Compared to the original X-Decor mod, this is a list of changes
that X-Decor-libre provides:

Important compatibilty-relevant change:

* Mod no longer registers cut nodes for mods other than `xdecor`
  and `default` (see `historic/upgrade.md` for details) (since
  version `libre6`)

Added blocks:

* Potted Green Chrysanthemum
* Potted Black Tulip

Fixed bugs (as of 01/07/2023):

* Changed packed ice recipe to avoid recipe collision with Ethereal
* Changed prison door recipe colliding with Minetest Game's Iron Bar Door
* Beehives no longer show that the bees are busy when they're not
* Fixed incorrect/incomplete node sounds
* Fix poorly placed buttons in enchantment screen
* Fix broken texture of cut Permafrost with Moss nodes
* Fix awkward lantern rotation
* Lanterns can no longer attach to sides
* Fix item stacking issues of curtains
* Cauldrons no longer turn river water to normal water
* Fix boiling water in cauldrons not reliably cooling down
* Fix boiling water sound not playing when rejoining
* Fix cauldron with soup boiling forever
* Fix cauldrons being heated up by fireflies
* Fix rope and painting not compatible with itemframe
* Fix itemframe, lever being offset when put into itemframe
* Fix storage formspecs not closing if exploded
* Show short item description in itemframe instead of itemstring
* Minor typo fixes
* Fix bad rope placement prediction
* Fixed the broken Chess game

Maintenance updates:

* HUGE rework of Chess to make it actually be like real Chess (more or less)
* New supported Chess rules (based on the FIDE Laws of Chess)
    * En passant
    * Choose your pawn promotion
    * Fixed incomplete enforcement of castling rule
    * 50-turn rule and 75-turn rule
    * Threefold repetition rule and fivefold repetition rule
    * Announce the winner or loser, or a drawn game
* Many technical improvements for Chess
* Renamed blocks:
    * "Empty Shelf" to "Plain Shelf"
    * "Slide Door" to "Paper Door"
    * "Rooster" to "Weathercock"
    * "Stone Tile" to "Polished Stone Block"
    * "Desert Stone Tile" to "Polished Desert Stone Block"
    * "Iron Light Box" to "Steel Lattice Light Box"
    * "Wooden Light Box" to "Wooden Cross Light Box"
    * "Wooden Light Box 2" to "Wooden Rhombus Light Box"
    * "Potted Rose" to "Potted Red Rose"
    * "Potted Tulip" to "Potted Orange Tulip"
    * "Potted Geranium" to "Potted Blue Geranium"
* Added fuel recipes for wooden-based things
* Changed a few confusing recipes to make more sense
* Improved textures for cut glass, obsidian glass, wood-framed glass,
  permafrost with moss and permafrost with stones
* Improved side texture of wood frame and rusty bar
* Add honey and cushion block to creative inventory
* Doors now count as nodes in creative inventory
* Cobwebs are no longer considered (fake) liquids
* Storage blocks now drop their inventory when exploded
* Made several strings translatable
* Translation updates
* Add description to every setting
* Add tooltip extensions for some interactive items (uses `tt` mod)
* Add crafting guide support for `unified_inventory` mod (honey)
* Rope no longer extends infinitely in Creative Mode
* Added manual for Chess in `CHESS_README.md`

Note: This list may not be perfect, because a lot of other changes
have been made since it was written.

#### List of replaced files

This is the list of non-free files in the original X-Decor mod
(as of commit 8b614b3513f2719d5975c883180c011cb7428c8d)
that X-Decor-libre replaces:

* `textures/xdecor_candle_hanging.png`
* `textures/xdecor_radio_back.png`
* `textures/xdecor_radio_front.png`
* `textures/xdecor_radio_side.png`
* `textures/xdecor_radio_top.png`
* `textures/xdecor_rooster.png`
* `textures/xdecor_speaker_back.png`
* `textures/xdecor_speaker_front.png`
* `textures/xdecor_speaker_side.png`
* `textures/xdecor_speaker_top.png`
* `sounds/xdecor_enchanting.ogg`

(see `LICENSE.txt` file for licensing).

