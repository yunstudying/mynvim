function! Opennerdtree()

	" 加载文件
	if !exists("g:NERDTree")

		execute "packadd nerdtree"

		let g:NERDTreeDirArrows=1    " Display arrows instead of ascii art in NERDTree
		let g:NERDTreeChDirMode=2    " Change current working directory based on root directory in NERDTree
		let g:NERDTreeHidden=1     " Don't show hidden files
		let g:NERDTreeWinSize=25     " Initial NERDTree width
		let g:NERDTreeAutoDeleteBuffer = 1  " Auto delete buffer deleted with NerdTree

		" 定义 Nerdtree 的图标
		let g:NERDTreeDirArrowExpandable = '▸'
		let g:NERDTreeDirArrowCollapsible = '▾'

		" 防止目录被内容覆盖
		autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
					\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


		" 当NERDTree窗口是最后一个窗口时自动关闭
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
					\ b:NERDTree.isTabTree()) | q | endif

		" 隐藏一些文件
		let g:NERDTreeIgnore = ['\.pyc$', '__pycache__','\.zip$','\.bz2$','\.gz$','\.xz$']

		" 最简界面
		let g:NERDTreeMinimalUI=1
	endif

	execute ":NERDTreeToggle"
endfunction

" 快捷键
map <silent> <F1> :call Opennerdtree()<CR>

