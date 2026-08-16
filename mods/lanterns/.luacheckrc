unused_args = false
allow_defined_top = true
exclude_files = {".luacheckrc"}

globals = {
    -- This is needed so running luacheck on a single file will recognize it
    "stripped_tree",
}

read_globals = {
    string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

    -- Builtin
    "core", "vector", "ItemStack",
    "dump", "DIR_DELIM", "VoxelArea", "Settings",

    -- MTG
    "default", "sfinv", "creative",

    -- Dependencies
    "moretrees", "ethereal", "moreores"
}
