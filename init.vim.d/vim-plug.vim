" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim  --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Tagbar
Plug 'majutsushi/tagbar'

" NERDTree
Plug 'scrooloose/nerdtree'

" NERDCommenter
Plug 'scrooloose/nerdcommenter'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Ack
Plug 'mileszs/ack.vim'

" Tags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" Cmake
Plug 'vhdirk/vim-cmake'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code snipperts
Plug 'honza/vim-snippets'

" Clang-Format
Plug 'rhysd/vim-clang-format'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" GitGutter
Plug 'airblade/vim-gitgutter'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Rainbow
Plug 'luochen1990/rainbow'

" Vim Wiki
Plug 'vimwiki/vimwiki'

" Replace nerw with Ranger
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" Man pages
" Plug 'vim-utils/vim-man'

" Multiple cursors
" Plug 'terryma/vim-multiple-cursors'

" Tmux imtegration
" Plug 'edkolev/tmuxline.vim'

" C/C++ highlighting
Plug 'bfrg/vim-cpp-modern'

" Material colorscheme
Plug 'kaicataldo/material.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

"Plug '~/.local/share/nvim/plugged/mixed'

Plug 'trotux/mixed'

Plug 'norcalli/nvim-colorizer.lua'

" See what keys do like in emacs
Plug 'liuchengxu/vim-which-key'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Terminal
Plug 'voldikss/vim-floaterm'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
