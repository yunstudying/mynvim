function! Autofor()

	if !exists("g:autoformat")
		let g:autoformat = 1
		execute "packadd vim-autoformat"
	endif

	execute ":Autoformat"
endfunction

function! Comment()
	if !exists('g:commentary')
		let g:commentary = 1
		execute "packadd vim-commentary"
	endif
	execute ":Commentary"
endfunction

" 自动保存
noremap <silent> <C-s> :call Autofor()<CR>:w<CR>
inoremap <silent> <C-s> <esc>:call Autofor()<CR>:w<CR>

" 代码注释
nnoremap <silent> <a-/> :call Comment()<CR>


let g:surround_no_mappings = 1
xmap S   <Plug>VSurround
nmap ds  <Plug>Dsurround

" 可视化模式下给单词添加符号
vmap <a-"> S"
vmap <a-'> S'
vmap <a-{> S{
vmap <a-(> S(
vmap <a-[> S[


" 可视化模式下删除符号
nmap <a-"> ds"
nmap <a-'> ds'
nmap <a-{> ds{
nmap <a-(> ds(
nmap <a-[> ds[

