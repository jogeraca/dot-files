vim.g.formatOnSave = FormatOnSave
vim.g.auto_save = true

vim.g.autoformat = false
vim.b.autoformat = true

vim.g.rainbow_active = 1
vim.o.clipboard = "unnamedplus"
vim.o.hidden = true -- Allow multiple buffers to be open
vim.o.relativenumber = true
vim.lsp.set_log_level(LogLevel)

local opt = vim.opt
vim.g.default_colorcolumn = "81"
opt.scrolloff = ScrollOff
opt.colorcolumn = "999"
-- opt.guifont = "Cartograph CF"
opt.foldmethod = "syntax"
opt.foldlevelstart = 99
opt.smartindent = true
opt.tabstop = 2
opt.autoindent = true
opt.shiftwidth = 2
--opt.expandtab = true
opt.number = true
opt.termguicolors = true
opt.backupdir = vim.fn.expand("~/.tmp/backup")
opt.directory = vim.fn.expand("~/.tmp/swp")
opt.splitbelow = true
opt.splitright = true
-- opt.lazyredraw = true
opt.showmode = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.undodir = vim.fn.expand("~/.tmp")
opt.mouse = "a"
opt.errorbells = false
opt.visualbell = true
-- opt.t_vb = ""
opt.cursorline = true
opt.inccommand = "nosplit"
opt.background = "dark"
opt.autoread = true

opt.title = true

local g = vim.g

-- g.forest_night_enable_italic = 1
g.forest_night_diagnostic_text_highlight = 1

g.loaded_python_provider = 0 -- Disable Python2 support
g.loaded_perl_provider = 0 -- Disable perl provider
g.loaded_ruby_provider = 0 -- Disable ruby provider
g.python3_host_prog = "~/.pyenv/shims/python"
-- g.lazyvim_font = "Cartograph CF"
