local execute = vim.api.nvim_command
local fn = vim.fn

-- Auto install plugin manager
local install_path = vim.fn.stdpath('data')..'site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

-- Plugins configurations

return require('packer').startup(
  function()
    -- Let packer manage itself
    use {
      'wbthomason/packer.nvim'
    }

    use {'axelf4/vim-strip-trailing-whitespace'}
    use {'kyazdani42/nvim-web-devicons'}

    -- Status line
    use {
      'hoob3rt/lualine.nvim',
      config = require('config.lualine')
    }

    -- Buffer line
--[[
    use {
      "romgrk/barbar.nvim",
      requires = {
        'kyazdani42/nvim-web-devicons'
      },
      config = require('config.barbar')
    }
]]--
    use {
      "akinsho/bufferline.nvim",
      requires = {
        'kyazdani42/nvim-web-devicons'
      },
      config = require('config.bufferline')
    }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      config = require('config.lspconfig')
    }

    -- LSP goto preview
    use {
      'rmagatti/goto-preview',
      config = require('config.goto-preview')
    }

    -- LSP Colors
    use {
      "folke/lsp-colors.nvim",
      event = "BufRead",
    }

    -- LSP CXX colors
    use { "jackguo380/vim-lsp-cxx-highlight" }

    -- Show tags based on LSP
    use {
      "liuchengxu/vista.vim",
      config = require('config.vista')
    }

    -- better LSP UI (for code actions, rename etc.)
    use {
      'glepnir/lspsaga.nvim',
      config = require('config.lspsaga'),
      disable = true,
    }

    use {'m-pilia/vim-ccls'}
    use {'roxma/vim-tmux-clipboard'}

    use {"simrat39/symbols-outline.nvim"}

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = require('config.gitsigns')
    }

    -- Git blamer
    use {
      'APZelos/blamer.nvim',
      config = require('config.blamer')
    }

    -- Comments
    use {
      "terrortylor/nvim-comment",
      cmd = "CommentToggle",
      config = require('config.nvim-comment')
    }

    -- Show indent line
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      setup = require('config.indent-blankline'),
      disable = false,
    }

    use {
      'editorconfig/editorconfig-vim',
      event = "BufRead",
      setup = require('config.editorconfig-vim')
    }

    use {
      'ntpeters/vim-better-whitespace',
      event = "BufRead",
      setup = require('config.vim-better-whitespace'),
      disable = false,
    }

    -- Autocomplete
    use {
      'hrsh7th/vim-vsnip',
      config = require('config.vim-vsnip')
    }

    use {
      "hrsh7th/nvim-compe",
      requires = {
        'hrsh7th/vim-vsnip',
        'hrsh7th/vim-vsnip-integ',
        'rafamadriz/friendly-snippets',
      },
      config = require('config.nvim-compe')
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }

    -- Autopairs
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      after = { "nvim-compe" },
      config = require('config.nvim-autopairs')
    }

    use {
      'rhysd/vim-clang-format',
      setup = require('config.vim-clang-format')
    }

    -- file trees
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = require('config.nvim-tree')
    }

    use {
      "akinsho/nvim-toggleterm.lua",
      config = require('config.nvim-toggleterm')
    }

    -- Ranger
    use {
      'kevinhwang91/rnvimr',
      run = ':make sync',
      config = require('config.rnvimr')
    }

    use {
      'phaazon/hop.nvim',
      as = 'hop',
      config = require('config.hop')
    }
  end
)
