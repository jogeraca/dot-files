
-- return {
--   "LazyVim/LazyVim",
--   opts = {
--     colorscheme = "catppuccin",
--   },
--   cmd = {
--     "PlenaryBustedDirectory",
--     "PlenaryBustedFile",
--   },
-- }
--
return {
    "rebelot/kanagawa.nvim",
    opts = {
      background = {
        dark =  "wave", --vim.fn.readfile(vim.fn.expand("~/.local/share/mitch/kanagawa.txt"))[1],
        light = "lotus",
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          NoiceCmdlinePopup = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          NoiceCmdlinePopupBorder = { bg = theme.ui.bg_m3, fg = theme.diag.info },
          NoiceCmdlinePopupTitle = { bg = theme.ui.bg_m3, fg = theme.diag.info },
          NoiceCmdlinePopupPrompt = { bg = theme.ui.bg_m3, fg = theme.diag.info },
          NoiceCmdlinePopupBorderSearch = { bg = theme.ui.bg_m3, fg = theme.diag.warning },

          NoiceCmdlineIcon = { bg = theme.ui.bg_m3, fg = theme.diag.info },
          NoiceCmdlineIconSearch = { bg = theme.ui.bg_m3, fg = theme.diag.warning },

          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          NavicIconsFile = { link = "Directory" },
          NavicIconsModule = { link = "TSInclude" },
          NavicIconsNamespace = { link = "TSInclude" },
          NavicIconsPackage = { link = "TSInclude" },
          NavicIconsClass = { link = "Structure" },
          NavicIconsMethod = { link = "Function" },
          NavicIconsProperty = { link = "TSProperty" },
          NavicIconsField = { link = "TSField" },
          NavicIconsConstructor = { link = "@constructor" },
          NavicIconsEnum = { link = "Identifier" },
          NavicIconsInterface = { link = "Type" },
          NavicIconsFunction = { link = "Function" },
          NavicIconsVariable = { link = "@variable" },
          NavicIconsConstant = { link = "Constant" },
          NavicIconsString = { link = "String" },
          NavicIconsNumber = { link = "Number" },
          NavicIconsBoolean = { link = "Boolean" },
          NavicIconsArray = { link = "Type" },
          NavicIconsObject = { link = "Type" },
          NavicIconsKey = { link = "Keyword" },
          NavicIconsNull = { link = "Type" },
          NavicIconsEnumMember = { link = "TSField" },
          NavicIconsStruct = { link = "Structure" },
          NavicIconsEvent = { link = "Structure" },
          NavicIconsOperator = { link = "Operator" },
          NavicIconsTypeParameter = { link = "Identifier" },
          NavicText = { fg = theme.ui.fg },
          NavicSeparator = { fg = theme.ui.fg },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
    end,
  }
