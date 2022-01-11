local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Plugins configurations
return packer.startup(
  function()
    -- Let packer manage itself
    use {
      'wbthomason/packer.nvim'
    }

    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'axelf4/vim-strip-trailing-whitespace' }
    use { 'kyazdani42/nvim-web-devicons' }

    -- Status line
    use {
      'nvim-lualine/lualine.nvim',
      config = require('config.lualine')
    }

    use {
      'akinsho/bufferline.nvim',
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

    use {
      'filipdutescu/renamer.nvim',
      config = require('config.renamer')
    }

    use {
      'simrat39/symbols-outline.nvim',
      config = require('config.symbols-outline')
    }
    use {'m-pilia/vim-ccls'}

    use {
      'folke/trouble.nvim',
      cmd = 'TroubleToggle',
    }

    -- LSP goto preview
    use {
      'rmagatti/goto-preview',
      config = require('config.goto-preview')
    }

    -- LSP Colors
    use {
      'folke/lsp-colors.nvim',
      event = "BufRead",
    }

    -- LSP CXX colors
    use { 'jackguo380/vim-lsp-cxx-highlight' }

    -- Tagbar
    use {'preservim/tagbar'}

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
      'terrortylor/nvim-comment',
      cmd = "CommentToggle",
      config = require('config.nvim-comment')
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- Show indent line
    use {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
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
      event = 'BufRead',
      setup = require('config.vim-better-whitespace'),
      disable = false,
    }

    -- Autocomplete
    use {
      'hrsh7th/vim-vsnip',
      config = require('config.vim-vsnip')
    }

    use {
      'hrsh7th/nvim-compe',
      requires = {
        'hrsh7th/vim-vsnip',
        'hrsh7th/vim-vsnip-integ',
        'rafamadriz/friendly-snippets',
      },
      config = require('config.nvim-compe')
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate c cpp"
    }

    -- Autopairs
    use {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      after = { "nvim-compe" },
      config = require('config.nvim-autopairs'),
      disable = true
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

    -- Terminal
    use {
      'akinsho/nvim-toggleterm.lua',
      config = require('config.nvim-toggleterm')
    }

    use {'roxma/vim-tmux-clipboard'}

    -- Notification
    use {
      'rcarriga/nvim-notify',
      config = require('config.nvim-notify')
    }

    -- Jump to line number
    use {
      'nacro90/numb.nvim',
      config = require('config.numb')
    }

    -- Registers
    use { 'tversteeg/registers.nvim', keys = { { 'n', '"' }, { 'i', '<c-r>' } } }

    use {
      'phaazon/hop.nvim',
      as = 'hop',
      config = require('config.hop')
    }

    -- VimWiki
    use {
      'vimwiki/vimwiki'
    }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      config = require('config.telescope')
    }

    use { 'tom-anders/telescope-vim-bookmarks.nvim' }
    use { 'nvim-telescope/telescope-media-files.nvim' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'nvim-telescope/telescope-packer.nvim' }
    use { 'ElPiloto/telescope-vimwiki.nvim' }

  end
)
