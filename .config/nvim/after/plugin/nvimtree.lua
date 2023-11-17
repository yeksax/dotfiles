require("nvim-tree").setup({
  sort_by = "case_sensitive",
  filters = {
    dotfiles = false,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = false,

      },
    },
  },
  open_on_tab = true,
  hijack_cursor = true,
  view = {
    width = 40
  }
})
