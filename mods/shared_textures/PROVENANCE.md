# shared_textures provenance status

This placeholder texture module was introduced in StelluAsuna commit
`674a699`. Its no-op init file was added later in `ce8631e` so ContentDB would
recognise it as a valid mod.

The bundled `blank.png` and `3d_armor_trans.png` are both 1x1 PNGs with the
same local hash. They do not match the similarly named files in the local
`horror` or `shields_mtg` mods, and no exact upstream package was found in the
Asuna or Stellua source trees or in the ContentDB package search.

The project owner has confirmed that this is an AI-created StelluAsuna
compatibility component. The Lua code is GPL-3.0-or-later and the two
transparent placeholder images are CC0-1.0; see `LICENSE`.
