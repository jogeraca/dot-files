if !has('nvim-0.6')
  let g:ElixirLS = {}
  "let ElixirLS.path = stdpath('config').'/plugged/elixir-ls'
  let ElixirLS.path="~/.local/share/nvim/plugged/elixir-ls"
  let ElixirLS.lsp=printf('%s/%s', ElixirLS.path, 'release/language_server.sh') 
  let ElixirLS.cmd=join([
          \ 'cp .release-tool-versions .tool-versions &&',
          \ 'asdf install &&',
          \ 'mix do',
          \ 'deps.get,',
          \ 'local.hex --force --if-missing,',
          \ 'local.rebar --force,',
          \ 'compile,',
          \ 'elixir_ls.release &&',
          \ 'rm .tool-versions'
          \ ], ' ')

  function ElixirLS.on_stdout(_job_id, data, _event)
    let self.output[-1] .= a:data[0]
    call extend(self.output, a:data[1:])
  endfunction

  let ElixirLS.on_stderr = function(ElixirLS.on_stdout)

  function ElixirLS.on_exit(_job_id, exitcode, _event)
    if a:exitcode[0] == 0
      echom '>>> ElixirLS compiled'
    else
      echoerr join(self.output, ' ')
      echoerr '>>> ElixirLS compilation failed' 
    endif
  endfunction

  function ElixirLS.compile()
    let me = copy(g:ElixirLS)
    let me.output = ['']
    echom '>>> compiling ElixirLS'
    let me.id = jobstart('cd ' . me.path . ' && git pull && ' . me.cmd, me)
  endfunction

  call coc#config('languageserver', {
      \ 'elixir': {
      \	 'command': ElixirLS.lsp,
      \	 'trace.server': 'verbose',
      \	 'filetypes': ['elixir', 'eelixir'],
      \    "rootPatterns": ["mix.exs"],
      \ "initializationOptions": {}
      \ }
      \})

      

hi Statement   guifg=#8ac6f2     gui=italic,bold
  "" call coc#config('elixir.pathToElixirLS', ElixirLS.lsp)
endif
