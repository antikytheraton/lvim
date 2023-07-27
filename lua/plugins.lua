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
	-- spellsitter
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
	{
		"j-hui/fidget.nvim",
		version = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	-- File explorer
	{
		"luukvbaal/nnn.nvim",
		config = function()
			require("config.nnn").setup()
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
	-- -- Emoji on cmp
	-- { "hrsh7th/cmp-emoji" },
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
	-- Tests
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
		},
		config = function()
			require("config.neotest").setup()
		end,
	},
	-- Load dotenv file variables
	{ "tpope/vim-dotenv" },
	-- repeat supported maps with "."
	{ "tpope/vim-repeat" },
	-- HTML tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- LSP signature
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach({
				floating_window = false,
				hint_prefix = "🐼 ",
			})
		end,
	},
	-- TODO: comments
	-- NOTE: highlights comments on code
	-- BUG: error XD
	-- HACK: hack code
	-- PERF: to improve later
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- autosession
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.persistence").setup()
		end,
	},
	-- colorizer
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "css", "scss", "html", "javascript", "lua", "python" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	-- NOTE: THEMES
	--------------------------------------------------------------------
	{ "lunarvim/colorschemes" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
	{ "EdenEast/nightfox.nvim", priority = 1000 },
	{ "marko-cerovac/material.nvim", priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
	{ "NTBBloodbath/doom-one.nvim", priority = 1000 },
}

------------------------------------------------------
-- Load custom configurations
------------------------------------------------------
require("config.null_ls")
require("config.telescope")
