local map = vim.api.nvim_set_keymap
local noremap_opts = { noremap = true, silent = true }


map("n", "<S-l>", ":diffget :2<cr>", noremap_opts)
map("n", "<S-r>", ":diffget :3<cr>", noremap_opts)
map("n", "<S-c>", ":Gitsigns diffthis<cr>", noremap_opts)
map("n", "<S-h>", ":/<<<<<<<\\|=======\\|>>>>>>><cr>", noremap_opts)
