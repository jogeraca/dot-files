if has('nvim-0.5')
  
  nmap <silent> - :<C-U>call <SID>dirvish_toggle()<CR>
  nmap <silent> <leader>b :call <SID>dirvish_toggle()<CR>

  function! s:dirvish_open(cmd, bg) abort
    let path = getline('.')
    if isdirectory(path)
      if a:cmd ==# 'edit' && a:bg ==# '0'
        call dirvish#open(a:cmd, 0)
      endif
    else
      if a:bg
        call dirvish#open(a:cmd, 1)
      else
        bwipeout
        execute a:cmd ' ' path
      endif
    endif
  endfunction

  function! s:dirvish_toggle() abort
    let height = float2nr(&lines)
    let width  = float2nr(&columns * 0.34)
    let top    = float2nr(width - &columns)
    let vertical = 1
    let opts   = {'relative': 'editor', 'row': vertical, 'col': top, 'width': width, 'height': height, 'style': 'minimal' }
    let fdir = expand('%:h')
    let path = expand('%:p')
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    if fdir ==# ''
      let fdir = '.'
    endif

    call dirvish#open(fdir)

    if !empty(path)
      call search('\V\^'.escape(path, '\').'\$', 'cw')
    endif
  endfunction

  augroup vimrc
      autocmd FileType dirvish nmap <silent> <buffer> <CR>  :<C-U>call <SID>dirvish_open('edit'   , 0)<CR>
      autocmd FileType dirvish nmap <silent> <buffer> v     :<C-U>call <SID>dirvish_open('vsplit' , 0)<CR>
      autocmd FileType dirvish nmap <silent> <buffer> V     :<C-U>call <SID>dirvish_open('vsplit' , 1)<CR>
      autocmd FileType dirvish nmap <silent> <buffer> x     :<C-U>call <SID>dirvish_open('split'  , 0)<CR>
      autocmd FileType dirvish nmap <silent> <buffer> X     :<C-U>call <SID>dirvish_open('split'  , 1)<CR>
      autocmd FileType dirvish nmap <silent> <buffer> t     :<C-U>call <SID>dirvish_open('tabedit', 0)<CR>
      autocmd FileType dirvish nmap <silent> <buffer> T     :<C-U>call <SID>dirvish_open('tabedit', 1)<CR>
      autocmd FileType dirvish nmap <silent> <buffer> -     <Plug>(dirvish_up)
      autocmd FileType dirvish nmap <silent> <buffer> <ESC> :bd<CR>
      autocmd FileType dirvish nmap <silent> <buffer> q     :bd<CR>
  augroup END

  " Dirvish replace netrw

  let g:loaded_netrwPlugin = 1
  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
  command! -nargs=? -complete=dir Lexplore leftabove vsplit | silent Dirvish <args>
endif
