"Gruvbox-material configuration
"
"

"Python define custom colorss
"#highlight pythonImport gui=italic
"#highlight pythonConditional term=italic

"hi Keyword   guifg=#8ac6f2 gui=italic
"hi Constant 		guifg=#e5786d gui=none
"hi Function guifg=#cae682 gui=none
"#hi Keyword  guifg=#8ac6f2 gui=italic
"hi Identifier guifg=#cae682 gui=italic
""#hi Error cterm=underline gui=underline
"highlight Keyword gui=italic cterm=italic
"hi Todo 		guifg=#yellow gui=italic
"
"


"colorscheme gruvbox-material
"let g:lightline.colorscheme = 'gruvbox_material'
"let g:gruvbox_material_background="hard"
"let g:gruvbox_material_enable_bold=1
"let g:gruvbox_material_visual = 'reverse'
"let g:gruvbox_material_transparent_background=1
"let g:gruvbox_material_enable_italic=1
"let g:gruvbox_material_disable_italic_comment=1
"let g:gruvbox_material_cursor = 'green'
"

augroup GruvboxMaterialCustom
   autocmd!
   autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END

function! s:gruvbox_material_custom() abort
   " Link a highlight group to a predefined highlight group.
   " See `colors/gruvbox-material.vim` for all predefined highlight groups.
   
  "" highlight! link pythonTodo
   
   " Initialize the color palette.

   let g:gruvbox_material_background = 'hard'
   let g:gruvbox_material_palette = 'mix'
   " Define a highlight group.
   " The first parameter is the name of a highlight group,
   " the second parameter is the foreground color,
   " the third parameter is the background color,
   " the fourth parameter is for UI highlighting which is optional,
   " and the last parameter is for `guisp` which is also optional.
   " See `autoload/gruvbox_material.vim` for the format of `l:palette`.
   "
   "Note: to get the name highlight group execute:   `exe 'hi '.synIDattr(synstack(line('.'), col('.'))[-1], 'name')`"
  ""# call gruvbox_material#highlight('elixirKeyword', l:palette.red, l:palette.none, 'italic')
endfunction


let g:gruvbox_material_background="hard"
let g:gruvbox_material_enable_bold=1
let g:gruvbox_material_visual = 'reverse'
let g:gruvbox_material_enable_italic=1
let g:gruvbox_material_disable_italic_comment=1

let g:gruvbox_material_cursor = 'purple'
colorscheme gruvbox-material
