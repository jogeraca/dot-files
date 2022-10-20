local lspconfig = require("lspconfig")

M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local has_run = {}

M.on_attach = function(_, bufnr)
  local map_opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "df", "<cmd>lua vim.lsp.buf.format()<cr>", map_opts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.diagnostic.open_float()<cr>", map_opts)
  vim.keymap.set("n", "<leader>dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  vim.keymap.set("n", "<C-Enter>", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  vim.keymap.set("n", "<C-i>", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  vim.keymap.set("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
  vim.keymap.set("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
  vim.keymap.set("n", "space-s", "<cmd>lua vim.lsp.codelens.run()<cr>", map_opts)
  vim.keymap.set("n", "gr", ":References<cr>", map_opts)
  vim.keymap.set("n", "g0", ":DocumentSymbols<cr>", map_opts)
  vim.keymap.set("n", "gW", ":WorkspaceSymbols<cr>", map_opts)
  vim.keymap.set("n", "<leader>dd", ":Diagnostics<cr>", map_opts)
  vim.keymap.set("n", "<leader>da", ":DiagnosticsAll<cr>", map_opts)

  vim.cmd([[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
  vim.cmd([[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])

end

M.setup = function(name, opts)
  if not has_run[name] then
    has_run[name] = true

    lspconfig[name].setup(vim.tbl_extend("force", {
      log_level = vim.lsp.protocol.MessageType.Log,
      message_level = vim.lsp.protocol.MessageType.Log,
--      capabilities = capabilities,
      on_attach = M.on_attach,
    }, opts))
  end
end
print("entro")
if
  vim.fn.executable(
    vim.fn.expand("~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server")
  ) > 0
then
  require("nlua.lsp.nvim").setup(require("lspconfig"), {
    on_attach = M.on_attach,
    globals = { "vim", "hs" }
  })
end

vim.lsp.set_log_level(2)

local convert_lsp_log_level_to_neovim_log_level = function(lsp_log_level)
  if lsp_log_level == 1 then
    return 4
  elseif lsp_log_level == 2 then
    return 3
  elseif lsp_log_level == 3 then
    return 2
  elseif lsp_log_level == 4 then
    return 1
  end
end

local levels = {
  "ERROR",
  "WARN",
  "INFO",
  "DEBUG",
  [0] = "TRACE",
}

vim.lsp.handlers["window/showMessage"] = function(_, result, ...)
  if require("vim.lsp.log").should_log(convert_lsp_log_level_to_neovim_log_level(result.type)) then
    vim.notify(result.message, levels[result.type])
  end
end

M.default_config = function(name)
  return require("lspconfig.server_configurations." .. name).default_config
end

return M
