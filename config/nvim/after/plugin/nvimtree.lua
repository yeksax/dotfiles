require("nvim-tree").setup({
    actions = {
        open_file = {
            -- quit_on_open = true,
        },
    },
    update_focused_file = {
        enable = true,
    },
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
        width = 40,
    }
})

