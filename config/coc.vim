let g:coc_global_extensions = [
			\ 'coc-css',
			\ 'coc-html',
			\ 'coc-diagnostic',
			\ 'coc-eslint',
			\ 'coc-explorer',
			\ 'coc-flutter-tools',
			\ 'coc-gitignore',
			\ 'coc-json',
			\ 'coc-lists',
			\ 'coc-prettier',
			\ 'coc-prisma',
			\ 'coc-pyright',
			\ 'coc-python',
			\ 'coc-snippets',
			\ 'coc-sourcekit',
			\ 'coc-stylelint',
			\ 'coc-syntax',
			\ 'coc-tailwindcss',
			\ 'coc-tasks',
			\ 'coc-translator',
			\ 'coc-tslint-plugin',
			\ 'coc-tsserver',
			\ 'coc-vimlsp',
			\ 'coc-yaml',
			\ 'coc-marketplace',
			\ 'coc-pairs',
			\ 'coc-yank']


" 提高响应速度
set updatetime=100

" tab 补全
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 在 auto-select 下键入回车时，选择第一个
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 查看 vim 指令的帮助
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" 光标定义到某个单词时，高亮显示
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=0 Prettier :CocCommand prettier.formatFile

