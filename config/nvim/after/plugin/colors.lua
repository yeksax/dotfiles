function ColorMyPencils(color)
  color = color or "gruvbox-material"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeStatusline", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "none", fg = "#202328" })
end

ColorMyPencils()
