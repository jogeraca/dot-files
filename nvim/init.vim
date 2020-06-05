scriptencoding utf-8
set fileencoding=utf8

let $vimdir="~/.config/nvim"
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


source $vimdir/plugins.vim
call plug#end()

filetype on
filetype indent on
filetype plugin on

source $vimdir/settings.vim
source $vimdir/bindings.vim
