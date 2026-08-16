# Extended Tooltips: Base
This mod is for the Extended Tooltips [tt] mod to extend item tooltips with the following
basic info:

* Tool digging times
* Weapon stats
* Food stats
* Node damage
* Node light level
* Node info: climbable, slippery, bouncy, jumping/descending restriction

This mod assumes that the default gameplay behavior of Luanti is used.

## Notes for programmers

This mod offers a few customizations for programmers, see `API.md`.

Game authors: It is highly recommended to review the tooltips of **ALL**
your items when you use this mod and make custom adjustments (see `API.md`)
where necessary. **DO NOT** just blindly drop this mod into your game
and call it a day. This mod cannot automatically detect everything, a
manual review is necessary to ensure high tooltip quality.

Note that using `tt_base` for your game is NOT neccessary for `tt` to
work, it just provides some common use cases. If `tt_base` is too
restrictive, consider *not* using it and just add the tooltip
snippets manually using the `tt` mod.

## Version
1.1.0

This mod requires Luanti 5.10.0 or later.

## License
MIT License.
