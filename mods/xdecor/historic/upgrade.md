# Upgrading from X-Decor to X-Decor-libre

Here’s how you can upgrade from X-Decor to X-Decor-libre.

## Drop-in-replacement

If you used the original X-Decor before, this mod is a safe **drop-in-replacement**
for X-Decor **provided you used no other mods that added new blocks**. X-Decor-libre
is fully backwards-compatible in that case.

If other mods existed, X-Decor-libre is still a drop-in-replacement if
the world contains no cut nodes that have been cut from nodes from
a mod other than `default` or `xdecor`. (“classic” stairs, slabs, inner
and outer slabs that already existed without X-Decor-libre are safe)

If this is the case, then you can just replace your X-Decor mod in your world
with X-Decor-libre and you’re good to go.

If this for any reason still didn’t work, this is a bug, please report it at
<https://codeberg.org/Wuzzy/xdecor-libre/issues>.

## Manual intervention required

If you used X-Decor before and you or any player in the world have cut any node
at the workbench that is not from `xdecor` or the `default` mod, then those
cut nodes will become **unknown nodes** after you upgrade. In that case,
X-Decor-libre is **no longer a drop-in-replacement**, so a bit of manual
intervention is required to make the upgrade to X-Decor-libre work.

(This was a change in version `libre6` that was done to remove clutter and
prevent more and more potential naming collisions to build up. Versions
before `libre6` added cut nodes too aggressively, potentially even overwriting
existing nodes.)

Cut nodes end with `_panel`, `_cube`, `_thinstair`, `_microslab`, `_micropanel`,
`_nanoslab`, `_halfstair` (but remember nodes with such names might come
from other unrelated mods as well).

To fix the unknown nodes, you can add the `xdecor_autocut` mod which you find
in the `extra_mods` directory. This will basically bring back the old
behavior of X-Decor and old X-Decor-libre versions (before `libre6`), but
is a bit more careful with adding nodes. Read `extra_mods/xdecor_autocut/README.md`
for details.

Alternatively, you may decide to manually remove all unknown cut nodes from
the world. This is more realistic if not many such nodes have been created
so far.


