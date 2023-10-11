return {
	"javiorfo/nvim-soil",
	lazy = true,
	ft = "plantuml",
	requires = {
		"javiorfo/nvim-nyctophilia",
	},
	config = function()
		require("nvim-tree").setup({
			puml_jar = "/home/yoser/dot-files/bin",
			image = {
				darkmode = false, -- Enable or disable darkmode
				format = "png", -- Choose between png or svg
			},
		})
	end,
}
