let g:ElixirLS = {}
"let ElixirLS.path = stdpath('config').'/plugged/elixir-ls'
let ElixirLS.path='/home/yoser/.local/share/nvim/plugged/elixir-ls'
let ElixirLS.lsp=printf('%s/%s', ElixirLS.path, 'release/language_server.sh') 
let ElixirLS.cmd=join([
        \ 'asdf install &&',
        \ 'mix do',
        \ 'local.hex --force --if-missing,',
        \ 'local.rebar --force,',
        \ 'deps.get,',
        \ 'compile,',
        \ 'elixir_ls.release'
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
  \   "initializationOptions": {}
	\ }
	\})

"call coc#config('language_server',{
  "\ 'elixir', {
  "\ 'command': g:ElixirLS.lsp,
  "\ 'filetypes': ['elixir', 'eelixir'],
  "\ 'trace.server': 'verbose',
  "\}})
call coc#config('elixir.pathToElixirLS', g:ElixirLS.lsp)
