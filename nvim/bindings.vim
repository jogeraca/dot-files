let g:mapleader=","

set mouse=a
set mousemodel=popup

"" move betwen tab windows
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <silent> <S-t> :tabnew<CR>
noremap <leader>c :bd<CR>



"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
nnoremap <silent> <leader><space> :nohlsearch<CR>

nnoremap <silent> <Leader>+ :vertical resize +5 <CR>
nnoremap <silent> <Leader>- :vertical resize -5 <CR>

nnoremap <silent> <leader>b :Buffers<CR>

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

