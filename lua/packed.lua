local execute = vim.api.nvim_command
local fn = vim.fn

-- Auto install plugin manager

-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local install_path = vim.fn.stdpath('data')..'site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

vim.cmd [[ autocmd BufWritePost packed.lua PackerCompile ]]

-- Plugins configurations

return require('packer').startup(

  function()
    -- Let packer manage itself
    use {'wbthomason/packer.nvim'}

    -- Status line
    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                theme = 'wombat'
                }
            })
        end
    }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup({})
    end
  }

  use {
    'APZelos/blamer.nvim',
    config = function()
      vim.g.blamer_enabled = 0
      vim.g.blamer_show_in_visual_modes = 0
      vim.g.blamer_relative_time = 1
    end
  }

  -- Comments
  use {
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    config = function()
      require("nvim_comment").setup()
    end,
  }

  -- Show indent line
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"

      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
      }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }

      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
    end,
    disable = false,
  }

  use {
    'editorconfig/editorconfig-vim',
    event = "BufRead",
    setup = function()
      vim.g.EditorConfig_exec_path = '/usr/bin/editorconfig'
    end,
  }

  use {'axelf4/vim-strip-trailing-whitespace'}
  use {
    'ntpeters/vim-better-whitespace',
    event = "BufRead",
    setup = function()
      vim.g.better_whitespace_skip_empty_lines=0
    end,
    disable = false,
  }

  use {'kyazdani42/nvim-web-devicons'}

  -- Buffer line
  use {
    "romgrk/barbar.nvim",
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = require('barbar-config')
    -- config = function()
    --   vim.api.nvim_set_keymap("n", "<C-Right>", ":BufferNext<CR>", { noremap = true, silent = true })
    --   vim.api.nvim_set_keymap("n", "<C-Left>", ":BufferPrevious<CR>", { noremap = true, silent = true })
    --   vim.api.nvim_set_keymap("n", "<C-Del>", ":BufferClose<CR>", { noremap = true, silent = true })
    -- end,
    -- event = "BufRead",
  }

  use {'neovim/nvim-lspconfig', config = require('lsp')}

  -- LSP Colors
  use {
    "folke/lsp-colors.nvim",
    event = "BufRead",
  }


--  use {
--    'm-pilia/vim-ccls',
--   config = function()
--      require('vim-ccls').setup({})
--    end
--  }

  -- Autocomplete
  use {'hrsh7th/vim-vsnip', config=require('vim-vsnip')}
  use {
    "hrsh7th/nvim-compe",
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('compe').setup({
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "enable",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,

        source = {
          path = { kind = "   (Path)" },
          buffer = { kind = "   (Buffer)" },
          calc = { kind = "   (Calc)" },
          vsnip = { kind = "   (Snippet)" },
          nvim_lsp = { kind = "   (LSP)" },
          -- nvim_lua = {kind = "  "},
          nvim_lua = false,
          spell = { kind = "   (Spell)" },
          tags = false,
          vim_dadbod_completion = true,
          -- snippets_nvim = {kind = "  "},
          -- ultisnips = {kind = "  "},
          treesitter = {kind = "  "},
          emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } },
          -- for emoji press : (idk if that in compe tho)
        },
      })
    end,
  }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "nvim-compe" },
    config = function()
      require "nvim-autopairs"
    end,
  }

  use {'bfrg/vim-cpp-modern'}
  use {'rhysd/vim-clang-format'}

  use {'liuchengxu/vista.vim'}

  use {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 15; -- Height of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
      }
    end
  }

  end)
