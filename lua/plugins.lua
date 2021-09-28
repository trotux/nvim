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
    use {
      "romgrk/barbar.nvim",
      requires = {
        'kyazdani42/nvim-web-devicons'
      },
      config = require('config.barbar')
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
      config=require('config.vista')
    }

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
      config = function()
        require("nvim_comment").setup()
      end,
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
      config=require('config.vim-vsnip')
    }

    use {
      "hrsh7th/nvim-compe",
      requires = {
        'hrsh7th/vim-vsnip',
        'hrsh7th/vim-vsnip-integ',
        'rafamadriz/friendly-snippets',
      },
      config=require('config.nvim-compe')
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
      config = function()
        require('config.nvim-autopairs')
      end,
    }

    use {'rhysd/vim-clang-format'}

    -- file trees
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = require('config.nvim-tree')
    }

    -- better LSP UI (for code actions, rename etc.)
    use {
      'glepnir/lspsaga.nvim',
      config=require('config.lspsaga'),
      disable = true,
    }

--[[


  use {
    'm-pilia/vim-ccls',
    config = function()
      require('vim-ccls').setup({})
    end
  }

  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("toggleterm").setup({
        size = 20,
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'float',
        close_on_exit = true, -- close the terminal window when the process exits
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end
  }

  use {"simrat39/symbols-outline.nvim"}

-- Ranger
  use {'kevinhwang91/rnvimr', run = ':make sync'}
]]--

end)
