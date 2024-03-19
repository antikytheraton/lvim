------------------------------------------------------
-- Plugins
------------------------------------------------------
lvim.plugins = {
	-- TMUX navigator
	{ "christoomey/vim-tmux-navigator" },
	{ "tmux-plugins/vim-tmux-focus-events" },
	-- Enhanced movement plugin
	{
		"ggandor/leap.nvim",
		event = "BufRead",
		-- config = function()
		-- 	require("leap").create_default_mappings()
		-- end,
		dependencies = {
			"tpope/vim-repeat",
		},
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
	-- File explorer
	-- {
	-- 	"luukvbaal/nnn.nvim",
	-- 	config = function()
	-- 		require("config.nnn").setup()
	-- 	end,
	-- },
	-- telescope extensions
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
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup()
		end,
	},
	-- image viewer
	{
		"samodostal/image.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "m00qek/baleia.nvim", version = "v1.3.0" },
		},
		config = function()
			require("image").setup({
				render = {
					min_padding = 5,
					show_label = true,
					show_image_dimensions = true,
					use_dither = true,
					foreground_color = true,
					background_color = true,
				},
				events = {
					update_on_nvim_resize = true,
				},
			})
		end,
	},
	-- Fidget
	{
		"j-hui/fidget.nvim",
		opts = {
			integration = {
				["nvim-tree"] = {
					enable = false, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
				},
			},
		},
	},
	-- python DAP config
	{ "mfussenegger/nvim-dap-python" },
	-- Draw ASCII diagrams in nvim
	{ "jbyuki/venn.nvim" },
	-- Rust DEV
	{ "rust-lang/rust.vim" },
	-- Jump to the line
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
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
	{ "NLKNguyen/papercolor-theme" },
	{ "ayu-theme/ayu-vim" },
	{ "cocopon/iceberg.vim" },
	{ "dikiaap/minimalist" },
	{ "rakr/vim-one" },
	{ "ntk148v/komau.vim" },
}

------------------------------------------------------
-- Load custom configurations
------------------------------------------------------
require("config.null_ls")
require("config.telescope")
require("config.dap")
require("config.venn")
require("config.big_file")
