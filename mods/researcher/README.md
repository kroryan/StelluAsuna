Researcher
==========

Unlock the limitless creative potential of your world with Researcher! This mod adds a thematic "earned creative" mode to Minetest through which you can earn infinite duplication of the items in your world. When applied to a survival world, research becomes an enticing goal that rewards your gameplay efforts with endless command of the items you study the most.

Research
--------

Research is the mechanism by which items are permanently destroyed in order to gain the ability to duplicate them. You gain *research points* when you destroy an item, a score which is tracked per player and per item such that every player has their own research point total for each item in the game.

Reaching certain research point milestones known as *research levels* will grant you permanent bonuses towards future research of similar items. Reaching maximum research levels for an item will grant you the permanent ability to duplicate the item.

### How to Research

To research an item, open the Researcher menu in your inventory or via `/research`, place an item into the research box, then click the "Research" button. Researching an item will immediately destroy the researched item and grant you research points in return. The amount of research points gained per research is a constant amount plus any research bonuses you've gained.

### Duplication

Once you've reached the maximum research level for an item (level 10 by default), you are granted the permanent ability to duplicate the item as many times as you'd like at no cost. When duplication is unlocked for an item, the "Research" button in the research menu will change to "Duplicate" for the item, and clicking the button will add a full stack of the item to your main inventory.

Bonuses
-------

You can earn bonuses towards research by researching under certain conditions. These bonuses encourage players to specialize in a particular field of research.

### Group Research

Gaining research levels for a particular item will earn permanent bonuses on future items that match any of the item's groups. For example, cobblestone will have the `stone` group, and five research levels in cobblestone will add +5 research points for all `stone` items, including cobblestone itself.

### Focused Research

Focusing your research on a particular item will grant you cumulative bonuses to continuous research of the item and its groups. Whenever you research an item, the item becomes your current research focus.

You will gain additional research points for each successive research that matches the focus item or its groups, up to a certain maximum. More points are given for an exact match and fewer points are given for a group match. All focus bonuses are reset to zero if you research a non-matching item.

### Research Table

A research table is a special node that allows you to gain significant bonuses to your research. A research table has its own focus item that must be set and matched in order to use it for research.

To use a research table, craft it, place it, then right-click it in order to access its menu. Place an item into its "focus" slot to set its focus item. The research table can then be used to research items that match its focus item or the item's groups.

Placing items near the research table that match the groups of the research table's focus item will increase the research bonus it grants, up to a certain maximum (10 items by default). This can be done by placing matching nodes in the world near the research table or by placing a node with an inventory that contains matching items (e.g., a nearby chest full of swords to gain research bonuses to swords).

The crafing recipe for a research table requires wood (`[W]`) and stone (`[S]`) as illustrated below:

```
[S] [S] [S]
[W] [W] [W]
[W] [ ] [W]
```

Slash Commands
--------------

Researcher can be controlled via the `/research` slash command.

- `/research` - Opens the research interface, or prompts you to use your inventory for research if a supported inventory mod is being used (see next section for complete list)
- `/research reset` - Reset your entire research progress for all items
- `/research reset <item ID>` - Reset your research progress for the item specified by its item ID, e.g., `default:cobble`

Supported Games/Mods
--------------------

Researcher supports a number of games and mods. Popular games include:

- [Minetest Game](https://content.minetest.net/packages/Minetest/minetest_game/) and its derivatives, e.g., [MeseCraft](https://content.minetest.net/packages/MeseCraft/mesecraft/), [Asuna](https://content.minetest.net/packages/EmptyStar/asuna/), etc.
- [Mineclonia](https://content.minetest.net/packages/ryvnf/mineclonia/)
- [VoxeLibre](https://content.minetest.net/packages/Wuzzy/mineclone2/)
- Any Minetest game in theory, but those not listed above are untested

Supported mods include:

- [Awards](https://content.minetest.net/packages/rubenwardy/awards/) - Adds awards for certain research milestones
- [sfinv](https://content.minetest.net/packages/rubenwardy/sfinv/) (Minetest Game default) - Adds an integrated research tab where research can be performed
- [i3](https://content.minetest.net/packages/mt-mods/i3/) - Adds an integrated research tab
- [Unified Inventory](https://content.minetest.net/packages/RealBadAngel/unified_inventory/) - Adds an integrated research tab