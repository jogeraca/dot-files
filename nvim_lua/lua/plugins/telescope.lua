return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-media-files.nvim",
		"ThePrimeagen/harpoon",
		--{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	-- apply the config and additionally load fzf-native
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		--telescope.load_extension("fzf")
		telescope.load_extension("notify")
		telescope.load_extension("harpoon")
		telescope.load_extension("fzy_native")
		telescope.load_extension("media_files")
		telescope.load_extension("file_browser")
	end,
	opts = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			file_sorter = require("telescope.sorters").get_fzy_sorter,
			file_ignore_patterns = {
				".git/",
				"node_modules",
				"^_build/",
				"^.elixir_ls/",
				"^deps/",
				"^.git",
				"^.elixir_tools",
			},
			path_display = { "smart" },
			prompt_position = "top",
			prompt_prefix = " ",
			selection_caret = " ",
			sorting_strategy = "ascending",
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			grep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
		},
		pickers = {
			file_browser = { path_display = {} },
			grep_string = { path_display = { "tail" } },
			buffers = { prompt_prefix = "﬘ " },
			commands = { prompt_prefix = " " },
			git_files = { prompt_prefix = " ", show_untracked = true },
			find_files = {
				prompt_prefix = " ",
				find_command = { "rg", "--files", "--hidden" },
			},
		},
		extensions = {
			--[[ fzf = {
				fuzzy = true,
				overried_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			fzy_native = {
				override_generic_sorter = true,
				override_file_sorter = true,
			},--]]
			media_files = {
				filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf" },
				find_cmd = "rg",
			},
		},
	},
	keys = function()
		return {}
	end,
}
