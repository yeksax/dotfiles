local util = require("formatter.util")
local rfmt = function()
	return {
		exe = "Rscript",
		args = {
			"-e 'styler::style_file(\"" .. util.escape_path(util.get_current_buffer_file_path()) .. "\")'",
		},
	}
end

require("formatter").setup({
	filetype = {
		r = { rfmt },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
})

vim.api.nvim_exec(
	[[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost * FormatWrite
    augroup END
  ]],
	true
)
