local api = vim.api

-- Trim whitespace
-- TrimWhitespace = function()
-- 	local patterns = {
-- 		[[%s/\s\+$//e]],
-- 		[[%s/\($\n\s*\)\+\%$//]],
-- 		[[%s/\%^\n\+//]],
-- 		[[%s/\(\n\n\)\n\+/\1/]],
-- 	}
-- 	local save = vim.fn.winsaveview()
-- 	for _, v in pairs(patterns) do
-- 		api.nvim_exec(string.format("keepjumps keeppatterns silent! %s", v), false)
-- 	end
-- 	vim.fn.winrestview(save)
-- end
-- Utils.make_command("TrimWhitespace")

-- Formatting
FormatToggle = function()
	local enabled = api.nvim_get_var("formatOnSave")
	if enabled then
		api.nvim_set_var("formatOnSave", false)
	else
		api.nvim_set_var("formatOnSave", true)
	end
end
Utils.make_command("FormatToggle")

FormatOnSave = function()
	if AlwaysTrimWhitespace then
		TrimWhitespace()
	end
	local enabled = api.nvim_get_var("formatOnSave")
	if enabled then
		vim.lsp.buf.format({ async = true })
		if not AlwaysTrimWhitespace then
			TrimWhitespace()
		end
	end
end
Utils.make_command("FormatOnSave")

ReloadConfig = function()
	local hls_status = vim.v.hlsearch
	for name, _ in pairs(package.loaded) do
		package.loaded[name] = nil
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
	if hls_status == 0 then
		vim.opt.hlsearch = false
	end
end
Utils.make_command("ReloadConfig")

PlantUmlCompile = function()
	local puml_cmd = "!/usr/bin/plantuml " .. ' "' .. vim.fn.expand("%") .. '"'
	vim.fn.execute(" " .. puml_cmd)
end
Utils.make_command("PlantUmlCompile")

PlantUmlView = function()
	vim.g.puml_viewer = "okular"
	local puml_view = "!" .. vim.g.puml_viewer .. ' "' .. vim.fn.expand("%<") .. '.png"' .. " 2>/dev/null&"
	vim.fn.execute("silent " .. puml_view)
end
Utils.make_command("PlantUmlView")

-- Paste images
--local paste_cmd = Markdown.imagePasteCommand
--
--local create_dir = function(dir)
--	if vim.fn.isdirectory(dir) == 0 then
--		vim.fn.mkdir(dir, "p")
--	end
--end
--
--local get_name = function(start)
--	local index = start
--	for _ in io.popen("ls img"):lines() do
--		index = index + 1
--	end
--	local prefix = ""
--	if index < 10 then
--		prefix = "000"
--	elseif index < 100 then
--		prefix = "00"
--	elseif index < 1000 then
--		prefix = "0"
--	end
--	return "image" .. prefix .. index
--end
--
--PasteImg = function()
--	create_dir(Markdown.imageDir)
--	local name = get_name(1)
--	local path = string.format(Markdown.imageDir .. "/%s.png", name)
--	os.execute(string.format(paste_cmd, path))
--
--	local template
--	local size = Markdown.imageDefaultWidth
--	if Markdown.imagePasteSyntax == "html" then
--		if size ~= nil then
--			template = '<img src="%s" width=' .. size .. "px />"
--		else
--			template = '<img src="%s" />'
--		end
--	elseif Markdown.imagePasteSyntax == "obsidian" then
--		if size ~= nil then
--			template = "![[%s|" .. size .. "]]"
--		else
--			template = "![[%s]]"
--		end
--	else
--		template = Markdown.imagePasteSyntax
--	end
--	local pasted_txt = string.format(template, path)
--	vim.cmd("normal a" .. pasted_txt)
--end
--Utils.make_command("PasteImg")
--
--DelLastImg = function()
--	local name = get_name(0)
--	local path = string.format(Markdown.imageDir .. "/%s.png", name)
--	os.execute(string.format("rm %s", path))
--end
--Utils.make_command("DelLastImg")
--
--CleanText = function()
--	api.nvim_command("%s/–\\|•\\|▪/-/ge")
--	api.nvim_command("%s/■/-/ge")
--	api.nvim_command("%s/❑/↳ /ge")
--	api.nvim_command("%s/’/'/ge")
--	api.nvim_command('%s/“\\|”/"/ge')
--end
--Utils.make_command("CleanText")
--
--PS = function()
--	api.nvim_command("PackerSync")
--end
--Utils.make_command("PS")
--
--
