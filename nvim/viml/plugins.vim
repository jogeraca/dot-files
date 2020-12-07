" vim:set et sw=2 ts=2 fdm=marker fdl=1:
" 
" the prefix to use for leader commands
"
scriptencoding utf-8
if has('nvim')
    let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
    call plug#begin(stdpath('data') . '/plugged')
else
    let vimplug_exists=expand('~/.vim/autoload/plug.vim')
    call plug#begin('~/.vim/plugged')
endif


if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif


Plug 'elixir-lsp/elixir-ls', { 'for': ['elixir','eelixir'],'do': { -> g:ElixirLS.compile() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'jremmen/vim-ripgrep'
"Themes
Plug 'morhetz/gruvbox'
" Utils
"Plug 'wakatime/vim-wakatime'
Plug 'Yggdroot/indentLine'
"Plug 'tpope/vim-obsession'
Plug 'mbbill/undotree'
" Git support
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'andreshazard/vim-freemarker'
" Programing            
"Plug 'jimenezrick/vimerl' " erlang
call plug#end()



