" vim:set et sw=2 ts=2 fdm=marker fdl=1:
" 
"
if (!exists('*ReloadConfig'))
    function! ReloadConfig() abort 
        source $MYVIMRC
        for f in split(glob('~/.config/nvim/autoload/*'), '\n')
          exe 'source' f
        endfor
    endfunction
endif
