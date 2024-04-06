dofile(os.getenv("HOME") .. "/.config/nvim/settings.lua")

local config_files = {
	--"utils",
	"core.bootstrap",
	"config.lazy",
	-- pending
	"config.autocmds",
	"keymaps",
	-- nothing
	"general",
	"commands",
	"settings",
	"utils/utils",
	"functions",
}

for _, file in ipairs(config_files) do
	require("." .. file)
end

--if SafeRequire("plenary") then
--RELOAD = require("plenary.reload").reload_module
--R = function(name)
--RELOAD(name)
--return require(name)
--end
--end
