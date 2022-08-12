require'nvim-tree'.setup { 
  disable_netrw = true,
	sync_root_with_cwd = true,
	view = {
		side = "right",
	},
	diagnostics = {
		enable = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
	renderer = {
		highlight_git = true,
	}
}
