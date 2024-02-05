-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
    blue        = '#458588',
    cyan        = '#8ec07c',
    black       = '#1d2021',
    white       = '#ebdbb2',
    red         = '#fb4934',
    violet      = '#d3869b',
    grey        = '#928374',
    transparent = '#00000000',
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.white },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.transparent },
    },

    insert = { a = { fg = colors.black, bg = colors.green } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    },
}

require('lualine').setup {
    options = {
        disabled_filetypes = { 'NvimTree', 'packer' },
        disabled_buftypes = { 'terminal', 'nofile' },
        theme = bubbles_theme,
        component_separators = '',
    },
    sections = {
        lualine_a = {
            { 'mode' },
        },
        lualine_b = { 'filename' },
        lualine_c = { 'fileformat' },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
            { 'location' },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
}
