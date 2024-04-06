local map = vim.api.nvim_set_keymap
local noremap_opts = { noremap = true, silent = true }

--local cnoremap_opts = { cnoremap = true, silent = true }
--
vim.g.mapleader = LeaderKey
vim.g.maplocalleader = LocalLeaderKey

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

-- map("n", "<leader>d", ":lua motch.gdiff()<cr>", noremap_opts)
map("n", "<leader><leader>m", ":Mix<cr>", noremap_opts)

-- Commentary
map("n", "<C-c>", "<esc>:Commentary<CR>", noremap_opts)
map("i", "<leader>/", "<esc>:Commentary<CR>", noremap_opts)
map("v", "<C-c>", ":Commentary<CR>", noremap_opts)
-- Copy namefile with path and only name
map("n", "<F2>", ":let @+ = expand('%:p')<CR>", noremap_opts)
map("n", "<F3>", ":let @+ = expand('%:~:.')<CR>", noremap_opts)
map("n", "<F4>", ":let @+ = expand('%:t')<CR>", noremap_opts)

-- Vim-fugitivie
map("n", "<c-p>", ":GitFiles<cr>", noremap_opts)
map("n", "<leader>gs", "<cmd>Git<cr>", noremap_opts)
map("n", "<leader>gw", "<cmd>Gwrite<cr>", noremap_opts)
map("n", "<leader>gc", "<cmd>Gcommit<cr>", noremap_opts)
map("n", "<leader>gsh", "<cmd>Git push<cr>", noremap_opts)
map("n", "<leader>gll", "<cmd>Gpull<cr>", noremap_opts)
map("n", "<leader>Gw", "<cmd>Gwq<cr>", noremap_opts)
map("n", "<leader>Gb", "<cmd>Gwq<cr>", noremap_opts)
map("n", "<leader>Gvh", "<cmd>Gvdiffsplit<cr>", noremap_opts)
map("n", "<leader>Ghh", "<cmd>Gdiffsplit<cr>", noremap_opts)
map("n", "<leader>Ggd", ":silent !tmux popup -K -w '90\\%' -h '90\\%' -R 'git diff'<cr>", noremap_opts)
---
map("n", "<leader>tr", "<cmd>Telescope lsp_references", noremap_opts)

-- resolv conflicts
map("n", "<S-l>", ":diffget LO <cr>", noremap_opts)
map("n", "<S-r>", ":diffget RE<cr>", noremap_opts)
map("n", "<S-b>", ":diffget BA<cr>", noremap_opts)
--vim.keymap.set("n", "<leader>gs", ":silent !tmux popup -K -w '90\\%' -h '90\\%' -R 'git status'<cr>")

-- Vim-sings
map("n", "<S-gl>", ":diffget :2<cr>", noremap_opts)
map("n", "<S-gr>", ":diffget :3<cr>", noremap_opts)
map("n", "<S-c>", ":Gitsigns diffthis<cr>", noremap_opts)
map("n", "<S-h>", ":/<<<<<<<\\|=======\\|>>>>>>><cr>", noremap_opts)

map("n", "<leader>rg", ":Telescope live_grep<cr>", noremap_opts)
--vim.cmd([[tnoremap <esc> <C-\><C-n>]])

vim.g.dispatch_handlers = { "job" }

-- ctags
map("n", "<leader>ct", ":!ctags -R .<cr>", noremap_opts)

-- Editing
-- map("n", "<C-BS>", "<C-W>", noremap_opts)
map("i", "<C-BS>", "<C-W>", noremap_opts)

-- sql
map(
	"n",
	"<leader>fs",
	"%s/\\<update\\>\\|\\<select\\>\\|\\<from\\>\\|\\<where>\\|\\<left join\\>\\|\\<inner join\\>\\|\\<group by\\>\\|\\<order by\\>/\r\\U&/ge<cr>nesc>",
	noremap_opts
)
