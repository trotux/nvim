" ----------------------------------------------------------
"  Plugins install
"
"-----------------------------------------------------------

source $HOME/.config/nvim/init.vim.d/vim-plug.vim

" ----------------------------------------------------------
"  Plugins settings
"
"-----------------------------------------------------------

" NERDTree
let g:NERDTreeShowHidden=1
nmap <silent> <F7> :NERDTreeToggle<CR>
nmap <silent> <F6> :NERDTreeTabsToggle<CR>

" NERDCommenter
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#branch#enabled = 1

" Clang-Format
let g:clang_format#command = '/usr/bin/clang-format-10'
" autocmd FileType c ClangFormatAutoEnable

" EditorConfig
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" GitGutter
let g:gitgutter_override_sign_column_highlight = 1

" Rainbow
let g:rainbow_active = 0

" VimWiki
let g:vimwiki_list = [ { 'path': '~/.dotfiles/cfg/vimwiki',
                       \ 'path_html': '~/.dotfiles/html' } ]

" Easy tags
" let g:easytags_cmd = '/usr/bin/ctags'

source $HOME/.config/nvim/init.vim.d/which-key.vim
source $HOME/.config/nvim/init.vim.d/fzf.vim
source $HOME/.config/nvim/init.vim.d/floaterm.vim
source $HOME/.config/nvim/init.vim.d/coc.vim
source $HOME/.config/nvim/init.vim.d/tagbar.vim

" ----------------------------------------------------------
" " Vim settings
" ----------------------------------------------------------
" Disable vi compatibility.
set nocompatible
filetype plugin on

" Reduce refresh time
set updatetime=250

" use additional .vimrc
set exrc
set secure

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if (has("termguicolors"))
  set termguicolors
endif

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"luafile $HOME/.config/nvim/lua/plug-colorizer.lua

" Switch on syntax highlighting.
syntax on
set syntax=whitespace

" 256 colours
set  t_Co=256
"set background=color
set background=dark
" colorscheme xoria256
colorscheme mixed
" colorscheme hybrid_material
"highlight ColorColumn ctermbg=none

" Tabstops are 8 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set smartindent " Умные отступы (например, автоотступ после {)

" Automatically indent
set autoindent
" Remove unsed white spaces set shiftround

" set the search scan to wrap lines
set wrapscan

" Make command line two lines high
set ch=2

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=cesB$

" Show 'invisibles'
set list

" Set the status line
set statusline=%<%f%h%m%r%=\ %l,%c%V

" Always show status line
set laststatus=2

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8
" set scrolloff=999

" Show cursor all the time
set ruler

" Highlight the line where cursor set cursorline
set cursorline

" Show uncompleted commands in status bar
set showcmd

" Don't remove buffer when we switch to next
set hidden

" Show the current mode
set showmode

" Allow the cursor to go in to 'invalid' places
set virtualedit=all

" Make the command-line completion better
set wildmenu

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" set the search scan so that it ignores case when the search is all lower
" case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" Incrementally match the search
set incsearch

" Stop searching at the end of file
set nowrapscan

" add some line space for easy reading
set linespace=1

" Highlight 80 column
if exists('+colorcolumn')
    highlight ColorColumn ctermbg=235 guibg=#2c2d27
    highlight CursorLine ctermbg=235 guibg=#2c2d27
    highlight CursorColumn ctermbg=235 guibg=#2c2d27
    let &colorcolumn=join(range(81,999),",")
else
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
end

" Set width to 80 colums
set textwidth=80

" Turn off line wrap
set nowrap
set formatoptions-=t

" Breaking lines without breaking them
set linebreak

" Default encoding
set termencoding=utf-8

" Default encoding
set encoding=utf8

" Turn On Xclipboard
"set clipboard+=unnamed  " On xclipboard
set clipboard^=unnamed,unnamedplus
set virtualedit=all     " On Virtual Edit for all modes
set go+=a               " Vim select copy selected to clipboard

" Enable search highlighting
set hlsearch

" Show matching brackets.
set showmatch

" Bracket blinking.
set matchtime=5

" Line numbers off
set number

" No blinking
set novisualbell

" No noise.
set noerrorbells

" disable any beeps or flashes on error
set vb t_vb=

set foldenable " Turn on folding
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
set foldlevel=1 " closed fold by default

" Turn off backup files
set nobackup
set nowritebackup

" Turn off swap files
set noswapfile

" Auto change the directory to the current file I'm working on
" autocmd BufEnter * lcd %:p:h

set splitbelow
set splitright

" Fix CVE-2019-12735
set nomodeline

" Makes popup menu smaller
set pumheight=10

let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
let g:miniBufExplMaxSize = 1 " <max lines: defualt 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers.

" Tab at the end of line
if has('multi_byte')

    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59

    if version >= 700
        set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
    else
        set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
    endif
endif

" Symbol before wrapped line
if has("linebreak")
    let &sbr = nr2char(8618).' ' " Show ↪ at the beginning of wrapped lines
endif

" Set up the GVim window colors and size
if has("gui_running")
    set guifont=Ubuntu\Mono\ 14
    if !exists("g:vimrcloaded")
        winpos 0 0
        if ! &diff
            winsize 130 90
        else
            winsize 227 90
        endif
        let g:vimrcloaded = 1
    endif

    " Set up the gui cursor to look nice
    set guicursor=n-v-c:block-Cursor-blinkon0
    set guicursor+=ve:ver35-Cursor
    set guicursor+=o:hor50-Cursor
    set guicursor+=i-ci:ver25-Cursor
    set guicursor+=r-cr:hor20-Cursor
    set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

    " set the gui options
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar"
endif

" Save cursor position when changing split
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" Remove whitespaces from all file
function! TrimWhitespace()
    %s/\s\+$//e
endfunction
command! TrimWhitespace call TrimWhitespace()

" Remove multiple blank lines from all file
function! DeleteMultiplyBlankLines()
    %s/\n\{3,}/\r\r/e
endfunction
command! DeleteMultiplyBlankLines call DeleteMultiplyBlankLines()

autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

nmap <A-S-p> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Find && Replace in all opened buffers
" http://vim.wikia.com/wiki/VimTip382
function! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/gce'
    :unlet! s:word
endfunction
map <Leader>r :call Replace()<CR>

" ----------------------------------------------------------
" " Mappings
" ----------------------------------------------------------

" pressing ; will go into command mode
" nnoremap ; :

" Leader key
let mapleader = "\\"

nnoremap <bs> X

" Disable the F1 key (which normally opens help)
" coz I hit it accidentally.
noremap <F1> <nop>

nmap <C-s> :update<CR>
vmap <C-s> <Esc><C-s>gv
imap <C-s> <C-o><C-s>

nmap <F2> :update<CR>
vmap <F2> <Esc><F2>gv
imap <F2> <c-o><F2>

nnoremap <F5> :buffers<CR>:buffer<Space>
inoremap <F5> <Esc>:buffers<CR>:buffer<Space>
vnoremap <F5> <Esc>:buffers<CR>:buffer<Space>

" Ctrl-P \ Ctrl-N for next\prev buffers
nnoremap <silent> <C-P> :bp<cr>
nnoremap <silent> <C-N> :bn<cr>
" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Use ctrl-h/j/k/l to switch between splits
nnoremap <A-Right> <C-W><Right>
nnoremap <A-Left> <C-W><Left>
nnoremap <A-Up> <C-W><Up>
nnoremap <A-Down> <C-W><Down>
inoremap <A-Right> <Esc><C-W><Right>
inoremap <A-Left> <Esc><C-W><Left>
inoremap <A-Up> <Esc><C-W><Up>
inoremap <A-Down> <Esc><C-W><Down>

" Use alt + hjkl to resize windows
nnoremap <A-j>    :resize -2<CR>
nnoremap <A-k>    :resize +2<CR>
nnoremap <A-h>    :vertical resize -2<CR>
nnoremap <A-l>    :vertical resize +2<CR>

" Tabs
" map <S-TAB> :tabprevious<CR>
nnoremap <C-z> :tabprevious<CR>
inoremap <C-z> <Esc>:tabprevious<CR>i
" map <C-TAB> :tabnext<CR>
nnoremap <C-x> :tabnext<CR>
inoremap <C-x> <Esc>:tabnext<CR>i

nmap <Leader>n :tabnew<CR>
nmap <Leader>w :tabclose<CR>

" ,cd to change pwd to current file dir
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" C-c and C-v - Copy/Paste using global clipboard
vmap <C-C> <esc> "+yi
imap <C-V> <esc>"+gPi

" Shift-Insert like xterm
map <S-Insert> <MiddleMouse>

" F8 - show/hide strings numeration
imap <F8> <Esc>:set<Space>nu!<CR>a
nmap <F8> :set<Space>nu!<CR>
nmap <Leader>l :set<Space>nu!<CR>

" show/Hide hidden Chars
"map <silent> <F12> :set invlist<CR>
"map <silent> <C-l> :set invlist<CR>
imap <F9> <Esc>:set<Space>invlist<CR>a
nmap <F9> :set<Space>invlist<CR>
map <silent> ,l :set invlist<CR>
nmap <Leader>c :set<Space>invlist<CR>

" <Esc><Esc>
" Clear the search highlight in Normal mode
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Fast grep
" grep in current dir by word under cursor
map <Leader>f :execute "Ack " . expand("<cword>") <Bar> cw<CR>

nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>


" Moving between splits with Ctrl-H\J\K\L
" map <C-H> <C-W>h
" map <C-J> <C-W>j
" map <C-K> <C-W>k
" map <C-L> <C-W>l

" 'Centered' search results
" nmap n nzz
" nmap N Nzz
" nmap * *zz
" nmap # #zz
" nmap g* g*zz
" nmap g# g#zz

" Don't skip wrap lines
" noremap j gj
" noremap k gk

" Space for open/close folds if exist
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"nmap yr :call system("ssh $machineA_IP pbcopy", @*)<CR>

" nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
" nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
" nnoremap <C-k> dd

