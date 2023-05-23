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

vim.keymap.set("n", "<C-d>", "<Cmd>lua require('neoscroll').scroll(vim.wo.scroll, true, 250)<CR>zz")
vim.keymap.set("n", "<C-u>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- put in _ register when deleting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- When creating a new line with o, make sure there is a trailing comma on the
-- current line
vim.keymap.set("n", "o", function()
  local line = vim.api.nvim_get_current_line()

  local should_add_comma = string.find(line, "[^,{[]$")
  if should_add_comma then
    return "A,<cr>"
  else
    return "o"
  end
end, { buffer = true, expr = true })

-- Inside an attribute: <button type| pressing = -> <button type="|"
vim.keymap.set("i", "=", function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

  -- The cursor location does not give us the correct node in this case, so we
  -- need to get the node to the left of the cursor
  local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
  local nodes_active_in = { "attribute_name", "directive_argument", "directive_name" }
  if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
    return "="
  end

  return '=""<left>'
end, { expr = true, buffer = true })

-- attempts to be smart about removing whitespace from joined lines
vim.keymap.set("n", "J", function()
  vim.cmd("normal! mzJ")

  local col = vim.fn.col(".")
  local context = string.sub(vim.fn.getline("."), col - 1, col + 1)
  if
    context == ") ."
    or context == ") :"
    or context:match("%( .")
    or context:match(". ,")
    or context:match("%w %.")
  then
    vim.cmd("undojoin | normal! x")
  elseif context == ",)" then
    vim.cmd("undojoin | normal! hx")
  end

  vim.cmd("normal! `z")
end)

-- dont yank empty lines into register
vim.keymap.set("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true })

vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })
