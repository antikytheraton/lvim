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
	-- git blame
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
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
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("lsp_signature").on_attach({
	-- 			floating_window = false,
	-- 			hint_prefix = "🐼 ",
	-- 		})
	-- 	end,
	-- },
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
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("config.treesitter_context").setup()
		end,
	},
	-- mkdir
	{ "pbrisbin/vim-mkdir" },
	-- Wakatime
	{ "wakatime/vim-wakatime" },
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
	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},
	-- Noice CMD / Notifications / Signatures
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("config.noice").setup()
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
			require("config.colorizer").setup()
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
	-- SQL LSP
	{ "nanotee/sqls.nvim" },
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	-- NOTE:  WINDOWS
	--------------------------------------------------------------------
	-- {
	-- 	"anuvyklack/windows.nvim",
	-- 	dependencies = {
	-- 		"anuvyklack/middleclass",
	-- 		"anuvyklack/animation.nvim",
	-- 	},
	-- 	config = function()
	-- 		vim.o.winwidth = 10
	-- 		vim.o.winminwidth = 10
	-- 		vim.o.equalalways = false
	-- 		require("windows").setup()
	-- 	end,
	-- },
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
	{
		"diegoulloao/neofusion.nvim",
		config = function()
			lvim.builtin.lualine.options.theme = require("neofusion.lualine")
		end,
	},
	{ "ntk148v/komau.vim" },
	{
		"jesseleite/nvim-noirbuddy",
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
		lazy = false,
		-- priority = 1000,
		opts = {
			-- All of your `setup(opts)` will go here
		},
		config = function()
			require("noirbuddy").setup({
				preset = "minimal",
				styles = {
					italic = true,
					bold = false,
					underline = false,
					undercurl = true,
				},
			})
		end,
	},
}

------------------------------------------------------
-- Load custom configurations
------------------------------------------------------
require("config.big_file")
require("config.null_ls")
require("config.telescope")
require("config.lualine")
