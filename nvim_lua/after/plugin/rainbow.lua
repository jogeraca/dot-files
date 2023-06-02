
	-- \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
vim.cmd[[
	let g:rainbow_conf = {
	\	'guifgs': ['#61afef', '#e5c07b', '#c678dd', '#56b6c2', '#be5046', '#d19a66', '#98c379'],
 \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'guis': [''],
	\	'cterms': [''],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'elixir': {
 \			'parentheses': ['start=/do/ end=/end/', 'start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold']
\ },
	\   'markdown': {'parentheses_options': 'containedin=markdownCode contained'},
	\		'vim': {'parentheses_options': 'containedin=vimFuncBody'},
	\		'css': 0,
	\		'nerdtree': 0
	\	}
	\	}
]]
-- \			'parentheses': ['start=/do/ end=/end/', 'start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold']
-- vim.cmd([[
--   autocmd FileType elixir let g:rainbow_conf = {
--     \ 'extended_mode': 1,
--     \ 'colors': ['#FBC7FC', '#AEEEEE', '#F0E68C', '#FA8072', '#C0C0C0', '#FFFFFF'],
-- 	  \ 'parentheses': [
--       \   'start=;(; end=;); fold',
--       \   'start=;\[; end=;\]; fold',
--       \   'start=;{; end=;}; fold',
--       \   'start=;\(\s\|^\)\(do\|fn\)\(\s\|$\); ' .
--       \   'step=;\(\s\|^\)\(->\|catch\|rescue\|after\|else\)\(\s\|$\); ' .
--       \   'end=;\(\s\|^\)end; ' .
--       \   'fold'
--       \ ]
	--       \}
-- ]])
	--
	--   parentheses = {"()", "[]", "{}"}
