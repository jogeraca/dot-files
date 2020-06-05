" Configuration fzf
"
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


let g:fzf_layout = { 'up': '~30%' }
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

nnoremap <silent> <leader>e :FZF -m<CR>
