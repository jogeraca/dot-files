return {
  "kyazdani42/nvim-tree.lua",
  requires = {
    "kyazdani42/nvim-web-devicons", -- optional, for file icon
  },
  config = function()
    require("nvim-tree").setup({
      respect_buf_cwd = true,
      -- view = {
        -- font = "Hack Nerd Font", -- Adjust the font name and size
      -- },
    })
  end,
}
