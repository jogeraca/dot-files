local map = vim.api.nvim_set_keymap
local noremap_opts = { noremap = true, silent = true }

local cnoremap_opts = { cnoremap = true, silent = true }
--
vim.g.mapleader = LeaderKey 
--vim.g.maplocalleader = ","

vim.cmd([[command! Q q]])
vim.cmd([[command! Qall qall]])
vim.cmd([[command! QA qall]])
vim.cmd([[command! E e]])
vim.cmd([[command! W w]])
vim.cmd([[command! Wq wq]])

map("n", "XX", "<cmd>quitall<cr>", noremap_opts)
map("n", "<C-s>", "<cmd>w<cr>", noremap_opts)

-- Move between tab windows
map("n", "<Tab>", "<cmd>bn<cr>", noremap_opts)
map("n", "<S-TAB>", "<cmd>bprevious<cr>", noremap_opts)
map("n", "<leader>cb", "<cmd>ene<cr>", noremap_opts)
map("n", "<leader>db", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", noremap_opts)


--show
map("n", "<leader>snw", "<cmd>set nowrap<cr>", noremap_opts)
map("n", "<leader>sw", "<cmd>set wrap<cr>", noremap_opts)

-- copy/paste
map("n", "<Leader>sa", "ggVG", noremap_opts)
map("n", "Y", "y$", noremap_opts)

-- searching text
map("n", "<leader><space>", ":set hls!<cr>", noremap_opts)

--syntax 
map("n", "<leader>fo", "<cmd>FormatOnSave", noremap_opts)


map("n", "<leader>ev", ":vsplit ~/.config/nvim/init.lua<cr>", noremap_opts)
map("n", "<space>sv", [[:luafile $MYVIMRC<cr>]], noremap_opts)
map("n", "<c-p>", ":Files<cr>", noremap_opts)
map("n", "<space>vp", ":Files ~/.local/share/nvim/site/pack/packer/start<cr>", noremap_opts)
map("n", "<space>df", ":Files ~/src/<cr>", noremap_opts)
map("n", "gl", ":BLines<cr>", noremap_opts)
map("n", "<leader>a", ":LocalProjectSearch<cr>", noremap_opts)
map("n", "<space>a", ":GlobalProjectSearch<cr>", noremap_opts)
map("n", "<leader>gr", ":grep<cr>", noremap_opts)
map("n", "<leader>c", ":botright copen 20<cr>", noremap_opts)

map("n", "<leader>d", ":lua motch.gdiff()<cr>", noremap_opts)
map("n", "<leader><leader>m", ":Mix<cr>", noremap_opts)

vim.cmd([[tnoremap <esc> <C-\><C-n>]])

vim.g.dispatch_handlers = { "job" }

-- ctags
map("n", "<leader>ct", ":!ctags -R .<cr>", noremap_opts)
