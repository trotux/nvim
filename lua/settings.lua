-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-- This file can be loaded by calling `require('module_name')` from your
--- init.lua

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd     				    -- execute Vim commands
local exec = vim.api.nvim_exec 	    -- execute Vimscript
local fn = vim.fn       				    -- call Vim functions
local g = vim.g         				    -- global variables
local o = vim.o         				    -- global options
local b = vim.bo        				    -- buffer-scoped options
local w = vim.wo        				    -- windows-scoped options

CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"

-----------------------------------------------------------
-- VIM ONLY COMMANDS
-----------------------------------------------------------

cmd([["filetype plugin on"]])
cmd('let &titleold="' .. TERMINAL .. '"')
cmd([["set inccommand=split"]])
cmd([["set iskeyword+=-"]])
cmd([["set whichwrap+=<,>,[,],h,l"]])

-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = ';'                         -- change leader to a comma
-- o.mouse = 'a'                          -- enable mouse support
b.swapfile = false                        -- don't use swapfile
o.backup = false 	                        -- creates a backup file
o.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
o.cmdheight = 2                           -- more space in the neovim command line for displaying messages
o.colorcolumn = "100"                     -- fix indentline for now
o.conceallevel = 0                        -- so that `` is visible in markdown files
o.fileencoding = "utf-8"                  -- the encoding written to a file
o.timeoutlen = 500                        -- time to wait for a mapped sequence to complete (in milliseconds)
o.title = true                            -- set the title of window to the value of the titlestring
o.titlestring = "%<%F%=%l/%L - nvim"      -- what the title of the window will be set to
o.undodir = CACHE_PATH .. "/undo"         -- set an undo directory
o.undofile = true                         -- enable persisten undo
o.updatetime = 300                        -- faster completion
o.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
o.pumheight = 10                          -- pop up menu height
o.hlsearch = true                         -- highlight all matches on previous search pattern
o.ignorecase = true                       -- ignore case in search patterns
o.textwidth = 80
vim.opt.listchars = { space = '_', tab = '>~' }

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
o.completeopt = 'menuone,noselect,noinsert,preview' -- completion options
o.shortmess = 'c' 	-- don't show completion messages

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
o.hidden = true                           -- enable background buffers
o.history = 100                           -- remember n lines in history
o.lazyredraw = true                       -- faster scrolling
b.synmaxcol = 240                         -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
o.termguicolors = true                      -- set term gui colors (enable 24-bit RGB colors, most terminals support this)
g.colors_name = "mixed"

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
o.showtabline = 2 	                      -- always show tabs
o.tabstop = 4 	                          -- insert 4 spaces for a tab
o.expandtab = true                        -- convert tabs to spaces
o.shiftwidth = 4 	                        -- the number of spaces inserted for each indentation
o.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
o.smartcase = true                        -- smart case
o.smartindent = true                      -- make indenting smarter again

o.wrap = false 	                          -- display lines as one long line
o.number = true 	                        -- set numbered lines
o.cursorline = true                       -- highlight the current line
o.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time

