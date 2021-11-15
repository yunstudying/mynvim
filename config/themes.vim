" onedark.vim 
" {{{
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

syntax on
colorscheme onedark


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
"""}}}


""" lightline.vim
""" {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
"""}}}


""" buffet.vim
""" {{{
let g:lightline.enable = {
                    \ 'statusline': 1,
                    \ 'tabline': 0
                    \ }


let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "🌞"
let g:lightline.colorscheme = 'one'


" 显示缓冲区的编号
let g:buffet_show_index = 1
let g:buffet_index_type = "index" " default
let g:buffet_index_type = "number" " shows number INSTEAD of indexes
let g:buffet_show_number = 1 " 0 is default


" 状态栏上色
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#98C379 guifg=#000000
  hi! BuffetTab cterm=NONE ctermbg=5 ctermfg=8 guibg=#2572BF guifg=#000000

  hi! BuffetActiveBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#98C379 guifg=#000000
  hi! BuffetBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#2C323C guifg=#FFF

endfunction
""" }}}


"" vim-startify
""" {{{
"会话保存的位置
let g:startify_session_dir = '~/.config/nvim/session'

" 定义菜单的格式
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
""" }}}
