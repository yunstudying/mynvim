if &compatible
	" vint: -ProhibitSetNoCompatible
	set nocompatible
	" vint: +ProhibitSetNoCompatible
endif

" Disable vim distribution plugins
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:python3_host_prog="/usr/bin/python3"


if has('vim_starting')
	" Global Mappings "{{{
	" Use spacebar as leader and ; as secondary-leader
	" Required before loading plugins!
	let g:mapleader="\<Space>"
	let g:maplocalleader=';'

	" Release keymappings prefixes, evict entirely for use of plug-ins.
	nnoremap <Space>  <Nop>
	xnoremap <Space>  <Nop>
	nnoremap ,        <Nop>
	xnoremap ,        <Nop>
	nnoremap ;        <Nop>
	xnoremap ;        <Nop>

endif


" .config/nvim
let $VIM_PATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

execute 'source' $VIM_PATH.'/config/settings.vim'
execute 'source' $VIM_PATH.'/config/keys.vim'
execute 'source' $VIM_PATH.'/config/themes.vim'
execute 'source' $VIM_PATH.'/config/nerdtree.vim'
execute 'source' $VIM_PATH.'/config/edit.vim'
execute 'source' $VIM_PATH.'/config/coc.vim'
execute 'source' $VIM_PATH.'/config/search.vim'
execute 'source' $VIM_PATH.'/config/floaterm.vim'
