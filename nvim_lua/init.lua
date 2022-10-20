dofile(os.getenv("HOME") .. "/.config/nvim/settings.lua")
local subdir=""
local config_files = {
  "utils",
  "motch.plugins",
  "motch.language_servers",
  "general",
  "functions",
  "keymaps",
}

for _ , file  in ipairs(config_files ) do
  require(subdir .. "." .. file)
end

_G.motch = {}

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

vim.notify = require("notify")

-- vim.lsp.handlers["window/logMessage"] = n

_ = require("underscore")

local opt = vim.opt

function RemoveNetrwMap()
  if vim.fn.hasmapto("<Plug>NetrwRefresh") > 0 then
    vim.cmd([[unmap <buffer> <C-l>]])
  end
end

vim.api.nvim_exec(
  [[
function! FzfWrapHelper(opts)
  call fzf#run(fzf#wrap(a:opts))
endfunction
]],
  false
)

FZF = vim.fn["FzfWrapHelper"]

vim.env.WALLABY_DRIVER = "chrome"

opt.laststatus = 3
--opt.winbar = "%f %m"

opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}


-- vim.cmd([[color thicc_forest]])


opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.blamer_enabled = 1
vim.g.blamer_relative_time = 1

vim.g.zig_fmt_autosave = 0

--require("motch.treesitter")

opt.grepprg = "ag --vimgrep -Q $*"
opt.grepformat = "%f:%l:%c:%m"

vim.g.jsx_ext_required = 0

vim.keymap.set("n", "<leader>gy", ":TZAtaraxis<cr>")
vim.g.goyo_width = 120
vim.g.goyo_height = 100

vim.g.markdown_syntax_conceal = 0

-- vim.g.Hexokinase_optInPatterns = { "full_hex", "triple_hex", "rgb", "rgba", "hsl", "hsla" }

local old_handler = vim.lsp.handlers["window/logMessage"]

vim.lsp.handlers["window/logMessage"] = function(err, result, ...)
  if result.type == 3 or result.type == 4 then
    print(result.message)
  end

  old_handler(err, result, ...)
end

local LSP = require("motch.lsp")

LSP.setup("efm", {
  filetypes = {
    --"elixir",
    "javascript",
    "typescript",
    "lua",
    "bash",
    "zsh",
    "sh",
    "sql",
  },
})
LSP.setup("rust_analyzer", {})
-- LSP.setup("solargraph", {})
LSP.setup("omnisharp", {})
LSP.setup("tsserver", {})
-- LSP.setup("vimls", {})
LSP.setup("bashls", {})

local zk = require("zk")

zk.setup({
  filetypes = { "markdown", "liquid" },
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    LSP.on_attach(client, bufnr)
    vim.keymap.set("n", "<C-p>", [[:Notes<cr>]], opts)
    vim.keymap.set("n", "<space>zt", [[:Tags<cr>]], opts)
    vim.keymap.set("n", "<space>zl", [[:Links<cr>]], opts)
    vim.keymap.set("n", "<space>zb", [[:Backlinks<cr>]], opts)
    vim.keymap.set(
      "n",
      "<space>zd",
      [[:lua require("zk").new({group = "daily", dir = "journal/daily"})<cr>]],
      opts
    )
    vim.keymap.set("v", "<leader>zn", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)

    if vim.fn.expand("%:h") == "dnd" then
      vim.keymap.set("n", "<A-j>", [[:lua motch.dnd.move_to("previous")<cr>]], opts)
      vim.keymap.set("n", "<A-k>", [[:lua motch.dnd.move_to("next")<cr>]], opts)
    end
  end,
})

LSP.setup("zls", {})
LSP.setup("gopls", {})

local default_tw_config = LSP.default_config("tailwindcss")
LSP.setup(
  "tailwindcss",
  vim.tbl_deep_extend("force", default_tw_config, {
    init_options = {
      userLanguages = {
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
      },
    },
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            [[class: "([^"]*)]],
          },
        },
      },
    },
    filetypes = { "elixir", "eelixir", "html", "liquid" },
  })
)

-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('motch.code_action').code_action_listener()]])
--

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local random = augroup("random", { clear = true })

autocmd(
  "BufWritePost",
  { group = random, pattern = "config/nvim/lua/motch/plugins.lua", command = "PackerCompile" }
)
-- autocmd "User", FloatermOpen execute "normal G" | wincmd p]]
autocmd("VimResized", { group = random, pattern = "*", command = "wincmd =" })
autocmd("GUIEnter", {
  group = random,
  pattern = "*",
  callback = function()
    vim.opt.visualbell = "t_vb="
  end,
})
autocmd("FileType", { group = random, pattern = "netrw", callback = RemoveNetrwMap })
autocmd("FileType", {
  group = random,
  pattern = "fzf",
  callback = function()
    vim.keymap.set("t", "<esc>", "<C-c>", { buffer = 0 })
  end,
})
autocmd(
  { "BufRead", "BufNewFile" },
  { group = random, pattern = "*.livemd", command = "set filetype=markdown" }
)
autocmd(
  { "BufRead", "BufNewFile" },
  { group = random, pattern = "aliases.local", command = "set filetype=zsh" }
)
autocmd({ "BufRead", "BufNewFile" }, { group = random, pattern = "*.lexs", command = "set filetype=elixir" })
autocmd({ "BufRead", "BufNewFile" }, { group = random, pattern = "*.exs", command = "FormatOnSave" })
autocmd("BufWritePost", { group = random, pattern = "*.ex", command = "FormatOnSave" })
autocmd("BufWritePost", { group = random, pattern = "*.exs", command = "FormatOnSave" })

local clojure = augroup("clojure", { clear = true })
autocmd("BufWritePost", { group = clojure, pattern = "*.clj", command = "silent Require" })

local markdown = augroup("markdown", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, { group = markdown, pattern = "*.md", command = "setlocal spell" })
autocmd({ "BufRead", "BufNewFile" }, { group = markdown, pattern = "*.md", command = "setlocal linebreak" })

vim.cmd([[let g:test#javascript#jest#file_pattern = '\v(.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$']])

if vim.fn.filereadable(".init.local.lua") == 1 then
  vim.cmd([[source .init.local.lua]])
end

--vim.cmd("autocmd BufWritePost init.lu
