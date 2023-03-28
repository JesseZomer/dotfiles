-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- easy escape
vim.keymap.set("i", "jj", "<Esc>")

-- move cursor in insert mode
vim.keymap.set("i", "<C-h>", "<C-o>h")
vim.keymap.set("i", "<C-l>", "<C-o>l")

-- undo ctrl-z
vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("i", "<C-z>", "<C-o>u")

-- Don't yank on char replace
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "X", '"_X', { noremap = true, silent = true })
vim.keymap.set("v", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("v", "X", '"_X', { noremap = true, silent = true })

-- Don't yank on visual paste
vim.keymap.set("v", "p", '"_dP')

-- keep cursor in same place when joining/navigating
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<Cmd>lua require('neoscroll').scroll(vim.wo.scroll, true, 250)<CR>zz")
vim.keymap.set("n", "<C-u>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- put in _ register when deleting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
