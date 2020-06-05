" the prefix to use for leader commands

if has('nvim')
    call plug#begin(stdpath('data') . '/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

Plug 'elixir-lsp/elixir-ls', { 'for': ['elixir','eelixir'],'do': { -> g:ElixirLS.compile() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'jremmen/vim-ripgrep'
Plug 'morhetz/gruvbox'
" Utils
Plug 'wakatime/vim-wakatime'
"Plug 'tpope/vim-obsession'
Plug 'mbbill/undotree'
" Git support
Plug 'tpope/vim-fugitive'
" Programing            

Plug 'elixir-lang/vim-elixir' " elixir 
"Plug 'jimenezrick/vimerl' " erlang


call plug#end()

