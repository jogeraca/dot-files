dofile(os.getenv("HOME") .. "/.config/nvim/settings.lua")
local subdir = ""
local config_files = {
	--"utils",
	"yoser.lazy",
	"general",
	"keymaps",
	"commands",
	"yoser.autocmds",
}

for _, file in ipairs(config_files) do
	require(subdir .. "." .. file)
end

--if SafeRequire("plenary") then
--RELOAD = require("plenary.reload").reload_module
--R = function(name)
--RELOAD(name)
--return require(name)
--end
--end
