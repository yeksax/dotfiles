vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":NvimTreeFocus<CR>")
vim.keymap.set("n", "<C-b>", ":NvimTreeFocus<CR>")

vim.keymap.set("n", "<C-Up>", ":m .-2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>", { noremap = true, silent = true })

-- Move linhas para cima ou para baixo no modo insert
vim.keymap.set('i', '<C-Up>', '<Esc>:m .-2<CR>i', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Down>', '<Esc>:m .+1<CR>i', { noremap = true, silent = true })

-- Move linhas para cima ou para baixo no modo visual
vim.keymap.set('x', '<C-Up>', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })
vim.keymap.set('x', '<C-Down>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("n", "<leader>t", "<C-w>s <C-w>j :term<CR> :resize 10<CR> i", { noremap = true, silent = true })

-- vim.keymap.set("i", "(", "()<left>")
-- vim.keymap.set("i", "[", "[]<left>")
-- vim.keymap.set("i", "{", "{}<left>")
-- vim.keymap.set("i", '"', '""<left>')
-- vim.keymap.set("i", "'", "''<left>")

vim.keymap.set("n", "<leader>f", "<cmd>LspZeroFormat<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/yeksax/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("w")
    if vim.bo.filetype == 'lua' then
        vim.cmd("luafile %")
    end
end)
