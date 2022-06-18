let g:mapleader=","

"" move betwen tab windows
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <silent> <S-t> :tabnew<CR>
noremap <leader>c :ene <CR>:bp<CR>
noremap <leader>d  :bp<bar>sp<bar>bn<bar>bd<CR>
noremap <leader>snw :set nowrap
noremap <leader>sw :set wrap

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
nnoremap <silent> <leader><space> :nohlsearch<CR>
" redimension windown
nnoremap <silent> <Leader>+ :vertical resize +5 <CR>
nnoremap <silent> <Leader>- :vertical resize -5 <CR>
" words move {{{
cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>
vnoremap <silent> <C-K> :m '<-2<CR>gv=gv
vnoremap <silent> <C-J> :m '>+1<CR>gv=gv

nmap <silent> XX :quitall<CR>

" list buffers
nnoremap <silent> <leader>b :Buffers<CR>

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"sort
vnoremap <silent> <C-O> :sort<CR>

"Column
vnoremap <silent> <leader>ft :column --table<CR>
" select all {{{
map <Leader>sa ggVG


" 
nnoremap <leader>kp :let @*=expand("%")<CR>
"cursor keys

"" Abbreviations
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

" EasyMotion
nmap <Leader>s <Plug>(easymotion-s2)

nnoremap <Leader>v :e $MYVIMRC<cr>
nnoremap <Leader><Leader>r :call ReloadConfig()<cr>
