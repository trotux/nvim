return function ()
  vim.g.vista_default_executive = 'nvim_lsp'
  vim.g.vista_sidebar_width = 50

  vim.api.nvim_set_keymap("n", "<C-\\>", ":Vista!!<CR>", { noremap = true, silent = true })
end
