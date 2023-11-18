require("nvim-tree").setup({
  sort_by = "case_sensitive",
  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = {
      ".git"
    }
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = false,

      },
    },
  },
  open_on_tab = false,
  hijack_cursor = true,
  view = {
    adaptive_size = true,
  }
})
