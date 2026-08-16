# Telemosaic [telemosaic]

[![luacheck](https://github.com/mt-mods/telemosaic/workflows/luacheck/badge.svg)](https://github.com/mt-mods/telemosaic/actions)

A Minetest mod for user-generated teleportation pads.

![screenshot](screenshot.png?raw=true "screenshot")

## Description

This is a mod for Minetest. It provides teleportation pads, called "beacons". Unlike other teleportation mods, no menus or GUIs are used; you set the destination with a simple "key" item. There is no tooltip for the destination either, so signs are recommended.

Another difference is the limited default range of the beacons. To increase the range, you need to place "extenders" around the beacon. The extenders come in different colors, allowing the extenders to form a pretty pattern; hence the name "telemosaic".

## Notes

This is a maintained fork of https://github.com/bendeutsch/minetest-telemosaic with various improvements and changes, optimized for multiplayer environments.

* Beacons no longer teleport players automatically, they must be right-clicked by a player.
* More chat messages are sent to inform and help players with non-functional telemosaics.
* Telemosaic keys can be preserved by holding shift when right-clicking a beacon.
* Beacons can be enabled and disabled by punching them with a telemosaic key.
* If the `digilines` mod is installed, beacons can be controlled by digilines.
* and other small changes...

## Usage

Right-clicking a beacon with a default mese crystal fragment creates a telemosaic key with the position of the beacon.

Right-clicking a second beacon with the key sets the destination of the second beacon to the position of the first beacon. To set up a return path, right-click the second beacon with the fragment, and then first beacon with the resulting key again.

The beacons do not need to be strictly paired this way: rings or star-shaped networks are also possible. Each beacon has only a single destination, but can itself be the destination of several others.

Once linked, you teleport between beacons by right-clicking them. Before teleporting, beacons will check that their destination is sane: the destination still needs to be a beacon, and the two nodes above it should be clear for walking/standing in.

Beacons have a default range of 20 nodes. If the destination is too far away, the beacon will turn red and will not function. To extend the range for a beacon, place "extenders" next to it, within a 7x7 horizontal square centered on the beacon, and at the same level or one node below the beacon.

Extenders come in three tiers, with each being more powerful than the tier below. By default, tier 1, tier 2, and tier 3 extenders increase the range of nearby beacons by 5, 20, and 80 nodes, respectively.

Extenders can be colored with any of the dyes found in the `dye` mod. Colored extenders work just like regular extenders, both for teleporting and for recipes.

## Digilines

When the `digilines` mod is installed, telemosaic beacons can be controlled by sending digiline messages. By default, all beacons use the channel "telemosaic", but you can change the channel name via digilines.

For full documentaion, see [digilines.md](digilines.md).

## Dependencies

* `default`
* `doors`
* `dye` (optional)
* `digilines` (optional)

## License

* Code: LGPL 2.1 (see included LICENSE file)
* Textures: CC-BY-SA (see http://creativecommons.org/licenses/by-sa/4.0/)
* textures/telemosaic_beacon_protected_overlay.png MIT (https://notabug.org/TenPlus1/protector)
