" Configuration fzf
"
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"set wildignore+=*/_build/**

let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

let g:fzf_layout = { 'window': 'call UserFzfOpenWin()' }

let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

let g:fzf_command_prefix = 'Fzf'

nnoremap <silent> <leader>e  :call UserFzFOpenUp() <CR>
function! UserFzFOpenUp()
  let g:fzf_layout = { 'up': '~30%' }
  silent! FZF -m
  let g:fzf_layout = { 'window': 'call UserFzfOpenWin()' }
endfunction


noremap <silent> <c-p> :FzfFiles<CR>
let g:fzf_files_options='--preview-window down:wrap --reverse'
command! -bang -nargs=? -complete=dir FzfFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('down:50%', '?'), <bang>0)
function! UserFzfOpenWin()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf_bg = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf_bg, 0, -1, v:true, lines)
    let s:bwin = nvim_open_win(s:buf_bg, v:true, opts)
    set winhl=Normal:Comment
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)

    setlocal
          \ buftype=nofile
          \ nobuflisted
          \ bufhidden=hide
          \ nonumber
          \ norelativenumber
          \ signcolumn=no

    autocmd WinLeave * ++once call nvim_win_close(s:bwin, v:false)
      \| execute 'bwipeout ' . s:buf_bg
endfunction
