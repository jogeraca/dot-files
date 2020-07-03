" vim:set et sw=2 ts=2 fdm=marker fdl=1:
scriptencoding utf-8
set fileencoding=utf8

let $vimdir="~/.config/nvim"
let s:scriptPath = expand('<sfile>:p:h')
let s:sourceList = [
	\ 'plugins',
	\ 'settings',
	\ 'bindings',
	\ ]

for s:item in s:sourceList
	exec 'source ' . s:scriptPath . '/viml/' . s:item . '.vim'
endfor

unlet s:scriptPath
unlet s:sourceList 

filetype on
filetype indent on
filetype plugin on

