-- Enable italic for function names in Elixir

local custom_attach = function(client, bufnr)
	local map_opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "<leader>df", "<cmd>lua vim.lsp.buf.format()<cr>", map_opts)
	vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.diagnostic.open_float()<cr>", map_opts)
	vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
	vim.keymap.set("n", "vgt", ":vsplit | lua vim.lsp.buf.definition()<cr>", map_opts)
	vim.keymap.set("n", "hgt", ":belowright split| lua vim.lsp.buf.definition()<cr>", map_opts)
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

vim.cmd("autocmd FileType elixir highlight ElixirFunction gui=italic,bold")

return {
	cond = true,
	"elixir-tools/elixir-tools.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local elixir = require("elixir")
		local elixirls = require("elixir.elixirls")

		-- local nextls_opts
		-- if vim.env.NEXTLS_LOCAL == "1" then
		-- else
		-- nextls_opts = { enable = true }
		local nextls = {
			enable = true, -- defaults to false
      -- cmd = "bin/nextls",
			-- port = 9000, -- connect via TCP with the given port. mutually exclusive with `cmd`. defaults to nil
			-- cmd = "/home/yoser/dot-files/nvim_lua/lazy/elixir-tools.nvim/bin/nextls", -- path to the executable. mutually exclusive with `port`
			-- init_options = {
			-- 	mix_env = "dev",
			-- 	mix_target = "host",
        -- experimental = {
        --   completions = {
        --     enable = true, -- control if completions are enabled. defaults to false
        --   },
        -- },
			-- },
			-- on_attach = function(client, bufnr)
				-- custom keybinds
			-- end,
		}
		-- end

		elixir.setup({
			credo = {enable= false},
			nextls = nextls,
			elixirls = {
				repo = "elixir-lsp/elixir-ls",
				branch = "master",
				enable = true,
				settings = elixirls.settings({
					fetchDeps = true,
					suggestSpecs = false,
					dialyzerEnabled = true,
					enableTestLenses = false,
          signatureAfterComplete = false,
          mixEnv="dev",
          -- trace={ server = "off", }
				}),
				-- log_level = vim.lsp.protocol.MessageType.Log,
				-- message_level = vim.lsp.protocol.MessageType.Log,
				on_attach = custom_attach,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
