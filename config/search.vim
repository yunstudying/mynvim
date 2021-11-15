function! Ranger()
	if !exists('g:ranger')
		let g:ranger = 1
		execute "packadd rnvimr"

		let g:rnvimr_ex_enable = 1
	endif

	execute "RnvimrToggle"
endfunction

function! Fzf(name)
	if !exists("g:fzf_flag")
		let g:fzf_flag = 1
		execute "packadd fzf.vim"
		execute "packadd fzf"
		execute "packadd vim-rooter"

		let g:fzf_preview_window = 'right:60%'
		let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
		let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
	endif

	execute a:name
endfunction

function! Leaderf()
	if !exists('g:leaderf')
		let g:leaderf = 1
		execute "packadd LeaderF"
		execute "packadd vim-rooter"

		let g:Lf_PreviewInPopup = 1
		let g:Lf_PreviewCode = 1
		let g:Lf_ShowHidden = 1
		let g:Lf_ShowDevIcons = 0
		let g:Lf_CommandMap = {
					\   '<C-]>': ['<C-v>'],
					\   '<C-p>': ['<C-n>'],
					\}
		let g:Lf_UseVersionControlTool = 0
		let g:Lf_IgnoreCurrentBufferName = 1
		let g:Lf_WildIgnore = {
					\ 'dir': ['.git', 'vendor', 'node_modules'],
					\ 'file': ['__vim_project_root', 'class']
					\}
		let g:Lf_UseMemoryCache = 0
		let g:Lf_UseCache = 0
	endif

	execute "Leaderf file"
endfunction

function! ShowTags()
	if !exists('g:show_tags')
		let g:show_tags = 1
		execute "packadd vista.vim"

		function! NearestMethodOrFunction() abort
			return get(b:, 'vista_nearest_method_or_function', '')
		endfunction

		set statusline+=%{NearestMethodOrFunction()}

		" By default vista.vim never run if you don't call it explicitly.
		"
		" If you want to show the nearest function in your statusline automatically,
		" you can add the following line to your vimrc
		autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

		let g:lightline = {
					\ 'colorscheme': 'wombat',
					\ 'active': {
						\   'left': [ [ 'mode', 'paste' ],
						\             [ 'readonly', 'filename', 'modified', 'method' ] ]
						\ },
						\ 'component_function': {
							\   'method': 'NearestMethodOrFunction'
							\ },
							\ }
	endif

	execute "Vista!!"
endfunction

nmap <silent> <F12> :call Ranger()<CR>


noremap <silent> <C-f> :call Leaderf()<CR>
noremap <silent> <C-g> :call Fzf("Rg")<CR>
noremap <silent> <C-t> :call Fzf("Tags")<CR>

noremap <silent> <F10> :call ShowTags()<CR>



