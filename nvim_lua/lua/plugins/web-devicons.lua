return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
      override = {
        ["leex"] = {
          icon = "",
          color = "#a074c4",
          cterm_color = "140",
          name = "Leex",
        },
        ["heex"] = {
            icon = "",
            color = "",
            cterm_color = "140",
            name = "Heex",
          },
        ["exs"] = {
            icon = "",
            color = "#a074c4",
            cterm_color = "140",
            name = "Exs",
          },
        ["ex"] = {
            icon = "",
            color = "#a074c4",
            cterm_color = "140",
            font ="fira code",
            name = "Ex",
          },
        -- ["eex"] = {
        --    icon = "",
        --     color = "#a074c4",
        --     cterm_color = "140",
        --     name = "Ex",
        --   },
        -- ["eex"] = {
        --     icon = "",
        --     color = "#a074c4",
        --     cterm_color = "140",
        --     name = "Ex",
        --   },
        -- ["eex"] = {
        --     icon = "e",
        --     color = "#a074c4",
        --     cterm_color = "140",
        --     name = "Eex",
        --   },
        -- ["mix.lock"] = {
        --     icon = "",
        --     color = "#a074c4",
        --     cterm_color = "140",
        --     name = "MixLock",
        --   }
      }
    })
	end,
}
