# Third-party licenses and provenance

This is the redistribution index for the StelluAsuna game. It records the
source, license and relevant local changes for material that is not wholly
owned by the project. It does not replace the license files shipped inside
each mod and it does not grant rights where the copyright holder has not done
so.

## Project-owned components

- `mods/admin_seed/`: code owned by kroryan, GPL-3.0-or-later; notice in
  `mods/admin_seed/LICENSE`.
- `mods/sgjourney/`: code owned by kroryan, GPL-3.0-or-later; original local
  PNG and OGG assets are CC0-1.0; notices are in `mods/sgjourney/LICENSE` and
  `mods/sgjourney/ASSETS_LICENSE.md`.

## Stellua-derived components

`stl_core`, `stl_decor`, `stl_precursor`, `stl_vehicles` and `stl_weather`
were compared with the Stellua upstream repository. The upstream license is
preserved verbatim in `LICENSE_STELLUA.txt`.

- Upstream: <https://github.com/theidealist101/stellua>
- Revision inspected: `2f3266ffbef2fd631aa07f5bca278b1d0d024a18`
- Upstream license: GPLv3 for code and the component-specific media terms
  stated in `LICENSE_STELLUA.txt`.
- Local status: these directories contain a mixture of unchanged upstream
  files and StelluAsuna modifications. The modified files are marked in the
  repository history where known; this manifest identifies the derivative
  source and preserves the upstream attribution.
- `stl_seasons` and `stl_village_bridge` are project-owned integration
  components, not part of that upstream revision. Their GPL-3.0-or-later
  notices are stored in the respective directories.

The Stellua license lists the following external sound assets bundled by the
derived mods. They remain attributed here even when the files were converted
or compressed by the release build:

| Bundled file | Author | Source | License |
|---|---|---|---|
| `mods/stl_vehicles/sounds/242740__marlonhj__engine.ogg` | MarlonHJ | <https://freesound.org/s/242740/> | CC0 |
| `mods/stl_vehicles/sounds/534856__m_cel__jet-engine.ogg` | m_cel | <https://freesound.org/s/534856/> | CC0 |
| `mods/stl_weather/sounds/212799__ayton__rain-loop-ontario.ogg` | Ayton | <https://freesound.org/people/Ayton/sounds/212799/> | CC BY 3.0 |
| `mods/stl_weather/sounds/624267__iwaobisou__soft-hail-leaves-looped.ogg` | iwaobisou | <https://freesound.org/s/624267/> | CC0 |
| `mods/stl_weather/sounds/651545__nsstudios__wind-draft-loop-3.ogg` | nsstudios | <https://freesound.org/s/651545/> | CC BY 4.0 |
| `mods/stl_weather/sounds/717995__johnny25225__heavywobblyimpacthit_06.ogg` | johnny25225 | <https://freesound.org/s/717995/> | CC0 |
| `mods/stl_weather/sounds/777331__matthiasflowers__101glcglitzer-teckyy-kachelhi_endonly.ogg` | matthiasflowers | <https://freesound.org/s/777331/> | CC BY 4.0 |
| `mods/stl_precursor/sounds/631467__adhdreaming__destroy-all-humans.ogg` | adhdreaming | <https://freesound.org/s/631467/> | CC0 |

## Other included third-party material

- Asuna and its included modpack components: see the existing per-mod
  license and credit files listed in `LICENSE`.
- `mods/deepslate/`: the bundled LDoc documentation files match the
  SilverSandstone ContentDB release `0.2.0` (release ID `17511`). Code is MIT
  and media is CC-BY-SA-4.0; the original `LICENSE.md` is now preserved in
  that directory. Source package: <https://content.luanti.org/packages/SilverSandstone/deepslate/>.
- `mods/glow_pack/`: the local content matches Hybrid Dog's ContentDB
  release `v1.0.0` (release ID `10202`), apart from the metadata filename.
  Code is MIT and media is CC-BY-3.0. The local preservation notice is
  `mods/glow_pack/LICENSE.md`.
- `mods/mg_villages/`: the local content matches Sokomine's ContentDB 2023
  release in 247 upstream files, with two documented StelluAsuna changes.
  ContentDB declares code and media GPL-3.0-only; see
  `mods/mg_villages/LICENSE` and `UPSTREAM_PROVENANCE.md`.
- `mods/simple_fishing/`: code AGPL-3.0-only; textures CC BY-SA 4.0; bundled
  sounds CC0; bundled font OFL-1.1. The authoritative texts are inside that
  mod and its README.
- `mods/skinsdb/`: skin authors and licenses are listed in
  `mods/skinsdb/CREDITS.md`; the listed skins are CC BY-SA 3.0 or CC0.
- `mods/itemframes/`: code MIT and textures CC BY 3.0 according to its
  README and the exact local content matches the ContentDB release from
  2026-08-06. The package declares its media as CC BY 3.0. Its README says
  `screenshot.jpg` was created using textstudio.com; that external source
  attribution is retained but its terms are not independently documented.

## Local components and asset provenance

These are not copies of a package found in Asuna, Stellua or the exact public
ContentDB searches performed for this audit:

- `mods/shared_textures/`: introduced by project commit `674a699` and given a
  no-op init by `ce8631e`. Its two 1x1 PNGs have the same hash as each other,
  but do not match the `blank.png` files in `horror` or `shields_mtg`, and no
  ContentDB package named `shared_textures`, `3d_armor_trans` or
  `placeholder textures` was found. The creator and license of these images
  are therefore still unknown.
- `mods/stl_seasons/`: present from project commit `e1fb3a0` as the
  StelluAsuna seasonal integration. That commit does not establish its
  pre-repository source. It does not match the public
  `tbook/seasons` package, which is a separate biome-driven mod with a
  different file/API layout. The project owner has confirmed the code is
  project-owned and licensed GPL-3.0-or-later.
- `mods/stl_village_bridge/`: present in project commit `674a699` and
  restored by `e7c2007` after a temporary removal. It is the local bridge from
  `mg_villages` beds to `working_villages` residents, not an upstream Stellua
  component or a ContentDB package with this exact name. The root commit does
  not prove its pre-repository source; the project owner has confirmed the
  code is project-owned and licensed GPL-3.0-or-later.

## Pending before broad redistribution

The following item still has no verified license or ownership record for the
exact local files. It is still included in the game as requested, but should
not be treated as cleared for redistribution until the listed evidence is
obtained:

- `mods/shared_textures/`: provenance and license of the placeholder images;
  see the local-component section above.

The `itemframes` screenshot is not pending: the exact local package matches
the ContentDB release and its package metadata declares CC-BY-3.0 for media.
Its textstudio.com provenance remains documented for attribution purposes.

This pending list is intentionally conservative. A missing license is not
interpreted as permission to redistribute; see the Luanti ContentDB copyright
guidance for the required source, author and license evidence.
