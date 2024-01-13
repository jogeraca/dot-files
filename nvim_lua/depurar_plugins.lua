--/lua/yoser/plugins.lua
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[packadd packer.nvim]])

vim.cmd("autocmd BufWritePost init.lua PackerCompile")

local startup = require("packer").startup

startup({
	function(use, use_rocks)
		-- lua
		use("nvim-lua/plenary.nvim")
		-- Utils
		use({ "wbthomason/packer.nvim", opt = true })
		use("norcalli/nvim-colorizer.lua")
		use("rcarriga/nvim-notify")
		use("folke/which-key.nvim")
		use("akinsho/toggleterm.nvim")
		use("Chiel92/vim-autoformat")
		use("folke/todo-comments.nvim")
		use("wakatime/vim-wakatime")
		use("luochen1990/rainbow")

		--use("kevinhwang91/nvim-bqf")

		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				vim.cmd([[TSUpdate]])
			end,
		})

		-- Navigation
		-- use {
		--   'kyazdani42/nvim-tree.lua',
		--   requires = {
		--     'kyazdani42/nvim-web-devicons', -- optional, for file icon
		--   },
		--   config = function()
		--             require("nvim-tree").setup({ respect_buf_cwd = true })
		--   end
		-- }
		--use("nvim-lua/telescope.nvim")
		use("nvim-telescope/telescope.nvim")
		use("nvim-telescope/telescope-fzy-native.nvim")
		use("nvim-telescope/telescope-media-files.nvim")
		use("nvim-telescope/telescope-file-browser.nvim")

		-- languages
		use("jamespeapen/swayconfig.vim")
		use({ "williamboman/nvim-lsp-installer" })
		use({ "neovim/nvim-lspconfig" })
		--#use("sheerun/vim-polyglot")
		--use({ "nvim-lua/lsp-status.nvim" })
		--

		use({ "elixir-tools/elixir-tools.nvim", requires = { "nvim-lua/plenary.nvim" } })
		--#use({ "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }})
		--#use({ "jogeraca/elixir.nvim", branch="otp_24", requires = { "nvim-lua/plenary.nvim" }})
		use("aklt/plantuml-syntax")
		use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

		-- git
		use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
		use("tpope/vim-fugitive")
		use("akinsho/git-conflict.nvim")
		use("APZelos/blamer.nvim")

		-- Completion
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/cmp-path")
		use("f3fora/cmp-spell")
		use("tpope/vim-surround")
		use("junegunn/fzf.vim")

		---- validar:
		use("AndrewRadev/splitjoin.vim")
		use("alvan/vim-closetag")
		use("christoomey/vim-tmux-navigator")
		use("christoomey/vim-tmux-runner")
		use("farmergreg/vim-lastplace")
		use("hrsh7th/cmp-emoji")
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/vim-vsnip")
		-- use("junegunn/goyo.vim")
		use("kristijanhusak/vim-dadbod-completion")
		use("kristijanhusak/vim-dadbod-ui")
		use("norcalli/nvim.lua")
		use("onsails/lspkind-nvim")
		use("stsewd/fzf-checkout.vim")
		use("tjdevries/nlua.nvim")
		use("tpope/vim-commentary")
		use("tpope/vim-dadbod")
		use("tpope/vim-dispatch")
		use("tpope/vim-eunuch")
		use("tpope/vim-projectionist")
		use("tpope/vim-repeat")
		use("tpope/vim-rsi")
		use("tpope/vim-vinegar")
		use("vim-test/vim-test")
		use({ "NTBBloodbath/rest.nvim", requires = { "nvim-lua/plenary.nvim" } })
		use({
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		})
		use({ "gfanto/fzf-lsp.nvim" })
		use({ "lukas-reineke/indent-blankline.nvim" })
		use({ "mg979/vim-visual-multi", branch = "master" })
		use({ "mhanberg/thicc_forest", requires = { "rktjmp/lush.nvim" } })
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
		use({ "nvim-treesitter/playground" })

		use({ "xiyaowong/nvim-transparent" })
		use("lukas-reineke/cmp-rg")

		use({ "kristijanhusak/vim-carbon-now-sh" })
		use({ "junegunn/vim-easy-align" })

		use({ "simrat39/symbols-outline.nvim" })

		use("mfussenegger/nvim-dap")

		use("Pocco81/true-zen.nvim")

		use_rocks({ "underscore" })
		use_rocks({ "ansicolors" })
	end,
	config = {
		max_jobs = 30,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})

require("packer.luarocks").setup_paths()
