--  Default maps
-- co — choose ours
-- ct — choose theirs
-- cb — choose both
-- c0 — choose none
-- ]x — move to previous conflict
-- [x — move to next conflict
local opts = {
  default_mappings = true, -- disable buffer local mapping created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  highlights = { -- They must have background color, otherwise the default color will be used
    incoming = "DiffText",
    current = "DiffAdd",
  },
}
return {
	"akinsho/git-conflict.nvim",
	version = "*",
	config = true,
  opts = opts,
  event ="VeryLazy"
}
