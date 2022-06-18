local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-v>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Esc>"] = cmp.mapping.close(),
    ["C-e"] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true })
  }),
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "treesitter" },
    { name = "vim-dadbod-completion" },
    { name = "spell", keyword_length = 5 },
    -- { name = "rg", keyword_length = 3 },
    -- { name = "buffer", keyword_length = 5 },
    -- { name = "emoji" },
    { name = "path" },
    { name = "gh_issues" },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        -- emoji = "[Emoji]",
        spell = "[Spell]",
        path = "[Path]",
        -- rg = "[Rg]",
      },
    }),
  },
  completion = {
    keyword_length = 1,
    completeopt = "menu,noselect"
  },
  view = {
    entries = 'custom',
  },
})

