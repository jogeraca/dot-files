return {
  "nvim-tree/nvim-tree.lua",
  requires = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icon
  },
  config = function()
    require("nvim-tree").setup({
      sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      -- respect_buf_cwd = true,
      -- view = {
        -- font = "Hack Nerd Font", -- Adjust the font name and size
      -- },
    })
  end,
}
