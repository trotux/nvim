vim.cmd [[
try
  colorscheme mixed
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
