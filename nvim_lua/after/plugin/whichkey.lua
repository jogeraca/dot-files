local wk = require("which-key")

wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { ["<C-_>"] = "Comments" },
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "->", -- symbol used between a key and it's label
		group = "", -- symbol prepended to a group
	},
	window = {
		border = "shadow", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 0, 0, 0, 0 }, -- extra window margin [top, left, bottom, right]
		padding = { 1, 1, 1, 1 }, -- extra window padding [top, left, bottom, right]
	},
	layout = {
		height = { min = 4, max = 10 }, -- min and max height of the columns
		width = { min = 20, max = 300 }, -- min and max width of the columns
		spacing = 5, -- spacing between columns
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers_blacklist = {
		i = { "^" },
	},
})

vim.g.mapleader = LeaderKey

-- Normal mode
local nmappings = {
	[","] = "which_key_ignore",
	["/"] = { "<cmd>CommentToggle<cr>", "toggle comment" },
	["?"] = { "<cmd>NvimTreeFindFile<cr>", "find current file" },
	["."] = { "<cmd>luafile %<cr>", "source file" },
	c = { "<cmd>SessionSave<cr>", "save session" },
	e = { "<cmd>NvimTreeToggle<cr>", "explorer" },


	I = { "<cmd>IndentBlanklineToggle<cr>", "toggle indent lines" },
	H = { "<cmd>Dashboard<cr>", "home" },

	s = { "<cmd>w<cr>", "save" },
	q = { "<cmd>wqa<cr>", "save & quit" },
	Q = { "<cmd>qa!<cr>", "force quit" },
	w = { "<cmd>close<cr>", "close window" },
	x = { "<cmd>BufferClose<cr>", "close buffer" },
	X = { "<cmd>BufferClose!<cr>", "close buffer!" },
	h = { "<cmd>sp<cr>", "split below" },
	v = { "<cmd>vert sp<cr>", "split right" },
	i = { "<cmd>PasteImg<cr>2b", "paste image" },
	N = { "<cmd>NewFile<cr>", "new buffer" },
	R = { "<cmd>e<cr>", "reload buffer" },
	-- Menus
  A = {
		name = "Application menu",
		m = {
			name = "markdown",
			p = { "<cmd>MarkdownPreviewToggle<cr>", "toggle preview" },
			i = { "A  %_<esc>", "fix italics" },
			C = {
				"<cmd>s/\\(\\s[a-z]\\)\\|^\\([a-z]\\)/\\U\\2\\U\\1/g<CR>",
				"capitalize line",
			},
			s = { "1z=", "fix spelling" },
			c = { "mz<cmd>CleanText<cr>'z", "clean text" },
		},
	},
	C = {
		name= "Config nvim",
    e= {":vsplit ~/.config/nvim/init.lua<cr>", "Edit config a"},
		r= {"<cmd>luafile $MYVIMRC<cr>", "reset nvim"},
	},
	b = {
		name = "buffers",
		[">"] = { "<cmd>BufferMoveNext<cr>", "move right" },
		["<"] = { "<cmd>BufferMovePrevious<cr>", "move left" },
		b = { "<cmd>Telescope buffers<cr>", "buffers" },
		B = { "<cmd>Buffers<cr>", "list buffers" },
    d = {"<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", "delete buffer"},
		p = { "<cmd>BufferPick<cr>", "pick buffer" },
		x = { "<cmd>BufferClose<cr>", "close buffer" },
		c = { "<cmd>BufferCloseAllButCurrent<cr>", "close all other buffers" },
		p = { "<cmd>BufferPin<cr>", "pin buffer" },
		j = { "<cmd>BufferNext<cr>", "next buffer" },
		k = { "<cmd>BufferPrevious<cr>", "prev buffer" },
		t = {
			name = "tab",
			t = { "<cmd>tabnew<cr>", "new tab" },
			c = { "<cmd>tabclose<cr>", "close tab" },
			n = { "<cmd>tabn<cr>", "next tab" },
			p = { "<cmd>tabp<cr>", "prev tab" },
			l = { "<cmd>tabs<cr>", "list tabs" },
		},
	},
	d = {
		name = "debug",
		O = { "<cmd>DebugStepOut<cr>", "step out" },
		b = { "<cmd>DebugToggleBreakpoint<cr>", "toggle breakpoint" },
		c = { "<cmd>DebugContinue<cr>", "continue" },
		f = { "<cmd>DebugFloatElement<cr>", "float ui element" },
		j = { "<cmd>DebugStepInto<cr>", "step into" },
		k = { "<cmd>DebugStepBack<cr>", "step back" },
		l = { "<cmd>DebugListBreakpoints<cr>", "list breakpoints" },
		o = { "<cmd>DebugStepOver<cr>", "step over" },
		t = { "<cmd>DebugToggleRepl<cr>", "toggle repl" },
		p = {
			name = "python",
			m = { "<cmd>PythonTestMethod<cr>", "test method" },
			c = { "<cmd>PythonTestClass<cr>", "test class" },
		},
	},
  E = {
    name = "Editing",
	  ['"'] = { 'ciw"<C-r>""<esc>', '""' },
	  u = { "'u", "undo 'undo jump'" },
    ["'"] = { "ciw'<C-r>\"'<esc>", "''" },
    ["("] = { 'ciw(<C-r>")<esc>', "()" },
    ["["] = { 'ciw[<C-r>"]<esc>', "[]" },
    ["`"] = { 'ciw`<C-r>"`<esc>', "``" },
    ["{"] = { 'ciw{<C-r>"}<esc>', "{}" },
  },
	f = {
		name = "File explorer",
		["?"] = { "<cmd>NvimTreeFindFile<cr>", "find current file" },
		f = { "<cmd>Telescope find_files<cr>", "files" },
		e = { "<cmd>Telescope file_browser<cr>", "fuzzy explorer" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		i = { "<cmd>Telescope media_files<cr>", "media" },
	},
	F = {
		name = "fold",
		O = { "<cmd>set foldlevel=20<cr>", "open all" },
		C = { "<cmd>set foldlevel=0<cr>", "close all" },
		c = { "<cmd>foldclose<cr>", "close" },
		o = { "<cmd>foldopen<cr>", "open" },
		["1"] = { "<cmd>set foldlevel=1<cr>", "level1" },
		["2"] = { "<cmd>set foldlevel=2<cr>", "level2" },
		["3"] = { "<cmd>set foldlevel=3<cr>", "level3" },
		["4"] = { "<cmd>set foldlevel=4<cr>", "level4" },
		["5"] = { "<cmd>set foldlevel=5<cr>", "level5" },
		["6"] = { "<cmd>set foldlevel=6<cr>", "level6" },
	},
	g = {
		name = "Git",
		--R = { "<cmd>Git reset_buffer<CR>", "reset buffer" },
		--b = { "<cmd>Git blame_line<CR>", "blame" },
		--d = { "<cmd>Git preview_hunk<cr>", "preview hunk diff" },
		--p = { "<cmd>Git prev_hunk<CR>", "prev hunk" },
		--r = { "<cmd>Git reset_hunk<CR>", "reset hunk" },
		--u = { "<cmd>Git undo_stage_hunk<CR>", "undo stage hunk" },
		A = { "<cmd>Git stage_buffer<cr>", "stage buffer" },
		D = { "<cmd>Git diffthis<CR>", "file diff" },
		a = { "<cmd>Git stage_hunk<CR>", "stage hunk" },
		b = { "<cmd>Telescope git_branches<cr>", "git branches" },
		g = { "<cmd>lua LazygitToggle()<CR>", "lazygit" },
		n = { "<cmd>Git next_hunk<CR>", "next hunk" },
		q = { "<cmd>Git setqflist<CR>", "quickfix" },
		w = { "<cmd>Git toggle_word_diff<CR>", "word diff" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff"},
    hs = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>:Git<cr>", "Status" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk"
    },
	},
	l = {
		name = "lsp",
		["?"] = { "<cmd>LspInfo<cr>", "lsp info" },
		A = { "<cmd>lua vim.lsp.codelens.run()<cr>", "accept the suggestion" },
		D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "workspace diagnostics"},
		F = { "<cmd>FormatToggle<cr>", "toggle formatting" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    L = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		R = { "<cmd>LspRestart<cr>", "restart lsp" },
		S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "workspace symbols" },
    W = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
		T = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "type defintion" },
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
		d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "document diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.formatting_async()<cr>", "Format" },
		i = { "<cmd>normal A  # type: ignore<cr>bbbbhhh", "pyright ignore" },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
		l = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "line diagnostics"},
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		v = { "<cmd>LspVirtualTextToggle<cr>", "toggle virtual text" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		x = { "<cmd>cclose<cr>", "close quickfix" },
		w = {
			name = "workspace",
			a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "add workspace" },
			d = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "remove workspace" },
			l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "remov113e workspace" },
		},
	},
	k = {
		name = "keep",
		t = { "<cmd>GkeepToggle<cr>", "toggle" },
		n = { "<cmd>GkeepNew note<cr>", "new note" },
		b = { "<cmd>GkeepBrowse<cr>", "open in browser" },
		c = { "<cmd>GkeepCheck<cr>", "toggle checkbox" },
		C = { "<cmd>GkeepSortChecked<cr>", "sort checkboxes" },
		x = { "<cmd>GkeepClearChecked<cr>", "clear checked" },
		r = { "<cmd>GkeepSync<cr>", "sync" },
	},
	n = {
		name = "notebook",
		c = { "<cmd>norm i# %%<cr>o", "code cell" },
		m = { "<cmd>norm i# %% [markdown]<cr>o# ", "markdown cell" },
	},
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  S = {
    name = "Search",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
  },
  T = {
    name = "Terminal",
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
	t = {
		name = "telescope",
		["."] = {
			'<cmd>lua require("plugins.telescope").search_dotfiles{}<cr>',
			"config",
		},
		["?"] = { "<cmd>Telescope filetypes<cr>", "filetypes" },
		h = { "<cmd>Telescope command_history<cr>", "cmd history" },
		m = { "<cmd>Telescope marks<cr>", "marks" },
		M = { "<cmd>Telescope man_pages<cr>", "manuals" },
		o = { "<cmd>Telescope vim_options<cr>", "options" },
		t = {
			'<cmd>Telescope grep_string search="" only_sort_text=true<cr>',
			"text",
		},
		T = { "<cmd>Telescope live_grep<cr>", "exact text" },
		s = {
			'<cmd>lua require("plugins.telescope").search_dir()<cr>',
			"search dir",
		},
		q = { "<cmd>Telescope quickfix<cr>", "quickfix" },
	},
	W = {
		name = "window",
		["<"] = { "<C-w><", "-x" },
		[">"] = { "<C-w>>", "+x" },
		["-"] = { "<C-w>-", "-y" },
		["+"] = { "<C-w>+", "+y" },
		["="] = { "<C-w>=", "reset window" },
		h = { "<cmd>split<cr>", "split horizontal" },
		v = { "<cmd>vsplit<cr>", "split vertical" },
		d = { "<cmd>close<cr>", "close split window" },
		j = { "<C-w>J", "move to bottom" },
		H = { "<C-w>J<C-w>k<C-w>H<C-w>l<C-w>j", "move under" },
	},
}
wk.register(nmappings, {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

-- Visual mode
local vmappings = {
	B = { 'c**_<C-r>"_**<esc>', "bold & italic" },
	a = { ':s/=/\\&=/g<cr>gvc\\begin{align}<cr><C-r>"<backspace><space>\\\\<cr>\\end{align}<esc>O&= ', "align" },
	b = { 'c**<C-r>"**<esc>', "bold" },
	c = { 'c<span style="color: "><C-r>"</span><esc>T:a', "color" },
	i = { 'c_<C-r>"_<esc>', "italic" },
	l = { 'c[[./<C-r>"#<C-r>"|<C-r>"]]<esc>', "inlink" },
	m = { 'c$<C-r>"$<esc>', "inline math" },
	p = { "<Plug>(IPy-Run)", "ipython run selection" },
	r = { "<Plug>SnipRun", "run selection" },
	s = { "<cmd>Telescope grep_string<cr>", "search selection" },
	d = {
		name = "debug",
		e = { "<cmd>DebugEvaluate<cr>", "evaluate selected expression" },
		s = { "<cmd>PythonDebugSelection<cr>", "py debug selection" },
		c = { "<cmd>lua require'dap'.step_into()<CR>","continue"},
-- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
	},
	g = {
		name = "format line",
		q = "format line length",
	},

}

wk.register(vmappings, {
	mode = "v",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
