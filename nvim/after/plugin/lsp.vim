if has('nvim-0.6')
 :lua << LUA
  local a = vim.api
  local lspconfig = require('lspconfig')
 
  local lsp_servers = {
    bashls = {},
    cssls = {
      root_dir = lspconfig.util.root_pattern("package.json", ".git")
    },
    dockerls = {},
    elixirls = {
      cmd = { vim.loop.os_homedir().."/.local/share/nvim/plugged/elixir-ls/release/language_server.sh" };
      settings = {
        elixirLS = {
          dialyzerFormat = "dialyxir_short";
        }
      };
    },
    html = {},
    jsonls = {},
    solargraph = {},
    sqlls = {
      cmd = {"sql-language-server", "up", "--method", "stdio"};
    },
    tsserver = {},
    vimls = {},
    vuels = {},
    yamlls = {},
  } 
  local function make_on_attach(config)
    return function(client)
      print('LSP Starting')
 
      require('completion').on_attach(client)
 
      local opts = { noremap = true, silent = true}
      a.nvim_buf_set_keymap(0, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<leader>gw', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<leader>go', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', opts)
      a.nvim_buf_set_keymap(0, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
 
      if client.resolved_capabilities.document_highlight == true then
        a.nvim_command('augroup lsp_aucmds')
        a.nvim_command('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
        a.nvim_command('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
        a.nvim_command('augroup END')
      end
 
      a.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')
    end
  end
 
  for lsp_server, config in pairs(lsp_servers) do
    config.on_attach = make_on_attach(config)
    local setup = lspconfig[lsp_server]
    lspconfig[lsp_server].setup(config)
  end
 
  require('lspfuzzy').setup({})
 
  require('colorizer').setup({
    'css',
    'javascript',
    'html',
    'eelixir',
    'erb'
  })
 
LUA
 
command! -nargs=0 Format :lua vim.lsp.buf.formatting()
 
  command! -nargs=? LspActiveClients lua print(vim.inspect(vim.lsp.get_active_clients()))
  command! -nargs=? LspLog lua vim.api.nvim_command("split "..vim.lsp.get_log_path())
 
  function! RestartLsp()
    lua vim.lsp.stop_client(vim.lsp.get_active_clients())
    edit
  endfunction
 
  command! -nargs=? LspRestart :call RestartLsp()
 
  sign define LspDiagnosticsSignError text=⨯ texthl=LspDiagnosticsSignError linehl= numhl=
  sign define LspDiagnosticsSignWarning text=⚠ texthl=LspDiagnosticsSignWarning linehl= numhl=
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
  sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

  autocmd BufNewFile,BufRead *.drab setf eelixir
endif
