------------------------------------------------------
-- Plugins
------------------------------------------------------
lvim.plugins = {
	-- TMUX navigator
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-|>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- Glow Markdown preview
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
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
	-- Draw ASCII diagrams in nvim
	{ "jbyuki/venn.nvim" },
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
	-- mkdir
	{ "pbrisbin/vim-mkdir" },
	-- Wakatime
	{ "wakatime/vim-wakatime" },
	-- Diagnostics, references, telescope results, quick fix and location lists
	-- { "folke/trouble.nvim",            branch = "main", opts = {} },
	-- Move like a spider
	{ "chrisgrieser/nvim-spider", lazy = true },
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
		"ryanmsnyder/toggleterm-manager.nvim",
		dependencies = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
		},
		config = function()
			require("config.term_manager").setup()
		end,
	},
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
	{
		"nvim-telescope/telescope-symbols.nvim",
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
	},
	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},
	-- NOTE:  WINDOWS
	--------------------------------------------------------------------
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},
	-- NOTE: THEMES
	--------------------------------------------------------------------
	-- { "lunarvim/colorschemes" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim", lazy = false, opts = {} },
	{ "EdenEast/nightfox.nvim" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "NTBBloodbath/doom-one.nvim" },
	{ "NLKNguyen/papercolor-theme" },
	{ "ayu-theme/ayu-vim" },
	{ "cocopon/iceberg.vim" },
	{ "neanias/everforest-nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "diegoulloao/neofusion.nvim" },
}

------------------------------------------------------
-- Load custom configurations
------------------------------------------------------
require("config.big_file")
require("config.null_ls")
require("config.telescope")
require("config.venn")
