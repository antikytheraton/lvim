------------------------------------------------------
-- Keymaps
------------------------------------------------------

lvim.builtin.terminal.shell = "/usr/bin/env fish"
lvim.builtin.terminal.open_mapping = [[<c-n>]]

lvim.builtin.nvimtree.active = false -- NOTE: using NNN
lvim.builtin.which_key.mappings["e"] = { "<cmd>NnnPicker %:p:h<CR>", "Explorer" }
lvim.builtin.which_key.mappings["|"] = { "<cmd>vsp<cr>", "Window vertical split" }
lvim.builtin.which_key.mappings["-"] = { "<cmd>sp<cr>", "Window horizontal split" }
lvim.builtin.which_key.mappings["k"] = { "<cmd>BufferKill<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["c"] = { "<cmd>Telescope neoclip star<CR>", "Clipboard manager" }
-- lvim.builtin.which_key.mappings["t"] = {
-- 	name = "Diagnostics",
-- 	t = { "<cmd>TroubleToggle<cr>", "trouble" },
-- 	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
-- 	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
-- 	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
-- 	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
-- 	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
-- }

lvim.builtin.which_key.mappings["t"] = {
	name = "Test",
	["r"] = { '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>', "Run tests" },
	["n"] = { '<cmd>lua require("neotest").run.run()<CR>', "Run nearest test" },
	["d"] = { '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>', "Debug nearest test" },
	["s"] = { '<cmd>lua require("neotest").run.stop()<CR>', "Stop test" },
	["t"] = { '<cmd>lua require("neotest").summary.toggle()<CR>', "Toggle summary" },
	["a"] = { '<cmd>lua require("neotest").run.attach()<CR>', "Test attach" },
	["o"] = { "<cmd>Neotest output<CR>", "Show test output" },
}
lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Telescope select files
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
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

-- Spider keymaps overides
vim.keymap.set({ "n", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
