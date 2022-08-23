local LSP = require("motch.lsp")

local elixirls = require("elixir")

elixirls.setup({
	cmd = { vim.fn.expand("~/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh") },
  repo = "mhanberg/elixir-ls",
  branch = "mh/all-workspace-symbols",
  settings = elixirls.settings({
    dialyzerEnabled = true,
    suggestSpecs = true,
    fetchDeps= true,
    enableTestLenses=true
  }),

  log_level = vim.lsp.protocol.MessageType.Log,
  message_level = vim.lsp.protocol.MessageType.Log,
  on_attach = function(client, bufnr)
    LSP.on_attach(client, bufnr)

    vim.keymap.set("n", "<space>r", vim.lsp.codelens.run, { buffer = true, noremap = true })
    vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
    vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
    vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })

    -- dap
    vim.keymap.set("n", "<space>db", require("dap").toggle_breakpoint, { buffer = true, silent = true })
    vim.keymap.set("n", "<space>dc", require("dap").continue, { buffer = true, silent = true })
  end,
})

