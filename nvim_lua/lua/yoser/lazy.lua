local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- import any extras modules here
		----- { import = "lazyvim.plugins.extras.lang.typescript" },
		----- { import = "lazyvim.plugins.extras.lang.json" },
		-- cSpell:word hipatterns
		----- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	-- cSpell:word tokyonight habamax
	install = { colorscheme = { "tokyonight", "kanagawa", "habamax", "everforest" } },
	ui = { border = "single", },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})


_G.yoser = {}
local theme = "kanagawa"

_G.yoser.set_dark_theme = function()
  vim.g.everforest_colors_override = {
    -- bg8 = { "#000000", 235 },
    bg0 = { "#273433", "235" },
    bg1 = { "#394C4A", "236" },
    bg2 = { "#425755", "237" },
    bg3 = { "#4B6361", "238" },
    bg4 = { "#56716F", "239" },
  }
  vim.opt.background = "dark"
  vim.cmd.colorscheme(theme)
end
_G.yoser.set_light_theme = function()
  vim.g.everforest_colors_override = {
    bg8 = { "#000000", 235 },
  }
  vim.opt.background = "light"

  vim.cmd.colorscheme(theme)
end

_G.yoser.toggle_theme = function()
  if vim.opt.background:get() == "dark" then
    yoser.set_light_theme()
  else
    yoser.set_dark_theme()
  end
end

vim.api.nvim_create_user_command(
  "ToggleColorscheme",
  yoser.toggle_theme,
  { desc = "Toggle the theme from dark mode to light mode" }
)

vim.opt.statuscolumn = "%s %l %C"
vim.cmd([[command! -nargs=0 GoToFile :Telescope find_files]])
vim.cmd([[command! -nargs=0 GoToCommand :Telescope commands]])
-- cSpell:word cursorlineopt
vim.o.cursorlineopt = "number"

vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = true
vim.g.code_action_menu_show_action_kind = false
