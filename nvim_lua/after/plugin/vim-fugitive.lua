local map = vim.api.nvim_set_keymap
local noremap_opts = { noremap = true, silent = true }


map("n", "<c-p>", ":GitFiles<cr>", noremap_opts)
map("n", "<leader>gs", "<cmd>Git<cr>", noremap_opts)
map("n", "<leader>gw", "<cmd>Gwrite<cr>", noremap_opts)
map("n", "<leader>gc", "<cmd>Gcommit<cr>", noremap_opts)
map("n", "<leader>gsh", "<cmd>Gpush<cr>", noremap_opts)
map("n", "<leader>gll", "<cmd>Gpull<cr>", noremap_opts)
map("n", "<leader>Gw", "<cmd>Gwq<cr>", noremap_opts)
map("n", "<leader>Gb", "<cmd>Gwq<cr>", noremap_opts)
map("n", "<leader>Gvh", "<cmd>Gvdiffsplit<cr>", noremap_opts)
map("n", "<leader>Ghh", "<cmd>Gdiffsplit<cr>", noremap_opts)

map("n", "<leader>gd", ":silent !tmux popup -K -w '90\\%' -h '90\\%' -R 'git diff'<cr>", noremap_opts)
--vim.keymap.set("n", "<leader>gs", ":silent !tmux popup -K -w '90\\%' -h '90\\%' -R 'git status'<cr>")