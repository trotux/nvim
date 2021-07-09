" Vim color file
"
" Name:       mixed.vim
" Version:    0.1
" Maintainer:  Anatoly Nikulin  (trotux) <trotux@gmail.com>
"
" Color numbers (0-255) see:
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
"

" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='mixed'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:mixed_guisp_fallback') || index(['fg', 'bg'], g:mixed_guisp_fallback) == -1
  let g:mixed_guisp_fallback='NONE'
endif

if !exists('g:mixed_improved_strings')
  let g:mixed_improved_strings=0
endif

if !exists('g:mixed_function_bold')
  let g:mixed_function_bold=0
endif

let s:is_dark=(&background == 'dark')


"}}}

" Setup Emphasis: {{{

let s:bold = 'bold,'
"if g:xoria256_bold == 0
  "let s:bold = ''
"endif

let s:italic = 'italic,'
"if g:xoria256_italic == 0
  "let s:italic = ''
"endif

let s:underline = 'underline,'
"if g:xoria256_underline == 0
  "let s:underline = ''
"endif

let s:undercurl = 'undercurl,'
"if g:xoria256_undercurl == 0
  "let s:undercurl = ''
"endif

let s:inverse = 'inverse,'
"if g:xoria256_inverse == 0
  "let s:inverse = ''
"endif

let s:invert_tabline = ''
let s:italicize_comments = ''
let s:invert_signs = s:inverse

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine absolute colors

let s:fg0               = ['#eeeeee', 255 ]
let s:fg1               = ['#d0d0d0', 252 ]
let s:fg2               = ['#b2b2b2', 249 ]
let s:fg3               = ['#9e9e9e', 247 ]
let s:fg4               = ['#3a3a3a', 237 ]

let s:bg0               = ['#000000', 0   ]
let s:bg1               = ['#1c1c1c', 234 ]
let s:bg2               = ['#444444', 238 ]
let s:bg3               = ['#4e4e4e', 239 ]
let s:bg4               = ['#606060', 241 ]
"let s:bg4               = ['#767676', 243 ]

let s:gray_245          = ['#8a8a8a', 245 ]
let s:gray_244          = ['#808080', 244 ]

let s:special_bg1       = ['#5f5f87', 60  ]
let s:special_bg2       = ['#875f87', 96  ]
let s:special_red         = ['#800000', 1   ]

" light colors
let s:light_red         = ['#d78787', 174 ]
let s:light_brown       = ['#d7af87', 180 ]
let s:light_green       = ['#afd787', 150 ]
let s:light_blue        = ['#87afd7', 110 ]
let s:light_aqua        = ['#87d7d7', 116 ]
let s:light_orange      = ['#ffaf00', 214 ]
let s:light_yellow      = ['#ffffaf', 229 ]
let s:light_purple      = ['#af5f87', 132 ]

" Normal colors
let s:normal_red        = ['#cc241d', 124 ]
let s:normal_brown      = ['#c7915b', 173 ]
let s:normal_green      = ['#5fd75f', 77  ]
let s:normal_blue       = ['#5f87df', 68  ]
let s:normal_aqua       = ['#8ec07c', 108 ]
let s:normal_orange     = ['#ff8700', 208 ]
let s:normal_yellow     = ['#ffff00', 221 ]  " #ffff5f #ffff00
let s:normal_purple     = ['#b16286', 132 ]

" Bright colors
let s:bright_red        = ['#fb4934', 167 ]
let s:bright_green      = ['#afff00', 154 ]
let s:bright_blue       = ['#005fff', 27  ]
let s:bright_aqua       = ['#87ffaf', 121 ]
let s:bright_orange     = ['#fe8019', 208 ]
let s:bright_yellow     = ['#fabd2f', 214 ] 
let s:bright_purple     = ['#d3869b', 175 ]

" determine relative colors
let s:gray = s:gray_245

let s:color_column      = s:bg1
let s:color_line        = s:bg1
let s:sign_column       = s:bg1
let s:number_column     = s:none

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:light_red[0]
  let g:terminal_color_9 = s:normal_red[0]

  let g:terminal_color_2 = s:light_green[0]
  let g:terminal_color_10 = s:normal_green[0]

  let g:terminal_color_3 = s:light_yellow[0]
  let g:terminal_color_11 = s:normal_yellow[0]

  let g:terminal_color_4 = s:light_blue[0]
  let g:terminal_color_12 = s:normal_blue[0]

  let g:terminal_color_5 = s:light_purple[0]
  let g:terminal_color_13 = s:normal_purple[0]

  let g:terminal_color_6 = s:light_aqua[0]
  let g:terminal_color_14 = s:normal_aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:mixed_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:mixed_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Mixed Hi Groups: {{{

" memoize common hi groups
call s:HL('MixedFg0', s:fg0)
call s:HL('MixedFg1', s:fg1)
call s:HL('MixedFg2', s:fg2)
call s:HL('MixedFg3', s:fg3)
call s:HL('MixedFg4', s:fg4)
call s:HL('MixedGray', s:gray)

call s:HL('MixedBg0', s:bg0)
call s:HL('MixedBg1', s:bg1)
call s:HL('MixedBg2', s:bg2)
call s:HL('MixedBg3', s:bg3)
call s:HL('MixedBg4', s:bg4)

call s:HL('MixedNormalRedSign', s:normal_red, s:sign_column, s:invert_signs)
call s:HL('MixedNormalGreenSign', s:normal_green, s:sign_column, s:invert_signs)
call s:HL('MixedNormalYellowSign', s:normal_yellow, s:sign_column, s:invert_signs)
call s:HL('MixedNormalBlueSign', s:normal_blue, s:sign_column, s:invert_signs)
call s:HL('MixedNormalPurpleSign', s:normal_purple, s:sign_column, s:invert_signs)
call s:HL('MixedNormalAquaSign', s:normal_aqua, s:sign_column, s:invert_signs)
call s:HL('MixedNormalOrangeSign', s:normal_orange, s:sign_column, s:invert_signs)

call s:HL('MixedLightRedSign', s:light_red, s:sign_column, s:invert_signs)
call s:HL('MixedLightGreenSign', s:light_green, s:sign_column, s:invert_signs)
call s:HL('MixedLightYellowSign', s:light_yellow, s:sign_column, s:invert_signs)
call s:HL('MixedLightBlueSign', s:light_blue, s:sign_column, s:invert_signs)
call s:HL('MixedLightPurpleSign', s:light_purple, s:sign_column, s:invert_signs)
call s:HL('MixedLightAquaSign', s:light_aqua, s:sign_column, s:invert_signs)
call s:HL('MixedLightOrangeSign', s:light_orange, s:sign_column, s:invert_signs)

call s:HL('MixedNormalRed', s:normal_red)
call s:HL('MixedNormalRedBold', s:normal_red, s:none, s:bold)
call s:HL('MixedNormalPurple', s:normal_purple)
call s:HL('MixedNormalPurpleBold', s:normal_purple, s:none, s:bold)
call s:HL('MixedNormalGreen', s:normal_green)
call s:HL('MixedNormalGreenBold', s:normal_green, s:none, s:bold)
call s:HL('MixedNormalBlue', s:normal_blue)
call s:HL('MixedNormalBlueBold', s:normal_blue, s:none, s:bold)
call s:HL('MixedNormalYellow', s:normal_yellow)
call s:HL('MixedNormalYellowBold', s:normal_yellow, s:none, s:bold)
call s:HL('MixedNormalAqua', s:normal_aqua)
call s:HL('MixedNormalAquaBold', s:normal_aqua, s:none, s:bold)
call s:HL('MixedNormalOrange', s:normal_orange)
call s:HL('MixedNormalOrangeBold', s:normal_orange, s:none, s:bold)

call s:HL('MixedLightRed', s:light_red)
call s:HL('MixedLightBrown', s:light_brown, s:none, s:bold)
call s:HL('MixedLightGreen', s:light_green)
call s:HL('MixedLightBlue', s:light_blue)
call s:HL('MixedLightYellow', s:light_yellow)
call s:HL('MixedLightAqua', s:light_aqua)

call s:HL('MixedLightBlueBold', s:light_blue, s:none, s:bold)

call s:HL('MixedBrightGreen', s:bright_green)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg0, s:bg1)

" Correct background
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine', s:none, s:color_line)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:normal_green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:bg0, s:bright_blue, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn', s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:normal_blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:bright_yellow, s:bg1)
endif

call s:HL('SignColumn', s:bg0)

call s:HL('NonText', s:bg2)
call s:HL('SpecialKey', s:bg2)

call s:HL('Visual', s:fg0,  s:special_bg1)
call s:HL('VisualNOS', s:fg0,  s:special_bg2)

call s:HL('Search',    s:bg0, s:light_green, s:inverse)
call s:HL('IncSearch', s:bg0, s:light_purple, s:inverse)

call s:HL('Underlined', s:normal_blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:fg0, s:fg0)

" Current match in wildmenu completion
call s:HL('WildMenu', s:normal_blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory MixedNormalGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title MixedNormalGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:light_yellow, s:normal_red)

" More prompt: -- More --
hi! link MoreMsg MixedNormalYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg MixedNormalYellowBold
" 'Press enter' prompt and yes/no questions
" hi! link Question MixedNormalOrangeBold
hi! link Question MixedLightBrown
" Warning messages
hi! link WarningMsg MixedNormalRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:fg0, s:special_bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:fg3, s:bg1)
let s:number_column = s:none

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" call s:HL('Cursor', s:none, s:cursor)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:normal_red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement MixedLightRed
" if, then, else, endif, swicth, etc.
hi! link Conditional MixedLightRed
" for, do, while, etc.
hi! link Repeat MixedLightRed
" case, default, etc.
hi! link Label MixedLightRed
" try, catch, throw
hi! link Exception MixedLightRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword MixedLightRed

" Variable name
hi! link Identifier MixedlightBlue
" Function name
"if g:mixed_function_bold == 1
"    hi! link Function MixedNormalGreenBold
"else
    hi! link Function MixedLightGreen
"endif

" Generic preprocessor
hi! link PreProc MixedNormalGreen
" Preprocessor #include
hi! link Include MixedNormalGreen
" Preprocessor #define
hi! link Define MixedNormalGreen
" Same as Define
hi! link Macro MixedNormalGreen
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit MixedNormalGreen

" Generic constant
hi! link Constant MixedNormalYellow
" Character constant: 'c', '/n'
hi! link Character MixedNormalRed
" String constant: "this is a string"
hi! link String MixedLightYellow
" Boolean constant: TRUE, false
hi! link Boolean MixedNormalPurple
" Number constant: 234, 0xff
hi! link Number MixedNormalRed
" Floating point constant: 2.3e10
hi! link Float MixedNormalBlue
hi! link Special MixedNormalPurple

" Generic type
hi! link Type MixedLightBlue
" static, register, volatile, etc
hi! link StorageClass MixedNormalBlue
" struct, union, enum, etc.
hi! link Structure MixedNormalBlue
" typedef
hi! link Typedef MixedLightBlue

call s:HL('Ignore', s:fg4)
hi! link Special MixedLightRed

"}}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg0, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg0, s:light_blue)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:normal_red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:normal_green, s:bg0, s:inverse)
call s:HL('DiffChange', s:bg0, s:normal_blue)
call s:HL('DiffText',   s:bg0, s:normal_yellow)

" Alternative setting
call s:HL('DiffChange', s:normal_aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:normal_yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:normal_red)
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:normal_blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:normal_aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:normal_purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" GitGutter: {{{

hi! link GitGutterAdd MixedLightGreenSign
hi! link GitGutterChange MixedLightBlueSign
hi! link GitGutterDelete MixedLightRedSign
hi! link GitGutterChangeDelete MixedNormalAquaSign

" }}}
" NERDTree: {{{

hi! link NERDTreeDir MixedNormalAqua
hi! link NERDTreeDirSlash MixedNormalAqua

hi! link NERDTreeOpenable MixedNormalOrange
hi! link NERDTreeClosable MixedNormalOrange

hi! link NERDTreeFile MixedFg1
hi! link NERDTreeExecFile MixedNormalYellow

hi! link NERDTreeUp MixedGray
hi! link NERDTreeCWD MixedNormalGreen
hi! link NERDTreeHelp MixedFg1

hi! link NERDTreeToggleOn MixedNormalGreen
hi! link NERDTreeToggleOff MixedNormalRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign MixedNormalRedSign
hi! link CocWarningSign MixedNormalOrangeSign
hi! link CocInfoSign MixedNormalYellowSign
hi! link CocHintSign MixedNormalBlueSign
hi! link CocErrorFloat MixedNormalRed
hi! link CocWarningFloat MixedNormalOrange
hi! link CocInfoFloat MixedNormalYellow
hi! link CocHintFloat MixedNormalBlue
hi! link CocDiagnosticsError MixedNormalRed
hi! link CocDiagnosticsWarning MixedNormalOrange
hi! link CocDiagnosticsInfo MixedNormalYellow
hi! link CocDiagnosticsHint MixedNormalBlue

hi! link CocSelectedText MixedNormalRed
hi! link CocCodeLens MixedGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:normal_red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:normal_orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:normal_yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:normal_blue)

" }}}
" Filetype specific -----------------------------------------------------------
" C: {{{

hi! link cOperator  MixedNormalPurple
"hi! link cStructure MixedNormalOrange
hi! link cStatement MixedLightRed
hi! link cConstant MixedNormalGreen

" }}}
" CPP: {{{

hi! link cppStatement MixedNormalRed
hi! link cppAccess MixedLightRed
hi! link cppSTLnamespace MixedLightYellow

" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:normal_aqua, s:none, s:bold . s:italicize_comments)

hi! link vimVar MixedLightBlue
hi! link vimOption MixedLightBlue
hi! link vimNotation MixedNormalOrange
hi! link vimBracket MixedNormalOrange
hi! link vimMapModKey MixedNormalOrange
hi! link vimFuncSID MixedFg3
hi! link vimSetSep MixedFg3
hi! link vimSep MixedFg3
hi! link vimContinue MixedFg3

" }}}

" Other -----------------------------------------------------------------------
" hi Comment      ctermfg=244 guifg=#808080
" stings
" hi Constant     ctermfg=229 guifg=#ffffaf
" hi Identifier   ctermfg=182 guifg=#dfafdf                           cterm=none
" hi Ignore       ctermfg=238 guifg=#444444
" hi Number       ctermfg=180 guifg=#dfaf87
" hi PreProc      ctermfg=150 guifg=#afdf87
" hi Special      ctermfg=174 guifg=#df8787
" hi Statement    ctermfg=110 guifg=#87afdf                           cterm=none gui=none
" hi Type         ctermfg=146 guifg=#afafdf                           cterm=none gui=none
"hi Error        ctermfg=15  guifg=#ffffff ctermbg=1   guibg=#800000
"hi ErrorMsg     ctermfg=15  guifg=#ffffff ctermbg=1   guibg=#800000
"hi FoldColumn   ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212
"hi Folded       ctermfg=255 guifg=#eeeeee ctermbg=60  guibg=#5f5f87
"hi IncSearch    ctermfg=0   guifg=#000000 ctermbg=223 guibg=#ffdfaf cterm=none gui=none
" hi LineNr       ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212
"hi MatchParen   ctermfg=188 guifg=#dfdfdf ctermbg=68  guibg=#5f87df cterm=bold gui=bold
" TODO
" hi MoreMsg

"hi SignColumn   ctermfg=248 guifg=#a8a8a8
"hi SpellBad     ctermfg=160 guifg=fg      ctermbg=bg                cterm=underline               guisp=#df0000
"hi SpellCap     ctermfg=189 guifg=#dfdfff ctermbg=bg  guibg=bg      cterm=underline gui=underline
"hi SpellRare    ctermfg=168 guifg=#df5f87 ctermbg=bg  guibg=bg      cterm=underline gui=underline
"hi SpellLocal   ctermfg=98  guifg=#875fdf ctermbg=bg  guibg=bg      cterm=underline gui=underline
" hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#4e4e4e cterm=bold gui=bold
" hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none
"hi TabLine      ctermfg=fg  guifg=fg      ctermbg=242 guibg=#666666 cterm=none gui=none
"hi TabLineFill  ctermfg=fg  guifg=fg      ctermbg=237 guibg=#3a3a3a cterm=none gui=none
" FIXME
" hi Title        ctermfg=225 guifg=#ffdfff
" hi Todo         ctermfg=0   guifg=#000000 ctermbg=184 guibg=#dfdf00
" hi Underlined   ctermfg=39  guifg=#00afff                           cterm=underline gui=underline
"hi VertSplit    ctermfg=237 guifg=#3a3a3a ctermbg=237 guibg=#3a3a3a cterm=none gui=none
" hi VIsualNOS    ctermfg=24  guifg=#005f87 ctermbg=153 guibg=#afdfff cterm=none gui=none
" hi Visual       ctermfg=24  guifg=#005f87 ctermbg=153 guibg=#afdfff
"hi Visual       ctermfg=255 guifg=#eeeeee ctermbg=96  guibg=#875f87
" hi Visual       ctermfg=255 guifg=#eeeeee ctermbg=24  guibg=#005f87
"hi VisualNOS    ctermfg=255 guifg=#eeeeee ctermbg=60  guibg=#5f5f87
" hi WildMenu     ctermfg=0   guifg=#000000 ctermbg=150 guibg=#afdf87 cterm=bold gui=bold
" Special {{{

"" .diff {{{2
""hi diffAdded    ctermfg=150 guifg=#afdf87
""hi diffRemoved  ctermfg=174 guifg=#df8787
"" }}}

"" vimdiff {{{2
"hi diffAdd      ctermfg=bg  guifg=bg      ctermbg=151 guibg=#afdfaf
""hi diffDelete   ctermfg=bg  guifg=bg      ctermbg=186 guibg=#dfdf87 cterm=none gui=none
"hi diffDelete   ctermfg=bg  guifg=bg      ctermbg=246 guibg=#949494 cterm=none gui=none
"hi diffChange   ctermfg=bg  guifg=bg      ctermbg=181 guibg=#dfafaf
"hi diffText     ctermfg=bg  guifg=bg      ctermbg=174 guibg=#df8787 cterm=none gui=none
"" }}}

"" python {{{2
"hi pythonExceptions ctermfg=174
"" }}}

"" NERDTree {{{2
"hi Directory      ctermfg=110  guifg=#87afdf
"hi treeCWD        ctermfg=180  guifg=#dfaf87
"hi treeClosable   ctermfg=174  guifg=#df8787
"hi treeOpenable   ctermfg=150  guifg=#afdf87
"hi treePart       ctermfg=244  guifg=#808080
"hi treeDirSlash   ctermfg=244  guifg=#808080
"hi treeLink       ctermfg=182  guifg=#dfafdf
"" }}}
"" VimDebug {{{2
" FIXME
" you may want to set SignColumn highlight in your .vimrc
" :help sign
" :help SignColumn

" hi currentLine term=reverse cterm=reverse gui=reverse
" hi breakPoint  term=NONE    cterm=NONE    gui=NONE
" hi empty       term=NONE    cterm=NONE    gui=NONE

" sign define currentLine linehl=currentLine
" sign define breakPoint  linehl=breakPoint  text=>>
" sign define both        linehl=currentLine text=>>
" sign define empty       linehl=empty
"" }}}

" }}}
