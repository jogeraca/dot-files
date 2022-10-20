local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[packadd packer.nvim]])

vim.cmd("autocmd BufWritePost init.lua PackerCompile")

local startup = require("packer").startup

startup({
  function(use, use_rocks)
    -- Utils
    use({ "wbthomason/packer.nvim", opt = true })
    use("nvim-lua/plenary.nvim")
    use("folke/which-key.nvim")
		use("akinsho/toggleterm.nvim")
    -- LSP
    use({"neovim/nvim-lspconfig"})
    use({"williamboman/nvim-lsp-installer"})

    use('wakatime/vim-wakatime')
    -- Navigation
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function()
        require("nvim-tree").setup({ respect_buf_cwd = true })
      end
    }
		--use("nvim-lua/telescope.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")

    -- Completion
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    use("hrsh7th/nvim-cmp")
    use("f3fora/cmp-spell")
    use("tpope/vim-surround")
    -- programming
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        vim.cmd([[TSUpdate]])
      end,
    })
    use("cuducos/yaml.nvim")

-- windows maximizer
	use {
		"anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim"
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require('windows').setup({
				animation = {
					duration = 100,
				}
			})
		end
	}
    use("mhanberg/zk.nvim")
    use("ruanyl/vim-gh-line")
    use("APZelos/blamer.nvim")
    use("AndrewRadev/splitjoin.vim")
    use("alvan/vim-closetag")
    use("christoomey/vim-tmux-navigator")
    use("christoomey/vim-tmux-runner")
    use("farmergreg/vim-lastplace")
    use("hrsh7th/cmp-emoji")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/vim-vsnip")
    use("junegunn/fzf.vim")
    -- use("junegunn/goyo.vim")
    use("kristijanhusak/vim-dadbod-completion")
    use("kristijanhusak/vim-dadbod-ui")
    use("norcalli/nvim.lua")
    use("onsails/lspkind-nvim")
    use("rcarriga/nvim-notify")
    use("stsewd/fzf-checkout.vim")
    use("tjdevries/nlua.nvim")
    use("tpope/vim-commentary")
    use("tpope/vim-dadbod")
    use("tpope/vim-dispatch")
    use("tpope/vim-eunuch")
    use("tpope/vim-fugitive")
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
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

		use({ "xiyaowong/nvim-transparent"} )
    use("lukas-reineke/cmp-rg")

    use({ "kristijanhusak/vim-carbon-now-sh" })
    use({ "junegunn/vim-easy-align" })

    use({ "simrat39/symbols-outline.nvim" })

		use({ "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }})
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
