" General 
syntax on
set colorcolumn=90  " Color colum to limit coding length
set undofile        " Maintain undo history between sessions
set undodir=~/.vim/undodir
set undolevels=1000

" Numbers
set number
set relativenumber
"set numberwidth=3   " keep the line number gutter narrow

" Enable hidden buffers
set nocompatible
set hidden
set history=1000
set showtabline=2             " tab bar is always on 
set signcolumn=yes            " always draw the sign column
set linebreak

" status bar
set laststatus=2

" Tabs
set autoindent
set copyindent
set expandtab
set tabstop=4 
set softtabstop=4
set shiftwidth=2
set smartindent
set smarttab
set pastetoggle=<F7>		 " when in insert mode, press <F2> to go to
                             " pasete mode, where you can paste mass data
                             " that won't be autoindent

set nobackup
set nowritebackup
set noswapfile

" UI Config {{{
set showcmd         " show command in bottom bar
set cursorline      " highlight current line
set termguicolors
filetype indent on  " load filetype-specific index files

" search
set incsearch
set ignorecase
set incsearch
set ws! ws?

"set smartcase
"set list
"set listchars=tab:▸\ ,nbsp:␣,trail:·,extends:>,precedes:<,eol:¬
"set t_Co=256
"set guioptions=egmrti
"set gfn=Monospace 10
"" Disable the blinking cursor.
"set gcr=a:blinkon0
"set scrolloff=3
""" Use modeline overrides
"set modeline
"set modelines=10
"" Folding {{{
"set foldenable          " enable folding
"set foldlevelstart=10   " open most folds by default
"set foldnestmax=10      " 10 nested fold max
"set foldmethod=indent "syntax    fold based on syntax
"set foldlevel=1

" Wayland clipboard
xnoremap Y Y:!wl-copy <C-r>"<cr><cr>gv
nnoremap "P :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*P :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

set clipboard=unnamedplus

let g:ruby_host_prog = '~/.gem/ruby/2.7.0/bin/neovim-ruby-host'

