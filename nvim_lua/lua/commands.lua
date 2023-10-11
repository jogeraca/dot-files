---Create an nvim command
---@param name any
---@param rhs string|fun(args: CommandArgs)
---@param opts? table
-- function command(name, rhs, opts)
-- 	opts = opts or {}
-- 	api.nvim_create_user_command(name, rhs, opts)
-- end

-- [ commands ] ----------------------------------------------------------------
do
	vim.cmd([[
    command! -nargs=1 Rg lua require("telescope.builtin").grep_string({ search = vim.api.nvim_eval('"<args>"') })
  ]])

	-- command("Todo", [[noautocmd silent! grep! 'TODO\|FIXME\|BUG\|HACK' | copen]])
	vim.cmd([[command! Q q]])
	vim.cmd([[command! Qall qall]])
	vim.cmd([[command! QA qall]])
	vim.cmd([[command! E e]])
	vim.cmd([[command! W w]])
	vim.cmd([[command! Wq wq]])
end
