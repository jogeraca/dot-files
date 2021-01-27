" vim:set et sw=2 ts=2 fdm=marker fdl=1:

" General
scriptencoding utf-8

set encoding=utf-8

syntax on
set colorcolumn=90  " Color colum to limit coding length
set undofile        " Maintain undo history between sessions
"set undodir=~/.vim/undodir
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

" paste mode
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
set smartcase
set ignorecase
set incsearch
set ws! ws?

" mouse
set mouse+=a
set mousemodel=popup
set mousehide

" spaceline
set list
set listchars=tab:▸\ ,nbsp:␣,trail:·,extends:>,precedes:<,eol:¬

" window scroll {{{}
 set winminheight=0
 set scrolloff=3
 set splitright
 " }}}

"
"set t_Co=256
"set guioptions=egmrti
"set gfn=Monospace 10
"" Disable the blinking cursor.
"set gcr=a:blinkon0
""" Use modeline overrides
"set modeline
"set modelines=10

"" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent "syntax    fold based on syntax
set foldlevel=1
" }}}
"
if system('uname -s') == "Linux\n"
  " Wayland clipboard
  xnoremap Y Y:!wl-copy <C-r>"<cr><cr>gv
  nnoremap "P :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
  nnoremap "*P :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
  set clipboard=unnamedplus
endif

"let g:ruby_host_prog = '~/.gem/ruby/2.7.0/bin/neovim-ruby-host'
"set listchars=tab:›\ ,trail:-,extends:#,nbsp:.
"
if has('python')
   set pyx=3
endif

if has('nvim-0.5')
  augroup vimrcEx
    autocmd!

    " Open to last line after close
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " Set syntax highlighting
    autocmd BufNewFile,BufRead Procfile,Brewfile setf ruby
    autocmd BufNewFile,BufRead *.md setf markdown
    autocmd BufNewFile,BufRead *.drab setf eelixir
    autocmd BufNewFile,BufRead *.arb setf ruby
    autocmd BufNewFile,BufRead irbrc,pryrc setf ruby

    autocmd BufEnter * lua require('completion').on_attach()
    " autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
    " autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
    " autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

    " JSON w/ comments
    autocmd BufNewFile,BufRead *.jsonc setf json
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " Remove trailing whitespace on save
    autocmd BufWritePre * :%s/\s\+$//e

    " Resize panes when window resizes
    autocmd VimResized * :wincmd =
  augroup END
endif
