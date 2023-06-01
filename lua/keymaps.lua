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
lvim.builtin.which_key.mappings["c"] = { "<cmd>Telescope neoclip<CR>", "Clipboard manager" }

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
map("n", "[q", ":cprevious<CR>", opts)
map("n", "]q", ":cnext<CR>", opts)
map("n", "]Q", ":clast<CR>", opts)
map("n", "[Q", ":cfirst<CR>", opts)
-- Stay centered jumping between search results
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
-- Fix cursor position after joining lines
map("n", "J", "mzJ`z", opts)
