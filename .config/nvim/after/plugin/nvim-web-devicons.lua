require 'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = "",
      color = "#07090F",
      cterm_color = "65",
      name = "Zsh"
    },
    go = {
      icon = "󰟓",
      color = "#01aed8",
      name = "Go"
    },
    svelte = {
      icon = "",
      color = "#fe4407",
      name = "Svelte"
    },
    json = {
      icon = "󰘦",
      color = "#f8e026",
      name = "Json"
    },
    js = {
      icon = "",
      color = "#f8e026",
      name = "Javascript"
    },
    gitignore = {
      icon = "",
      color = "#f05134",
      name = "Gitignore"
    },
    gitconfig = {
      icon = "",
      color = "#f05134",
      name = "Gitconfig"
    },
  },
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = false,
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
  -- globally enable "strict" selection of icons - icon will be looked up in
  -- different tables, first by filename, and if not found by extension; this
  -- prevents cases when file doesn't have any extension but still gets some icon
  -- because its name happened to match some extension (default to false)
  strict = false,
  -- same as `override` but specifically for overrides by filename
  -- takes effect when `strict` is true
  override_by_filename = {
    ["go.mod"] = {
      icon = "󰟓",
      color = "#01aed8",
      name = "GoMod"
    },
    ["go.sum"] = {
      icon = "󰟓",
      color = "#01aed8",
      name = "GoSum"
    }
  },
  -- same as `override` but specifically for overrides by extension
  -- takes effect when `strict` is true
  override_by_extension = {},
}
