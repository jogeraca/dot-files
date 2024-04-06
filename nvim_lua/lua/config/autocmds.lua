local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("traap_" .. name, { clear = true })
end

local random = augroup("random")
-- -------------------------------------------------------------------------
-- {{{ PlantUML automatic commands.
-- -------------------------------------------------------------------------
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

-- -------------------------------------------------------------------------
-- {{{ PlantUML automatic commands.
-- -------------------------------------------------------------------------

autocmd("BufWritePost", {
	command = "PlantUmlCompile",
	pattern = { "*.puml", "*.wsd" },
})

autocmd("BufLeave", {
	-- group = augroup("plantuml_clear"),
	command = "PlantUmlClear",
	pattern = { "*.puml", "*.wsd" },
})
