local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local random = augroup("random", { clear = true })

autocmd("ColorScheme", {
  group = random,
  pattern = "kanagawa",
  callback = function()
    local highlights = {
      ["@symbol.elixir"] = { link = "Blue" },
      ["@constant.elixir"] = { link = "PurpleItalic" },
    }

    for key, value in pairs(highlights) do
      vim.api.nvim_set_hl(0, key, value)
    end
  end,
})
