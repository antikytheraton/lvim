------------------------------------------------------
-- Plugins
------------------------------------------------------
lvim.plugins = {
	-- TMUX navigator
	{ "christoomey/vim-tmux-navigator" },
	{ "tmux-plugins/vim-tmux-focus-events" },
	-- Enhanced movement plugin
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},
	-- Go development
	{
		"fatih/vim-go",
		build = ":GoUpdateBinaries",
	},
	-- Treesitter complements
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	},
	-- mkdir
	{ "pbrisbin/vim-mkdir" },
	-- Wakatime
	{ "wakatime/vim-wakatime" },
	-- -- LSP fidget
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	config = function()
	-- 		require("fidget").setup()
	-- 	end,
	-- },
	-- File explorer
	{
		"luukvbaal/nnn.nvim",
		config = function()
			require("config.nnn").setup()
		end,
	},
	-- autosession
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
			})
		end,
	},
	-- clipboard management
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "kkharji/sqlite.lua", module = "sqlite" },
		},
		config = function()
			require("neoclip").setup()
		end,
	},
	-- Diagnostics, references, telescope results, quick fix and location lists
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	-- GIT blame
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
	},
	-- Move like a spider
	{ "chrisgrieser/nvim-spider", lazy = true },
	-- Glow Markdown preview
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	-- Emoji on cmp
	{ "hrsh7th/cmp-emoji" },
	-- Minimap
	{
		"wfxr/minimap.vim",
		build = "cargo install --locked code-minimap",
		cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
		config = function()
			vim.cmd("let g:minimap_width = 10")
			vim.cmd("let g:minimap_auto_start = 1")
			vim.cmd("let g:minimap_auto_start_win_enter = 1")
		end,
	},
}

------------------------------------------------------
-- Load custom configurations
------------------------------------------------------
require("config.null_ls")
require("config.telescope")
