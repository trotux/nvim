local inoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap('i', lhs, rhs, {noremap = true, silent = true})
end

local nnoremap = function(lhs, rhs, silent)
    vim.api.nvim_set_keymap('n', lhs, rhs, {noremap = true, silent = silent})
end

local nnoremap = function(lhs, rhs)
    vim.api.nvim_set_keymap('n', lhs, rhs, {noremap = true, silent = true})
end

local vnoremap = function(lhs, rhs)
    vim.api.nvim_set_keymap('v', lhs, rhs, {noremap = true, silent = true})
end

-- Tab switch buffer
-- nnoremap('<C-n>', ':bnext<CR>', true)
-- nnoremap('<C-p>', ':bprevious<CR>', true)

nnoremap("<C-Right>", ":BufferLineCycleNext<CR>", true)
nnoremap("<C-Left>", ":BufferLineCyclePrev<CR>", true)
nnoremap("<C-Del>", ":bd<CR>", true)

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })
-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { noremap = true, silent = true, expr = true })

nnoremap("++", ":CommentToggle<CR>")
vnoremap("++", ":CommentToggle<CR>")
nnoremap("<leader>n", ":tabnew<CR>")

vim.api.nvim_set_keymap("n", "<C-d>", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-i>", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})

vim.api.nvim_set_keymap("n", "<A-Up>", ":resize -2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-Down>", ":resize +2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-Left>", ":vertical resize +2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-Right>", ":vertical resize -2<CR>", { silent = true })

-- Map Ctrl-Backspace to delete the previous word in insert mode.
-- nnoremap('<C-w>', '<C-\\><C-o>dB')
nnoremap('<C-BS>', 'db')

nnoremap('<C-\\>', '<cmd>SymbolsOutline<CR>')

-- Trouble plugin
nnoremap("<leader>xx", "<cmd>Trouble<CR>")
nnoremap("<C-e>", "<cmd>Trouble<CR>")
nnoremap("<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>")
nnoremap("<leader>xd", "<cmd>Trouble document_diagnostics<CR>")
nnoremap("<leader>xl", "<cmd>Trouble loclist<CR>")
nnoremap("<leader>xq", "<cmd>Trouble quickfix<CR>")
nnoremap("gR", "<cmd>Trouble lsp_references<CR>")
nnoremap("<F3>", "<cmd>Trouble lsp_references<CR>")

-- Renamer plugin
inoremap("<F2>", '<cmd>lua require("renamer").rename({empty = false})<CR>')
nnoremap("<F2>", '<cmd>lua require("renamer").rename({empty = false})<CR>');

-- Nvim-Tree
nnoremap('<leader>nt', ':NvimTreeToggle<CR>')
nnoremap('<leader>nr', ':NvimTreeRefresh<CR>')
nnoremap('<leader>nf', ':NvimTreeFindFile<CR>')

