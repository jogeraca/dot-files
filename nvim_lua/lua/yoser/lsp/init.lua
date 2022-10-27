local lspconfig = SafeRequire("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.window = {
  workDoneProgress = true,
}

local custom_attach = function(client, bufnr)
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
  vim.keymap.set("n", "gr", ":References<cr>", map_opts)
  vim.keymap.set("n", "g0", ":DocumentSymbols<cr>", map_opts)
  vim.keymap.set("n", "gW", ":WorkspaceSymbols<cr>", map_opts)
  vim.keymap.set("n", "<leader>dd", ":Diagnostics<cr>", map_opts)
  vim.keymap.set("n", "<leader>da", ":DiagnosticsAll<cr>", map_opts)

	vim.keymap.set("n", "<space>r", vim.lsp.codelens.run, { buffer = true, noremap = true })
  vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })


  vim.keymap.set("n", "space-s", "<cmd>lua vim.lsp.codelens.run()<cr>", map_opts)

  vim.cmd([[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
  vim.cmd([[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])

	if client.server_capabilities.renameProvider then
    vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, map_opts)
  end
end
local servers = {
	sumneko_lua = true,
	vimls = true,
	pyright = true,
	rls = true,
	jsonls = true,
	html = true,
	cssls = true,
	eslint = true,
	tsserver = true,
	yamlls = true,
	ccls = true,
	zk = true,
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_attach = custom_attach,
		capabilities = capabilities,
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
 	setup_server(server, config)
end

local elixirls = require("elixir")

elixirls.setup({
		repo = "mhanberg/elixir-ls",
		branch = "mh/all-workspace-symbols",
		settings = elixirls.settings({
    	dialyzerEnabled = true,
    	suggestSpecs = true,
    	enableTestLenses = true,
  	}),
  	on_attach = custom_attach,
  	capabilities = capabilities,
	})

