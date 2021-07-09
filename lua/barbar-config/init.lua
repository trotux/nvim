return function ()
  vim.api.nvim_set_keymap("n", "<C-Right>", ":BufferNext<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<C-Left>", ":BufferPrevious<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<C-Del>", ":BufferClose<CR>", { noremap = true, silent = true })
end
