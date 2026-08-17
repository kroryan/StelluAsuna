# mg_villages provenance and license

This directory contains the `mg_villages` code and schematics currently
bundled by StelluAsuna. It was first added to this repository in commit
`674a699`.

## Upstream comparison

- Repository: <https://github.com/Sokomine/mg>
- ContentDB package: <https://content.luanti.org/packages/Sokomine/mg_villages/>
- ContentDB release checked: <https://content.luanti.org/packages/Sokomine/mg_villages/releases/4863/>
- ContentDB API release checked: `2023-06-11`, release ID `20488`, commit
  `11dbd55a534dcce77235d94ba83753caba621fc0`.
- Older ContentDB release also recorded: commit
  `8b043f63b156e39c2eacdbdabf515d1f67c6c39c`.
- Repository inspected: <https://github.com/Sokomine/mg>

The local copy matches the ContentDB 2023 release in all 247 upstream files
except for two local changes in `inhabitants.lua` and `spawn_player.lua`.
Those changes are intentional StelluAsuna integration changes: the former
adds bounded/debugged worker assignment and the latter disables the original
mg_villages player-spawn hooks so the game controls spawn placement. The local
copy also contains this provenance notice.

ContentDB declares this package as **GPL-3.0-only for code and media**. The
release archive itself does not contain a separate license file, so this
directory includes `LICENSE` as a local preservation of that exact ContentDB
declaration. The complete GPLv3 text is retained in the repository root
`../../LICENSE`.

Do not apply the GPL notice to the two local modifications as if they were
upstream-authored; they remain StelluAsuna changes to a GPL-3.0-only base.
