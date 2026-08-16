# Translating X-Decor-libre

This mod wants to be translated in many languages.

The recommended way to translate this mod is online on Codeberg Translate:

<https://translate.codeberg.org/projects/xdecor/>

This is the easiest way to help this mod get translated.

## Manual translation

The rest of this document describes how translation works under the hood.
You don’t need to understand this.

The translations are provided in the gettext PO format (supported since
Luanti 5.10.0); they can be edited with programs like Poedit.

Many strings are commented, so read the comments to understand the context
of each string.

There are two files to translate:

* `xdecor.pot`: Main translation file
* `_xdecor_cut_nodes.pot`: Descriptions of nodes that were cut by the workbench

To create a complete translation, you need to have:

* `xdecor.<CODE>.po`
* `_xdecor_cut_nodes.<CODE>.po`

where `<CODE>` is the language code like `de` for German.

## Special symbols

The strings may contain some symbols with special meaning:

`@1`, `@2`, `@3`, etc. are placeholders, they will be replaced with some other
text. The translation *MUST* include all placeholders of the original string,
but you can change the order as you wish.

`@n` represents a new line.

Refer to `lua_api.md` of the Luanti documentation for more information about
the translation system.
