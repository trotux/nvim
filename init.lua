---  HELPERS  ---

local cmd = vim.cmd
local opt = vim.opt

CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"

---  VIM ONLY COMMANDS  ---

cmd "filetype plugin on"
cmd('let &titleold="' .. TERMINAL .. '"')
cmd "set inccommand=split"
cmd "set iskeyword+=-"
cmd "set whichwrap+=<,>,[,],h,l"

--- COLORSCHEME ---

vim.g.colors_name = "mixed"

--- SETTINGS ---
opt.backup = false 	                        -- creates a backup file
opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
opt.colorcolumn = "99999"                   -- fix indentline for now
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0                        -- so that `` is visible in markdown files
opt.fileencoding = "utf-8"                  -- the encoding written to a file
opt.termguicolors = true                    -- set term gui colors (most terminals support this)
opt.timeoutlen = 500                        -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true                            -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim"      -- what the title of the window will be set to
opt.undodir = CACHE_PATH .. "/undo"         -- set an undo directory
opt.undofile = true                         -- enable persisten undo
opt.updatetime = 300                        -- faster completion
opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.pumheight = 10                          -- pop up menu height

opt.hlsearch = true                         -- highlight all matches on previous search pattern
opt.ignorecase = true                       -- ignore case in search patterns

opt.shortmess:append "c"

-- opt.mouse = "a"                             -- allow the mouse to be used in neovim

opt.showtabline = 2 	                    -- always show tabs
opt.tabstop = 4 	                        -- insert 4 spaces for a tab
opt.expandtab = true                        -- convert tabs to spaces
opt.shiftwidth = 4 	                        -- the number of spaces inserted for each indentation
opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
opt.smartcase = true                        -- smart case
opt.smartindent = true                      -- make indenting smarter again

opt.wrap = false 	                        -- display lines as one long line
opt.number = true 	                        -- set numbered lines
opt.cursorline = true                       -- highlight the current line
opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time

local leader_key = ";"
vim.api.nvim_set_keymap("n", leader_key, "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = leader_key

------------------
-- Key mappings --
------------------

require('mappings')

-------------
-- Plugins --
-------------

require('packed')
