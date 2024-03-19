------------------------------------------------------
-- Keymaps
------------------------------------------------------

lvim.builtin.terminal.shell = "/usr/bin/env fish"
lvim.builtin.terminal.open_mapping = [[<c-n>]]

-- lvim.builtin.nvimtree.active = false -- NOTE: using NNN

local mappings = lvim.builtin.which_key.mappings
-- Navigation
-- mappings["e"] = { "<cmd>NnnPicker %:p:h<CR>", "Explorer" }
mappings["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }
mappings["|"] = { "<cmd>vsp<cr>", "Window vertical split" }
mappings["-"] = { "<cmd>sp<cr>", "Window horizontal split" }
mappings["m"] = { "<cmd>MinimapToggle<cr>", "Toggle minimap" }
-- Telescope
mappings["c"] = { "<cmd>Telescope neoclip star<CR>", "Clipboard manager" }
mappings["so"] = { "<cmd>Telescope oldfiles<CR>", "Old files" }
mappings["sw"] = { "<cmd>Telescope grep_string<CR>", "Word under cursor" }
mappings["sm"] = { "<cmd>Telescope marks<CR>", "Bookmarks" }
mappings["sT"] = { "<cmd>TodoTelescope<CR>", "TODO Telescope" }
mappings["sL"] = { "<cmd>Telescope treesitter<CR>", "Treesitter" }
mappings["sb"] = { "<cmd>Telescope buffers<cr>", "Find buffer" }

mappings["l"]["f"] = {
	function()
		require("lvim.lsp.utils").format({ timeout_ms = 2000 })
	end,
	"Format",
}
-- Test
mappings["t"] = {
	name = "Test",
	r = { '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>', "Run tests" },
	n = { '<cmd>lua require("neotest").run.run()<CR>', "Run nearest test" },
	d = { '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>', "Debug nearest test" },
	s = { '<cmd>lua require("neotest").run.stop()<CR>', "Stop test" },
	t = { '<cmd>lua require("neotest").summary.toggle()<CR>', "Toggle summary" },
	a = { '<cmd>lua require("neotest").run.attach()<CR>', "Test attach" },
	o = { "<cmd>Neotest output<CR>", "Show test output" },
}
-- Sessions
mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
-- Gitsigns
mappings["gS"] = { '<cmd>lua require"gitsigns".stage_buffer()<cr>', "Stage Buffer" }
-- Trouble
mappings["lt"] = {
	name = "Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}
-- Buffers
mappings["k"] = { "<cmd>BufferKill<CR>", "Close Buffer" }
-- mappings["bp"] = { "<cmd>BufferPin<cr>", "Pin/Unpin buffer" }
-- mappings["bk"] = { "<cmd>BufferCloseAllButPinned<cr>", "Close all but pinned buffer(s)" }
-- mappings["bL"] = { "<cmd>BufferMovePrevious<cr>", "Move buffer to the left" }
-- mappings["bR"] = { "<cmd>BufferMoveNext<cr>", "Move buffer to the right" }

mappings["x"] = {
	name = "Misc",
	["d"] = { "<cmd>%s/\\s\\+$//e<cr>", "Delete trailing spaces" },
	["j"] = { "<cmd>%!jq '.'<cr>", "Format JSON using JQ" },
	["p"] = { "<cmd>!reorder-python-imports %<cr>", "Reorder python imports" },
}

-- toggle keymappings for venn using <leader>v
mappings["v"] = {
	name = "Venn",
	["v"] = { "<cmd>Toggle_venn()<cr>", "Toggle VENN ASCII Diagrams" },
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Telescope select files
map("n", "<C-p>", "<cmd>Telescope git_files<cr>", opts)
-- clear any highlights when <esc> is pressed
map("n", "<Esc>", ":noh<CR>", opts)
-- move one up/down display line instead of physicial line
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
-- Search for visually selected text
map("v", "//", 'y/<C-R>"<cr>', opts)
-- Use tab for indenting in visual mode
map("x", "<Tab>", ">gv|", opts)
map("x", "<S-Tab>", "<gv", opts)
-- quickfix mappings
map("n", "]q", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
map("n", "[q", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
map("n", "]Q", ":clast<CR>", opts)
map("n", "[Q", ":cfirst<CR>", opts)
-- git mappings
map("n", "]c", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", opts)
map("n", "[c", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", opts)
-- Stay centered jumping between search results
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
-- Fix cursor position after joining lines
map("n", "J", "mzJ`z", opts)
-- Have the same buffer on clipboard for multiple pastes
map("v", "p", "pgvy", opts)
-- Make the dot command work as expected in visual mode
-- https://www.reddit.com/r/vim/comments/3y2mgt/
map("v", ".", ":norm .<cr>", opts)
-- DAP
map("n", "<F5>", "<cmd>require'dap'.continue<cr>", opts)
map("n", "<F6>", "<cmd>require'dap'.step_over<cr>", opts)
map("n", "<F7>", "<cmd>require'dap'.step_into<cr>", opts)
map("n", "<F8>", "<cmd>require'dap'.step_out<cr>", opts)
map("n", "mm", "<cmd>MinimapToggle<cr>", opts)
-- Fix some common typos
map("c", "Q", "q", opts)
map("c", "W", "w", opts)
-- format visual selection
vim.keymap.set("v", "f", vim.lsp.buf.format)
-- vim.keymap.set("v", "f", vim.lsp.buf.range_formatting())
-- Spider keymaps overrides
vim.keymap.set({ "n", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })

-- NOTE: Disabling custom Leap settings (defaults)
-- vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
-- vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
-- vim.keymap.set({'n', 'x', 'o'}, 't', '<Plug>(leap-forward-till)')
-- vim.keymap.set({'n', 'x', 'o'}, 'T', '<Plug>(leap-backward-till)')
vim.keymap.set({ "n", "x", "o" }, "s", function()
	local focusable_windows = vim.tbl_filter(function(win)
		return vim.api.nvim_win_get_config(win).focusable
	end, vim.api.nvim_tabpage_list_wins(0))

	require("leap").leap({
		-- target_windows = require("leap.util").get_enterable_windows(),
		target_windows = focusable_windows
	})
end)

-- LSP callback keymaps
local on_attach = function(client, bufrn)
	-- local function buf_set_option(...)
	-- 	vim.api.nvim_buf_set_option(bufrn, ...)
	-- end
	-- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufrn, ...)
	end

	buf_set_keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

-- require("lspconfig").ruff_lsp.setup({
-- 	on_attach = on_attach,
-- 	init_options = {
-- 		settings = {
-- 			args = {},
-- 		},
-- 	},
-- })

-- require("lspconfig").sqlls.setup({
-- 	on_attach = on_attach,
-- 	init_options = {
-- 		settings = {
-- 			args = {},
-- 		},
-- 	},
-- })

lvim.lsp.on_attach_callback = on_attach

require("lspconfig").yamlls.setup({
	settings = {
		yaml = {
			schemaStore = {
				url = "https://www.schemastore.org/api/json/catalog.json",
				enable = true,
			},
			schemas = {
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/*docker-compose*.y*ml",
				["https://json.schemastore.org/circleciconfig.json"] = "/*circle*.y*ml",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
				["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] = "k8s/**",
				["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
					"ci/*.yml",
					".gitlab-ci.yml",
				},
			},
		},
	},
})

require("lspconfig").rust_analyzer.setup({})
