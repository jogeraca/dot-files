" Configuration Coc
if !has('nvim-0.5')
  let g:coc_global_extensions = [
     \ 'coc-css',
     \ 'coc-diagnostic',
     \ 'coc-eslint',
     \ 'coc-explorer',
     \ 'coc-git',
     \ 'coc-highlight',
     \ 'coc-html',
     \ 'coc-json',
     \ 'coc-lists',
     \ 'coc-marketplace',
     \ 'coc-pairs',
     \ 'coc-prettier',
     \ 'coc-python',
     \ 'coc-rls',
     \ 'coc-tag',
     \ 'coc-tslint',
     \ 'coc-tslint-plugin',
     \ 'coc-spell-checker',
     \ 'coc-cspell-dicts',
     \ 'coc-snippets',
     \ 'coc-tsserver',
     \ 'coc-vimlsp',
     \ 'coc-elixir',
     \ 'coc-java',
     \ 'coc-solargraph',
     \ 'coc-yaml']



  " if hidden is not set, TextEdit might fail.
  set hidden

  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup
  " Better display for messages
  set cmdheight=2
  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300
  " don't give |ins-completion-menu| messages.
  set shortmess+=c
  " always show signcolumns
  set signcolumn=yes
  " Better display for messages
  set cmdheight=2
  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300
  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.

  inoremap <silent><expr> <TAB>
   \ pumvisible() ? "\<C-n>":
   \ <SID>check_back_space() ? "\<TAB>" :
   \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
  endfunction


  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Coc integrate with git
  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)


  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> <Alt-p> :GFiles <CR> " TODO: pendiente

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
  endfunction

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
  if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Create mappings for function text object, requires document symbols feature of languageserver.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  " TODO: Definir hotkey
  nmap <silent> <C-d> <Plug>(coc-range-select)
  xmap <silent> <C-d> <Plug>(coc-range-select)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  "Use <C-l> to trigger snippet expand
  "imap <C-l> <Plug>(coc-snippets-expand)

  nmap <silent> <C-c> <Plug>(coc-cursors-position)
  " TODO: Definir hotkey
  nmap <silent> <C-d> <Plug>(coc-cursors-word)
  xmap <silent> <C-d> <Plug>(coc-cursors-range)

  imap <leader>x  <Plug>(coc-cursors-operator)
  nmap <leader>r  <Plug>(coc-refactor)

  vmap <leader>a <Plug>(coc-codeaction-selected)
  nmap <leader>a <Plug>(coc-codeaction-selected)


  nmap <silent> }c <Plug>(coc-git-nextchunk)
  nmap <silent> {c <Plug>(coc-git-prevchunk)
  nmap <silent> <Leader>cs :CocCommand git.chunkStage<CR>
  nmap <silent> <Leader>cu :CocCommand git.chunkUndo<CR>
  nmap <silent> <Leader>cp <Plug>(coc-git-chunkinfo)



  ""if !has('nvim')
  ""    let g:airline_section_c = airline#section#create(['%{airline#extensions#fugitiveline#bufname()}','%m',"   %#__accent_gray__# %{get(b:,'coc_git_blame','')} %#__restore__#", '%#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'])
  ""endif


  " Coc Explorer Key
  :nmap oe :CocCommand explorer<CR>

  hi CocCursorRange guibg=#b16286 guifg=#ebdfff
  nmap <expr> <silent> <C-d> <SID>select_current_word()

  function! s:select_current_word()
        if !get(g:, 'coc_cursors_activated', 0)
                return "\<Plug>(coc-cursors-word)"
                  endif
                    return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
                endfunc
endif
